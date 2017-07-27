IMPORT ut, lib_fileservices, _control, lib_STRINGlib, _Validate, AID, did_add, Enclarity_Facility_Sanctions;
			
cleanUpper(STRING s) := FUNCTION
			RETURN StringLib.StringCleanSpaces(StringLib.StringToUpperCase(s));
END;
	
EXPORT Proc_Get_AID	:= MODULE

	EXPORT Facility_sanctions(DATASET(Enclarity_Facility_Sanctions.Layouts.Base.Facility_Sanctions)	pBaseFile) := FUNCTION
		
		expand_base_layout	:= RECORD
			UNSIGNED8			unique_id;
			UNSIGNED4			address_type;
			Enclarity_Facility_Sanctions.Layouts.base.facility_sanctions;
			Enclarity_Facility_Sanctions.Layouts.appended.temp_address clean_address;
			STRING100		append_prep_address1;
			STRING50		append_prep_addresslast;
			AID.Common.xAID							        Append_RawAID;
			AID.Common.xAID							        Append_AceAID;
			UNSIGNED1	zero	:= 0;
		END;

		//expand layout for NORMALIZE/DENORMALIZE address fields
		expand_base_layout expand_rec(pBaseFile L) := TRANSFORM
			SELF := L;
			SELF := [];
		END;

		temp_base_recs := PROJECT(pBaseFile,expand_rec(LEFT));	
				
		//assign a unique_id for NORMALIZE/DENORMALIZE
		ut.MAC_Sequence_Records(temp_base_recs,unique_id,temp_base_seq);

		expand_base_layout tNormalizeAddress(temp_base_seq L, UNSIGNED cnt) := TRANSFORM, SKIP ((cnt = 2 AND L.prac1_secondary_address = '') OR (cnt = 3 AND L.bill1_primary_address = '') OR (cnt = 4 AND L.bill1_secondary_address = ''))   
			SELF.unique_id						 		:= L.unique_id;
			SELF.address_type			 				:= cnt;
			SELF.Append_Prep_Address1			:= CHOOSE(cnt,cleanUpper(L.prac1_primary_address),cleanUpper(L.prac1_secondary_address),cleanUpper(L.bill1_primary_address),cleanUpper(L.bill1_secondary_address));
			pre_Append_Prep_AddressLast 	:= CHOOSE(cnt,cleanUpper(L.prac1_city) + ', ' + cleanUpper(L.prac1_state) + ' ' + L.prac1_zip,
																								  cleanUpper(L.prac1_city) + ', ' + cleanUpper(L.prac1_state) + ' ' + L.prac1_zip,
																									cleanUpper(L.bill1_city) + ', ' + cleanUpper(L.bill1_state) + ' ' + L.bill1_zip,
																									cleanUpper(L.bill1_city) + ', ' + cleanUpper(L.bill1_state) + ' ' + L.bill1_zip);
			SELF.Append_Prep_AddressLast	:= IF(pre_Append_Prep_AddressLast = ',','',pre_Append_Prep_AddressLast);
			SELF													:= L;
			SELF 													:= [];
		END;
  
		//NORMALIZE the records to populate the address information for all addresses
		dAddressPrep	:= NORMALIZE(temp_base_seq,4,tNormalizeAddress(LEFT,counter));
      
		HasAddress	:=	//TRIM(dAddressPrep.Append_Prep_Address1,LEFT,RIGHT)    != '' AND
										TRIM(dAddressPrep.Append_Prep_AddressLast,LEFT,RIGHT) != '';
										
		dWith_address			:= dAddressPrep(HasAddress);
		dWithout_address	:= dAddressPrep(NOT(HasAddress));
			
		AID.Common.xflags flags	:=	AID.Common.eReturnValues.RawAID  |
																AID.Common.eReturnValues.ACECacheRecords;
		
		AID.MacAppendFromRaw_2Line(dWith_address,Append_Prep_Address1,Append_Prep_AddressLast,Append_RawAID,dAddressCleaned,flags);
		
		expand_base_layout	tAddressAppended(dAddressCleaned pInput)	:=		  TRANSFORM
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
				SELF.clean_prac1_rawaid 			:= IF(r.address_type = 1	,r.Append_RawAID, l.clean_prac1_rawaid);
				SELF.clean_prac2_rawaid				:= IF(r.address_type = 2	,r.Append_RawAID, l.clean_prac2_rawaid);
				SELF.clean_bill1_rawaid 			:= IF(r.address_type = 3	,r.Append_RawAID, l.clean_bill1_rawaid);
				SELF.clean_bill2_rawaid				:= IF(r.address_type = 4	,r.Append_RawAID, l.clean_bill2_rawaid);			
				SELF.clean_prac1_aceaid				:= IF(r.address_type = 1	,r.Append_AceAID, l.clean_prac1_aceaid);
				SELF.clean_prac2_aceaid				:= IF(r.address_type = 2	,r.Append_AceAID, l.clean_prac2_aceaid);
				SELF.clean_bill1_aceaid				:= IF(r.address_type = 3	,r.Append_AceAID, l.clean_bill1_aceaid);
				SELF.clean_bill2_aceaid				:= IF(r.address_type = 4	,r.Append_AceAID, l.clean_bill2_aceaid);		
				SELF.clean_prac1_prim_range		:= IF(r.address_type = 1	,r.Clean_address.prim_range	,l.clean_prac1_prim_range	);
				SELF.clean_prac1_predir				:= IF(r.address_type = 1	,r.Clean_address.predir			,l.clean_prac1_predir	);
				SELF.clean_prac1_prim_name		:= IF(r.address_type = 1	,r.Clean_address.prim_name	,l.clean_prac1_prim_name	);
				SELF.clean_prac1_addr_suffix	:= IF(r.address_type = 1	,r.Clean_address.addr_suffix,l.clean_prac1_addr_suffix	);
				SELF.clean_prac1_postdir			:= IF(r.address_type = 1	,r.Clean_address.postdir		,l.clean_prac1_postdir	);
				SELF.clean_prac1_unit_desig		:= IF(r.address_type = 1	,r.Clean_address.unit_desig	,l.clean_prac1_unit_desig	);
				SELF.clean_prac1_sec_range		:= IF(r.address_type = 1	,r.Clean_address.sec_range	,l.clean_prac1_sec_range	);
				SELF.clean_prac1_p_city_name	:= IF(r.address_type = 1	,r.Clean_address.p_city_name,l.clean_prac1_p_city_name	);
				SELF.clean_prac1_v_city_name	:= IF(r.address_type = 1	,r.Clean_address.v_city_name,l.clean_prac1_v_city_name	);
				SELF.clean_prac1_st						:= IF(r.address_type = 1	,r.Clean_address.st					,l.clean_prac1_st	);
				SELF.clean_prac1_zip					:= IF(r.address_type = 1	,r.Clean_address.zip				,l.clean_prac1_zip	);
				SELF.clean_prac1_zip4					:= IF(r.address_type = 1	,r.Clean_address.zip4				,l.clean_prac1_zip4	);		
				SELF.clean_prac1_cart					:= IF(r.address_type = 1	,r.Clean_address.cart				,l.clean_prac1_cart	);
				SELF.clean_prac1_cr_sort_sz		:= IF(r.address_type = 1	,r.Clean_address.cr_sort_sz	,l.clean_prac1_cr_sort_sz	);
				SELF.clean_prac1_lot					:= IF(r.address_type = 1	,r.Clean_address.lot				,l.clean_prac1_lot	);
				SELF.clean_prac1_lot_order		:= IF(r.address_type = 1	,r.Clean_address.lot_order	,l.clean_prac1_lot_order	);
				SELF.clean_prac1_dbpc					:= IF(r.address_type = 1	,r.Clean_address.dbpc				,l.clean_prac1_dbpc	);
				SELF.clean_prac1_chk_digit		:= IF(r.address_type = 1	,r.Clean_address.chk_digit	,l.clean_prac1_chk_digit	);
				SELF.clean_prac1_rec_type			:= IF(r.address_type = 1	,r.Clean_address.rec_type		,l.clean_prac1_rec_type	);
				SELF.clean_prac1_fips_st			:= IF(r.address_type = 1	,r.Clean_address.fips_st		,l.clean_prac1_fips_st	);
				SELF.clean_prac1_fips_county	:= IF(r.address_type = 1	,r.Clean_address.fips_county,l.clean_prac1_fips_county	);
				SELF.clean_prac1_geo_lat			:= IF(r.address_type = 1	,r.Clean_address.geo_lat		,l.clean_prac1_geo_lat	);
				SELF.clean_prac1_geo_long			:= IF(r.address_type = 1	,r.Clean_address.geo_long		,l.clean_prac1_geo_long	);
				SELF.clean_prac1_msa					:= IF(r.address_type = 1	,r.Clean_address.msa				,l.clean_prac1_msa	);
				SELF.clean_prac1_geo_blk			:= IF(r.address_type = 1	,r.Clean_address.geo_blk		,l.clean_prac1_geo_blk	);
				SELF.clean_prac1_geo_match		:= IF(r.address_type = 1	,r.Clean_address.geo_match	,l.clean_prac1_geo_match	);
				SELF.clean_prac1_err_stat			:= IF(r.address_type = 1	,r.Clean_address.err_stat		,l.clean_prac1_err_stat		);
				SELF.clean_prac2_prim_range		:= IF(r.address_type = 2	,r.Clean_address.prim_range	,l.clean_prac2_prim_range	);
				SELF.clean_prac2_predir				:= IF(r.address_type = 2	,r.Clean_address.predir			,l.clean_prac2_predir	);
				SELF.clean_prac2_prim_name		:= IF(r.address_type = 2	,r.Clean_address.prim_name	,l.clean_prac2_prim_name	);
				SELF.clean_prac2_addr_suffix	:= IF(r.address_type = 2	,r.Clean_address.addr_suffix,l.clean_prac2_addr_suffix	);
				SELF.clean_prac2_postdir			:= IF(r.address_type = 2	,r.Clean_address.postdir		,l.clean_prac2_postdir	);
				SELF.clean_prac2_unit_desig		:= IF(r.address_type = 2	,r.Clean_address.unit_desig	,l.clean_prac2_unit_desig	);
				SELF.clean_prac2_sec_range		:= IF(r.address_type = 2	,r.Clean_address.sec_range	,l.clean_prac2_sec_range	);
				SELF.clean_prac2_p_city_name	:= IF(r.address_type = 2	,r.Clean_address.p_city_name,l.clean_prac2_p_city_name	);
				SELF.clean_prac2_v_city_name	:= IF(r.address_type = 2	,r.Clean_address.v_city_name,l.clean_prac2_v_city_name	);
				SELF.clean_prac2_st						:= IF(r.address_type = 2	,r.Clean_address.st					,l.clean_prac2_st	);
				SELF.clean_prac2_zip					:= IF(r.address_type = 2	,r.Clean_address.zip				,l.clean_prac2_zip	);
				SELF.clean_prac2_zip4					:= IF(r.address_type = 2	,r.Clean_address.zip4				,l.clean_prac2_zip4	);		
				SELF.clean_prac2_cart					:= IF(r.address_type = 2	,r.Clean_address.cart				,l.clean_prac2_cart	);
				SELF.clean_prac2_cr_sort_sz		:= IF(r.address_type = 2	,r.Clean_address.cr_sort_sz	,l.clean_prac2_cr_sort_sz	);
				SELF.clean_prac2_lot					:= IF(r.address_type = 2	,r.Clean_address.lot				,l.clean_prac2_lot	);
				SELF.clean_prac2_lot_order		:= IF(r.address_type = 2	,r.Clean_address.lot_order	,l.clean_prac2_lot_order	);
				SELF.clean_prac2_dbpc					:= IF(r.address_type = 2	,r.Clean_address.dbpc				,l.clean_prac2_dbpc	);
				SELF.clean_prac2_chk_digit		:= IF(r.address_type = 2	,r.Clean_address.chk_digit	,l.clean_prac2_chk_digit	);
				SELF.clean_prac2_rec_type			:= IF(r.address_type = 2	,r.Clean_address.rec_type		,l.clean_prac2_rec_type	);
				SELF.clean_prac2_fips_st			:= IF(r.address_type = 2	,r.Clean_address.fips_st	  ,l.clean_prac2_fips_st	);
				SELF.clean_prac2_fips_county	:= IF(r.address_type = 2	,r.Clean_address.fips_county,l.clean_prac2_fips_county	);
				SELF.clean_prac2_geo_lat			:= IF(r.address_type = 2	,r.Clean_address.geo_lat		,l.clean_prac2_geo_lat	);
				SELF.clean_prac2_geo_long			:= IF(r.address_type = 2	,r.Clean_address.geo_long		,l.clean_prac2_geo_long	);
				SELF.clean_prac2_msa					:= IF(r.address_type = 2	,r.Clean_address.msa				,l.clean_prac2_msa	);
				SELF.clean_prac2_geo_blk			:= IF(r.address_type = 2	,r.Clean_address.geo_blk		,l.clean_prac2_geo_blk	);
				SELF.clean_prac2_geo_match		:= IF(r.address_type = 2	,r.Clean_address.geo_match	,l.clean_prac2_geo_match	);
				SELF.clean_prac2_err_stat			:= IF(r.address_type = 2	,r.Clean_address.err_stat		,l.clean_prac2_err_stat		);			
				SELF.clean_bill1_prim_range		:= IF(r.address_type = 3	,r.Clean_address.prim_range	,l.clean_bill1_prim_range	);
				SELF.clean_bill1_predir				:= IF(r.address_type = 3	,r.Clean_address.predir			,l.clean_bill1_predir	);
				SELF.clean_bill1_prim_name		:= IF(r.address_type = 3	,r.Clean_address.prim_name	,l.clean_bill1_prim_name	);
				SELF.clean_bill1_addr_suffix	:= IF(r.address_type = 3	,r.Clean_address.addr_suffix,l.clean_bill1_addr_suffix	);
				SELF.clean_bill1_postdir			:= IF(r.address_type = 3	,r.Clean_address.postdir		,l.clean_bill1_postdir	);
				SELF.clean_bill1_unit_desig		:= IF(r.address_type = 3	,r.Clean_address.unit_desig	,l.clean_bill1_unit_desig	);
				SELF.clean_bill1_sec_range		:= IF(r.address_type = 3	,r.Clean_address.sec_range	,l.clean_bill1_sec_range	);
				SELF.clean_bill1_p_city_name	:= IF(r.address_type = 3	,r.Clean_address.p_city_name,l.clean_bill1_p_city_name	);
				SELF.clean_bill1_v_city_name	:= IF(r.address_type = 3	,r.Clean_address.v_city_name,l.clean_bill1_v_city_name	);
				SELF.clean_bill1_st						:= IF(r.address_type = 3	,r.Clean_address.st					,l.clean_bill1_st	);
				SELF.clean_bill1_zip					:= IF(r.address_type = 3	,r.Clean_address.zip				,l.clean_bill1_zip	);
				SELF.clean_bill1_zip4					:= IF(r.address_type = 3	,r.Clean_address.zip4				,l.clean_bill1_zip4	);		
				SELF.clean_bill1_cart					:= IF(r.address_type = 3	,r.Clean_address.cart				,l.clean_bill1_cart	);
				SELF.clean_bill1_cr_sort_sz		:= IF(r.address_type = 3	,r.Clean_address.cr_sort_sz	,l.clean_bill1_cr_sort_sz	);
				SELF.clean_bill1_lot					:= IF(r.address_type = 3	,r.Clean_address.lot				,l.clean_bill1_lot	);
				SELF.clean_bill1_lot_order		:= IF(r.address_type = 3	,r.Clean_address.lot_order	,l.clean_bill1_lot_order	);
				SELF.clean_bill1_dbpc					:= IF(r.address_type = 3	,r.Clean_address.dbpc				,l.clean_bill1_dbpc	);
				SELF.clean_bill1_chk_digit		:= IF(r.address_type = 3	,r.Clean_address.chk_digit	,l.clean_bill1_chk_digit	);
				SELF.clean_bill1_rec_type			:= IF(r.address_type = 3	,r.Clean_address.rec_type		,l.clean_bill1_rec_type	);
				SELF.clean_bill1_fips_st			:= IF(r.address_type = 3	,r.Clean_address.fips_st		,l.clean_bill1_fips_st	);
				SELF.clean_bill1_fips_county	:= IF(r.address_type = 3	,r.Clean_address.fips_county,l.clean_bill1_fips_county	);
				SELF.clean_bill1_geo_lat			:= IF(r.address_type = 3	,r.Clean_address.geo_lat		,l.clean_bill1_geo_lat	);
				SELF.clean_bill1_geo_long			:= IF(r.address_type = 3	,r.Clean_address.geo_long		,l.clean_bill1_geo_long	);
				SELF.clean_bill1_msa					:= IF(r.address_type = 3	,r.Clean_address.msa				,l.clean_bill1_msa	);
				SELF.clean_bill1_geo_blk			:= IF(r.address_type = 3	,r.Clean_address.geo_blk		,l.clean_bill1_geo_blk	);
				SELF.clean_bill1_geo_match		:= IF(r.address_type = 3	,r.Clean_address.geo_match	,l.clean_bill1_geo_match	);
				SELF.clean_bill1_err_stat			:= IF(r.address_type = 3	,r.Clean_address.err_stat		,l.clean_bill1_err_stat		);
				SELF.clean_bill2_prim_range		:= IF(r.address_type = 4	,r.Clean_address.prim_range	,l.clean_bill2_prim_range	);
				SELF.clean_bill2_predir				:= IF(r.address_type = 4	,r.Clean_address.predir			,l.clean_bill2_predir	);
				SELF.clean_bill2_prim_name		:= IF(r.address_type = 4	,r.Clean_address.prim_name	,l.clean_bill2_prim_name	);
				SELF.clean_bill2_addr_suffix	:= IF(r.address_type = 4	,r.Clean_address.addr_suffix,l.clean_bill2_addr_suffix	);
				SELF.clean_bill2_postdir			:= IF(r.address_type = 4	,r.Clean_address.postdir		,l.clean_bill2_postdir	);
				SELF.clean_bill2_unit_desig		:= IF(r.address_type = 4	,r.Clean_address.unit_desig	,l.clean_bill2_unit_desig	);
				SELF.clean_bill2_sec_range		:= IF(r.address_type = 4	,r.Clean_address.sec_range	,l.clean_bill2_sec_range	);
				SELF.clean_bill2_p_city_name	:= IF(r.address_type = 4	,r.Clean_address.p_city_name,l.clean_bill2_p_city_name	);
				SELF.clean_bill2_v_city_name	:= IF(r.address_type = 4	,r.Clean_address.v_city_name,l.clean_bill2_v_city_name	);
				SELF.clean_bill2_st						:= IF(r.address_type = 4	,r.Clean_address.st					,l.clean_bill2_st	);
				SELF.clean_bill2_zip					:= IF(r.address_type = 4	,r.Clean_address.zip				,l.clean_bill2_zip	);
				SELF.clean_bill2_zip4					:= IF(r.address_type = 4	,r.Clean_address.zip4				,l.clean_bill2_zip4	);		
				SELF.clean_bill2_cart					:= IF(r.address_type = 4	,r.Clean_address.cart				,l.clean_bill2_cart	);
				SELF.clean_bill2_cr_sort_sz		:= IF(r.address_type = 4	,r.Clean_address.cr_sort_sz	,l.clean_bill2_cr_sort_sz	);
				SELF.clean_bill2_lot					:= IF(r.address_type = 4	,r.Clean_address.lot				,l.clean_bill2_lot	);
				SELF.clean_bill2_lot_order		:= IF(r.address_type = 4	,r.Clean_address.lot_order	,l.clean_bill2_lot_order	);
				SELF.clean_bill2_dbpc					:= IF(r.address_type = 4	,r.Clean_address.dbpc				,l.clean_bill2_dbpc	);
				SELF.clean_bill2_chk_digit		:= IF(r.address_type = 4	,r.Clean_address.chk_digit	,l.clean_bill2_chk_digit	);
				SELF.clean_bill2_rec_type			:= IF(r.address_type = 4	,r.Clean_address.rec_type		,l.clean_bill2_rec_type	);
				SELF.clean_bill2_fips_st			:= IF(r.address_type = 4	,r.Clean_address.fips_st	  ,l.clean_bill2_fips_st	);
				SELF.clean_bill2_fips_county	:= IF(r.address_type = 4	,r.Clean_address.fips_county,l.clean_bill2_fips_county	);
				SELF.clean_bill2_geo_lat			:= IF(r.address_type = 4	,r.Clean_address.geo_lat		,l.clean_bill2_geo_lat	);
				SELF.clean_bill2_geo_long			:= IF(r.address_type = 4	,r.Clean_address.geo_long		,l.clean_bill2_geo_long	);
				SELF.clean_bill2_msa					:= IF(r.address_type = 4	,r.Clean_address.msa				,l.clean_bill2_msa	);
				SELF.clean_bill2_geo_blk			:= IF(r.address_type = 4	,r.Clean_address.geo_blk		,l.clean_bill2_geo_blk	);
				SELF.clean_bill2_geo_match		:= IF(r.address_type = 4	,r.Clean_address.geo_match	,l.clean_bill2_geo_match	);
				SELF.clean_bill2_err_stat			:= IF(r.address_type = 4	,r.Clean_address.err_stat		,l.clean_bill2_err_stat		);
				SELF          							  := l;
		END;

	  denormRecs :=  DENORMALIZE(sort(distribute(temp_base_seq,hash(unique_id)),unique_id,local),sort(distribute(all_address,hash(unique_id)),unique_id,local),
								  LEFT.unique_id = RIGHT.unique_id,
								  denormAID(LEFT,RIGHT), LOCAL);
								         
		final_file	:= PROJECT(denormRecs, Enclarity_Facility_Sanctions.layouts.base.facility_sanctions);	
		RETURN final_file;
	END;
END;
	   