#!/usr/bin/env ruby

require 'restclient'
require 'wuclan/twitter'
require 'wuclan/twitter/request'
require 'wuclan/twitter/api_client' ; include Wuclan::Twitter::Request

frids = TwitterFriendsIdsRequest.new(1554031)
frids.fetch

friend_metrics = {}
frids.ids.each do |frid|
  next if friend_metrics[frid]
  raw_json = RestClient.get("http://api.infochimps.com/soc/net/tw/influence.json?user_id=#{frid}&requested_at=1289897022&apikey=flip69") rescue '{}'
  metrics = JSON.load(raw_json)
  friend_metrics[frid] = metrics
  puts "Fetched #{friend_metrics.length}" if (friend_metrics.length % 20) == 0
end

