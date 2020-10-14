# encoding: utf-8
require 'spec_helper'
require "logstash/filters/log4j"

describe LogStash::Filters::Log4j do
  describe "Parse Log4j logs" do
    let(:config) do <<-CONFIG
      filter {
        log4j {
          source => "raw"
          target => "data"
          }
      }
    CONFIG
    end

    sample("raw" => "[2020-10-13 16:59:26,144][org.logicalcobwebs.proxool.ConnectionPool.putConnection(ConnectionPool.java:374)][Thread-45]002177 (00/06/00) - Connection #1 returned (now AVAILABLE)") do
      expect(subject.get("message")).to eq('002177 (00/06/00) - Connection #1 returned (now AVAILABLE)')
    end
  end
end
