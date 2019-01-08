IMPORT Address, AID, ut;
EXPORT fCleanAddresses(DATASET(RECORDOF(Layout_Basefile)) pInput) := FUNCTION

	// Clean Address Field
	layout_Clean_Address_Fields := record
		pInput;
		STRING76	clean_orig_address1	:=	'';
		STRING76	clean_orig_address2	:=	'';
	END;
	
	layout_Clean_Address_Fields	tPrepAddressFields(RECORDOF(pInput) pInput)	:=	TRANSFORM

		STRING76 orig_address1			:= ut.CleanSpacesAndUpper(pInput.MSADDR1+' '+pInput.MSADDR2);
		STRING76 orig_address2			:= ut.CleanSpacesAndUpper(
																							IF(pInput.MSCITY<>'' AND (pInput.MSSTATE<>'' OR pInput.MSZIP5<>''),
																									pInput.MSCITY+', ',
																									pInput.MSCITY) + 
																							pInput.MSSTATE+' ' +
																							pInput.MSZIP5 +
																		        IF(pInput.MSZIP5='' OR pInput.MSZIP4='','','-'+pInput.MSZIP4)
																							);
		SELF.clean_orig_address1	:=	Address.fn_addr_clean_prep(orig_address1,'first');
		SELF.clean_orig_address2	:=	Address.fn_addr_clean_prep(orig_address2,'last');
		SELF														:=	pInput;
	END;
	dCleanAddressFields					:=	PROJECT(pInput,tPrepAddressFields(LEFT));

	// Split Records with address from records without
	dNoAddress											:=	dCleanAddressFields(clean_orig_address1=''	AND	clean_orig_address2 =''); 
	dHasAddress										:=	dCleanAddressFields(clean_orig_address1<>''	OR	clean_orig_address2 <>'');

	// Clean US addresses
	UNSIGNED4 lAIDAppendFlags 	:= AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;
	AID.MacAppendFromRaw_2Line(dHasAddress,clean_orig_address1,clean_orig_address2,rawaid,appendAddr,lAIDAppendFlags);
	
	// Fill fields after running through Address Cleaners.
	RECORDOF(pInput) tFillAddr(RECORDOF(appendAddr) L)	:=	TRANSFORM
		SELF.prim_range							:=	L.AIDWork_ACECache.prim_range;
		SELF.predir									:=	L.AIDWork_ACECache.predir;
		SELF.prim_name								:=	L.AIDWork_ACECache.prim_name;
		SELF.addr_suffix						:=	L.AIDWork_ACECache.addr_suffix;
		SELF.postdir									:=	L.AIDWork_ACECache.postdir;
		SELF.unit_desig							:=	L.AIDWork_ACECache.unit_desig;
		SELF.sec_range								:=	L.AIDWork_ACECache.sec_range;
		SELF.p_city_name						:=	L.AIDWork_ACECache.p_city_name;
		SELF.v_city_name						:=	L.AIDWork_ACECache.v_city_name;
		SELF.st												:=	IF(L.AIDWork_ACECache.st = '',ziplib.ZipToState2(L.AIDWork_ACECache.zip5),L.AIDWork_ACECache.st);
		SELF.zip											:=	L.AIDWork_ACECache.zip5;
		SELF.zip4											:=	L.AIDWork_ACECache.zip4;
		SELF.cart											:=	L.AIDWork_ACECache.cart;
		SELF.cr_sort_sz							:=	L.AIDWork_ACECache.cr_sort_sz;
		SELF.lot											:=	L.AIDWork_ACECache.lot;
		SELF.lot_order								:=	L.AIDWork_ACECache.lot_order;
		SELF.dbpc											:=	L.AIDWork_ACECache.dbpc;
		SELF.chk_digit								:=	L.AIDWork_ACECache.chk_digit;
		SELF.rec_type								:=	L.AIDWork_ACECache.rec_type;
		SELF.fips_state							:=	L.AIDWork_ACECache.county[1..2];
		SELF.fips_county						:=	L.AIDWork_ACECache.county[3..];
		SELF.geo_lat									:=	L.AIDWork_ACECache.geo_lat;
		SELF.geo_long								:=	L.AIDWork_ACECache.geo_long;
		SELF.msa											:=	L.AIDWork_ACECache.msa;
		SELF.geo_blk									:=	L.AIDWork_ACECache.geo_blk;
		SELF.geo_match								:=	L.AIDWork_ACECache.geo_match;
		SELF.err_stat								:=	L.AIDWork_ACECache.err_stat;
		SELF.rawaid									:=	L.AIDWork_RawAID;
		SELF														:=	L;
	END;
	
	// Put records back into base file layout
	fCleanedAddress	:=	PROJECT(dNoAddress,TRANSFORM(RECORDOF(pInput),SELF:=LEFT)) +
													PROJECT(appendAddr,tFillAddr(LEFT));
	
	
	RETURN fCleanedAddress;
	
END;