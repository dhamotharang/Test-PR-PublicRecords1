#stored('did_add_force','thor');
import address, 
	   business_header_ss, 
	   business_header, 
	   did_add, 
		  _validate,
	   standard, ut, idl_header;

mac_get_taxonomy(RecType, Lfilein, Rfilein, Lfieldin, Lfieldout, outfile) := macro
#uniquename(trans)
RecType %Trans%(Lfilein L, Rfilein R) := transform
		self.Lfieldout := trimUpper(R.desc);
		self := L;
		self := [];
		end;

outFile := join(Lfilein,Rfilein,
				left.Lfieldin=right.code,
				%Trans%(left,right),lookup,left outer);
endmacro;

export Proc_Build_Base(string8 filedate) := function

trimUpper(string s) := function
			return trim(stringlib.StringToUppercase(s),left,right);
			end;  
		
		getIssuerDesc(string s) := function
			return case(trim(s,left,right),
     			   '01' => 'OTHER',
     			   '02' => 'MEDICARE UPIN',
				   '04' => 'MEDICARE ID-TYPE UNSPECIFIED',
				   '05' => 'MEDICAID',
				   '06' => 'MEDICARE OSCAR/CERTIFICATION',
				   '07' => 'MEDICARE NSC',
				   '08' => 'MEDICARE PIN',
				   '');
			end;   
		
dsNPPES	:= nppes.File_NPPES_in;

