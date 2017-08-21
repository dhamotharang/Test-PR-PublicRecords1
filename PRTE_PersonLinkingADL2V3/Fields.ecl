import ut,SALT20;
export Fields := MODULE
//Individual field level validation
export InValid_NAME_SUFFIX(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_NAME_SUFFIX(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.NotLeft,SALT20.HygieneErrors.Inquotes('"\''),SALT20.HygieneErrors.Good);
export Make_NAME_SUFFIX(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_FNAME(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_FNAME(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.NotLeft,SALT20.HygieneErrors.Inquotes('"\''),SALT20.HygieneErrors.Good);
export Make_FNAME(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_MNAME(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_MNAME(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.NotLeft,SALT20.HygieneErrors.Inquotes('"\''),SALT20.HygieneErrors.Good);
export Make_MNAME(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_LNAME(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_LNAME(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.NotLeft,SALT20.HygieneErrors.Inquotes('"\''),SALT20.HygieneErrors.Good);
export Make_LNAME(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_PRIM_RANGE(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_PRIM_RANGE(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.NotLeft,SALT20.HygieneErrors.Inquotes('"\''),SALT20.HygieneErrors.Good);
export Make_PRIM_RANGE(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_PRIM_NAME(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_PRIM_NAME(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.NotLeft,SALT20.HygieneErrors.Inquotes('"\''),SALT20.HygieneErrors.Good);
export Make_PRIM_NAME(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_SEC_RANGE(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_SEC_RANGE(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.NotLeft,SALT20.HygieneErrors.Inquotes('"\''),SALT20.HygieneErrors.Good);
export Make_SEC_RANGE(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_CITY(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0,stringlib.stringtouppercase(s)<>s,length(trim(s))<>length(trim(stringlib.stringfilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'))),~(length(trim(s)) = 0 or length(trim(s)) >= 4));
export InValidMessage_CITY(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.NotLeft,SALT20.HygieneErrors.Inquotes('"\''),SALT20.HygieneErrors.NotCaps,SALT20.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'),SALT20.HygieneErrors.NotLength('0,4..'),SALT20.HygieneErrors.Good);
export Make_CITY(string s0) := FUNCTION
s1 := stringlib.stringtouppercase(s0); // Force to upper case
s2 := stringlib.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./'); // Only allow valid symbols
s3 := stringlib.stringcleanspaces( stringlib.stringsubstituteout(s2,' <>{}[]-^=!+&,./',' ') ); // Insert spaces but avoid doubles
s4 := if ( stringlib.stringfind('"\'',s3[1],1)>0 and stringlib.stringfind('"\'',s3[length(trim(s3))],1)>0,s3[2..length(trim(s3))-1],s3 );// Remove quotes if required
s5 := trim(s4,left); // Left trim
return s5;
end;
export InValid_STATE(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_STATE(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.NotLeft,SALT20.HygieneErrors.Inquotes('"\''),SALT20.HygieneErrors.Good);
export Make_STATE(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_ZIP(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0,length(trim(s))<>length(trim(stringlib.stringfilter(s,'0123456789'))));
export InValidMessage_ZIP(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.NotLeft,SALT20.HygieneErrors.Inquotes('"\''),SALT20.HygieneErrors.NotInChars('0123456789'),SALT20.HygieneErrors.Good);
export Make_ZIP(string s0) := FUNCTION
s1 := stringlib.stringfilter(s0,'0123456789'); // Only allow valid symbols
s2 := if ( stringlib.stringfind('"\'',s1[1],1)>0 and stringlib.stringfind('"\'',s1[length(trim(s1))],1)>0,s1[2..length(trim(s1))-1],s1 );// Remove quotes if required
s3 := trim(s2,left); // Left trim
return s3;
end;
export InValid_ZIP4(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_ZIP4(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.NotLeft,SALT20.HygieneErrors.Inquotes('"\''),SALT20.HygieneErrors.Good);
export Make_ZIP4(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_COUNTY(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0,length(trim(s))<>length(trim(stringlib.stringfilter(s,'0123456789'))));
export InValidMessage_COUNTY(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.NotLeft,SALT20.HygieneErrors.Inquotes('"\''),SALT20.HygieneErrors.NotInChars('0123456789'),SALT20.HygieneErrors.Good);
export Make_COUNTY(string s0) := FUNCTION
s1 := stringlib.stringfilter(s0,'0123456789'); // Only allow valid symbols
s2 := if ( stringlib.stringfind('"\'',s1[1],1)>0 and stringlib.stringfind('"\'',s1[length(trim(s1))],1)>0,s1[2..length(trim(s1))-1],s1 );// Remove quotes if required
s3 := trim(s2,left); // Left trim
return s3;
end;
export InValid_SSN5(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_SSN5(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.NotLeft,SALT20.HygieneErrors.Inquotes('"\''),SALT20.HygieneErrors.Good);
export Make_SSN5(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_SSN4(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_SSN4(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.NotLeft,SALT20.HygieneErrors.Inquotes('"\''),SALT20.HygieneErrors.Good);
export Make_SSN4(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_DOB(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_DOB(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.NotLeft,SALT20.HygieneErrors.Inquotes('"\''),SALT20.HygieneErrors.Good);
export Make_DOB(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_PHONE(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0,length(trim(s))<>length(trim(stringlib.stringfilter(s,'0123456789'))));
export InValidMessage_PHONE(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.NotLeft,SALT20.HygieneErrors.Inquotes('"\''),SALT20.HygieneErrors.NotInChars('0123456789'),SALT20.HygieneErrors.Good);
export Make_PHONE(string s0) := FUNCTION
s1 := stringlib.stringfilter(s0,'0123456789'); // Only allow valid symbols
s2 := if ( stringlib.stringfind('"\'',s1[1],1)>0 and stringlib.stringfind('"\'',s1[length(trim(s1))],1)>0,s1[2..length(trim(s1))-1],s1 );// Remove quotes if required
s3 := trim(s2,left); // Left trim
return s3;
end;
export InValid_MAINNAME(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_MAINNAME(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.NotLeft,SALT20.HygieneErrors.Inquotes('"\''),SALT20.HygieneErrors.Good);
export Make_MAINNAME(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_FULLNAME(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_FULLNAME(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.NotLeft,SALT20.HygieneErrors.Inquotes('"\''),SALT20.HygieneErrors.Good);
export Make_FULLNAME(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_ADDR1(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_ADDR1(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.NotLeft,SALT20.HygieneErrors.Inquotes('"\''),SALT20.HygieneErrors.Good);
export Make_ADDR1(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_LOCALE(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_LOCALE(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.NotLeft,SALT20.HygieneErrors.Inquotes('"\''),SALT20.HygieneErrors.Good);
export Make_LOCALE(string s0) := FUNCTION
s1 := if ( stringlib.stringfind('"\'',s0[1],1)>0 and stringlib.stringfind('"\'',s0[length(trim(s0))],1)>0,s0[2..length(trim(s0))-1],s0 );// Remove quotes if required
s2 := trim(s1,left); // Left trim
return s2;
end;
export InValid_ADDRS(string s) := WHICH(s[1]=' ' and length(trim(s))>0,stringlib.stringfind('"\'',s[1],1)<>0 and stringlib.stringfind('"\'',s[length(trim(s))],1)<>0);
export InValidMessage_ADDRS(unsigned1 wh) := CHOOSE(wh,SALT20.HygieneErrors.NotLeft,SALT20.HygieneErrors.Inquotes('"\''),SALT20.HygieneErrors.Good);
export Make_ADDRS(string s0) := FUNCTION
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
    BOOLEAN Diff_NAME_SUFFIX;
    BOOLEAN Diff_FNAME;
    BOOLEAN Diff_MNAME;
    BOOLEAN Diff_LNAME;
    BOOLEAN Diff_PRIM_RANGE;
    BOOLEAN Diff_PRIM_NAME;
    BOOLEAN Diff_SEC_RANGE;
    BOOLEAN Diff_CITY;
    BOOLEAN Diff_STATE;
    BOOLEAN Diff_ZIP;
    BOOLEAN Diff_ZIP4;
    BOOLEAN Diff_COUNTY;
    BOOLEAN Diff_SSN5;
    BOOLEAN Diff_SSN4;
    BOOLEAN Diff_DOB;
    BOOLEAN Diff_PHONE;
    UNSIGNED Num_Diffs;
    STRING Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := transform
    SELF.Diff_NAME_SUFFIX := le.NAME_SUFFIX <> ri.NAME_SUFFIX;
    SELF.Diff_FNAME := le.FNAME <> ri.FNAME;
    SELF.Diff_MNAME := le.MNAME <> ri.MNAME;
    SELF.Diff_LNAME := le.LNAME <> ri.LNAME;
    SELF.Diff_PRIM_RANGE := le.PRIM_RANGE <> ri.PRIM_RANGE;
    SELF.Diff_PRIM_NAME := le.PRIM_NAME <> ri.PRIM_NAME;
    SELF.Diff_SEC_RANGE := le.SEC_RANGE <> ri.SEC_RANGE;
    SELF.Diff_CITY := le.CITY <> ri.CITY;
    SELF.Diff_STATE := le.STATE <> ri.STATE;
    SELF.Diff_ZIP := le.ZIP <> ri.ZIP;
    SELF.Diff_ZIP4 := le.ZIP4 <> ri.ZIP4;
    SELF.Diff_COUNTY := le.COUNTY <> ri.COUNTY;
    SELF.Diff_SSN5 := le.SSN5 <> ri.SSN5;
    SELF.Diff_SSN4 := le.SSN4 <> ri.SSN4;
    SELF.Diff_DOB := le.DOB <> ri.DOB;
    SELF.Diff_PHONE := le.PHONE <> ri.PHONE;
    SELF.Val := (STRING)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_NAME_SUFFIX,1,0)+ IF( SELF.Diff_FNAME,1,0)+ IF( SELF.Diff_MNAME,1,0)+ IF( SELF.Diff_LNAME,1,0)+ IF( SELF.Diff_PRIM_RANGE,1,0)+ IF( SELF.Diff_PRIM_NAME,1,0)+ IF( SELF.Diff_SEC_RANGE,1,0)+ IF( SELF.Diff_CITY,1,0)+ IF( SELF.Diff_STATE,1,0)+ IF( SELF.Diff_ZIP,1,0)+ IF( SELF.Diff_ZIP4,1,0)+ IF( SELF.Diff_COUNTY,1,0)+ IF( SELF.Diff_SSN5,1,0)+ IF( SELF.Diff_SSN4,1,0)+ IF( SELF.Diff_DOB,1,0)+ IF( SELF.Diff_PHONE,1,0);
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
    Count_Diff_NAME_SUFFIX := COUNT(GROUP,%Closest%.Diff_NAME_SUFFIX);
    Count_Diff_FNAME := COUNT(GROUP,%Closest%.Diff_FNAME);
    Count_Diff_MNAME := COUNT(GROUP,%Closest%.Diff_MNAME);
    Count_Diff_LNAME := COUNT(GROUP,%Closest%.Diff_LNAME);
    Count_Diff_PRIM_RANGE := COUNT(GROUP,%Closest%.Diff_PRIM_RANGE);
    Count_Diff_PRIM_NAME := COUNT(GROUP,%Closest%.Diff_PRIM_NAME);
    Count_Diff_SEC_RANGE := COUNT(GROUP,%Closest%.Diff_SEC_RANGE);
    Count_Diff_CITY := COUNT(GROUP,%Closest%.Diff_CITY);
    Count_Diff_STATE := COUNT(GROUP,%Closest%.Diff_STATE);
    Count_Diff_ZIP := COUNT(GROUP,%Closest%.Diff_ZIP);
    Count_Diff_ZIP4 := COUNT(GROUP,%Closest%.Diff_ZIP4);
    Count_Diff_COUNTY := COUNT(GROUP,%Closest%.Diff_COUNTY);
    Count_Diff_SSN5 := COUNT(GROUP,%Closest%.Diff_SSN5);
    Count_Diff_SSN4 := COUNT(GROUP,%Closest%.Diff_SSN4);
    Count_Diff_DOB := COUNT(GROUP,%Closest%.Diff_DOB);
    Count_Diff_PHONE := COUNT(GROUP,%Closest%.Diff_PHONE);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
end;
