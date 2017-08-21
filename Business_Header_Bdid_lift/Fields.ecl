import ut;
export Fields := MODULE
//Individual field level validation
export InValid_fein(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0,length(trim(s))<>length(trim(stringlib.stringfilter(s,'0123456789'))));
export InValidMessage_fein(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','Contains characters not in:0123456789','GOOD');
export Make_fein(string s0) := FUNCTION
s1 := stringlib.stringfilter(s0,'0123456789'); // Only allow valid symbols
s2 := if ( stringlib.stringfind('"\'',s1[1],1)>0 and stringlib.stringfind('"\'',s1[length(trim(s1))],1)>0,s1[2..length(trim(s1))-1],s1 );// Remove quotes if required
s3 := trim(s2,left); // Left trim
return s3;
end;
export InValid_phone(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0,length(trim(s))<>length(trim(stringlib.stringfilter(s,'0123456789'))));
export InValidMessage_phone(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','Contains characters not in:0123456789','GOOD');
export Make_phone(string s0) := FUNCTION
s1 := stringlib.stringfilter(s0,'0123456789'); // Only allow valid symbols
s2 := if ( stringlib.stringfind('"\'',s1[1],1)>0 and stringlib.stringfind('"\'',s1[length(trim(s1))],1)>0,s1[2..length(trim(s1))-1],s1 );// Remove quotes if required
s3 := trim(s2,left); // Left trim
return s3;
end;
export InValid_vendor_id(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_vendor_id(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_vendor_id(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_company_name(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0,stringlib.stringtouppercase(s)<>s,length(trim(s))<>length(trim(stringlib.stringfilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'))));
export InValidMessage_company_name(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','String contains lower case characters','Contains characters not in:ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./','GOOD');
export Make_company_name(string s0) := FUNCTION
s1 := stringlib.stringtouppercase(s0); // Force to upper case
s2 := stringlib.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'); // Only allow valid symbols
s3 := stringlib.stringcleanspaces( stringlib.stringsubstituteout(s2,' <>{}[]-^=!+&,./',' ') ); // Insert spaces but avoid doubles
s4 := if ( stringlib.stringfind('"\'',s3[1],1)>0 and stringlib.stringfind('"\'',s3[length(trim(s3))],1)>0,s3[2..length(trim(s3))-1],s3 );// Remove quotes if required
s5 := trim(s4,left); // Left trim
return s5;
end;
export InValid_prim_range(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_prim_range(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_prim_range(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_zip(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0,length(trim(s))<>length(trim(stringlib.stringfilter(s,'0123456789'))));
export InValidMessage_zip(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','Contains characters not in:0123456789','GOOD');
export Make_zip(string s0) := FUNCTION
s1 := stringlib.stringfilter(s0,'0123456789'); // Only allow valid symbols
s2 := if ( stringlib.stringfind('"\'',s1[1],1)>0 and stringlib.stringfind('"\'',s1[length(trim(s1))],1)>0,s1[2..length(trim(s1))-1],s1 );// Remove quotes if required
s3 := trim(s2,left); // Left trim
return s3;
end;
export InValid_sec_range(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_sec_range(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_sec_range(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_zip4(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0,length(trim(s))<>length(trim(stringlib.stringfilter(s,'0123456789'))));
export InValidMessage_zip4(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','Contains characters not in:0123456789','GOOD');
export Make_zip4(string s0) := FUNCTION
s1 := stringlib.stringfilter(s0,'0123456789'); // Only allow valid symbols
s2 := if ( stringlib.stringfind('"\'',s1[1],1)>0 and stringlib.stringfind('"\'',s1[length(trim(s1))],1)>0,s1[2..length(trim(s1))-1],s1 );// Remove quotes if required
s3 := trim(s2,left); // Left trim
return s3;
end;
export InValid_CITY(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0,stringlib.stringtouppercase(s)<>s,length(trim(s))<>length(trim(stringlib.stringfilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'))),~(length(trim(s)) = 0 or length(trim(s)) >= 4));
export InValidMessage_CITY(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','String contains lower case characters','Contains characters not in:ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./','Length was not it:0,4..','GOOD');
export Make_CITY(string s0) := FUNCTION
s1 := stringlib.stringtouppercase(s0); // Force to upper case
s2 := stringlib.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'); // Only allow valid symbols
s3 := stringlib.stringcleanspaces( stringlib.stringsubstituteout(s2,' <>{}[]-^=!+&,./',' ') ); // Insert spaces but avoid doubles
s4 := if ( stringlib.stringfind('"\'',s3[1],1)>0 and stringlib.stringfind('"\'',s3[length(trim(s3))],1)>0,s3[2..length(trim(s3))-1],s3 );// Remove quotes if required
s5 := trim(s4,left); // Left trim
return s5;
end;
export InValid_unit_desig(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_unit_desig(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_unit_desig(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_county(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_county(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_county(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_prim_name(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_prim_name(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_prim_name(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_state(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0,stringlib.stringtouppercase(s)<>s,length(trim(s))<>length(trim(stringlib.stringfilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
export InValidMessage_state(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','String contains lower case characters','Contains characters not in:ABCDEFGHIJKLMNOPQRSTUVWXYZ','GOOD');
export Make_state(string s0) := FUNCTION
s1 := stringlib.stringtouppercase(s0); // Force to upper case
s2 := stringlib.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
s3 := if ( stringlib.stringfind('"\'',s2[1],1)>0 and stringlib.stringfind('"\'',s2[length(trim(s2))],1)>0,s2[2..length(trim(s2))-1],s2 );// Remove quotes if required
s4 := trim(s3,left); // Left trim
return s4;
end;
export InValid_msa(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0,length(trim(s))<>length(trim(stringlib.stringfilter(s,'0123456789'))));
export InValidMessage_msa(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','Contains characters not in:0123456789','GOOD');
export Make_msa(string s0) := FUNCTION
s1 := stringlib.stringfilter(s0,'0123456789'); // Only allow valid symbols
s2 := if ( stringlib.stringfind('"\'',s1[1],1)>0 and stringlib.stringfind('"\'',s1[length(trim(s1))],1)>0,s1[2..length(trim(s1))-1],s1 );// Remove quotes if required
s3 := trim(s2,left); // Left trim
return s3;
end;
export InValid_SOURCE(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_SOURCE(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_SOURCE(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_addr_suffix(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0,stringlib.stringtouppercase(s)<>s,length(trim(s))<>length(trim(stringlib.stringfilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
export InValidMessage_addr_suffix(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','String contains lower case characters','Contains characters not in:ABCDEFGHIJKLMNOPQRSTUVWXYZ','GOOD');
export Make_addr_suffix(string s0) := FUNCTION
s1 := stringlib.stringtouppercase(s0); // Force to upper case
s2 := stringlib.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
s3 := if ( stringlib.stringfind('"\'',s2[1],1)>0 and stringlib.stringfind('"\'',s2[length(trim(s2))],1)>0,s2[2..length(trim(s2))-1],s2 );// Remove quotes if required
s4 := trim(s3,left); // Left trim
return s4;
end;
end;
