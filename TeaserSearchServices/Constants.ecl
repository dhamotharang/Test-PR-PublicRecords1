EXPORT Constants := MODULE
     
	EXPORT addrMaskString := '****';
	EXPORT phoneMaskString := '***-****';
	EXPORT AtSign := '@';
	EXPORT layout_string := RECORD
	        STRING75 CategoryString;
	END;
	EXPORT   Category 		 :=     dataset( [{'addresses_cnt'},
												           {'PhonesPlus_cnt'},
											                 {'Email_cnt'},
													       {'Education_Student_cnt'},
												             {'Possible_Relatives_and_Associates_cnt'},
														   {'Possible_Properties_owned_cnt'},
														   {'Criminal_Records_cnt'},
													         {'Sexual_Offenses_cnt'},
														    {'Liens_and_Judgements_cnt'},
														    { 'Bankruptcies_cnt'},
															{'Marriage_and_Divorce_cnt'},
															{'Professional_Licenses_cnt'},
															{'People_at_Work_possible_employment_records_cnt'},
															{'Businesses_records_cnt'},
															{'Corporate_affiliations_cnt'},
															{'UCC_cnt'},
															{'Hunting_and_Fishing_Permits_cnt'},
															{'Concealed_Weapon_Permits_cnt'},
															{'Firearms_and_Explosives_cnt'},
															{'FAA_Aircraft_cnt'},
															{'FAA_Pilot_cnt'}],layout_string);
	EXPORT AddressTeaser := MODULE
		EXPORT MaxNames := 15;
		EXPORT MaxAddresses := 15;
		EXPORT StartDOB := 1900;
		EXPORT MaxPenalt := 5;
		EXPORT KeepLimitProperty := 10000;
		EXPORT KeepLimitYearBuilt := 1000;
		EXPORT RESIDENTIAL := 'Residential';
		EXPORT BUSINESS := 'Business';
	END;
  
  EXPORT CONSUMER_IND_CLASS := 'CNSMR';
END;