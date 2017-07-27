import Healthcare_Shared;

export Layouts_AddrPhoneFax := module

	export AddressType := enum (
					unsigned1,
					PRACTICE       = 1,
					BILLING        = 2,
					REMIT          = 4,
					OFFICE         = 8,
					MAILING        = 16
				);
				
	export PhoneType := enum (
					unsigned1,
					PHONE          = 1,
					FAX            = 2
				);
				
	export CorrectionType := enum (
					unsigned1,
					ADDRESS        = 1,
					PHONE          = 2,
					FAX            = 4
				);
				
	export AddressPhoneFaxSourceBit := enum (
					unsigned2,
					FRESH_VSF          = 1,
					ROSTER             = 2,
					DENTAL_NPI_DEA     = 4,
					CAM_NPI_DEA        = 8,
					CAM_STALE_PHONE    = 16,
					CAM_STALE_VSF      = 32,
					CAM_ROSTER         = 64,
					DEA_ROSTER         = 128,
					NPI_ROSTER         = 256
				);

	export Layout_AddressPhoneFax := record
		string20	    acctno := '';
		unsigned6     InternalID:=0;
		boolean		    isRoyalty := false;	
		dataset(Healthcare_Shared.Layouts.layout_FileSource) sources := dataset([],Healthcare_Shared.Layouts.layout_FileSource);	
		string38		  group_key := '';
		string38      surrogate_key;
		Healthcare_Shared.layouts_commonized.layout_std_address;
		Healthcare_Shared.layouts_commonized.layout_std_phone;
		Healthcare_Shared.layouts_commonized.layout_std_fax;
		Healthcare_Shared.layouts_commonized.layout_std_company;
		Healthcare_Shared.layouts_commonized.layout_best_hospital;
		string8       last_update_date;
		string9       filecode;
		unsigned8     filecode_enum;
		unsigned1     address_type;
		string1       primary_location;
		unsigned8     call_return_id;
		string10      taxonomy;
		boolean       isInactive;
		boolean       isPhoneVerified;
		boolean       isPhoneVerifiedFresh;
		boolean       isPhoneVerifiedStale;
		boolean       isFaxVerified;
		boolean       isFaxVerifiedFresh;
		boolean       isFaxVerifiedStale;
		boolean       isVsfVerified;
		boolean       isVsfVerifiedFresh;
		boolean       isVsfVerifiedStale;
		boolean       isCamVerified;
		boolean       isCamVerifiedFresh;
		boolean       isCamVerifiedStale;
		boolean       isVSFInact;
		boolean       isHighVerified;
		boolean       isPrison;
		boolean       isHospital;
		boolean       isNpsr;
		boolean       isResidential;
		boolean       isPobox;
		boolean       isSigStd;
		boolean       isNotDeliverable;
		unsigned1     source_confidence_score;
		unsigned1     corrRank;
		boolean       verifiesInputPracAddress;
		boolean       verifiesInputPracSuite;
		boolean       verifiesInputPracPhone;
		boolean       verifiesInputPracFax;
		boolean       verifiesInputBillAddress;
		boolean       verifiesInputBillSuite;
		boolean       verifiesInputBillPhone;
		boolean       verifiesInputBillFax;
		Healthcare_Shared.Layouts.MatchStat msPracAddr;
		Healthcare_Shared.Layouts.MatchStat msBillAddr;
		unsigned2     cbm1;
		unsigned2     cbm3;
		unsigned2     cbm6;
		unsigned2     cbm12;
		unsigned2     cbm18;
	end;
	
	export Layout_Phone := record
		string10   number;
		unsigned4  phone_type;
	end;
		
	export Layout_DistinctPhone := record
		Layout_Phone;
		boolean    isRoyalty;
		dataset(Healthcare_Shared.Layouts.layout_FileSource) sources := dataset([],Healthcare_Shared.Layouts.layout_FileSource);
		boolean    isPhoneVerifiedAsPractice := false;
		boolean    isPhoneVerifiedAsBilling := false;
		boolean    isFaxVerifiedAsPractice := false;
		boolean    isFaxVerifiedAsBilling := false;
		boolean    isOtherVerifiedAsPractice := false;
		boolean    isOtherVerifiedAsBilling := false;
		boolean    isVSF := false;
		boolean    isERXFax := false;
		boolean    isInactive := false;
		boolean    isPhoneInactive := false;
		boolean    isFaxInactive := false;
		boolean    isRefPrac := false;
		boolean    isRefBill := false;
		boolean    isPhoneVerified := false;
		boolean    isPhoneVerifiedFresh := false;
		boolean    isPhoneVerifiedStale := false;
		boolean    isFaxVerified := false;
		boolean    isFaxVerifiedFresh := false;
		boolean    isFaxVerifiedStale := false;
		boolean    isHighVerified := false;
		unsigned4  highVerification := 0;             // bit mask of high-verifying sources
		boolean    verifiesInputPracSuite := false;
		boolean    verifiesInputBillSuite := false;
		boolean    verifiesInputPracPhone := false;
		boolean    verifiesInputBillPhone := false;
		boolean    verifiesInputPracFax := false;
		boolean    verifiesInputBillFax := false;
		string8    bestPracticeLastDate := '';
		string8    bestBillingLastDate := '';
		string8    lastPhoneContactDate := '';
		string8    lastFaxContactDate := '';
		string8    lastUpdateDate := '';
		string8    inactiveDate := '';
		unsigned2  otherCount := 0;
		unsigned1  corrRank;
		unsigned8  phone_st := 0;
	end;
	
	export Layout_DistinctAddress := record
		string20	 acctno := '';
		unsigned6  InternalID:=0;
		boolean		 isRoyalty := false;
		string38	 group_key := '';
		unsigned1  addr_rank := 0;
		dataset(Healthcare_Shared.Layouts.layout_FileSource) sources := dataset([],Healthcare_Shared.Layouts.layout_FileSource);		
		Healthcare_Shared.layouts_commonized.layout_std_address;
		DATASET(Layout_AddressPhoneFax)   records;
		Healthcare_Shared.layouts_commonized.layout_std_company;
		Healthcare_Shared.layouts_commonized.layout_best_hospital;
		DATASET(Layout_DistinctPhone)     distinctPhones;
		DATASET(Layout_DistinctPhone)     distinctFaxes;
		unsigned8  inactiveCallReturnId := 0;
		unsigned8  activeCallReturnId := 0;
		unsigned1  address_type;
		boolean    isPrison;
		boolean    isHospital;
		boolean    isNpsr;
		boolean    isResidential;
		boolean    isPobox;
		boolean    isSigStd;
		boolean    isPhoneInactive := false;
		boolean    isFaxInactive := false;
		boolean    isPhoneVerifiedFresh := false;
		boolean    isFaxVerifiedFresh := false;
		boolean    isCAMVerifiedFresh := false;
		boolean    hasValidVSF := false;
		boolean    haveDea := false;
		boolean    isNcpdpOnly := false;
		boolean    isCAMOnly := false;
		boolean    isNotDeliverable;
		integer1   hospMainIndicator := 0;
		string1    primaryLocation := '';
		string8    inactDate := '';
		boolean    isCAMVerified := false;
		string8    lastUpdateDate := '';
		unsigned2  otherVerifiedSourceCount := 0;
		unsigned1  confidenceScore := 0;
		unsigned4  highVerification;             // bit mask of high-verifying sources
		string8    lastHighVerificationDate;     // the most recent HV date seen for the address
		string8    lastPhoneVerificationDate;    // the most recent phone record that verifies the address
		string8    lastFaxVerificationDate;      // the most recent fax record that verifies the address
		boolean    verifiesInputPracAddress;
		boolean    verifiesInputBillAddress;
		boolean    verifiesInputPracPhone := false;
		boolean    verifiesInputBillPhone := false;
		boolean    verifiesInputPracFax := false;
		boolean    verifiesInputBillFax := false;
		boolean    augment := false;
		unsigned1  correction;
		Layout_AddressPhoneFax bestAddress;
		Layout_DistinctPhone   bestPhone;
		Layout_DistinctPhone   bestFax;
	end;
end;
