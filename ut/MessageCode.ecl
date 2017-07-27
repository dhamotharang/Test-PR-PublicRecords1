Import ut;
export MessageCode(integer code, string msg = '') := FUNCTION
     return DATASET([{code, IF(msg <> '',msg,ut.MapMessageCodes(code))}], ut.layout_message);
END;