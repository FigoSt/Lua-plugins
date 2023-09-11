local log = require("log")
local Api = require("coreApi")
local json = require("json")
local http = require("http")
local mysql = require("mysql")
--收到好友或私聊消息 触发的回调函数
function ReceiveFriendMsg(CurrentQQ, data)
    log.info("%s", "FriendParseMsg")
    if data.MsgHead.FromType == 1 then --来源好友        
        if data.MsgHead.MsgType == 166 then
        log.info("%s消息内容",data.MsgBody.Content)
        end
    end   
    if data.MsgHead.FromType == 3 then --来源私聊
        if data.MsgHead.MsgType == 141 then
        end
    end
    return 1
end

--收到群消息 触发的回调函数
function ReceiveGroupMsg(CurrentQQ, data)
    log.info("%s", "GroupMsgParseMsg")
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
    end
    return 1
end

--收到事件 触发的回调函数 
function ReceiveEvents(CurrentQQ, data)
    return 1
end
