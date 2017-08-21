//TODO -- Very Much a WIP

//TODO - not sure if CT needs phase1 autokeys at all... 

EXPORT z_p1_build_autokey(STRING version) := FUNCTION
			IMPORT AutokeyB2;

			layout_autokey:=RECORD
				_files.Phase1_Output_File.clean_p_city_name;
				_files.Phase1_Output_File.phone;
				_files.Phase1_Output_File.dob;
				_files.Phase1_Output_File.did;
				_files.Phase1_Output_File.clean_fname;
				_files.Phase1_Output_File.clean_mname;
				_files.Phase1_Output_File.clean_lname;
				_files.Phase1_Output_File.clean_name_suffix;
				_files.Phase1_Output_File.clean_prim_range;
				_files.Phase1_Output_File.clean_prim_name;
				_files.Phase1_Output_File.clean_sec_range;
				_files.Phase1_Output_File.clean_st;
				_files.Phase1_Output_File.clean_zip;
				_files.Phase1_Output_File.email;
				STRING blank:='';
				INTEGER zero:=0;
			END;
			
			autokeydata:=TABLE(_files.Phase1_Output_File,layout_autokey);
			SET OF STRING skipset:=['Q','S','F','B'];
			
			AutoKeyB2.MAC_Build(autokeydata,clean_fname,clean_mname,clean_lname,blank,dob,
				phone,clean_prim_name,clean_prim_range,clean_st,clean_p_city_name,clean_zip,clean_sec_range,
				zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,did,blank,zero,
				zero,blank,blank,blank,blank,blank,blank,zero,
				_constants.autokeyFileString ,
				_constants.autokeyFileVerString(version),
				createautokey,false,skipset,true,,false,,,zero);

			RETURN createautokey;
END;