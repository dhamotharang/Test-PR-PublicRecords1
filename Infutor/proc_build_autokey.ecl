import AutoKeyB2, infutor; 

export proc_build_autokey(string filedate) := function

dsearch := Infutor.file_infutor_autokey;

skip_set := Infutor.constants(filedate).autokey_skip_set;
AutoKeyB2.MAC_Build (dsearch,name.fname,name.mname,name.lname,
						ssn,
						dob,
						phone,
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
						infutor.constants(filedate).autokey_keyname,
						infutor.constants(filedate).autokey_Logical,
						outaction,false,
						skip_set,TRUE,infutor.constants(filedate).ak_typeStr,
						true,,,zero); 


AutoKeyB2.MAC_AcceptSK_to_QA(infutor.constants(filedate).autokey_keyname,mymove)

out_auto := sequential(outaction,mymove);
 
return out_auto;

end;
