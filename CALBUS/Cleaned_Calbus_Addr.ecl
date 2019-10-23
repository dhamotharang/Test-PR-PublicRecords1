import ut, address, idl_header, aid;

Cleaned_Update := Calbus.File_Calbus_In.File_Cleaned_Super;
Previous_base  := project(CALBUS.File_Calbus_Base,transform(Calbus.Layouts_Calbus.Layout_Common,self:=left;));
in_file        := Cleaned_Update + Previous_base;

Address.Mac_Is_Business(in_file(trim(Ownership_code) in Calbus.Constants.OwnerShip_Code_Check), Owner_Name, Clean_Owner_Name,name_flag,false,true );

cln_layout := RECORD
		recordof(in_file);
		string1         name_flag;
		string5         cln_title;
		string20        cln_fname;
		string20        cln_mname;
		string20        cln_lname;
		string5         cln_suffix;
		string5         cln_title2;
		string20        cln_fname2;
		string20        cln_mname2;
		string20        cln_lname2;
		string5         cln_suffix2;
END;

dOwnerNameBlank		:=      project(in_file(trim(Ownership_code) not in Calbus.Constants.OwnerShip_Code_Check),transform(cln_layout,self	:=	left; self	:=	[]));
dOwnerCleanName		:=      Clean_Owner_Name   +  dOwnerNameBlank;

Calbus.Layouts_Calbus.Layout_Common  CleanOwnerNameAddr( dOwnerCleanName  l) := transform
		self.Owner_title				:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_title,
															l.name_flag = 'U' => l.Owner_title,
															''
														 );
		self.Owner_fname				:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_fname,
															l.name_flag = 'U' => l.Owner_fname, 
															''
														);
		self.Owner_mname				:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_mname,
															l.name_flag = 'U' => l.Owner_mname, 
															''
														 );
		self.Owner_lname				:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_lname,
															l.name_flag = 'U' => l.Owner_lname, 
															''
														 );
		self.Owner_name_suffix	:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_suffix,
															l.name_flag = 'U' => l.Owner_name_suffix, '');
				
		self										:=	l;
end;		
			
cleanName_Calbus			:=	project( dOwnerCleanName ,CleanOwnerNameAddr(left));
				
//** Flipping the first & last names that are wrongly cleaned by name cleaner.
ut.mac_flipnames(cleanName_Calbus, Owner_fname, Owner_mname, Owner_lname, in_file_flipnames)

//////////////////////////////////////////////////////////////////////////////////////
// -- Prepare Addresses for Cleaning using macro
//////////////////////////////////////////////////////////////////////////////////////
CALBUS.Layouts_Calbus.Layout_AID_Temp tPreAddrCleaning(Calbus.Layouts_Calbus.Layout_Common l, unsigned8 cnt) := transform
		//////////////////////////////////////////////////////////////////////////////////////
		// -- Prepare Addresses for Cleaning using macro
		//////////////////////////////////////////////////////////////////////////////////////
		address1 								:=	Address.Addr1FromComponents(
																					 stringlib.stringtouppercase(l.BUSINESS_STREET		)
																					,''
																					,''
																					,''
																					,''
																					,''
																					,''
																				); 
		address2 								:=	Address.Addr2FromComponents(
																					 stringlib.stringtouppercase(l.BUSINESS_CITY 	)	
																					,stringlib.stringtouppercase(l.BUSINESS_STATE	)	
																					,trim(l.BUSINESS_ZIP_5,left,right)
																				);
																				
		mail_address1 					:=	Address.Addr1FromComponents(
																					 stringlib.stringtouppercase(l.MAILING_STREET		)
																					,''
																					,''
																					,''
																					,''
																					,''
																					,''
																				); 
		mail_address2 					:=	Address.Addr2FromComponents(
																					 stringlib.stringtouppercase(l.MAILING_CITY 	)	
																					,stringlib.stringtouppercase(l.MAILING_STATE	)	
																					,trim(l.MAILING_ZIP_5,left,right)
																				);		
		
		self.unique_id		 						:= cnt;
		self.prep_addr_line1 					:= address1;
		self.prep_addr_line_last 			:= address2;
		self.prep_mail_addr_line1 		:= mail_address1;
		self.prep_mail_addr_line_last := mail_address2;
		self                    			:= l;
end;

dPreAddrForAID := project(in_file_flipnames, tPreAddrCleaning(left,counter)) : persist('~thor_data400::persist::calbus::cleaned_addr_calbus::addr_for_AID');

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
dPreAddrNormForAID  := NORMALIZE(dPreAddrForAID
													,if(trim(left.prep_mail_addr_line1,left,right) <> '' or
															trim(left.prep_mail_addr_line_last,left,right) <> '',2,1)
													,trfNormAddrs(left,counter));

HasAddress	:=	trim(dPreAddrNormForAID.prep_addr_line1, left,right) != ''
						and trim(dPreAddrNormForAID.prep_addr_line_last, left,right) != '';
								
dWith_address			:= dPreAddrNormForAID(HasAddress);
dWithout_address	:= dPreAddrNormForAID(not(HasAddress));

