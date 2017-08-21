import AutoKeyB2; 

export Proc_HuntFish_AutokeyBuild_fcra(string filedate) := function

b := emerges.file_huntfish_searchautokey;

skip_set := emerges.HuntFish_Autokey_Constants(filedate).ak_skip_set;

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
						did,
						blank,
						zero,
						zero,
						blank,blank,blank,blank,blank,blank,
						zero,
						emerges.HuntFish_Autokey_Constants(filedate).ak_keyname_fcra,
						emerges.HuntFish_Autokey_Constants(filedate).ak_logicalname_fcra,
						outaction,false,
						skip_set,
						true,
						emerges.HuntFish_Autokey_Constants(filedate).ak_typeStr,
						true,,,zero);

AutoKeyB2.MAC_AcceptSK_to_QA(emerges.HuntFish_Autokey_Constants(filedate).ak_keyname_fcra, mymove,, skip_set)

retval := sequential(outaction,mymove);
 
return retval;

end;
