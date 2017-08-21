import std,ut;

EXPORT KeyStart (boolean skipEmail = false):= function

return BuildLogger.CustomTag('Key_Start',skipEmail);
end;