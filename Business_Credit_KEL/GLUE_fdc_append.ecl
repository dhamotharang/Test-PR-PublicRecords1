IMPORT BIPV2, Business_Credit, Business_Risk_BIP, MDR, ut, std;

EXPORT GLUE_fdc_append(DATASET(RECORDOF(Business_Credit_KEL.File_SBFE_temp.linkids)) linkid_recs) := MODULE
	
	EXPORT fdc_layout := RECORD
		RECORDOF(Business_Credit_KEL.File_SBFE_temp);
	END;
	
	// The following function finds the most recent build date in Production with respect to 
	// the formal parameter value. If the HistoryDateTime value is prior to any build dates 
	// found in the key, it is simply returned as the result. If it is a 'nines' value, then 
	// today's date is evaluated against the most recent build date. The return value is 
	// a 16-digit integer, except in the case where the formal paramenter value is six digits 
	// (YYYYMM) and it refernces a date/time prior to any build date.
	SHARED fn_getLatestReleaseDateTime(INTEGER HistoryDateTime) :=
		FUNCTION
			
			hist_date_time := IF( ((STRING)HistoryDateTime)[1..6] = '999999', (INTEGER)Std.Date.Today(), HistoryDateTime );
			
			len := LENGTH((STRING)hist_date_time);
			
			kReleaseDates_filt := 
				Business_Credit.Key_ReleaseDates()( // Ensure that the key definition points to the correct environment, e.g. Dataland, Prod, etc.
						(INTEGER)prod_date > 0 AND 
						(INTEGER)((TRIM(prod_date) + TRIM(prod_time))[1..len]) <= hist_date_time
					);
			
		result := 
			IF(
				COUNT(kReleaseDates_filt) > 0, 
				MAX(kReleaseDates_filt, (INTEGER)((TRIM(prod_date) + TRIM(prod_time)))),
				IF( len = 6, hist_date_time * 100 + 1, hist_date_time )
			);
				
			RETURN result;
		END;
	
	 
		SHARED getLoadDate(fdc_bundle, seq_field, secondary_date_field) := FUNCTIONMACRO
		fdc_bundle addLoadDate(fdc_bundle le, RECORDOF(business_credit.Key_ReleaseDates()) ri) := TRANSFORM
			load_datetime := ri.prod_date + ri.prod_time;
			//if load_datetime = '' means the record isn't in production yet - keep these for realtime runs and use secondary load date field, but don't use in archive runs.
			load_date := MAP(le.load_date < Business_Risk_BIP.Constants.FirstSBFELoadDate 																							=> le.load_date,
											(INTEGER)load_datetime=0 and ((STRING)le.HistoryDateTime)[1..6] = Business_Risk_BIP.Constants.NinesDate			=> (STRING)le.secondary_date_field,
																																																																		 load_datetime);
			SELF.load_date := load_date;
			SELF.load_dateYYYYMMDD := load_date[1..8]; 
			SELF := le;
		END;
		with_loadDate := JOIN(fdc_bundle, Business_Credit.Key_ReleaseDates(), LEFT.original_version=RIGHT.version, addLoadDate(LEFT,RIGHT), LEFT OUTER, LIMIT(100));
		with_loadDate_deduped := DEDUP(SORT(with_loadDate, seq_field, -original_version, -load_date), seq_field);	
		
		RETURN with_loadDate_deduped;
	ENDMACRO;		

	EXPORT JustSeq := PROJECT(DEDUP(TABLE(linkid_recs, {Seq, HistoryDate, HistoryDateTime, HistoryDateLength}), ALL, HASH), TRANSFORM(fdc_layout, 
																			SELF.seq:=LEFT.seq, 
																			SELF.HistoryDate := LEFT.HistoryDate,
																			SELF.HistoryDateTime := LEFT.HistoryDateTime,
																			SELF.HistoryDateLength := LEFT.HistoryDateLength,
																			SELF := []));

	SHARED RECORDOF(fdc_layout.tradelines) xfm_add_Tradelines( linkid_recs le, RECORDOF(Business_Credit.key_tradeline()) ri, INTEGER c) := TRANSFORM
		SELF.seq := le.seq;
		SELF.seq_num := HASH(c, le.seq, ri.sbfe_contributor_number, ri.contract_account_number, ri.account_type_reported); 
		SELF.HistoryDateTime := le.HistoryDateTime;
		SELF.load_date := IF(ri.original_version < Business_Risk_BIP.Constants.FirstSBFELoadDate, ri.cycle_end_date, ri.original_version); 
		SELF.acct_no := HASH(le.seq, ri.sbfe_contributor_number, ri.contract_account_number, ri.account_type_reported);
		SELF := ri;
		SELF := []
	END;
			
	SHARED linkid_recs_dedup := DEDUP(SORT(linkid_recs,seq, sbfe_contributor_number, contract_account_number, account_type_reported), seq, sbfe_contributor_number, contract_account_number, account_type_reported);

	SHARED tradeline_recs := JOIN(linkid_recs_dedup, Business_Credit.key_tradeline(),
																						KEYED(RIGHT.contract_account_number = LEFT.contract_account_number) AND KEYED(RIGHT.sbfe_contributor_number = LEFT.sbfe_contributor_number) AND KEYED(RIGHT.account_type_reported = LEFT.account_type_reported), 
																						//get all tradelines now, filter by load date below
																						xfm_add_Tradelines(LEFT,RIGHT,COUNTER), LIMIT(Business_Risk_BIP.Constants.Limit_SBFE)); //TODO: which conditions do we dedup tradelines by? (need to use (integer)contractacc_num to remove leading 0s)

	SHARED tradeline_recs_with_loaddate := getLoadDate(tradeline_recs, seq_num, cycle_end_date);
	
	EXPORT AddTradelines := DENORMALIZE(JustSeq, tradeline_recs_with_loaddate, LEFT.seq = RIGHT.seq
																						AND IF(LEFT.historydate =(INTEGER)Business_Risk_BIP.Constants.NinesDate,
																									RIGHT.load_date[1..8] <= StringLib.getDateYYYYMMDD(),
																									Business_Risk_BIP.Common.fn_filter_on_archive_date((INTEGER)RIGHT.load_date, LEFT.HistoryDateTime, LEFT.HistoryDateLength)), GROUP, 
																						TRANSFORM(fdc_layout, SELF.tradelines := ROWS(RIGHT), SELF := LEFT, SELF := []));
  //Join LinkIds to tradeline records in order to identify linkid records with no associated tradelines after date filtering. If a linkid has no tradeline records, we throw it out.
	EXPORT FilterLinkIds := JOIN(LinkId_Recs, AddTradelines.Tradelines, LEFT.SBFE_Contributor_Number = RIGHT.SBFE_Contributor_Number AND LEFT.Contract_Account_Number = RIGHT.Contract_Account_Number AND LEFT.Account_Type_Reported = RIGHT.Account_Type_Reported,
															 TRANSFORM(RECORDOF(Linkid_Recs), SELF := LEFT), LIMIT(Business_Risk_BIP.Constants.Limit_SBFE));
	
	EXPORT AddLinkIds := DENORMALIZE(AddTradelines,  FilterLinkIds, LEFT.seq = RIGHT.seq, GROUP, TRANSFORM(fdc_layout, SELF.seq := LEFT.seq, SELF.linkids := ROWS(RIGHT), SELF := LEFT, SELF := []));



	//EXPORT AddLinkIdsFuture := DENORMALIZE(AddTradelines,  LinkId_Recs, LEFT.seq = RIGHT.seq, GROUP, TRANSFORM(fdc_layout, SELF.seq := LEFT.seq, SELF.linkids := ROWS(RIGHT), SELF := LEFT, SELF := []));
	EXPORT AddTradelinesFuture := DENORMALIZE(JustSeq, tradeline_recs_with_loaddate, LEFT.seq = RIGHT.seq																					
																						AND IF(LEFT.historydate =(INTEGER)Business_Risk_BIP.Constants.NinesDate,
																									RIGHT.load_date[1..8] <= StringLib.getDateYYYYMMDD(),
																									Business_Risk_BIP.Common.fn_filter_on_archive_date((INTEGER)RIGHT.load_date, Business_Risk_BIP.Common.getFutureDate(LEFT.HistoryDateTime), LEFT.HistoryDateLength)), GROUP, 
																						TRANSFORM(fdc_layout, SELF.tradelines := ROWS(RIGHT), SELF := LEFT, SELF := []));
																						
	EXPORT FilterLinkIdsFuture := JOIN(LinkId_Recs, AddTradelinesFuture.Tradelines, LEFT.SBFE_Contributor_Number = RIGHT.SBFE_Contributor_Number AND LEFT.Contract_Account_Number = RIGHT.Contract_Account_Number AND LEFT.Account_Type_Reported = RIGHT.Account_Type_Reported,
															 TRANSFORM(RECORDOF(Linkid_Recs), SELF := LEFT), LIMIT(Business_Risk_BIP.Constants.Limit_SBFE));
	EXPORT AddLinkIdsFuture := DENORMALIZE(AddTradelinesFuture,  FilterLinkIdsFuture, LEFT.seq = RIGHT.seq, GROUP, TRANSFORM(fdc_layout, SELF.seq := LEFT.seq, SELF.linkids := ROWS(RIGHT), SELF := LEFT, SELF := []));														 
															 
	SHARED RECORDOF(fdc_layout.BusinessInformation) xfm_BusinessInformation_recs(linkid_recs le, RECORDOF(Business_Credit.Key_BusinessInformation()) ri, INTEGER c) := TRANSFORM
		SELF.seq:=le.seq;
		SELF.seq_num := HASH(c, le.seq, ri.sbfe_contributor_number, ri.contract_account_number, ri.account_type_reported);
		SELF.acct_no := HASH(le.seq, ri.sbfe_contributor_number, ri.contract_account_number, ri.account_type_reported);
		SELF.load_date := IF(ri.original_version < Business_Risk_BIP.Constants.FirstSBFELoadDate, (STRING)ri.dt_first_seen, ri.original_version); 
		SELF.HistoryDate := le.HistoryDate;
		SELF.HistoryDateTime := le.HistoryDateTime;
		SELF.HistoryDateLength := le.HistoryDateLength;
		SELF := ri;
		SELF := [];
	END;

		
	EXPORT BusinessInformation_recs := JOIN(linkid_recs_dedup, Business_Credit.Key_BusinessInformation(),
																						KEYED(RIGHT.contract_account_number = LEFT.contract_account_number) AND KEYED(RIGHT.sbfe_contributor_number = LEFT.sbfe_contributor_number) AND KEYED(RIGHT.account_type_reported = LEFT.account_type_reported), 
																					xfm_BusinessInformation_recs(LEFT,RIGHT,COUNTER), ATMOST(Business_Risk_BIP.Constants.Limit_SBFE));
																											
	SHARED BusinessInformation_recs_with_loaddate := getLoadDate(BusinessInformation_recs, seq_num, dt_first_seen);		
	
	SHARED BusinessInformation_recs_with_loaddate_filtered := BusinessInformation_recs_with_loaddate((historydate =(INTEGER)Business_Risk_BIP.Constants.NinesDate AND load_date[1..8] <= StringLib.getDateYYYYMMDD())
																									OR Business_Risk_BIP.Common.fn_filter_on_archive_date((INTEGER)load_date, HistoryDateTime, HistoryDateLength));
	SHARED RECORDOF(fdc_layout.BusinessClassification) xfm_add_BusInfo( RECORDOF(fdc_layout.BusinessInformation) le, RECORDOF(Business_Credit.Key_BusinessClassification()) ri, INTEGER c) :=
		TRANSFORM
			SELF.seq := le.seq,
			SELF.seq_num := HASH(c, le.seq, ri.sbfe_contributor_number, ri.contract_account_number, ri.account_type_reported),
			SELF.acct_no := le.acct_no;
			SELF.HistoryDateTime := le.HistoryDateTime;
			SELF.load_date := IF(ri.original_version < Business_Risk_BIP.Constants.FirstSBFELoadDate, (STRING)ri.dt_first_seen, ri.original_version); 
			SELF := ri;
			SELF := [];
		END;
		
		
	SHARED BusinessInformation_recs_with_loaddate_dedup := DEDUP(SORT(BusinessInformation_recs_with_loaddate, seq, sbfe_contributor_number, contract_account_number, account_type_reported), seq, sbfe_contributor_number, contract_account_number, account_type_reported);
	EXPORT BusinessClassification_recs := JOIN(BusinessInformation_recs_with_loaddate_dedup, Business_Credit.Key_BusinessClassification(),
																						KEYED(RIGHT.contract_account_number =LEFT.contract_account_number) AND KEYED(RIGHT.sbfe_contributor_number=LEFT.sbfe_contributor_number)  AND KEYED(RIGHT.account_type_reported = LEFT.account_type_reported),
																						xfm_add_BusInfo(LEFT,RIGHT,COUNTER), ATMOST(Business_Risk_BIP.Constants.Limit_SBFE));
																						
	SHARED BusinessClassification_recs_with_loaddate := getLoadDate(BusinessClassification_recs, seq_num, dt_first_seen);																					
					
					
	EXPORT AddBusinessClassification := DENORMALIZE(BusinessInformation_recs_with_loaddate_filtered, BusinessClassification_recs_with_loaddate, LEFT.seq = RIGHT. seq AND LEFT.acct_no = RIGHT.acct_no
																									AND IF(LEFT.historydate =(INTEGER)Business_Risk_BIP.Constants.NinesDate,
																									RIGHT.load_date[1..8] <= StringLib.getDateYYYYMMDD(),
																									Business_Risk_BIP.Common.fn_filter_on_archive_date((INTEGER)RIGHT.load_date, LEFT.HistoryDateTime, LEFT.HistoryDateLength)), GROUP,
																						TRANSFORM(RECORDOF(fdc_layout.BusinessInformation), SELF.BusinessClassification := ROWS(RIGHT), SELF := LEFT, SELF := []));
																											
	EXPORT AddBusinessInformation := DENORMALIZE(AddLinkIds, BusinessInformation_recs_with_loaddate, LEFT.seq = RIGHT.seq
																									AND IF(LEFT.historydate =(INTEGER)Business_Risk_BIP.Constants.NinesDate,
																									RIGHT.load_date[1..8] <= StringLib.getDateYYYYMMDD(),
																									Business_Risk_BIP.Common.fn_filter_on_archive_date((INTEGER)RIGHT.load_date, LEFT.HistoryDateTime, LEFT.HistoryDateLength)),GROUP, 
																						TRANSFORM(fdc_layout, SELF.BusinessInformation := ROWS(RIGHT), SELF := LEFT, SELF := []));
																						
	EXPORT AddBusinessClassification_KEL := DENORMALIZE(AddBusinessInformation, BusinessClassification_recs_with_loaddate, LEFT.seq = RIGHT.seq
																									AND IF(LEFT.historydate =(INTEGER)Business_Risk_BIP.Constants.NinesDate,
																									RIGHT.load_date[1..8] <= StringLib.getDateYYYYMMDD(),
																									Business_Risk_BIP.Common.fn_filter_on_archive_date((INTEGER)RIGHT.load_date, LEFT.HistoryDateTime, LEFT.HistoryDateLength)),GROUP,
																						TRANSFORM(fdc_layout, SELF.BusinessClassification := ROWS(RIGHT), SELF := LEFT, SELF := []));
	
	SHARED RECORDOF(fdc_layout.BusinessOwner) xfm_add_BusOwner( linkid_recs le, RECORDOF(Business_Credit.Key_BusinessOwner()) ri, INTEGER c) :=
		TRANSFORM
			SELF.seq := le.seq,
			SELF.seq_num := HASH(c, le.seq, ri.sbfe_contributor_number, ri.contract_account_number, ri.account_type_reported),
			SELF.acct_no := HASH(le.seq, ri.sbfe_contributor_number, ri.contract_account_number, ri.account_type_reported);
			SELF.HistoryDateTime := le.HistoryDateTime;
			SELF.load_date := IF(ri.original_version < Business_Risk_BIP.Constants.FirstSBFELoadDate, (STRING)ri.dt_first_seen, ri.original_version);
			SELF := ri;
			SELF := [];
		END;
	
  EXPORT BusinessOwner_recs := JOIN(linkid_recs_dedup, Business_Credit.Key_BusinessOwner(),
																						KEYED(RIGHT.contract_account_number = LEFT.contract_account_number) AND KEYED(RIGHT.sbfe_contributor_number = LEFT.sbfe_contributor_number) AND KEYED(RIGHT.account_type_reported = LEFT.account_type_reported), 
																					xfm_add_BusOwner(LEFT,RIGHT,COUNTER), ATMOST(Business_Risk_BIP.Constants.Limit_SBFE));
																					
	SHARED BusinessOwner_recs_with_loaddate := getLoadDate(BusinessOwner_recs, seq_num, dt_first_seen);	
	
	EXPORT AddBusinessOwner := DENORMALIZE(AddBusinessClassification_KEL, BusinessOwner_recs_with_loaddate, LEFT.seq = RIGHT.seq
																									AND IF(LEFT.historydate =(INTEGER)Business_Risk_BIP.Constants.NinesDate,
																									RIGHT.load_date[1..8] <= StringLib.getDateYYYYMMDD(),
																									Business_Risk_BIP.Common.fn_filter_on_archive_date((INTEGER)RIGHT.load_date, LEFT.HistoryDateTime, LEFT.HistoryDateLength)), GROUP,
																						TRANSFORM(fdc_layout, SELF.BusinessOwner := ROWS(RIGHT), SELF := LEFT, SELF := []));
	
	SHARED RECORDOF(fdc_layout.IndividualOwner) xfm_add_IndivOwner( linkid_recs le, RECORDOF(Business_Credit.Key_IndividualOwner()) ri, INTEGER c) :=
		TRANSFORM
			SELF.seq := le.seq,
			SELF.seq_num := HASH(c, le.seq, ri.sbfe_contributor_number, ri.contract_account_number, ri.account_type_reported),
			SELF.acct_no := HASH(le.seq, ri.sbfe_contributor_number, ri.contract_account_number, ri.account_type_reported);
			SELF.HistoryDateTime := le.HistoryDateTime;
			SELF.load_date := IF(ri.original_version < Business_Risk_BIP.Constants.FirstSBFELoadDate, (STRING)ri.dt_first_seen, ri.original_version);
			SELF := ri;
			SELF := [];
		END;
		
	EXPORT IndividualOwner_recs := JOIN(linkid_recs_dedup, Business_Credit.Key_IndividualOwner(),																			
																						KEYED(RIGHT.contract_account_number = LEFT.contract_account_number) AND KEYED(RIGHT.sbfe_contributor_number = LEFT.sbfe_contributor_number) AND KEYED(RIGHT.account_type_reported = LEFT.account_type_reported), 
																						xfm_add_IndivOwner(LEFT,RIGHT,COUNTER), ATMOST(Business_Risk_BIP.Constants.Limit_SBFE));
																						
	SHARED IndividualOwner_recs_with_loaddate := getLoadDate(IndividualOwner_recs, seq_num, dt_first_seen);	
																						
	EXPORT AddIndividualOwner := DENORMALIZE(AddBusinessOwner, IndividualOwner_recs_with_loaddate, LEFT.seq = RIGHT.seq
																									AND IF(LEFT.historydate =(INTEGER)Business_Risk_BIP.Constants.NinesDate,
																									RIGHT.load_date[1..8] <= StringLib.getDateYYYYMMDD(),
																									Business_Risk_BIP.Common.fn_filter_on_archive_date((INTEGER)RIGHT.load_date, LEFT.HistoryDateTime, LEFT.HistoryDateLength)), GROUP,
																						TRANSFORM(fdc_layout, SELF.IndividualOwner := ROWS(RIGHT), SELF := LEFT, SELF := []));

  // Setup query config module
	SHARED Cfg_Append(fdc_layout le) := MODULE(Business_Credit_KEL.Cfg_graph)
			EXPORT CurrentDate := 
				MAP(
					le.HistoryDateTime > 0 => (INTEGER)((STRING)fn_getLatestReleaseDateTime(le.HistoryDateTime))[1..8],
					le.HistoryDate     > 0 => (INTEGER)((STRING)fn_getLatestReleaseDateTime(le.HistoryDate))[1..8],
					/* default.........: */   (INTEGER)((STRING)fn_getLatestReleaseDateTime((INTEGER)Std.Date.Today()))[1..8]
				);
	END;

	//We have to call the KEL inside a function to allow multiple history dates in one batch
	SHARED RECORDOF(Business_Credit_KEL.Q_S_B_F_E___Shell().Res0) withResults(fdc_layout le) := TRANSFORM
		CFG_Mod := CFG_append(le);
		Results := Business_Credit_KEL.Q_S_B_F_E___Shell(DATASET([le], fdc_layout), CFG_Mod).Res0;
		SELF := Results[1];
	END;
		
	SHARED RECORDOF(Business_Credit_KEL.Q_S_B_F_E___Future___Shell().Res0) withResultsFuture(fdc_layout le) := TRANSFORM
		CFG_Mod := CFG_append(le);
		Results := Business_Credit_KEL.Q_S_B_F_E___Future___Shell(DATASET([le], fdc_layout), CFG_Mod).Res0;
		SELF := Results[1];
	END;
			
	EXPORT SBFE_Result := PROJECT(AddIndividualOwner, withResults(LEFT));
	EXPORT SBFE_Result_Future := PROJECT(AddLinkIdsFuture, withResultsFuture(LEFT));
	
	// Debugging options
	//EXPORT SBFE_Result := Business_Credit_KEL.Q_S_B_F_E___Shell(AddIndividualOwner, CFG_append(AddIndividualOwner[1])).Res0; 
	//EXPORT SBFE_Result_Future := Business_Credit_KEL.Q_S_B_F_E___Future___Shell(AddTradelinesFuture, CFG_append(AddTradelinesFuture[1])).Res0;
	//EXPORT SBFE_Result := AddIndividualOwner;
	//EXPORT SBFE_raw := Business_Credit_KEL.Q_Tradeline__dump(AddIndividualOwner, CFG_append(AddIndividualOwner[1])).Res0;
	//EXPORT SBFE_Result := Business_Credit_KEL.Q_Dump(AddIndividualOwner, CFG_append(AddIndividualOwner[1])).Res0; //shows raw data, for debugging
END;