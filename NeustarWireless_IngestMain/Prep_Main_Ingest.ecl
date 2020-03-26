IMPORT NeustarWireless, MDR, STD, Tools, Address, NID, ut, PRTE2;
EXPORT Prep_Main_Ingest:= FUNCTION


	
		NeustarWireless.Layouts.Base.Main tAppendFields(RECORDOF(NeustarWireless.Files.Raw_In) pInput) := TRANSFORM	
				self.latitude						:= (real8) pInput.latitude; 	
				self.longitude					:= (real8) pInput.longitude; 					
 
				vFileDate := (unsigned4) pInput.raw_file_name[length(trim(pInput.raw_file_name))-7..length(trim(pInput.raw_file_name))];
				self.date_vendor_first_reported :=	vFileDate;
				self.date_vendor_last_reported 	:=	vFileDate;
				self.process_date 							:=  (unsigned4) workunit[2..9];
				self.process_time								:= 	(unsigned4) workunit[11..16];
				self.current_rec								:= 	true;
				self.source 										:= 	MDR.sourceTools.src_NeustarWireless;
			
				self.cln_dob										:= Std.Date.ConvertDateFormat(ut.CleanSpacesAndUpper(pInput.dob),'%Y%m%d','%Y%m%d');
		
				self.append_prep_name 					:= ut.CleanSpacesAndUpper(pInput.fname + ' ' + pInput.mname + ' ' + pInput.lname);

				self.append_prep_address_1 := Address.Addr1FromComponents(prim_range:=ut.CleanSpacesAndUpper(pInput.house), 
																																	predir:=ut.CleanSpacesAndUpper(pInput.pre_dir), 
																																	prim_name:=ut.CleanSpacesAndUpper(pInput.street), 
																																	suffix:=ut.CleanSpacesAndUpper(pInput.street_type), 
																																	postdir:=ut.CleanSpacesAndUpper(pInput.post_dir), 
																																	unit_desig:=ut.CleanSpacesAndUpper(pInput.apt_type), 
																																	sec_range:=ut.CleanSpacesAndUpper(pInput.apt_nbr));
																												
				self.append_prep_address_2 := Address.Addr2FromComponents(city_name:=ut.CleanSpacesAndUpper(pInput.city), 
																																	st:=ut.CleanSpacesAndUpper(pInput.state), 
																																	zip:=ut.CleanSpacesAndUpper(pInput.zip));
	
				self	:=	pInput;	
				self	:= 	[];			
		END;
		
		//Project raw file to base layout and populate dates, source, and appended address fields
		dsBaseDirtyNames := PROJECT(NeustarWireless.Files.Raw_In, tAppendFields(LEFT));

		//clean names and normalize dual names
		NID.Mac_CleanParsedNames(dsBaseDirtyNames, dsCleanNames, 
														 firstname:=fname, lastname:=lname, middlename:=mname, namesuffix:=suffix
														,includeInRepository:= not(Tools._Constants.IsDataland) //if in dataland, don't include in repository per Charles Salvo
														,normalizeDualNames:=true, useV2 := true);
													
		dsBaseCleanNames := PROJECT(dsCleanNames, TRANSFORM(NeustarWireless.Layouts.Base.Main, SELF.cln_fullname := LEFT.fullname; SELF := LEFT));

		NeustarWireless.Layouts.Base.Main tAddPersistentRecordID(NeustarWireless.Layouts.Base.Main pInput) := TRANSFORM
			//add persistent record id
			self.persistent_record_id 	:= HASH64(pInput.phone
																			,ut.CleanSpacesAndUpper(pInput.fname)
																			,ut.CleanSpacesAndUpper(pInput.lname)
																			,ut.CleanSpacesAndUpper(pInput.apt_nbr)
																			,pInput.latitude
																			,pInput.longitude
																			,pInput.NID); //Added NID here because we are normalizing to split vendor records
																										//where we receive two names in one record.  ie, fname + lname resolves to 
																										//Bob and Ann Smith
			self	:=	pInput;	
			self	:= 	[];			
		END;
		
		dsBaseNormalized := PROJECT(dsBaseCleanNames, tAddPersistentRecordID(LEFT));
		
		//sanity check outputs
		count_raw_in := count(NeustarWireless.Files.Raw_In);
		count_raw_normalized_names := count(dsBaseNormalized);
		output(count_raw_in, named('count_raw_in'));
		output(count_raw_normalized_names, named('count_raw_normalized_names'));
		output(((count_raw_normalized_names - count_raw_in)/count_raw_in)*100.00, named('pct_difference'));

		output(count(dsBaseCleanNames(trim(cln_lname)<>'')), named('count_cln_lname'));	
		output(count(dsBaseCleanNames(trim(cln_lname)='')), named('count_missing_cln_lname'));		
		output(choosen(dsBaseCleanNames(trim(cln_lname)=''), 100), named('sample_missing_cln_lname'));	
		output(choosen(dsBaseCleanNames(trim(cln_lname)<>''), 100), named('sample_cln_lname'));	
		
		RETURN dsBaseNormalized;																								

END;
