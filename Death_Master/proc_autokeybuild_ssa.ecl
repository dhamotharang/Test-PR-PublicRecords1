import AutoKeyB2, death_master, lib_Stringlib; 

export proc_autokeybuild_ssa(string filedate) := function

dsearch := death_master.file_SearchAutokey_ssa;


skip_set := death_master.constants(filedate).autokey_skip_set;
autokey_keyname		:=	death_master.constants(filedate).autokey_keyname_ssa;
autokey_logical		:=	death_master.constants(filedate).autokey_Logical_ssa;


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
						autokey_keyname,
						autokey_logical,
						outaction,false,
						skip_set,TRUE,death_master.constants(filedate).autokey_typeStr,
						true,,,zero); 


AutoKeyB2.MAC_AcceptSK_to_QA(autokey_keyname,mymove)

out_auto := sequential(outaction, mymove);
 
return out_auto;

end;
