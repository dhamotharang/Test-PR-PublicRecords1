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
	//-03/08/2017 remove bad corp keys that begin with "BAT" and followed
	//						by a digit - per Rosemary Murphy
	//********************************************************************
	EXPORT Main(DATASET(corp2_mapping.layoutscommon.main) pinfile) := Function
		invalid_corp_keys 					:= ['08-BAT1'	,	'08-BAT2'	,	'08-BAT3'	,'08-BAT4' ,'08-BAT5'	,'08-BAT6' ,'08-BAT7' ,'08-BAT8' ,'08-BAT9' ,'08-BAT10',
																		'08-BAT11',	'08-BAT12',	'08-BAT13','08-BAT14','08-BAT15','08-BAT16','08-BAT17','08-BAT18','08-BAT19','08-BAT20',
																		'08-BAT21',	'08-BAT22',	'08-BAT23','08-BAT24','08-BAT25','08-BAT26','08-BAT27','08-BAT28','08-BAT29','08-BAT30',
																		'08-BAT31',	'08-BAT32',	'08-BAT33','08-BAT34','08-BAT35','08-BAT36','08-BAT37','08-BAT38','08-BAT39','08-BAT40',
																		'08-BAT41',	'08-BAT42',	'08-BAT43','08-BAT44','08-BAT45','08-BAT46','08-BAT47','08-BAT48','08-BAT49','08-BAT50',
																		'08-BAT51',	'08-BAT52',	'08-BAT53','08-BAT54','08-BAT55','08-BAT56','08-BAT57','08-BAT58','08-BAT59','08-BAT60',
																		'08-BAT61',	'08-BAT62',	'08-BAT63','08-BAT64','08-BAT65','08-BAT66','08-BAT67','08-BAT68','08-BAT69','08-BAT70'
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