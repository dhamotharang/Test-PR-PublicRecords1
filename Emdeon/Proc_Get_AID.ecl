IMPORT ut, lib_fileservices, _control, lib_STRINGlib, _Validate, AID, did_add, Emdeon;
			
cleanUpper(STRING s) := FUNCTION
			RETURN StringLib.StringCleanSpaces(StringLib.StringToUpperCase(s));
END;
	
EXPORT Proc_Get_AID	:= MODULE

	EXPORT C_records(DATASET(Emdeon.Layouts.Base.C_record)	pBaseFile) := FUNCTION

		expand_C_rec_layout	:= RECORD
			UNSIGNED8			unique_id;
			UNSIGNED4			address_type;
			Emdeon.Layouts.base.c_record;
			Emdeon.Layouts.base.clean_address clean_address;
			STRING100		append_prep_address1;
			STRING50		append_prep_addresslast;
			AID.Common.xAID							        Append_RawAID;
			AID.Common.xAID							        Append_AceAID;
			UNSIGNED1	zero	:= 0;
		END;

		//expand layout for NORMALIZE/DENORMALIZE address fields
		expand_C_rec_layout expand_rec(pBaseFile L) := TRANSFORM
			SELF := L;
			SELF := [];
		END;
  
		temp_base_recs := PROJECT(pBaseFile,expand_rec(LEFT));	
				
		//assign a unique_id for NORMALIZE/DENORMALIZE
		ut.MAC_Sequence_Records(temp_base_recs,unique_id,temp_base_seq);

		expand_C_rec_layout tNormalizeAddress(temp_base_seq L, UNSIGNED cnt) := TRANSFORM   
			SELF.unique_id						 	:= L.unique_id;
			SELF.address_type			 			:= cnt;
			SELF.Append_Prep_Address1			:= CHOOSE(cnt,cleanUpper(L.billing_address1),cleanUpper(L.billing_address2),cleanUpper(L.facility_address1),cleanUpper(L.facility_address2));
			pre_Append_Prep_AddressLast 	:= CHOOSE(cnt,cleanUpper(L.billing_city) + ', ' + cleanUpper(L.billing_state) + ' ' + L.billing_zip[..5],
																								 cleanUpper(L.facility_city) + ', ' + cleanUpper(L.facility_state) + ' ' + L.facility_zip[..5]);
			SELF.Append_Prep_AddressLast	:= IF(pre_Append_Prep_AddressLast = ',','',pre_Append_Prep_AddressLast);
			
			
