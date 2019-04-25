//************************************************************************************************************************************//
//Liens Key files for Key Validation purposes
//************************************************************************************************************************************//

EXPORT LSKeyFiles := MODULE

Import Autokeyb2,LiensV2,Ashirey,Autokey,Data_Services, Doxie, ut;

	//Attribute that refers to FCRA BDID key file
	EXPORT keyFileBDID := LiensV2.Key_FCRA_liens_BDID;	
	
	//Attribute that refers to NON FCRA BDID key file
	EXPORT keyFileBDID_NF := LiensV2.Key_liens_BDID;	
	
	//Attribute that refers to NON FCRA CaseNumber key file
	EXPORT keyFileCaseNumberNF := LiensV2.Key_liens_case_number;

	//Attribute that refers to FCRA CaseNumber key file
	EXPORT keyFileCaseNumber := LiensV2.Key_fcra_liens_case_number;

	//Attribute that refers to NON FCRA DID key file
	EXPORT keyFileDIDNF := LiensV2.Key_liens_DID;

	//Attribute that refers to DID key file
	EXPORT keyFileDID := LiensV2.key_liens_DID_FCRA;
	
	//Attribute that refers to FCRA Filing key file
	EXPORT keyFileFiling := LiensV2.Key_fcra_liens_filing;
	
	//Attribute that refers to NON FCRA Filing key file
	EXPORT keyFileFilingNF := LiensV2.Key_liens_filing;
	
	//Attribute that refers to NON FCRA Certificate Number key file
	EXPORT keyFileCTNNF := LiensV2.key_liens_certificate_number;
	
	//Attribute that refers to FCRA Certificate Number key file
	EXPORT keyFileCTN := LiensV2.key_fcra_liens_certificate_number;
	
	//Attribute that refers to NON FCRA Serial Number key file
	EXPORT keyFileSNNF := LiensV2.key_liens_irs_serial_number;
	
	//Attribute that refers to FCRA Serial Number key file
	EXPORT keyFileSN := LiensV2.key_fcra_liens_irs_serial_number;
	
	//Attribute that refers to NON FCRA RMSID key file
	EXPORT keyFileRMSNF := LiensV2.Key_liens_RMSID;

	//Attribute that refers to FCRA RMSID key file
	EXPORT keyFileRMS := LiensV2.key_liens_RMSID_FCRA;
	
	//Attribute that refers to NON FCRA TMSID RMSID main key file
	
	EXPORT layout_filing_status := RECORD,maxlength(10000)
	
   string filing_status;
   string filing_status_desc;
  END;

	
  SHARED TRMOutputLayout := RECORD,maxlength(32766)
		string50 tmsid;
		string50 rmsid;
		string process_date;
		string record_code;
		string date_vendor_removed;
		string filing_jurisdiction;
		string filing_state;
		string20 orig_filing_number;
		string orig_filing_type;
		string orig_filing_date;
		string orig_filing_time;
		string case_number;
		string20 filing_number;
		string filing_type_desc;
		string filing_date;
		string filing_time;
		string vendor_entry_date;
		string judge;
		string case_title;
		string filing_book;
		string filing_page;
		string release_date;
		string amount;
		string eviction;
		string satisifaction_type;
		string judg_satisfied_date;
		string judg_vacated_date;
		string tax_code;
		string irs_serial_number;
		string effective_date;
		string lapse_date;
		string accident_date;
		string sherrif_indc;
		string expiration_date;
		string agency;
		string agency_city;
		string agency_state;
		string agency_county;
		string legal_lot;
		string legal_block;
		string legal_borough;
		string certificate_number;
		unsigned8 persistent_record_id;
		layout_filing_status filing_status;
		unsigned8 __internal_fpos__;
 END;

  
 
	SHARED keyFileTRDNF_base := LiensV2.Key_liens_main_ID;	
	
		TRMOutputLayout normalizeKeyTransform1(keyFileTRDNF_base l, unsigned c) := TRANSFORM
				self.filing_status := l.filing_status[c];
				self := l;
		END;
		
	NormalizedKeyTR := NORMALIZE(keyFileTRDNF_base,count(left.filing_status), normalizeKeyTransform1(left,counter));

	Ashirey.Flatten(NormalizedKeyTR,NormalizedKeyTRF_K);	
	
  EXPORT keyFileTRDNF := NormalizedKeyTRF_K;
	
	//Attribute that refers to FCRA TMSID RMSID Main key file
	SHARED keyFileTRD_Base := LiensV2.key_liens_main_ID_FCRA;

		TRMOutputLayout normalizeKeyTransform2(keyFileTRD_Base l, unsigned c) := TRANSFORM
				self.filing_status := l.filing_status[c];
				self := l;
		END;	
	
	NormalizedKeyTR_F := NORMALIZE(keyFileTRD_Base,count(left.filing_status), normalizeKeyTransform2(left,counter));

	Ashirey.Flatten(NormalizedKeyTR_F,NormalizedKeyTRF_fcra);	
  
	EXPORT keyFileTRD := NormalizedKeyTRF_fcra;
	
	
	//Attribute that refers to SourceRecId key file
	EXPORT keyFilesrid := LiensV2.Key_liens_SourceRecId;

	//Attribute that refers to TMSID RMSID LINKSID key file
	EXPORT keyFilesTRL := LiensV2.Key_liens_party_ID_linkids;

	//Attribute that refers to NON FCRA TMSID RMSID Party key file
	EXPORT keyFilesTRPNF := LiensV2.Key_liens_party_ID;

	//Attribute that refers to FCRA TMSID RMSID Party key file
	EXPORT keyFilesTRP := LiensV2.key_liens_party_id_FCRA;	

	//Attribute that refers to FCRA TMSID RMSID Party key file
	EXPORT keyFilesLinksId := LiensV2.Key_LinkIds.Key;	
	
	//Attribute that refers to FCRA Autokey Payload
	keyFilesAutoKeyPayloadFCRA_Base := LiensV2.key_fcra_liens_autokeypayload;


	Ashirey.Flatten(keyFilesAutoKeyPayloadFCRA_Base,keyFilesAutoKeyPayloadFCRA_Flattened);	
	
			
	EXPORT keyFilesAutoKeyPayloadFCRA := KeyValidation.applyNormalize(keyFilesAutoKeyPayloadFCRA_Flattened,
																			['person_addr__zip5','person_addr__st','person_addr__prim_name','person_addr__prim_range','person_addr__sec_range'],
																			['if(c=1, l.person_addr__zip5,l.company_addr__zip5)', 
																			'if(c=1, l.person_addr__st,l.company_addr__st)',
																			'if(c=1, ut.stripOrdinal(l.person_addr__prim_name),ut.stripOrdinal(l.company_addr__prim_name))',
																			'if(c=1, TRIM(ut.CleanPrimRange(l.person_addr__prim_range),left), TRIM(ut.CleanPrimRange(l.company_addr__prim_range),left))',
																			'if(c=1, l.person_addr__sec_range,l.company_addr__sec_range)'],['qa_defined_empty'],2);

		//Attribute that refers to NFCRA Autokey Payload
	keyFilesAutoKeyPayloadNFCRA_Base := LiensV2.key_liens_AutokeyPayload;
	
	Ashirey.Flatten(keyFilesAutoKeyPayloadNFCRA_base,keyFilesAutoKeyPayloadNFCRA_Flattened);	
	
			
	EXPORT keyFilesAutoKeyPayloadNFCRA := KeyValidation.applyNormalize(keyFilesAutoKeyPayloadNFCRA_Flattened,
																			['person_addr__zip5','person_addr__st','person_addr__prim_name','person_addr__prim_range','person_addr__sec_range'],
																			['if(c=1, l.person_addr__zip5,l.company_addr__zip5)', 
																			'if(c=1, l.person_addr__st,l.company_addr__st)',
																			'if(c=1, ut.stripOrdinal(l.person_addr__prim_name),ut.stripOrdinal(l.company_addr__prim_name))',
																			'if(c=1, TRIM(ut.CleanPrimRange(l.person_addr__prim_range),left), TRIM(ut.CleanPrimRange(l.company_addr__prim_range),left))',
																			'if(c=1, l.person_addr__sec_range,l.company_addr__sec_range)'],['qa_defined_empty'],2);
	
	
	//Attribute that refers to NFCRA Zip Autokey key file
	EXPORT keyFile_AutoKeyZipNONFCRA := Autokey.Key_Zip(Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2_autokey');

	//Attribute that refers to FCRA Zip Autokey key file
	EXPORT keyFile_AutoKeyZipFCRA := Autokey.Key_Zip(Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2::fcra::qa::autokey_');
	
	//Attribute that refers to NON FCRA Zipb2 Autokey key file
  EXPORT keyFile_AutoKeyZipb2NONFCRA := Autokeyb2.Key_Zip(Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2_autokey');	
	
	//Attribute that refers to FCRA Zipb2 Autokey key file
	EXPORT keyFile_AutoKeyZipb2FCRA := Autokeyb2.Key_Zip(Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2::fcra::qa::autokey_');
	
	//Attribute that refers to NON FCRA Stname Autokey key file
  EXPORT keyFile_AutoKeyStnameNONFCRA := Autokey.Key_StName(Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2_autokey');	
	
	//Attribute that refers to FCRA Stname Autokey key file
	EXPORT keyFile_AutoKeyStnameFCRA := Autokey.Key_StName(Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2::fcra::qa::autokey_');

	//Attribute that refers to NON FCRA Stnameb2 Autokey key file
  EXPORT keyFile_AutoKeyStnameb2NONFCRA := Autokeyb2.Key_StName(Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2_autokey');	
	
	//Attribute that refers to FCRA Stnameb2 Autokey key file
	EXPORT keyFile_AutoKeyStnameb2FCRA := Autokeyb2.Key_StName(Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2::fcra::qa::autokey_');

	//Attribute that refers to NON FCRA SSN2 Autokey key file
  EXPORT keyFile_AutoKeySSN2NONFCRA := Autokey.Key_SSN2(Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2_autokey');	
	
	//Attribute that refers to FCRA SSN2 Autokey key file
	EXPORT keyFile_AutoKeySSN2FCRA := Autokey.Key_SSN2(Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2::fcra::qa::autokey_');

	//Attribute that refers to NON FCRA phone2 Autokey key file
  // EXPORT keyFile_AutoKeypho2NONFCRA := Autokey.Key_Phone2(Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2_autokey');	
	
	//Attribute that refers to FCRA phone2 Autokey key file
	// EXPORT keyFile_AutoKeypho2FCRA := Autokey.Key_Phone2(Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2::fcra::qa::autokey_');

	//Attribute that refers to NON FCRA phoneb2 Autokey key file
  // EXPORT keyFile_AutoKeyphob2NONFCRA := Autokeyb2.Key_Phone(Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2_autokey');	
	
	//Attribute that refers to FCRA phoneb2 Autokey key file
	// EXPORT keyFile_AutoKeyphob2FCRA := Autokeyb2.Key_Phone(Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2::fcra::qa::autokey_');

	//Attribute that refers to NON FCRA name Autokey key file
  EXPORT keyFile_AutoKeynmeNONFCRA := Autokey.Key_Name(Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2_autokey');	
	
	//Attribute that refers to FCRA name Autokey key file
	EXPORT keyFile_AutoKeynmeFCRA := Autokey.Key_Name(Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2::fcra::qa::autokey_');

	//Attribute that refers to NON FCRA nameb2 Autokey key file
  // EXPORT keyFile_AutoKeynmeb2NONFCRA := Autokeyb2.Key_Name(Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2_autokey');	
	
	//Attribute that refers to FCRA nameb2 Autokey key file
	// EXPORT keyFile_AutoKeynmeb2FCRA := Autokeyb2.Key_Name(Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2::fcra::qa::autokey_');
	
	//Attribute that refers to NON FCRA address Autokey key file
  EXPORT keyFile_AutoKeyaddressNONFCRA := Autokey.Key_Address(Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2_autokey');	
	
	//Attribute that refers to FCRA address Autokey key file
	EXPORT keyFile_AutoKeyaddressFCRA := Autokey.Key_Address(Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2::fcra::qa::autokey_');
	
	//Attribute that refers to NON FCRA addressb2 Autokey key file
  EXPORT keyFile_AutoKeyaddressb2NONFCRA := Autokeyb2.Key_Address(Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2_autokey');	
	
	//Attribute that refers to FCRA addressb2 Autokey key file
	EXPORT keyFile_AutoKeyaddressb2FCRA := Autokeyb2.Key_Address(Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2::fcra::qa::autokey_');
	
	//Attribute that refers to NON FCRA citystname Autokey key file
  EXPORT keyFile_AutoKeycitystatenameNONFCRA := Autokey.Key_CityStName(Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2_autokey');	
	
	//Attribute that refers to FCRA citystname Autokey key file
	EXPORT keyFile_AutoKeycitystnameFCRA := Autokey.Key_CityStName(Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2::fcra::qa::autokey_');
	
	//Attribute that refers to NON FCRA citystnameb2 Autokey key file
  EXPORT keyFile_AutoKeycitystatenameb2NONFCRA := Autokeyb2.Key_CityStName(Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2_autokey');	
	
	//Attribute that refers to FCRA citystnameb2 Autokey key file
	EXPORT keyFile_AutoKeycitystnameb2FCRA := Autokeyb2.Key_CityStName(Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2::fcra::qa::autokey_');
	
	//Attribute that refers to NON FCRA fein2 Autokey key file
  EXPORT keyFile_AutoKeyfeins2NONFCRA := Autokeyb2.Key_FEIN(Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2_autokey');	
	
	//Attribute that refers to FCRA fein2 Autokey key file
	EXPORT keyFile_AutoKeyfeins2FCRA := Autokeyb2.Key_FEIN(Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2::fcra::qa::autokey_');
	
	//Attribute that refers to NON FCRA namewords2 Autokey key file
  EXPORT keyFile_AutoKeynamewords2NONFCRA := Autokeyb2.Key_NameWords(Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2_autokey');	
	
	//Attribute that refers to FCRA fein2 namewords2 key file
	EXPORT keyFile_AutoKeynamewords2FCRA := Autokeyb2.Key_NameWords(Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2::fcra::qa::autokey_');

END;