import AutoKeyB2; 

export proc_ccw_autokeybuild(string filedate) := function

b0 := emerges.file_ccw_searchautokey;
b := Project(b0, Transform( recordof(b0) and not source_code, Self := Left));

skip_set := emerges.CCW_Constants(filedate).ak_skipset;

  AutokeyB2.MAC_Build (b,
            fname,mname,lname, 
						best_ssn,
						zero,
						zero,
						prim_name,prim_range,st,city_name,zip,sec_range,
						zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,
						did_out6, // converted type of did_out to unsigned6
						blank,
						zero,
						zero,
						blank,blank,blank,blank,blank,blank,
						zero,
						eMerges.CCW_Constants(filedate).ak_keyname,
						eMerges.CCW_Constants(filedate).ak_logicalname,
						outaction,false,
						skip_set,
						true,
						eMerges.CCW_Constants(filedate).ak_typeStr,
						true,,,zero);

AutoKeyB2.MAC_AcceptSK_to_QA(eMerges.CCW_Constants(filedate).ak_keyname, mymove,, skip_set)

retval := sequential(outaction,mymove);
 
return retval;

end;