oldBase := nppes.File_NPPES_Base;

   //Get the Taxonomy Descriptions
   Layout_Taxonomies_Slim := RECORD
		 STRING10 code;
		 STRING   desc;
	 END;

	 Layout_Taxonomies_Slim convert_description(layouts.Input_Taxonomy L) := TRANSFORM
	   trimmed_classification := StringLib.StringToUpperCase(TRIM(L.classification, LEFT, RIGHT));
		 trimmed_specialization := StringLib.StringToUpperCase(TRIM(L.specialization, LEFT, RIGHT));

     SELF.code := StringLib.StringToUpperCase(L.taxonomy_code);  // Using utility, just in case.
		 SELF.desc := IF(trimmed_specialization != '',
		                 trimmed_classification + ' ' + trimmed_specialization,
										 trimmed_classification);
	 END;
		
   taxonomy_input_ds := DATASET('~thor_data400::in::nppes::taxonomy_codes',
	                                 layouts.Input_Taxonomy, CSV(HEADING(1), QUOTE('"')));

   taxonomy_codes := PROJECT(taxonomy_input_ds, convert_description(LEFT));
   
   mac_get_taxonomy(nppes.Layouts.base, dsNPPES,  taxonomy_codes, Healthcare_Provider_Taxonomy_Code_1, taxonomy_desc1, outfile1);				   
   mac_get_taxonomy(nppes.Layouts.base, outfile1, taxonomy_codes, Healthcare_Provider_Taxonomy_Code_2, taxonomy_desc2, outfile2);
   mac_get_taxonomy(nppes.Layouts.base, outfile2, taxonomy_codes, Healthcare_Provider_Taxonomy_Code_3, taxonomy_desc3, outfile3);
   mac_get_taxonomy(nppes.Layouts.base, outfile3, taxonomy_codes, Healthcare_Provider_Taxonomy_Code_4, taxonomy_desc4, outfile4);
   mac_get_taxonomy(nppes.Layouts.base, outfile4, taxonomy_codes, Healthcare_Provider_Taxonomy_Code_5, taxonomy_desc5, outfile5);
   mac_get_taxonomy(nppes.Layouts.base, outfile5, taxonomy_codes, Healthcare_Provider_Taxonomy_Code_6, taxonomy_desc6, outfile6);
   mac_get_taxonomy(nppes.Layouts.base, outfile6, taxonomy_codes, Healthcare_Provider_Taxonomy_Code_7, taxonomy_desc7, outfile7);
   mac_get_taxonomy(nppes.Layouts.base, outfile7, taxonomy_codes, Healthcare_Provider_Taxonomy_Code_8, taxonomy_desc8, outfile8);
   mac_get_taxonomy(nppes.Layouts.base, outfile8, taxonomy_codes, Healthcare_Provider_Taxonomy_Code_9, taxonomy_desc9, outfile9);
   mac_get_taxonomy(nppes.Layouts.base, outfile9, taxonomy_codes, Healthcare_Provider_Taxonomy_Code_10, taxonomy_desc10, outfile10);
   mac_get_taxonomy(nppes.Layouts.base, outfile10, taxonomy_codes, Healthcare_Provider_Taxonomy_Code_11, taxonomy_desc11, outfile11);
   mac_get_taxonomy(nppes.Layouts.base, outfile11, taxonomy_codes, Healthcare_Provider_Taxonomy_Code_12, taxonomy_desc12, outfile12);
   mac_get_taxonomy(nppes.Layouts.base, outfile12, taxonomy_codes, Healthcare_Provider_Taxonomy_Code_13, taxonomy_desc13, outfile13);
   mac_get_taxonomy(nppes.Layouts.base, outfile13, taxonomy_codes, Healthcare_Provider_Taxonomy_Code_14, taxonomy_desc14, outfile14);
   mac_get_taxonomy(nppes.Layouts.base, outfile14, taxonomy_codes, Healthcare_Provider_Taxonomy_Code_15, taxonomy_desc15, outfile15);

   // We want to always make sure the taxonomy description is up-to-date, so apply the same logic
	 // to the "old base" file.
   mac_get_taxonomy(nppes.Layouts.base, oldBase,  taxonomy_codes, Healthcare_Provider_Taxonomy_Code_1, taxonomy_desc1, oldBase_outfile1);				   
   mac_get_taxonomy(nppes.Layouts.base, oldBase_outfile1, taxonomy_codes, Healthcare_Provider_Taxonomy_Code_2, taxonomy_desc2, oldBase_outfile2);
   mac_get_taxonomy(nppes.Layouts.base, oldBase_outfile2, taxonomy_codes, Healthcare_Provider_Taxonomy_Code_3, taxonomy_desc3, oldBase_outfile3);
   mac_get_taxonomy(nppes.Layouts.base, oldBase_outfile3, taxonomy_codes, Healthcare_Provider_Taxonomy_Code_4, taxonomy_desc4, oldBase_outfile4);
   mac_get_taxonomy(nppes.Layouts.base, oldBase_outfile4, taxonomy_codes, Healthcare_Provider_Taxonomy_Code_5, taxonomy_desc5, oldBase_outfile5);
   mac_get_taxonomy(nppes.Layouts.base, oldBase_outfile5, taxonomy_codes, Healthcare_Provider_Taxonomy_Code_6, taxonomy_desc6, oldBase_outfile6);
   mac_get_taxonomy(nppes.Layouts.base, oldBase_outfile6, taxonomy_codes, Healthcare_Provider_Taxonomy_Code_7, taxonomy_desc7, oldBase_outfile7);
   mac_get_taxonomy(nppes.Layouts.base, oldBase_outfile7, taxonomy_codes, Healthcare_Provider_Taxonomy_Code_8, taxonomy_desc8, oldBase_outfile8);
   mac_get_taxonomy(nppes.Layouts.base, oldBase_outfile8, taxonomy_codes, Healthcare_Provider_Taxonomy_Code_9, taxonomy_desc9, oldBase_outfile9);
   mac_get_taxonomy(nppes.Layouts.base, oldBase_outfile9, taxonomy_codes, Healthcare_Provider_Taxonomy_Code_10, taxonomy_desc10, oldBase_outfile10);
   mac_get_taxonomy(nppes.Layouts.base, oldBase_outfile10, taxonomy_codes, Healthcare_Provider_Taxonomy_Code_11, taxonomy_desc11, oldBase_outfile11);
   mac_get_taxonomy(nppes.Layouts.base, oldBase_outfile11, taxonomy_codes, Healthcare_Provider_Taxonomy_Code_12, taxonomy_desc12, oldBase_outfile12);
   mac_get_taxonomy(nppes.Layouts.base, oldBase_outfile12, taxonomy_codes, Healthcare_Provider_Taxonomy_Code_13, taxonomy_desc13, oldBase_outfile13);
   mac_get_taxonomy(nppes.Layouts.base, oldBase_outfile13, taxonomy_codes, Healthcare_Provider_Taxonomy_Code_14, taxonomy_desc14, oldBase_outfile14);
   mac_get_taxonomy(nppes.Layouts.base, oldBase_outfile14, taxonomy_codes, Healthcare_Provider_Taxonomy_Code_15, taxonomy_desc15, oldBase_outfile15);

