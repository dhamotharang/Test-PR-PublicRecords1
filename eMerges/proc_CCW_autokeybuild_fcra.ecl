import AutoKeyB2 , Mdr;
export proc_CCW_autokeybuild_fcra(string filedate) := function

b0 := eMerges.file_ccw_searchautokey_pre(Source_code <> MDR.sourceTools.src_EMerge_CCW_NY);
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
						eMerges.CCW_Constants(filedate).ak_keyname_fcra,
						eMerges.CCW_Constants(filedate).ak_logicalname_fcra,
						outaction_fcra,false,
						skip_set,
						true,
						eMerges.CCW_Constants(filedate).ak_typeStr,
						true,,,zero);

AutoKeyB2.MAC_AcceptSK_to_QA(eMerges.CCW_Constants(filedate).ak_keyname_fcra, mymove_fcra,, skip_set);

retval := sequential(outaction_fcra,mymove_fcra);
 
return retval;

end;