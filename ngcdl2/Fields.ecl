import ut;
export Fields := MODULE
//Individual field level validation
export InValid_LNAME(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_LNAME(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_LNAME(string s0) := FUNCTION
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
export InValid_TITLE(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_TITLE(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_TITLE(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_P_CITY_NAME(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_P_CITY_NAME(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_P_CITY_NAME(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_STATE(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_STATE(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_STATE(string s0) := FUNCTION
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
export InValid_PRIM_NAME(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_PRIM_NAME(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_PRIM_NAME(string s0) := FUNCTION
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
export InValid_STATE_ORIGIN(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_STATE_ORIGIN(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_STATE_ORIGIN(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_DID(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_DID(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_DID(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_OFFENDER_KEY(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_OFFENDER_KEY(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_OFFENDER_KEY(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_ORIG_SSN(string s) := WHICH(stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0,length(trim(s))<>length(trim(stringlib.stringfilter(s,'0123456789'))));
export InValidMessage_ORIG_SSN(unsigned1 wh) := CHOOSE(wh,'String is quoted using one of:"\'','Contains characters not in:0123456789','GOOD');
export Make_ORIG_SSN(string s0) := FUNCTION
s1 := stringlib.stringfilter(s0,'0123456789'); // Only allow valid symbols
s2 := if ( stringlib.stringfind('"\'',s1[1],1)>0 and stringlib.stringfind('"\'',s1[length(trim(s1))],1)>0,s1[2..length(trim(s1))-1],s1 );// Remove quotes if required
return s2;
end;
export InValid_DOB(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_DOB(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_DOB(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_INS_NUM(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_INS_NUM(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_INS_NUM(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_CASE_NUMBER(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_CASE_NUMBER(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_CASE_NUMBER(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_DLE_NUM(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_DLE_NUM(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_DLE_NUM(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_FBI_NUM(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_FBI_NUM(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_FBI_NUM(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_DOC_NUM(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_DOC_NUM(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_DOC_NUM(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_ID_NUM(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_ID_NUM(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_ID_NUM(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_SOR_NUMBER(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_SOR_NUMBER(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_SOR_NUMBER(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_NCIC_NUMBER(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_NCIC_NUMBER(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_NCIC_NUMBER(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_VEH_TAG(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_VEH_TAG(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_VEH_TAG(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_DL_NUM(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_DL_NUM(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_DL_NUM(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_VENDOR(string s) := WHICH();
export InValidMessage_VENDOR(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_VENDOR(string s0) := FUNCTION
return s0;
end;
export InValid_VEH_STATE(string s) := WHICH();
export InValidMessage_VEH_STATE(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_VEH_STATE(string s0) := FUNCTION
return s0;
end;
export InValid_DL_STATE(string s) := WHICH();
export InValidMessage_DL_STATE(unsigned1 wh) := CHOOSE(wh,'GOOD');
export Make_DL_STATE(string s0) := FUNCTION
return s0;
end;
end;
