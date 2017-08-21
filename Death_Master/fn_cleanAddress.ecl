IMPORT Header, Address, AID;
EXPORT fn_cleanAddress(DATASET(RECORDOF(Header.layout_death_master_supplemental)) supp) := FUNCTION 

	////////////////////////////////////////////////////////////////////////////
	//Clean addresses
	///////////////////////////////////////////////////////////////////////////

	// Split Records with address from records without
	dNoAddress	:=	supp(orig_address1=''	AND	orig_address2 =''); 
	dHasAddress	:=	supp(orig_address1<>''	OR	orig_address2 <>'');
	
	// Clean Address Field
	layout_Clean_Address_Fields := record
		dHasAddress;
		STRING76	clean_orig_address1	:=	'';
		STRING76	clean_orig_address2	:=	'';
	END;

	layout_Clean_Address_Fields	tCleanAddressFields(RECORDOF(dHasAddress) pInput)	:=	TRANSFORM
		SELF.clean_orig_address1	:=	Address.fn_addr_clean_prep(pInput.orig_address1,'first');
		SELF.clean_orig_address2	:=	Address.fn_addr_clean_prep(pInput.orig_address2,'last');
		SELF											:=	pInput;
	END;
	dCleanAddressFields	:=	PROJECT(dHasAddress,tCleanAddressFields(LEFT));

	// Clean US addresses
	UNSIGNED4 lAIDAppendFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;
	AID.MacAppendFromRaw_2Line(dCleanAddressFields,clean_orig_address1,clean_orig_address2,rawaid,appendUSAddr,lAIDAppendFlags);
	
	dCleanUSAddress			:=	appendUSAddr(AIDWork_ACECache.err_stat<>'');
	dTryCanadianAddress	:=	appendUSAddr(AIDWork_ACECache.err_stat='');

	// Try using the Canadian Address Cleaner.
	RECORDOF(dTryCanadianAddress) tFillCanadianAddr(RECORDOF(dTryCanadianAddress) pInput)	:=	TRANSFORM
		dCleanCanadaAddress								:=	Address.CleanCanadaAddress109(pInput.clean_orig_address1, pInput.clean_orig_address2);
		sCanadianState										:=	['ON','BC','QC','NS','NB','MB','PE','SK','AB','NL','NT','YT','NU'];
		BOOLEAN isCanadianAddr						:=	LENGTH(TRIM(dCleanCanadaAddress[95..100],LEFT,RIGHT)) = 6 OR 
																											dCleanCanadaAddress[93..94] IN sCanadianState;
		SELF.AIDWork_ACECache.prim_range	:=	IF(isCanadianAddr, dCleanCanadaAddress[1..10], ''); 
		SELF.AIDWork_ACECache.predir			:=	IF(isCanadianAddr, dCleanCanadaAddress[11..12],'');					   
		SELF.AIDWork_ACECache.prim_name		:=	IF(isCanadianAddr, dCleanCanadaAddress[13..40],'');
		SELF.AIDWork_ACECache.addr_suffix	:=	IF(isCanadianAddr, dCleanCanadaAddress[41..44],'');
		SELF.AIDWork_ACECache.unit_desig	:=	IF(isCanadianAddr, dCleanCanadaAddress[45..54],'');
		SELF.AIDWork_ACECache.sec_range		:=	IF(isCanadianAddr, dCleanCanadaAddress[55..62],'');
		SELF.AIDWork_ACECache.p_city_name	:=	IF(isCanadianAddr, dCleanCanadaAddress[63..92],'');
		SELF.AIDWork_ACECache.st					:=	IF(isCanadianAddr, dCleanCanadaAddress[93..94],'');
		SELF.AIDWork_ACECache.zip5				:=	IF(isCanadianAddr, dCleanCanadaAddress[95..99],'');
		SELF.AIDWork_ACECache.zip4				:=	IF(isCanadianAddr, dCleanCanadaAddress[100],'');
		SELF.AIDWork_ACECache.rec_type   	:=	IF(isCanadianAddr, dCleanCanadaAddress[101..102],'');
		SELF.AIDWork_ACECache.err_stat 		:=	IF(isCanadianAddr, dCleanCanadaAddress[104..109],'');
		SELF															:=	pInput;
	END;
	dCleanCanadianAddress	:=	PROJECT(dTryCanadianAddress,tFillCanadianAddr(LEFT));

	// Fill fields after running through Address Cleaners.
	RECORDOF(supp) tFillAddr(RECORDOF(dCleanUSAddress) pInput)	:=	TRANSFORM
		SELF.prim_range		:=	pInput.AIDWork_ACECache.prim_range;
		SELF.predir				:=	pInput.AIDWork_ACECache.predir;
		SELF.prim_name		:=	pInput.AIDWork_ACECache.prim_name;
		SELF.addr_suffix	:=	pInput.AIDWork_ACECache.addr_suffix;
		SELF.postdir			:=	pInput.AIDWork_ACECache.postdir;
		SELF.unit_desig		:=	pInput.AIDWork_ACECache.unit_desig;
		SELF.sec_range		:=	pInput.AIDWork_ACECache.sec_range;
		SELF.p_city_name	:=	pInput.AIDWork_ACECache.p_city_name;
		SELF.v_city_name	:=	pInput.AIDWork_ACECache.v_city_name;
		SELF.state				:=	IF(pInput.AIDWork_ACECache.st = '',ziplib.ZipToState2(pInput.AIDWork_ACECache.zip5),pInput.AIDWork_ACECache.st);
		SELF.zip5					:=	pInput.AIDWork_ACECache.zip5;
		SELF.zip4					:=	pInput.AIDWork_ACECache.zip4;
		SELF.cart					:=	pInput.AIDWork_ACECache.cart;
		SELF.cr_sort_sz		:=	pInput.AIDWork_ACECache.cr_sort_sz;
		SELF.lot					:=	pInput.AIDWork_ACECache.lot;
		SELF.lot_order		:=	pInput.AIDWork_ACECache.lot_order;
		SELF.dpbc					:=	pInput.AIDWork_ACECache.dbpc;
		SELF.chk_digit		:=	pInput.AIDWork_ACECache.chk_digit;
		SELF.rec_type			:=	pInput.AIDWork_ACECache.rec_type;
		SELF.fips_state		:=	pInput.AIDWork_ACECache.county[1..2];
		SELF.fips_county	:=	pInput.AIDWork_ACECache.county[3..];
		SELF.geo_lat			:=	pInput.AIDWork_ACECache.geo_lat;
		SELF.geo_long			:=	pInput.AIDWork_ACECache.geo_long;
		SELF.msa					:=	pInput.AIDWork_ACECache.msa;
		SELF.geo_blk			:=	pInput.AIDWork_ACECache.geo_blk;
		SELF.geo_match		:=	pInput.AIDWork_ACECache.geo_match;
		SELF.err_stat			:=	pInput.AIDWork_ACECache.err_stat;
		SELF.address			:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(
														IF(TRIM(pInput.orig_address1)<>'' AND TRIM(pInput.orig_address2)<>'',
															TRIM(pInput.orig_address1)+', '+TRIM(pInput.orig_address2),
															IF(TRIM(pInput.orig_address1)<>'',TRIM(pInput.orig_address1),TRIM(pInput.orig_address2))
														)
													));
		SELF							:=	pInput;
	END;
	
	// Put records back into the Supplemental Format
	clean_supp := dNoAddress+PROJECT(dCleanUSAddress+dCleanCanadianAddress,tFillAddr(LEFT));

	RETURN clean_supp;
END;
