EXPORT mac_AppendADVO(in_dataset, UseIndexThreshold=20000000, in_prim_range, in_prim_name, in_suffix, in_predir, in_postdir, in_sec_range, in_zip, in_prefix='advo_') := FUNCTIONMACRO 
  IMPORT hipie_ecl, ADVO;
  LOCAL dDistributed  := DISTRIBUTE(in_dataset((STRING)in_zip <> ''), HASH32(in_zip, in_prim_range, in_prim_name, in_suffix));
  LOCAL rSearch := {RECORDOF(in_dataset) OR {STRING _searchZip,STRING _searchPrimRange,STRING _searchPrimName,STRING _searchSuffix,STRING _searchPredir,STRING _searchPostDir,STRING _searchSecRange}};
  LOCAL dSearch := PROJECT(dDistributed, TRANSFORM(rSearch,
    SELF._searchZip := (STRING)LEFT.in_zip,
    SELF._searchPrimRange := (STRING)LEFT.in_prim_range,
    SELF._searchPrimName := (STRING)LEFT.in_prim_name,
    SELF._searchSuffix := (STRING)LEFT.in_suffix,
    SELF._searchPredir := (STRING)LEFT.in_predir,
    SELF._searchPostDir := (STRING)LEFT.in_postdir,
    SELF._searchSecRange := (STRING)LEFT.in_sec_range,
    SELF := LEFT));
  LOCAL dupSearch   := DEDUP(SORT(dSearch, in_zip, in_prim_range, in_prim_name, in_suffix, in_predir, in_postdir, in_sec_range, LOCAL), in_zip, in_prim_range, in_prim_name, in_suffix, in_predir, in_postdir, in_sec_range, LOCAL);

  LOCAL dAdvo := hipie_ecl.macJoinKey(dupSearch, ADVO.Key_Addr1,
    'KEYED(LEFT._searchZip = RIGHT.zip AND LEFT._searchPrimRange = RIGHT.prim_range AND LEFT._searchPrimName = RIGHT.prim_name AND LEFT._searchSuffix = RIGHT.addr_suffix AND LEFT._searchPredir = RIGHT.predir AND LEFT._searchPostDir = RIGHT.postdir AND (LEFT._searchSecRange = \'\' OR LEFT._searchSecRange = RIGHT.sec_range))', 
    'RIGHT._searchZip = LEFT.zip AND RIGHT._searchPrimRange = LEFT.prim_range AND RIGHT._searchPrimName = LEFT.prim_name AND RIGHT._searchSuffix = LEFT.addr_suffix AND RIGHT._searchPredir = LEFT.predir AND RIGHT._searchPostDir = LEFT.postdir AND (RIGHT._searchSecRange = \'\' OR RIGHT._searchSecRange = LEFT.sec_range)', 
    UseIndexThreshold,,true,1);

  LOCAL rOut := RECORD
    RECORDOF(in_dataset);
    STRING1 #EXPAND(in_prefix + 'HitFlag') := 'N';
    #EXPAND(in_prefix + 'VacancyIndicator') := ADVO.Key_Addr1.address_vacancy_indicator;
    #EXPAND(in_prefix + 'ThrowBackIndicator') := ADVO.Key_Addr1.throw_back_indicator;
    #EXPAND(in_prefix + 'SeasonalDeliveryIndicator') := ADVO.Key_Addr1.seasonal_delivery_indicator;
    #EXPAND(in_prefix + 'SeasonalSuppressionStartDate') := ADVO.Key_Addr1.seasonal_start_suppression_date;
    #EXPAND(in_prefix + 'SeasonalSuppressionEndDate') := ADVO.Key_Addr1.seasonal_end_suppression_date;
    #EXPAND(in_prefix + 'DoNotDeliverIndicator') := ADVO.Key_Addr1.dnd_indicator;
    #EXPAND(in_prefix + 'CollegeIndicator') := ADVO.Key_Addr1.college_indicator;
    #EXPAND(in_prefix + 'CollegeSuppressionStartDate') := ADVO.Key_Addr1.college_start_suppression_date;
    #EXPAND(in_prefix + 'CollegeSuppressionEndDate') := ADVO.Key_Addr1.college_end_suppression_date;	
    #EXPAND(in_prefix + 'AddressStyle') := ADVO.Key_Addr1.address_style_flag;
    #EXPAND(in_prefix + 'SimplifyAddressCount') := ADVO.Key_Addr1.simplify_address_count;
    #EXPAND(in_prefix + 'DropIndicator') := ADVO.Key_Addr1.drop_indicator;
    #EXPAND(in_prefix + 'ResidentialOrBusinessIndicator') := ADVO.Key_Addr1.residential_or_business_ind;
    #EXPAND(in_prefix + 'OnlyWayToGetMailIndicator') := ADVO.Key_Addr1.owgm_indicator;
    #EXPAND(in_prefix + 'RecordTypeCode') := ADVO.Key_Addr1.record_type_code;
    #EXPAND(in_prefix + 'AddressType') := ADVO.Key_Addr1.address_type;
    #EXPAND(in_prefix + 'AddressUsageType') := ADVO.Key_Addr1.mixed_address_usage;
    #EXPAND(in_prefix + 'FirstSeenDate') := ADVO.Key_Addr1.date_first_seen;
    #EXPAND(in_prefix + 'LastSeenDate') := ADVO.Key_Addr1.date_last_seen;
    #EXPAND(in_prefix + 'VendorFirstReportedDate') := ADVO.Key_Addr1.date_vendor_first_reported;
    #EXPAND(in_prefix + 'VendorLastReportedDate') := ADVO.Key_Addr1.date_vendor_last_reported;
    #EXPAND(in_prefix + 'VacationBeginDate') := ADVO.Key_Addr1.vac_begdt;
    #EXPAND(in_prefix + 'VacationEndDate') := ADVO.Key_Addr1.vac_enddt;
    #EXPAND(in_prefix + 'NumberOfCurrentVacationMonths') := ADVO.Key_Addr1.months_vac_curr;
    #EXPAND(in_prefix + 'MaxVacationMonths') := ADVO.Key_Addr1.months_vac_max;
    #EXPAND(in_prefix + 'VacationPeriodsCount') := ADVO.Key_Addr1.vac_count;	
  END;

  LOCAL dOut := JOIN(dDistributed, dAdvo, 
    LEFT.in_zip = RIGHT._searchZip AND 
    LEFT.in_prim_range = RIGHT._searchPrimRange AND 
    LEFT.in_prim_name = RIGHT._searchPrimName AND 
    LEFT.in_suffix = RIGHT._searchSuffix AND 
    LEFT.in_predir = RIGHT._searchPredir AND 
    LEFT.in_postdir = RIGHT._searchPostDir AND 
    LEFT.in_sec_range = RIGHT._searchSecRange,
    TRANSFORM(rOut,
      SELF.#EXPAND(in_prefix + 'HitFlag') := IF(RIGHT.date_first_seen != '','Y','N'); 
      SELF.#EXPAND(in_prefix + 'VacancyIndicator') := RIGHT.address_vacancy_indicator;
      SELF.#EXPAND(in_prefix + 'ThrowBackIndicator') := RIGHT.throw_back_indicator;
      SELF.#EXPAND(in_prefix + 'SeasonalDeliveryIndicator') := RIGHT.seasonal_delivery_indicator;
      SELF.#EXPAND(in_prefix + 'SeasonalSuppressionStartDate') := RIGHT.seasonal_start_suppression_date;
      SELF.#EXPAND(in_prefix + 'SeasonalSuppressionEndDate') := RIGHT.seasonal_end_suppression_date;
      SELF.#EXPAND(in_prefix + 'DoNotDeliverIndicator') := RIGHT.dnd_indicator;
      SELF.#EXPAND(in_prefix + 'CollegeIndicator') := RIGHT.college_indicator;
      SELF.#EXPAND(in_prefix + 'CollegeSuppressionStartDate') := RIGHT.college_start_suppression_date;
      SELF.#EXPAND(in_prefix + 'CollegeSuppressionEndDate') := RIGHT.college_end_suppression_date;	
      SELF.#EXPAND(in_prefix + 'AddressStyle') := RIGHT.address_style_flag;
      SELF.#EXPAND(in_prefix + 'SimplifyAddressCount') := RIGHT.simplify_address_count;
      SELF.#EXPAND(in_prefix + 'DropIndicator') := RIGHT.drop_indicator;
      SELF.#EXPAND(in_prefix + 'ResidentialOrBusinessIndicator') := RIGHT.residential_or_business_ind;
      SELF.#EXPAND(in_prefix + 'OnlyWayToGetMailIndicator') := RIGHT.owgm_indicator;
      SELF.#EXPAND(in_prefix + 'RecordTypeCode') := RIGHT.record_type_code;
      SELF.#EXPAND(in_prefix + 'AddressType') := RIGHT.address_type;
      SELF.#EXPAND(in_prefix + 'AddressUsageType') := RIGHT.mixed_address_usage;
      SELF.#EXPAND(in_prefix + 'FirstSeenDate') := RIGHT.date_first_seen;
      SELF.#EXPAND(in_prefix + 'LastSeenDate') := RIGHT.date_last_seen;
      SELF.#EXPAND(in_prefix + 'VendorFirstReportedDate') := RIGHT.date_vendor_first_reported;
      SELF.#EXPAND(in_prefix + 'VendorLastReportedDate') := RIGHT.date_vendor_last_reported;
      SELF.#EXPAND(in_prefix + 'VacationBeginDate') := RIGHT.vac_begdt;
      SELF.#EXPAND(in_prefix + 'VacationEndDate') := RIGHT.vac_enddt;
      SELF.#EXPAND(in_prefix + 'NumberOfCurrentVacationMonths') := RIGHT.months_vac_curr;
      SELF.#EXPAND(in_prefix + 'MaxVacationMonths') := RIGHT.months_vac_max;
      SELF.#EXPAND(in_prefix + 'VacationPeriodsCount') := RIGHT.vac_count;
      SELF := LEFT),
    LEFT OUTER, LOCAL)
    + PROJECT(in_dataset((STRING)in_zip = ''), TRANSFORM(rOut,
        SELF := LEFT, SELF := []));
  
  RETURN DISTRIBUTE(dOut);
ENDMACRO;