/* 			SELF.Append_Prep_Address1		:= CHOOSE(cnt,cleanUpper(L.billing_address1) + ' ' + cleanUpper(L.billing_address2)
   																						,cleanUpper(L.facility_address1) + ' ' + cleanUpper(L.facility_address2));
   			SELF.Append_Prep_AddressLast := CHOOSE(cnt,cleanUpper(L.billing_city) + ', ' + cleanUpper(L.billing_state) + ' ' + L.billing_zip[..5],
   																								 cleanUpper(L.facility_city)+ ', ' + cleanUpper(L.facility_state) + ' ' + L.facility_zip[..5]);
*/
			SELF := L;
			SELF := [];
		END;
   
		//NORMALIZE the records to populate the address information for both addresses
		dAddressPrep	:= NORMALIZE(temp_base_seq,2,tNormalizeAddress(LEFT,counter));
   
		// output(dAddressPrep);
   
		HasAddress	:=	// TRIM(dAddressPrep.Append_Prep_Address1,LEFT,RIGHT)    != '' AND
						TRIM(dAddressPrep.Append_Prep_AddressLast,LEFT,RIGHT) != '';
										
		dWith_address			:= dAddressPrep(HasAddress);
		dWithout_address	        := dAddressPrep(NOT(HasAddress));
			
		AID.Common.xflags flags	:=	AID.Common.eReturnValues.RawAID  |
										AID.Common.eReturnValues.ACECacheRecords;
		
		AID.MacAppendFromRaw_2Line(dWith_address,Append_Prep_Address1,Append_Prep_AddressLast,Append_RawAID,dAddressCleaned,flags);

		expand_C_rec_layout	tAddressAppended(dAddressCleaned pInput)	:=		  TRANSFORM
				SELF.Append_RawAID							:=	pInput.AIDWork_RawAID;
				SELF.Append_AceAID          		:=  pInput.AIDWork_ACECache.aid;
				SELF.clean_address.zip					:=	pInput.AIDWork_ACECache.zip5;
				SELF.clean_address.fips_st		  :=  pInput.AIDWork_ACECache.county[1..2];
				SELF.clean_address.fips_county  :=  pInput.AIDWork_ACECache.county[3..5];
				SELF.clean_address							:=	pInput.AIDWork_ACECache;
				SELF														:=	pInput;
		END;
			
    dAddressAppended		:=	PROJECT(dAddressCleaned,tAddressAppended(LEFT));
	   
	  all_address := DISTRIBUTE(dAddressAppended + dWithout_address, HASH(unique_id));
	   		   
	  //DENORMALIZE the records 
		temp_base_seq denormAID(temp_base_seq l, dAddressAppended r) := TRANSFORM
				SELF.clean_billing_rawaid 			:= IF(r.address_type = 1, r.Append_RawAID, l.clean_billing_rawaid);
				SELF.clean_facility_rawaid			:= IF(r.address_type = 2, r.Append_RawAID, l.clean_facility_rawaid);
				SELF.clean_billing_aceaid				:= IF(r.address_type = 1, r.Append_AceAID, l.clean_billing_aceaid);
				SELF.clean_facility_aceaid			:= IF(r.address_type = 2, r.Append_AceAID, l.clean_facility_aceaid);
				SELF.Clean_billing_prim_range		:= IF(r.address_type = 1	,r.Clean_address.prim_range		,l.Clean_billing_prim_range	);
				SELF.Clean_billing_predir				:= IF(r.address_type = 1	,r.Clean_address.predir				,l.Clean_billing_predir	);
				SELF.Clean_billing_prim_name		:= IF(r.address_type = 1	,r.Clean_address.prim_name		,l.Clean_billing_prim_name	);
				SELF.Clean_billing_addr_suffix	:= IF(r.address_type = 1	,r.Clean_address.addr_suffix	,l.Clean_billing_addr_suffix	);
				SELF.Clean_billing_postdir			:= IF(r.address_type = 1	,r.Clean_address.postdir			,l.Clean_billing_postdir	);
				SELF.Clean_billing_unit_desig		:= IF(r.address_type = 1	,r.Clean_address.unit_desig		,l.Clean_billing_unit_desig	);
				SELF.Clean_billing_sec_range		:= IF(r.address_type = 1	,r.Clean_address.sec_range		,l.Clean_billing_sec_range	);
				SELF.Clean_billing_p_city_name	:= IF(r.address_type = 1	,r.Clean_address.p_city_name	,l.Clean_billing_p_city_name	);
				// SELF.Clean_billing_v_city_name	:= IF(r.address_type = 1	,r.Clean_address.v_city_name	,l.Clean_billing_v_city_name	);
				SELF.Clean_billing_st						:= IF(r.address_type = 1	,r.Clean_address.st						,l.Clean_billing_st	);
				SELF.Clean_billing_zip					:= IF(r.address_type = 1	,r.Clean_address.zip					,l.Clean_billing_zip	);
				//SELF.Clean_billing_zip4					:= IF(r.address_type = 1	,r.Clean_address.zip4					,l.Clean_billing_zip4	);		
				SELF.Clean_billing_cart					:= IF(r.address_type = 1	,r.Clean_address.cart					,l.Clean_billing_cart	);
				SELF.Clean_billing_cr_sort_sz		:= IF(r.address_type = 1	,r.Clean_address.cr_sort_sz		,l.Clean_billing_cr_sort_sz	);
				SELF.Clean_billing_lot					:= IF(r.address_type = 1	,r.Clean_address.lot					,l.Clean_billing_lot	);
				SELF.Clean_billing_lot_order		:= IF(r.address_type = 1	,r.Clean_address.lot_order		,l.Clean_billing_lot_order	);
				SELF.Clean_billing_dbpc					:= IF(r.address_type = 1	,r.Clean_address.dbpc					,l.Clean_billing_dbpc	);
				SELF.Clean_billing_chk_digit		:= IF(r.address_type = 1	,r.Clean_address.chk_digit		,l.Clean_billing_chk_digit	);
				SELF.Clean_billing_rec_type			:= IF(r.address_type = 1	,r.Clean_address.rec_type			,l.Clean_billing_rec_type	);
				SELF.Clean_billing_fips_st			:= IF(r.address_type = 1	,r.Clean_address.fips_st		  ,l.Clean_billing_fips_st	);
				SELF.Clean_billing_fips_county	:= IF(r.address_type = 1	,r.Clean_address.fips_county  ,l.Clean_billing_fips_county	);
				SELF.Clean_billing_geo_lat			:= IF(r.address_type = 1	,r.Clean_address.geo_lat			,l.Clean_billing_geo_lat	);
				SELF.Clean_billing_geo_long			:= IF(r.address_type = 1	,r.Clean_address.geo_long			,l.Clean_billing_geo_long	);
				SELF.Clean_billing_msa					:= IF(r.address_type = 1	,r.Clean_address.msa					,l.Clean_billing_msa	);
				SELF.Clean_billing_geo_blk			:= IF(r.address_type = 1	,r.Clean_address.geo_blk			,l.Clean_billing_geo_blk	);
				SELF.Clean_billing_geo_match		:= IF(r.address_type = 1	,r.Clean_address.geo_match		,l.Clean_billing_geo_match	);
				SELF.Clean_billing_err_stat			:= IF(r.address_type = 1	,r.Clean_address.err_stat			,l.Clean_billing_err_stat		);
				SELF.Clean_facility_prim_range	:= IF(r.address_type = 2	,r.Clean_address.prim_range		,l.Clean_facility_prim_range	);
				SELF.Clean_facility_predir			:= IF(r.address_type = 2	,r.Clean_address.predir				,l.Clean_facility_predir	);
				SELF.Clean_facility_prim_name		:= IF(r.address_type = 2	,r.Clean_address.prim_name		,l.Clean_facility_prim_name	);
				SELF.Clean_facility_addr_suffix	:= IF(r.address_type = 2	,r.Clean_address.addr_suffix	,l.Clean_facility_addr_suffix	);
				SELF.Clean_facility_postdir			:= IF(r.address_type = 2	,r.Clean_address.postdir			,l.Clean_facility_postdir	);
				SELF.Clean_facility_unit_desig	:= IF(r.address_type = 2	,r.Clean_address.unit_desig		,l.Clean_facility_unit_desig	);
				SELF.Clean_facility_sec_range		:= IF(r.address_type = 2	,r.Clean_address.sec_range		,l.Clean_facility_sec_range	);
				SELF.Clean_facility_p_city_name	:= IF(r.address_type = 2	,r.Clean_address.p_city_name	,l.Clean_facility_p_city_name	);
				// SELF.Clean_facility_v_city_name:= IF(r.address_type = 2	,r.Clean_address.v_city_name	,l.Clean_facility_v_city_name	);
				SELF.Clean_facility_st					:= IF(r.address_type = 2	,r.Clean_address.st						,l.Clean_facility_st	);
				SELF.Clean_facility_zip					:= IF(r.address_type = 2	,r.Clean_address.zip					,l.Clean_facility_zip	);
				//SELF.Clean_facility_zip4				:= IF(r.address_type = 2	,r.Clean_address.zip4					,l.Clean_facility_zip4	);		
				SELF.Clean_facility_cart				:= IF(r.address_type = 2	,r.Clean_address.cart					,l.Clean_facility_cart	);
				SELF.Clean_facility_cr_sort_sz	:= IF(r.address_type = 2	,r.Clean_address.cr_sort_sz		,l.Clean_facility_cr_sort_sz	);
				SELF.Clean_facility_lot					:= IF(r.address_type = 2	,r.Clean_address.lot					,l.Clean_facility_lot	);
				SELF.Clean_facility_lot_order		:= IF(r.address_type = 2	,r.Clean_address.lot_order		,l.Clean_facility_lot_order	);
				SELF.Clean_facility_dbpc				:= IF(r.address_type = 2	,r.Clean_address.dbpc					,l.Clean_facility_dbpc	);
				SELF.Clean_facility_chk_digit		:= IF(r.address_type = 2	,r.Clean_address.chk_digit		,l.Clean_facility_chk_digit	);
				SELF.Clean_facility_rec_type		:= IF(r.address_type = 2	,r.Clean_address.rec_type			,l.Clean_facility_rec_type	);
				SELF.Clean_facility_fips_st			:= IF(r.address_type = 2	,r.Clean_address.fips_st		  ,l.Clean_facility_fips_st	);
				SELF.Clean_facility_fips_county	:= IF(r.address_type = 2	,r.Clean_address.fips_county  ,l.Clean_facility_fips_county	);
				SELF.Clean_facility_geo_lat			:= IF(r.address_type = 2	,r.Clean_address.geo_lat			,l.Clean_facility_geo_lat	);
				SELF.Clean_facility_geo_long		:= IF(r.address_type = 2	,r.Clean_address.geo_long			,l.Clean_facility_geo_long	);
				SELF.Clean_facility_msa					:= IF(r.address_type = 2	,r.Clean_address.msa					,l.Clean_facility_msa	);
				SELF.Clean_facility_geo_blk			:= IF(r.address_type = 2	,r.Clean_address.geo_blk			,l.Clean_facility_geo_blk	);
				SELF.Clean_facility_geo_match		:= IF(r.address_type = 2	,r.Clean_address.geo_match		,l.Clean_facility_geo_match	);
				SELF.Clean_facility_err_stat		:= IF(r.address_type = 2	,r.Clean_address.err_stat			,l.Clean_facility_err_stat		);
				SELF            := l;
		END;
	   
	  denormRecs :=  DENORMALIZE(temp_base_seq,all_address,
								  LEFT.unique_id = RIGHT.unique_id,
								  denormAID(LEFT,RIGHT), LOCAL);
								         
		final_file	:= PROJECT(denormRecs, Emdeon.layouts.base.c_record);	
		RETURN final_file;
	END;
	
	EXPORT D_records(DATASET(Emdeon.Layouts.Base.D_record)	pBaseFile) := FUNCTION

		expand_D_rec_layout	:= RECORD
			UNSIGNED8			unique_id;
			UNSIGNED4			address_type;
			Emdeon.Layouts.base.d_record;
			Emdeon.Layouts.base.clean_address clean_address;
			STRING100		append_prep_address1;
			STRING50		append_prep_addresslast;
			AID.Common.xAID							        Append_RawAID;
			AID.Common.xAID							        Append_AceAID;
			UNSIGNED1	zero	:= 0;
		END;

		//expand layout for NORMALIZE/DENORMALIZE address fields
		expand_D_rec_layout expand_rec(pBaseFile L) := TRANSFORM
			SELF := L;
			SELF := [];
		END;
  
		temp_base_recs := PROJECT(pBaseFile,expand_rec(LEFT));			
		
		//assign a unique_id for NORMALIZE/DENORMALIZE
		ut.MAC_Sequence_Records(temp_base_recs,unique_id,temp_base_seq);

		expand_D_rec_layout tNormalizeAddress(temp_base_seq L, UNSIGNED cnt) := TRANSFORM   
			SELF.unique_id					 		:= l.unique_id;
			SELF.address_type			 			:= cnt;
			SELF.Append_Prep_Address1		:= CHOOSE(cnt,cleanUpper(L.pay_to_address1) + ' ' + cleanUpper(L.pay_to_address2),
																						cleanUpper(L.pay_to_plan_address1) + ' ' + cleanUpper(L.pay_to_plan_address2));
			SELF.Append_Prep_AddressLast := CHOOSE(cnt,cleanUpper(L.pay_to_city) + ', ' + cleanUpper(L.pay_to_state) + ' ' + L.pay_to_zip[..5],
																								 cleanUpper(L.pay_to_plan_city)+ ', ' + cleanUpper(L.pay_to_plan_state) + ' ' + L.pay_to_plan_zip[..5]);
			SELF := [];
		END;
   
		//NORMALIZE the records to populate the address information for both addresses
		dAddressPrep	:= NORMALIZE(temp_base_seq,2,tNormalizeAddress(LEFT,counter));
   
		HasAddress	:=	TRIM(dAddressPrep.Append_Prep_Address1,LEFT,RIGHT)    != '' AND
						TRIM(dAddressPrep.Append_Prep_AddressLast,LEFT,RIGHT) != '';
										
		dWith_address			:= dAddressPrep(HasAddress);
		dWithout_address	:= dAddressPrep(NOT(HasAddress));
			
		AID.Common.xflags flags	:=	AID.Common.eReturnValues.RawAID  |
										AID.Common.eReturnValues.ACECacheRecords;
		
		AID.MacAppendFromRaw_2Line(dWith_address,Append_Prep_Address1,Append_Prep_AddressLast,Append_RawAID,dAddressCleaned,flags);

		expand_D_rec_layout	tAddressAppended(dAddressCleaned pInput)	:=		  TRANSFORM
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
	   		   
	  //DENORMALIZE the records 
		temp_base_seq denormAID(temp_base_seq l, dAddressAppended r) := TRANSFORM
				SELF.clean_pay_to_rawaid 					:= IF(r.address_type = 1, r.Append_RawAID, l.clean_pay_to_rawaid);
				SELF.clean_pay_to_plan_rawaid			:= IF(r.address_type = 2, r.Append_RawAID, l.clean_pay_to_plan_rawaid);
				SELF.clean_pay_to_aceaid					:= IF(r.address_type = 1, r.Append_AceAID, l.clean_pay_to_aceaid);
				SELF.clean_pay_to_plan_aceaid			:= IF(r.address_type = 2, r.Append_AceAID, l.clean_pay_to_plan_aceaid);
				SELF.Clean_pay_to_prim_range			:= IF(r.address_type = 1	,r.Clean_address.prim_range		,l.Clean_pay_to_prim_range	);
				SELF.Clean_pay_to_predir					:= IF(r.address_type = 1	,r.Clean_address.predir				,l.Clean_pay_to_predir	);
				SELF.Clean_pay_to_prim_name				:= IF(r.address_type = 1	,r.Clean_address.prim_name		,l.Clean_pay_to_prim_name	);
				SELF.Clean_pay_to_addr_suffix			:= IF(r.address_type = 1	,r.Clean_address.addr_suffix	,l.Clean_pay_to_addr_suffix	);
				SELF.Clean_pay_to_postdir					:= IF(r.address_type = 1	,r.Clean_address.postdir			,l.Clean_pay_to_postdir	);
				SELF.Clean_pay_to_unit_desig			:= IF(r.address_type = 1	,r.Clean_address.unit_desig		,l.Clean_pay_to_unit_desig	);
				SELF.Clean_pay_to_sec_range				:= IF(r.address_type = 1	,r.Clean_address.sec_range		,l.Clean_pay_to_sec_range	);
				SELF.Clean_pay_to_p_city_name			:= IF(r.address_type = 1	,r.Clean_address.p_city_name	,l.Clean_pay_to_p_city_name	);
				SELF.Clean_pay_to_st							:= IF(r.address_type = 1	,r.Clean_address.st						,l.Clean_pay_to_st	);
				SELF.Clean_pay_to_zip							:= IF(r.address_type = 1	,r.Clean_address.zip					,l.Clean_pay_to_zip	);
				//SELF.Clean_pay_to_zip4						:= IF(r.address_type = 1	,r.Clean_address.zip4					,l.Clean_pay_to_zip4	);		
				SELF.Clean_pay_to_cart						:= IF(r.address_type = 1	,r.Clean_address.cart					,l.Clean_pay_to_cart	);
				SELF.Clean_pay_to_cr_sort_sz			:= IF(r.address_type = 1	,r.Clean_address.cr_sort_sz		,l.Clean_pay_to_cr_sort_sz	);
				SELF.Clean_pay_to_lot							:= IF(r.address_type = 1	,r.Clean_address.lot					,l.Clean_pay_to_lot	);
				SELF.Clean_pay_to_lot_order				:= IF(r.address_type = 1	,r.Clean_address.lot_order		,l.Clean_pay_to_lot_order	);
				SELF.Clean_pay_to_dbpc						:= IF(r.address_type = 1	,r.Clean_address.dbpc					,l.Clean_pay_to_dbpc	);
				SELF.Clean_pay_to_chk_digit				:= IF(r.address_type = 1	,r.Clean_address.chk_digit		,l.Clean_pay_to_chk_digit	);
				SELF.Clean_pay_to_rec_type				:= IF(r.address_type = 1	,r.Clean_address.rec_type			,l.Clean_pay_to_rec_type	);
				SELF.Clean_pay_to_fips_st					:= IF(r.address_type = 1	,r.Clean_address.fips_st		  ,l.Clean_pay_to_fips_st	);
				SELF.Clean_pay_to_fips_county			:= IF(r.address_type = 1	,r.Clean_address.fips_county  ,l.Clean_pay_to_fips_county	);
				SELF.Clean_pay_to_geo_lat					:= IF(r.address_type = 1	,r.Clean_address.geo_lat			,l.Clean_pay_to_geo_lat	);
				SELF.Clean_pay_to_geo_long				:= IF(r.address_type = 1	,r.Clean_address.geo_long			,l.Clean_pay_to_geo_long	);
				SELF.Clean_pay_to_msa							:= IF(r.address_type = 1	,r.Clean_address.msa					,l.Clean_pay_to_msa	);
				SELF.Clean_pay_to_geo_blk					:= IF(r.address_type = 1	,r.Clean_address.geo_blk			,l.Clean_pay_to_geo_blk	);
				SELF.Clean_pay_to_geo_match				:= IF(r.address_type = 1	,r.Clean_address.geo_match		,l.Clean_pay_to_geo_match	);
				SELF.Clean_pay_to_err_stat				:= IF(r.address_type = 1	,r.Clean_address.err_stat			,l.Clean_pay_to_err_stat		);
				SELF.Clean_pay_to_plan_prim_range	:= IF(r.address_type = 2	,r.Clean_address.prim_range		,l.Clean_pay_to_plan_prim_range	);
				SELF.Clean_pay_to_plan_predir			:= IF(r.address_type = 2	,r.Clean_address.predir				,l.Clean_pay_to_plan_predir	);
				SELF.Clean_pay_to_plan_prim_name	:= IF(r.address_type = 2	,r.Clean_address.prim_name		,l.Clean_pay_to_plan_prim_name	);
				SELF.Clean_pay_to_plan_addr_suffix:= IF(r.address_type = 2	,r.Clean_address.addr_suffix	,l.Clean_pay_to_plan_addr_suffix	);
				SELF.Clean_pay_to_plan_postdir		:= IF(r.address_type = 2	,r.Clean_address.postdir			,l.Clean_pay_to_plan_postdir	);
				SELF.Clean_pay_to_plan_unit_desig	:= IF(r.address_type = 2	,r.Clean_address.unit_desig		,l.Clean_pay_to_plan_unit_desig	);
				SELF.Clean_pay_to_plan_sec_range	:= IF(r.address_type = 2	,r.Clean_address.sec_range		,l.Clean_pay_to_plan_sec_range	);
				SELF.Clean_pay_to_plan_p_city_name:= IF(r.address_type = 2	,r.Clean_address.p_city_name	,l.Clean_pay_to_plan_p_city_name	);
				SELF.Clean_pay_to_plan_st					:= IF(r.address_type = 2	,r.Clean_address.st						,l.Clean_pay_to_plan_st	);
				SELF.Clean_pay_to_plan_zip				:= IF(r.address_type = 2	,r.Clean_address.zip					,l.Clean_pay_to_plan_zip	);
				//SELF.Clean_pay_to_plan_zip4				:= IF(r.address_type = 2	,r.Clean_address.zip4					,l.Clean_pay_to_plan_zip4	);		
				SELF.Clean_pay_to_plan_cart				:= IF(r.address_type = 2	,r.Clean_address.cart					,l.Clean_pay_to_plan_cart	);
				SELF.Clean_pay_to_plan_cr_sort_sz	:= IF(r.address_type = 2	,r.Clean_address.cr_sort_sz		,l.Clean_pay_to_plan_cr_sort_sz	);
				SELF.Clean_pay_to_plan_lot				:= IF(r.address_type = 2	,r.Clean_address.lot					,l.Clean_pay_to_plan_lot	);
				SELF.Clean_pay_to_plan_lot_order	:= IF(r.address_type = 2	,r.Clean_address.lot_order		,l.Clean_pay_to_plan_lot_order	);
				SELF.Clean_pay_to_plan_dbpc				:= IF(r.address_type = 2	,r.Clean_address.dbpc					,l.Clean_pay_to_plan_dbpc	);
				SELF.Clean_pay_to_plan_chk_digit	:= IF(r.address_type = 2	,r.Clean_address.chk_digit		,l.Clean_pay_to_plan_chk_digit	);
				SELF.Clean_pay_to_plan_rec_type		:= IF(r.address_type = 2	,r.Clean_address.rec_type			,l.Clean_pay_to_plan_rec_type	);
				SELF.Clean_pay_to_plan_fips_st		:= IF(r.address_type = 2	,r.Clean_address.fips_st		  ,l.Clean_pay_to_plan_fips_st	);
				SELF.Clean_pay_to_plan_fips_county:= IF(r.address_type = 2	,r.Clean_address.fips_county  ,l.Clean_pay_to_plan_fips_county	);
				SELF.Clean_pay_to_plan_geo_lat		:= IF(r.address_type = 2	,r.Clean_address.geo_lat			,l.Clean_pay_to_plan_geo_lat	);
				SELF.Clean_pay_to_plan_geo_long		:= IF(r.address_type = 2	,r.Clean_address.geo_long			,l.Clean_pay_to_plan_geo_long	);
				SELF.Clean_pay_to_plan_msa				:= IF(r.address_type = 2	,r.Clean_address.msa					,l.Clean_pay_to_plan_msa	);
				SELF.Clean_pay_to_plan_geo_blk		:= IF(r.address_type = 2	,r.Clean_address.geo_blk			,l.Clean_pay_to_plan_geo_blk	);
				SELF.Clean_pay_to_plan_geo_match	:= IF(r.address_type = 2	,r.Clean_address.geo_match		,l.Clean_pay_to_plan_geo_match	);
				SELF.Clean_pay_to_plan_err_stat		:= IF(r.address_type = 2	,r.Clean_address.err_stat			,l.Clean_pay_to_plan_err_stat		);
				SELF            := l;
		END;
	   
	  denormRecs :=  DENORMALIZE(temp_base_seq,all_address,
								  LEFT.unique_id = RIGHT.unique_id,
								  denormAID(LEFT,RIGHT), LOCAL);
								         
		final_file	:= PROJECT(denormRecs, Emdeon.layouts.base.d_record);
		RETURN final_file; 
	END;
END;
	   