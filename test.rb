#!/usr/bin/ruby
require 'date'
require 'time'
logstring = "[2020-10-13 16:59:26,144][org.logicalcobwebs.proxool.ConnectionPool.putConnection(ConnectionPool.java:374)][Thread-45]002177 (00/06/00) - Connection #1 returned (now AVAILABLE)
fadfas
dfsafd"
# logstring = "a bcab cabc"

timeString = ""
className = ""
thradName = ""
messageString = ""
funcName= ""
lineNum=0
stringArray = logstring.split(']', 4)
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

timeString = "2020-10-13 16:59:26,123"
puts Time.parse(timeString, "%Y-%m-%d %H:%M:%S,%3N").strftime("%d %b %Y %H:%M:%S.%3N")

#.strftime("%d %b %Y %H:%M:%S.%3N")

# puts logstring


# bin/logstash -e 'input { stdin{} } filter { log4j { message => "[2020-10-13 16:59:26,144][org.logicalcobwebs.proxool.ConnectionPool.putConnection(ConnectionPool.java:374)][Thread-45]002177 (00/06/00) - Connection #1 returned (now AVAILABLE)"} } output {stdout { codec => rubydebug }}'
