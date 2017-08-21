EXPORT layouts := MODULE

	export cnld_clean 
		:=
			RECORD
				integer8	DID,
				integer8	DID_Score,
				string10	GENNUM,
				string10	SSN,
				string10	TELEPHONE,
				string8		DOB,
				string20	FNAME,
				string20	MNAME,
				string20	LNAME,
				string5		NAME_SUFFIX,
				string10	PRIM_RANGE,
				string28	PRIM_NAME,
				string8		SEC_RANGE,
				string2		ST,
				string5		ZIP
			END;

	export cnldJoinedRecClean 
		:=
			RECORD
				string10		GENNUM,
				string8			DOB,
				string10		SSN,
				string10		TELEPHONE,
				string78		clean_name,
				string182		clean_address
			END;

	export DIDSlim
		:=
			RECORD
				string10 	GENNUM;
				integer 	DID;
				integer   DID_Score;
			END;
			
	export IngxBaseSlim
		:=
			RECORD
				string		ProviderID;
				string12 	DID;
				string3   DID_Score;
				string		TaxID;
			END;

	export ProviderAddress
		:=
			RECORD
				string	ProviderID,
				string	AddressID,
				string	Address,
				string	Address2,
				string	City,
				string	State,
				string	County,
				string	Zip,
				string	ExtZip,
				string	Latitude,
				string	Longitude,
				string	GeoReturn,
				string	HighRisk,
				string	CompanyCount,
				string	TierTypeID,
				string	VerificationStatusCode,
				string	VerificationDate
			END;
			
	export ProviderAddressDEANumber 
		:=
			RECORD
				string	ProviderID,
				string	Blank,
				string	DEANumber,
				string	CompanyCount,
				string	TierTypeID,
				string	VerificationStatusCode,
				string	VerificationDate
			END;

	export ProviderAddressPhone
		:=
			RECORD
				string	ProviderID,
				string	AddressID,
				string	PhoneNumber,
				string	PhoneType,
				string	CompanyCount,
				string	TierTypeID,
				string	VerificationStatusCode,
				string	VerificationDate
			END;

	export ProviderAddressTaxID
		:=
			RECORD
				string	ProviderID,
				string	AddressID,
				string	TaxID,
				string	CompanyCount,
				string	TierTypeID,
				string	VerificationStatusCode,
				string	VerificationDate
			END;

	export ProviderAddressTaxIDSlim
		:=
			RECORD
				string	ProviderID,
				string	AddressID,
				string	TaxID,
				string	CompanyCount,
				string	VerificationDate
			END;

	export ProviderAddressType
		:=
			RECORD
				string	ProviderID,
				string	AddressID,
				string	AddressTypeCode,
				string	CompanyCount,
				string	TierTypeID,
				string	VerificationStatusCode,
				string	VerificationDate
			END;

	export ProviderBirthDate
		:=
			RECORD
				string	ProviderID,
				string	BirthDate,
				string	CompanyCount,
				string	TierTypeID,
				string	VerificationStatusCode,
				string	VerificationDate
			END;

	export ProviderDegree
		:=
			RECORD
				string	ProviderID,
				string	Degree,
				string	CompanyCount,
				string	TierTypeID,
				string	VerificationStatusCode,
				string	VerificationDate
			END;

	export ProviderGender
		:=
			RECORD
				string	ProviderID,
				string	Gender,
				string	CompanyCount,
				string	TierTypeID,
				string	VerificationStatusCode,
				string	VerificationDate
			END;

	export ProviderLanguage
		:=
			RECORD
				string	ProviderID,
				string	Language,
				string	CompanyCount,
				string	TierTypeID,
				string	VerificationStatusCode,
				string	VerificationDate
			END;

	export ProviderLicense 
		:=
			RECORD
				string	ProviderID,
				string	LicenseNumber,
				string	State,
				string	EffectiveDate,
				string	TerminationDate,
				string	CompanyCount,
				string	TierTypeID,
				string	VerificationStatusCode,
				string	VerificationDate
			END;

	export ProviderMedSchool
		:=
			RECORD
				string	ProviderId,
				string	MedSchoolName,
				string	GraduationYear,
				string	CompanyCount,
				string	TierTypeID,
				string	VerificationStatusCode,
				string	VerificationDate
			END;

	export ProviderName
		:=
			RECORD
				string ProviderID,
				string LastName,
				string FirstName,
				string MiddleName,
				string Suffix,
				string CompanyCount,
				string TierTypeID,
				string VerificationStatusCode,
				string VerificationDate,
				string NameScore
			END;

	export ProviderNPI
		:=
			RECORD
				string	ProviderID,
				string	NPI,
				string	EnumerationDate,
				string	CompanyCount,
				string	TierTypeID,
				string	VerificationStatusCode,
				string	VerificationDate
			END;

	export ProviderNPISlim
		:=
			RECORD
				string	ProviderID,
				string	NPI,
				string	CompanyCount,
				string	VerificationDate
			END;
		
	export ProviderResidency
		:=
			RECORD
				string	ProviderID,
				string	ResidencyName,
				string	CompanyCount,
				string	TierTypeID,
				string	VerificationStatusCode,
				string	VerificationDate
			END;
		
	export ProviderSpecialty
		:=
			RECORD
				string	ProviderID,
				string	SpecialtyID,
				string	CompanyCount,
				string	TierTypeID,
				string	VerificationStatusCode,
				string	VerificationDate
			END;

	export ProvIDSpecProfCode
		:=
			RECORD
				string 	ProviderID;
				string	SpecialtyGroupID,
				string	SpecialtyID,
				string	SPEC_CODE,
				string	PROFCODE
			END;

	export ProviderUPIN
		:=
			RECORD
				string	ProviderID,
				string	UPIN,
				string	CompanyCount,
				string	TierTypeID,
				string	VerificationStatusCode,
				string	VerificationDate
			END;

	export SanctionsDBoutput 
		:=
			RECORD
				string	SANC_ID,
				string	SANC_LNME,
				string	SANC_FNME,
				string	SANC_MID_I_NM,
				string	SANC_BUSNME,
				string	SANC_DOB,
				string	SANC_STREET,
				string	SANC_CITY,
				string	SANC_ZIP,
				string	SANC_STATE,
				string	SANC_CNTRY,
				string	SANC_TIN,
				string	SANC_UPIN,
				string	SANC_PROVTYPE,
				string	SANC_SANCDTE,
				string	SANC_SANCST,
				string	SANC_LICNBR,
				string	SANC_BRDTYPE,
				string	SANC_SRC_DESC,
				string	SANC_TYPE,
				string	SANC_REAS,
				string	SANC_TERMS,
				string	SANC_COND,
				string	SANC_FINES,
				string	SANC_FAB,
				string	SANC_UPDTE,
				string	SANC_REINDTE,
				string	SANC_UNAMB_IND
			END;

	export SancFileProfs 
		:=
			RECORD
				string	ProvType,
				string	PROFCODE
			END;

	export Specialty
		:=
			RECORD
				string	SpecialtyID,
				string	SpecialtyName,
				string	SpecialtyGroupID
			END;

	export SpecialtyGroup
		:=
			RECORD
				string	SpecialtyGroupID,
				string	SpecialtyGroupName
			END;

	export SpecialtyToProfCode
		:=
			RECORD
				string		SpecialtyGroupID,
				string		SpecialtyID,
				string		SpecCode,
				string		PossibleProfession
			END;

	export cmcadd
		:=
			RECORD
				string		ADDRID,
				string		ADDRESS1,
				string		ADDRESS2,
				string		CITY,
				string		STATE,
				string		ZIP5,
				string		ZIP4,
				string		CARRT,
				string		DPBC,
				string		DTSTAMP,
				string		LAST_UPDT,
				string		SRCE_UPDT,
				string		COUNTY,
				string		FLAGOOC,
				string		COUNTRY,
				string		ADDKEY,
				string		SUDKEY,
				string		MATCHCNT,
				string		RESULTCODE,
				string		CREATE_DT,
				string		ADDRESSPK
			END;

	export cmcaddSlim
		:=
			RECORD
				string10		ADDRID,
				string40		ADDRESS1,
				string40		ADDRESS2,
				string25		CITY,
				string2			STATE,
				string5			ZIP5,
				string4			ZIP4
			END;

	export cmcalias 
		:=
			RECORD
				string	GENNUM,
				string	ORG_NAME,
				string	LAST_NAME,
				string	FIRST_NAME,
				string	MID_NAME,
				string	NAME_PREFIX,
				string	NAME_SUFX,
				string	DTSTAMP,
				string	LAST_UPDT,
				string	SRCE_UPDT,
				string	MATCHCNT,
				string	CREATE_DT,
				string	ALIASPK
			END;
			
	export cmcdea
		:=
			RECORD
				string	GENNUM,
				string	DEANBR,
				string	DTSTAMP,
				string	LAST_UPDT,
				string	MATCHCNT,
				string	TERM_DATE,
				string	CREATE_DT,
				string	EXPDATE,
				string	SRCE_UPDT,
				string	SCHEDULE1,
				string	SCHEDULE2,
				string	SCHEDULE2N,
				string	SCHEDULE3,
				string	SCHEDULE4,
				string	SCHEDULE5,
				string	SCHEDULEL1,
				string	ADDRID,
				string	BUS_CODE,
				string	DEAPK
			END;

	export cmcdiscp 
		:=
			RECORD
				string	GENNUM,
				string	PROFCODE,
				string	ACTSTATE,
				string	ACTDATE,
				string	DOCTITLE,
				string	JUDGEMENT,
				string	CASENBR,
				string	COMPLAINT,
				string	ACTIONDESC,
				string	SRCE_UPDT,
				string	ENTRYDATE,
				string	ENTRYSTAFF,
				string	ADDLDATACD,
				string	VERIFIED,
				string	VERDATE,
				string	VERSTAFFF,
				string	REPORTABLE,
				string	LICREINDT,
				string	DOCID,
				string	SANCID,
				string	ADDLINFO,
				string	DTSTAMP,
				string	LAST_UPDATE,
				string	MATCHCNT,
				string	TERM_DATE,
				string	CREATE_DT
			END;

	export cmcfed
		:=
			RECORD
				string	GENNUM,
				string	FED_TAXID,
				string	ADDRID,
				string	TAX_TYPE,
				string	LAST_UPDT,
				string	SRCE_UPDT,
				string	DTSTAMP,
				string	MATCHCNT,
				string	PROV_TYPE,
				string	TERM_DATE,
				string	SANC,
				string	CREATE_DT,
				string	FEDPK
			END;

	export cmcfedSlim
		:=
			RECORD
				string10		GENNUM,
				string10		FED_TAXID
			END;

	export cmclang 
		:= 
			RECORD
				string	GENNUM,
				string	LANGCODE,
				string	SRCE_UPDT,
				string	LAST_UPDT,
				string	DTSTAMP,
				string	MATCHCNT,
				string	TERM_DATE,
				string	CREATE_DT,
				string	LANGPK
			END;

	export cmcprof 
		:= 
			RECORD
				string	GENNUM,
				string	PROFCODE,
				string	TERM_DATE,
				string	CREATE_DT,
				string	PROFSTAT,
				string	DTSTAMP,
				string	PROFPK
			END;

	export cmcprov 
		:=
			RECORD
				string	GENNUM,
				string	UPIN_NUM,
				string	TYPE_CODE,
				string	ORG_NAME,
				string	LAST_NAME,
				string	FIRST_NAME,
				string	MID_NAME,
				string	NAME_PREFX,
				string	NAME_SUFX,
				string	CREDENTIAL,
				string	DTSTAMP,
				string	LAST_UPDT,
				string	SRCE_UPDT,
				string	MATCHCNT,
				string	ORGKEY,
				string	MAILADDRID,
				string	PROVSTAT,
				string	GENDER,
				string	DOBYEAR,
				string	DOBMONTH,
				string	DOBDAY,
				string	DISC,
				string	OSTEO,
				string	PRAEXPDATE,
				string	ABMS,
				string	SANC,
				string	NEWGEN,
				string	CREATE_DT,
				string	ABMSDOBFLG,
				string	PROVID
			END;

	export cmcprovSlim
		:=
			RECORD
				string10		GENNUM,
				string30		LAST_NAME,
				string15		FIRST_NAME,
				string15		MID_NAME,
				string8			NAME_PREFX,
				string3			NAME_SUFX,
				string4			DOBYEAR,
				string2			DOBMONTH,
				string2			DOBDAY
			END;

	export cmcschool
		:=
			RECORD
				string	GENNUM,
				string	SCHOOLCODE,
				string	SCHOOLYEAR,
				string	DEGREE,
				string	PROFCODE,
				string	DTSTAMP,
				string	LAST_UPDT,
				string	SRCE_UPDT,
				string	MATCHCNT,
				string	TERM_DATE,
				string	CREATE_DT,
				string	ABMSSCHOOLFLG,
				string	SCHOOLPK			
			END;
	
	export cmcsl 
		:= 
			RECORD
				string	GENNUM,
				string	LIC_STATE,
				string	SLNUM,
				string	LIC_TYPE,
				string	SRCE_UPDT,
				string	LAST_UPDT,
				string	ISSUEDATE,
				string	EXPDATE,
				string	CONTHRSREQ,
				string	CONTHRSCMP,
				string	SUPERVISOR,
				string	ORIGINCODE,
				string	LIC_STATUS,
				string	DISPTYPE,
				string	DTSTAMP,
				string	MATCHCNT,
				string	TERM_DATE,
				string	SANC,
				string	PTHERAPY,
				string	ULTRASND,
				string	ACCUPUNCT,
				string	PROFCODE,
				string	CREATE_DT,
				string	ADDRID,
				string	SLPK
			END;

	export cmcspcd
		:=
			RECORD
				string	GENNUM,
				string	SPEC_CODE,
				string	SRCE_UPDT,
				string	DTSTAMP,
				string	LAST_UPDT,
				string	MATCHCNT,
				string	UPIN,
				string	SL,
				string	TERM_DATE,
				string	CREATE_DT,
				string	SPCDPK
			END;	

	export cmctraining
		:=
			RECORD
				string	GENNUM,
				string	STATE,
				string	SPECIALTY1,
				string	SPECIALTY2,
				string	INSTITUTE,
				string	CATEGORY,
				string	STARTDATE,
				string	ENDDATE,
				string	CONFIRMED,
				string	DTSTAMP,
				string	LAST_UPDT,
				string	SRCE_UPDT,
				string	MATCHCNT,
				string	TERM_DATE,
				string	CREATE_DT,
				string	TRAININGPK
			END;

	export cmlpvad
		:=
			RECORD
				string	GENNUM,
				string	ADDRID,
				string	EFF_DATE,
				string	TERM_DATE,
				string	TELEPHONE,
				string	FAX_NUM,
				string	FAX_SECURE,
				string	OFFICENAME,
				string	SRCE_UPDT,
				string	DTSTAMP,
				string	ADD_SRCE,
				string	LAST_UPDT,
				string	MATCHCNT,
				string	NEW_ADDRID,
				string	BILLADDR,
				string	PRACADDR,
				string	HOMEADDR,
				string	SANC,
				string	CREATE_DT,
				string	ABMSFLG,
				string	LADDRSTAT,
				string	SADDRDATE,
				string	LADDRRATE,
				string	SVERDATE,
				string	LBESTADDR,
				string	LADDRDATE
			END;

	export cmlpvadSlim
		:=
			RECORD
				string10		GENNUM,
				string10		ADDRID,
				string10		TELEPHONE
			END;

	export cmvinstitute
		:=
			RECORD
				string	INSTITUTE,
				string	INSTNAME,
				string	CONFIRMED,
				string	CREATE_DT,
				string	ADDRESS1,
				string	ADDRESS2,
				string	CITY,
				string	STATE,
				string	ZIP5,
				string	COUNTRY,
				string	ORGKEY,
				string	INSTITUTEPK
			END;

	export cmvlang
		:=
			RECORD
				string	LANGCODE,
				string	LANGDESC,
				string	CMVLANGPK
			END;
		
	export cmvschool
		:=
			RECORD
				string	SCHOOLCODE,
				string	SCHOOLNAME,
				string	CONFIRMED,
				string	CREATE_DT,
				string	ORGKEY,
				string	CMVSCHOOLPK
			END;

END;