/**
 * Returns printable characters There are 95 printable ASCII characters, numbered 32 to 126.
 * space is 32
 * ~ is 126
 **/
IMPORT STD; 

NonPrintable := '\000\001\002\003\004\005\006\007\010\011\012\013\014\015\016\017\020\021\022\023\024\025\026\027\030\031\032\033\034\035\036\037'; 

EXPORT fn_KeepPrintableChars(string s) := STD.Str.FilterOut(s, NonPrintable); 
