IMPORT ut;
IMPORT Data_Services;
EXPORT Constants := MODULE

	export cluster											:= '~thor_data400::';
	
  export keyServerPointer := //FileNames.keyCluster; //'~'; // to switch to production, change server. Example: ut.foreign_prod
				 Data_services.Data_location.Prefix('Property'); // Use this attribute to assist query developer / deployment

	// Autokey constants
	export ak(boolean isFast) := MODULE
		shared  keyPrefix										:= if(isFast,'property_fast','ln_propertyV2');
		shared  keySuffix										:= '';//if(isFast,'z','y');
		export	keyname											:=	cluster	+	'key::'+keyPrefix+'::autokey::';
		export	logical(string	filedate)		:=	cluster	+	'key::ln_propertyV2::'	+	filedate + keySuffix	+	'::autokey::';
		export	data_set										:=	LN_PropertyV2_Fast.file_search_autokey(isFast);
		export	typeStr											:=	'\'AK\'';
		export	skipSet											:=	[];
	END;
	
	export email_recipients := 'Sudhir.Kasavajjala@lexisnexis.com, Robert.Berger@lexisnexis.com, Angela.Herzberg@lexisnexis.com;';
	export email_DL_reports := 'Jessica.Mills@lexisnexis.com,Carlo.Ramos1@lexisnexis.com,Erol.Macalino@lexisnexis.com,Benedict.Flores@lexisnexis.com,Telra.Moore@lexisnexis.com,Jessica.Mills@lexisnexis.com,Robert.Berger@lexisnexis.com,Angela.Herzberg@lexisnexis.com';
	export email_DL_export  := 'Sudhir.Kasavajjala@lexisnexis.com, Robert.Berger@lexisnexis.com';
	
END;