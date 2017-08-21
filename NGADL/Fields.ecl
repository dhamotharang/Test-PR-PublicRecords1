import ut;
export Fields := MODULE
//Individual field level validation
export InValid_SSN(string s) := WHICH(stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0,length(trim(s))<>length(trim(stringlib.stringfilter(s,'0123456789'))));
export InValidMessage_SSN(unsigned1 wh) := CHOOSE(wh,'String is quoted using one of:"\'','Contains characters not in:0123456789','GOOD');
export Make_SSN(string s0) := FUNCTION
s1 := stringlib.stringfilter(s0,'0123456789'); // Only allow valid symbols
s2 := if ( stringlib.stringfind('"\'',s1[1],1)>0 and stringlib.stringfind('"\'',s1[length(trim(s1))],1)>0,s1[2..length(trim(s1))-1],s1 );// Remove quotes if required
return s2;
end;
export InValid_VENDOR_ID(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_VENDOR_ID(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_VENDOR_ID(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_LNAME(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_LNAME(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_LNAME(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_PRIM_NAME(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_PRIM_NAME(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_PRIM_NAME(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_DOB(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_DOB(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_DOB(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_PRIM_RANGE(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_PRIM_RANGE(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_PRIM_RANGE(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_SEC_RANGE(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_SEC_RANGE(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_SEC_RANGE(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_FNAME(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_FNAME(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_FNAME(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_CITY_NAME(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_CITY_NAME(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_CITY_NAME(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_MNAME(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_MNAME(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_MNAME(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_NAME_SUFFIX(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_NAME_SUFFIX(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_NAME_SUFFIX(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_ST(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_ST(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_ST(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_GENDER(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_GENDER(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_GENDER(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_SRC(string s) := WHICH();
export InValidMessage_SRC(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_SRC(string s0) := FUNCTION
return s0;
end;
end;
