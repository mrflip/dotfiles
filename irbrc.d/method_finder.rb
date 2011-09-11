class Object
  # list methods which aren't in superclass
  def local_methods(*klasses)
    klasses = [self.class.superclass] if klasses.empty?
    hide_methods = klasses.inject([]){|am, km|  (am | km.instance_methods) }
    (self.methods - hide_methods).sort
  end
end
