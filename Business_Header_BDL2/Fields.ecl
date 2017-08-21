
import ut;
export Fields := MODULE

//Individual field level validation

export InValid_GROUP_ID(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0,length(trim(s))<>length(trim(stringlib.stringfilter(s,'0123456789'))));
export InValidMessage_GROUP_ID(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','Contains characters not in:0123456789','GOOD');
export Make_GROUP_ID(string s0) := FUNCTION
s1 := stringlib.stringfilter(s0,'0123456789'); // Only allow valid symbols
s2 := if ( stringlib.stringfind('"\'',s1[1],1)>0 and stringlib.stringfind('"\'',s1[length(trim(s1))],1)>0,s1[2..length(trim(s1))-1],s1 );// Remove quotes if required
s3 := trim(s2,left); // Left trim
return s3;
end;

export InValid_COMPANY_NAME(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0,stringlib.stringtouppercase(s)<>s,length(trim(s))<>length(trim(stringlib.stringfilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'))));
export InValidMessage_COMPANY_NAME(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','String contains lower case characters','Contains characters not in:ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./','GOOD');
export Make_COMPANY_NAME(string s0) := FUNCTION
s1 := stringlib.stringtouppercase(s0); // Force to upper case
s2 := stringlib.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'); // Only allow valid symbols
s3 := stringlib.stringcleanspaces( stringlib.stringsubstituteout(s2,' <>{}[]-^=!+&,./',' ') ); // Insert spaces but avoid doubles
s4 := if ( stringlib.stringfind('"\'',s3[1],1)>0 and stringlib.stringfind('"\'',s3[length(trim(s3))],1)>0,s3[2..length(trim(s3))-1],s3 );// Remove quotes if required
s5 := trim(s4,left); // Left trim
return s5;
end;

end;