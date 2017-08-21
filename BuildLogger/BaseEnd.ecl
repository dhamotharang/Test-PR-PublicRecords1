import std,ut;

EXPORT BaseEnd (boolean skipEmail = false) := function

return BuildLogger.CustomTag('Base_End',skipEmail);
end;