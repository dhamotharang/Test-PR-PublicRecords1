import lib_stringlib, ut, address, idl_header, aid, NID;

in_file   := Txbus.File_Txbus_In.File_Cleaned_Super;

base_file := project(Txbus.File_Txbus_Base, transform(Txbus.Layouts_txbus.Layout_Common,self:=left));

pShouldUpdate	:= txbus._Flags.Update;

update_combined		:= if(pShouldUpdate
												,in_file + base_file
												,in_file
												);
															
Temp_Txbus_Layout_Common:=record
		Txbus.Layouts_Txbus.Layout_Common;
		string73 tempTaxpayerName;
end;

Temp_Txbus_layout_Common trans_Name(Txbus.Layouts_Txbus.Layout_Common l) :=transform
//If Taxpayer_Org_Type = 'IS' then Taxpayer_Name will contain an induvidual's name instead of the  
//business name. So based on this conditions we only clean if it is an actual person name.
 			self.tempTaxpayerName := if(trim(l.Taxpayer_Name,left,right) <> '' and stringlib.StringToUpperCase(trim(l.Taxpayer_Org_Type,left,right)) = 'IS',
																			stringlib.StringToUpperCase(trim(l.Taxpayer_Name,left,right)),'');
			self							 		:= l;
			
end;
dCleanName := project(update_combined,trans_Name(left));
//*** Cleaning person names using the new NID name cleaner.
NID.Mac_CleanFullNames(dCleanName, cleaned_name_output, tempTaxpayerName);

Txbus.Layouts_Txbus.Layout_Common tStandardizeName(cleaned_name_output l) :=transform

			//////////////////////////////////////////////////////////////////////////////////////
			// -- Map Fields
			//////////////////////////////////////////////////////////////////////////////////////
			self.Taxpayer_title		         	:= l.cln_title;
			self.Taxpayer_fname	            := l.cln_fname;
			self.Taxpayer_mname	            := l.cln_mname;
			self.Taxpayer_lname		         	:= l.cln_lname;
			self.Taxpayer_name_suffix	      := l.cln_suffix;
			self.Taxpayer_name_score	      := '';
			self														:= l;
			
end;
dStandardizedName := project(cleaned_name_output, tStandardizeName(left));
				
//** Flipping the first & last names that are wrongly cleaned by name cleaner.
ut.mac_flipnames(dStandardizedName, Taxpayer_fname, Taxpayer_mname, Taxpayer_lname, in_file_flipnames)

//////////////////////////////////////////////////////////////////////////////////////
// -- Prepare Addresses for Cleaning using macro
//////////////////////////////////////////////////////////////////////////////////////
Txbus.Layouts_Txbus.Layout_AID_Temp tPreAddrCleaning(Txbus.Layouts_Txbus.Layout_Common l, unsigned8 cnt) := transform
		//////////////////////////////////////////////////////////////////////////////////////
		// -- Prepare Addresses for Cleaning using macro
		//////////////////////////////////////////////////////////////////////////////////////
		address1 											:=	Address.Addr1FromComponents(
																								 stringlib.stringtouppercase(l.Taxpayer_Address		)
																								,''
																								,''
																								,''
																								,''
																								,''
																								,''
																							); 
		address2 											:=	Address.Addr2FromComponents(
																								 stringlib.stringtouppercase(l.Taxpayer_City 	)	
																								,stringlib.stringtouppercase(l.Taxpayer_State	)	
																								,trim(l.Taxpayer_ZipCode,left,right)
																							);
																						
		mail_address1 								:=	Address.Addr1FromComponents(
																								 stringlib.stringtouppercase(l.outlet_Address		)
																								,''
																								,''
																								,''
																								,''
																								,''
																								,''
																							); 
		mail_address2 								:=	Address.Addr2FromComponents(
																								 stringlib.stringtouppercase(l.outlet_City 	)	
																								,stringlib.stringtouppercase(l.outlet_State	)	
																								,trim(l.outlet_ZipCode,left,right)
																							);		
		
		self.unique_id		 						:= cnt;
		self.prep_addr_line1 					:= address1;
		self.prep_addr_line_last			:= address2;
		self.prep_mail_addr_line1 		:= mail_address1;
		self.prep_mail_addr_line_last := mail_address2;
		self                    			:= l;
end;

dPreAddrForAID := project(in_file_flipnames, tPreAddrCleaning(left,counter)) : persist('~thor_data400::persist::txbus::cleaned_addr_txbus::addr_for_AID');

//---------------------------------------------------------------------------
//*** Normaize the business and mailing address for AID.
//---------------------------------------------------------------------------
Layout_Norm :=  record
		string1 		addr_type 		:= ''	;
		unsigned8		unique_id						;
		string100 	prep_addr_line1		 	;
		string50		prep_addr_line_last	;
		unsigned8		raw_aid				:= 0	;
		unsigned8		ace_aid				:= 0	;
