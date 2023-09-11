local log = require("log")
local Api = require("coreApi")
local json = require("json")
local http = require("http")
local mysql = require("mysql")

function ReceiveFriendMsg(CurrentQQ, data)
    log.info("%s", "\nFriendParseMsg")

    if data.MsgHead.FromType == 1 then --来源好友
        if data.MsgHead.MsgType == 166 then
        end
    end
   
    if data.MsgHead.FromType == 3 then --来源私聊
        if data.MsgHead.MsgType == 141 then
        end
    end
    return 1
end

function ReceiveGroupMsg(CurrentQQ, data)
    log.info("%s", "\nGroupMsgParseMsg")
    if data.MsgHead.MsgType == 82 then      
        if data.MsgBody.Content=="测试" then
            random_number = math.random(1, 11)
            keyWord = random_number
            if keyWord == "" then
                return 1
            end
            Api.Api_MagicCgiCmd(
                CurrentQQ,
                {
                    CgiCmd = "MessageSvc.PbSendMsg",
                    CgiRequest = {
                        ToUin = data.MsgHead.FromUin,
                        ToType = data.MsgHead.FromType,
                        Content = keyWord
                    }
                }
            )
        end
    end
    return 1
end

function ReceiveEvents(CurrentQQ, data)
    return 1
end