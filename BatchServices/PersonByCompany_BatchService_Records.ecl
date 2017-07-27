IMPORT AutoHeaderI, AutoStandardI, Business_Header, DayBatchEDA, DCA, Didville, EBR, PAW, SUPPRESS, UT, STD;

EXPORT PersonByCompany_BatchService_Records(
	DATASET(PersonByCompany_BatchService_Layouts.Input) indata,
	PersonByCompany_BatchService_Interfaces.Input args) := MODULE
	
	EXPORT Records := FUNCTION
	
		bitmasks := PersonByCompany_BatchService_Constants.Bitmasks;
		limits := PersonByCompany_BatchService_Constants.Limits;

		// First, sequence the records to ensure uniqueness and add domain.
		Sequenced_Rec := RECORD
			UNSIGNED __seq;
			QSTRING50 domain;
			PersonByCompany_BatchService_Layouts.Input;
		END;
			
		Add_Sequence := PROJECT(indata,TRANSFORM(Sequenced_Rec,
			SELF.__seq := COUNTER,
			SELF.domain := TRIM(STD.Str.ToUpperCase(regexfind('[@](.*)',left.email,1)),left,right),
			SELF := LEFT));
			
		// Next, join against EDA file to locate the business
		Found_Info_Rec := RECORD
			UNSIGNED __seq;
			UNSIGNED1 origin;
			QSTRING120 listed_name;
		END;
		
		EDA_Join := JOIN(Add_Sequence,DayBatchEDA.Key_Gong_Phone,
			KEYED(RIGHT.ph7 = IF(LENGTH(TRIM(LEFT.phone)) = 10,LEFT.phone[4..10],(STRING7)LEFT.phone)) AND
			KEYED((RIGHT.ph3 = LEFT.phone[1..3] OR LENGTH(TRIM(LEFT.phone)) != 10)) AND
			WILD(RIGHT.st) AND
			KEYED(RIGHT.business_flag),
			TRANSFORM(Found_Info_Rec,
				SELF.__seq := LEFT.__seq,
				SELF.listed_name := RIGHT.listed_name,
				SELF.origin := bitmasks.PHONE,
				SELF := []),
			KEEP(limits.EDA_KEEP), LIMIT(0));
	
		// Step 2: Look by email
		Email_Join := JOIN(Add_Sequence,PAW.Key_companyname_domain,
			KEYED(LEFT.domain = RIGHT.domain) AND
			args.emailthreshold <= RIGHT.ratio,
			TRANSFORM(Found_Info_Rec,
				SELF.__seq := LEFT.__seq,
				SELF.listed_name := RIGHT.company_name,
				SELF.origin := bitmasks.EMAIL,
				SELF := []),
			LIMIT(limits.EMAIL_LIMIT,SKIP),
			KEEP(limits.EMAIL_KEEP));
	
		// Step 3: DID the records and look up PAW.
		File_for_DID := PROJECT(Add_Sequence,TRANSFORM(Didville.Layout_Did_OutBatch,
			SELF.seq := LEFT.__seq,
			SELF.phone10 := LEFT.phone,
			SELF := LEFT));
	
		IndustryClass := ut.IndustryClass.Get();
		// Gets the DIDs -- with the necessary confidence score -- and removes zero DIDs
		DIDed_Records := TABLE(Didville.did_service_common_function(File_for_DID,
																																,
																																,
																																'ALL',
																																,
																																75,,,,,,,,,,,
																																args.applicationType,
																																IndustryClass_val := IndustryClass)(did != 0),
			{UNSIGNED __seq := seq,did});
	
		ContactId_Records := JOIN(DIDed_Records,PAW.Key_Did,
			KEYED(LEFT.did = RIGHT.did),
			KEEP(limits.PAW_CONTACTID_KEEP), LIMIT(0));
		
		// Gets the actual PAW payload records
		PAW_Records := JOIN(ContactId_Records,PAW.Key_contactID,
			KEYED(LEFT.contact_id = RIGHT.contact_id),
			KEEP(limits.PAW_RECORDS_KEEP), LIMIT(0));  // keep 1, limit 0
	
		// Pull SSNs and DIDs
	  Suppress.MAC_Suppress(PAW_Records,PAW_Records_DIDs_Pulled,args.applicationType,Suppress.Constants.LinkTypes.DID,did);
	  Suppress.MAC_Suppress(PAW_Records_DIDs_Pulled,PAW_Records_SSNs_Pulled,args.applicationType,Suppress.Constants.LinkTypes.SSN,ssn);
		
		Deduped_PAW_Records := DEDUP(SORT(PAW_Records_SSNs_Pulled,__seq,-dt_last_seen,-dt_first_seen,record),__seq);
		
		PAW_Names := PROJECT(Deduped_PAW_Records,TRANSFORM(Found_Info_Rec,
			SELF.__seq := LEFT.__seq,
			SELF.listed_name := LEFT.company_name,
			SELF.origin := bitmasks.PAW,
			SELF := []));
		
		// Step 4: Look just using names provided
		Normalized_Names := NORMALIZE(Add_Sequence,2,
			TRANSFORM(Found_Info_Rec,
				SELF.__seq := LEFT.__seq,
				SELF.listed_name := CHOOSE(COUNTER,
					LEFT.bureau_company_name,
					LEFT.client_company_name),
				SELF.origin := CHOOSE(COUNTER,
					bitmasks.BUREAU_NAME,
					bitmasks.CLIENT_NAME),
				SELF := []));
		
		All_Names := (EDA_Join + Email_Join + PAW_Names + Normalized_Names)(listed_name != '');
		
		Deduped_Names := ROLLUP(SORT(All_Names,__seq,listed_name),
			LEFT.__seq = RIGHT.__seq AND
			LEFT.listed_name = RIGHT.listed_name,
			TRANSFORM(Found_Info_Rec,
				SELF.origin := LEFT.origin | RIGHT.origin,
				SELF := LEFT));
		
		// Next, join back to the input to get input data again
		Sequenced_Plus_Found_Rec := RECORD
			RECORDOF(Add_Sequence) OR RECORDOF(Deduped_Names);
		END;
		
		Join_Back := JOIN(Add_Sequence,Deduped_Names,
			LEFT.__seq = RIGHT.__seq,
			TRANSFORM(Sequenced_Plus_Found_Rec,
				SELF := RIGHT,
				SELF := LEFT));
		
		// Now, again project into the layout for Business Header Fetch, this time to get by company name and zip-radius
		it := AutoStandardI.InterfaceTranslator;
		Header_Fetch_Records_2 := PROJECT(Join_Back,TRANSFORM(AutoHeaderI.Layouts.Fetch_Hdr_Batch_Biz_Layout,
			tempmod := MODULE(
				it.company_name_value.params,
				it.zip_value.params)
				EXPORT asisname := '';
				EXPORT cn := '';
				EXPORT company := '';
				EXPORT companyname := LEFT.listed_name;
				EXPORT corpname := '';
				EXPORT nameasis := '';
				EXPORT addr := '';
				EXPORT city := LEFT.p_city_name;
				EXPORT isPRP := false;
				EXPORT prim_name := '';
				EXPORT primname := '';
				EXPORT prim_range := '';
				EXPORT primrange := '';
				EXPORT sec_range := '';
				EXPORT secrange := '';
				EXPORT st := LEFT.st;
				EXPORT st_orig := '';
				EXPORT state := '';
				EXPORT statecityzip := '';
				EXPORT street_name := '';
				EXPORT z5 := LEFT.z5;
				EXPORT zip := '';
				EXPORT mileradius := args.ZipRadius;
				EXPORT zipradius := args.ZipRadius;
				EXPORT county := '';
			END;
			SELF.company_name_value := it.company_name_value.val(PROJECT(tempmod,it.company_name_value.params)),
			SELF.zip_value := it.zip_value.val(PROJECT(tempmod,it.zip_value.params)),
			SELF.nofail := FALSE,
			SELF.searchignoresaddressonly_value := FALSE,
			SELF.allow_close_match_value := args.FuzzinessDial > 0,
			SELF.allow_indic_match_value := args.FuzzinessDial > 1,
			SELF.allow_wild_match_value := args.FuzzinessDial > 2,
			// I have to combine this information in the acctno field because otherwise it will be lost.
			SELF.acctno := INTFORMAT(LEFT.origin,4,1) + '|' + (STRING)LEFT.__seq,
			SELF := []));
		
		Deduped_Header_Fetch_Records_2 := DEDUP(SORT(Header_Fetch_Records_2,record),record);
		
		// Next, call the Business Header Fetch to get by company name and zip-radius
		Zip_Radius_Records := AutoHeaderI.FetchI_Hdr_Batch_Biz(Deduped_Header_Fetch_Records_2);
		
		// Project to get __Seq and origin.
		Demuxed_Radius_Records := PROJECT(Zip_Radius_Records,TRANSFORM(
			{
				RECORDOF(Zip_Radius_Records);
				Add_Sequence.__seq;
				Found_Info_Rec.origin;
			},
			SELF.__seq := (UNSIGNED)LEFT.acctno[6..],
			SELF.origin := (UNSIGNED)LEFT.acctno[1..4],
			SELF := LEFT));
		
		Projected_Radius_Records := JOIN(Add_Sequence,Demuxed_Radius_Records,
			// I have to demux the info from the acctno field to get the actual __Seq to match on
			LEFT.__seq = RIGHT.__seq,
			TRANSFORM(
			{
				Add_Sequence.acctno;
				Add_Sequence.__seq;
				Zip_Radius_Records.id;
				Found_Info_Rec.origin;
				BOOLEAN in_ebr;
				BOOLEAN in_dca;
			},
			SELF.acctno := LEFT.acctno,
			SELF.origin := RIGHT.origin,
			SELF.__seq := LEFT.__seq,
			SELF.in_ebr := FALSE,
			SELF.in_dca := FALSE,
			SELF.id := RIGHT.id));
		
		Rolledup_Radius_Records := ROLLUP(SORT(Projected_Radius_Records,acctno,id),
			LEFT.acctno = RIGHT.acctno AND
			LEFT.id = RIGHT.id,
			TRANSFORM(RECORDOF(Projected_Radius_Records),
				SELF.origin := LEFT.origin | RIGHT.origin,
				SELF := LEFT));
		
		// Here, we just check to see whether the company shows up in EBR or DCA.  If so, we want it
		// to bubble up closer to the top.
		EBR_Join := JOIN(Rolledup_Radius_Records,EBR.Key_0010_Header_BDID,
			KEYED(LEFT.id = RIGHT.bdid),
			TRANSFORM(RECORDOF(Rolledup_Radius_Records),
				SELF.in_ebr := RIGHT.bdid != 0,
				SELF := LEFT),
			LEFT OUTER,
			KEEP(limits.EBR_KEEP), LIMIT(0));
		
		DCA_Join := JOIN(EBR_Join,DCA.Key_DCA_BDID,
			KEYED(LEFT.id = RIGHT.bdid),
			TRANSFORM(RECORDOF(Rolledup_Radius_Records),
				SELF.in_dca := RIGHT.bdid != 0,
				SELF := LEFT),
			LEFT OUTER,
			KEEP(limits.DCA_KEEP), LIMIT (ut.limits.MAX_DCA_PER_BDID));
		
		Final_Selection := DEDUP(SORT(DCA_Join,
			__seq,
			-(
				if(origin & bitmasks.PHONE != 0,1,0) +
				if(origin & bitmasks.EMAIL != 0,1,0) +
				if(origin & bitmasks.PAW != 0,1,0) +
				if(origin & bitmasks.BUREAU_NAME != 0,1,0) +
				if(origin & bitmasks.CLIENT_NAME != 0,1,0)),
			-(if(in_ebr,1,0) + if(in_dca,1,0)),
			id,
			record),
			__seq,keep args.MaxResultsPerRow);
			
		// Go get the best data.
		Best_Records := JOIN(Final_Selection,Business_Header.Key_BH_Best,
			KEYED(LEFT.id = RIGHT.bdid),
			TRANSFORM(PersonByCompany_BatchService_Layouts.Final,
				SELF.prim_name := IF(RIGHT.prim_name = '' AND RIGHT.phone = 0,SKIP,RIGHT.prim_name),
				SELF.zip := IF(RIGHT.zip = 0,'',INTFORMAT(RIGHT.zip,5,1)),
				SELF.zip4 := IF(RIGHT.zip4 = 0,'',INTFORMAT(RIGHT.zip4,4,1)),
				SELF.phone := IF(RIGHT.phone = 0,'',INTFORMAT(RIGHT.phone,10,1)),
				SELF.fein := IF(RIGHT.fein = 0,'',INTFORMAT(RIGHT.fein,9,1)),
				SELF.from_phone := LEFT.origin & bitmasks.PHONE != 0,
				SELF.from_email := LEFT.origin & bitmasks.EMAIL != 0,
				SELF.from_paw := LEFT.origin & bitmasks.PAW != 0,
				SELF.from_bureau_name := LEFT.origin & bitmasks.BUREAU_NAME != 0,
				SELF.from_client_name := LEFT.origin & bitmasks.CLIENT_NAME != 0,
				SELF := LEFT,
				SELF := RIGHT),
			KEEP (1), LIMIT (0));
	
		RETURN Best_Records;
	
	END;

END;
