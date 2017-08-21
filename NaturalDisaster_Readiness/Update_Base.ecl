IMPORT AID;

export Update_Base(
										dataset(Layouts.Input)	pUpdateFile,
										dataset(Layouts.Base)		pBaseFile,
										string pversion
									) := function
	
	//dStandardizedInputFile is in the base layout format
	dStandardizedInputFile  := 	NaturalDisaster_Readiness.StandardizeInputFile.fAll(pUpdateFile, pversion);
	
	update_combined					:=	if(NaturalDisaster_Readiness._Flags.Update
																,dStandardizedInputFile + pBaseFile
																,dStandardizedInputFile
																) : persist(_Dataset().thor_cluster_Persists+'persist::'+_Dataset().name+'::Combined');

  HasAddress							:=	trim(update_combined.Append_MailAddress1, left,right) != ''
													AND	trim(update_combined.Append_MailAddressLast, left,right) != '';
									
	dWith_address						:= 	update_combined(HasAddress);

	dWithout_address				:= 	update_combined(not(HasAddress));			

	lFlags := AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;

	AID.MacAppendFromRaw_2Line(dWith_address, Append_MailAddress1, Append_MailAddresslast, Append_MailRawAID, dwithAID, lFlags);

	dAddressStandardized_dist		:= distribute(dwithAID ,hash(Business_Acronym,Business_Address1));	

	NaturalDisaster_Readiness.layouts.keybuild tGetStandardizedAddress(dAddressStandardized_dist l)	:=	transform
			self.Append_MailRawAID		:= 	l.AIDWork_RawAID;
			self.Append_MailAceAID		:= 	l.AIDWork_ACECache.AID;
			self.m_prim_range					:=	l.AIDWork_ACECache.prim_range;
			self.m_predir							:=	l.AIDWork_ACECache.predir;
			self.m_prim_name					:=	l.AIDWork_ACECache.prim_name;
			self.m_addr_suffix				:=	l.AIDWork_ACECache.addr_suffix;
			self.m_postdir						:=	l.AIDWork_ACECache.postdir;
			self.m_unit_desig					:=	l.AIDWork_ACECache.unit_desig;
			self.m_sec_range					:=	l.AIDWork_ACECache.sec_range;		
			self.m_p_city_name				:=	l.AIDWork_ACECache.p_city_name;	
			self.m_v_city_name				:=	l.AIDWork_ACECache.v_city_name;	
			self.m_st									:=	l.AIDWork_ACECache.st;	
			self.m_zip								:=	l.AIDWork_ACECache.zip5;	
			self.m_zip4								:=	l.AIDWork_ACECache.zip4;	
			self.m_cart								:=	l.AIDWork_ACECache.cart;	
			self.m_cr_sort_sz					:=	l.AIDWork_ACECache.cr_sort_sz;	
			self.m_lot								:=	l.AIDWork_ACECache.lot;				
			self.m_lot_order					:=	l.AIDWork_ACECache.lot_order;
			self.m_dbpc								:=	l.AIDWork_ACECache.dbpc;	
			self.m_chk_digit					:=	l.AIDWork_ACECache.chk_digit;	
			self.m_rec_type						:=	l.AIDWork_ACECache.rec_type;
			self.m_fips_state					:=	l.AIDWork_ACECache.county[1..2];	
			self.m_fips_county				:=	l.AIDWork_ACECache.county[3..5];	
			self.m_geo_lat						:=	l.AIDWork_ACECache.geo_lat;	
			self.m_geo_long						:=	l.AIDWork_ACECache.geo_long;	
			self.m_msa								:=	l.AIDWork_ACECache.msa;	
			self.m_geo_blk						:=	l.AIDWork_ACECache.geo_blk;	
			self.m_geo_match					:=	l.AIDWork_ACECache.geo_match;
			self.m_err_stat						:=	l.AIDWork_ACECache.err_stat;
			self											:= 	l;
	end;
		
	dAddressAppended			:=	project(dAddressStandardized_dist, tGetStandardizedAddress(left)) + 
														project(dWithout_address,TRANSFORM(NaturalDisaster_Readiness.layouts.keybuild,SELF := LEFT; SELF	:=	[];));

	dAppendIds						:= 	Append_Ids.fAll	(dAddressAppended);

	dDistNewKeyBuildFile	:=	distribute(dAppendIds,hash(BDID));	

	dRollupKeyBuildFile		:= 	Rollup_Base	(dDistNewKeyBuildFile);

	return dRollupKeyBuildFile;

end;