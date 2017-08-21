export Split_Base_AID(

	dataset(Layouts.Base.AID			)	pBaseFile

) :=
module

	export Companies :=
	function
	
		Layout_BusReg_Company_AID t2CompanyLayout(layouts.base.AID L) :=
		transform
			
			self.dt_first_seen	:= IF(l.dt_first_seen <> 0	,(STRING8)L.dt_first_seen	,'');
			self.dt_last_seen		:= IF(l.dt_last_seen	<> 0	,(STRING8)L.dt_last_seen	,'');
			self.record_date		:= IF(l.record_date		<> 0	,(STRING8)L.record_date		,'');
			self.company_name		:= l.rawfields.company			;
			self.first_name			:= l.rawfields.first				;
			self.last_name			:= l.rawfields.last					;
			self.mail_zip_orig	:= l.rawfields.mail_zip			;
			self.mail_zip4_orig	:= l.rawfields.mail_zip4		;
			self.loc_zip_orig		:= l.rawfields.loc_zip			;
			self.loc_zip4_orig	:= l.rawfields.loc_zip4			;
			self.ofc1_zip_orig	:= l.rawfields.ofc1_zip			;
			self.ra_zip_orig		:= l.rawfields.ra_zip				;
			self.email_addr			:= l.rawfields.email				;
			
			self.mail_prim_range		:= l.Clean_mailing_address.prim_range		;
			self.mail_predir        := l.Clean_mailing_address.predir				;
			self.mail_prim_name     := l.Clean_mailing_address.prim_name		;
			self.mail_addr_suffix   := l.Clean_mailing_address.addr_suffix	;
			self.mail_postdir       := l.Clean_mailing_address.postdir			;
			self.mail_unit_desig    := l.Clean_mailing_address.unit_desig		;
			self.mail_sec_range     := l.Clean_mailing_address.sec_range		;
			self.mail_p_city_name   := l.Clean_mailing_address.p_city_name	;
			self.mail_v_city_name   := l.Clean_mailing_address.v_city_name	;
			self.mail_st            := l.Clean_mailing_address.st						;
			self.mail_zip           := l.Clean_mailing_address.zip					;
			self.mail_zip4          := l.Clean_mailing_address.zip4					;
			self.mail_cart          := l.Clean_mailing_address.cart					;
			self.mail_cr_sort_sz    := l.Clean_mailing_address.cr_sort_sz		;
			self.mail_lot           := l.Clean_mailing_address.lot					;
			self.mail_lot_order     := l.Clean_mailing_address.lot_order		;
			self.mail_dpbc          := l.Clean_mailing_address.dbpc					;
			self.mail_chk_digit     := l.Clean_mailing_address.chk_digit		;
			self.mail_record_type   := l.Clean_mailing_address.rec_type			;
			self.mail_ace_fips_st   := l.Clean_mailing_address.fips_state		;
			self.mail_fipscounty    := l.Clean_mailing_address.fips_county	;
			self.mail_geo_lat       := l.Clean_mailing_address.geo_lat			;
			self.mail_geo_long      := l.Clean_mailing_address.geo_long			;
			self.mail_msa           := l.Clean_mailing_address.msa					;
			self.mail_geo_blk       := l.Clean_mailing_address.geo_blk			;
			self.mail_geo_match     := l.Clean_mailing_address.geo_match		;
			self.mail_err_stat		  := l.Clean_mailing_address.err_stat			;

			self.loc_prim_range		 := l.clean_location_address.prim_range		;
			self.loc_predir        := l.clean_location_address.predir				;
			self.loc_prim_name     := l.clean_location_address.prim_name		;
			self.loc_addr_suffix   := l.clean_location_address.addr_suffix	;
			self.loc_postdir       := l.clean_location_address.postdir			;
			self.loc_unit_desig    := l.clean_location_address.unit_desig		;
			self.loc_sec_range     := l.clean_location_address.sec_range		;
			self.loc_p_city_name   := l.clean_location_address.p_city_name	;
			self.loc_v_city_name   := l.clean_location_address.v_city_name	;
			self.loc_st            := l.clean_location_address.st						;
			self.loc_zip           := l.clean_location_address.zip					;
			self.loc_zip4          := l.clean_location_address.zip4					;
			self.loc_cart          := l.clean_location_address.cart					;
			self.loc_cr_sort_sz    := l.clean_location_address.cr_sort_sz		;
			self.loc_lot           := l.clean_location_address.lot					;
			self.loc_lot_order     := l.clean_location_address.lot_order		;
			self.loc_dpbc          := l.clean_location_address.dbpc					;
			self.loc_chk_digit     := l.clean_location_address.chk_digit		;
			self.loc_record_type   := l.clean_location_address.rec_type			;
			self.loc_ace_fips_st   := l.clean_location_address.fips_state		;
			self.loc_fipscounty    := l.clean_location_address.fips_county	;
			self.loc_geo_lat       := l.clean_location_address.geo_lat			;
			self.loc_geo_long      := l.clean_location_address.geo_long			;
			self.loc_msa           := l.clean_location_address.msa					;
			self.loc_geo_blk       := l.clean_location_address.geo_blk			;
			self.loc_geo_match     := l.clean_location_address.geo_match		;
			self.loc_err_stat		   := l.clean_location_address.err_stat			;

			self.ofc1_prim_range		:= l.clean_officer1_address.prim_range		;
			self.ofc1_predir        := l.clean_officer1_address.predir				;
			self.ofc1_prim_name     := l.clean_officer1_address.prim_name			;
			self.ofc1_addr_suffix   := l.clean_officer1_address.addr_suffix		;
			self.ofc1_postdir       := l.clean_officer1_address.postdir				;
			self.ofc1_unit_desig    := l.clean_officer1_address.unit_desig		;
			self.ofc1_sec_range     := l.clean_officer1_address.sec_range			;
			self.ofc1_p_city_name   := l.clean_officer1_address.p_city_name		;
			self.ofc1_v_city_name   := l.clean_officer1_address.v_city_name		;
			self.ofc1_st            := l.clean_officer1_address.st						;
			self.ofc1_zip           := l.clean_officer1_address.zip						;
			self.ofc1_zip4          := l.clean_officer1_address.zip4					;
			self.ofc1_cart          := l.clean_officer1_address.cart					;
			self.ofc1_cr_sort_sz    := l.clean_officer1_address.cr_sort_sz		;
			self.ofc1_lot           := l.clean_officer1_address.lot						;
			self.ofc1_lot_order     := l.clean_officer1_address.lot_order			;
			self.ofc1_dpbc          := l.clean_officer1_address.dbpc					;
			self.ofc1_chk_digit     := l.clean_officer1_address.chk_digit			;
			self.ofc1_record_type   := l.clean_officer1_address.rec_type			;
			self.ofc1_ace_fips_st   := l.clean_officer1_address.fips_state		;
			self.ofc1_fipscounty    := l.clean_officer1_address.fips_county		;
			self.ofc1_geo_lat       := l.clean_officer1_address.geo_lat				;
			self.ofc1_geo_long      := l.clean_officer1_address.geo_long			;
			self.ofc1_msa           := l.clean_officer1_address.msa						;
			self.ofc1_geo_blk       := l.clean_officer1_address.geo_blk				;
			self.ofc1_geo_match     := l.clean_officer1_address.geo_match			;
			self.ofc1_err_stat		  := l.clean_officer1_address.err_stat			;

			self.ra_prim_range		:= l.clean_ra_address.prim_range		;
			self.ra_predir        := l.clean_ra_address.predir				;
			self.ra_prim_name     := l.clean_ra_address.prim_name			;
			self.ra_addr_suffix   := l.clean_ra_address.addr_suffix		;
			self.ra_postdir       := l.clean_ra_address.postdir				;
			self.ra_unit_desig    := l.clean_ra_address.unit_desig		;
			self.ra_sec_range     := l.clean_ra_address.sec_range			;
			self.ra_p_city_name   := l.clean_ra_address.p_city_name		;
			self.ra_v_city_name   := l.clean_ra_address.v_city_name		;
			self.ra_st            := l.clean_ra_address.st						;
			self.ra_zip           := l.clean_ra_address.zip						;
			self.ra_zip4          := l.clean_ra_address.zip4					;
			self.ra_cart          := l.clean_ra_address.cart					;
			self.ra_cr_sort_sz    := l.clean_ra_address.cr_sort_sz		;
			self.ra_lot           := l.clean_ra_address.lot						;
			self.ra_lot_order     := l.clean_ra_address.lot_order			;
			self.ra_dpbc          := l.clean_ra_address.dbpc					;
			self.ra_chk_digit     := l.clean_ra_address.chk_digit			;
			self.ra_record_type   := l.clean_ra_address.rec_type			;
			self.ra_ace_fips_st   := l.clean_ra_address.fips_state		;
			self.ra_fipscounty    := l.clean_ra_address.fips_county		;
			self.ra_geo_lat       := l.clean_ra_address.geo_lat				;
			self.ra_geo_long      := l.clean_ra_address.geo_long			;
			self.ra_msa           := l.clean_ra_address.msa						;
			self.ra_geo_blk       := l.clean_ra_address.geo_blk				;
			self.ra_geo_match     := l.clean_ra_address.geo_match			;
			self.ra_err_stat		  := l.clean_ra_address.err_stat			;
                                                      
			self.ofc1_name_prefix		:= l.clean_officer1_name.title			;
			self.ofc1_name_first		:= l.clean_officer1_name.fname			;
			self.ofc1_name_middle		:= l.clean_officer1_name.mname			;
			self.ofc1_name_last			:= l.clean_officer1_name.lname			;
			self.ofc1_name_suffix		:= l.clean_officer1_name.name_suffix;
			self.ofc1_name_score		:= l.clean_officer1_name.name_score	;
			
			self.company_phone10	:= l.clean_phones.biz_phone		;
			self.ofc1_phone10 		:= l.clean_phones.ofc1_phone	;
			self.ra_phone10				:= l.clean_phones.ra_phone		;
                                                  
			self := l.rawfields;
			self := l;

		end;

		new_company := project(pBaseFile,t2CompanyLayout(left))(company_name != '');

		return new_company;
	
	end;
	
	export Contacts :=
	function
	
		Layout_BusReg_Contact_AID tNorm2ContactLayout(layouts.base.AID L, unsigned4 cnt) :=
		transform
			
			self.dt_first_seen	:= IF(l.dt_first_seen <> 0	,(STRING8)L.dt_first_seen	,'');
			self.dt_last_seen		:= IF(l.dt_last_seen	<> 0	,(STRING8)L.dt_last_seen	,'');
			self.did 						:= 0;
			self.name						:= choose(cnt,l.rawfields.OFC1_NAME	,l.rawfields.OFC2_NAME	,l.rawfields.OFC3_NAME	,l.rawfields.OFC4_NAME	,l.rawfields.OFC5_NAME	,l.rawfields.OFC6_NAME	,l.rawfields.RA_NAME);
			self.title 					:= choose(cnt,l.rawfields.OFC1_TITLE,l.rawfields.OFC2_TITLE	,l.rawfields.OFC3_TITLE	,l.rawfields.OFC4_TITLE	,l.rawfields.OFC5_TITLE	,l.rawfields.OFC6_TITLE	,'RA'								);
			self.add 						:= choose(cnt,l.rawfields.OFC1_ADD	,l.rawfields.OFC2_ADD		,l.rawfields.OFC3_ADD		,l.rawfields.OFC4_ADD		,l.rawfields.OFC5_ADD		,l.rawfields.OFC6_ADD		,l.rawfields.RA_ADD	);
			self.FEIN 					:= choose(cnt,l.rawfields.OFC1_FEIN	,l.rawfields.OFC2_FEIN	,l.rawfields.OFC3_FEIN	,l.rawfields.OFC4_FEIN	,l.rawfields.OFC5_FEIN	,l.rawfields.OFC6_FEIN	,''									);
			self.ssn 						:= choose(cnt,l.rawfields.OFC1_SSN	,l.rawfields.OFC2_SSN		,l.rawfields.OFC3_SSN		,l.rawfields.OFC4_SSN		,l.rawfields.OFC5_SSN		,l.rawfields.OFC6_SSN		,''									);
			self.csz 						:= choose(cnt
																,trim(l.rawfields.OFC1_CITY	)+' '+trim(l.rawfields.OFC1_STATE	)+' '+trim(l.rawfields.OFC1_ZIP	)
																,l.rawfields.OFC2_CSZ
																,l.rawfields.OFC3_CSZ
																,l.rawfields.OFC4_CSZ
																,l.rawfields.OFC5_CSZ
																,l.rawfields.OFC6_CSZ
																,trim(l.rawfields.RA_CITY		)+' '+trim(l.rawfields.RA_STATE		)+' '+trim(l.rawfields.RA_ZIP		)
														);
			self.phone 					:= choose(cnt,l.clean_phones.ofc1_phone,'','','','','',l.clean_phones.ra_phone);

			self.name_prefix 		:= choose(cnt,l.clean_officer1_name.title				,l.clean_officer2_name.title				,l.clean_officer3_name.title				,l.clean_officer4_name.title				,l.clean_officer5_name.title				,l.clean_officer6_name.title				,'');
			self.name_first 		:= choose(cnt,l.clean_officer1_name.fname				,l.clean_officer2_name.fname				,l.clean_officer3_name.fname				,l.clean_officer4_name.fname				,l.clean_officer5_name.fname				,l.clean_officer6_name.fname				,'');
			self.name_middle 		:= choose(cnt,l.clean_officer1_name.mname				,l.clean_officer2_name.mname				,l.clean_officer3_name.mname				,l.clean_officer4_name.mname				,l.clean_officer5_name.mname				,l.clean_officer6_name.mname				,'');
			self.name_last 			:= choose(cnt,l.clean_officer1_name.lname				,l.clean_officer2_name.lname				,l.clean_officer3_name.lname				,l.clean_officer4_name.lname				,l.clean_officer5_name.lname				,l.clean_officer6_name.lname				,'');
			self.name_suffix 		:= choose(cnt,l.clean_officer1_name.name_suffix	,l.clean_officer2_name.name_suffix	,l.clean_officer3_name.name_suffix	,l.clean_officer4_name.name_suffix	,l.clean_officer5_name.name_suffix	,l.clean_officer6_name.name_suffix	,'');
			self.name_score 		:= choose(cnt,l.clean_officer1_name.name_score	,l.clean_officer2_name.name_score		,l.clean_officer3_name.name_score		,l.clean_officer4_name.name_score		,l.clean_officer5_name.name_score		,l.clean_officer6_name.name_score		,'');
																																																																			 
			self.prim_range 		:= choose(cnt,l.Clean_officer1_address.prim_range		,l.Clean_officer2_address.prim_range	,l.Clean_officer3_address.prim_range	,l.Clean_officer4_address.prim_range	,l.Clean_officer5_address.prim_range	,l.Clean_officer6_address.prim_range	,l.Clean_ra_address.prim_range	);
			self.predir 				:= choose(cnt,l.Clean_officer1_address.predir				,l.Clean_officer2_address.predir			,l.Clean_officer3_address.predir			,l.Clean_officer4_address.predir			,l.Clean_officer5_address.predir			,l.Clean_officer6_address.predir			,l.Clean_ra_address.predir			);
			self.prim_name 			:= choose(cnt,l.Clean_officer1_address.prim_name		,l.Clean_officer2_address.prim_name		,l.Clean_officer3_address.prim_name		,l.Clean_officer4_address.prim_name		,l.Clean_officer5_address.prim_name		,l.Clean_officer6_address.prim_name		,l.Clean_ra_address.prim_name		);
			self.addr_suffix 		:= choose(cnt,l.Clean_officer1_address.addr_suffix	,l.Clean_officer2_address.addr_suffix	,l.Clean_officer3_address.addr_suffix	,l.Clean_officer4_address.addr_suffix	,l.Clean_officer5_address.addr_suffix	,l.Clean_officer6_address.addr_suffix	,l.Clean_ra_address.addr_suffix	);
			self.postdir 				:= choose(cnt,l.Clean_officer1_address.postdir			,l.Clean_officer2_address.postdir			,l.Clean_officer3_address.postdir			,l.Clean_officer4_address.postdir			,l.Clean_officer5_address.postdir			,l.Clean_officer6_address.postdir			,l.Clean_ra_address.postdir			);
			self.unit_desig 		:= choose(cnt,l.Clean_officer1_address.unit_desig		,l.Clean_officer2_address.unit_desig	,l.Clean_officer3_address.unit_desig	,l.Clean_officer4_address.unit_desig	,l.Clean_officer5_address.unit_desig	,l.Clean_officer6_address.unit_desig	,l.Clean_ra_address.unit_desig	);
			self.sec_range 			:= choose(cnt,l.Clean_officer1_address.sec_range		,l.Clean_officer2_address.sec_range		,l.Clean_officer3_address.sec_range		,l.Clean_officer4_address.sec_range		,l.Clean_officer5_address.sec_range		,l.Clean_officer6_address.sec_range		,l.Clean_ra_address.sec_range		);
			self.p_city_name 		:= choose(cnt,l.Clean_officer1_address.p_city_name	,l.Clean_officer2_address.p_city_name	,l.Clean_officer3_address.p_city_name	,l.Clean_officer4_address.p_city_name	,l.Clean_officer5_address.p_city_name	,l.Clean_officer6_address.p_city_name	,l.Clean_ra_address.p_city_name	);
			self.v_city_name 		:= choose(cnt,l.Clean_officer1_address.v_city_name	,l.Clean_officer2_address.v_city_name	,l.Clean_officer3_address.v_city_name	,l.Clean_officer4_address.v_city_name	,l.Clean_officer5_address.v_city_name	,l.Clean_officer6_address.v_city_name	,l.Clean_ra_address.v_city_name	);
			self.st							:= choose(cnt,l.Clean_officer1_address.st						,l.Clean_officer2_address.st					,l.Clean_officer3_address.st					,l.Clean_officer4_address.st					,l.Clean_officer5_address.st					,l.Clean_officer6_address.st					,l.Clean_ra_address.st					);
			self.zip 						:= choose(cnt,l.Clean_officer1_address.zip					,l.Clean_officer2_address.zip					,l.Clean_officer3_address.zip					,l.Clean_officer4_address.zip					,l.Clean_officer5_address.zip					,l.Clean_officer6_address.zip					,l.Clean_ra_address.zip					);
			self.zip4 					:= choose(cnt,l.Clean_officer1_address.zip4					,l.Clean_officer2_address.zip4				,l.Clean_officer3_address.zip4				,l.Clean_officer4_address.zip4				,l.Clean_officer5_address.zip4				,l.Clean_officer6_address.zip4				,l.Clean_ra_address.zip4				);
			self.cart 					:= choose(cnt,l.Clean_officer1_address.cart					,l.Clean_officer2_address.cart				,l.Clean_officer3_address.cart				,l.Clean_officer4_address.cart				,l.Clean_officer5_address.cart				,l.Clean_officer6_address.cart				,l.Clean_ra_address.cart				);
			self.cr_sort_sz 		:= choose(cnt,l.Clean_officer1_address.cr_sort_sz		,l.Clean_officer2_address.cr_sort_sz	,l.Clean_officer3_address.cr_sort_sz	,l.Clean_officer4_address.cr_sort_sz	,l.Clean_officer5_address.cr_sort_sz	,l.Clean_officer6_address.cr_sort_sz	,l.Clean_ra_address.cr_sort_sz	);
			self.lot 						:= choose(cnt,l.Clean_officer1_address.lot					,l.Clean_officer2_address.lot					,l.Clean_officer3_address.lot					,l.Clean_officer4_address.lot					,l.Clean_officer5_address.lot					,l.Clean_officer6_address.lot					,l.Clean_ra_address.lot					);
			self.lot_order 			:= choose(cnt,l.Clean_officer1_address.lot_order		,l.Clean_officer2_address.lot_order		,l.Clean_officer3_address.lot_order		,l.Clean_officer4_address.lot_order		,l.Clean_officer5_address.lot_order		,l.Clean_officer6_address.lot_order		,l.Clean_ra_address.lot_order		);
			self.dpbc 					:= choose(cnt,l.Clean_officer1_address.dbpc					,l.Clean_officer2_address.dbpc				,l.Clean_officer3_address.dbpc				,l.Clean_officer4_address.dbpc				,l.Clean_officer5_address.dbpc				,l.Clean_officer6_address.dbpc				,l.Clean_ra_address.dbpc				);
			self.chk_digit 			:= choose(cnt,l.Clean_officer1_address.chk_digit		,l.Clean_officer2_address.chk_digit		,l.Clean_officer3_address.chk_digit		,l.Clean_officer4_address.chk_digit		,l.Clean_officer5_address.chk_digit		,l.Clean_officer6_address.chk_digit		,l.Clean_ra_address.chk_digit		);
			self.rec_type 			:= choose(cnt,l.Clean_officer1_address.rec_type			,l.Clean_officer2_address.rec_type		,l.Clean_officer3_address.rec_type		,l.Clean_officer4_address.rec_type		,l.Clean_officer5_address.rec_type		,l.Clean_officer6_address.rec_type		,l.Clean_ra_address.rec_type		);
			self.ace_fips_st 		:= choose(cnt,l.Clean_officer1_address.fips_state		,l.Clean_officer2_address.fips_state	,l.Clean_officer3_address.fips_state	,l.Clean_officer4_address.fips_state	,l.Clean_officer5_address.fips_state	,l.Clean_officer6_address.fips_state	,l.Clean_ra_address.fips_state	);
			self.fipscounty 		:= choose(cnt,l.Clean_officer1_address.fips_county	,l.Clean_officer2_address.fips_county	,l.Clean_officer3_address.fips_county	,l.Clean_officer4_address.fips_county	,l.Clean_officer5_address.fips_county	,l.Clean_officer6_address.fips_county	,l.Clean_ra_address.fips_county	);
			self.geo_lat 				:= choose(cnt,l.Clean_officer1_address.geo_lat			,l.Clean_officer2_address.geo_lat			,l.Clean_officer3_address.geo_lat			,l.Clean_officer4_address.geo_lat			,l.Clean_officer5_address.geo_lat			,l.Clean_officer6_address.geo_lat			,l.Clean_ra_address.geo_lat			);
			self.geo_long 			:= choose(cnt,l.Clean_officer1_address.geo_long			,l.Clean_officer2_address.geo_long		,l.Clean_officer3_address.geo_long		,l.Clean_officer4_address.geo_long		,l.Clean_officer5_address.geo_long		,l.Clean_officer6_address.geo_long		,l.Clean_ra_address.geo_long		);
			self.msa 						:= choose(cnt,l.Clean_officer1_address.msa					,l.Clean_officer2_address.msa					,l.Clean_officer3_address.msa					,l.Clean_officer4_address.msa					,l.Clean_officer5_address.msa					,l.Clean_officer6_address.msa					,l.Clean_ra_address.msa					);
			self.geo_blk 				:= choose(cnt,l.Clean_officer1_address.geo_blk			,l.Clean_officer2_address.geo_blk			,l.Clean_officer3_address.geo_blk			,l.Clean_officer4_address.geo_blk			,l.Clean_officer5_address.geo_blk			,l.Clean_officer6_address.geo_blk			,l.Clean_ra_address.geo_blk			);
			self.geo_match 			:= choose(cnt,l.Clean_officer1_address.geo_match		,l.Clean_officer2_address.geo_match		,l.Clean_officer3_address.geo_match		,l.Clean_officer4_address.geo_match		,l.Clean_officer5_address.geo_match		,l.Clean_officer6_address.geo_match		,l.Clean_ra_address.geo_match		);
			self.err_stat 			:= choose(cnt,l.Clean_officer1_address.err_stat			,l.Clean_officer2_address.err_stat		,l.Clean_officer3_address.err_stat		,l.Clean_officer4_address.err_stat		,l.Clean_officer5_address.err_stat		,l.Clean_officer6_address.err_stat		,l.Clean_ra_address.err_stat		);
			self.Prep_addr_line1:= choose(cnt,l.Clean_officer1_address1			,l.Clean_officer2_address1		,l.Clean_officer3_address1		,l.Clean_officer4_address1		,l.Clean_officer5_address1		,l.Clean_officer6_address1		,l.Clean_ra_address1		);
			self.Prep_addr_line_last:= choose(cnt,l.Clean_officer1_address2			,l.Clean_officer2_address2		,l.Clean_officer3_address2		,l.Clean_officer4_address2		,l.Clean_officer5_address2		,l.Clean_officer6_address2		,l.Clean_ra_address2		);
			self.Append_RawAID	:= choose(cnt,l.Append_Off1RawAID			,l.Append_Off2RawAID		,l.Append_Off3RawAID		,l.Append_Off4RawAID		,l.Append_Off5RawAID		,l.Append_Off6RawAID		,l.Append_RARawAID		);
			self.Append_ACEAID	:= choose(cnt,l.Append_Off1ACEAID			,l.Append_Off2ACEAID		,l.Append_Off3ACEAID		,l.Append_Off4ACEAID		,l.Append_Off5ACEAID		,l.Append_Off6ACEAID		,l.Append_RAACEAID		);
			self 								:= l;                                                                                                                                                 
			end;

			all_contacts := normalize(pBaseFile,7,tNorm2ContactLayout(left,counter));

			busreg.Layout_BusReg_Contact_AID propagate(busreg.Layout_BusReg_Contact_AID L, layouts.base.AID R) := 
			transform
			self.prim_range 	:= If(l.add='',r.Clean_mailing_address.prim_range	,l.prim_range	);
			self.predir 			:= If(l.add='',r.Clean_mailing_address.predir			,l.predir			);
			self.prim_name 		:= If(l.add='',r.Clean_mailing_address.prim_name	,l.prim_name	);
			self.addr_suffix 	:= If(l.add='',r.Clean_mailing_address.addr_suffix,l.addr_suffix);
			self.postdir 			:= If(l.add='',r.Clean_mailing_address.postdir		,l.postdir		);
			self.unit_desig 	:= If(l.add='',r.Clean_mailing_address.unit_desig	,l.unit_desig	);
			self.sec_range		:= If(l.add='',r.Clean_mailing_address.sec_range	,l.sec_range	);
			self.p_city_name 	:= If(l.add='',r.Clean_mailing_address.p_city_name,l.p_city_name);
			self.v_city_name 	:= If(l.add='',r.Clean_mailing_address.v_city_name,l.v_city_name);
			self.st 					:= If(l.add='',r.Clean_mailing_address.st					,l.st					);
			self.zip 					:= If(l.add='',r.Clean_mailing_address.zip				,l.zip				);
			self.zip4 				:= If(l.add='',r.Clean_mailing_address.zip4				,l.zip4				);
			self.cart 				:= If(l.add='',r.Clean_mailing_address.cart				,l.cart				);
			self.cr_sort_sz 	:= If(l.add='',r.Clean_mailing_address.cr_sort_sz	,l.cr_sort_sz	);
			self.lot 					:= If(l.add='',r.Clean_mailing_address.lot				,l.lot				);
			self.lot_order 		:= If(l.add='',r.Clean_mailing_address.lot_order	,l.lot_order	);
			self.dpbc 				:= If(l.add='',r.Clean_mailing_address.dbpc				,l.dpbc				);
			self.chk_digit 		:= If(l.add='',r.Clean_mailing_address.chk_digit	,l.chk_digit	);
			self.rec_type 		:= If(l.add='',r.Clean_mailing_address.rec_type		,l.rec_type		);
			self.ace_fips_st 	:= If(l.add='',r.Clean_mailing_address.fips_state	,l.ace_fips_st);
			self.fipscounty 	:= If(l.add='',r.Clean_mailing_address.fips_county,l.fipscounty	);
			self.geo_lat 			:= If(l.add='',r.Clean_mailing_address.geo_lat		,l.geo_lat		);
			self.geo_long 		:= If(l.add='',r.Clean_mailing_address.geo_long		,l.geo_long		);
			self.msa 					:= If(l.add='',r.Clean_mailing_address.msa				,l.msa				);
			self.geo_blk 			:= If(l.add='',r.Clean_mailing_address.geo_blk		,l.geo_blk		);
			self.geo_match 		:= If(l.add='',r.Clean_mailing_address.geo_match	,l.geo_match	);
			self.err_stat 		:= If(l.add='',r.Clean_mailing_address.err_stat		,l.err_stat		);
			self.Prep_addr_line1 		:= If(l.add='',r.Clean_mailing_address1		,l.Prep_addr_line1		);
			self.Prep_addr_line_last 		:= If(l.add='',r.Clean_mailing_address2		,l.Prep_addr_line_last		);
			self.Append_RawAID	:= If(l.add='',r.Append_MailRawAID		,l.Append_RawAID		);
			self.Append_ACEAID	:= If(l.add='',r.Append_MailACEAID		,l.Append_ACEAID		);
			self := l;                      
			end;

			d_base			:= distribute(pBaseFile		,hash(br_id));
			d_contacts	:= distribute(all_contacts,hash(br_id));

			//******** Create Contacts File *****************//
			cnts := join(d_contacts(name_last!='')
									,d_base
									,left.br_id=right.br_id
									,propagate(left,right)
									,left outer
									,local
							);

			return cnts;
	
	end;

end;