import address, UtilFile;

export Layouts := module

	shared max_size := _Dataset().max_record_size;
	
	export Input :=	module

		//*** Entity varying layout	
		export entity_raw := record, maxlength(max_size)
				string	CPS_SIG_ENT;
				string	CPS_LOAD_DTTM;
				string	CPS_VENDOR_CD;
				string	CPS_CLOAK;
				string	VEND_REF_NUM;
				string	VEND_ADD_DTE;
				string	NAME_LAST;
				string	NAME_FIRST;
				string	NAME_MID;
				string	NAME_SUFFIX;
				string	SSN;
				string	DL_STATE_ABBR;
				string	DL_NUM;
				string	CLN_VEND_ADD_DTE;
				string	CLN_SSN;
				string	CLN_DL_NUM;
				string	CPS_DL_STATE_ABBR;
				string	lf;
		end;

		//*** SVC_Address varying layout		
		export svcaddr_raw := record, maxlength(max_size)
				string	CPS_SIG_SADDR;
				string	CPS_SIG_ENT;
				string	CPS_LOAD_DTTM;
				string	CPS_VENDOR_CD;
				string	SVC_DTE;
				string	SVC_TYPE_CD;
				string	ADDR_HOUSE_NUM;
				string	ADDR_STREET_NAME;
				string	ADDR_SUFF;
				string	ADDR_PRE_DIR;
				string	ADDR_APT_NUM;
				string	ADDR_CITY;
				string	ADDR_STATE_ABBR;
				string	ADDR_POSTAL_CODE;
				string	PHONE;
				string	CLN_SVC_DTE;
				string	CPS_STATE_ABBR;
				string	CPS_ADDR_TYPE_CD;
				string	CLN_AREA_CODE;
				string	CLN_PHONE;
				string	CPS_PHONE_TYPE_CD;
				string	lf;
		end;

	end;
	
	
	////////////////////////////////////////////////////////////////////////
	// -- Common Layouts for processing
	////////////////////////////////////////////////////////////////////////
	export EntitySVCAddr := 
	record, maxlength(max_size)
			input.entity_raw;
			input.svcaddr_raw and not [CPS_SIG_ENT, 
																 CPS_LOAD_DTTM,
																 CPS_VENDOR_CD,
																 lf]
	end;
	
	export CleanAddr := record
			EntitySVCAddr;
			Address.Layout_Clean182;
			string100 Company_Name;
			string10	Clean_phone;
			string1		Name_Flag;
	end;
	
	
	////////////////////////////////////////////////////////////////////////
	// -- Base Layout
	////////////////////////////////////////////////////////////////////////
	export Base := record 
	 UtilFile.Layout_Utility_In;
	 string100	company_name := '';
	 string12		bdid := '';
	 string2		source := '';
  end;
 
 end;