IMPORT ut, YellowPages;
EXPORT Rollup_Base( DATASET(YellowPages.Layout_YellowPages_Base_v2_bip) pDataset) := FUNCTION

  Base_layout := YellowPages.Layout_YellowPages_Base_v2_bip;

	pDataset_Dist := DISTRIBUTE(pDataset, HASH(Primary_key));
	pDataset_sort := SORT(pDataset_Dist 
                       ,primary_key
                       ,business_name
	                     ,orig_street
                       ,orig_city
                       ,orig_state
                       ,orig_zip
                       ,orig_phone10
                       ,phone10
                       ,heading_string
                       ,sic_code
                       ,toll_free_indicator
                       ,fax_indicator
                       ,index_value
                       ,naics_code
                       ,web_address
                       ,email_address
                       ,employee_code
                       ,executive_title
                       ,executive_name
                       ,derog_legal_indicator
                       ,bus_name_flag
                       ,aka_name
                       ,address_override
                       ,phone_override
                       ,phone_type
                       ,source 								   
                       ,ChainID
                       ,BusShortName
                       ,BusDeptName
                       ,FIPS
                       ,CountyCode
                       ,SIC2
                       ,SIC3
                       ,SIC4
                       ,IndstryClass
                       ,NoSolicitCode
                       ,DSO
                       ,SingleAddrFlag      
                       ,DPC                     //When running first time with patched file, comment out
                       ,CarrierRoute            //from DPC down to TotalADSpend
                       ,Z4Type
                       ,CTract
                       ,CBlockGroup
                       ,CBlockID
                       ,CBSA
                       ,MCDCode
                       ,AddrSensitivity
                       ,MailDeliverabilityCode
                       ,SIC1_4
                       ,MLSC
                       ,ValidationFlag
                       ,SecValidationCode
                       ,Gender
                       ,ExecName
                       ,ExecTitleCode
                       ,ExecTitle
                       ,CondTitleCode
                       ,CondTitle
                       ,ContFunctionCode
                       ,ContFunction
                       ,Profession
                       ,EmplSizeCode
                       ,AnnualSalesCode
                       ,YrsInBus
                       ,EthnicCode
                       ,YPHeading2
                       ,YPHeading3
                       ,YPHeading4
                       ,YPHeading5
                       ,YPHeading6
                       ,MaxYPADSize
                       ,FaxAC
                       ,FaxExchge
                       ,FaxPhone
                       ,AltAC
                       ,AltExchge
                       ,AltPhone
                       ,MobileAC
                       ,MobileExchge
                       ,MobilePhone
                       ,TollFreeAC
                       ,TollFreeExchge
                       ,TollFreePhone
                       ,CreditCards
                       ,Brands
                       ,StdHrs
                       ,HrsOpen
                       ,Services
                       ,CondHeading
                       ,Tagline
                       ,TotalADSpend                //End of commented out code for first run
                       ,-pub_date
                       ,-dt_vendor_last_reported
											 ,LOCAL);
	
	Base_layout RollupUpdate(Base_layout l, Base_layout r) := TRANSFORM
		SELF.dt_first_seen          	       := ut.EarliestDate(l.dt_first_seen,             r.dt_first_seen	            );
		SELF.dt_last_seen          	         := MAX  (l.dt_last_seen,              r.dt_last_seen	            );
		SELF.dt_vendor_last_reported 	       := MAX  (l.dt_vendor_last_reported,   r.dt_vendor_last_reported	  );
		SELF.dt_vendor_first_reported        := ut.EarliestDate(l.dt_vendor_first_reported,  r.dt_vendor_first_reported	);
		SELF.record_type							       := IF(l.record_type = 'C' OR r.record_type = 'C', 'C', 'H');
		SELF.source_rec_id						       := IF(l.source_rec_id <= r.source_rec_id AND l.source_rec_id <> 0, l.source_rec_id,
                                               IF(r.source_rec_id <> 0, r.source_rec_id, l.source_rec_id));
		SELF.ValidationDate       	         := (STRING8)MAX((UNSIGNED4)l.ValidationDate, (UNSIGNED4)r.ValidationDate );
		SELF                                 := l;
	END;

	pDataset_rollup := ROLLUP( pDataset_sort
                            ,RollupUpdate(LEFT, RIGHT)
                            ,primary_key
                            ,business_name
	                          ,orig_street
                            ,orig_city
                            ,orig_state
                            ,orig_zip
                            ,orig_phone10
                            ,heading_string
                            ,sic_code
                            ,toll_free_indicator
                            ,fax_indicator
                            ,index_value
                            ,naics_code
                            ,web_address
                            ,email_address
                            ,employee_code
                            ,executive_title
                            ,executive_name
                            ,derog_legal_indicator
                            ,bus_name_flag
                            ,aka_name
                            ,address_override
                            ,phone_override
                            ,phone_type
                            ,source 								   
                            ,ChainID
                            ,BusShortName
                            ,BusDeptName
                            ,FIPS
                            ,CountyCode
                            ,SIC2
                            ,SIC3
                            ,SIC4
                            ,IndstryClass
                            ,NoSolicitCode
                            ,DSO
                            ,SingleAddrFlag      
                            ,DPC                            //When running first time with patched file, comment out
                            ,CarrierRoute                   //from DPC down to TotalADSpend
                            ,Z4Type
                            ,CTract
                            ,CBlockGroup
                            ,CBlockID
                            ,CBSA
                            ,MCDCode
                            ,AddrSensitivity
                            ,MailDeliverabilityCode
                            ,SIC1_4
                            ,MLSC
                            ,ValidationFlag
                            ,SecValidationCode
                            ,Gender
                            ,ExecName
                            ,ExecTitleCode
                            ,ExecTitle
                            ,CondTitleCode
                            ,CondTitle
                            ,ContFunctionCode
                            ,ContFunction
                            ,Profession
                            ,EmplSizeCode
                            ,AnnualSalesCode
                            ,YrsInBus
                            ,EthnicCode
                            ,YPHeading2
                            ,YPHeading3
                            ,YPHeading4
                            ,YPHeading5
                            ,YPHeading6
                            ,MaxYPADSize
                            ,FaxAC
                            ,FaxExchge
                            ,FaxPhone
                            ,AltAC
                            ,AltExchge
                            ,AltPhone
                            ,MobileAC
                            ,MobileExchge
                            ,MobilePhone
                            ,TollFreeAC
                            ,TollFreeExchge
                            ,TollFreePhone
                            ,CreditCards
                            ,Brands
                            ,StdHrs
                            ,HrsOpen
                            ,Services
                            ,CondHeading
                            ,Tagline
                            ,TotalADSpend                   //End of commented out code for first run              
														,LOCAL);

	
	// --for update that is not full file
	dnotfull_sort 			:= SORT	(pDataset_rollup,      Primary_key, LOCAL	);
	dnotfull_group			:= GROUP(pDataset_sort,        Primary_key, LOCAL	);
	dnotfull_sort_group	:= SORT	(dnotfull_group,       -dt_vendor_last_reported	);

	Base_layout SetRecordType(Base_layout L, Base_layout R) := TRANSFORM
		SELF.record_type	:= IF(L.record_type = '', 'C', R.record_type);
		SELF							:= R;
	END;

	dSetRecordType := GROUP(ITERATE(dnotfull_sort_group, SetRecordType(LEFT, RIGHT)));

	output_dataset := IF(_Flags.IsUpdateFullFile, pDataset_rollup, dSetRecordType);

	RETURN output_dataset;

END;