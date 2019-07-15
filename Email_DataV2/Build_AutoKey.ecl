import AutoKeyB2, dx_email; 


export Build_AutoKey(string filedate) := function

ak_keyname	:= dx_email.constants(filedate).ak_keyname;
ak_logical	:= dx_email.constants(filedate).ak_logical;
ak_dataset	:= Email_Datav2.constants(filedate).ak_dataset;
ak_skipSet	:= dx_email.constants(filedate).ak_skipSet;
ak_typeStr	:= dx_email.constants(filedate).ak_typeStr;


AutoKeyB2.MAC_Build (ak_dataset,clean_name.fname,clean_name.mname,clean_name.lname,
						clean_ssn,
						clean_dob,
						clean_phone,
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
						cln_CompanyName,
						zero,
						zero,
						blank,blank,blank,blank,blank,blank,
						zero,
						ak_keyname,
						ak_logical,
						outaction,false,
						ak_skipSet,false,ak_typeStr,
						false,,,zero); 


return outaction;

end;