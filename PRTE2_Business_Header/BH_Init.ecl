import Address, AID, Business_Header, ut, PRTE2;

export BH_Init (

		dataset(Layouts.Input.Layout_BusHeader	)	pInput_Bus_Header		= Files().Input.BusHeader.using
//	dataset(Business_Header.Layout_Business_Header_New)	pAll_Business_Header_Sources	= Business_Sources.business_headers
	
) :=
function

	dIn_BusHdr := pInput_Bus_Header;
	
	//*** Normalizing Business and mailing addresses
	Layouts.Temporary.Layout_BH_Norm trfBH_Addr_Norm(dIn_BusHdr l, unsigned c) := transform,
					skip(c = 2 and (ut.CleanSpacesAndUpper(l.mailing_city + l.mailing_st + l.mailing_zip) ='' or
													ut.CleanSpacesAndUpper(l.bus_Addr1 + l.bus_city + l.bus_st + l.bus_zip) = 
													ut.CleanSpacesAndUpper(l.mailing_Addr + l.mailing_city + l.mailing_st + l.mailing_zip))
							)
			self.Addr1							:= choose(c, ut.CleanSpacesAndUpper(l.Bus_Addr1), ut.CleanSpacesAndUpper(l.mailing_addr));
			self.Addr2							:= choose(c, ut.CleanSpacesAndUpper(l.Bus_Addr2), '');
			self.City								:= choose(c, ut.CleanSpacesAndUpper(l.Bus_City), ut.CleanSpacesAndUpper(l.mailing_city));
			self.State							:= choose(c, ut.CleanSpacesAndUpper(l.Bus_St), ut.CleanSpacesAndUpper(l.mailing_st));
			self.ZipCode						:= choose(c, ut.CleanSpacesAndUpper(l.Bus_Zip), ut.CleanSpacesAndUpper(l.mailing_zip));
			self.Addr_Type					:= choose(c, 'B', 'M');
			self 										:= l;
			self 										:= [];
	end;
	
	dBH_Addr_norm := Normalize(dIn_BusHdr, 2, trfBH_Addr_Norm(left, counter));
	
	//*** preping the addresses for AID call.
	Layouts.Temporary.Layout_BH_Norm trfBH_Prep_Addr(dBH_Addr_norm l) :=  transform,
						skip(ut.CleanSpacesAndUpper(l.link_fein) = 'LINK_FEIN' and 
								 ut.CleanSpacesAndUpper(l.link_inc_date) = 'LINK_INC_DATE'
								)
			
			self.prep_address_first	:= Address.fn_addr_clean_prep(l.Addr1, 'first');
			self.prep_address_last	:= if(trim(l.city) <> '',
																		Address.fn_addr_clean_prep(l.City+', '+l.State+' '+l.ZipCode, 'last'),
																		Address.fn_addr_clean_prep(l.State+' '+l.ZipCode, 'last')
																	 );
			self.long_bus_name			:= ut.CleanSpacesAndUpper(l.long_bus_name);
			self.cust_name					:= ut.CleanSpacesAndUpper(l.cust_name);
			self.rel1_bdid					:= ut.CleanSpacesAndUpper(l.rel1_bdid);
			self.rel1_fein					:= ut.CleanSpacesAndUpper(l.rel1_fein);
			self.rel1_type					:= ut.CleanSpacesAndUpper(l.rel1_type);
			self.rel2_type					:= ut.CleanSpacesAndUpper(l.rel2_type);
			self.rel3_type					:= ut.CleanSpacesAndUpper(l.rel3_type);
			self.rel4_type					:= ut.CleanSpacesAndUpper(l.rel4_type);
			self.rel5_type					:= ut.CleanSpacesAndUpper(l.rel5_type);
			self.rel6_type					:= ut.CleanSpacesAndUpper(l.rel6_type);
			self.rel7_type					:= ut.CleanSpacesAndUpper(l.rel7_type);
			self.rel8_type					:= ut.CleanSpacesAndUpper(l.rel8_type);
			self.rel9_type					:= ut.CleanSpacesAndUpper(l.rel9_type);
			self.rel10_type					:= ut.CleanSpacesAndUpper(l.rel10_type);
			self.rel11_type					:= ut.CleanSpacesAndUpper(l.rel11_type);
			self										:= l;
	end;
	
	dBH_Prep_Addr := project(dBH_Addr_norm, trfBH_Prep_Addr(left));
	
	//*** Assigning temp unique ids to use later in the below join after the AID cleaned output
	ut.MAC_Sequence_Records(dBH_Prep_Addr, uniq_id, dBH_Prep_Addr_w_uniq_id)
		
	dBH_Addr_For_AID := dBH_Prep_Addr_w_uniq_id : persist('~prte::persist::PRTE2_Business_Header::BH_Init::Uniq_id');
	
	//*** Slim the file with just addresses for AID address cleaner 
	BH_Addr_for_AID := project(dBH_Addr_For_AID, 
														 transform(prte2_business_header.Layouts.Temporary.Layout_For_AID_Addr,
																			 self.prep_address_first := left.prep_address_first,
																			 self.prep_address_last  := left.prep_address_last,
																			 self.uniq_id            := left.uniq_id,
																			 self                    := left
																			)
														);
	
	dBH_with_addr := BH_Addr_for_AID(trim(prep_address_last) <> '');
	
	unsigned4	lFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords | AID.Common.eReturnValues.NoNewCacheFiles;
	
	AID.MacAppendFromRaw_2Line(dBH_with_addr, prep_address_first, prep_address_last, RawAID, dWithAID, lFlags);

	dBH_WithAID:= dWithAID :independent;
	
	//Append cleaned address fields
	Layouts.Out.Layout_BH_Out tMapClnAddr(dBH_Addr_For_AID l, dBH_WithAID r) := transform
			self.RawAID					:= r.aidwork_rawaid;
			self.AceAID					:= r.AIDWork_ACECache.aid;
			self.prim_range     := r.AIDWork_ACECache.prim_range;
			self.predir         := r.AIDWork_ACECache.predir;
			self.prim_name      := r.AIDWork_ACECache.prim_name;
			self.addr_suffix		:= r.AIDWork_ACECache.addr_suffix;
			self.postdir        := r.AIDWork_ACECache.postdir;
			self.unit_desig	   	:= r.AIDWork_AceCache.unit_desig;
			self.sec_range      := r.AIDWork_ACECache.sec_range;
			self.p_city_name    := r.AIDWork_ACECache.p_city_name;
			self.v_city_name    := r.AIDWork_ACECache.v_city_name;
			self.st             := r.AIDWork_ACECache.st;
			self.zip	          := if(trim(l.cust_name) = '', trim(l.ZipCode), r.aidwork_acecache.zip5);
			self.zip4           := if(trim(l.cust_name) = '', trim(l.bus_zip4), r.aidwork_acecache.zip4);
			self.cart		       	:= r.AIDWork_AceCache.cart;
			self.cr_sort_sz	   	:= r.AIDWork_AceCache.cr_sort_sz;
			self.lot		       	:= r.AIDWork_AceCache.lot;
			self.lot_order		  := r.AIDWork_AceCache.lot_order;
			self.dbpc		       	:= r.AIDWork_AceCache.dbpc;
			self.chk_digit		  := r.AIDWork_AceCache.chk_digit;
			self.rec_type	      := r.AIDWork_AceCache.rec_type;
			self.fips_state		  := r.AIDWork_AceCache.county[1..2];
			self.fips_county   	:= if(trim(l.cust_name) = '', trim(l.filler2), r.AIDWork_AceCache.county[3..]);
			self.geo_lat		   	:= if(trim(l.cust_name) = '', trim(l.filler4), r.AIDWork_AceCache.geo_lat);
			self.geo_long		   	:= if(trim(l.cust_name) = '', trim(l.filler5), r.AIDWork_AceCache.geo_long);
			self.msa			   		:= if(trim(l.cust_name) = '', trim(l.filler3), r.AIDWork_AceCache.msa);
			self.geo_blk		   	:= r.AIDWork_AceCache.geo_blk;
			self.geo_match		  := r.AIDWork_AceCache.geo_match;
			self.err_stat		   	:= r.AIDWork_AceCache.err_stat;
			self.bdid						:= (unsigned6)l.bdid;
			self								:= l;
	end;

	jBH_CleanAddr	:= JOIN(dBH_Addr_For_AID,
												dBH_WithAID,
												left.uniq_id = right.uniq_id,
												tMapClnAddr(left,right),left outer);
	
	// Appending the fake BDID's for ONLY new business entitie records, cust_name <> ''.
	bh_out_recs := project(jBH_CleanAddr, transform(Layouts.Out.Layout_BH_Out, 
																									self.bdid	:= if(trim(left.cust_name) = '',
																																	left.bdid,
																																	PRTE2.fn_AppendFakeID.bdid(left.long_bus_name, 
																																														 left.prim_range, 
																																														 left.prim_name, 
																																														 left.v_city_name, 
																																														 left.st, 
																																														 left.zip,
																																														 left.cust_name)
																																 ),																																
																									self := left)
												): persist('~prte::persist::PRTE2_Business_Header::BH_Init');
												
	return bh_out_recs(bdid <> 0);

end;