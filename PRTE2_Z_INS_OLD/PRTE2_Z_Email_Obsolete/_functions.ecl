

EXPORT _functions := MODULE

		// -----------------------------------------------------------------------------
		EXPORT Clean_Email_Username (string email) := FUNCTION
				att_pos := StringLib.StringFind(email, '@',StringLib.StringFindCount(email, '@'));
				username := stringlib.stringtouppercase(email[1..att_pos -1]);
				//blank any characters not [Aa-Zz] or [0-9] or [! # $ % & ' * + - / = ? ^ _ ` { | } ~ ]
				blank_bad_chars := regexreplace('[^[:alnum:]!#$%&\'*+-/=?^_`{|}~]',username ,'');
				//blank leading or ending characters [.'+,/-]
				blank_leading_bad_chars := regexreplace('(^[*.\'+/,-]+)|([*.\'+/,-]+$)',blank_bad_chars ,'');
				//blank usernames with all characters being multiple 0s
				blank_zeros :=  regexreplace('^[0!#$%&\'*+-/=?^_`{|}~]+[0!#$%&\'*+-/=?^_`{|}~][0!#$%&\'*+-/=?^_`{|}~]+$',blank_leading_bad_chars ,'');
				alphachar := regexfind('[A-Za-z0-9]',blank_zeros);
				RETURN  if(alphachar, trim(blank_zeros,all), '');
		END;	

		// -----------------------------------------------------------------------------
		EXPORT Email_rec_key (string email, 
																string prim_range, 
																string prim_name, 
																string sec_range, 
																string zip , 
																string lname, 
																string fname) := hash64((data)email + 																																																									 
																									(data)prim_range + 
																									(data)prim_name + 
																									(data)sec_range + 
																									(data)zip +
																									(data)lname + 
																									(data)fname);
																									
		// -----------------------------------------------------------------------------
		
		// -----------------------------------------------------------------------------
		//Function to propagate did to records without did where the names are simmilar to a rec with did
		EXPORT Propagate_Did(dataset(recordof(_layouts.Base)) email_in) := FUNCTION
				import header, ut;

				with_did :=    email_in(did > 0);
				without_did := email_in(did = 0);

				recordof(email_in) t_propagate_did (without_did le, with_did ri) := transform
					self.did := if(ri.clean_email <> '' , ri.did, le.did);
					self.is_did_prop := if(ri.clean_email <> '' , true, le.is_did_prop);
					self := le;
				end;

				propagate_did := join(distribute(without_did, hash(clean_email)), 
															distribute(with_did, hash(clean_email)),
															left.clean_email = right.clean_email and
															ut.stringsimilar(left.clean_name.lname,right.clean_name.lname) < 3 and
															ut.stringsimilar(left.clean_name.fname,right.clean_name.fname) < 3,
															t_propagate_did (left, right),
															left outer,
															keep (1),
															local);


				RETURN propagate_did + with_did;
		END;		


		// -----------------------------------------------------------------------------
		EXPORT Build_AutoKey(string filedate) := FUNCTION
				import AutoKeyB2; 

				ak_keyname	:= _constants.ak_keyname;
				ak_logical	:= _constants.autokeyFileVerString(filedate);
				ak_dataset	:= _files.File_AutoKey;
				ak_skipSet	:= _constants.ak_skipSet;
				ak_typeStr	:= _constants.ak_typeStr;


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

		// -- Related to FCRA so CT should not need this -------------------------------
		// once z_build_base_ORIG_TMP goes away this isn't needed
		EXPORT Append_HHId(dataset(recordof(_layouts.Base)) email_in) := FUNCTION
				import ut,didville;

				//----Append HHID for recs with and without did
				with_did 		:= email_in(did > 0);
				without_did	:= email_in(did = 0);


				didville.MAC_HHID_Append(     		with_did, 
													'HHID_NAMES', 
													Append_HHID1);

				didville.MAC_HHID_Append_By_Address(
													without_did, 
													Append_HHID2, 
													hhid, 
													clean_name.lname,
													clean_address.prim_range, 
													clean_address.prim_name, 
													clean_address.sec_range, 
													clean_address.st, 
													clean_address.zip);
					
										
				email_all := Append_HHID1 + Append_HHID2;

				RETURN email_all;
		END;
		// -----------------------------------------------------------------------------
		EXPORT SpecialCTSourceCalculation(STRING inSource) := FUNCTION
				IMPORT mdr;
				outSource := MAP( // There is also Thrive.Files, but it seems different, doesn't use mdr.sourceTools.anyValue
										(inSource = mdr.sourceTools.src_acquiredweb) => mdr.sourceTools.src_acquiredweb
										,(inSource = mdr.sourceTools.src_alloymedia_consumer) => mdr.sourceTools.src_alloymedia_consumer
										,(inSource = mdr.sourceTools.src_datagence) => mdr.sourceTools.src_datagence
										,(inSource = mdr.sourceTools.src_entiera) => mdr.sourceTools.src_entiera
										,(inSource = mdr.sourceTools.src_Ibehavior) => mdr.sourceTools.src_Ibehavior
										,(inSource = mdr.sourceTools.src_impulse) => mdr.sourceTools.src_impulse
										,(inSource = mdr.sourceTools.src_MediaOne) => mdr.sourceTools.src_MediaOne
										,(inSource = mdr.sourceTools.src_OutwardMedia) => mdr.sourceTools.src_OutwardMedia
										,(inSource = mdr.sourceTools.src_SalesChannel) => mdr.sourceTools.src_SalesChannel
										,(inSource = mdr.sourceTools.src_wired_assets_email) => mdr.sourceTools.src_wired_assets_email
										,inSource);
				
				return outSource;
		END;
		// -----------------------------------------------------------------------------
		// -----------------------------------------------------------------------------
																									
END;