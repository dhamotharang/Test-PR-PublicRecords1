IMPORT ut, AID, NID;

EXPORT Fn_Clean := MODULE

	// Trim and uppercase a string
	EXPORT cleanUpper(STRING s) := FUNCTION
		RETURN StringLib.StringCleanSpaces(StringLib.StringToUpperCase(s));
	END;

	// Address cleaner
	EXPORT Address(dataset_to_clean) := FUNCTIONMACRO

		// Address cleaner call
		// (STRING) append_prep_address1 		:	Expects an street number and street
		//													e.g.			'123 MAIN ST'
		// (STRING) append_prep_addresslast : Expects a concatenation of city, street, and zip, city and street separated by a comma
		//													e.g.			'KING OF PRUSSIA, PA 19406'
		AID.Common.xflags flags	:=	AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;
		AID.MacAppendFromRaw_2Line(dataset_to_clean,
															 append_prep_address1,
															 append_prep_addresslast,
															 RawAID,
															 addrCleaned,
															 flags);
															 
		dataset_to_clean trans_address_cleaned(RECORDOF(addrCleaned) pInput) := TRANSFORM
			SELF.rawaid			:= pInput.AIDWork_RawAID;
			SELF.prim_range	:= pInput.AIDWork_ACECache.prim_range;
			SELF.predir			:= pInput.AIDWork_ACECache.predir;
			SELF.prim_name		:= pInput.AIDWork_ACECache.prim_name;
			SELF.addr_suffix	:= pInput.AIDWork_ACECache.addr_suffix;
			SELF.postdir		:= pInput.AIDWork_ACECache.postdir;
			SELF.unit_desig	:= pInput.AIDWork_ACECache.unit_desig;
			SELF.sec_range		:= pInput.AIDWork_ACECache.sec_range;
			SELF.p_city_name	:= pInput.AIDWork_ACECache.p_city_name;
			SELF.v_city_name	:= pInput.AIDWork_ACECache.v_city_name;
			SELF.st				:= pInput.AIDWork_ACECache.st;
			SELF.zip				:= pInput.AIDWork_ACECache.zip5;
			SELF.zip4			:= pInput.AIDWork_ACECache.zip4;
			SELF.rec_type		:= pInput.AIDWork_ACECache.rec_type;
			SELF.county			:= pInput.AIDWork_ACECache.county;
			SELF.geo_lat		:= pInput.AIDWork_ACECache.geo_lat;
			SELF.geo_long		:= pInput.AIDWork_ACECache.geo_long;
			SELF.msa				:= pInput.AIDWork_ACECache.msa;
			SELF.geo_blk		:= pInput.AIDWork_ACECache.geo_blk;
			SELF.geo_match		:= pInput.AIDWork_ACECache.geo_match;
			SELF.err_stat		:= pInput.AIDWork_ACECache.err_stat;
			SELF					:= pInput;
		END;

		RETURN PROJECT(addrCleaned, trans_address_cleaned(LEFT));
	ENDMACRO;
	
	// Name cleaner
	// (STRING) append_prep_name			: Expects a last, first, middle name, last and first name separated by a comma
	//												e.g.		'SMITH, JANE L'
	EXPORT Name(dataset_to_clean, pOutLayout, pName) := FUNCTIONMACRO
		NID.Mac_CleanFullNames(dataset_to_clean,
													 clean_names,
													 pName,
													 includeInRepository := FALSE,
													 normalizeDualNames 	:= FALSE);
													 
		setValidSuffix:=['JR','SR','I','II','III','IV','V','VI','VII','VIII','IX'];
		STRING fGetSuffix(STRING SuffixIn)	:=		MAP(SuffixIn = '1' => 'I'
																							,SuffixIn IN ['2','ND'] => 'II'
																							,SuffixIn IN ['3','RD'] => 'III'
																							,SuffixIn = '4' => 'IV'
																							,SuffixIn = '5' => 'V'
																							,SuffixIn = '6' => 'VI'
																							,SuffixIn = '7' => 'VII'
																							,SuffixIn = '8' => 'VIII'
																							,SuffixIn = '9' => 'IX'
																							,SuffixIn IN setValidSuffix => SuffixIn
																							,'');
																			
		pOutLayout tr(clean_names L) := TRANSFORM
			SELF.title 				:= IF(L.cln_title IN ['MR','MS'], L.cln_title, '');
			SELF.fname 				:= L.cln_fname;
			SELF.mname 				:= L.cln_mname;
			SELF.lname 				:= L.cln_lname;
			SELF.name_suffix 		:= fGetSuffix(L.cln_suffix);
			SELF            		:= L;
		END;
		RETURN PROJECT(clean_names,tr(LEFT));
	ENDMACRO;
	
	EXPORT Parsed_name(pDataset, pOutLayout, pFname, pMname, pLname, pSuffix = '') := FUNCTIONMACRO
		NID.Mac_CleanParsedNames(pDataset
														,cleanNames
														,pFname
														,pMname
														,pLname
														,pSuffix
														,includeInRepository:=FALSE
														,normalizeDualNames:=FALSE);	

		setValidSuffix:=['JR','SR','I','II','III','IV','V','VI','VII','VIII','IX'];
		STRING fGetSuffix(STRING SuffixIn)	:=		MAP(SuffixIn = '1' => 'I'
																							,SuffixIn IN ['2','ND'] => 'II'
																							,SuffixIn IN ['3','RD'] => 'III'
																							,SuffixIn = '4' => 'IV'
																							,SuffixIn = '5' => 'V'
																							,SuffixIn = '6' => 'VI'
																							,SuffixIn = '7' => 'VII'
																							,SuffixIn = '8' => 'VIII'
																							,SuffixIn = '9' => 'IX'
																							,SuffixIn IN setValidSuffix => SuffixIn
																							,'');
																			
		pOutLayout tr(cleanNames L) := TRANSFORM
			SELF.title 				:= IF(L.cln_title IN ['MR','MS'], L.cln_title, '');
			SELF.fname 				:= L.cln_fname;
			SELF.mname 				:= L.cln_mname;
			SELF.lname 				:= L.cln_lname;
			SELF.name_suffix 		:= fGetSuffix(L.cln_suffix);
			SELF            		:= L;
		END;
		RETURN PROJECT(cleanNames,tr(LEFT));
	ENDMACRO;


END;