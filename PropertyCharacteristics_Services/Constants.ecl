
export	Constants	:=
module

	export	ValidCategories	:=	[	'001','002','003','004','005','006','007','008','009',
																'010','011','012','013','014','015','016','017','018',
																'019','020','021','022','023','024','025','026','027'
															];
	
	// Report Constants
	export	Version					:=	'1.0';
	export	ProductID				:=	'23';
	export	ProductCode			:=	'PROPDATA';
	export	ProcessType			:=	ENUM(UNSIGNED1,UNDETERMINED=0,REQUEST,RESPONSE,CONTEXT,INTERNAL);
	export	ProcessingTime	:=	'0.00';
	export	SourceCode			:=	'INHOUSE';

	// Error codes exposed to a customer
	export	ErrorCodes	:=	ENUM(	unsigned1,
																INVALID_REPORT_TYPE,
																INSUFFICIENT_ADDRESS,
																LAST_NAME_REQUIRED,
																FIRST_NAME_REQUIRED,
																SINGLE_FAMILY_ERROR,
																LIVING_AREA_SQFT_REQUIRED,
																PROP_CHAR_INVALID_CATEGORY,
																PROP_CHAR_MATERIAL_REQUIRED,
																PROP_CHAR_VALUE_REQUIRED,
																PROP_DESC_REQUIRED,
																PROP_DESC_VALUE_REQUIRED,
																GATEWAY_XML_ERROR,
																GATEWAY_EXCEPTION
															);

	// Internal error codes
	export	InternalCodes	:=	ENUM(	UNSIGNED8,
																INVALID_REPORT_TYPE=1,
																INSUFFICIENT_ADDRESS=2,
																LAST_NAME_REQUIRED=4,
																FIRST_NAME_REQUIRED=8,
																SINGLE_FAMILY_ERROR=16,
																LIVING_AREA_SQFT_REQUIRED=32,
																PROP_CHAR_INVALID_CATEGORY=64,
																PROP_CHAR_MATERIAL_REQUIRED=128,
																PROP_CHAR_VALUE_REQUIRED=256,
																PROP_DESC_REQUIRED=512,
																PROP_DESC_VALUE_REQUIRED=1024,
																GATEWAY_XML_ERROR=2048,
																GATEWAY_EXCEPTION=4096,
																INVALID_PRODUCT=8192 // used by batch only so far
															);
	// Note: two sets of errors above must be in sync; they could be defined through each other,
	// but considering they both are small I preferred to keep it simple.

	// Error message dataset
	export	dErrors	:=	dataset([
		{InternalCodes.INVALID_REPORT_TYPE, 				ErrorCodes.INVALID_REPORT_TYPE,'INVALID REPORT TYPE PROVIDED'},
		{InternalCodes.INSUFFICIENT_ADDRESS,				ErrorCodes.INSUFFICIENT_ADDRESS,'BAD OR INSUFFICIENT ADDRESS PROVIDED'},
		{InternalCodes.LAST_NAME_REQUIRED,					ErrorCodes.LAST_NAME_REQUIRED,'LAST NAME MISSING'},
		{InternalCodes.FIRST_NAME_REQUIRED,					ErrorCodes.FIRST_NAME_REQUIRED,'FIRST NAME MISSING'},
		{InternalCodes.SINGLE_FAMILY_ERROR,					ErrorCodes.SINGLE_FAMILY_ERROR,'PROPERTY NOT A SINGLE FAMILY RESIDENCE'},
		{InternalCodes.LIVING_AREA_SQFT_REQUIRED,		ErrorCodes.LIVING_AREA_SQFT_REQUIRED,'LIVING AREA SQUARE FOOTAGE REQUIRED'},
		{InternalCodes.PROP_CHAR_INVALID_CATEGORY,	ErrorCodes.PROP_CHAR_INVALID_CATEGORY,'INVALID CATEGORY CODE IN PROPERTY CHARACTERISTICS'},
		{InternalCodes.PROP_CHAR_MATERIAL_REQUIRED,	ErrorCodes.PROP_CHAR_MATERIAL_REQUIRED,'MATERIAL MISSING IN PROPERTY CHARACTERISTICS'},
		{InternalCodes.PROP_CHAR_VALUE_REQUIRED,		ErrorCodes.PROP_CHAR_VALUE_REQUIRED,'VALUE MISSING IN PROPERTY CHARACTERISTICS'},
		{InternalCodes.PROP_DESC_REQUIRED,					ErrorCodes.PROP_DESC_REQUIRED,'DESCRIPTION MISSING IN PROPERTY DESCRIPTION'},
		{InternalCodes.PROP_DESC_VALUE_REQUIRED,		ErrorCodes.PROP_DESC_VALUE_REQUIRED,'VALUE MISSING IN PROPERTY DESCRIPTION'}
	], layouts.errors_rec);
	
	export	ESPMethod	:=	'PropertyInformation';

  export unsigned1 MAX_IDS_PER_ADDRESS := 20; // so far ~15

  export PRODUCT := module
    export integer1 DEFAULT    := 0; // meaning, not relevant (for example, in non-batch query)
    export integer1 PROPERTY   := 1;
    export integer1 INSPECTION := 2;
  end;

	// Home Gateway Report Constants
	export HGW_Agent       := '4127';
	export HGW_Underwriter := '4111';
	export HGW_ReportCodes := [HGW_Agent,HGW_Underwriter];
	export Underwriter     := 'U';
	export Agent           := 'A';
	
	EXPORT Default_Option  													:= 'DO';
	EXPORT Default_Plus_Option  								:= 'DPO';
	EXPORT Selected_Source_Option  					:= 'SS';
	EXPORT Selected_Source_Plus_Option  := 'SSP';
	
	EXPORT MSL_Src  							:= 'MLS';
	
	EXPORT MLS_Global_Source_ID	:= 27621;
	EXPORT log_extension_type		:= 52;
	EXPORT DID_SCORE_THRESHOLD	:= 80;

  /*Default Option (report type P) - Corelogic (D) and Blacknight (B)
	Default Option (report type I) - Best of Corelogic and Blacknight (A)
	Default Plus Option (report type P) - Corelogic (D) + best of Blacknight (B) and mls(E)
	Default Plus Option (report type I) -  Best of Corelogic and Blacknight (A)
	Selected Source - best of all sources (F)
	Selected Source Plus – best of all sources (F) and all underlying source data -Corelogic (D), Blacknight (B) and mls(E)*/
  EXPORT Property_ReportType          := 'P';
  EXPORT Inspection_ReportType        := 'I';

  EXPORT Best_CoreLogic_Blacknight    := 'A';
  EXPORT Blacknight_LocalizedAverages := 'B';
  EXPORT Blacknight                   := 'C';
  EXPORT CoreLogic                    := 'D';
  EXPORT MLS                          := 'E';
  EXPORT Best_AllSources              := 'F';
  EXPORT Best_All_NoMLS               := 'G';

end;