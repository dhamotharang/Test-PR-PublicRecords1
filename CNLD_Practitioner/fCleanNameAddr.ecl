IMPORT lib_fileservices,_Control,lib_stringlib,AID,address,idl_header,nid;

fCleanNameAddrPrep(DATASET(CNLD_Practitioner.layouts.temp) pTempFileInput) := FUNCTION

		HasAddress				:= 	trim(pTempFileInput.Append_AddrLineLast, left,right) != '';
												
		dWith_address			:= 	pTempFileInput(HasAddress);
		dWithout_address	:= 	pTempFileInput(not(HasAddress));
					
		unsigned4		lAIDAppendFlags	:=	AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;
				
		AID.MacAppendFromRaw_2Line(dWith_address, Append_AddrLine1, Append_AddrLineLast, Append_RawAID, dAddressCleaned, lAIDAppendFlags);
		
		// dAddressStandardized_dist		:= distribute(dwithAID ,hash(gennum));	
		
		CNLD_Practitioner.layouts.keybuild tGetStandardizedAddress(dAddressCleaned l)	:=	transform
			self.date_firstSeen			:=	20090226;
			self.date_LastSeen			:=	20090226;
			self.Append_RawAID			:= 	l.AIDWork_RawAID;
		  self.Append_ACEAID 			:=  l.AIDWork_ACECache.aid; 
			self.prim_range					:=	l.AIDWork_ACECache.prim_range;
			self.predir							:=	l.AIDWork_ACECache.predir;
			self.prim_name					:=	l.AIDWork_ACECache.prim_name;
			self.addr_suffix				:=	l.AIDWork_ACECache.addr_suffix;
			self.postdir						:=	l.AIDWork_ACECache.postdir;
			self.unit_desig					:=	l.AIDWork_ACECache.unit_desig;
			self.sec_range					:=	l.AIDWork_ACECache.sec_range;		
			self.p_city_name				:=	l.AIDWork_ACECache.p_city_name;	
			self.v_city_name				:=	l.AIDWork_ACECache.v_city_name;	
			self.st									:=	l.AIDWork_ACECache.st;	
			self.zip								:=	l.AIDWork_ACECache.zip5;	
			self.zip4								:=	l.AIDWork_ACECache.zip4;	
			self.cart								:=	l.AIDWork_ACECache.cart;	
			self.cr_sort_sz					:=	l.AIDWork_ACECache.cr_sort_sz;	
			self.lot								:=	l.AIDWork_ACECache.lot;				
			self.lot_order					:=	l.AIDWork_ACECache.lot_order;
			self.dbpc								:=	l.AIDWork_ACECache.dbpc;	
			self.chk_digit					:=	l.AIDWork_ACECache.chk_digit;	
			self.rec_type						:=	l.AIDWork_ACECache.rec_type;
			self.fips_state					:=	l.AIDWork_ACECache.county[1..2];	
			self.fips_county				:=	l.AIDWork_ACECache.county[3..5];	
			self.geo_lat						:=	l.AIDWork_ACECache.geo_lat;	
			self.geo_long						:=	l.AIDWork_ACECache.geo_long;	
			self.msa								:=	l.AIDWork_ACECache.msa;	
			self.geo_blk						:=	l.AIDWork_ACECache.geo_blk;	
			self.geo_match					:=	l.AIDWork_ACECache.geo_match;
			self.err_stat						:=	l.AIDWork_ACECache.err_stat;
			self										:= 	l;
			self										:=	[];
	end;
		
	dAddressAppended	:=	project(dAddressCleaned, tGetStandardizedAddress(left)) + 
												project(dWithout_address,TRANSFORM(CNLD_Practitioner.layouts.keybuild,SELF := LEFT; SELF	:=	[];));	
												
	NID.Mac_CleanParsedNames(	dAddressAppended
														, cleanNames
														, firstName
														, middleName
														, lastName
														, suffix
													);												

	return	CleanNames;
		
end;

EXPORT fCleanNameAddr(DATASET(CNLD_Practitioner.layouts.temp) pTempFileInput) := FUNCTION

	CleanNames	:=	fCleanNameAddrPrep(pTempFileInput);
																		
	CNLD_Practitioner.layouts.keybuild tfrPopCleanedNames(cleanNames pInput)	:=	transform
			self.title				:=	pInput.cln_title;
			self.fname				:=	pInput.cln_fname;
			self.mname				:=	pInput.cln_mname;
			self.lname				:=	pInput.cln_lname;
			self.name_suffix	:=	pInput.cln_suffix;
			self							:=	pInput;
	end;
		
	CleanedUpFile	:=	project(cleanNames, tfrPopCleanedNames(left));
		
	return CleanedUpFile;
		
end;