#!/usr/bin/env ruby
require 'taglib'
require 'yaml'
require 'configliere'; Settings.use :commandline

Settings.define :mode,       :default => :dump, :type => Symbol,   :description => "Mode: [dump] MP3 info, [fix] info"
Settings.define :fix_lyrics, :default => false, :type => :boolean, :description => "If true, will convert \\r to \\n in lyrics section"
Settings.define :dry_run,    :default => false, :type => :boolean, :description => "Don't take any action if --dry_run=true"
Settings.resolve!

frame_factory = TagLib::ID3v2::FrameFactory.instance
frame_factory.default_text_encoding = TagLib::String::UTF8

class Mp3File
  attr_reader :mp3_filename, :file, :tag, :lyrics
  def initialize(mp3_filename)
    @mp3_filename = mp3_filename
    @file         = TagLib::MPEG::File.new(mp3_filename)
    @tag          = file.id3v2_tag                      # or (tagger_warn("no id3v2 tag found"); return)
    @lyrics       = tag && tag.frame_list('USLT').first # or (tagger_warn("no lyrics found");    return)
  end

  def tagger_warn(str)
    warn("%-142s\t%s" % [mp3_filename, str])
  end

  def genre()  tag.genre  ; end
  def artist() tag.artist ; end
  def track()  tag.track  ; end
  def title()  tag.title  ; end
  def album()  tag.album  ; end
  def year()   tag.year.to_i == 0 ? nil : tag.year  ; end

  def dump_header
    puts "### %-47s\t%3d/%3d\t%-s" % [tag.artist, tag.track, tag.track, tag.title]
  end

  def indent_text(text, depth=2)
    ind = " "*depth
    [ind, text.gsub(/[\r\n]+/, "\n#{ind}"), "\n"].join
  end

  def dump_lyrics
    return unless lyrics
    puts indent_text(lyrics_text, 4)
  end

  def lyrics_text
    return unless lyrics
    text = lyrics.text.to_s
    text.gsub!(/\r\n?/m, "\n")
    text.gsub!(/^ *\[ Get Lyrical.*$/, '')
    text.gsub!(/Encoded By ATC/, '')
    text.gsub!(/\s+\z/m, '')
    text
  end

  def check_lyrics!
    return unless lyrics
    if    Settings.fix_lyrics
      tagger_warn "FIXING newlines and other nuisances"
      lyrics.text = lyrics_text
    elsif (lyrics.text =~ /\r/)
      tagger_warn "flattened lyrics"
    end
  end

  def frame_hash
    fh = {}
    tag.frame_list.each do |frame|
      next if %w[USLT TALB TIT2 TPE1].include?(frame.frame_id)
      fh[frame.frame_id] = frame.to_string
    end
    fh
  end

  def to_hash
    {
      :artist => artist,
      :album  => album,
      :year   => year,
      :track  => track,
      :title  => title,
      :genre  => genre,
      :lyrics => lyrics_text,
      :frames => frame_hash
    }
  end

  def dump
    puts "\n"
    dump_header
    puts "\n"
    dump_lyrics
  end

  def fix!
    check_lyrics! if Settings.fix_lyrics
    file.save     unless Settings.dry_run
  end
end


Dir['**/*.mp3'].each do |mp3_filename|
  mp3 = Mp3File.new(mp3_filename)
  case Settings.mode
  when :dump then  mp3.dump
  when :yaml then
    puts YAML.dump(mp3.to_hash)
  when :haz_lyrics then puts mp3_filename if mp3.lyrics_text
  when :fix  then  mp3.fix!
  else raise "Don't understand mode #{Settings.mode} with #{Settings.inspect} -- try --mode=dump or --mode=fix"
  end
end
