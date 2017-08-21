EXPORT slim_layouts := MODULE

	export cmcfed
		:=
			RECORD
					string	GENNUM
				,	string	FED_TAXID
				// ,	string	ADDRID
				,	string	TAX_TYPE
				// ,	string	LAST_UPDT
				// ,	string	SRCE_UPDT
				// ,	string	DTSTAMP
				// ,	string	MATCHCNT
				// ,	string	PROV_TYPE
				// ,	string	TERM_DATE
				// ,	string	SANC
				// ,	string	CREATE_DT
				// ,	string	FEDPK
			END;
			
		export cmcsl 
			:= 
				RECORD
					string	GENNUM
					, string	LIC_STATE
					, string	SLNUM
					// , string	LIC_TYPE
					// , string	SRCE_UPDT
					// , string	LAST_UPDT
					// , string	ISSUEDATE
					// , string	EXPDATE
					// , string	CONTHRSREQ
					// , string	CONTHRSCMP
					// , string	SUPERVISOR
					// , string	ORIGINCODE
					// , string	LIC_STATUS
					// , string	DISPTYPE
					// , string	DTSTAMP
					// , string	MATCHCNT
					// , string	TERM_DATE
					// , string	SANC
					// , string	PTHERAPY
					// , string	ULTRASND
					// , string	ACCUPUNCT
					// , string	PROFCODE
					// , string	CREATE_DT
					// , string	ADDRID
					// , string	SLPK
				END;
				
		export cmcprov 
			:=
				RECORD
					string	GENNUM
					, string	UPIN_NUM
					// , string	TYPE_CODE
					// , string	ORG_NAME
					, string	LAST_NAME
					, string	FIRST_NAME
					// , string	MID_NAME
					// , string	NAME_PREFX
					// , string	NAME_SUFX
					// , string	CREDENTIAL
					// , string	DTSTAMP
					// , string	LAST_UPDT
					// , string	SRCE_UPDT
					// , string	MATCHCNT
					// , string	ORGKEY
					// , string	MAILADDRID
					// , string	PROVSTAT
					// , string	GENDER
					// , string	DOBYEAR
					// , string	DOBMONTH
					// , string	DOBDAY
					// , string	DISC
					// , string	OSTEO
					// , string	PRAEXPDATE
					// , string	ABMS
					// , string	SANC
					// , string	NEWGEN
					// , string	CREATE_DT
					// , string	ABMSDOBFLG
					// , string	PROVID
				END;
			
	export cmcdea
		:=
			RECORD
				string	GENNUM
				, string	DEANBR
				// , string	DTSTAMP
				// , string	LAST_UPDT
				// , string	MATCHCNT
				// , string	TERM_DATE
				// , string	CREATE_DT
				// , string	EXPDATE
				// , string	SRCE_UPDT
				// , string	SCHEDULE1
				// , string	SCHEDULE2
				// , string	SCHEDULE2N
				// , string	SCHEDULE3
				// , string	SCHEDULE4
				// , string	SCHEDULE5
				// , string	SCHEDULEL1
				// , string	ADDRID
				// , string	BUS_CODE
				// , string	DEAPK
			END;
	
	export ProviderName
		:=
			RECORD
				string ProviderID
				, string LastName
				, string FirstName
				// , string MiddleName
				// , string Suffix
				// , string CompanyCount
				// , string TierTypeID
				// , string VerificationStatusCode
				// , string VerificationDate
				// , string NameScore
			END;
	
	export ProviderAddressTaxID
		:=
			RECORD
				string	ProviderID
				// , string	AddressID
				, string	TaxID
				// , string	CompanyCount
				// , string	TierTypeID
				// , string	VerificationStatusCode
				// , string	VerificationDate
			END;
	
	export GennumProviderID
		:=
			RECORD
				string GENNUM,
				string ProviderID
			END;
				
END;