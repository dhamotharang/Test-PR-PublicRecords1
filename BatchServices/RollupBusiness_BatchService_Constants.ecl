EXPORT RollupBusiness_BatchService_Constants := MODULE

	EXPORT Defaults := MODULE
	
		EXPORT UNSIGNED1 DPPAPURPOSE      := 0;
		EXPORT UNSIGNED1 GLBPURPOSE       := 0;
		EXPORT UNSIGNED1 FUZZINESSDIAL    := 0;
		EXPORT UNSIGNED1 MAXRESULTSPERROW := 5;
		EXPORT UNSIGNED1 PENALTTHRESHOLD  := 20;  // 20110602 Increased the penalty default to 20
		                                          // because with the default at 10 and the penalties
															   // all added together we were missing hits (for example: 
															   // input address has phone, unit_desig & sec_range.  Our hit
															   // didn't have the unit_desig or sec_range (all other addr 
															   // fields matched except the z4) and had a different phone.  
															   // The addr_penalt was 11, phone was 9. Input record: 
  														      // Alltell 1 Allied Dr, Little Rock, AZ 72202-2099
	END;
	
	EXPORT Limits := MODULE
	
		EXPORT UNSIGNED4 GROUPID_KEEP        := 1;
		EXPORT UNSIGNED4 RELATIVES_LIMIT     := 10000;
		EXPORT UNSIGNED4 RELATIVES_KEEP      := 1000;
		EXPORT UNSIGNED4 SUFFICIENT_NUMBER_OF_RELATIVES_AT_THIS_LEVEL := 50;
		EXPORT UNSIGNED4 BEST_KEEP           := 1;
		EXPORT UNSIGNED4 EXTRABEST_KEEP      := 2000;
		EXPORT UNSIGNED4 EXTRABEST_LIMIT     := 10000;
		EXPORT UNSIGNED4 PENALTY_LIMIT       := 10000;
		EXPORT UNSIGNED4 PENALTY_KEEP        := 10000;
		EXPORT UNSIGNED4 SIC_CODE_KEEP       := 10000;
		EXPORT UNSIGNED4 LIENS_TMSIDS_KEEP   := 10000;
		EXPORT UNSIGNED4 LIENS_RECORDS_LIMIT := 10000;
		EXPORT UNSIGNED4 LIENS_RECORDS_KEEP  := 1;
		EXPORT UNSIGNED4 CONTACTS_KEEP       := 10000;
		EXPORT UNSIGNED4 PROPERTIES_KEEP     := 10000;
		EXPORT UNSIGNED4 CORPS_KEEP          := 10000;
		EXPORT UNSIGNED4 DCA_KEEP            := 10000;
	
	END;

END;