unsigned4	lFlags 	:= AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	

AID.MacAppendFromRaw_2Line(dWith_address, prep_addr_line1, prep_addr_line_last, Raw_AID, dwithAID, lFlags);


//*** Transform the AID cleaned address records to get the clean address fields.
CALBUS.Layouts_Calbus.Layout_AID_Clean_Temp tMapAidAddr(dwithAID l) := transform	
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
									 + project(dWithout_address,transform(Layouts_Calbus.Layout_AID_Clean_Temp, self := left, self := []));

//*** Denorm AID cleaned address records to get them back to original form
CALBUS.Layouts_Calbus.Layout_AID_Temp DenormRecs(CALBUS.Layouts_Calbus.Layout_AID_Temp l,  Layouts_Calbus.Layout_AID_Clean_Temp r) := transform	
	self.raw_aid 									:= if(r.addr_type = 'O', r.raw_aid, l.raw_aid)															;
	self.ace_aid 									:= if(r.addr_type = 'O', r.ace_aid, l.ace_aid)															;
	
	self.mail_raw_aid 						:= if(r.addr_type = 'M', r.raw_aid, l.mail_raw_aid)													;	
	self.mail_ace_aid 						:= if(r.addr_type = 'M', r.ace_aid, l.mail_ace_aid)													;
	
	self.prep_addr_line1 					:= if(r.addr_type = 'O', r.prep_addr_line1, l.prep_addr_line1)							;	
	self.prep_addr_line_last			:= if(r.addr_type = 'O', r.prep_addr_line_last, l.prep_addr_line_last)			;
	
	self.prep_mail_addr_line1 		:= if(r.addr_type = 'M', r.prep_addr_line1, l.prep_mail_addr_line1)					;	
	self.prep_mail_addr_line_last	:= if(r.addr_type = 'M', r.prep_addr_line_last, l.prep_mail_addr_line_last)	;
	
	self.Business_prim_range			:= if(r.addr_type = 'O', r.Clean_Addr.prim_range, l.Business_prim_range)		;
	self.Business_predir					:= if(r.addr_type = 'O', r.Clean_Addr.predir, l.Business_predir)						;
	self.Business_prim_name				:= if(r.addr_type = 'O', r.Clean_Addr.prim_name, l.Business_prim_name)			;
	self.Business_addr_suffix			:= if(r.addr_type = 'O', r.Clean_Addr.addr_suffix, l.Business_addr_suffix)	;
	self.Business_postdir					:= if(r.addr_type = 'O', r.Clean_Addr.postdir, l.Business_postdir)					;
	self.Business_unit_desig			:= if(r.addr_type = 'O', r.Clean_Addr.unit_desig, l.Business_unit_desig)		;
	self.Business_sec_range				:= if(r.addr_type = 'O', r.Clean_Addr.sec_range, l.Business_sec_range)			;
	self.Business_p_city_name			:= if(r.addr_type = 'O', r.Clean_Addr.p_city_name, l.Business_p_city_name)	;
	self.Business_v_city_name			:= if(r.addr_type = 'O', r.Clean_Addr.v_city_name, l.Business_v_city_name)	;
	self.Business_st							:= if(r.addr_type = 'O', r.Clean_Addr.st, l.Business_st)										;
	self.Business_zip5						:= if(r.addr_type = 'O', r.Clean_Addr.zip, l.Business_zip5)									;
	self.Business_zip4						:= if(r.addr_type = 'O', r.Clean_Addr.zip4, l.Business_zip4)								;
	self.Business_cart						:= if(r.addr_type = 'O', r.Clean_Addr.cart, l.Business_cart)								;
	self.Business_cr_sort_sz			:= if(r.addr_type = 'O', r.Clean_Addr.cr_sort_sz, l.Business_cr_sort_sz)		;
	self.Business_lot							:= if(r.addr_type = 'O', r.Clean_Addr.lot, l.Business_lot)									;
	self.Business_lot_order				:= if(r.addr_type = 'O', r.Clean_Addr.lot_order, l.Business_lot_order)			;
	self.Business_dpbc						:= if(r.addr_type = 'O', r.Clean_Addr.dbpc, l.Business_dpbc)								;
	self.Business_chk_digit				:= if(r.addr_type = 'O', r.Clean_Addr.chk_digit, l.Business_chk_digit)			;
	self.Business_addr_rec_type		:= if(r.addr_type = 'O', r.Clean_Addr.rec_type, l.Business_addr_rec_type)		;	
	self.Business_fips_state 			:= if(r.addr_type = 'O', r.Clean_Addr.fips_state, l.Business_fips_state)		;
	self.Business_fips_county			:= if(r.addr_type = 'O', r.Clean_Addr.fips_county, l.Business_fips_county)	;
	self.Business_geo_lat					:= if(r.addr_type = 'O', r.Clean_Addr.geo_lat, l.Business_geo_lat)					;
	self.Business_geo_long				:= if(r.addr_type = 'O', r.Clean_Addr.geo_long, l.Business_geo_long)				;
	self.Business_cbsa						:= if(r.addr_type = 'O', r.Clean_Addr.msa, l.Business_cbsa)									;
	self.Business_geo_blk					:= if(r.addr_type = 'O', r.Clean_Addr.geo_blk, l.Business_geo_blk)					;
	self.Business_geo_match				:= if(r.addr_type = 'O', r.Clean_Addr.geo_match, l.Business_geo_match)			;
	self.Business_err_stat				:= if(r.addr_type = 'O', r.Clean_Addr.err_stat, l.Business_err_stat)				;

	self.Mailing_prim_range				:= if(r.addr_type = 'M', r.Clean_Addr.prim_range, l.Mailing_prim_range)			;
	self.Mailing_predir						:= if(r.addr_type = 'M', r.Clean_Addr.predir, l.Mailing_predir)							;
	self.Mailing_prim_name				:= if(r.addr_type = 'M', r.Clean_Addr.prim_name, l.Mailing_prim_name)				;
	self.Mailing_addr_suffix			:= if(r.addr_type = 'M', r.Clean_Addr.addr_suffix, l.Mailing_addr_suffix)		;
	self.Mailing_postdir					:= if(r.addr_type = 'M', r.Clean_Addr.postdir, l.Mailing_postdir)						;
	self.Mailing_unit_desig				:= if(r.addr_type = 'M', r.Clean_Addr.unit_desig, l.Mailing_unit_desig)			;
	self.Mailing_sec_range				:= if(r.addr_type = 'M', r.Clean_Addr.sec_range, l.Mailing_sec_range)				;
	self.Mailing_p_city_name			:= if(r.addr_type = 'M', r.Clean_Addr.p_city_name, l.Mailing_p_city_name)		;
	self.Mailing_v_city_name			:= if(r.addr_type = 'M', r.Clean_Addr.v_city_name, l.Mailing_v_city_name)		;
	self.Mailing_st								:= if(r.addr_type = 'M', r.Clean_Addr.st, l.Mailing_st)											;
	self.Mailing_zip5							:= if(r.addr_type = 'M', r.Clean_Addr.zip, l.Mailing_zip5)									;
	self.Mailing_zip4							:= if(r.addr_type = 'M', r.Clean_Addr.zip4, l.Mailing_zip4)									;
	self.Mailing_cart							:= if(r.addr_type = 'M', r.Clean_Addr.cart, l.Mailing_cart)									;
	self.Mailing_cr_sort_sz				:= if(r.addr_type = 'M', r.Clean_Addr.cr_sort_sz, l.Mailing_cr_sort_sz)			;
	self.Mailing_lot							:= if(r.addr_type = 'M', r.Clean_Addr.lot, l.Mailing_lot)										;
	self.Mailing_lot_order				:= if(r.addr_type = 'M', r.Clean_Addr.lot_order, l.Mailing_lot_order)				;
	self.Mailing_dpbc							:= if(r.addr_type = 'M', r.Clean_Addr.dbpc, l.Mailing_dpbc)									;
	self.Mailing_chk_digit				:= if(r.addr_type = 'M', r.Clean_Addr.chk_digit, l.Mailing_chk_digit)				;
	self.Mailing_addr_rec_type		:= if(r.addr_type = 'M', r.Clean_Addr.rec_type, l.Mailing_addr_rec_type)		;	
	self.Mailing_fips_state 			:= if(r.addr_type = 'M', r.Clean_Addr.fips_state, l.Mailing_fips_state)			;
	self.Mailing_fips_county			:= if(r.addr_type = 'M', r.Clean_Addr.fips_county, l.Mailing_fips_county)		;
	self.Mailing_geo_lat					:= if(r.addr_type = 'M', r.Clean_Addr.geo_lat, l.Mailing_geo_lat)						;
	self.Mailing_geo_long					:= if(r.addr_type = 'M', r.Clean_Addr.geo_long, l.Mailing_geo_long)					;
	self.Mailing_cbsa							:= if(r.addr_type = 'M', r.Clean_Addr.msa, l.Mailing_cbsa)									;
	self.Mailing_geo_blk					:= if(r.addr_type = 'M', r.Clean_Addr.geo_blk, l.Mailing_geo_blk)						;
	self.Mailing_geo_match				:= if(r.addr_type = 'M', r.Clean_Addr.geo_match, l.Mailing_geo_match)				;
	self.Mailing_err_stat					:= if(r.addr_type = 'M', r.Clean_Addr.err_stat, l.Mailing_err_stat)					;

	self        									:= l																																				;		 
end;

dDenorm_AID := denormalize(dPreAddrForAID,
														dAID_Cleaned_Addr,
														left.unique_id = right.unique_id,
														DenormRecs(left, right)
													 );

dCommon_With_AID := project(dDenorm_AID,transform(layouts_calbus.Layout_AID_Common, self := left));

export Cleaned_Calbus_Addr := dCommon_with_AID : persist(Calbus.Constants.Cluster + 'persist::calbus::Cleaned_Addr_Calbus::Addr_WithAID');