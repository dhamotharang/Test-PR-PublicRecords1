EXPORT mac_append_address_attributes (Infile, Input_Prim_Range, Input_PreDir, Input_PrimName, Input_Suffix, Input_PostDir, Input_SecRange, Input_City, Input_St, Input_Zip, UseIndexThreshold = 5000000, appendPrefix = '\'\'') := FUNCTIONMACRO
		
		OutPut_Rec := RECORD
			RECORDOF (Infile);
			STRING1   #EXPAND(appendPrefix + 'AdvoHitFlag') := 'N';
			STRING1   #EXPAND(appendPrefix + 'VacancyIndicator');
			STRING1   #EXPAND(appendPrefix + 'ThrowBackIndicator');
			STRING1   #EXPAND(appendPrefix + 'SeasonalDeliveryIndicator');
			STRING5   #EXPAND(appendPrefix + 'SeasonalSuppressionStartDate');
			STRING5   #EXPAND(appendPrefix + 'SeasonalSuppressionEndDate');
			STRING1   #EXPAND(appendPrefix + 'DoNotDeliverIndicator');
			STRING1   #EXPAND(appendPrefix + 'CollegeIndicator');
			STRING10  #EXPAND(appendPrefix + 'CollegeSuppressionStartDate');
			STRING10  #EXPAND(appendPrefix + 'CollegeSuppressionEndDate');
			STRING1   #EXPAND(appendPrefix + 'AddressStyle');
			STRING5   #EXPAND(appendPrefix + 'SimplifyAddressCount');
			STRING1   #EXPAND(appendPrefix + 'DropIndicator');
			STRING1   #EXPAND(appendPrefix + 'ResidentialOrBusinessIndicator');
			STRING1   #EXPAND(appendPrefix + 'OnlyWayToGetMailIndicator');
			STRING1   #EXPAND(appendPrefix + 'RecordTypeCode');
			STRING1   #EXPAND(appendPrefix + 'AdvoAddressType');
			STRING1   #EXPAND(appendPrefix + 'AddressUsageType');
			STRING8   #EXPAND(appendPrefix + 'FirstSeenDate');
			STRING8   #EXPAND(appendPrefix + 'LastSeenDate');
			STRING8   #EXPAND(appendPrefix + 'VendorFirstReportedDate');
			STRING8   #EXPAND(appendPrefix + 'VendorLastReportedDate');
			STRING8   #EXPAND(appendPrefix + 'VacationBeginDate');
			STRING8   #EXPAND(appendPrefix + 'VacationEndDate');
			STRING8   #EXPAND(appendPrefix + 'NumberOfCurrentVacationMonths');
			STRING8   #EXPAND(appendPrefix + 'MaxVacationMonths');
			STRING8   #EXPAND(appendPrefix + 'VacationPeriodsCount');
      STRING1   #EXPAND(appendPrefix + 'ACAHitFlag') := 'N';
      STRING200 #EXPAND(appendPrefix + 'Institution');
      STRING2   #EXPAND(appendPrefix + 'InstitutionType');
      STRING10  #EXPAND(appendPrefix + 'InstitutionTypeExp');
      STRING1   #EXPAND(appendPrefix + 'ACAAddressType');
		END;

		OutPut_Rec_W_Seq := RECORD
			UNSIGNED8 UniqueID;
			Output_Rec;
		END;
	
		Assign_Seq_No := PROJECT(Infile, TRANSFORM(OutPut_Rec_W_Seq, SELF.UniqueID := COUNTER, SELF := LEFT, SELF := []));

		OutPut_Rec tOutput_Rec(Infile L, AppendAddressAttributes.Key_Addr1 R) := TRANSFORM
			SELF.#EXPAND(appendPrefix + 'AdvoHitFlag') 										:=  IF(R.date_first_seen != '','Y','N');
			SELF.#EXPAND(appendPrefix + 'VacancyIndicator') 							:=  R.address_vacancy_indicator;
			SELF.#EXPAND(appendPrefix + 'ThrowBackIndicator') 						:=  R.throw_back_indicator;
			SELF.#EXPAND(appendPrefix + 'SeasonalDeliveryIndicator') 			:=  R.seasonal_delivery_indicator;
			SELF.#EXPAND(appendPrefix + 'SeasonalSuppressionStartDate') 	:=  R.seasonal_start_suppression_date;
			SELF.#EXPAND(appendPrefix + 'SeasonalSuppressionEndDate') 		:=  R.seasonal_end_suppression_date;
			SELF.#EXPAND(appendPrefix + 'DoNotDeliverIndicator') 					:=  R.dnd_indicator;
			SELF.#EXPAND(appendPrefix + 'CollegeIndicator') 							:=  R.college_indicator;
			SELF.#EXPAND(appendPrefix + 'CollegeSuppressionStartDate') 		:=  R.college_start_suppression_date;
			SELF.#EXPAND(appendPrefix + 'CollegeSuppressionEndDate') 			:=  R.college_end_suppression_date;	
			SELF.#EXPAND(appendPrefix + 'AddressStyle') 									:=  R.address_style_flag;
			SELF.#EXPAND(appendPrefix + 'SimplifyAddressCount') 					:=  R.simplify_address_count;
			SELF.#EXPAND(appendPrefix + 'DropIndicator') 									:=  R.drop_indicator;
			SELF.#EXPAND(appendPrefix + 'ResidentialOrBusinessIndicator') :=  R.residential_or_business_ind;
			SELF.#EXPAND(appendPrefix + 'OnlyWayToGetMailIndicator') 			:=  R.owgm_indicator;
			SELF.#EXPAND(appendPrefix + 'RecordTypeCode') 								:=  R.record_type_code;
			SELF.#EXPAND(appendPrefix + 'AdvoAddressType') 								:=  R.address_type;
			SELF.#EXPAND(appendPrefix + 'AddressUsageType') 							:=  R.mixed_address_usage;
			SELF.#EXPAND(appendPrefix + 'FirstSeenDate') 									:=  R.date_first_seen;
			SELF.#EXPAND(appendPrefix + 'LastSeenDate') 									:=  R.date_last_seen;
			SELF.#EXPAND(appendPrefix + 'VendorFirstReportedDate') 				:=  R.date_vendor_first_reported;
			SELF.#EXPAND(appendPrefix + 'VendorLastReportedDate') 				:=  R.date_vendor_last_reported;
			SELF.#EXPAND(appendPrefix + 'VacationBeginDate') 							:=  R.vac_begdt;
			SELF.#EXPAND(appendPrefix + 'VacationEndDate') 								:=  R.vac_enddt;
			SELF.#EXPAND(appendPrefix + 'NumberOfCurrentVacationMonths') 	:=  R.months_vac_curr;
			SELF.#EXPAND(appendPrefix + 'MaxVacationMonths') 							:=  R.months_vac_max;
			SELF.#EXPAND(appendPrefix + 'VacationPeriodsCount') 					:=  R.vac_count;
			SELF :=  L;
			SELF :=  R;
			SELF :=  [];
		END;
  
  OutPut_Rec_W_Seq tOutputPrep_Rec(Assign_Seq_No L, AppendAddressAttributes.Key_Addr1 R) :=  TRANSFORM
    SELF.#EXPAND(appendPrefix + 'AdvoHitFlag') 											:=  'Y';
    SELF.#EXPAND(appendPrefix + 'VacancyIndicator') 								:=  R.address_vacancy_indicator;
    SELF.#EXPAND(appendPrefix + 'ThrowBackIndicator') 							:=  R.throw_back_indicator;
    SELF.#EXPAND(appendPrefix + 'SeasonalDeliveryIndicator') 				:=  R.seasonal_delivery_indicator;
    SELF.#EXPAND(appendPrefix + 'SeasonalSuppressionStartDate') 		:=  R.seasonal_start_suppression_date;
    SELF.#EXPAND(appendPrefix + 'SeasonalSuppressionEndDate') 			:=  R.seasonal_end_suppression_date;
    SELF.#EXPAND(appendPrefix + 'DoNotDeliverIndicator') 						:=  R.dnd_indicator;
    SELF.#EXPAND(appendPrefix + 'CollegeIndicator') 								:=  R.college_indicator;
    SELF.#EXPAND(appendPrefix + 'CollegeSuppressionStartDate') 			:=  R.college_start_suppression_date;
    SELF.#EXPAND(appendPrefix + 'CollegeSuppressionEndDate')				:=  R.college_end_suppression_date;	
    SELF.#EXPAND(appendPrefix + 'AddressStyle')											:=  R.address_style_flag;
    SELF.#EXPAND(appendPrefix + 'SimplifyAddressCount') 						:=  R.simplify_address_count;
    SELF.#EXPAND(appendPrefix + 'DropIndicator') 										:=  R.drop_indicator;
    SELF.#EXPAND(appendPrefix + 'ResidentialOrBusinessIndicator') 	:=  R.residential_or_business_ind;
    SELF.#EXPAND(appendPrefix + 'OnlyWayToGetMailIndicator') 				:=  R.owgm_indicator;
    SELF.#EXPAND(appendPrefix + 'RecordTypeCode') 									:=  R.record_type_code;
    SELF.#EXPAND(appendPrefix + 'AdvoAddressType') 									:=  R.address_type;
    SELF.#EXPAND(appendPrefix + 'AddressUsageType') 								:=  R.mixed_address_usage;
    SELF.#EXPAND(appendPrefix + 'FirstSeenDate') 										:=  R.date_first_seen;
    SELF.#EXPAND(appendPrefix + 'LastSeenDate') 										:=  R.date_last_seen;
    SELF.#EXPAND(appendPrefix + 'VendorFirstReportedDate')					:=  R.date_vendor_first_reported;
    SELF.#EXPAND(appendPrefix + 'VendorLastReportedDate') 					:=  R.date_vendor_last_reported;
    SELF.#EXPAND(appendPrefix + 'VacationBeginDate') 								:=  R.vac_begdt;
    SELF.#EXPAND(appendPrefix + 'VacationEndDate') 									:=  R.vac_enddt;
    SELF.#EXPAND(appendPrefix + 'NumberOfCurrentVacationMonths') 		:=  R.months_vac_curr;
    SELF.#EXPAND(appendPrefix + 'MaxVacationMonths') 								:=  R.months_vac_max;
    SELF.#EXPAND(appendPrefix + 'VacationPeriodsCount') 						:=  R.vac_count;
    SELF :=  L;
    SELF := R;
    SELF := [];
  END;  

  ADVO_SM := JOIN(Infile, AppendAddressAttributes.Key_Addr1,
                     KEYED(LEFT.Input_Zip != '' AND LEFT.Input_Zip = RIGHT.zip) AND 
                     KEYED(LEFT.Input_Prim_Range = RIGHT.prim_range) AND
                     KEYED(LEFT.Input_PrimName = RIGHT.prim_name) AND
                     KEYED(LEFT.Input_Suffix = RIGHT.addr_suffix) AND
                     KEYED(LEFT.Input_PreDir = RIGHT.predir) AND
                     KEYED(LEFT.Input_PostDir = RIGHT.postdir) AND
                     KEYED(LEFT.Input_SecRange = '' OR LEFT.Input_SecRange = RIGHT.sec_range),
                     tOutput_Rec(LEFT, RIGHT),
                     KEEP(1), LEFT OUTER, KEYED);

  ADVO_LG_Prep := JOIN(AppendAddressAttributes.Key_Addr1, Assign_Seq_No,
                     RIGHT.Input_Zip != '' AND RIGHT.Input_Zip = LEFT.zip AND 
                     RIGHT.Input_Prim_Range = LEFT.prim_range AND
                     RIGHT.Input_PrimName = LEFT.prim_name AND
                     RIGHT.Input_Suffix = LEFT.addr_suffix AND
                     RIGHT.Input_PreDir = LEFT.predir AND
                     RIGHT.Input_PostDir = LEFT.postdir AND
                     (RIGHT.Input_SecRange = '' OR RIGHT.Input_SecRange = LEFT.sec_range),
           tOutputPrep_Rec(RIGHT, LEFT),
                    SMART, KEEP(1));	

  ADVO_LG := JOIN(Assign_Seq_No, ADVO_LG_Prep, LEFT.UniqueID = RIGHT.UniqueID, 
	                    TRANSFORM(Output_Rec, SELF := MAP(RIGHT.UniqueID > 0 => RIGHT, LEFT)), LEFT OUTER);

	
  ADVO_Results := MAP(COUNT(Infile) > UseIndexThreshold => ADVO_LG, ADVO_SM);

  ACA_Results := JOIN
        (
            ADVO_Results,
            PULL(AppendAddressAttributes.Key_ACA_Addr),
            LEFT.Input_PrimName = RIGHT.prim_name
                AND LEFT.Input_Prim_Range = RIGHT.prim_range
                AND (LEFT.Input_Zip != '' AND LEFT.Input_Zip = RIGHT.zip)
                AND LEFT.Input_SecRange = RIGHT.sec_range
                AND LEFT.Input_Suffix = RIGHT.addr_suffix
                AND LEFT.Input_PreDir = RIGHT.predir
                AND LEFT.Input_PostDir = RIGHT.postdir
                AND LEFT.Input_City = RIGHT.p_city_name
                AND LEFT.Input_St = RIGHT.st,
            TRANSFORM
                (
                    OutPut_Rec,
                    SELF.#EXPAND(appendPrefix + 'ACAHitFlag') := IF(RIGHT.inst_type != '','Y','N'),
                    SELF.#EXPAND(appendPrefix + 'Institution') := RIGHT.Institution,
                    SELF.#EXPAND(appendPrefix + 'InstitutionType') := RIGHT.inst_type,
                    SELF.#EXPAND(appendPrefix + 'InstitutionTypeExp') := RIGHT.inst_type_exp,
                    SELF.#EXPAND(appendPrefix + 'ACAAddressType') := RIGHT.addr_type,
                    SELF := LEFT
                ),
            LEFT OUTER, LOOKUP
        );
		
  RETURN ACA_Results;
	
ENDMACRO;

