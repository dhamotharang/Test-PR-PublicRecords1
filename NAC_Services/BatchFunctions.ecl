IMPORT NAC_Services,NAC_V2_Services,STD,Address,NID,ut;
EXPORT BatchFunctions := MODULE

	EXPORT processBatch(DATASET(NAC_Services.Layouts.Batch_in_temp) ds_in) := FUNCTION

		NAC_V2_Services.Layouts.process_layout xformInput(ds_in L) := TRANSFORM
			SELF.acctno 						:= (UNSIGNED)L.acctno;// Sequenced acctno
			SELF.orig_acctno 			  := L.orig_acctno;
			useCleanName						:= L.name_first <> '' AND L.name_last <> '';
			nameToClean							:= Address.NameFromComponents(L.name_first, L.name_middle,
			                                                      L.name_last, L.name_suffix);
			cleanName								:= Address.CleanNameFields(Address.CleanPersonFML73(nameToClean)).CleanNameRecord;
			nameLast                := IF(useCleanName, cleanName.lname, L.name_last);
			SELF.name_last 					:= nameLast;
			nameFirst               := IF(useCleanName, cleanName.fname, L.name_first);
			SELF.name_first 				:= nameFirst;
			SELF.name_middle 				:= IF(useCleanName, cleanName.mname, L.name_middle);
			SELF.name_suffix				:= IF(useCleanName, cleanName.name_suffix, L.name_suffix);
			SELF.name_first_pref		:= NID.PreferredFirst(nameFirst);
			SELF.name_first_pref_new:= NID.PreferredFirstNew(nameFirst);
			SELF.orig_name_last			:= L.name_last;
			SELF.orig_name_first		:= L.name_first;
			address1_addr1					:= L.address1_addr1 + ' ' + L.address1_addr2;
			address1_addr2 					:= Address.Addr2FromComponents(L.address1_city,
			                                                       L.address1_state, L.address1_zip);
			address1_clean_addr 		:= address.GetCleanAddress(address1_addr1,address1_addr2,
			                                                   address.Components.country.US);
			address1_ca							:= address1_clean_addr.results;
			SELF.addr1_prim_range		:= address1_ca.prim_range;
			SELF.addr1_prim_name 		:= address1_ca.prim_name;
			SELF.addr1_suffix				:= address1_ca.suffix;
			SELF.addr1_predir 			:= address1_ca.predir;
			SELF.addr1_postdir 			:= address1_ca.postdir;
			SELF.addr1_sec_range		:= address1_ca.sec_range;
			SELF.addr1_city					:= address1_ca.p_city;
			SELF.addr1_state				:= address1_ca.state;
			SELF.addr1_zip					:= address1_ca.zip;
			address2_addr1					:= L.address2_addr1 + ' ' + L.address2_addr2;
			address2_addr2 					:= Address.Addr2FromComponents(L.address2_city,
			                                                       L.address2_state, L.address2_zip);
			address2_clean_addr 		:= address.GetCleanAddress(address2_addr1,address2_addr2,
			                                                   address.Components.country.US);
			address2_ca							:= address2_clean_addr.results;
			SELF.addr2_prim_range 	:= address2_ca.prim_range;
			SELF.addr2_prim_name 		:= address2_ca.prim_name;
			SELF.addr2_suffix				:= address2_ca.suffix;
			SELF.addr2_predir 			:= address2_ca.predir;
			SELF.addr2_postdir 			:= address2_ca.postdir;
			SELF.addr2_sec_range		:= address2_ca.sec_range;
			SELF.addr2_city					:= address2_ca.p_city;
			SELF.addr2_state				:= address2_ca.state;
			SELF.addr2_zip					:= address2_ca.zip;
			// For filling match codes correctly if city/state OR zip wasn't actually in the input
			SELF.hasCityStateInput	:= (L.address1_city <> '' AND L.address1_state <> '')
			                            OR (L.address2_city <> '' AND L.address2_state <> '');
			SELF.hasZipInput				:= L.address1_zip <> '' OR L.address2_zip <> '';
			SELF.ssn			         	:= L.ssn;
			SELF.dob				        := L.dob;
		  programCode             := STD.STR.ToUpperCase(L.benefit_type);
			SELF.in_program_code		:= programCode;
			caseID                  := STD.STR.ToUpperCase(L.case_identifier);
			SELF.case_identifier		:= caseID;
			// Purposely set the client='' we don't support client searches in nac1 match searches
			SELF.client_identifier	:= '';
			benState                := STD.STR.ToUpperCase(L.benefit_state);
			SELF.benefit_state			:= benState;
			benMonth                := TRIM(L.benefit_month,LEFT)[..6];
			SELF.benefit_month 			:= benMonth;
			// We disregard input since these are investigative fields
			SELF.benefit_month_start:= '';
			SELF.benefit_month_END	:= '';
			SELF.eligibility_status	:= STD.STR.ToUpperCase(L.eligibility_status);
			SELF.IncludeInterstateAllPrograms	:= TRUE;// NAC_Services.Constants.MATCH_ProgramsAllowedReturn

			inHasNoPII	:= ~NAC_V2_Services.Functions().inputHasPII(nameLast, nameFirst, L.ssn,
																	L.address1_addr1, L.address1_city, L.address1_state, L.address1_zip,
																	L.address2_addr1, L.address2_city, L.address2_state, L.address2_zip);

			SELF.error_code	:= NAC_Services.Functions.isMatchInputMet(programCode,benMonth,benState,inHasNoPII);
		END;

		ds_out := PROJECT(ds_in, xformInput(LEFT));

		// Debug
		#IF(NAC_Services.Constants.Debug)
			OUTPUT(ds_out(error_code=0),NAMED('valid_inputs'));
			OUTPUT(ds_out(error_code>0),NAMED('invalid_inputs'));
		#END
		RETURN ds_out;
	END;

	EXPORT finalBatchTransform(DATASET(NAC_Services.Layouts.nac_raw_rec) nac_recs) := FUNCTION		
		ds_results := PROJECT(nac_recs, 
		                 TRANSFORM(NAC_Services.Layouts.nac_batch_out,
												SELF.acctno                  := LEFT.orig_acctno, //restore orig acctno's
												SELF.contact_name	           := LEFT.state_contact_name,
												SELF.contact_phone           := LEFT.state_contact_phone,
												SELF.contact_phone_extension := LEFT.state_contact_phone_extension,
												SELF.contact_email	         := LEFT.state_contact_email,
												SELF.sequence_number	       := IF(LEFT.sequence_number=0,'',(STRING)LEFT.sequence_number),
												SELF := LEFT));
		ut.mac_TrimFields(ds_results,'ds_results',results);
		RETURN results;
	END;	

END;