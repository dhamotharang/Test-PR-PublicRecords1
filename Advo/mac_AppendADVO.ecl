EXPORT mac_AppendADVO(in_dataset, UseIndexThreshold=5000000, in_prim_range, in_prim_name, in_suffix, in_predir, in_postdir, in_sec_range, in_zip, in_prefix='advo_') := FUNCTIONMACRO 
  
    // Create the output layout Input + Append Columns with a known default prefix (in this case advo_)

    Output_Rec := RECORD
    RECORDOF(in_dataset);
    AdvoHitFlag := 'N';
    AdvoVacancyIndicator := ADVO.Key_Addr1.address_vacancy_indicator;
    AdvoThrowBackIndicator := ADVO.Key_Addr1.throw_back_indicator;
    AdvoSeasonalDeliveryIndicator := ADVO.Key_Addr1.seasonal_delivery_indicator;
    AdvoSeasonalSuppressionStartDate := ADVO.Key_Addr1.seasonal_start_suppression_date;
    AdvoSeasonalSuppressionEndDate := ADVO.Key_Addr1.seasonal_end_suppression_date;
    AdvoDoNotDeliverIndicator := ADVO.Key_Addr1.dnd_indicator;
    AdvoCollegeIndicator := ADVO.Key_Addr1.college_indicator;
    AdvoCollegeSuppressionStartDate := ADVO.Key_Addr1.college_start_suppression_date;
    AdvoCollegeSuppressionEndDate := ADVO.Key_Addr1.college_end_suppression_date;	
    AdvoAddressStyle := ADVO.Key_Addr1.address_style_flag;
    AdvoSimplifyAddressCount := ADVO.Key_Addr1.simplify_address_count;
    AdvoDropIndicator := ADVO.Key_Addr1.drop_indicator;
    AdvoResidentialOrBusinessIndicator := ADVO.Key_Addr1.residential_or_business_ind;
    AdvoOnlyWayToGetMailIndicator := ADVO.Key_Addr1.owgm_indicator;
    AdvoRecordTypeCode := ADVO.Key_Addr1.record_type_code;
    AdvoAddressType := ADVO.Key_Addr1.address_type;
    AdvoAddressUsageType := ADVO.Key_Addr1.mixed_address_usage;
    AdvoFirstSeenDate := ADVO.Key_Addr1.date_first_seen;
    AdvoLastSeenDate := ADVO.Key_Addr1.date_last_seen;
    AdvoVendorFirstReportedDate := ADVO.Key_Addr1.date_vendor_first_reported;
    AdvoVendorLastReportedDate := ADVO.Key_Addr1.date_vendor_last_reported;
    AdvoVacationBeginDate := ADVO.Key_Addr1.vac_begdt;
    AdvoVacationEndDate := ADVO.Key_Addr1.vac_enddt;
    AdvoNumberOfCurrentVacationMonths := ADVO.Key_Addr1.months_vac_curr;
    AdvoMaxVacationMonths := ADVO.Key_Addr1.months_vac_max;
    AdvoVacationPeriodsCount := ADVO.Key_Addr1.vac_count;
  END;

  // In many cases ADVO might not have rows for an input address so many will be dropped.
  // Since the LG join (smart) below can not do a RIGHT OUTER we
  // Add a seqence number for rejoining back to original rows

	
  #UNIQUENAME(seq)
	
  OutputPrep_Rec := RECORD
    INTEGER %seq%;
    Output_Rec;
  END;
	
  // Sequence the inputfile.
	
  PreppedData := PROJECT(in_dataset, TRANSFORM(OutputPrep_Rec, self.%seq% := COUNTER, SELF := LEFT, SELF := []));

  Output_Rec tOutput_Rec(in_dataset l, ADVO.Key_Addr1 r) := TRANSFORM
    SELF.AdvoHitFlag := if(r.date_first_seen != '','Y','N'); // it is a string8, honest.
    SELF.AdvoVacancyIndicator := r.address_vacancy_indicator;
    SELF.AdvoThrowBackIndicator := r.throw_back_indicator;
    SELF.AdvoSeasonalDeliveryIndicator := r.seasonal_delivery_indicator;
    SELF.AdvoSeasonalSuppressionStartDate := r.seasonal_start_suppression_date;
    SELF.AdvoSeasonalSuppressionEndDate := r.seasonal_end_suppression_date;
    SELF.AdvoDoNotDeliverIndicator := r.dnd_indicator;
    SELF.AdvoCollegeIndicator := r.college_indicator;
    SELF.AdvoCollegeSuppressionStartDate := r.college_start_suppression_date;
    SELF.AdvoCollegeSuppressionEndDate := r.college_end_suppression_date;	
    SELF.AdvoAddressStyle := r.address_style_flag;
    SELF.AdvoSimplifyAddressCount := r.simplify_address_count;
    SELF.AdvoDropIndicator := r.drop_indicator;
    SELF.AdvoResidentialOrBusinessIndicator := r.residential_or_business_ind;
    SELF.AdvoOnlyWayToGetMailIndicator := r.owgm_indicator;
    SELF.AdvoRecordTypeCode := r.record_type_code;
    SELF.AdvoAddressType := r.address_type;
    SELF.AdvoAddressUsageType := r.mixed_address_usage;
    SELF.AdvoFirstSeenDate := r.date_first_seen;
    SELF.AdvoLastSeenDate := r.date_last_seen;
    SELF.AdvoVendorFirstReportedDate := r.date_vendor_first_reported;
    SELF.AdvoVendorLastReportedDate := r.date_vendor_last_reported;
    SELF.AdvoVacationBeginDate := r.vac_begdt;
    SELF.AdvoVacationEndDate := r.vac_enddt;
    SELF.AdvoNumberOfCurrentVacationMonths := r.months_vac_curr;
    SELF.AdvoMaxVacationMonths := r.months_vac_max;
    SELF.AdvoVacationPeriodsCount := r.vac_count;
    SELF := l;
    SELF := r;
    SELF := [];
  END;
  
  OutputPrep_Rec tOutputPrep_Rec(PreppedData l, ADVO.Key_Addr1 r) := TRANSFORM
    SELF.AdvoHitFlag := 'Y';
    SELF.AdvoVacancyIndicator := r.address_vacancy_indicator;
    SELF.AdvoThrowBackIndicator := r.throw_back_indicator;
    SELF.AdvoSeasonalDeliveryIndicator := r.seasonal_delivery_indicator;
    SELF.AdvoSeasonalSuppressionStartDate := r.seasonal_start_suppression_date;
    SELF.AdvoSeasonalSuppressionEndDate := r.seasonal_end_suppression_date;
    SELF.AdvoDoNotDeliverIndicator := r.dnd_indicator;
    SELF.AdvoCollegeIndicator := r.college_indicator;
    SELF.AdvoCollegeSuppressionStartDate := r.college_start_suppression_date;
    SELF.AdvoCollegeSuppressionEndDate := r.college_end_suppression_date;	
    SELF.AdvoAddressStyle := r.address_style_flag;
    SELF.AdvoSimplifyAddressCount := r.simplify_address_count;
    SELF.AdvoDropIndicator := r.drop_indicator;
    SELF.AdvoResidentialOrBusinessIndicator := r.residential_or_business_ind;
    SELF.AdvoOnlyWayToGetMailIndicator := r.owgm_indicator;
    SELF.AdvoRecordTypeCode := r.record_type_code;
    SELF.AdvoAddressType := r.address_type;
    SELF.AdvoAddressUsageType := r.mixed_address_usage;
    SELF.AdvoFirstSeenDate := r.date_first_seen;
    SELF.AdvoLastSeenDate := r.date_last_seen;
    SELF.AdvoVendorFirstReportedDate := r.date_vendor_first_reported;
    SELF.AdvoVendorLastReportedDate := r.date_vendor_last_reported;
    SELF.AdvoVacationBeginDate := r.vac_begdt;
    SELF.AdvoVacationEndDate := r.vac_enddt;
    SELF.AdvoNumberOfCurrentVacationMonths := r.months_vac_curr;
    SELF.AdvoMaxVacationMonths := r.months_vac_max;
    SELF.AdvoVacationPeriodsCount := r.vac_count;
    SELF := l;
    SELF := r;
    SELF := [];
  END;  
  
  ADVO_SM := JOIN(in_dataset, ADVO.Key_Addr1,
                     KEYED(LEFT.in_zip != '' AND LEFT.in_zip = RIGHT.zip) AND 
                     KEYED(LEFT.in_prim_range = RIGHT.prim_range) AND
                     KEYED(LEFT.in_prim_name = RIGHT.prim_name) AND
                     KEYED(LEFT.in_suffix = RIGHT.addr_suffix) AND
                     KEYED(LEFT.in_predir = RIGHT.predir) AND
                     KEYED(LEFT.in_postdir = RIGHT.postdir) AND
                     KEYED(LEFT.in_sec_range = '' OR LEFT.in_sec_range = RIGHT.sec_range),
                     tOutput_Rec(LEFT, RIGHT),
                     KEEP(1), LEFT OUTER, KEYED);

  ADVO_LG_Prep := JOIN(ADVO.Key_Addr1, PreppedData,
                     RIGHT.in_zip != '' AND RIGHT.in_zip = LEFT.zip AND 
                     RIGHT.in_prim_range = LEFT.prim_range AND
                     RIGHT.in_prim_name = LEFT.prim_name AND
                     RIGHT.in_suffix = LEFT.addr_suffix AND
                     RIGHT.in_predir = LEFT.predir AND
                     RIGHT.in_postdir = LEFT.postdir AND
                     (RIGHT.in_sec_range = '' OR RIGHT.in_sec_range = LEFT.sec_range),
           tOutputPrep_Rec(RIGHT, LEFT),
                    SMART, KEEP(1));	

  // Join back to the original (without the seq) and return.
	
  ADVO_LG := JOIN(PreppedData, ADVO_LG_Prep, LEFT.%seq%=RIGHT.%seq%, 
	                    TRANSFORM(Output_Rec, SELF := MAP(RIGHT.%seq% > 0 => RIGHT, LEFT)), LEFT OUTER);

  // Based on the UseIndexThreshold it will do mini-batch mode. Keyed for smaller datasets..
	
  ADVO_Results := MAP(COUNT(in_dataset) > UseIndexThreshold => ADVO_LG, ADVO_SM);
	
  // Re-prefix the appended columns with the specified prefix.
	
  ADVO_Results_Prefixed := ecl.macFieldRename(ADVO_Results, in_prefix, 'advo',,TRUE);

  RETURN ADVO_Results_Prefixed;

ENDMACRO;

