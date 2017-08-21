import AutoKeyB2, death_master; 

export proc_autokeybuild(string filedate) := function

dsearch := death_master.file_SearchAutokey;


skip_set := death_master.constants(filedate).autokey_skip_set;
AutoKeyB2.MAC_Build (dsearch,fname,mname,lname,
						ssn,
						dob,
						zero,
						addr.prim_name,addr.prim_range,addr.st,addr.v_city_name,addr.zip5,addr.sec_range,
						zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,
						DID,
						blank,
						zero,
						zero,
						blank,blank,blank,blank,blank,blank,
						zero,
						death_master.constants(filedate).autokey_keyname,
						death_master.constants(filedate).autokey_Logical,
						outaction,false,
						skip_set,TRUE,death_master.constants(filedate).autokey_typeStr,
						true,,,zero); 


AutoKeyB2.MAC_AcceptSK_to_QA(death_master.constants(filedate).autokey_keyname,mymove)

out_auto := sequential(outaction,mymove);
 
return out_auto;

end;
