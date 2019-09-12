export Constants := module
	export dateMask := enum(unsigned1,NONE=0,DAY,MONTH,YEAR,ALL);
	Export NonSubjectSuppression := ENUM(integer1,notSpecified=0,doNothing,returnRestrictedDescription,returnBlank,returnNameOnly);
	Export set of integer1 ValidNSS_Set := [NonSubjectSuppression.doNothing,NonSubjectSuppression.returnRestrictedDescription,NonSubjectSuppression.returnBlank,NonSubjectSuppression.returnNameOnly];
	// nss value of 4 currently supported only in Liens & judgements, Property, Watercraft, Marriage & Divorce.
	
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
end;