import std,IDA;

EXPORT _BWR_Spray(boolean pUseProd=false) := FUNCTION

return IDA.fSpray(pUseProd)._spray;

end;


