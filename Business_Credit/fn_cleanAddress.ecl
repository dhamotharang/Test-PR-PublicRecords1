IMPORT Header, Address, AID, ut;
EXPORT fn_cleanAddress(DATASET(RECORDOF(Business_Credit.Layouts.SBFE_Account_Layout)) pInput) := FUNCTION 

	// Clean Address Field
	layout_Clean_Address_Fields := record
		pInput;
		STRING76	clean_orig_address1	:=	'';
		STRING76	clean_orig_address2	:=	'';
	END;

	fnCleanAddressField(STRING	addrField)	:=	FUNCTION
		RETURN(IF(ut.fnTrim2Upper(addrField) 
							NOT IN ['','-','UNK','PENDING','- PENDING','UNKNOWN','UNKNOWN UNKNOWN'],ut.fnTrim2Upper(addrField),''));
	END;

	layout_Clean_Address_Fields	tCleanAddressFields(RECORDOF(pInput) pInput)	:=	TRANSFORM
		clean_street_address			:=	fnCleanAddressField(pInput.Orig_Address_Line_1+' '+pInput.Orig_Address_Line_2);
		clean_city								:=	fnCleanAddressField(pInput.Orig_City);
		clean_state								:=	fnCleanAddressField(pInput.Orig_State);
		clean_zip5								:=	fnCleanAddressField(pInput.Orig_Zip_Code_or_CA_Postal_Code);
		clean_zip4								:=	fnCleanAddressField(pInput.Orig_Postal_Code);

		STRING76 orig_address1		:= 	ut.fnTrim2Upper(clean_street_address);
		STRING76 orig_address2		:= 	ut.fnTrim2Upper(
																		IF(	clean_city<>'' AND (clean_state<>'' OR clean_zip5<>''),
																				clean_city+', ',
																				clean_city
																		)+clean_state+' '+clean_zip5+
																		IF(clean_zip5='' OR clean_zip4='','','-'+clean_zip4)
																	);
		SELF.clean_orig_address1	:=	ut.fn_addr_clean_prep(orig_address1,'first');
		SELF.clean_orig_address2	:=	ut.fn_addr_clean_prep(orig_address2,'last');
		SELF											:=	pInput;
	END;
	dCleanAddressFields	:=	PROJECT(pInput,tCleanAddressFields(LEFT));

	// Split Records with address from records without
	dNoAddress	:=	dCleanAddressFields(clean_orig_address1=''	AND	clean_orig_address2 =''); 
	dHasAddress	:=	dCleanAddressFields(clean_orig_address1<>''	OR	clean_orig_address2 <>'');

	// Clean US addresses
	UNSIGNED4 lAIDAppendFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;
	AID.MacAppendFromRaw_2Line(dHasAddress,clean_orig_address1,clean_orig_address2,rawaid,appendAddr,lAIDAppendFlags);
	
	// Fill fields after running through Address Cleaners.
	RECORDOF(pInput) tFillAddr(RECORDOF(appendAddr) pInput)	:=	TRANSFORM
		SELF.prim_range		:=	pInput.AIDWork_ACECache.prim_range;
		SELF.predir				:=	pInput.AIDWork_ACECache.predir;
		SELF.prim_name		:=	pInput.AIDWork_ACECache.prim_name;
		SELF.addr_suffix	:=	pInput.AIDWork_ACECache.addr_suffix;
		SELF.postdir			:=	pInput.AIDWork_ACECache.postdir;
		SELF.unit_desig		:=	pInput.AIDWork_ACECache.unit_desig;
		SELF.sec_range		:=	pInput.AIDWork_ACECache.sec_range;
		SELF.p_city_name	:=	pInput.AIDWork_ACECache.p_city_name;
		SELF.v_city_name	:=	pInput.AIDWork_ACECache.v_city_name;
		SELF.st						:=	IF(pInput.AIDWork_ACECache.st = '',ziplib.ZipToState2(pInput.AIDWork_ACECache.zip5),pInput.AIDWork_ACECache.st);
		SELF.zip					:=	pInput.AIDWork_ACECache.zip5;
		SELF.zip4					:=	pInput.AIDWork_ACECache.zip4;
		SELF.cart					:=	pInput.AIDWork_ACECache.cart;
		SELF.cr_sort_sz		:=	pInput.AIDWork_ACECache.cr_sort_sz;
		SELF.lot					:=	pInput.AIDWork_ACECache.lot;
		SELF.lot_order		:=	pInput.AIDWork_ACECache.lot_order;
		SELF.dbpc					:=	pInput.AIDWork_ACECache.dbpc;
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
		SELF							:=	pInput;
	END;
	
	// Put records back into the Supplemental Format
	clean_bc	:=	PROJECT(dNoAddress,TRANSFORM(RECORDOF(pInput),SELF:=LEFT))+
								PROJECT(appendAddr,tFillAddr(LEFT));

	RETURN clean_bc;
END;
