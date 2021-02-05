import Risk_Indicators, STD, data_services, dx_header;
EXPORT get_mas_build_dates(STRING variable_name) := FUNCTION
	
	//this function is similar to vault Risk_Indicators.get_build_date.  
	//if you add a build date to this list you must add a constent to PublicRecords_KEL.Library.LIB_BusinessAttributes
	IsFCRA := FALSE : STORED('isFCRA');	
	 
	unsigned1 iType := IF(IsFCRA, data_services.data_env.iFCRA, data_services.data_env.iNonFCRA);

	today := (STRING8)STD.Date.Today();
	invalid := (STRING8)'';
	
	varName := STD.Str.ToLowerCase(variable_name);
	dateFormat := '%Y%m%d';
	
	//FCRA and nonFCRA datasets
	Advo :=  Risk_Indicators.get_build_date('cds_build_version') : STORED('cds_build_version');
	aircraft := Risk_Indicators.get_build_date('faa_build_version') : STORED('faa_build_version');
	AmericanStudent := Risk_Indicators.get_build_date('fcra_asl_build_version') : STORED('asl_build_version');
	
	bankruptcy :=   Risk_Indicators.get_build_date('Bankruptcy_daily') : STORED('Bankruptcy_daily');
	criminal := Risk_Indicators.get_build_date('doc_build_version') : STORED('doc_build_version');
	email := IF(IsFCRA, Risk_Indicators.get_build_date('fcra_email_build_version'), Risk_Indicators.get_build_date('email_build_version')) : STORED('email_build_version');
	gong := Risk_Indicators.get_build_date('Gong_weekly') : STORED('Gong_weekly');//this says 'weelky' but its really the gong daily build
	Inquiry := IF(IsFCRA, Risk_Indicators.get_build_date('inquiry_build_version'), MAX(Risk_Indicators.get_build_date('inquiry_build_version'),Risk_Indicators.get_build_date('inquiry_update_build_version'))) : STORED('inquiry_build_version');//attrs
	liens := Risk_Indicators.get_build_date('liens_build_version') : STORED('liens_build_version');
	
	// person header is from max date last seen key not env vars
	// env var is based off of build date but that can be up to a month a head of max date last seen due to monthly updates of the normal header build
	//dk := choosen(dx_header.key_max_dt_last_seen(iType), 1);
	//max_last_seen := (string) dk[1].max_date_last_seen;
	//hdrBuildDate01 := max_last_seen[1..6]+'01';
	//personHeader := hdrBuildDate01;
	personHeader :=  Risk_Indicators.get_build_date('header_build_version') : STORED('header_build_version'); 

	Mari := Risk_Indicators.get_build_date('mari_build_version') : STORED('mari_build_version');
	Proflic := Risk_Indicators.get_build_date('proflic_build_version') : STORED('proflic_build_version');
	property := IF(IsFCRA, Risk_Indicators.get_build_date('FCRA_Property_Build_Version') , Risk_Indicators.get_build_date('Property_Build_Version')) : STORED('Property_Build_Version');
	targus := Risk_Indicators.get_build_date('targus_build_version') : STORED('targus_build_version');
	thrive := Risk_Indicators.get_build_date('thrive_build_version') : STORED('thrive_build_version');
	watercraft := Risk_Indicators.get_build_date('watercraft_build_version') : STORED('watercraft_build_version');
	
	//nonFCRA only datasets
	BIPHeader := IF(~IsFCRA, Risk_Indicators.get_build_date('bip_build_version'), invalid) : STORED('bip_build_version');
	corp := IF(~IsFCRA, Risk_Indicators.get_build_date('corp_build_version'), invalid) : STORED('corp_build_version');
	cortera := IF(~IsFCRA, Risk_Indicators.get_build_date('cortera_build_version'), invalid) : STORED('cortera_build_version');
	Ecrash := IF(~IsFCRA, Risk_Indicators.get_build_date('ecrash_build_version'), invalid) : STORED('ecrash_build_version');
	fp3 := IF(~IsFCRA, Risk_Indicators.get_build_date('fraudpoint3_build_version'), invalid) : STORED('fraudpoint3_build_version');
	RiskTable := IF(~IsFCRA, Risk_Indicators.get_build_date('risktable_build_version'), invalid) : STORED('risktable_build_version'); //attrs
	utility := IF(~IsFCRA, Risk_Indicators.get_build_date('utility_build_version'), invalid): STORED('utility_build_version');
	Vehicle := IF(~IsFCRA, Risk_Indicators.get_build_date('vehicle_build_version'), invalid) : STORED('vehicle_build_version');
	ucc := IF(~IsFCRA,Risk_Indicators.get_build_date('ucc_version'), invalid) : STORED('ucc_build_version');
	phonesplus := IF(~IsFCRA, Risk_Indicators.get_build_date('phonesplusv2_build_version'), invalid) : STORED('phonesplusv2_build_version');
	phonemetadata := IF(~IsFCRA, Risk_Indicators.get_build_date('pphones_build_version'), invalid) : STORED('pphones_build_version');
	forclosure := IF(~IsFCRA, Risk_Indicators.get_build_date('Foreclosure_Build_Version'), invalid) : STORED('Foreclosure_Build_Version');
	sam := IF(~IsFCRA, Risk_Indicators.get_build_date('Sam_build_version'), invalid) : STORED('Sam_build_version');
	
	//FCRA only
	optout := IF(IsFCRA, Risk_Indicators.get_build_date('fcra_optout_version'), invalid) : STORED('fcra_optout_version');
	
	
	
	// Check that the Date we pulled is a Valid Date - if not Valid, use Today as the Date instead
