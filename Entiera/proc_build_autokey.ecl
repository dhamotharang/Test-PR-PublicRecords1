import AutoKeyB2; 


export proc_build_autokey(string filedate) := function

c						:= entiera_constants(filedate);
ak_keyname	:= c.ak_keyname;
ak_logical	:= c.ak_logical;
ak_dataset	:= c.ak_dataset;
ak_skipSet	:= c.ak_skipSet;
ak_typeStr	:= c.ak_typeStr;


AutoKeyB2.MAC_Build (ak_dataset,clean_name.fname,clean_name.mname,clean_name.lname,
						best_ssn,
						best_dob,
						zero,
						clean_address.prim_name,
						clean_address.prim_range,
						clean_address.st,
						clean_address.p_city_name,
						clean_address.zip,
						clean_address.sec_range,
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
						ak_keyname,
						ak_logical,
						outaction,false,
						ak_skipSet,true,ak_typeStr,
						false,,,zero); 


return outaction;

end;