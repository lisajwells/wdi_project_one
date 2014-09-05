require 'json'
require 'securerandom'

class Model
  def self.create(entity)
    entities = self.all()

    entity["id"] = SecureRandom.hex
    entities.push(entity)

    File.write(self.file_name(), entities.to_json)
  end

  def self.find_by(key, value)
    self.all().find do |entity|
      entity[key] == value
    end
  end

  def self.select_by(key, value)
    self.all().select do |entity|
      entity[key] == value
    end
  end

  def self.all()
    array_of_hashes = JSON.parse(File.read(self.file_name()))
    instances = []

    array_of_hashes.each do |entity|
      instances << self.new(entity)
    end

    return instances
  end

  def self.file_name()
    self.name().downcase + "s.txt"
  end

  # Instance methods

  def initialize(attributes)
    @attributes = attributes
  end

  def to_json(_)
    @attributes.to_json
  end

  def [](key)
    return @attributes[key]
  end
end