end;

// Transform to normalize the mailing addresses..
Layout_Norm trfNormAddrs(dPreAddrForAID l, unsigned c) := transform									 
	self.prep_addr_line1  		:= choose(c, trim(l.prep_addr_line1), trim(l.prep_mail_addr_line1,left,right));
	self.prep_addr_line_last  := choose(c, trim(l.prep_addr_line_last), trim(l.prep_mail_addr_line_last,left,right));
	self.addr_type  					:= choose(c, 'O','M');
	self 											:= l;
end;

// Normalize the Mailing addresses to pass them to AID process
dPreAddrNormForAID	:= NORMALIZE(dPreAddrForAID
																,if(trim(left.prep_mail_addr_line1,left,right) <> '' or
																		trim(left.prep_mail_addr_line_last,left,right) <> '',2,1)
											 ,trfNormAddrs(left,counter));

HasAddress	      	:=	trim(dPreAddrNormForAID.prep_addr_line1, left,right) != ''and 
												trim(dPreAddrNormForAID.prep_addr_line_last, left,right) != '';
								
dWith_address				:= dPreAddrNormForAID(HasAddress);
dWithout_address		:= dPreAddrNormForAID(not(HasAddress));

unsigned4	lFlags 		:= AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	

AID.MacAppendFromRaw_2Line(dWith_address, prep_addr_line1, prep_addr_line_last, Raw_AID, dwithAID, lFlags);


//*** Transform the AID cleaned address records to get the clean address fields.
Txbus.Layouts_Txbus.Layout_AID_Clean_Temp tMapAidAddr(dwithAID l) := transform	
	self.raw_aid 									:= l.aidwork_rawaid;
	self.ace_aid 									:= l.aidwork_acecache.aid;
	self.Clean_Addr.prim_range		:= l.aidwork_acecache.prim_range;
	self.Clean_Addr.predir				:= l.aidwork_acecache.predir;
	self.Clean_Addr.prim_name			:= l.aidwork_acecache.prim_name;
	self.Clean_Addr.addr_suffix		:= l.aidwork_acecache.addr_suffix;
	self.Clean_Addr.postdir				:= l.aidwork_acecache.postdir;
	self.Clean_Addr.unit_desig		:= l.aidwork_acecache.unit_desig;
	self.Clean_Addr.sec_range			:= l.aidwork_acecache.sec_range;
	self.Clean_Addr.p_city_name		:= l.aidwork_acecache.p_city_name;
	self.Clean_Addr.v_city_name		:= l.aidwork_acecache.v_city_name;
	self.Clean_Addr.st						:= l.aidwork_acecache.st;
	self.Clean_Addr.zip						:= l.aidwork_acecache.zip5;
	self.Clean_Addr.zip4					:= l.aidwork_acecache.zip4;
	self.Clean_Addr.cart					:= l.aidwork_acecache.cart;
	self.Clean_Addr.cr_sort_sz		:= l.aidwork_acecache.cr_sort_sz;
	self.Clean_Addr.lot						:= l.aidwork_acecache.lot;
	self.Clean_Addr.lot_order			:= l.aidwork_acecache.lot_order;
	self.Clean_Addr.dbpc					:= l.aidwork_acecache.dbpc;
	self.Clean_Addr.chk_digit			:= l.aidwork_acecache.chk_digit;
	self.Clean_Addr.rec_type			:= l.aidwork_acecache.rec_type;	
	self.Clean_Addr.fips_state 		:= l.aidwork_acecache.county[1..2];
	self.Clean_Addr.fips_county		:= l.aidwork_acecache.county[3..];
	self.Clean_Addr.geo_lat				:= l.aidwork_acecache.geo_lat;
	self.Clean_Addr.geo_long			:= l.aidwork_acecache.geo_long;
	self.Clean_Addr.msa						:= l.aidwork_acecache.msa;
	self.Clean_Addr.geo_blk				:= l.aidwork_acecache.geo_blk;
	self.Clean_Addr.geo_match			:= l.aidwork_acecache.geo_match;
	self.Clean_Addr.err_stat			:= l.aidwork_acecache.err_stat;
	self        									:= l;		 
end;

//** Adding back the filtered blank address records to the rest of the file.
dAID_Cleaned_Addr := project(dwithAID, tMapAidAddr(left))
									 + project(dWithout_address,transform(Layouts_Txbus.Layout_AID_Clean_Temp, self := left, self := []));

