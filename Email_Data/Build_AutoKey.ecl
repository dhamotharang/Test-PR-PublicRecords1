import AutoKeyB2; 


export Build_AutoKey(string filedate) := function

ak_keyname	:= constants(filedate).ak_keyname;
ak_logical	:= constants(filedate).ak_logical;
ak_dataset	:= constants(filedate).ak_dataset;
ak_skipSet	:= constants(filedate).ak_skipSet;
ak_typeStr	:= constants(filedate).ak_typeStr;


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