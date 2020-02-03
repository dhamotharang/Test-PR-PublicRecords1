IMPORT std;
EXPORT Fn_STD_Str_FilterOut_ValidChars(STRING Field) := STD.Str.FilterOut(Field, '\t \n \r \'!"#$%&()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[]^_`{|}~\\');
// \t	tab
// \n	new line
// \r	carriage return