//*** Denorm AID cleaned address records to get them back to original form
Txbus.Layouts_Txbus.Layout_AID_Temp DenormRecs(Txbus.Layouts_Txbus.Layout_AID_Temp l,  Layouts_Txbus.Layout_AID_Clean_Temp r) := transform	
	self.raw_aid 									:= if(r.addr_type = 'O', r.raw_aid, l.raw_aid)															;
	self.ace_aid 									:= if(r.addr_type = 'O', r.ace_aid, l.ace_aid)															;
	self.mail_raw_aid 						:= if(r.addr_type = 'M', r.raw_aid, l.mail_raw_aid)													;	
	self.mail_ace_aid 						:= if(r.addr_type = 'M', r.ace_aid, l.mail_ace_aid)													;
	self.prep_addr_line1 					:= if(r.addr_type = 'O', r.prep_addr_line1, l.prep_addr_line1)							;	
	self.prep_addr_line_last			:= if(r.addr_type = 'O', r.prep_addr_line_last, l.prep_addr_line_last)			;
	self.prep_mail_addr_line1 		:= if(r.addr_type = 'M', r.prep_addr_line1, l.prep_mail_addr_line1)					;	
	self.prep_mail_addr_line_last	:= if(r.addr_type = 'M', r.prep_addr_line_last, l.prep_mail_addr_line_last)	;
	self.Taxpayer_prim_range			:= if(r.addr_type = 'O', r.Clean_Addr.prim_range, l.Taxpayer_prim_range)		;
	self.Taxpayer_predir					:= if(r.addr_type = 'O', r.Clean_Addr.predir, l.Taxpayer_predir)						;
	self.Taxpayer_prim_name				:= if(r.addr_type = 'O', r.Clean_Addr.prim_name, l.Taxpayer_prim_name)			;
	self.Taxpayer_addr_suffix			:= if(r.addr_type = 'O', r.Clean_Addr.addr_suffix, l.Taxpayer_addr_suffix)	;
	self.Taxpayer_postdir					:= if(r.addr_type = 'O', r.Clean_Addr.postdir, l.Taxpayer_postdir)					;
	self.Taxpayer_unit_desig			:= if(r.addr_type = 'O', r.Clean_Addr.unit_desig, l.Taxpayer_unit_desig)		;
	self.Taxpayer_sec_range				:= if(r.addr_type = 'O', r.Clean_Addr.sec_range, l.Taxpayer_sec_range)			;
	self.Taxpayer_p_city_name			:= if(r.addr_type = 'O', r.Clean_Addr.p_city_name, l.Taxpayer_p_city_name)	;
	self.Taxpayer_v_city_name			:= if(r.addr_type = 'O', r.Clean_Addr.v_city_name, l.Taxpayer_v_city_name)	;
	self.Taxpayer_st							:= if(r.addr_type = 'O', r.Clean_Addr.st, l.Taxpayer_st)										;
	self.Taxpayer_zip5						:= if(r.addr_type = 'O', r.Clean_Addr.zip, l.Taxpayer_zip5)									;
	self.Taxpayer_zip4						:= if(r.addr_type = 'O', r.Clean_Addr.zip4, l.Taxpayer_zip4)								;
	self.Taxpayer_cart						:= if(r.addr_type = 'O', r.Clean_Addr.cart, l.Taxpayer_cart)								;
	self.Taxpayer_cr_sort_sz			:= if(r.addr_type = 'O', r.Clean_Addr.cr_sort_sz, l.Taxpayer_cr_sort_sz)		;
	self.Taxpayer_lot							:= if(r.addr_type = 'O', r.Clean_Addr.lot, l.Taxpayer_lot)									;
	self.Taxpayer_lot_order				:= if(r.addr_type = 'O', r.Clean_Addr.lot_order, l.Taxpayer_lot_order)			;
	self.Taxpayer_dpbc						:= if(r.addr_type = 'O', r.Clean_Addr.dbpc, l.Taxpayer_dpbc)								;
	self.Taxpayer_chk_digit				:= if(r.addr_type = 'O', r.Clean_Addr.chk_digit, l.Taxpayer_chk_digit)			;
	self.Taxpayer_addr_rec_type		:= if(r.addr_type = 'O', r.Clean_Addr.rec_type, l.Taxpayer_addr_rec_type)		;	
	self.Taxpayer_fips_state 			:= if(r.addr_type = 'O', r.Clean_Addr.fips_state, l.Taxpayer_fips_state)		;
	self.Taxpayer_fips_county			:= if(r.addr_type = 'O', r.Clean_Addr.fips_county, l.Taxpayer_fips_county)	;
	self.Taxpayer_geo_lat					:= if(r.addr_type = 'O', r.Clean_Addr.geo_lat, l.Taxpayer_geo_lat)					;
	self.Taxpayer_geo_long				:= if(r.addr_type = 'O', r.Clean_Addr.geo_long, l.Taxpayer_geo_long)				;
	self.Taxpayer_cbsa						:= if(r.addr_type = 'O', r.Clean_Addr.msa, l.Taxpayer_cbsa)									;
	self.Taxpayer_geo_blk					:= if(r.addr_type = 'O', r.Clean_Addr.geo_blk, l.Taxpayer_geo_blk)					;
	self.Taxpayer_geo_match				:= if(r.addr_type = 'O', r.Clean_Addr.geo_match, l.Taxpayer_geo_match)			;
	self.Taxpayer_err_stat				:= if(r.addr_type = 'O', r.Clean_Addr.err_stat, l.Taxpayer_err_stat)				;
	self.outlet_prim_range				:= if(r.addr_type = 'M', r.Clean_Addr.prim_range, l.outlet_prim_range)			;
	self.outlet_predir						:= if(r.addr_type = 'M', r.Clean_Addr.predir, l.outlet_predir)							;
	self.outlet_prim_name					:= if(r.addr_type = 'M', r.Clean_Addr.prim_name, l.outlet_prim_name)				;
	self.outlet_addr_suffix				:= if(r.addr_type = 'M', r.Clean_Addr.addr_suffix, l.outlet_addr_suffix)		;
	self.outlet_postdir						:= if(r.addr_type = 'M', r.Clean_Addr.postdir, l.outlet_postdir)						;
	self.outlet_unit_desig				:= if(r.addr_type = 'M', r.Clean_Addr.unit_desig, l.outlet_unit_desig)			;
	self.outlet_sec_range					:= if(r.addr_type = 'M', r.Clean_Addr.sec_range, l.outlet_sec_range)				;
	self.outlet_p_city_name				:= if(r.addr_type = 'M', r.Clean_Addr.p_city_name, l.outlet_p_city_name)		;
	self.outlet_v_city_name				:= if(r.addr_type = 'M', r.Clean_Addr.v_city_name, l.outlet_v_city_name)		;
	self.outlet_st								:= if(r.addr_type = 'M', r.Clean_Addr.st, l.outlet_st)											;
	self.outlet_zip5							:= if(r.addr_type = 'M', r.Clean_Addr.zip, l.outlet_zip5)										;
	self.outlet_zip4							:= if(r.addr_type = 'M', r.Clean_Addr.zip4, l.outlet_zip4)									;
	self.outlet_cart							:= if(r.addr_type = 'M', r.Clean_Addr.cart, l.outlet_cart)									;
	self.outlet_cr_sort_sz				:= if(r.addr_type = 'M', r.Clean_Addr.cr_sort_sz, l.outlet_cr_sort_sz)			;
	self.outlet_lot								:= if(r.addr_type = 'M', r.Clean_Addr.lot, l.outlet_lot)										;
	self.outlet_lot_order					:= if(r.addr_type = 'M', r.Clean_Addr.lot_order, l.outlet_lot_order)				;
	self.outlet_dpbc							:= if(r.addr_type = 'M', r.Clean_Addr.dbpc, l.outlet_dpbc)									;
	self.outlet_chk_digit					:= if(r.addr_type = 'M', r.Clean_Addr.chk_digit, l.outlet_chk_digit)				;
	self.outlet_addr_rec_type			:= if(r.addr_type = 'M', r.Clean_Addr.rec_type, l.outlet_addr_rec_type)			;	
	self.outlet_fips_state 				:= if(r.addr_type = 'M', r.Clean_Addr.fips_state, l.outlet_fips_state)			;
	self.outlet_fips_county				:= if(r.addr_type = 'M', r.Clean_Addr.fips_county, l.outlet_fips_county)		;
	self.outlet_geo_lat						:= if(r.addr_type = 'M', r.Clean_Addr.geo_lat, l.outlet_geo_lat)						;
	self.outlet_geo_long					:= if(r.addr_type = 'M', r.Clean_Addr.geo_long, l.outlet_geo_long)					;
	self.outlet_cbsa							:= if(r.addr_type = 'M', r.Clean_Addr.msa, l.outlet_cbsa)										;
	self.outlet_geo_blk						:= if(r.addr_type = 'M', r.Clean_Addr.geo_blk, l.outlet_geo_blk)						;
	self.outlet_geo_match					:= if(r.addr_type = 'M', r.Clean_Addr.geo_match, l.outlet_geo_match)				;
	self.outlet_err_stat					:= if(r.addr_type = 'M', r.Clean_Addr.err_stat, l.outlet_err_stat)					;
  self        									:= l																																				;		 
end;

dDenorm_AID := denormalize(dPreAddrForAID,
														dAID_Cleaned_Addr,
														left.unique_id = right.unique_id,
														DenormRecs(left, right)
													 );

dCommon_With_AID 					:= project(dDenorm_AID,transform(layouts_Txbus.Layout_AID_Common, self := left));

export Cleaned_Txbus_Addr := dCommon_with_AID : persist(Txbus.Constants.Cluster + 'persist::txbus::Cleaned_Addr_txbus::Addr_WithAID');
