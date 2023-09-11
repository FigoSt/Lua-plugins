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
        local str =
            string.format(
            "收到群消息\n群号:%d\n群名:%s\n消息内容:%s\n触发对象昵称:%s\n触发消息对象:%d",
            data.MsgHead.FromUin, --FromUin
            data.MsgHead.GroupInfo.GroupName,
            data.MsgBody.Content,
            data.MsgHead.SenderNick,
            data.MsgHead.SenderUin
        )
        log.notice("From log.Lua Log\n%s", str)

        if string.find(data.MsgBody.Content, "复读机") then
            local keyWord = data.MsgBody.Content:gsub("复读机", "")
            keyWord = keyWord:gsub(" ", "")
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

    --log.info("%d", data.MsgBody.Images[1].FileId)
    end
    return 1
end

function ReceiveEvents(CurrentQQ, data)
    return 1
end