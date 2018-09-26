EXPORT mac_MatchFlex(JobId, InputFile, ssn='', dob='', fname, mname='', lname, name_suffix='', prim_range, prim_name, sec_range, zip, st, phone='', outfile, low_score_threshold=90, adl_matchset='')  := MACRO
  LOADXML('<xml/>');
rAdl := RECORD
  recordof(InputFile);
#IF(#TEXT(ssn)='')
  string adl_ssn := '';
#END
#IF(#TEXT(dob)='')
  string adl_dob := '';
#END
#IF(#TEXT(mname)='')
  string adl_mname := '';
#END
#IF(#TEXT(name_suffix)='')
  string adl_name_suffix := '';
#END
#IF(#TEXT(phone)='')
  string adl_phone := '';
#END
  unsigned4 did := 0;
	unsigned4 did_score := 0;
END;

//matchset := ['A','D','S','Q'];
#stored('did_add_force', 'roxie');

final_adl_matchset := ['A', 'Q', 'Z', 'S', 'P','D'];


did_add.MAC_Match_Flex
                (project(InputFile, TRANSFORM(rAdl, self := lefT)), 
								final_adl_matchset, 								
#IF(#TEXT(ssn)!='')
								ssn,
#ELSE
                adl_ssn,
#END
#IF(#TEXT(dob)!='')
								dob,
#ELSE
                adl_dob,
#END                
                 fname, 
#IF(#TEXT(mname)!='')
								mname, 
#ELSE
                adl_mname,
#END
								 lname, 
#IF(#TEXT(name_suffix)!='')
								 name_suffix, 
#ELSE
								 adl_name_suffix, 
#END
                 prim_range, prim_name, sec_range, zip, st, 
#IF(#TEXT(phone)!='')
								phone,
#ELSE
                adl_phone,
#END
                did, rAdl, true, did_score,
                low_score_threshold, outfile
								);
							
ENDMACRO;