nppes.Layouts.base   buildBase(outfile15 L) := transform, skip (length(trim(regexreplace('[^0-9]',l.npi,'')))<10)
	self.process_date := fileDate;
	self.dt_first_seen := (unsigned4)fileDate; 
	self.dt_last_seen := (unsigned4)fileDate;
	self.dt_vendor_first_reported := (unsigned4)fileDate;
	self.dt_vendor_last_reported := (unsigned4)fileDate;
   fullProvider					:=	trimUpper(trim(l.provider_name_prefix_text,left,right) + ' ' +
																  trim(l.provider_first_name,left,right) + ' ' + 
																  trim(l.provider_middle_name,left,right) + ' ' + 
																  trim(l.provider_last_name,left,right) + ' ' +
																  trim(l.provider_name_suffix_text,left,right));
																								
	fullOther    					:=	trimUpper(trim(l.provider_other_name_prefix_text,left,right) + ' ' +
													  trim(l.provider_other_first_name,left,right) + ' ' + 
													  trim(l.provider_other_middle_name,left,right) + ' ' + 
													  trim(l.provider_other_last_name,left,right) + ' ' +
													  trim(l.provider_other_name_suffix_text,left,right));																							

	fullOfficial					:=	trimUpper(trim(l.authorized_official_name_prefix,left,right) + ' ' +
													  trim(l.authorized_official_first_name,left,right) + ' ' + 
													  trim(l.authorized_official_middle_name,left,right) + ' ' + 
													  trim(l.authorized_official_last_name,left,right) + ' ' +
													  trim(l.authorized_official_name_suffix,left,right));		
		
		self.clean_name_provider 					:= Address.CleanPersonFML73_fields(fullProvider).CleanNameRecord;
		self.clean_name_provider_other 				:= Address.CleanPersonFML73_fields(fullOther).CleanNameRecord;
		self.clean_name_authorized_official   		:= Address.CleanPersonFML73_fields(fullOfficial).CleanNameRecord;	
		
		self.cleanMailingPhone						:= 	ut.CleanPhone(trim(l.Provider_Business_Mailing_Address_Telephone_Number));			
		self.cleanLocationPhone						:=  ut.CleanPhone(trim(l.Provider_Business_Practice_Location_Address_Telephone_Number));				
		self.entity_type_desc						:= case(l.entity_type_code,
															'1' => 'INDIVIDUAL',
															'2' => 'ORGANIZATION',
															'');
		self.deactivation_reason_desc				:= case(l.npi_deactivation_reason_code,
															'DT' => 'DEATH',
															'DB' => 'DISBANDMENT',
															'FR' => 'FRAUD',
															'OT' => 'OTHER',
															'');
		self.organization_name_type_desc   			:= case(l.provider_other_organization_name_type_code,
															'3' => 'DOING BUSINESS AS',
															'4' => 'FORMER LEGAL BUSINESS NAME',
															'5' => 'OTHER NAME',									
															'');
		self.last_name_type_desc   					:= case(l.provider_other_last_name_type_code,
															'1' => 'FORMER NAME',
															'2' => 'PROFESSIONAL NAME',
															'5' => 'OTHER NAME',									
															'');
		self.mailing_country_desc					:= ut.Country_ISO2_To_Name(l.provider_business_mailing_address_country_code);
		self.practice_location_country_desc			:= ut.Country_ISO2_To_Name(l.Provider_Business_Practice_Location_Address_Country_Code);
		self.other_pid_issuer_desc_1                := getIssuerDesc(l.other_provider_identifier_type_code_1);
		self.other_pid_issuer_desc_2                := getIssuerDesc(l.other_provider_identifier_type_code_2);
		self.other_pid_issuer_desc_3                := getIssuerDesc(l.other_provider_identifier_type_code_3);
		self.other_pid_issuer_desc_4                := getIssuerDesc(l.other_provider_identifier_type_code_4);
		self.other_pid_issuer_desc_5                := getIssuerDesc(l.other_provider_identifier_type_code_5);
		self.other_pid_issuer_desc_6                := getIssuerDesc(l.other_provider_identifier_type_code_6);
		self.other_pid_issuer_desc_7                := getIssuerDesc(l.other_provider_identifier_type_code_7);
		self.other_pid_issuer_desc_8                := getIssuerDesc(l.other_provider_identifier_type_code_8);
		self.other_pid_issuer_desc_9                := getIssuerDesc(l.other_provider_identifier_type_code_9);
		self.other_pid_issuer_desc_10               := getIssuerDesc(l.other_provider_identifier_type_code_10);
		self.other_pid_issuer_desc_11               := getIssuerDesc(l.other_provider_identifier_type_code_11);
		self.other_pid_issuer_desc_12               := getIssuerDesc(l.other_provider_identifier_type_code_12);
		self.other_pid_issuer_desc_13               := getIssuerDesc(l.other_provider_identifier_type_code_13);
		self.other_pid_issuer_desc_14               := getIssuerDesc(l.other_provider_identifier_type_code_14);
		self.other_pid_issuer_desc_15               := getIssuerDesc(l.other_provider_identifier_type_code_15);
		self.other_pid_issuer_desc_16               := getIssuerDesc(l.other_provider_identifier_type_code_16);
		self.other_pid_issuer_desc_17               := getIssuerDesc(l.other_provider_identifier_type_code_17);
		self.other_pid_issuer_desc_18               := getIssuerDesc(l.other_provider_identifier_type_code_18);
		self.other_pid_issuer_desc_19               := getIssuerDesc(l.other_provider_identifier_type_code_19);
		self.other_pid_issuer_desc_20               := getIssuerDesc(l.other_provider_identifier_type_code_20);
		self.other_pid_issuer_desc_21               := getIssuerDesc(l.other_provider_identifier_type_code_21);
		self.other_pid_issuer_desc_22               := getIssuerDesc(l.other_provider_identifier_type_code_22);
		self.other_pid_issuer_desc_23               := getIssuerDesc(l.other_provider_identifier_type_code_23);
		self.other_pid_issuer_desc_24               := getIssuerDesc(l.other_provider_identifier_type_code_24);
		self.other_pid_issuer_desc_25               := getIssuerDesc(l.other_provider_identifier_type_code_25);
		self.other_pid_issuer_desc_26               := getIssuerDesc(l.other_provider_identifier_type_code_26);
		self.other_pid_issuer_desc_27               := getIssuerDesc(l.other_provider_identifier_type_code_27);
		self.other_pid_issuer_desc_28               := getIssuerDesc(l.other_provider_identifier_type_code_28);
		self.other_pid_issuer_desc_29               := getIssuerDesc(l.other_provider_identifier_type_code_29);
		self.other_pid_issuer_desc_30               := getIssuerDesc(l.other_provider_identifier_type_code_30);
		self.other_pid_issuer_desc_31               := getIssuerDesc(l.other_provider_identifier_type_code_31);
		self.other_pid_issuer_desc_32               := getIssuerDesc(l.other_provider_identifier_type_code_32);
		self.other_pid_issuer_desc_33               := getIssuerDesc(l.other_provider_identifier_type_code_33);
		self.other_pid_issuer_desc_34               := getIssuerDesc(l.other_provider_identifier_type_code_34);
		self.other_pid_issuer_desc_35               := getIssuerDesc(l.other_provider_identifier_type_code_35);
		self.other_pid_issuer_desc_36               := getIssuerDesc(l.other_provider_identifier_type_code_36);
		self.other_pid_issuer_desc_37               := getIssuerDesc(l.other_provider_identifier_type_code_37);
		self.other_pid_issuer_desc_38               := getIssuerDesc(l.other_provider_identifier_type_code_38);
		self.other_pid_issuer_desc_39               := getIssuerDesc(l.other_provider_identifier_type_code_39);
		self.other_pid_issuer_desc_40               := getIssuerDesc(l.other_provider_identifier_type_code_40);
		self.other_pid_issuer_desc_41               := getIssuerDesc(l.other_provider_identifier_type_code_41);
		self.other_pid_issuer_desc_42               := getIssuerDesc(l.other_provider_identifier_type_code_42);
		self.other_pid_issuer_desc_43               := getIssuerDesc(l.other_provider_identifier_type_code_43);
		self.other_pid_issuer_desc_44               := getIssuerDesc(l.other_provider_identifier_type_code_44);
		self.other_pid_issuer_desc_45               := getIssuerDesc(l.other_provider_identifier_type_code_45);
		self.other_pid_issuer_desc_46               := getIssuerDesc(l.other_provider_identifier_type_code_46);
		self.other_pid_issuer_desc_47               := getIssuerDesc(l.other_provider_identifier_type_code_47);
		self.other_pid_issuer_desc_48               := getIssuerDesc(l.other_provider_identifier_type_code_48);
		self.other_pid_issuer_desc_49               := getIssuerDesc(l.other_provider_identifier_type_code_49);
		self.other_pid_issuer_desc_50               := getIssuerDesc(l.other_provider_identifier_type_code_50);
		
		
		
   self.RawAID_Mailing 				 := 0;
   self.AceAID_Mailing 				 := 0;
   self.Mailing_Prep_Address1	 := StringLib.StringCleanSpaces(
											  trimUpper(l.provider_first_line_business_mailing_address) + ' ' +
											  trimUpper(l.provider_second_line_business_mailing_address));
											  
   self.Mailing_Prep_AddressLast  := StringLib.StringCleanSpaces(
											  Address.Addr2FromComponents(
											  trimUpper(l.provider_business_mailing_address_city_name),
											  trimUpper(l.provider_business_mailing_address_state_name),
											  trimUpper(l.provider_business_mailing_address_postal_code[1..5])));											 
	self.RawAID_Location 			 := 0;   
	self.AceAID_Location 			 := 0;   
	self.Location_Prep_Address1	 := StringLib.StringCleanSpaces(
											  trimUpper(l.provider_first_line_business_practice_location_address) + ' ' +
											  trimUpper(l.provider_second_line_business_practice_location_address));
   
	self.Location_Prep_AddressLast  :=  StringLib.StringCleanSpaces(
											  Address.Addr2FromComponents(
											  trimUpper(l.provider_business_practice_location_address_city_name),
											  trimUpper(l.provider_business_practice_location_address_state_name),
											  trimUpper(l.provider_business_practice_location_address_postal_code[1..5])));
   string8 temp_Provider_Enumeration_Date  	:= trim(StringLib.StringFilterOut(l.Provider_Enumeration_Date,'.-/'));
   string8 temp_Last_Update_Date  					:= trim(StringLib.StringFilterOut(l.Last_Update_Date,'.-/'));
   string8 temp_NPI_Deactivation_Date  			:= trim(StringLib.StringFilterOut(l.NPI_Deactivation_Date,'.-/'));
   string8 temp_NPI_Reactivation_Date  			:= trim(StringLib.StringFilterOut(l.NPI_Reactivation_Date,'.-/'));
 	 
	 self.Provider_Enumeration_Date		:=	if (not _validate.date.fIsValid(temp_Provider_Enumeration_Date) and temp_Provider_Enumeration_Date != '',
																							if (_validate.date.fIsValid(temp_Provider_Enumeration_Date[5..8] + temp_Provider_Enumeration_Date[1..2] + temp_Provider_Enumeration_Date[3..4]),
																										temp_Provider_Enumeration_Date[5..8] + temp_Provider_Enumeration_Date[1..2] + temp_Provider_Enumeration_Date[3..4],
																										''
																									),
																							temp_Provider_Enumeration_Date
																						);
	 self.Last_Update_Date						:=	if (not _validate.date.fIsValid(temp_Last_Update_Date) and temp_Last_Update_Date != '',
																							if (_validate.date.fIsValid(temp_Last_Update_Date[5..8] + temp_Last_Update_Date[1..2] + temp_Last_Update_Date[3..4]),
																										temp_Last_Update_Date[5..8] + temp_Last_Update_Date[1..2] + temp_Last_Update_Date[3..4],
																										''
																									),
																							temp_Last_Update_Date
																						);
	 self.NPI_Deactivation_Date				:=	if (not _validate.date.fIsValid(temp_NPI_Deactivation_Date) and temp_NPI_Deactivation_Date != '',
																							if (_validate.date.fIsValid(temp_NPI_Deactivation_Date[5..8] + temp_NPI_Deactivation_Date[1..2] + temp_NPI_Deactivation_Date[3..4]),
																										temp_NPI_Deactivation_Date[5..8] + temp_NPI_Deactivation_Date[1..2] + temp_NPI_Deactivation_Date[3..4],
																										'0'
																									),
																							if(temp_NPI_Deactivation_Date = '', '0', temp_NPI_Deactivation_Date)
																						);
	 self.NPI_Reactivation_Date				:=	if (not _validate.date.fIsValid(temp_NPI_Reactivation_Date) and temp_NPI_Reactivation_Date != '',
																							if (_validate.date.fIsValid(temp_NPI_Reactivation_Date[5..8] + temp_NPI_Reactivation_Date[1..2] + temp_NPI_Reactivation_Date[3..4]),
																										temp_NPI_Reactivation_Date[5..8] + temp_NPI_Reactivation_Date[1..2] + temp_NPI_Reactivation_Date[3..4],
																										'0'
																									),
																							if(temp_NPI_Reactivation_Date = '', '0', temp_NPI_Reactivation_Date)
																						);		 
	 self := L;

