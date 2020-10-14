# encoding: utf-8
require "logstash/filters/base"
require "logstash/namespace"
require 'time'

# This example filter will replace the contents of the default
# message field with whatever you specify in the configuration.
#
# It is only intended to be used as an example.
class LogStash::Filters::Log4j < LogStash::Filters::Base

  # Setting the config_name here is required. This is how you
  # configure this filter from your Logstash config.
  #
  # filter {
  #   example {
  #     message => "My message..."
  #   }
  # }
  #
  config_name "log4j"

  # Replace the message with this value.
  config :message, :validate => :string, :default => "Hello World!"


  public
  def register
    # Add instance variables
  end # def register

  public
  def filter(event)

    if @message
      timeString = ""
      className = ""
      thradName = ""
      messageString = ""
      funcName= ""
      lineNum=0
      stringArray = @message.split(']', 4)
      arraySize = stringArray.size
      if arraySize >= 1
          timeString = stringArray[0]
          length = timeString.length
          if timeString[0] == '['
              timeString = timeString[1,length]
          end
      end

      if arraySize >= 2
          className = stringArray[1]
          length = className.length
          if className[0] == '['
              className = className[1,length]
          end

          funcArray = className.split('(', 2)
          if funcArray.size == 2
              
              length = funcArray[0].length
              lastDot = funcArray[0].rindex('.')
              if lastDot != nil
                  className = funcArray[0][0,lastDot]
                  className = "#{className}.java"
                  funcName = funcArray[0][lastDot+1,length]
              end

              lineArray = funcArray[1].split(':', 2)

              if lineArray.size == 2
                  lineNum = lineArray[1].to_i()
              end

          end
          


      end

      if arraySize >= 3
          thradName = stringArray[2]
          length = thradName.length
          if thradName[0] == '['
              thradName = thradName[1,length]
          end
      end

      if arraySize >= 4
          messageString = stringArray[3]
          length = thradName.length
          if messageString[0] == '['
              messageString = messageString[1,length]
          end
      end

      # puts timeString
      # puts className
      # puts funcName
      # puts lineNum
      # puts thradName
      # puts messageString
      event.set("timestamp", Time.parse(timeString, "%Y-%m-%d %H:%M:%S,%3N"))
      event.set("className", className)
      event.set("funcName", funcName)
      event.set("lineNum", lineNum)
      event.set("thradName", thradName)
      event.set("message", messageString)
      # correct debugging log statement for reference
      # using the event.get API
      @logger.debug? && @logger.debug("Message is now: #{event.get("message")}")
    end

    # filter_matched should go in the last line of our successful code
    filter_matched(event)
  end # def filter
end # class LogStash::Filters::Example
