export fn_concat_name_MA(string first_name,string mid, string last_name) := function 

  temp_name:= trim(trim(FIRST_NAME,left,right)+' '+trim(MID,left,right)+' '+trim(LAST_NAME,left,right));
  temp_name1:= StringLib.StringFindReplace(temp_name, 'U/D/T DATED 1/29/92, F/B/O THE MASON FAMILY',' ');
  temp_name2:= StringLib.StringFindReplace(temp_name1, 'U/T/D  11-20-1993 AS AMENDE',' ');
  temp_name3:= StringLib.StringFindReplace(temp_name2, ' U/D/T/ 7-6-1',' ');
  temp_name4:= StringLib.StringFindReplace(temp_name3, 'BARNSTABLE  BARNSTABLE','BARNSTABLE');
  tmp_xname5:=regexreplace('@',temp_name4,' ');
  tmp_xname6:=regexreplace('C/O',tmp_xname5,' ');
  tmp_xname7:=regexreplace('ATTN:',tmp_xname6,' ');

return tmp_xname7;  
end ; 