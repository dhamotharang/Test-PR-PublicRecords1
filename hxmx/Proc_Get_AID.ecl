IMPORT ut, lib_fileservices, _control, lib_stringlib, _Validate, AID, did_add, hxmx;

trimUpper(STRING s) := FUNCTION
			RETURN TRIM(stringlib.StringToUppercase(s),LEFT,RIGHT);
			END;  

EXPORT Proc_Get_AID	:= MODULE

	EXPORT hx_records(DATASET(hxmx.Layouts.Base.hx_record)	pBaseFile) := FUNCTION

		expand_hx_rec_layout	:= RECORD
			hxmx.Layouts.base.hx_record;
			hxmx.Layouts.base.clean_address clean_address;
			STRING100		append_prep_address1;
			STRING50		append_prep_addresslast;
			AID.Common.xAID							        Append_RawAID;
			AID.Common.xAID							        Append_AceAID;
		END;

		//expand layout for normalize/denormalize address fields
		expand_hx_rec_layout expand_rec(pBaseFile L) := TRANSFORM
			SELF := L;
			SELF := [];
		END;

		temp_base_recs := PROJECT(pBaseFile,expand_rec(LEFT));	

		expand_hx_rec_layout tPrepAddress(temp_base_recs L) := TRANSFORM   
			SELF.Append_Prep_Address1			:= L.billing_addr;
			SELF.Append_Prep_AddressLast 	:= IF(TRIM(L.billing_city,LEFT,RIGHT) <> '',
																					TRIM(L.billing_city,LEFT,RIGHT) + ', ' + 
																					TRIM(L.billing_state,LEFT,RIGHT) + ' ' + 
																				 (IF(LENGTH(L.billing_zip) > 5, L.billing_zip[..5] + '-' + L.billing_zip[6..], L.billing_zip)), '');
			SELF	:= L;
			SELF := [];
		END;

		//transform the records to populate the prep address fields
		dAddressPrep	:= PROJECT(temp_base_recs,tPrepAddress(LEFT));

		HasAddress	:=	TRIM(dAddressPrep.Append_Prep_Address1,LEFT,RIGHT)    != '' AND
						TRIM(dAddressPrep.Append_Prep_AddressLast,LEFT,RIGHT) != '';

		dWith_address							:= dAddressPrep(HasAddress);
		dWithout_address	        := dAddressPrep(not(HasAddress));

		AID.Common.xflags flags	:=	AID.Common.eReturnValues.RawAID  |
										AID.Common.eReturnValues.ACECacheRecords;

		AID.MacAppendFromRaw_2Line(dWith_address,Append_Prep_Address1,Append_Prep_AddressLast,Append_RawAID,dAddressCleaned,flags);

		hxmx.layouts.base.hx_record addr(dAddressCleaned L)	:= TRANSFORM
			SELF.clean_billing_rawaid    := L.aidwork_rawaid;
			SELF.clean_billing_aceaid			:= L.aidwork_acecache.aid;
			SELF.clean_billing_prim_range := stringlib.stringfilterout(L.aidwork_acecache.prim_range,'.');
			SELF.clean_billing_predir			:= stringlib.stringfilterout(L.aidwork_acecache.predir,'.^!$+<>@=%?*\'');
			SELF.clean_billing_prim_name  := stringlib.stringfilterout(L.aidwork_acecache.prim_name,'.^!$+<>@=%?*\'');
			SELF.clean_billing_addr_suffix:= stringlib.stringfilterout(L.aidwork_acecache.addr_suffix, '.^!$+<>@=%?*\'');
			SELF.clean_billing_postdir		:= stringlib.stringfilterout(L.aidwork_acecache.postdir,'.^!$+<>@=%?*\'');
			SELF.clean_billing_unit_desig	:= stringlib.stringfilterout(L.aidwork_acecache.unit_desig,'.^!$+<>@=%?*\'');
			SELF.clean_billing_sec_range  := stringlib.stringfilterout(L.aidwork_acecache.sec_range,'.>$!%*@=?&\'');
			SELF.clean_billing_p_city_name:= IF(LENGTH(stringlib.stringfilterout(stringlib.stringtouppercase(L.aidwork_acecache.p_city_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ-. '))=0,L.aidwork_acecache.p_city_name,'');
			SELF.clean_billing_st					:= stringlib.stringfilterout(L.aidwork_acecache.st,'.^!$+<>@=%?*\'');
			SELF.clean_billing_zip        := L.aidwork_acecache.zip5;
			SELF.clean_billing_zip4				:= L.aidwork_acecache.zip4;
			SELF.clean_billing_cart				:= L.aidwork_acecache.cart;
			SELF.clean_billing_cr_sort_sz	:= L.aidwork_acecache.cr_sort_sz;
			SELF.clean_billing_lot				:= L.aidwork_acecache.lot;
			SELF.clean_billing_lot_order	:= L.aidwork_acecache.lot_order;
			SELF.clean_billing_dbpc				:= L.aidwork_acecache.dbpc;
			SELF.clean_billing_chk_digit	:= L.aidwork_acecache.chk_digit;
			SELF.clean_billing_rec_type		:= L.aidwork_acecache.rec_type;
			SELF.clean_billing_fips_st    := L.aidwork_acecache.county[1..2];
			SELF.clean_billing_fips_county:= L.aidwork_acecache.county[3..5];
			SELF.clean_billing_geo_lat		:= L.aidwork_acecache.geo_lat;
			SELF.clean_billing_geo_long		:= L.aidwork_acecache.geo_long;
			SELF.clean_billing_msa        := IF(L.aidwork_acecache.msa='','',L.aidwork_acecache.msa+'0');
			SELF.clean_billing_geo_blk		:= L.aidwork_acecache.geo_blk;
			SELF.clean_billing_geo_match	:= L.aidwork_acecache.geo_match;
			SELF.clean_billing_err_stat		:= L.aidwork_acecache.err_stat;
			SELF            := L.aidwork_acecache;
			SELF            := L;
		END;

		clean_address	:= PROJECT(dAddressCleaned, addr(LEFT));	
		no_address		:= PROJECT(dWithout_address, hxmx.Layouts.base.hx_record);
		
		RETURN clean_address + no_address;
	END;

	EXPORT mx_records(DATASET(hxmx.Layouts.Base.mx_record)	pBaseFile) := FUNCTION

		expand_mx_rec_layout	:= RECORD
			UNSIGNED8			unique_id;
			UNSIGNED4			address_type;
			hxmx.Layouts.base.mx_record;
			hxmx.Layouts.base.clean_address clean_address;
			STRING10		append_good_zip;
			STRING100		append_prep_address1;
			STRING50		append_prep_addresslast;
			AID.Common.xAID							        Append_RawAID;
			AID.Common.xAID							        Append_AceAID;
			UNSIGNED1	zero	:= 0;
		END;

		//expand layout for normalize/denormalize address fields
		expand_mx_rec_layout expand_rec(pBaseFile L) := TRANSFORM
			SELF := L;
			SELF := [];
		END;

		temp_base_recs := PROJECT(pBaseFile,expand_rec(LEFT));			

		//assign a unique_id for normalize/denormalize
		ut.MAC_Sequence_Records(temp_base_recs,unique_id,temp_base_seq);

		expand_mx_rec_layout tNormalizeAddress(temp_base_seq L, UNSIGNED cnt) := TRANSFORM   
			SELF.unique_id					 		:= l.unique_id;
			SELF.address_type			 			:= cnt;
			SELF.Append_good_zip				:= CHOOSE(cnt,(IF(LENGTH(L.billing_zip)>=5 AND ut.isNumeric(L.billing_zip),
																										L.billing_zip[..5],'')),
																								(IF(LENGTH(L.facility_lab_zip)>=5 AND ut.isNumeric(L.facility_lab_zip),
																										L.facility_lab_zip[..5], '')),
																								(IF(LENGTH(L.pay_to_zip)>=5 AND ut.isNumeric(L.pay_to_zip),
																										L.pay_to_zip[..5], '')),
																								(IF(LENGTH(L.serv_line_fac_zip)>=5 AND ut.isNumeric(L.serv_line_fac_zip),
																										L.serv_line_fac_zip[..5], '')));	
			SELF												:= L;
			SELF												:= [];
		END;

		//normalize the records to populate the address information for both addresses
		dAddressNorm	:= NORMALIZE(temp_base_seq,4,tNormalizeAddress(LEFT,counter));

		//prep the address lines for passing to AID
		expand_mx_rec_layout tPrepAddress(dAddressNorm L) := TRANSFORM   
			SELF.Append_Prep_Address1			:= MAP(L.address_type = 1 => StringLib.StringCleanSpaces(StringLib.StringToUpperCase(StringLib.StringFilterOut
																																	(L.billing_addr,'.^!$+<>@=%?*\''))),
																			 L.address_type = 2 => StringLib.StringCleanSpaces(StringLib.StringToUpperCase(StringLib.StringFilterOut
																																	(L.facility_lab_addr,'.^!$+<>@=%?*\''))),
																			 L.address_type = 3 => StringLib.StringCleanSpaces(StringLib.StringToUpperCase(StringLib.StringFilterOut
																																	(L.pay_to_addr,'.^!$+<>@=%?*\''))),
																			 StringLib.StringCleanSpaces(StringLib.StringToUpperCase(StringLib.StringFilterOut
																																	(L.serv_line_fac_addr,'.^!$+<>@=%?*\''))));
			SELF.Append_Prep_AddressLast  := MAP(L.address_type = 1 =>
																						 IF(L.billing_city <>'',
																								StringLib.StringCleanSpaces(StringLib.StringToUpperCase(L.billing_city)) + ', ' +  
																								StringLib.StringCleanSpaces(StringLib.StringToUpperCase(L.billing_state)) + ' ' + 
																								StringLib.StringCleanSpaces(StringLib.StringToUpperCase(L.append_good_zip)), ''),
																			 L.address_type = 2 =>
																						 IF(L.facility_lab_city <>'',
																								StringLib.StringCleanSpaces(StringLib.StringToUpperCase(L.facility_lab_city)) + ', ' + 
																								StringLib.StringCleanSpaces(StringLib.StringToUpperCase(L.facility_lab_state)) + ' ' + 
																								StringLib.StringCleanSpaces(StringLib.StringToUpperCase(L.append_good_zip)), ''),
																			 L.address_type = 3 =>
																						 IF(L.pay_to_city <>'',
																								StringLib.StringCleanSpaces(StringLib.StringToUpperCase(L.pay_to_city)) + ', ' + 
																								StringLib.StringCleanSpaces(StringLib.StringToUpperCase(L.pay_to_state)) + ' ' + 
																								StringLib.StringCleanSpaces(StringLib.StringToUpperCase(L.append_good_zip)), ''),
																			IF(L.serv_line_fac_city <> '',
																								StringLib.StringCleanSpaces(StringLib.StringToUpperCase(L.serv_line_fac_city)) + ', ' + 
																								StringLib.StringCleanSpaces(StringLib.StringToUpperCase(L.serv_line_fac_state)) + ' ' + 
																								StringLib.StringCleanSpaces(StringLib.StringToUpperCase(L.append_good_zip)), ''));
			SELF	:= L;
			SELF := [];
		END;

		dAddressPrep := PROJECT(dAddressNorm, tPrepAddress(LEFT));

		HasAddress	:=	TRIM(dAddressPrep.Append_Prep_Address1,LEFT,RIGHT)    != '' AND
						TRIM(dAddressPrep.Append_Prep_AddressLast,LEFT,RIGHT) != '';

		dWith_address			:= dAddressPrep(HasAddress);
		dWithout_address	:= dAddressPrep(not(HasAddress));

		AID.Common.xflags flags	:=	AID.Common.eReturnValues.RawAID  |
										AID.Common.eReturnValues.ACECacheRecords;

		AID.MacAppendFromRaw_2Line(dWith_address,Append_Prep_Address1,Append_Prep_AddressLast,Append_RawAID,dAddressCleaned,flags);

		expand_mx_rec_layout	tAddressAppended(dAddressCleaned pInput)	:=		  TRANSFORM
				SELF.Append_RawAID							:=	pInput.AIDWork_RawAID;
				SELF.Append_AceAID          		:=  pInput.aidwork_acecache.aid;
				SELF.clean_address.zip					:=	pInput.AIDWork_ACECache.zip5;
				SELF.clean_address.fips_st		  :=  pInput.AIDWork_ACECache.county[1..2];
				SELF.clean_address.fips_county  :=  pInput.AIDWork_ACECache.county[3..5];
				SELF.clean_address							:=	pInput.AIDWork_ACECache;
				SELF														:=	pInput;
		END;

    dAddressAppended		:=	PROJECT(dAddressCleaned,tAddressAppended(LEFT));

	  all_address := DISTRIBUTE(dAddressAppended + dWithout_address, HASH(unique_id));

	  //denormalize the records 
		temp_base_seq denormAID(temp_base_seq l, dAddressAppended r) := TRANSFORM
				SELF.clean_billing_rawaid 						:= IF(r.address_type = 1, r.Append_RawAID, l.clean_billing_rawaid);
				SELF.clean_billing_aceaid							:= IF(r.address_type = 1, r.Append_AceAID, l.clean_billing_aceaid);
				SELF.clean_facility_lab_rawaid				:= IF(r.address_type = 2, r.Append_RawAID, l.clean_facility_lab_rawaid);		
				SELF.clean_facility_lab_aceaid				:= IF(r.address_type = 2, r.Append_AceAID, l.clean_facility_lab_aceaid);
				SELF.clean_pay_to_rawaid							:= IF(r.address_type = 3, r.Append_RawAID, l.clean_pay_to_rawaid);		
				SELF.clean_pay_to_aceaid							:= IF(r.address_type = 3, r.Append_AceAID, l.clean_pay_to_aceaid);
				SELF.clean_serv_line_fac_rawaid				:= IF(r.address_type = 4, r.Append_RawAID, l.clean_serv_line_fac_rawaid);		
				SELF.clean_serv_line_fac_aceaid				:= IF(r.address_type = 4, r.Append_AceAID, l.clean_serv_line_fac_aceaid);
				SELF.Clean_billing_prim_range					:= IF(r.address_type = 1	,r.Clean_address.prim_range		,l.Clean_billing_prim_range	);
				SELF.Clean_billing_predir							:= IF(r.address_type = 1	,r.Clean_address.predir				,l.Clean_billing_predir	);
				SELF.Clean_billing_prim_name					:= IF(r.address_type = 1	,r.Clean_address.prim_name		,l.Clean_billing_prim_name	);
				SELF.Clean_billing_addr_suffix				:= IF(r.address_type = 1	,r.Clean_address.addr_suffix	,l.Clean_billing_addr_suffix	);
				SELF.Clean_billing_postdir						:= IF(r.address_type = 1	,r.Clean_address.postdir			,l.Clean_billing_postdir	);
				SELF.Clean_billing_unit_desig					:= IF(r.address_type = 1	,r.Clean_address.unit_desig		,l.Clean_billing_unit_desig	);
				SELF.Clean_billing_sec_range					:= IF(r.address_type = 1	,r.Clean_address.sec_range		,l.Clean_billing_sec_range	);
				SELF.Clean_billing_p_city_name				:= IF(r.address_type = 1	,r.Clean_address.p_city_name	,l.Clean_billing_p_city_name	);
				SELF.Clean_billing_st									:= IF(r.address_type = 1	,r.Clean_address.st						,l.Clean_billing_st	);
				SELF.Clean_billing_zip								:= IF(r.address_type = 1	,r.Clean_address.zip					,l.Clean_billing_zip	);
				SELF.Clean_billing_zip4								:= IF(r.address_type = 1	,r.Clean_address.zip4					,l.Clean_billing_zip4	);		
				SELF.Clean_billing_cart								:= IF(r.address_type = 1	,r.Clean_address.cart					,l.Clean_billing_cart	);
				SELF.Clean_billing_cr_sort_sz					:= IF(r.address_type = 1	,r.Clean_address.cr_sort_sz		,l.Clean_billing_cr_sort_sz	);
				SELF.Clean_billing_lot								:= IF(r.address_type = 1	,r.Clean_address.lot					,l.Clean_billing_lot	);
				SELF.Clean_billing_lot_order					:= IF(r.address_type = 1	,r.Clean_address.lot_order		,l.Clean_billing_lot_order	);
				SELF.Clean_billing_dbpc								:= IF(r.address_type = 1	,r.Clean_address.dbpc					,l.Clean_billing_dbpc	);
				SELF.Clean_billing_chk_digit					:= IF(r.address_type = 1	,r.Clean_address.chk_digit		,l.Clean_billing_chk_digit	);
				SELF.Clean_billing_rec_type						:= IF(r.address_type = 1	,r.Clean_address.rec_type			,l.Clean_billing_rec_type	);
				SELF.Clean_billing_fips_st						:= IF(r.address_type = 1	,r.Clean_address.fips_st		  ,l.Clean_billing_fips_st	);
				SELF.Clean_billing_fips_county				:= IF(r.address_type = 1	,r.Clean_address.fips_county  ,l.Clean_billing_fips_county	);
				SELF.Clean_billing_geo_lat						:= IF(r.address_type = 1	,r.Clean_address.geo_lat			,l.Clean_billing_geo_lat	);
				SELF.Clean_billing_geo_long						:= IF(r.address_type = 1	,r.Clean_address.geo_long			,l.Clean_billing_geo_long	);
				SELF.Clean_billing_msa								:= IF(r.address_type = 1	,r.Clean_address.msa					,l.Clean_billing_msa	);
				SELF.Clean_billing_geo_blk						:= IF(r.address_type = 1	,r.Clean_address.geo_blk			,l.Clean_billing_geo_blk	);
				SELF.Clean_billing_geo_match					:= IF(r.address_type = 1	,r.Clean_address.geo_match		,l.Clean_billing_geo_match	);
				SELF.Clean_billing_err_stat						:= IF(r.address_type = 1	,r.Clean_address.err_stat			,l.Clean_billing_err_stat		);	
				SELF.Clean_facility_lab_prim_range		:= IF(r.address_type = 2	,r.Clean_address.prim_range		,l.Clean_facility_lab_prim_range	);
				SELF.Clean_facility_lab_predir				:= IF(r.address_type = 2	,r.Clean_address.predir				,l.Clean_facility_lab_predir	);
				SELF.Clean_facility_lab_prim_name			:= IF(r.address_type = 2	,r.Clean_address.prim_name		,l.Clean_facility_lab_prim_name	);
				SELF.Clean_facility_lab_addr_suffix		:= IF(r.address_type = 2	,r.Clean_address.addr_suffix	,l.Clean_facility_lab_addr_suffix	);
				SELF.Clean_facility_lab_postdir				:= IF(r.address_type = 2	,r.Clean_address.postdir			,l.Clean_facility_lab_postdir	);
				SELF.Clean_facility_lab_unit_desig		:= IF(r.address_type = 2	,r.Clean_address.unit_desig		,l.Clean_facility_lab_unit_desig	);
				SELF.Clean_facility_lab_sec_range			:= IF(r.address_type = 2	,r.Clean_address.sec_range		,l.Clean_facility_lab_sec_range	);
				SELF.Clean_facility_lab_p_city_name		:= IF(r.address_type = 2	,r.Clean_address.p_city_name	,l.Clean_facility_lab_p_city_name	);
				SELF.Clean_facility_lab_st						:= IF(r.address_type = 2	,r.Clean_address.st						,l.Clean_facility_lab_st	);
				SELF.Clean_facility_lab_zip						:= IF(r.address_type = 2	,r.Clean_address.zip					,l.Clean_facility_lab_zip	);
				SELF.Clean_facility_lab_zip4					:= IF(r.address_type = 2	,r.Clean_address.zip4					,l.Clean_facility_lab_zip4	);		
				SELF.Clean_facility_lab_cart					:= IF(r.address_type = 2	,r.Clean_address.cart					,l.Clean_facility_lab_cart	);
				SELF.Clean_facility_lab_cr_sort_sz		:= IF(r.address_type = 2	,r.Clean_address.cr_sort_sz		,l.Clean_facility_lab_cr_sort_sz	);
				SELF.Clean_facility_lab_lot						:= IF(r.address_type = 2	,r.Clean_address.lot					,l.Clean_facility_lab_lot	);
				SELF.Clean_facility_lab_lot_order			:= IF(r.address_type = 2	,r.Clean_address.lot_order		,l.Clean_facility_lab_lot_order	);
				SELF.Clean_facility_lab_dbpc					:= IF(r.address_type = 2	,r.Clean_address.dbpc					,l.Clean_facility_lab_dbpc	);
				SELF.Clean_facility_lab_chk_digit			:= IF(r.address_type = 2	,r.Clean_address.chk_digit		,l.Clean_facility_lab_chk_digit	);
				SELF.Clean_facility_lab_rec_type			:= IF(r.address_type = 2	,r.Clean_address.rec_type			,l.Clean_facility_lab_rec_type	);
				SELF.Clean_facility_lab_fips_st				:= IF(r.address_type = 2	,r.Clean_address.fips_st		  ,l.Clean_facility_lab_fips_st	);
				SELF.Clean_facility_lab_fips_county		:= IF(r.address_type = 2	,r.Clean_address.fips_county  ,l.Clean_facility_lab_fips_county	);
				SELF.Clean_facility_lab_geo_lat				:= IF(r.address_type = 2	,r.Clean_address.geo_lat			,l.Clean_facility_lab_geo_lat	);
				SELF.Clean_facility_lab_geo_long			:= IF(r.address_type = 2	,r.Clean_address.geo_long			,l.Clean_facility_lab_geo_long	);
				SELF.Clean_facility_lab_msa						:= IF(r.address_type = 2	,r.Clean_address.msa					,l.Clean_facility_lab_msa	);
				SELF.Clean_facility_lab_geo_blk				:= IF(r.address_type = 2	,r.Clean_address.geo_blk			,l.Clean_facility_lab_geo_blk	);
				SELF.Clean_facility_lab_geo_match			:= IF(r.address_type = 2	,r.Clean_address.geo_match		,l.Clean_facility_lab_geo_match	);
				SELF.Clean_facility_lab_err_stat			:= IF(r.address_type = 2	,r.Clean_address.err_stat			,l.Clean_facility_lab_err_stat		);			
				SELF.Clean_pay_to_prim_range					:= IF(r.address_type = 3	,r.Clean_address.prim_range		,l.Clean_pay_to_prim_range	);
				SELF.Clean_pay_to_predir							:= IF(r.address_type = 3	,r.Clean_address.predir				,l.Clean_pay_to_predir	);
				SELF.Clean_pay_to_prim_name						:= IF(r.address_type = 3	,r.Clean_address.prim_name		,l.Clean_pay_to_prim_name	);
				SELF.Clean_pay_to_addr_suffix					:= IF(r.address_type = 3	,r.Clean_address.addr_suffix	,l.Clean_pay_to_addr_suffix	);
				SELF.Clean_pay_to_postdir							:= IF(r.address_type = 3	,r.Clean_address.postdir			,l.Clean_pay_to_postdir	);
				SELF.Clean_pay_to_unit_desig					:= IF(r.address_type = 3	,r.Clean_address.unit_desig		,l.Clean_pay_to_unit_desig	);
				SELF.Clean_pay_to_sec_range						:= IF(r.address_type = 3	,r.Clean_address.sec_range		,l.Clean_pay_to_sec_range	);
				SELF.Clean_pay_to_p_city_name					:= IF(r.address_type = 3	,r.Clean_address.p_city_name	,l.Clean_pay_to_p_city_name	);
				SELF.Clean_pay_to_st									:= IF(r.address_type = 3	,r.Clean_address.st						,l.Clean_pay_to_st	);
				SELF.Clean_pay_to_zip									:= IF(r.address_type = 3	,r.Clean_address.zip					,l.Clean_pay_to_zip	);
				SELF.Clean_pay_to_zip4								:= IF(r.address_type = 3	,r.Clean_address.zip4					,l.Clean_pay_to_zip4	);		
				SELF.Clean_pay_to_cart								:= IF(r.address_type = 3	,r.Clean_address.cart					,l.Clean_pay_to_cart	);
				SELF.Clean_pay_to_cr_sort_sz					:= IF(r.address_type = 3	,r.Clean_address.cr_sort_sz		,l.Clean_pay_to_cr_sort_sz	);
				SELF.Clean_pay_to_lot									:= IF(r.address_type = 3	,r.Clean_address.lot					,l.Clean_pay_to_lot	);
				SELF.Clean_pay_to_lot_order						:= IF(r.address_type = 3	,r.Clean_address.lot_order		,l.Clean_pay_to_lot_order	);
				SELF.Clean_pay_to_dbpc								:= IF(r.address_type = 3	,r.Clean_address.dbpc					,l.Clean_pay_to_dbpc	);
				SELF.Clean_pay_to_chk_digit						:= IF(r.address_type = 3	,r.Clean_address.chk_digit		,l.Clean_pay_to_chk_digit	);
				SELF.Clean_pay_to_rec_type						:= IF(r.address_type = 3	,r.Clean_address.rec_type			,l.Clean_pay_to_rec_type	);
				SELF.Clean_pay_to_fips_st							:= IF(r.address_type = 3	,r.Clean_address.fips_st		  ,l.Clean_pay_to_fips_st	);
				SELF.Clean_pay_to_fips_county					:= IF(r.address_type = 3	,r.Clean_address.fips_county  ,l.Clean_pay_to_fips_county	);
				SELF.Clean_pay_to_geo_lat							:= IF(r.address_type = 3	,r.Clean_address.geo_lat			,l.Clean_pay_to_geo_lat	);
				SELF.Clean_pay_to_geo_long						:= IF(r.address_type = 3	,r.Clean_address.geo_long			,l.Clean_pay_to_geo_long	);
				SELF.Clean_pay_to_msa									:= IF(r.address_type = 3	,r.Clean_address.msa					,l.Clean_pay_to_msa	);
				SELF.Clean_pay_to_geo_blk							:= IF(r.address_type = 3	,r.Clean_address.geo_blk			,l.Clean_pay_to_geo_blk	);
				SELF.Clean_pay_to_geo_match						:= IF(r.address_type = 3	,r.Clean_address.geo_match		,l.Clean_pay_to_geo_match	);
				SELF.Clean_pay_to_err_stat						:= IF(r.address_type = 3	,r.Clean_address.err_stat			,l.Clean_pay_to_err_stat		);
				SELF.Clean_serv_line_fac_prim_range		:= IF(r.address_type = 4	,r.Clean_address.prim_range		,l.Clean_serv_line_fac_prim_range	);
				SELF.Clean_serv_line_fac_predir				:= IF(r.address_type = 4	,r.Clean_address.predir				,l.Clean_serv_line_fac_predir	);
				SELF.Clean_serv_line_fac_prim_name		:= IF(r.address_type = 4	,r.Clean_address.prim_name		,l.Clean_serv_line_fac_prim_name	);
				SELF.Clean_serv_line_fac_addr_suffix	:= IF(r.address_type = 4	,r.Clean_address.addr_suffix	,l.Clean_serv_line_fac_addr_suffix	);
				SELF.Clean_serv_line_fac_postdir			:= IF(r.address_type = 4	,r.Clean_address.postdir			,l.Clean_serv_line_fac_postdir	);
				SELF.Clean_serv_line_fac_unit_desig		:= IF(r.address_type = 4	,r.Clean_address.unit_desig		,l.Clean_serv_line_fac_unit_desig	);
				SELF.Clean_serv_line_fac_sec_range		:= IF(r.address_type = 4	,r.Clean_address.sec_range		,l.Clean_serv_line_fac_sec_range	);
				SELF.Clean_serv_line_fac_p_city_name	:= IF(r.address_type = 4	,r.Clean_address.p_city_name	,l.Clean_serv_line_fac_p_city_name	);
				SELF.Clean_serv_line_fac_st						:= IF(r.address_type = 4	,r.Clean_address.st						,l.Clean_serv_line_fac_st	);
				SELF.Clean_serv_line_fac_zip					:= IF(r.address_type = 4	,r.Clean_address.zip					,l.Clean_serv_line_fac_zip	);
				SELF.Clean_serv_line_fac_zip4					:= IF(r.address_type = 4	,r.Clean_address.zip4					,l.Clean_serv_line_fac_zip4	);		
				SELF.Clean_serv_line_fac_cart					:= IF(r.address_type = 4	,r.Clean_address.cart					,l.Clean_serv_line_fac_cart	);
				SELF.Clean_serv_line_fac_cr_sort_sz		:= IF(r.address_type = 4	,r.Clean_address.cr_sort_sz		,l.Clean_serv_line_fac_cr_sort_sz	);
				SELF.Clean_serv_line_fac_lot					:= IF(r.address_type = 4	,r.Clean_address.lot					,l.Clean_serv_line_fac_lot	);
				SELF.Clean_serv_line_fac_lot_order		:= IF(r.address_type = 4	,r.Clean_address.lot_order		,l.Clean_serv_line_fac_lot_order	);
				SELF.Clean_serv_line_fac_dbpc					:= IF(r.address_type = 4	,r.Clean_address.dbpc					,l.Clean_serv_line_fac_dbpc	);
				SELF.Clean_serv_line_fac_chk_digit		:= IF(r.address_type = 4	,r.Clean_address.chk_digit		,l.Clean_serv_line_fac_chk_digit	);
				SELF.Clean_serv_line_fac_rec_type			:= IF(r.address_type = 4	,r.Clean_address.rec_type			,l.Clean_serv_line_fac_rec_type	);
				SELF.Clean_serv_line_fac_fips_st			:= IF(r.address_type = 4	,r.Clean_address.fips_st		  ,l.Clean_serv_line_fac_fips_st	);
				SELF.Clean_serv_line_fac_fips_county	:= IF(r.address_type = 4	,r.Clean_address.fips_county  ,l.Clean_serv_line_fac_fips_county	);
				SELF.Clean_serv_line_fac_geo_lat			:= IF(r.address_type = 4	,r.Clean_address.geo_lat			,l.Clean_serv_line_fac_geo_lat	);
				SELF.Clean_serv_line_fac_geo_long			:= IF(r.address_type = 4	,r.Clean_address.geo_long			,l.Clean_serv_line_fac_geo_long	);
				SELF.Clean_serv_line_fac_msa					:= IF(r.address_type = 4	,r.Clean_address.msa					,l.Clean_serv_line_fac_msa	);
				SELF.Clean_serv_line_fac_geo_blk			:= IF(r.address_type = 4	,r.Clean_address.geo_blk			,l.Clean_serv_line_fac_geo_blk	);
				SELF.Clean_serv_line_fac_geo_match		:= IF(r.address_type = 4	,r.Clean_address.geo_match		,l.Clean_serv_line_fac_geo_match	);
				SELF.Clean_serv_line_fac_err_stat			:= IF(r.address_type = 4	,r.Clean_address.err_stat			,l.Clean_serv_line_fac_err_stat		);
				SELF            := l;
		END;

	  denormRecs :=  DENORMALIZE(temp_base_seq,all_address,
								  LEFT.unique_id = RIGHT.unique_id,
								  denormAID(LEFT,RIGHT),LOCAL);

		final_file	:= PROJECT(denormRecs, hxmx.layouts.base.mx_record); 

	RETURN final_file;
	END;
END;
	   