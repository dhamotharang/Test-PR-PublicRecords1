import AID,codes;
export Update_Base( dataset(layouts.Input)	pUpdateFile
										,dataset(Layouts.Base)	pBaseFile
										,string	pversion
									 ) := function
	
	dStandardizedInputFile  := 	Diversity_Certification.StandardizeInputFile.fAll  (pUpdateFile, pversion);
	
	update_combined					:=	if(Diversity_Certification._Flags.Update
																,dStandardizedInputFile + pBaseFile
																,dStandardizedInputFile
																) : persist('~persist::DivCert::Combined');
																
	trimUpper(string s) := function
		return trim(stringlib.StringToUppercase(s),left,right);
	end;
	
	Diversity_Certification.Layouts.keybuild tAddUniqueId(Diversity_Certification.Layouts.Base l, unsigned8 cnt)	:=	transform
			self.unique_id	:= 	cnt;
			self						:= 	l;
			self						:=	[];
	end;   
      
	dAddUniqueId 		:= project(update_combined, tAddUniqueId(left,counter)) : persist('persist::DivCert::AddID');
	
	 addresslayout 	:=	record,maxlength(_Dataset().max_record_size)
			Diversity_Certification.Layouts.keybuild;
			unsigned8	rawaid;
			unsigned1	addr_type;	// 	Mailing or Physical Address
			string100	PrepAddress1;
			string50	PrepAddress2;
	end;
	
	addresslayout tNormalizeAddress(Diversity_Certification.Layouts.keybuild l, unsigned1 cnt)	:=	transform
			self.addr_type		:= 	cnt;
			self.PrepAddress1	:= 	choose(cnt	,l.Append_Prep_MailAddress1	,l.Append_Prep_PhyAddress1);
			self.PrepAddress2	:= 	choose(cnt	,l.Append_Prep_MailAddressLast,l.Append_Prep_PhyAddressLast);           
			self.rawaid				:= 	choose(cnt	,l.Append_MailRawAID,l.Append_PhyRawAID	);
			self							:=	l;					 
	end;
	
		// Normalize the Mailing addresses to pass them to AID process
	dPreAddrNormForAID   := 	normalize(dAddUniqueId,if(trim(left.Append_Prep_MailAddress1,left,right)    = trim(left.Append_Prep_PhyAddress1,left,right) and
																									trim(left.Append_Prep_MailAddressLast,left,right) = trim(left.Append_Prep_PhyAddressLast,left,right)
																											OR
                                                    (trim(left.Append_Prep_PhyAddress1,left,right) = '' and trim(left.Append_Prep_PhyAddressLast,left,right) = '')
																							,1,2), tNormalizeAddress(left,counter)) : persist('persist::DivCert::Normalize');	
																

	HasAddress					:= trim(dPreAddrNormForAID.PrepAddress2, left,right) != '';
	dWith_address				:= dPreAddrNormForAID(HasAddress);

	SlimWithAddr	 			:=	record,maxlength(_Dataset().max_record_size)
			unsigned6					unique_id;
			string100					Append_Prep_MailAddress1;
			string50					Append_Prep_MailAddressLast;
			AID.Common.xAID		Append_MailRawAID;
			string100					Append_Prep_PhyAddress1;
			string50					Append_Prep_PhyAddressLast;
			AID.Common.xAID		Append_PhyRawAID;
			string10					m_prim_range; 
			string2						m_predir;	
			string28					m_prim_name;	
			string4						m_addr_suffix; 
			string2						m_postdir;	
			string10					m_unit_desig;	
			string8						m_sec_range;	
			string25					m_p_city_name;	
			string25					m_v_city_name; 
			string2						m_st;	
			string5						m_zip;	
			string4						m_zip4;	
			string4						m_cart;	
			string1						m_cr_sort_sz;	
			string4						m_lot;	
			string1						m_lot_order;	
			string2						m_dbpc;	
			string1						m_chk_digit;	
			string2						m_rec_type;	
			string2						m_fips_state;	
			string3						m_fips_county;	
			string10					m_geo_lat;	
			string11					m_geo_long;	
			string4						m_msa;	
			string7						m_geo_blk;	
			string1						m_geo_match;	
			string4						m_err_stat;	
			string10					p_prim_range; 
			string2						p_predir;	
			string28					p_prim_name;	
			string4						p_addr_suffix; 
			string2						p_postdir;	
			string10					p_unit_desig;	
			string8						p_sec_range;	
			string25					p_p_city_name;	
			string25					p_v_city_name; 
			string2						p_st;	
			string5						p_zip;	
			string4						p_zip4;	
			string4						p_cart;	
			string1						p_cr_sort_sz;	
			string4						p_lot;	
			string1						p_lot_order;	
			string2						p_dbpc;	
			string1						p_chk_digit;	
			string2						p_rec_type;	
			string2						p_fips_state;	
			string3						p_fips_county;	
			string10					p_geo_lat;	
			string11					p_geo_long;	
			string4						p_msa;	
			string7						p_geo_blk;	
			string1						p_geo_match;	
			string4						p_err_stat;				
			unsigned8					rawaid;
			unsigned1					addr_type;	// 	Mailing or Physical Address
			string100					PrepAddress1;
			string50					PrepAddress2;
	end;
	dSlimWithAddr			:= project(dWith_address,TRANSFORM(SlimWithAddr,SELF := LEFT;));
	
	lFlags 						:= AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;
	AID.MacAppendFromRaw_2Line(dSlimWithAddr, prepAddress1, PrepAddress2, rawaid, dwithAID, lFlags);

	Diversity_Certification.Layouts.keybuild tGetStandardizedAddress(Diversity_Certification.Layouts.keybuild l	,dwithAID r)	:=	transform
			self.Append_MailRawAID:= 	if(r.addr_type = 1,	r.AIDWork_RawAID,								l.Append_MailRawAID);
			self.m_prim_range			:=	if(r.addr_type = 1,	r.AIDWork_ACECache.prim_range,	l.m_prim_range);
			self.m_predir					:=	if(r.addr_type = 1,	r.AIDWork_ACECache.predir,			l.m_predir);
			self.m_prim_name			:=	if(r.addr_type = 1,	r.AIDWork_ACECache.prim_name,		l.m_prim_name);
			self.m_addr_suffix		:=	if(r.addr_type = 1,	r.AIDWork_ACECache.addr_suffix,	l.m_addr_suffix);
			self.m_postdir				:=	if(r.addr_type = 1,	r.AIDWork_ACECache.postdir,			l.m_postdir);
			self.m_unit_desig			:=	if(r.addr_type = 1,	r.AIDWork_ACECache.unit_desig,	l.m_unit_desig);
			self.m_sec_range			:=	if(r.addr_type = 1,	r.AIDWork_ACECache.sec_range,		l.m_sec_range);		
			self.m_p_city_name		:=	if(r.addr_type = 1,	r.AIDWork_ACECache.p_city_name,	l.m_p_city_name);	
			self.m_v_city_name		:=	if(r.addr_type = 1,	r.AIDWork_ACECache.v_city_name,	l.m_v_city_name);	
			self.m_st							:=	if(r.addr_type = 1,	r.AIDWork_ACECache.st,					l.m_st);	
			self.m_zip						:=	if(r.addr_type = 1,	r.AIDWork_ACECache.zip5,				l.m_zip);	
			self.m_zip4						:=	if(r.addr_type = 1,	r.AIDWork_ACECache.zip4,				l.m_zip4);	
			self.m_cart						:=	if(r.addr_type = 1,	r.AIDWork_ACECache.cart,				l.m_cart);	
			self.m_cr_sort_sz			:=	if(r.addr_type = 1,	r.AIDWork_ACECache.cr_sort_sz,	l.m_cr_sort_sz);	
			self.m_lot						:=	if(r.addr_type = 1,	r.AIDWork_ACECache.lot,					l.m_lot);				
			self.m_lot_order			:=	if(r.addr_type = 1,	r.AIDWork_ACECache.lot_order,		l.m_lot_order);
			self.m_dbpc						:=	if(r.addr_type = 1,	r.AIDWork_ACECache.dbpc,				l.m_dbpc);	
			self.m_chk_digit			:=	if(r.addr_type = 1,	r.AIDWork_ACECache.chk_digit,		l.m_chk_digit);	
			self.m_rec_type				:=	if(r.addr_type = 1,	r.AIDWork_ACECache.rec_type, 		l.m_rec_type);
			self.m_fips_state			:=	if(r.addr_type = 1,	r.AIDWork_ACECache.county[1..2],l.m_fips_state);	
			self.m_fips_county		:=	if(r.addr_type = 1,	r.AIDWork_ACECache.county[3..5],l.m_fips_county);	
			self.m_geo_lat				:=	if(r.addr_type = 1,	r.AIDWork_ACECache.geo_lat,			l.m_geo_lat);	
			self.m_geo_long				:=	if(r.addr_type = 1,	r.AIDWork_ACECache.geo_long,		l.m_geo_long);	
			self.m_msa						:=	if(r.addr_type = 1,	r.AIDWork_ACECache.msa,					l.m_msa);	
			self.m_geo_blk				:=	if(r.addr_type = 1,	r.AIDWork_ACECache.geo_blk,			l.m_geo_blk);	
			self.m_geo_match			:=	if(r.addr_type = 1,	r.AIDWork_ACECache.geo_match,		l.m_geo_match);
			self.m_err_stat				:=	if(r.addr_type = 1,	r.AIDWork_ACECache.err_stat,		l.m_err_stat);
			self.Append_PhyRawAID	:= 	if(r.addr_type = 2,	r.AIDWork_RawAID,								l.Append_PhyRawAID);
			self.p_prim_range			:=	if(r.addr_type = 2,	r.AIDWork_ACECache.prim_range,	l.p_prim_range);
			self.p_predir					:=	if(r.addr_type = 2,	r.AIDWork_ACECache.predir,			l.p_predir);
			self.p_prim_name			:=	if(r.addr_type = 2,	r.AIDWork_ACECache.prim_name,		l.p_prim_name);
			self.p_addr_suffix		:=	if(r.addr_type = 2,	r.AIDWork_ACECache.addr_suffix,	l.p_addr_suffix);
			self.p_postdir				:=	if(r.addr_type = 2,	r.AIDWork_ACECache.postdir,			l.p_postdir);
			self.p_unit_desig			:=	if(r.addr_type = 2,	r.AIDWork_ACECache.unit_desig,	l.p_unit_desig);
			self.p_sec_range			:=	if(r.addr_type = 2,	r.AIDWork_ACECache.sec_range,		l.p_sec_range);		
			self.p_p_city_name		:=	if(r.addr_type = 2,	r.AIDWork_ACECache.p_city_name,	l.p_p_city_name);	
			self.p_v_city_name		:=	if(r.addr_type = 2,	r.AIDWork_ACECache.v_city_name,	l.p_v_city_name);	
			self.p_st							:=	if(r.addr_type = 2,	r.AIDWork_ACECache.st,					l.p_st);	
			self.p_zip						:=	if(r.addr_type = 2,	r.AIDWork_ACECache.zip5,				l.p_zip);	
			self.p_zip4						:=	if(r.addr_type = 2,	r.AIDWork_ACECache.zip4,				l.p_zip4);	
			self.p_cart						:=	if(r.addr_type = 2,	r.AIDWork_ACECache.cart,				l.p_cart);	
			self.p_cr_sort_sz			:=	if(r.addr_type = 2,	r.AIDWork_ACECache.cr_sort_sz,	l.p_cr_sort_sz);	
			self.p_lot						:=	if(r.addr_type = 2,	r.AIDWork_ACECache.lot,					l.p_lot);				
			self.p_lot_order			:=	if(r.addr_type = 2,	r.AIDWork_ACECache.lot_order,		l.p_lot_order);
			self.p_dbpc						:=	if(r.addr_type = 2,	r.AIDWork_ACECache.dbpc,				l.p_dbpc);	
			self.p_chk_digit			:=	if(r.addr_type = 2,	r.AIDWork_ACECache.chk_digit,		l.p_chk_digit);	
			self.p_rec_type				:=	if(r.addr_type = 2,	r.AIDWork_ACECache.rec_type, 		l.p_rec_type);
			self.p_fips_state			:=	if(r.addr_type = 2,	r.AIDWork_ACECache.county[1..2],l.p_fips_state);	
			self.p_fips_county		:=	if(r.addr_type = 2,	r.AIDWork_ACECache.county[3..5],l.p_fips_county);	
			self.p_geo_lat				:=	if(r.addr_type = 2,	r.AIDWork_ACECache.geo_lat,			l.p_geo_lat);	
			self.p_geo_long				:=	if(r.addr_type = 2,	r.AIDWork_ACECache.geo_long,		l.p_geo_long);	
			self.p_msa						:=	if(r.addr_type = 2,	r.AIDWork_ACECache.msa,					l.p_msa);	
			self.p_geo_blk				:=	if(r.addr_type = 2,	r.AIDWork_ACECache.geo_blk,			l.p_geo_blk);	
			self.p_geo_match			:=	if(r.addr_type = 2,	r.AIDWork_ACECache.geo_match,		l.p_geo_match);
			self.p_err_stat				:=	if(r.addr_type = 2,	r.AIDWork_ACECache.err_stat,		l.p_err_stat);
			self									:= 	l;
	end;
		
	dAddressAppended					:= join( dAddUniqueId
																		,dwithAID
																		,left.unique_id = right.unique_id
																		,tGetStandardizedAddress(left,right)
																		,left outer
																		): persist('persist::DivCert::Final');
																		
	dAppendIds								:= 	Append_Ids.fAll	(dAddressAppended );
	
	dRollupBase								:= 	Rollup_Base	(dAppendIds);
	
	return dRollupBase;
	
end;