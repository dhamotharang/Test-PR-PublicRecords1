export Clean_Goofy(string indata) := function

 valid_chars := '!"#$%&`()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_\'abcdefghijklmnopqrstuvwxyz{|}~';
 outdata:= Stringlib.StringFilter(indata, valid_chars); 
return outdata;
end;


