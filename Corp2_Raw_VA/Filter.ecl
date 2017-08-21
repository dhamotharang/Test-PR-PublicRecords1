IMPORT corp2_mapping;

EXPORT Filter := MODULE
	//********************************************************************
	//Filter: The purpose of this attribute is to filter out "known" bad
	//				records that data insight has indicated are no longer to be
	//				rejected by scrubs.
	//
	//				Please be very specific on your filter to eliminate the 
	//				possibility of filtering out valid records.
	//********************************************************************
	
	//********************************************************************
	//Event Filter
	//********************************************************************
	EXPORT Events(DATASET(corp2_mapping.layoutscommon.events) pinfile) := Function
		RETURN pinfile;
	END;
	
	//********************************************************************
	//Main Filter
	//Note: Please document the date, issue and who authorized the removal 
	//			of specific records.	
	//-08/31/2016 remove bad corp keys '51-,735192','51-B\\\\\\496' and 
	//						'51-+165136' per Rosemary Murphy
	//-09/01/2016 remove bad corp keys '51-3650520','51-B397438','51-B633842',
	//						'51-MMM0557' and '51-VA20845' per Rosemary Murphy	
	//********************************************************************
	EXPORT Main(DATASET(corp2_mapping.layoutscommon.main) pinfile) := Function
		invalid_corp_keys 					:= [
																		'51-,735192','51-B\\\\\\496','51-+165136','51-3650520','51-B397438',
																		'51-B633842','51-MMM0557','51-VA20845'
																	 ];

		filterout_invalid_corp_keys := pinfile(corp_key not in [invalid_corp_keys]);

		valid_main_file 						:= filterout_invalid_corp_keys;

		RETURN valid_main_file;
	END;
	
	//********************************************************************
	//Stock Filter
	//********************************************************************
	EXPORT Stock(DATASET(corp2_mapping.layoutscommon.stock) pinfile) := Function
		RETURN pinfile;
	END;

END;