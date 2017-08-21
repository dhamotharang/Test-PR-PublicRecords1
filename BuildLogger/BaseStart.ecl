import std,ut;

EXPORT BaseStart (boolean skipEmail = false) := function

return BuildLogger.CustomTag('Base_Start',skipEmail);
end;