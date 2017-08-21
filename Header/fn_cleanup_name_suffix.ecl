export fn_cleanup_name_suffix (string pIn) := function

 out_string1 := stringlib.stringfilterout(pin,'-(),.+=$*!;^@%{}_"\'/');
 pOut   := if(stringlib.stringfind(trim(out_string1,left,right),' ',1)>0
        ,out_string1[1..stringlib.stringfind(trim(out_string1,left,right),' ',1)-1] // picking the first suffix if there is space SR SR , JR SR etc..
        ,out_string1);
 
 return pOut;
 
end;