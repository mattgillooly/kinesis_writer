#!/usr/bin/env ruby

require 'dotenv'
Dotenv.load

require 'aws'

c = AWS::Kinesis::Client.new(
  access_key_id: ENV['AWS_ACCESS_KEY_ID'],
  secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
)

stream_description = c.describe_stream(stream_name: ENV['KINESIS_STREAM_NAME'])[:stream_description]

shard = stream_description[:shards].first

shard_iterator = c.get_shard_iterator(
  stream_name: stream_description[:stream_name],
  shard_id: shard[:shard_id],
  shard_iterator_type: 'AT_SEQUENCE_NUMBER',
  starting_sequence_number: shard[:sequence_number_range][:starting_sequence_number],
)[:shard_iterator]

result = c.get_records(shard_iterator: shard_iterator)

loop do
  puts result[:records] unless result[:records].empty?
  sleep 2
  result = c.get_records(shard_iterator: result[:next_shard_iterator])
end
