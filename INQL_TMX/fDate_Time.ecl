IMPORT std;

EXPORT fDate_Time := module;

//------------------------------------------------------------------------------------------------------------
//  fGetDateTimeString()
//
//  Returns current date/time as string14 formatted as YYYYMMDDhhmmss
//  Can use local(fGetDateTimeString()) if nothor usage to help force unique evaluation
//
//------------------------------------------------------------------------------------------------------------
EXPORT STRING14 fGetDateTimeString() :=	
    std.date.SecondsToString(std.date.CurrentSeconds(true), '%Y%m%d%H%M%S');


end;