/*************** the var names below MUST be in ALL lower case*************/	
	
	buildDate := MAP(
		varName = 'faa_build_version' AND STD.Date.IsValidDate(STD.Date.FromStringToDate(aircraft, dateFormat))																=> aircraft,
		varName = 'asl_build_version' AND STD.Date.IsValidDate(STD.Date.FromStringToDate(AmericanStudent, dateFormat)) 												=> AmericanStudent,
		varName = 'bankruptcy_daily' AND STD.Date.IsValidDate(STD.Date.FromStringToDate(bankruptcy, dateFormat)) 															=> bankruptcy,
		varName = 'bip_build_version' AND STD.Date.IsValidDate(STD.Date.FromStringToDate(BIPHeader, dateFormat)) 															=> BIPHeader,
		varName = 'cortera_build_version' AND STD.Date.IsValidDate(STD.Date.FromStringToDate(cortera, dateFormat)) 														=> cortera,
		varName = 'doc_build_version' AND STD.Date.IsValidDate(STD.Date.FromStringToDate(criminal, dateFormat))																=> criminal,
		varName = 'inquiry_build_version' AND STD.Date.IsValidDate(STD.Date.FromStringToDate(inquiry, dateFormat)) 														=> inquiry,
		varName = 'liens_build_version' AND STD.Date.IsValidDate(STD.Date.FromStringToDate(liens, dateFormat)) 																=> liens,
		varName = 'header_build_version' AND STD.Date.IsValidDate(STD.Date.FromStringToDate(personHeader, dateFormat)) 												=> personHeader,
		varName = 'targus_build_version' AND STD.Date.IsValidDate(STD.Date.FromStringToDate(targus, dateFormat)) 															=> targus,
		varName = 'proflic_build_version' AND STD.Date.IsValidDate(STD.Date.FromStringToDate(Proflic, dateFormat))    												=> Proflic,
		varName = 'property_build_version' AND STD.Date.IsValidDate(STD.Date.FromStringToDate(property, dateFormat)) 													=> property,
		varName = 'watercraft_build_version' AND STD.Date.IsValidDate(STD.Date.FromStringToDate(watercraft, dateFormat)) 											=> watercraft,
		varName = 'vehicle_build_version' AND STD.Date.IsValidDate(STD.Date.FromStringToDate(Vehicle, dateFormat)) 														=> Vehicle,
		varName = 'ucc_build_version' AND STD.Date.IsValidDate(STD.Date.FromStringToDate(ucc, dateFormat)) 																		=> ucc,
		varName = 'email_build_version' AND STD.Date.IsValidDate(STD.Date.FromStringToDate(email, dateFormat)) 																=> email,
		varName = 'cds_build_version' AND STD.Date.IsValidDate(STD.Date.FromStringToDate(Advo, dateFormat)) 																	=> Advo,
		varName = 'corp_build_version' AND STD.Date.IsValidDate(STD.Date.FromStringToDate(corp, dateFormat)) 																	=> corp,
		varName = 'mari_build_version' AND STD.Date.IsValidDate(STD.Date.FromStringToDate(mari, dateFormat)) 																	=> mari,
		varName = 'risktable_build_version' AND STD.Date.IsValidDate(STD.Date.FromStringToDate(risktable, dateFormat)) 												=> risktable,
		varName = 'utility_build_version' AND STD.Date.IsValidDate(STD.Date.FromStringToDate(utility, dateFormat)) 														=> utility,
		varName = 'ecrash_build_version' AND STD.Date.IsValidDate(STD.Date.FromStringToDate(Ecrash, dateFormat)) 															=> Ecrash,
		varName = 'thrive_build_version' AND STD.Date.IsValidDate(STD.Date.FromStringToDate(thrive, dateFormat)) 															=> thrive,
		varName = 'fraudpoint3_build_version' AND STD.Date.IsValidDate(STD.Date.FromStringToDate(fp3, dateFormat)) 														=> fp3,
		varName = 'phonesplusv2_build_version' AND STD.Date.IsValidDate(STD.Date.FromStringToDate(phonesplus, dateFormat)) 										=> phonesplus,
		varName = 'pphones_build_version' AND STD.Date.IsValidDate(STD.Date.FromStringToDate(phonemetadata, dateFormat)) 											=> phonemetadata,
		varName = 'foreclosure_build_Version' AND STD.Date.IsValidDate(STD.Date.FromStringToDate(phonemetadata, dateFormat)) 									=> forclosure,
		varName = 'sam_build_version' AND STD.Date.IsValidDate(STD.Date.FromStringToDate(phonemetadata, dateFormat)) 													=> sam,
		varName = 'fcra_optout_version' AND STD.Date.IsValidDate(STD.Date.FromStringToDate(phonemetadata, dateFormat)) 												=> optout,
		varName = 'gong_weekly' AND STD.Date.IsValidDate(STD.Date.FromStringToDate(gong, dateFormat)) 																				=> gong,
	
	today);

	RETURN buildDate;
END;
