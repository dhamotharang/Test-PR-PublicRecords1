export outputMessage(integer code, string msg = '') := output(MessageCode(code, msg), NAMED('MessageCodes'), extend);
