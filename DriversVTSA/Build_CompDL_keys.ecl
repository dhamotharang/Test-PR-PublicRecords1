export Build_CompDL_keys := MODULE

	import DriversV2, Doxie_Files, ut, doxie, autokey, autokeyB2, RoxieKeyBuild, lib_fileservices;;
	
	
	export CompDLEx := DATASET(File_CompDL, {DriversV2.Layout_DL, UNSIGNED8 RecPtr {virtual(fileposition)}}, FLAT);
/*
	export Key_DID := index(CompDLEx(did!=0), {did, RecPtr}, '~thor400_92::key::dl_VTSA::did');
	export Key_ssn := index(CompDLEx(SSN!='' AND SSN!='000000000'), {SSN, RecPtr}, '~thor400_92::key::dl_VTSA::ssn');
	export Key_Name := index(CompDLEx(lname!=''), {lname,fname,mname, RecPtr}, '~thor400_92::key::dl_VTSA::name');
	export Key_StName := index(CompDLEx(st!='' AND lname!=''), {st,lname,fname,mname, RecPtr}, '~thor400_92::key::dl_VTSA::stnam');
	export Key_CityStName := index(CompDLEx(p_city_name!='' AND p_city_name!='?' AND st!='' AND lname!=''), {p_city_name,st,lname,fname,mname, RecPtr}, '~thor400_92::key::dl_VTSA::city');
	export Key_zip := index(CompDLEx(zip5!='' AND LENGTH(TRIM(zip5))=5 AND zip5!='00000' AND lname!=''), {zip5,lname,fname,mname, RecPtr}, '~thor400_92::key::dl_VTSA::zip');
*/

	
	//start dl autokeys
	dl_base     := File_DL_base_for_Autokeys;


	// holds logical base name for a autokeys.
	autokey_keyname	  := '~thor400_92::key::dl_VTSA::autokey::';
	autokey_qa_Keyname := '~thor400_92::key::dl_VTSA::autokey::qa::';
	
	autokey_typeStr  := 'DL';
	autokey_skipSet  := ['B','P','Q','F'];
	
	logicalname := '~thor400_92::key::dl_VTSA::' + filedate + '::autokey::';
	logicalkeyname := '~thor400_92::key::dl_VTSA::' + filedate + '::';
	key_qa_Keyname := '~thor400_92::key::dl_VTSA::qa::';

	// holds key base name for autokeys 
	keyname     := autokey_keyname;
	// Holds the type string for lookups
	type_str    := autokey_typeStr;
	skip_set    := autokey_skipSet;

	AutokeyB2.MAC_Build(dl_base,fname,mname,lname,
					ssn,
					dob,
					zero,
					prim_name, prim_range, st, p_city_name, zip5, sec_range,
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
					keyname,
					logicalname,bld_auto_keys,false,skip_set,true,type_str,
					true,,,zero); 

	
	
// Move DID, dl_number & seq keys to built
// Move DID, dl_number & seq to QA


	//export Build_AutoKeys := bld_auto_keys;
	bld_dl_seq_key := buildindex(Key_DL_Seq, logicalkeyname + 'dl_seq');
	bld_dl_key := buildindex(Key_DL, logicalkeyname + 'dl');
	bld_dl_number_key := buildindex(Key_DL_Number, logicalkeyname + 'dl_number');
	bld_dl_did := buildindex(Key_DL_DID, logicalkeyname + 'dl_did');


	//export Build_dl_Keys := 
		//					 parallel(bld_dl_seq_key, bld_dl_key, bld_auto_keys);
															//export Build_Keys := parallel(
/*
	export Build_dl_Keys := sequential(
							 parallel(bld_dl_seq_key, bld_auto_keys),
							 mv_seq,
							 parallel(mv_seq_key, mv_fdids_key, mv_autokey_ssn2, 
														mv_autokey_addr, mv_autokey_name, mv_autokey_stnam,
														mv_autokey_city, mv_autokey_zip)																			
							);
*/
//Build_All:=	sequential(	Build_dl_Keys,
//						Build_Uber_Keys);
																		
	ClearSuperFile(string name) := FUNCTION
		superfile := autokey_qa_Keyname + name;
		return IF(FileServices.SuperFileExists(superfile), 
				FileServices.ClearSuperFile(superfile),
				FileServices.CreateSuperFile(superfile));
	END;
	
	ClearSuperFile2(string name) := FUNCTION
		superfile := key_qa_Keyname + name;
		return IF(FileServices.SuperFileExists(superfile), 
				FileServices.ClearSuperFile(superfile),
				FileServices.CreateSuperFile(superfile));
	END;
	
	ClearSuperFile3(string name) := FUNCTION
		superfile := autokey_keyname + name;
		return IF(FileServices.SuperFileExists(superfile), 
				FileServices.ClearSuperFile(superfile),
				FileServices.CreateSuperFile(superfile));
	END;
	
	//AddToSuperfile(string superfile, string filename) := FUNCTION
	AddToSuperfile(string name) := FUNCTION
			superfile := autokey_qa_Keyname + name;
			filename := logicalname + name;
			return	FileServices.AddSuperFile(superfile, filename);
		END;
		
	AddToSuperfile2(string name) := FUNCTION
			superfile := key_qa_Keyname + name;
			filename := logicalkeyname + name;
			return	FileServices.AddSuperFile(superfile, filename);
		END;
		
	SetupAutoKey(string name) := 
		SEQUENTIAL(
			ClearSuperFile(name),
			ClearSuperFile3(name+'_built'),
			ClearSuperFile3(name+'_delete'),
			ClearSuperFile3(name+'_father'),
			ClearSuperFile3(name+'_grandfather'),
			ClearSuperFile3(name+'_qa')
	);		
		
	clear_all := SEQUENTIAL(
		SetupAutoKey('SSN2'),
		//ClearSuperFile('SSN'),
		SetupAutoKey('Address'),
		SetupAutoKey('Name'),
		SetupAutoKey('StName'),
		SetupAutoKey('CityStName'),
		SetupAutoKey('Zip'),
		SetupAutoKey('payload'),
		ClearSuperFile2('dl_seq'),
		ClearSuperFile2('dl_number'),
		ClearSuperFile2('dl_did'),
		ClearSuperFile2('dl')
	);
	
super_all
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
			
		AddToSuperfile('SSN2'),
		//AddToSuperfile('SSN'),
		AddToSuperfile('Address'),
		AddToSuperfile('Name'),
		AddToSuperfile('StName'),
		AddToSuperfile('CityStName'),
		AddToSuperfile('Zip'),
		AddToSuperfile('payload'),
		AddToSuperfile2('dl_seq'),
		AddToSuperfile2('dl_number'),
		AddToSuperfile2('dl_did'),
		AddToSuperfile2('dl'),
		
		FileServices.FinishSuperFileTransaction()
	);
	
	export Build_dl_Keys := sequential(
							clear_all,
							Proc_Build_DL_Search_Base,
							 parallel(bld_dl_seq_key, bld_dl_number_key, bld_dl_did, bld_dl_key, bld_auto_keys),
							 super_all																			
							);

end;