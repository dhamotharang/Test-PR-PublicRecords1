IMPORT AutoKeyB2;

		EXPORT Build_AutoKeys(string filedate) := FUNCTION
				import AutoKeyB2; 

				ak_keyname	:= Files.ak_keyname;
				ak_logical	:= Files.autokeyFileVerString(filedate);
				ak_dataset	:= Files.File_AutoKey;
				ak_skipSet	:= Files.ak_skipSet;
				ak_typeStr	:= Files.ak_typeStr;


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


				RETURN outaction;

		END;

