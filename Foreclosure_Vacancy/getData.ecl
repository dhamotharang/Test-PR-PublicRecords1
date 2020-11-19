/*2010-09-09T20:45:34Z (Adam Shirey)
Returning iesp.intermediate_log.t_IntermediateLogRecord for customer support tool
*/
import address, ut, Risk_Indicators, ADVO, AddrFraud, dx_Property, iesp, models, std, MDR, Foreclosure_Services, foreclosure_vacancy;
 
//Data sources
export getData(DATASET(Foreclosure_Vacancy.Layouts.in_data) indata = DATASET([],Foreclosure_Vacancy.Layouts.in_data), boolean isRenewal = FALSE) := MODULE

	//Clean Addresses
	foreclosure_vacancy.layouts.in_clean AddressClean(indata l) := TRANSFORM
		//echo input
		self.UniqueID_in       := l.UniqueID;
		tempname               := std.str.filterout(l.last_name, ' ');
		clean_last             := address.CleanPersonLFM73(tempname);
		self.first_name_in     := l.first_name;
		self.middle_initial_in := l.middle_initial;
		self.last_name_in      := trim(clean_last[46..65], all);
		street_add             := l.street_address + ' ' + l.apt;
		self.street_address_in := street_add;
		self.apt_in            := l.apt;
		self.city_in           := l.city;
		self.state_in          := l.state;
		self.zip_in            := l.zip;
		self.zip4_in           := l.zip4;
		clean_address          := Risk_Indicators.MOD_AddressClean.clean_addr(street_add, l.city, l.state, l.zip);
		self.prim_range        := clean_address [1..10];
		self.predir            := clean_address [11..12];
		self.prim_name         := clean_address [13..40];
		self.suffix            := clean_address [41..44];
		self.postdir           := clean_address [45..46];
		self.unit_desig        := clean_address [47..56];
		self.sec_range         := clean_address [57..65];
		self.p_city_name       := clean_address [90..114];
		self.st                := clean_address [115..116];
		self.zip               := clean_address [117..121];
		self.zip4              := clean_address[122..125];
		self.county            := clean_address[143..145];
		self.geo_lat           := clean_address[146..155];
		self.geo_long          := clean_address[156..166];
		self.msa               := clean_address[167..170];
		self.geo_blk           := clean_address[171..177];
		self.geo_match         := clean_address[178];
		self.DMS_lat           := AddrFraud.functions.DectoDMS(clean_address[146..155]);
		self.DMS_long          := AddrFraud.functions.DectoDMS(clean_address[156..166]);
		//build geolink for AddrRisk
		self.geolink           := clean_address[115..116]+clean_address[143..145]+clean_address[171..177];
		self                   := [];
	end;

	export Cleaned := project(indata, AddressClean(Left));

	//Get ADVO data
	foreclosure_vacancy.layouts.ADVO_full addADVOFull(Cleaned l, ADVO.Key_Addr1 r) := transform
		self.UniqueID := l.UniqueID_in;
		self := r;
		self := [];
	end;

	export base_ADVO_Full := join(Cleaned, ADVO.Key_Addr1,
		left.zip !='' and left.prim_name !='' and left.prim_range != '' and
		keyed(left.zip = right.zip) and
		keyed(left.prim_range = right.prim_range) and
		keyed(left.prim_name = right.prim_name) and
		keyed(left.suffix = right.addr_suffix) and
		keyed(left.predir = right.predir) and
		keyed(left.postdir = right.postdir) and
		keyed(left.sec_range = right.sec_range),
		addADVOFull(left, right),Left Outer,
			atmost(50),keep(1));
	
	foreclosure_vacancy.layouts.ADVO addADVO(Cleaned l, base_ADVO_Full r) := transform
		self.UniqueID := l.UniqueID_in;
		self.Potentially_Vacant := if(r.Address_Vacancy_Indicator='', 'N', r.Address_Vacancy_Indicator);		
		self.Vacancy_First_Seen := if(r.Address_Vacancy_Indicator='Y', r.vac_begdt, '');
		self.Vacancy_count := r.vac_count;
		self.Vacancy_current_duration := (string)((integer)r.months_vac_curr * 30);
		self.Vacancy_max_duration := (string)((integer)r.months_vac_max * 30);
		self := l;
		self := [];
	end;

	export base_ADVO := join(Cleaned, base_ADVO_Full,
		left.UniqueID_in !='' and right.UniqueID !='' and
		left.UniqueID_in = right.UniqueID,
		addADVO(left, right),Left Outer,
			keep(1));

	SHARED MAC_PREFILL_DATA := MACRO
		//Calculate prefill data
		tmp_data_date := if(r.filing_date >= r.recording_date, r.filing_date, r.recording_date);
		
		//Calculate fields per depricated ChoicePoint FC process see Mark McLean for details
		self.CP_DATA_DATE            := tmp_data_date;//Derived newest of filing_date and record_date 
		self.source           							:= if(r.source=MDR.sourceTools.src_Foreclosures, Foreclosure_services.Constants('').src_Fares, 
																																																																																					Foreclosure_services.Constants('').src_BlackKnight);																																																																																	 
		self.LENDER_TYPE := r.lender_type;
		self.LENDER_TYPE_DESC := r.lender_type_desc;
		self.LOAN_AMOUNT := r.loan_amount;
		self.LOAN_TYPE := r.loan_type;
		self.LOAN_TYPE_DESC := r.loan_type_desc;		
		self.DEED_EVENT_TYPE_CD      := r.deed_category;
		self.DEED_EVENT_TYPE_DESC    := r.deed_desc;
		self.DOC_TYPE_CD             := if( isRenewal, r.document_type, '' );
		self.DOC_TYPE_DESC           := if( isRenewal, r.document_desc, '' );
		self.CP_SALE_AMT             := if( isRenewal, r.sales_price, '' );
		self.CP_DFLT_AMT             := if( isRenewal, r.amount_of_default, '' );
		self.CP_DFLT_DT              := if( isRenewal, r.date_of_default, '' ); 
		self.CP_AUCTION_DT           := if( isRenewal, r.auction_date, '' ); 
		self.LNDR_CMPNY_NAME         := if( isRenewal, r.lender_beneficiary_company_name, '' );
		self.PROPERTY_TYPE_CD        := if( isRenewal, r.property_indicator, '' );
		self.PROPERTY_TYPE_DESC      := if( isRenewal, r.property_desc, '' );
		self.CP_FILING_DT            := if( isRenewal, r.filing_date, '' ); 
		self.CP_RECORDING_DT         := if( isRenewal, r.recording_date, '' ); 
		self.SUBDV_NAME              := if( isRenewal, r.tract_subdivision_name, '' );
		self.COURT_CASE_NBR          := if( isRenewal, r.court_case_nbr, '' );
		self.PLNTFF1_NAME            := if( isRenewal, r.plaintiff_1, '' );
		self.PLNTFF2_NAME            := if( isRenewal, r.plaintiff_2, '' );
		self.TRUSTEE_NAME            := if( isRenewal, r.trustee_name, '' );
		self.TRUSTEE_ADDR            := if( isRenewal, r.trustee_mailing_address, '' );
		self.TRUSTEE_CITY            := if( isRenewal, r.trustee_city, '' );
		self.TRUSTEE_STATE           := if( isRenewal, r.trustee_state, '' );
		self.TRUSTEE_ZIPCD           := if( isRenewal, r.trustee_zip, '' );
		self.TRUSTEE_PHONE_NBR       := if( isRenewal, r.trustee_phone, '' );
		self.ORIG_LOAN_DT            := if( isRenewal, r.original_loan_date, '' );
		self.ORIG_LOAN_RECORDING_DT  := if( isRenewal, r.original_loan_recording_date, '' );
		self.LAST_FULLSALE_TRNSFR_DT := if( isRenewal, r.last_full_sale_transfer_date, '' );
		self.EXPAND_LEGAL_DESC       := if( isRenewal, r.expanded_legal, '' );
		self.LEGAL_DESC_2            := if( isRenewal, r.legal_2, '' );
		self.LEGAL_DESC_3            := if( isRenewal, r.legal_3, '' );
		self.LEGAL_DESC_4            := if( isRenewal, r.legal_4, '' );
		self.OWNR_1_CMPNY_NAME       := if( isRenewal, r.first_defendant_borrower_company_name, '' );
		self.OWNR_3_FIRST_NAME       := if( isRenewal, r.third_defendant_borrower_owner_first_name, '' );
		self.OWNR_3_LAST_NAME        := if( isRenewal, r.third_defendant_borrower_owner_last_name, '' );
		self.OWNR_4_FIRST_NAME       := if( isRenewal, r.fourth_defendant_borrower_owner_first_name, '' );
		self.OWNR_4_LAST_NAME        := if( isRenewal, r.fourth_defendant_borrower_owner_last_name, '' );


		
		//Calculate owner names when the deed type is a U and Company name is not blank and Owner Name is blank
		plaintiff := if(trim(r.plaintiff_2)!='', r.plaintiff_2, r.plaintiff_1);
		
		OwnerFirst1 := trim(models.common.getw(trim(models.common.getw(plaintiff,1,'&')),2,' '));
		OwnerLast1  := trim(models.common.getw(trim(models.common.getw(plaintiff,1,'&')),1,' '));
		OwnerFirst2 := trim(models.common.getw(trim(models.common.getw(plaintiff,2,'&')),1,' '));
		
		self.OWNR_1_FIRST_NAME := if( isRenewal, if(r.name1_first ='' and r.deed_category = 'U' and r.first_defendant_borrower_company_name != '', OwnerFirst1, r.name1_first), '' );
		self.OWNR_1_LAST_NAME  := if( isRenewal, if(r.name1_last  ='' and r.deed_category = 'U' and r.first_defendant_borrower_company_name != '', OwnerLast1, r.name1_last), '' );
		self.OWNR_2_FIRST_NAME := if( isRenewal, if(OwnerFirst2 !='' and r.name2_first ='' and r.deed_category = 'U' and r.first_defendant_borrower_company_name != '', OwnerFirst2, r.name2_first), '' );
		self.OWNR_2_LAST_NAME  := if( isRenewal, if(OwnerFirst2 !='' and r.name2_last  ='' and r.deed_category = 'U' and r.first_defendant_borrower_company_name != '', OwnerLast1, r.name2_last), '' );
			
			//Prefill Owner Type
		owner_type_calc := 	if(trim(r.name1_last) <> '' and r.deed_category IN ['F','L','N','R'], 'FO', 
												if(trim(r.name1_last) <> '' and r.deed_category IN ['G','U','T'], 'SO',
												if(plaintiff <> '' and r.deed_category IN ['U'], 'FO', 
												'UK')));
		self.OWNER_TYPE := owner_type_calc;
		
	ENDMACRO;

	Foreclosure_Vacancy.layouts.Foreclosure addAddrOnlyForeclosures(Cleaned l, dx_Property.Key_Foreclosures_Addr r) := TRANSFORM
		self.fc_unique_ID := l.UniqueID_in;
		MAC_PREFILL_DATA();
		self := r;
		self := l;
		self := [];
	end;

	EXPORT fn_Find_Foreclosure_By_Addr(DATASET(foreclosure_vacancy.layouts.in_clean) clnd, DATASET(RECORDOF(dx_Property.Key_Foreclosures_Addr)) keyfile, boolean includeBlackKnight=false) :=
		FUNCTION
			clnd_filtered := clnd(zip != '' and prim_range != '' and prim_name != '');
			foreclosure_recs := 
				join(clnd_filtered, keyfile, 
					keyed(left.zip = right.situs1_zip) and
					keyed(left.prim_range = right.situs1_prim_range) and
					keyed(left.prim_name = right.situs1_prim_name) and
					keyed(left.suffix = right.situs1_addr_suffix) and
					left.sec_range = right.situs1_sec_range and
					if (includeBlackKnight, true, right.source=MDR.sourceTools.src_Foreclosures),
					addAddrOnlyForeclosures(left, right),Left Outer,atmost(100), keep(50));	
					
			RETURN foreclosure_recs;
		END;
		
	EXPORT fn_Find_Foreclosure_By_Did(DATASET(Foreclosure_Services.Layouts.layout_batch_in) ds_batch_in,
		BOOLEAN includeBlackKnight=FALSE) := FUNCTION

		acctno_did:=PROJECT(ds_batch_in(uniqueID!=''),TRANSFORM({STRING30 acctno,UNSIGNED did},
			SELF.acctno:=LEFT.acctno,SELF.did:=(UNSIGNED)LEFT.uniqueid));

		// foreclosure fids
		ds_FOR_fids:=JOIN(acctno_did,dx_Property.Key_Foreclosure_DID,
			KEYED(LEFT.did=RIGHT.did),LIMIT(ut.limits.Foreclosure_PER_DID,SKIP));

		// forclosure payload
		ds_FOR_recs:=JOIN(ds_FOR_fids, dx_Property.Key_Foreclosures_FID,
			KEYED(LEFT.fid=RIGHT.fid) AND
			IF(includeBlackKnight,TRUE,RIGHT.source=MDR.sourceTools.src_Foreclosures),
			LIMIT(ut.limits.Foreclosure_MAX,SKIP));

		// notice of default fids
		ds_NOD_fids:=JOIN(acctno_did,dx_Property.Key_NOD_DID,
			KEYED(LEFT.did=RIGHT.did),LIMIT(ut.limits.Foreclosure_PER_DID,SKIP));

		// notice of default payload
		ds_NOD_recs:=JOIN(ds_NOD_fids, dx_Property.Key_NOD_FID,
			KEYED(LEFT.fid=RIGHT.fid) AND
			IF(includeBlackKnight,TRUE,RIGHT.source=MDR.sourceTools.src_Foreclosures),
			LIMIT(ut.limits.Foreclosure_MAX,SKIP));

		// foreclosure and notice of default payloads have same layout
		Foreclosure_Vacancy.layouts.Foreclosure formatOutput(RECORDOF(ds_NOD_recs) R) := TRANSFORM
			SELF.fc_unique_id := r.acctno; // used to join recs back to batch input
			MAC_PREFILL_DATA();
			SELF := R;
			SELF := [];
		END;

		RETURN PROJECT(ds_FOR_recs+ds_NOD_recs,formatOutput(LEFT));
	END;

	export Find_Foreclosure_By_Addr := fn_Find_Foreclosure_By_Addr(Cleaned, dx_Property.Key_Foreclosures_Addr);

	foreclosure_records := Find_Foreclosure_By_Addr(CP_DATA_DATE  <> '');
	shared foreclosure_sort := sort(foreclosure_records, fc_unique_id, -CP_DATA_DATE);

	//Count Foreclosure records in last 12 months
	foreclosure_vacancy.layouts.Foreclosure add12MoForeclosures(Find_Foreclosure_By_Addr l) := TRANSFORM
		tmp_data_date := if(l.filing_date >= l.recording_date, l.filing_date, l.recording_date);
		fc_populate := if(tmp_data_date <> '' and ut.DaysApart((STRING)Std.Date.Today() , tmp_data_date) < 365, 1, 0);
		
		self.fc_found_12mo := (STRING)fc_populate;
		self.CP_DATA_DATE := tmp_data_date;								 
		self.fc_unique_ID := if(fc_populate = 1, l.fc_unique_ID,'');
		
		self := l;
		self := [];
	end;

	Find_12_Mo_Foreclosure := project(Find_Foreclosure_By_Addr, add12MoForeclosures(left));
	
	FC_count := record
		Find_12_Mo_Foreclosure.fc_unique_id;
		Find_12_Mo_Foreclosure.fc_found_12mo;
		number := count(group,Find_12_Mo_Foreclosure.fc_found_12mo = '1');
	end;
	FC_Count_12_months := TABLE(Find_12_Mo_Foreclosure, FC_count, fc_unique_id, fc_found_12mo);
	shared FC_Count_Sort := dedup(sort( FC_Count_12_months, fc_unique_id, -Number), fc_unique_id);


	export getInteractive() := FUNCTION
		//Build results
		//Interactive-------------------------------------------------------
		foreclosure_vacancy.layouts.Final_Interactive PrefillADVO(Cleaned l, base_ADVO r) := transform
			self.Potentially_Vacant := MAP( r.Potentially_Vacant = 'Y' => TRUE, r.Potentially_Vacant = 'F' => FALSE, FALSE);
			self := r;
			self := l;
			self := [];
		end;
		Prefill_with_ADVO := join(Cleaned, base_ADVO, 
			(left.UniqueID_in = right.UniqueID),
			PrefillADVO(left, right),Left Outer);

		foreclosure_vacancy.layouts.Final_Interactive PrefillForeclosure(Prefill_with_ADVO l, foreclosure_sort r) := transform
			self.foreclosure_12mo := r.fc_found_12mo;
			self.foreclosure_type := r.DEED_EVENT_TYPE_CD;
			self.foreclosure_type_description := r.DEED_EVENT_TYPE_DESC;
			self.foreclosure_date := r.CP_DATA_DATE;
			self := l;
		end;

		Prefill_with_Count := join(Prefill_with_ADVO, foreclosure_sort, 
			(left.UniqueID_in = right.FC_Unique_ID),
			PrefillForeclosure(left, right),Left Outer, KEEP(1));

		foreclosure_vacancy.layouts.Final_Interactive PrefillFinal(Prefill_with_Count l, FC_Count_Sort r) := transform
			self.foreclosure_12mo := if(r.fc_found_12mo = '1','1','0');
			self.foreclosure_count_12mo := (string)r.number;
			self := l;
		end;
		Interactive_Final := join(Prefill_with_Count, FC_Count_Sort, 
			(left.UniqueID_in = right.FC_Unique_ID),
			PrefillFinal(left, right),Left Outer);
			
		return Interactive_Final;
	end;
	
	export getRenewal() 		:= FUNCTION
		//Foreclosure Address Search - Sort and dedup to get newest record
		ForeclosureNewest := dedup(Foreclosure_sort, fc_unique_id);
		
		foreclosure_vacancy.layouts.Renewal AddrSearch(ForeclosureNewest l) := transform
				self.OWNER_TYPE 	:= 'UK';
				self.FC_IND 			:= 'N';										
				self.FC_ADDR_IND 	:= 'Y';
				self 							:= l;
		end;

		Address_Foreclosures := project(ForeclosureNewest, AddrSearch(Left));
		
		
		//Foreclosure Name and Address Search on Owner Name 1
		foreclosure_vacancy.layouts.Renewal NameAddrSearch1(Foreclosure_sort l, Cleaned r) := transform
			self.FC_IND 			:= 'Y';							//foreclosure match by name and address
			self.FC_ADDR_IND 	:= 'N';							//foreclosure match by address
			self 							:= l;
		end;
		NameAddrForeclosures1 := join(Foreclosure_sort, Cleaned, 
			(left.fc_unique_ID = right.UniqueID_in) and
			(left.OWNR_1_LAST_NAME = right.last_name_in),
			NameAddrSearch1(left, right), KEEP(1));

		NameAddrForeclosuresDedup1 := dedup(NameAddrForeclosures1, fc_unique_id);
		
		//Foreclosure Name and Address Search on Owner Name 1
		foreclosure_vacancy.layouts.Renewal NameAddrSearch2(Foreclosure_sort l, Cleaned r) := transform
			self.FC_IND 			:= 'Y';							//foreclosure match by name and address
			self.FC_ADDR_IND 	:= 'N';							//foreclosure match by address
			self 							:= l;
		end;
		NameAddrForeclosures2 := join(Foreclosure_sort, Cleaned, 
			(left.fc_unique_ID = right.UniqueID_in) and
			(left.OWNR_2_LAST_NAME = right.last_name_in),
			NameAddrSearch2(left, right), KEEP(1));

		NameAddrForeclosuresDedup2 := dedup(NameAddrForeclosures2, fc_unique_id);
		
		NameAddrForeclosuresTemp := NameAddrForeclosuresDedup1 + NameAddrForeclosuresDedup2;
		
		NameAddrForeclosuresFinal := dedup(sort(NameAddrForeclosuresTemp, fc_unique_id),  fc_unique_id);
		
		foreclosure_vacancy.layouts.Renewal joinForeclosures(Address_Foreclosures l, NameAddrForeclosuresFinal r) :=transform
			self := if(r.fc_unique_id <>'', r, l);
		end;

		Foreclosure_Pre_Results := join(Address_Foreclosures, NameAddrForeclosuresFinal,
			(left.fc_unique_ID = right.fc_unique_ID),
			joinForeclosures(left, right), Left Outer);
	
		//Remove all foreclosures older than 12 months
		Foreclosure_Results := Foreclosure_Pre_Results(ut.DaysApart((STRING)Std.Date.Today() , cp_data_date) < 365);
	
		//Build results
		//Batch--------------------------------------------------------------
		foreclosure_vacancy.layouts.Final_Renewal BatchADVO(Cleaned l, base_ADVO r) := transform
			self := l;
			self.VACANCY_IND := r.Potentially_Vacant;
			self.VAC_BEGDT := r.Vacancy_First_Seen;
			self := [];
		end;
		Batch_with_ADVO := join(Cleaned, base_ADVO, 
			(left.UniqueID_in = right.UniqueID),
			BatchADVO(left, right),Left Outer);

		foreclosure_vacancy.layouts.Final_Renewal BatchFinal(Batch_with_ADVO l, Foreclosure_Results r) := transform
			self.FC_IND := if(r.fc_unique_ID <>'', r.FC_IND, 'N');
			self.FC_ADDR_IND := if(r.fc_unique_ID <>'', r.FC_ADDR_IND, 'N');
			self.OWNER_TYPE := if(r.fc_unique_ID <>'', r.OWNER_TYPE, '');
			self := r;
			self := l;
		end;
		Renewal_Final := join(Batch_with_ADVO, Foreclosure_Results, 
			(left.UniqueID_in = right.FC_Unique_ID),
			BatchFinal(left, right),Left Outer);

		return Renewal_Final;
	end;
	

End;