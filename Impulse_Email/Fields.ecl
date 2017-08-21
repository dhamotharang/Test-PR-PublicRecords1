import ut;
export Fields := MODULE
//Individual field level validation
export InValid_SOURCENAME(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0,stringlib.stringtouppercase(s)<>s,length(trim(s))<>length(trim(stringlib.stringfilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'))));
export InValidMessage_SOURCENAME(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','String contains lower case characters','Contains characters not in:ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./','GOOD');
export Make_SOURCENAME(string s0) := FUNCTION
s1 := stringlib.stringtouppercase(s0); // Force to upper case
s2 := stringlib.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'); // Only allow valid symbols
s3 := stringlib.stringcleanspaces( stringlib.stringsubstituteout(s2,' <>{}[]-^=!+&,./',' ') ); // Insert spaces but avoid doubles
s4 := if ( stringlib.stringfind('"\'',s3[1],1)>0 and stringlib.stringfind('"\'',s3[length(trim(s3))],1)>0,s3[2..length(trim(s3))-1],s3 );// Remove quotes if required
s5 := trim(s4,left); // Left trim
return s5;
end;
export InValid_EMAIL(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0,length(trim(s))<>length(trim(stringlib.stringfilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@.!#$%&\'*+-/=?^_`{|}~'))));
export InValidMessage_EMAIL(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','Contains characters not in:ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@.!#$%&\'*+-/=?^_`{|}~','GOOD');
export Make_EMAIL(string s0) := FUNCTION
s1 := stringlib.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@.!#$%&\'*+-/=?^_`{|}~'); // Only allow valid symbols
s2 := if ( stringlib.stringfind('"\'',s1[1],1)>0 and stringlib.stringfind('"\'',s1[length(trim(s1))],1)>0,s1[2..length(trim(s1))-1],s1 );// Remove quotes if required
s3 := trim(s2,left); // Left trim
return s3;
end;
export InValid_FirstName(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0,stringlib.stringtouppercase(s)<>s,length(trim(s))<>length(trim(stringlib.stringfilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
export InValidMessage_FirstName(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','String contains lower case characters','Contains characters not in:ABCDEFGHIJKLMNOPQRSTUVWXYZ','GOOD');
export Make_FirstName(string s0) := FUNCTION
s1 := stringlib.stringtouppercase(s0); // Force to upper case
s2 := stringlib.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
s3 := if ( stringlib.stringfind('"\'',s2[1],1)>0 and stringlib.stringfind('"\'',s2[length(trim(s2))],1)>0,s2[2..length(trim(s2))-1],s2 );// Remove quotes if required
s4 := trim(s3,left); // Left trim
return s4;
end;
export InValid_MiddleName(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0,stringlib.stringtouppercase(s)<>s,length(trim(s))<>length(trim(stringlib.stringfilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
export InValidMessage_MiddleName(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','String contains lower case characters','Contains characters not in:ABCDEFGHIJKLMNOPQRSTUVWXYZ','GOOD');
export Make_MiddleName(string s0) := FUNCTION
s1 := stringlib.stringtouppercase(s0); // Force to upper case
s2 := stringlib.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
s3 := if ( stringlib.stringfind('"\'',s2[1],1)>0 and stringlib.stringfind('"\'',s2[length(trim(s2))],1)>0,s2[2..length(trim(s2))-1],s2 );// Remove quotes if required
s4 := trim(s3,left); // Left trim
return s4;
end;
export InValid_lastName(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0,stringlib.stringtouppercase(s)<>s,length(trim(s))<>length(trim(stringlib.stringfilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
export InValidMessage_lastName(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','String contains lower case characters','Contains characters not in:ABCDEFGHIJKLMNOPQRSTUVWXYZ','GOOD');
export Make_lastName(string s0) := FUNCTION
s1 := stringlib.stringtouppercase(s0); // Force to upper case
s2 := stringlib.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
s3 := if ( stringlib.stringfind('"\'',s2[1],1)>0 and stringlib.stringfind('"\'',s2[length(trim(s2))],1)>0,s2[2..length(trim(s2))-1],s2 );// Remove quotes if required
s4 := trim(s3,left); // Left trim
return s4;
end;
export InValid_address1(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_address1(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_address1(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_address2(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_address2(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_address2(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_city(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_city(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_city(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_state(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_state(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_state(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_zip(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_zip(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_zip(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_HomePhone(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_HomePhone(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_HomePhone(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_WORKPHONE(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_WORKPHONE(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_WORKPHONE(string s0) := FUNCTION
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
export InValid_created(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_created(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_created(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_SITEID(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_SITEID(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_SITEID(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_SSN(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0,length(trim(s))<>length(trim(stringlib.stringfilter(s,'0123456789.'))));
export InValidMessage_SSN(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','Contains characters not in:0123456789.','GOOD');
export Make_SSN(string s0) := FUNCTION
s1 := stringlib.stringfilter(s0,'0123456789.'); // Only allow valid symbols
s2 := if ( stringlib.stringfind('"\'',s1[1],1)>0 and stringlib.stringfind('"\'',s1[length(trim(s1))],1)>0,s1[2..length(trim(s1))-1],s1 );// Remove quotes if required
s3 := trim(s2,left); // Left trim
return s3;
end;
export InValid_STATUS(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_STATUS(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_STATUS(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_CELLPHONE(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_CELLPHONE(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_CELLPHONE(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_JOB_EMPLOYER(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_JOB_EMPLOYER(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_JOB_EMPLOYER(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_EMPLOYERNAME(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_EMPLOYERNAME(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_EMPLOYERNAME(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_EMPLOYER(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_EMPLOYER(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_EMPLOYER(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_EMPLOYER_NAME(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_EMPLOYER_NAME(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_EMPLOYER_NAME(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_MONTHSALARY(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_MONTHSALARY(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_MONTHSALARY(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_NETSALARY(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_NETSALARY(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_NETSALARY(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_LICENSE_NUM(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_LICENSE_NUM(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_LICENSE_NUM(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_LICENSE_STATE(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_LICENSE_STATE(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_LICENSE_STATE(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_INCOME_MONTHLY_NET(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_INCOME_MONTHLY_NET(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_INCOME_MONTHLY_NET(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_JOB_EMPLOYER_PHONE(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_JOB_EMPLOYER_PHONE(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_JOB_EMPLOYER_PHONE(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_MILITARY(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_MILITARY(unsigned1 wh) := CHOOSE(wh,'Field not left justified','String is quoted using one of:"\'','GOOD');
export Make_MILITARY(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
//Find those highly occuring pivot values to remove them from consideration
#uniquename(tr)
  %tr% := table(in_left+in_right,{ val := pivot_exp; });
#uniquename(r1)
  %r1% := record
    %tr%.val;    unsigned Cnt := COUNT(GROUP);
  end;
#uniquename(t1)
  %t1% := table(%tr%,%r1%,val,local); // Pre-aggregate before distribute
#uniquename(r2)
  %r2% := record
    %t1%.val;    unsigned Cnt := SUM(GROUP,%t1%.Cnt);
  end;
#uniquename(t2)
  %t2% := table(%t1%,%r2%,val); // Now do global aggregate
Bad_Pivots := %t2%(Cnt>100);
#uniquename(dl)
  %dl% := RECORD
    BOOLEAN Diff_SOURCENAME;
    BOOLEAN Diff_EMAIL;
    BOOLEAN Diff_FirstName;
    BOOLEAN Diff_MiddleName;
    BOOLEAN Diff_lastName;
    BOOLEAN Diff_address1;
    BOOLEAN Diff_address2;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_HomePhone;
    BOOLEAN Diff_WORKPHONE;
    BOOLEAN Diff_DOB;
    BOOLEAN Diff_created;
    BOOLEAN Diff_SITEID;
    BOOLEAN Diff_SSN;
    BOOLEAN Diff_STATUS;
    BOOLEAN Diff_CELLPHONE;
    BOOLEAN Diff_JOB_EMPLOYER;
    BOOLEAN Diff_EMPLOYERNAME;
    BOOLEAN Diff_EMPLOYER;
    BOOLEAN Diff_EMPLOYER_NAME;
    BOOLEAN Diff_MONTHSALARY;
    BOOLEAN Diff_NETSALARY;
    BOOLEAN Diff_LICENSE_NUM;
    BOOLEAN Diff_LICENSE_STATE;
    BOOLEAN Diff_INCOME_MONTHLY_NET;
    BOOLEAN Diff_JOB_EMPLOYER_PHONE;
    BOOLEAN Diff_MILITARY;
    UNSIGNED Num_Diffs;
    STRING Val;
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := transform
    SELF.Diff_SOURCENAME := le.SOURCENAME <> ri.SOURCENAME;
    SELF.Diff_EMAIL := le.EMAIL <> ri.EMAIL;
    SELF.Diff_FirstName := le.FirstName <> ri.FirstName;
    SELF.Diff_MiddleName := le.MiddleName <> ri.MiddleName;
    SELF.Diff_lastName := le.lastName <> ri.lastName;
    SELF.Diff_address1 := le.address1 <> ri.address1;
    SELF.Diff_address2 := le.address2 <> ri.address2;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_HomePhone := le.HomePhone <> ri.HomePhone;
    SELF.Diff_WORKPHONE := le.WORKPHONE <> ri.WORKPHONE;
    SELF.Diff_DOB := le.DOB <> ri.DOB;
    SELF.Diff_created := le.created <> ri.created;
    SELF.Diff_SITEID := le.SITEID <> ri.SITEID;
    SELF.Diff_SSN := le.SSN <> ri.SSN;
    SELF.Diff_STATUS := le.STATUS <> ri.STATUS;
    SELF.Diff_CELLPHONE := le.CELLPHONE <> ri.CELLPHONE;
    SELF.Diff_JOB_EMPLOYER := le.JOB_EMPLOYER <> ri.JOB_EMPLOYER;
    SELF.Diff_EMPLOYERNAME := le.EMPLOYERNAME <> ri.EMPLOYERNAME;
    SELF.Diff_EMPLOYER := le.EMPLOYER <> ri.EMPLOYER;
    SELF.Diff_EMPLOYER_NAME := le.EMPLOYER_NAME <> ri.EMPLOYER_NAME;
    SELF.Diff_MONTHSALARY := le.MONTHSALARY <> ri.MONTHSALARY;
    SELF.Diff_NETSALARY := le.NETSALARY <> ri.NETSALARY;
    SELF.Diff_LICENSE_NUM := le.LICENSE_NUM <> ri.LICENSE_NUM;
    SELF.Diff_LICENSE_STATE := le.LICENSE_STATE <> ri.LICENSE_STATE;
    SELF.Diff_INCOME_MONTHLY_NET := le.INCOME_MONTHLY_NET <> ri.INCOME_MONTHLY_NET;
    SELF.Diff_JOB_EMPLOYER_PHONE := le.JOB_EMPLOYER_PHONE <> ri.JOB_EMPLOYER_PHONE;
    SELF.Diff_MILITARY := le.MILITARY <> ri.MILITARY;
    SELF.Val := (STRING)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_SOURCENAME,1,0)+ IF( SELF.Diff_EMAIL,1,0)+ IF( SELF.Diff_FirstName,1,0)+ IF( SELF.Diff_MiddleName,1,0)+ IF( SELF.Diff_lastName,1,0)+ IF( SELF.Diff_address1,1,0)+ IF( SELF.Diff_address2,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_HomePhone,1,0)+ IF( SELF.Diff_WORKPHONE,1,0)+ IF( SELF.Diff_DOB,1,0)+ IF( SELF.Diff_created,1,0)+ IF( SELF.Diff_SITEID,1,0)+ IF( SELF.Diff_SSN,1,0)+ IF( SELF.Diff_STATUS,1,0)+ IF( SELF.Diff_CELLPHONE,1,0)+ IF( SELF.Diff_JOB_EMPLOYER,1,0)+ IF( SELF.Diff_EMPLOYERNAME,1,0)+ IF( SELF.Diff_EMPLOYER,1,0)+ IF( SELF.Diff_EMPLOYER_NAME,1,0)+ IF( SELF.Diff_MONTHSALARY,1,0)+ IF( SELF.Diff_NETSALARY,1,0)+ IF( SELF.Diff_LICENSE_NUM,1,0)+ IF( SELF.Diff_LICENSE_STATE,1,0)+ IF( SELF.Diff_INCOME_MONTHLY_NET,1,0)+ IF( SELF.Diff_JOB_EMPLOYER_PHONE,1,0)+ IF( SELF.Diff_MILITARY,1,0);
  END;
// Now need to remove bad pivots from comparison
#uniquename(L)
  %L% := JOIN(in_left,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(R)
  %R% := JOIN(in_right,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(DiffL)
  %DiffL% := JOIN(%L%,%R%,evaluate(left,pivot_exp)=evaluate(right,pivot_exp),%fd%(left,right),hash);
#uniquename(Closest)
  %Closest% := DEDUP(SORT(%DiffL%,Val,Num_Diffs,local),Val,local); // Join will have distributed by pivot_exp
#uniquename(AggRec)
  %AggRec% := RECORD
    Count_Diff_SOURCENAME := COUNT(GROUP,%Closest%.Diff_SOURCENAME);
    Count_Diff_EMAIL := COUNT(GROUP,%Closest%.Diff_EMAIL);
    Count_Diff_FirstName := COUNT(GROUP,%Closest%.Diff_FirstName);
    Count_Diff_MiddleName := COUNT(GROUP,%Closest%.Diff_MiddleName);
    Count_Diff_lastName := COUNT(GROUP,%Closest%.Diff_lastName);
    Count_Diff_address1 := COUNT(GROUP,%Closest%.Diff_address1);
    Count_Diff_address2 := COUNT(GROUP,%Closest%.Diff_address2);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_HomePhone := COUNT(GROUP,%Closest%.Diff_HomePhone);
    Count_Diff_WORKPHONE := COUNT(GROUP,%Closest%.Diff_WORKPHONE);
    Count_Diff_DOB := COUNT(GROUP,%Closest%.Diff_DOB);
    Count_Diff_created := COUNT(GROUP,%Closest%.Diff_created);
    Count_Diff_SITEID := COUNT(GROUP,%Closest%.Diff_SITEID);
    Count_Diff_SSN := COUNT(GROUP,%Closest%.Diff_SSN);
    Count_Diff_STATUS := COUNT(GROUP,%Closest%.Diff_STATUS);
    Count_Diff_CELLPHONE := COUNT(GROUP,%Closest%.Diff_CELLPHONE);
    Count_Diff_JOB_EMPLOYER := COUNT(GROUP,%Closest%.Diff_JOB_EMPLOYER);
    Count_Diff_EMPLOYERNAME := COUNT(GROUP,%Closest%.Diff_EMPLOYERNAME);
    Count_Diff_EMPLOYER := COUNT(GROUP,%Closest%.Diff_EMPLOYER);
    Count_Diff_EMPLOYER_NAME := COUNT(GROUP,%Closest%.Diff_EMPLOYER_NAME);
    Count_Diff_MONTHSALARY := COUNT(GROUP,%Closest%.Diff_MONTHSALARY);
    Count_Diff_NETSALARY := COUNT(GROUP,%Closest%.Diff_NETSALARY);
    Count_Diff_LICENSE_NUM := COUNT(GROUP,%Closest%.Diff_LICENSE_NUM);
    Count_Diff_LICENSE_STATE := COUNT(GROUP,%Closest%.Diff_LICENSE_STATE);
    Count_Diff_INCOME_MONTHLY_NET := COUNT(GROUP,%Closest%.Diff_INCOME_MONTHLY_NET);
    Count_Diff_JOB_EMPLOYER_PHONE := COUNT(GROUP,%Closest%.Diff_JOB_EMPLOYER_PHONE);
    Count_Diff_MILITARY := COUNT(GROUP,%Closest%.Diff_MILITARY);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
end;