end;
   
   preBase	:= project(outfile15,buildBase(left));

	// ------------Apply Name Flipping Macro--------------------				
	ut.mac_flipnames(preBase,clean_name_provider.fname,clean_name_provider.mname,clean_name_provider.lname,preBase2);
	ut.mac_flipnames(preBase2,clean_name_provider_other.fname,clean_name_provider_other.mname,clean_name_provider_other.lname,preBase3);
	ut.mac_flipnames(preBase3,clean_name_authorized_official.fname,clean_name_authorized_official.mname,clean_name_authorized_official.lname,newBase);
   
	// Remove unwanted text from EIN attribute.
	nppes.Layouts.base clean_EIN(nppes.Layouts.base L) := TRANSFORM
	  SELF.Employer_Identification_Number :=
		  IF(ut.CleanSpacesAndUpper(L.Employer_Identification_Number) = '<UNAVAIL>',
			   '',
				 L.Employer_Identification_Number);

	  SELF := L;
	END;

 	AppendFile := PROJECT(newBase + oldBase_outfile15, clean_EIN(LEFT));
  npi_dist := DISTRIBUTE(AppendFile, HASH(npi));  

  npi_dist_sort := SORT(npi_dist,
	                      EXCEPT did, did_score, bdid, bdid_score, dt_first_seen, dt_last_seen,
                           dt_vendor_first_reported, dt_vendor_last_reported, process_date,
													 clean_name_provider.name_score, clean_name_provider_other.name_score,
													 clean_name_authorized_official.name_score, RawAID_Mailing, AceAID_Mailing,
													 RawAID_Location, AceAID_Location,
													 xadl2_weight, xadl2_score, xadl2_distance, xadl2_keys_used, xadl2_keys_desc,  //HC-1224	
													 xadl2_matches, xadl2_matches_desc,
												LOCAL);

	nppes.Layouts.base rollupBase(nppes.Layouts.base L, nppes.Layouts.base R) := TRANSFORM
		SELF.dt_first_seen						:= ut.EarliestDate(ut.EarliestDate(L.dt_first_seen, R.dt_first_seen),
																										 ut.EarliestDate(L.dt_last_seen, R.dt_last_seen));
		SELF.dt_last_seen							:= MAX(L.dt_last_seen, R.dt_last_seen);
		SELF.dt_vendor_last_reported	:= MAX(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
		SELF.dt_vendor_first_reported	:= ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
		SELF.process_date				      := IF(L.process_date > r.process_date, L.process_date, R.process_date);
		SELF.source_rec_id            := IF(L.source_rec_id = 0, R.source_rec_id, L.source_rec_id);
		
		SELF := L;		
	END;

  // (bug 164152) Had to add lnpid to the EXCEPT portion, so that the ROLLUP would work correctly.
	// This was because lnpid is not calculated until later in this program, so an input record would
	// have a 0 and the base record would not (if an lnpid was found).  In the future, if there's a
	// field added that's sorted above, but not calculated/determined until later... you'll need to
	// probably add it to the EXCEPT below to keep the records collapsing correctly.
  prebase_rolledup := ROLLUP(npi_dist_sort, rollupBase(LEFT, RIGHT),
																 EXCEPT did, did_score, bdid, bdid_score, dt_first_seen, dt_last_seen,
																		dt_vendor_first_reported, dt_vendor_last_reported, process_date,
																		clean_name_provider.name_score, clean_name_provider_other.name_score,
																		clean_name_authorized_official.name_score, RawAID_Mailing, AceAID_Mailing,
																		RawAID_Location, AceAID_Location, source_rec_id, lnpid,
																		xadl2_weight, xadl2_score, xadl2_distance, xadl2_keys_used, xadl2_keys_desc, 
																		xadl2_matches, xadl2_matches_desc,																		
																 LOCAL);

  nppes.Layouts.base doiterate(nppes.Layouts.base L, nppes.Layouts.base R) := TRANSFORM
            		SELF.NPI_Reactivation_Date    := if(l.NPI=R.NPI,(string) MAX((integer) L.NPI_Reactivation_Date, (integer) R.NPI_Reactivation_Date),R.NPI_Reactivation_Date);
   						  SELF.NPI_Deactivation_Date    := if(l.NPI=R.NPI,(string) MAX((integer) L.NPI_Deactivation_Date, (integer) R.NPI_Deactivation_Date),R.NPI_Deactivation_Date);
            		SELF := R;
            	END;
 
  sync_dates := Iterate(sort(prebase_rolledup,NPI,local), doiterate(LEFT, RIGHT)
            										 ,local);

	ut.MAC_Append_Rcid (sync_dates, source_rec_id, addSourceRid);
   
	return addSourceRid;

end;