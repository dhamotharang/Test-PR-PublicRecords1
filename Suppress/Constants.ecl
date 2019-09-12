IMPORT _control;
export Constants := module
	export dateMask := enum(unsigned1,NONE=0,DAY,MONTH,YEAR,ALL);
	Export NonSubjectSuppression := ENUM(integer1,notSpecified=0,doNothing,returnRestrictedDescription,returnBlank);
	Export set of integer1 ValidNSS_Set := [NonSubjectSuppression.doNothing,NonSubjectSuppression.returnRestrictedDescription,NonSubjectSuppression.returnBlank];
	
	/*
		If you add new application types, you are going to be redeploying all the related services
	*/
	Export ApplicationTypes := module
		export string32 PeopleWise := 'CON';
		export string32 Consumer := 'CON';
		export string32 LE := 'LE';
		export string32 DEFAULT := '';//Default suppression for standard Accurint products
	end;
	/*
		If you add new link types, you can get away with only redeploying the services that use the new link type
	*/
	Export LinkTypes := module
		export string5 DID := 'DID';
		export string5 BDID := 'BDID';
		export string5 SSN := 'SSN';
		export string5 FIELDSUPPRESS := 'FIELD';		
	end;
	/*
		If you add new doc types, you can get away with only redeploying the services that use the new doc type
	*/
	Export DocTypes := module
		export string15 FaresID := 'FARES ID';
		export string15 OffenderKey := 'OFFENDER KEY';
		export string15 OfficialRecord := 'OFFICIAL RECORD';
		export string15 RID := 'PHDR_RID';
		export string15 BK_TMSID := 'BK_TMSID';
		export string15 LIENS_TMSID := 'LIENS_TMSID';
		export string15 UCC_TMSID := 'UCC_TMSID';
		export string15 FDN_ID := 'FDN ID';
	end;
	/*
		If you add new products, you can get away with only redeploying the services that use that new product 
		designation.  However, if you add a new file that needs to apply to existing products, you are going to
		be redeploying all the related services
		NOTE...  Consumer and PeopleWise are going to be treated the same as per Lisa S.
	*/
	export set of String32 ProductAll :=['ALL'];//This is reserved for special Bob VanHusen data that needs to be removed from all products including LE
	export set of String32 ProductBadData :=['BADDATA'];//This is reserved for special situations where we want to remove bad data.
	export set of String32 ProductAccurint :=['ACCURINT'];//All Accurint products except LE
	export set of String32 ProductLE :=['LE']; // Law Enforcement
	export set of String32 ProductPeopleWise := ['PEOPLEWISE']; //ApplicationType := 'CON'
	export set of String32 ProductConsumer := ['CONSUMER']; //ApplicationType := 'CON'
	export set of String32 SuppressGeneral := ProductAll+ProductBadData+ProductAccurint+ProductLE;
	export set of String32 SuppressLE := ProductAll+ProductLE;
	export set of String32 SuppressPeopleWise := ProductAll+ProductBadData+ProductPeopleWise+ProductConsumer+ProductAccurint+ProductLE;
	export set of String32 SuppressConsumer := SuppressPeopleWise;//ProductAll+ProductBadData+ProductPeopleWise+ProductConsumer+ProductAccurint+ProductLE;
  
  // matches global mod definition
  EXPORT SSN_MASK_TYPE :=
    MODULE
      EXPORT STRING6 NONE   := 'NONE';
      EXPORT STRING6 ALL    := 'ALL';
      EXPORT STRING6 LAST4  := 'LAST4'; 
      EXPORT STRING6 FIRST5 := 'FIRST5';
    END;
    
  EXPORT DATE_MASK_TYPE :=
    MODULE
      EXPORT STRING6 NONE  := 'NONE';
      EXPORT STRING6 ALL   := 'ALL';
      EXPORT STRING6 DAY   := 'DAY'; 
      EXPORT STRING6 MONTH := 'MONTH';
      EXPORT STRING6 YEAR  := 'YEAR';
    END;

	//	Server IP to Spray from
	EXPORT	STRING serverIP	:=	IF(_Control.thisenvironment.name='Dataland',
																					_Control.IPAddress.bctlpedata12,
																					_Control.IPAddress.bctlpedata11);

	EXPORT OptOut := MODULE
	
		//	Directory to Spray from
		EXPORT	STRING Directory					:=	IF(	_control.thisenvironment.name='Dataland',
																										'/data/hds_2/suppress_opt_out_src/',
																										'/data/hds_2/suppress_opt_out_src/');
		EXPORT STRING FileToSpray 			:= '*.txt';		
		EXPORT SET OF UNSIGNED4 CACCPA_Global_Sid := [	23361,23371,23381,8271,23311,22751,22911,23571,24051,24141,23431,22401,23421,25751,25041,27581,27001,24011,23401,23411,16281,16331,22611,24591,24361,22771,24371,23611,23621,24351,24961,25651,19521,25681,25901,27651,24221,23461,23471,23481,23781,24911,23581,26631,23591,22661,22671,22691,23561,23451,22651,22921,22641,22961,22971,22981,22991,23001,23011,23021,23031,23041,23051,23061,23071,23121,22371,22381,23441,22601,14761,23601,27441,23931,23961,23991,27621,25371,17591,17871,26651,24611,24641,23231,25031,24451,25471,25781,25721,25321,27591,22681,23241,25791,26041,26051,26061,26191,26211,23521,23531,24261,26541,26641,23161,26671,26881,23331,27681,27161,27371,27381,27571,24331,25731,26521,27641];
	END;	

END;