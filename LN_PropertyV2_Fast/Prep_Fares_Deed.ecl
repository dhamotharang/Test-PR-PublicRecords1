
import ut, nid, aid, property,ln_propertyv2,LN_PropertyV2_Fast,ln_functions;

// Jira DF-11862 - added isfast parameter to name persist file accordingly in order to run continuous delta
EXPORT Prep_Fares_Deed (string pVersionDate,dataset(recordof(LN_PropertyV2_Fast.Layout_Raw_Fares.Deed)) ds_deed, boolean isFast) := MODULE
	SHARED common	:= MODULE

			EXPORT ds_deed_mod := record
				LN_PropertyV2.Layout_Raw_Fares.Clean_Address_Deed;
				string5   vendor										:= '';
				string1   which_orig								:= '';
				string70	nameasis 									:= '';
				string2   source_code								:= '';
				string80 	cname 										:= '';
				string1		conjunctive_name_seq 			:= '';
				string100	append_prepaddr1 					:= '';
				string50	append_prepaddr2 					:= '';
				string8 	dt_first_seen							:= ''; 
				string8 	dt_last_seen							:= ''; 
				string8 	dt_vendor_first_reported	:= ''; 
				string8 	dt_vendor_last_reported		:= '';
				unsigned8	nid												:= 0;
				string1		ln_entity_type						:= '';
				string70  mailing_street											:= ''; 
				string6   mailing_unit_number									:= ''; 
				string51  mailing_csz													:= ''; 
				string70  seller_mailing_full_street_address 	:= ''; 
				string6   seller_mailing_address_unit_number	:= ''; 
				string51  seller_mailing_address_citystatezip	:= '';
				string1		vendor_source_flag									:= '';
				string3	  ln_buyer_mailing_country_code				:= '';
				string3	  ln_seller_mailing_country_code			:= '';
				string100 raw_file_name;
			end;
			ds_fips_lookup 	:= LN_PropertyV2.File_Tax_Supplemental_Coverage_In;
			EXPORT ds_sort_fips_lookup := sort(distribute(ds_fips_lookup, hash(fips_code)), fips_code, local);
	
	END;
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Create Unmatched Assessment Fips Codes File/////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	EXPORT writeUnmatchedFipsFile	:= FUNCTION
		ds_sort_deed 				:= sort(distribute(ds_deed, hash(fips)), fips, local);

			ds_deed findFips(ds_sort_deed l, common.ds_sort_fips_lookup r):= transform
				self := l;
			end;

			unmatched_fips := join(ds_sort_deed, common.ds_sort_fips_lookup,
													left.fips = right.fips_code,
													findFips(left, right), left only, local);
	
			dslayout_unmatched_fips := record
				string5 fips_code;
				string2 crlf;
			end;
	
			dslayout_unmatched_fips findUnMatched(unmatched_fips l):= transform
				self.fips_code := l.fips;
				self := l;
			end;
	
		unmatched_fips_project := dedup(sort(project(unmatched_fips, findUnMatched(left)), record, local), record, local);
		//vFilePrefix					:= LN_Propertyv2.cluster	+	'in::ln_propertyv2::'	+	pVersionDate;
		vFilePrefix					:=  LN_PropertyV2_Fast.Filenames.prep.prefix +	pVersionDate;	
		bldUnmatch					:= output(unmatched_fips_project 	,,	vFilePrefix	+	'::deed_unmatched' 	,__compressed__);
		RETURN bldUnmatch;
	END;
	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	//Create Deed File/////////////////////////////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////////////////////	
	EXPORT deed 	:= MODULE	
    //ds_deed 				:= LN_PropertyV2.File_Raw_Fares_Deed;
    //Add Sequence Number///////////////////////////////////////////////////////////////////////////////////////////////
		{LN_PropertyV2.Layout_Raw_Fares.Clean_Address_Deed, string100 raw_file_name} seqDeed(ds_deed l, unsigned4 cnt):= transform

					maxDeedFaresID													:= max(
																													max(LN_PropertyV2.File_Fares_Deeds_in(fares_id[1..2]	=	'RD'), (unsigned)fares_id[3..]),
																													max(LN_PropertyV2_Fast.Files.prep.deed_mortg(ln_fares_id[1..2] = 'RD'), (unsigned)ln_fares_id[3..])
																													)	:	global;
					unsigned	vFaresID											:= maxDeedFaresID +	cnt;
				self.fares_id 														:= 'RD' +	intformat(vFaresID,10,1);
				self.fares_source 												:= 'RD';
				self.owner_buyer_last_name 								:= if(StringLib.StringToUppercase(trim(l.owner_buyer_last_name[1..3], left, right)) = 'SG ',
																												trim(l.owner_buyer_last_name, left, right)[3..30],
																											if(StringLib.StringToUppercase(trim(l.owner_buyer_last_name, left, right)) = 'SG',
																												'',
																												trim(l.owner_buyer_last_name, left, right)));
				self.owner_buyer_first_name 							:= if(StringLib.StringToUppercase(trim(l.owner_buyer_first_name, left, right)[1..3]) = 'SG ',
																												trim(l.owner_buyer_first_name, left, right)[3..30],
																											if(StringLib.StringToUppercase(trim(l.owner_buyer_first_name, left, right)) = 'SG',
																												'',
																												trim(l.owner_buyer_first_name, left, right)));
				self.owner_carrier_code 									:= l.carrier_code;
				self.prop_apartment_unit 									:= l.prop_apt_unit_num;
				self.prop_carrier_code 										:= l.carrier_code1;
				self.seller_name 													:= if(StringLib.StringToUppercase(trim(l.seller_name, left, right)[1..3]) = 'SG ',
																												trim(l.seller_name, left, right)[3..30],
																											if(StringLib.StringToUppercase(trim(l.seller_name, left, right)) = 'SG',
																												'',
																												trim(l.seller_name, left, right)));
				self.prior_book_and_page 									:= l.prior_book_page;
				self.resale_new_construction_m_resale_n_ 	:= l.resale_new_construction_m_resale_n_new_const;
				self.cash_mortgage_purchase_q_cash_r_mor 	:= l.cash_mortgage_purchase_q_cash_r_mortgage;
				self.apn_parcel_number_unformatted 				:= regexreplace(' ', l.apn_parcel_number_unformatted,'');
				self.irs_apn 															:= '';
				self.name1																:= '';	
				self.name1_title													:= '';
				self.name1_first													:= '';
				self.name1_middle													:= '';
				self.name1_last														:= '';
				self.name1_suffix													:= '';
				self.name2																:= '';
				self.name2_title													:= '';
				self.name2_first													:= '';
				self.name2_middle													:= '';
				self.name2_last														:= '';
				self.name2_suffix													:= '';
				self.name1_company												:= '';
				self.name2_company												:= '';
				self.seller1															:= '';	
				self.seller1_title												:= '';
				self.seller1_first												:= '';
				self.seller1_middle												:= '';
				self.seller1_last													:= '';
				self.seller1_suffix												:= '';
				self.seller2															:= '';
				self.seller2_title												:= '';
				self.seller2_first												:= '';
				self.seller2_middle												:= '';
				self.seller2_last													:= '';
				self.seller2_suffix												:= '';
				self.seller1_company											:= '';
				self.seller2_company											:= '';		
				self.own_prim_range												:= '';
				self.own_predir														:= '';
				self.own_prim_name												:= '';
				self.own_suffix														:= '';
				self.own_postdir													:= '';
				self.own_unit_desig												:= '';
				self.own_sec_range												:= '';
				self.own_p_city_name											:= '';
				self.own_v_city_name											:= '';
				self.own_ace_state												:= '';
				self.own_ace_zip													:= '';
				self.own_ace_zip4													:= '';
				self.own_cart															:= '';
				self.own_cr_sort_sz												:= '';
				self.own_lot															:= '';
				self.own_lot_order												:= '';
				self.own_dbpc															:= '';
				self.own_chk_digit												:= '';
				self.own_ace_rec_type											:= '';
				self.own_ace_county												:= '';
				self.own_geo_lat													:= '';
				self.own_geo_long													:= '';
				self.own_ace_msa													:= '';
				self.own_geo_blk													:= '';
				self.own_geo_match												:= '';
				self.own_err_stat													:= '';
				self.append_prep_owner_address1 					:= '';
				self.append_prep_owner_address2 					:= '';
				self.prop_prim_range											:= '';
				self.prop_predir													:= '';
				self.prop_prim_name												:= '';
				self.prop_suffix													:= '';
				self.prop_postdir													:= '';
				self.prop_unit_desig											:= '';
				self.prop_sec_range												:= '';
				self.prop_p_city_name											:= '';
				self.prop_v_city_name											:= '';
				self.prop_ace_state												:= '';
				self.prop_ace_zip													:= '';
				self.prop_ace_zip4												:= '';
				self.prop_cart														:= '';
				self.prop_cr_sort_sz											:= '';
				self.prop_lot															:= '';
				self.prop_lot_order												:= '';
				self.prop_dbpc														:= '';
				self.prop_chk_digit												:= '';
				self.prop_ace_rec_type										:= '';
				self.prop_ace_county											:= '';
				self.prop_geo_lat													:= '';
				self.prop_geo_long												:= '';
				self.prop_ace_msa													:= '';
				self.prop_geo_blk													:= '';
				self.prop_geo_match												:= '';
				self.prop_err_stat												:= '';
				self.append_prep_property_address1 				:= '';
				self.append_prep_property_address2 				:= '';
				self.process_date													:= pVersionDate; //ut.GetDate; removing getdate and using version parameter, Jira DF-16881
				self																			:= l;
			end;

		ds_deed_sequence := project(ds_deed, seqDeed(left, counter)) : independent; //DF-19358 because independent was added to LN_PropertyV2.Append_AID

    //Prep Addresses for Cleaner & Add Fares ID
		{LN_PropertyV2.Layout_Raw_Fares.Clean_Address_Deed, string100 raw_file_name}	addOwnName(ds_deed_sequence l):= transform
	
				v_first 			:= trim(regexreplace(' +', stringlib.stringfilter(l.owner_buyer_first_name,'ABCDEFGHIJKLMNOPQTRSTUVWXYZ1234567890&. '), ' '), left, right);
				v_last				:= trim(regexreplace(' +', stringlib.stringfilter(l.owner_buyer_last_name,'ABCDEFGHIJKLMNOPQTRSTUVWXYZ1234567890&. '),' '), left, right);
				v_full_name		:= if(length(trim(v_last, left, right))<30,
														trim(trim(v_last, left, right)+' '+trim(v_first, left, right), left, right),
														trim(trim(v_last, left, right)+trim(v_first, left, right), left, right));
				
				v_seller			:= trim(regexreplace(' +', stringlib.stringfilter(l.seller_name,'ABCDEFGHIJKLMNOPQTRSTUVWXYZ1234567890&. '),' '), left, right);

				owner_name_clean 	:= if(ln_propertyV2.Functions.fIsCompany(v_full_name) or trim(v_full_name, left, right)[1..4]='DBA ',
																v_full_name,
																trim(trim(v_last, left, right) + ', ' + trim(v_first, left, right), left, right));
				seller_name_clean := v_seller;

        self.append_property_raw_aid 			:= 0;
				self.name1												:= if(ln_propertyV2.Functions.fIsCompany(owner_name_clean) or trim(v_full_name, left, right)[1..4]='DBA ',
																								'',
																								owner_name_clean);		
				self.seller1											:= if(ln_propertyV2.Functions.fIsCompany(seller_name_clean) or trim(seller_name_clean, left, right)[1..4]='DBA ',
																								'',
																								seller_name_clean);
				self.name1_company								:= if(ln_propertyV2.Functions.fIsCompany(v_full_name) or trim(v_full_name, left, right)[1..4]='DBA ',
																								v_full_name,
																								'');
				self.seller1_company							:= if(ln_propertyV2.Functions.fIsCompany(seller_name_clean) or trim(seller_name_clean, left, right)[1..4]='DBA ',
																								seller_name_clean,
																								'');
				self.append_prep_owner_address1		:= trim(trim(l.owner_house_number_prefix, left, right) + ' ' + 
																								trim(ln_propertyv2.Functions.fRemLeadZeros(trim(l.owner_house_number, left, right)) + ' ' +
																								trim(trim(l.owner_house_number_suffix, left, right) + ' ' + 
																								trim(trim(l.owner_street_direction, left, right) + ' ' + 
																								trim(trim(ln_propertyv2.Functions.fRemLeadZeros(trim(l.owner_street_name, left, right)), left, right) + ' ' +
																								trim(trim(l.owner_mode, left, right) + ' ' +
																														trim(if(ln_propertyv2.Functions.fRemLeadZeros(trim(l.owner_apartment_unit, left, right)) = '', 
																																ln_propertyv2.Functions.fRemLeadZeros(trim(l.owner_apartment_unit, left, right)),
																																trim('UNIT ' + ln_propertyv2.Functions.fRemLeadZeros(trim(l.owner_apartment_unit, left, right)), left, right)), left, right), left, right), left, right), left, right), left, right), left, right), left, right);
				self.append_prep_owner_address2		:= if((l.owner_city<>'' and l.owner_state<>'') or (ln_propertyv2.Functions.fRemLeadZeros(l.owner_zip_code[1..5])=''),
																															trim(regexreplace('[0]{5}$|[,]$', trim(trim(trim(l.owner_city, left, right) + ', '+ trim(l.owner_state, left, right), left, right)+ ' ' + trim(l.owner_zip_code[1..5], left, right), left, right), ''), left, right),
																														if(l.owner_city<>'',
																															trim(l.owner_city, left, right) + ' ' + '12345',
																														if(l.owner_state<>'',
																															'UNKNOWN, '+ l.owner_state +' 12345',
																															'UNKNOWN 12345')));
				self.append_owner_raw_aid 				:= 0;		
				self.append_prep_property_address1:= trim(trim(l.prop_house_number_prefix, left, right) + ' ' + 
																								trim(ln_propertyv2.Functions.fRemLeadZeros(l.prop_house_number) + ' ' +
																								trim(trim(l.prop_house_number_suffix, left, right) + ' ' + 
																								trim(trim(l.prop_direction, left, right) + ' ' + 
																								trim(trim(ln_propertyv2.Functions.fRemLeadZeros(l.prop_street_name), left, right) + ' ' +
																								trim(trim(l.prop_mode, left, right) + ' ' +
																															trim(if(ln_propertyv2.Functions.fRemLeadZeros(l.prop_apartment_unit)='', 
																																ln_propertyv2.Functions.fRemLeadZeros(l.prop_apartment_unit),
																																trim('UNIT '+ ln_propertyv2.Functions.fRemLeadZeros(l.prop_apartment_unit), left, right)), left, right), left, right), left, right), left, right), left, right), left, right), left, right);
				self.append_prep_property_address2:= if((l.prop_city<>'' and l.prop_state<>'') or (ln_propertyv2.Functions.fRemLeadZeros(l.prop_property_address_zip_code_[1..5])<>''),
																															trim(regexreplace('[0]{5}$|[,]$', trim(trim(trim(l.prop_city, left, right)+', '+trim(l.prop_state, left, right), left, right) + ' ' + trim(l.prop_property_address_zip_code_[1..5], left, right), left, right), ''), left, right),
																														if(l.prop_city<>'',
																															trim(l.prop_city, left, right) + ' ' + '12345',
																														if(l.prop_state<>'', 
																															'UNKNOWN, '+ l.prop_state + ' 12345', 
																															'UNKNOWN 12345')));
				self := l;
			end;
	
			ds_prep_deed_address := project(ds_deed_sequence, addOwnName(left));

    //Normalize File by Address
		common.ds_deed_mod	tDeedNormAddr(ds_prep_deed_address	pInput, integer	cnt) := transform
			self.Append_PrepAddr1			:=	choose(cnt,pInput.append_prep_owner_address1,pInput.append_prep_property_address1);
			self.Append_PrepAddr2			:=	choose(cnt,pInput.append_prep_owner_address2,pInput.append_prep_property_address2);
			self.source_code					:=	' '+ choose(cnt,'O','P');
			self											:=	pInput;
		end;
	
		dDeedNormAddr		:= normalize(ds_prep_deed_address,2,tDeedNormAddr(left,counter));
		dDeedAddrFilt		:= dDeedNormAddr(append_prepaddr1 !=	'' or	append_prepaddr2 != '');
		deedFilter 			:= dDeedAddrFilt;
	


    	//Prep for Country Code Flag//////////////////////////////////////////////////////////////////////	
		common.ds_deed_mod tDeedMailAddr(deedFilter l) := transform
			string v_buyer_mailing_full_street_address  := l.owner_house_number_prefix
																											+ ' '+if((integer)l.owner_house_number<>0,regexreplace('^0*',trim(L.owner_house_number,left,right),''),'')
																											+ ' '+l.owner_house_number_suffix
																											+ ' '+l.owner_street_direction
																											+ ' '+regexreplace('^0*',trim(L.owner_street_name,left,right),'')
																											+ ' '+l.owner_mode
																											+ ' '+l.owner_quadrant;

			self.mailing_street                         := stringlib.stringcleanspaces(v_buyer_mailing_full_street_address); //new
			self.mailing_unit_number                    := L.owner_apartment_unit; 
			self.mailing_csz                            := LN_Functions.Function_CombineCityStateZip(L.owner_city, L.owner_state, if(length(trim(l.owner_zip_code))=9,l.owner_zip_code[1..5]+'-'+l.owner_zip_code[6..9],L.owner_zip_code), ''); //new
			self																			 := l;
		end;
		
			mailAddrPop  := project(deedFilter, tDeedMailAddr(left));	
		
	//Fix ID Field for Macro
		prepFix := record	
			common.ds_deed_mod;
			string12 ln_fares_id;
		end;
	
		prepFix idFix(mailAddrPop l):= transform
			self.ln_fares_id := l.fares_id;	
			self := l;
		end;
	
		idFixField := project(mailAddrPop, idFix(left));
	
	//Assign Country Codes
		LN_PropertyV2_Fast.MAC_CtryCodeOwnSellDeed(idFixField, dDeedCommon);	
		
	//Remove ID Field
		common.ds_deed_mod retId(dDeedCommon l):= transform
			self := l;
		end;
		
		returnID := project(dDeedCommon, retID(left));

	//Apply Clean Address Macro - Add AIDs
		LN_Propertyv2.Append_AID(returnID, dSrchCleanAddr, false);
		
	//Populate Clean Address Fields by Source Code
		common.ds_deed_mod addressAppended(dSrchCleanAddr pInput) := transform
			self.append_owner_raw_aid			:= if(pInput.source_code[2]='O',
																					pInput.append_rawaid,
																					0);
			self.own_prim_range 					:= if(pInput.source_code[2]='O',
																					pInput.prim_range,
																					'');
			self.own_predir 							:= if(pInput.source_code[2]='O',
																					pInput.predir,
																					'');
			self.own_prim_name 						:= if(pInput.source_code[2]='O',
																					pInput.prim_name,
																					'');
			self.own_suffix 							:= if(pInput.source_code[2]='O',
																					pInput.suffix,
																					'');
			self.own_postdir 							:= if(pInput.source_code[2]='O',
																					pInput.postdir,
																					'');
			self.own_unit_desig 					:= if(pInput.source_code[2]='O',
																					pInput.unit_desig,
																					'');
			self.own_sec_range 						:= if(pInput.source_code[2]='O',
																					pInput.sec_range,
																					'');
			self.own_p_city_name 					:= if(pInput.source_code[2]='O',
																					pInput.p_city_name,
																					'');
			self.own_v_city_name 					:= if(pInput.source_code[2]='O',
																					pInput.v_city_name,
																					'');
			self.own_ace_state						:= if(pInput.source_code[2]='O',
																					pInput.st,
																					'');
			self.own_ace_zip							:= if(pInput.source_code[2]='O',
																					pInput.zip,
																					'');
			self.own_ace_zip4							:= if(pInput.source_code[2]='O',
																					pInput.zip4,
																					'');
			self.own_cart 								:= if(pInput.source_code[2]='O',
																					pInput.cart,
																					'');
			self.own_cr_sort_sz 					:= if(pInput.source_code[2]='O',
																					pInput.cr_sort_sz,
																					'');
			self.own_lot 									:= if(pInput.source_code[2]='O',
																					pInput.lot,
																					'');
			self.own_lot_order 						:= if(pInput.source_code[2]='O',
																					pInput.lot_order,
																					'');
			self.own_dbpc 								:= if(pInput.source_code[2]='O',
																					pInput.dbpc,
																					'');
			self.own_chk_digit 						:= if(pInput.source_code[2]='O',
																					pInput.chk_digit,
																					'');
			self.own_ace_rec_type 				:= if(pInput.source_code[2]='O',
																					pInput.rec_type,
																					'');
			self.own_ace_county 					:= if(pInput.source_code[2]='O',
																					pInput.county,
																					'');
			self.own_geo_lat 							:= if(pInput.source_code[2]='O',
																					pInput.geo_lat,
																					'');
			self.own_geo_long 						:= if(pInput.source_code[2]='O',
																					pInput.geo_long,
																					'');
			self.own_ace_msa 							:= if(pInput.source_code[2]='O',
																					pInput.msa,
																					'');
			self.own_geo_blk 							:= if(pInput.source_code[2]='O',
																					pInput.geo_blk,
																					'');
			self.own_geo_match 						:= if(pInput.source_code[2]='O',
																					pInput.geo_match,
																					'');
			self.own_err_stat 						:= if(pInput.source_code[2]='O',
																					pInput.err_stat,
																					'');
			self.append_property_raw_aid	:= if(pInput.source_code[2]='P',
																					pInput.append_rawaid,
																					0);
			self.prop_prim_range 					:= if(pInput.source_code[2]='P',
																					pInput.prim_range,
																					'');
			self.prop_predir 							:= if(pInput.source_code[2]='P',
																					pInput.predir,
																					'');
			self.prop_prim_name 					:= if(pInput.source_code[2]='P',
																					pInput.prim_name,
																					'');
			self.prop_suffix 							:= if(pInput.source_code[2]='P',
																					pInput.suffix,
																					'');
			self.prop_postdir 						:= if(pInput.source_code[2]='P',
																					pInput.postdir,
																					'');
			self.prop_unit_desig 					:= if(pInput.source_code[2]='P',
																					pInput.unit_desig,
																					'');
			self.prop_sec_range 					:= if(pInput.source_code[2]='P',
																					pInput.sec_range,
																					'');
			self.prop_p_city_name 				:= if(pInput.source_code[2]='P',
																					pInput.p_city_name,
																					'');
			self.prop_v_city_name 				:= if(pInput.source_code[2]='P',
																					pInput.v_city_name,
																					'');
			self.prop_ace_state						:= if(pInput.source_code[2]='P',
																					pInput.st,
																					'');
			self.prop_ace_zip							:= if(pInput.source_code[2]='P',
																					pInput.zip,
																					'');
			self.prop_ace_zip4						:= if(pInput.source_code[2]='P',
																					pInput.zip4,
																					'');
			self.prop_cart 								:= if(pInput.source_code[2]='P',
																					pInput.cart,
																					'');
			self.prop_cr_sort_sz 					:= if(pInput.source_code[2]='P',
																					pInput.cr_sort_sz,
																					'');
			self.prop_lot 								:= if(pInput.source_code[2]='P',
																					pInput.lot,
																					'');
			self.prop_lot_order 					:= if(pInput.source_code[2]='P',
																					pInput.lot_order,
																					'');
			self.prop_dbpc 								:= if(pInput.source_code[2]='P',
																					pInput.dbpc,
																					'');
			self.prop_chk_digit 					:= if(pInput.source_code[2]='P',
																					pInput.chk_digit,
																					'');
			self.prop_ace_rec_type 				:= if(pInput.source_code[2]='P',
																					pInput.rec_type,
																					'');
			self.prop_ace_county 					:= if(pInput.source_code[2]='P',
																					pInput.county,
																					'');
			self.prop_geo_lat 						:= if(pInput.source_code[2]='P',
																					pInput.geo_lat,
																					'');
			self.prop_geo_long 						:= if(pInput.source_code[2]='P',
																					pInput.geo_long,
																					'');
			self.prop_ace_msa 						:= if(pInput.source_code[2]='P',
																					pInput.msa,
																					'');
			self.prop_geo_blk 						:= if(pInput.source_code[2]='P',
																					pInput.geo_blk,
																					'');
			self.prop_geo_match 					:= if(pInput.source_code[2]='P',
																					pInput.geo_match,
																					'');
			self.prop_err_stat 						:= if(pInput.source_code[2]='P',
																					pInput.err_stat,
																					'');
			self													:= pInput;
		end;
			
		cleanAddress 	:= project(dSrchCleanAddr, addressAppended(left));//:persist('~thor_data::persist::clean_deed');
	
	//Rollup Owner Addresses
		cleanAddress ownAddr(cleanAddress l, cleanAddress r) := transform
			self.append_owner_raw_aid 		:= if(l.append_owner_raw_aid = 0, r.append_owner_raw_aid, l.append_owner_raw_aid);
			self.own_prim_range  					:= if(l.own_prim_range ='', r.own_prim_range, l.own_prim_range);
			self.own_predir  							:= if(l.own_predir ='', r.own_predir, l.own_predir);
			self.own_prim_name  					:= if(l.own_prim_name ='', r.own_prim_name, l.own_prim_name);
			self.own_suffix  							:= if(l.own_suffix ='', r.own_suffix, l.own_suffix);
			self.own_postdir  						:= if(l.own_postdir ='', r.own_postdir, l.own_postdir);
			self.own_unit_desig  					:= if(l.own_unit_desig ='', r.own_unit_desig, l.own_unit_desig);
			self.own_sec_range  					:= if(l.own_sec_range ='', r.own_sec_range, l.own_sec_range);
			self.own_p_city_name  				:= if(l.own_p_city_name ='', r.own_p_city_name, l.own_p_city_name);
			self.own_v_city_name  				:= if(l.own_v_city_name ='', r.own_v_city_name, l.own_v_city_name);
			self.own_ace_state 						:= if(l.own_ace_state ='', r.own_ace_state, l.own_ace_state);
			self.own_ace_zip 							:= if(l.own_ace_zip ='', r.own_ace_zip, l.own_ace_zip);
			self.own_ace_zip4 						:= if(l.own_ace_zip4 ='', r.own_ace_zip4, l.own_ace_zip4);
			self.own_cart  								:= if(l.own_cart ='', r.own_cart, l.own_cart);
			self.own_cr_sort_sz  					:= if(l.own_cr_sort_sz ='', r.own_cr_sort_sz, l.own_cr_sort_sz);
			self.own_lot  								:= if(l.own_lot ='', r.own_lot, l.own_lot);
			self.own_lot_order  					:= if(l.own_lot_order ='', r.own_lot_order, l.own_lot_order);
			self.own_dbpc  								:= if(l.own_dbpc ='', r.own_dbpc, l.own_dbpc);
			self.own_chk_digit  					:= if(l.own_chk_digit ='', r.own_chk_digit, l.own_chk_digit);
			self.own_ace_rec_type  				:= if(l.own_ace_rec_type ='', r.own_ace_rec_type, l.own_ace_rec_type);
			self.own_ace_county  					:= if(l.own_ace_county ='', r.own_ace_county, l.own_ace_county);
			self.own_geo_lat  						:= if(l.own_geo_lat ='', r.own_geo_lat, l.own_geo_lat);
			self.own_geo_long  						:= if(l.own_geo_long ='', r.own_geo_long, l.own_geo_long);
			self.own_ace_msa  						:= if(l.own_ace_msa ='', r.own_ace_msa, l.own_ace_msa);
			self.own_geo_blk  						:= if(l.own_geo_blk ='', r.own_geo_blk, l.own_geo_blk);
			self.own_geo_match  					:= if(l.own_geo_match ='', r.own_geo_match, l.own_geo_match);
			self.own_err_stat  						:= if(l.own_err_stat ='', r.own_err_stat, l.own_err_stat);
			self													:= r;
		end;
		
		ownerAddr := ROLLUP(sort(distribute(cleanAddress, HASH(fares_id)), fares_id, -append_owner_raw_aid,-own_prim_range,
								-own_predir,-own_prim_name,-own_suffix,-own_postdir,-own_unit_desig,-own_sec_range,-own_p_city_name,-own_v_city_name,
								-own_ace_state ,-own_ace_zip ,-own_ace_zip4 ,-own_cart,-own_cr_sort_sz,-own_lot,-own_lot_order,-own_dbpc,-own_chk_digit,
								-own_ace_rec_type,-own_ace_county,-own_geo_lat,-own_geo_long,-own_ace_msa,-own_geo_blk,-own_geo_match,-own_err_stat,local),
								left.fares_id = right.fares_id and
								left.append_prep_owner_address1 = right.append_prep_owner_address1 and
								left.append_prep_owner_address2 = right.append_prep_owner_address2 and 
								left.append_prep_property_address1 = right.append_prep_property_address1 and 
								left.append_prep_property_address2 = right.append_prep_property_address2,
								ownAddr(left, right), local);

  //Rollup Property Addresses
		ownerAddr propAddr(ownerAddr l, ownerAddr r) := transform
			self.prop_prim_range  				:= if(l.prop_prim_range ='', r.prop_prim_range, l.prop_prim_range);
			self.prop_predir  						:= if(l.prop_predir ='', r.prop_predir, l.prop_predir);
			self.prop_prim_name  					:= if(l.prop_prim_name ='', r.prop_prim_name, l.prop_prim_name);
			self.prop_suffix  						:= if(l.prop_suffix ='', r.prop_suffix, l.prop_suffix);
			self.prop_postdir  						:= if(l.prop_postdir ='', r.prop_postdir, l.prop_postdir);
			self.prop_unit_desig  				:= if(l.prop_unit_desig ='', r.prop_unit_desig, l.prop_unit_desig);
			self.prop_sec_range  					:= if(l.prop_sec_range ='', r.prop_sec_range, l.prop_sec_range);
			self.prop_p_city_name  				:= if(l.prop_p_city_name ='', r.prop_p_city_name, l.prop_p_city_name);
			self.prop_v_city_name  				:= if(l.prop_v_city_name ='', r.prop_v_city_name, l.prop_v_city_name);
			self.prop_ace_state 					:= if(l.prop_ace_state ='', r.prop_ace_state, l.prop_ace_state);
			self.prop_ace_zip 						:= if(l.prop_ace_zip ='', r.prop_ace_zip, l.prop_ace_zip);
			self.prop_ace_zip4 						:= if(l.prop_ace_zip4 ='', r.prop_ace_zip4, l.prop_ace_zip4);
			self.prop_cart  							:= if(l.prop_cart ='', r.prop_cart, l.prop_cart);
			self.prop_cr_sort_sz  				:= if(l.prop_cr_sort_sz ='', r.prop_cr_sort_sz, l.prop_cr_sort_sz);
			self.prop_lot  								:= if(l.prop_lot ='', r.prop_lot, l.prop_lot);
			self.prop_lot_order  					:= if(l.prop_lot_order ='', r.prop_lot_order, l.prop_lot_order);
			self.prop_dbpc  							:= if(l.prop_dbpc ='', r.prop_dbpc, l.prop_dbpc);
			self.prop_chk_digit 					:= if(l.prop_chk_digit ='', r.prop_chk_digit, l.prop_chk_digit);
			self.prop_ace_rec_type  			:= if(l.prop_ace_rec_type ='', r.prop_ace_rec_type, l.prop_ace_rec_type);
			self.prop_ace_county  				:= if(l.prop_ace_county ='', r.prop_ace_county, l.prop_ace_county);
			self.prop_geo_lat  						:= if(l.prop_geo_lat ='', r.prop_geo_lat, l.prop_geo_lat);
			self.prop_geo_long  					:= if(l.prop_geo_long ='', r.prop_geo_long, l.prop_geo_long);
			self.prop_ace_msa  						:= if(l.prop_ace_msa ='', r.prop_ace_msa, l.prop_ace_msa);
			self.prop_geo_blk  						:= if(l.prop_geo_blk ='', r.prop_geo_blk, l.prop_geo_blk);
			self.prop_geo_match  					:= if(l.prop_geo_match ='', r.prop_geo_match, l.prop_geo_match);SELF := R; 
		end;
		
		propertyAddr := ROLLUP(sort(distribute(ownerAddr, HASH(fares_id)), fares_id, -append_property_raw_aid,-prop_prim_range,
											-prop_predir,-prop_prim_name,-prop_suffix,-prop_postdir,-prop_unit_desig,-prop_sec_range,-prop_p_city_name,-prop_v_city_name,
											-prop_ace_state,-prop_ace_zip,-prop_ace_zip4,-prop_cart,-prop_cr_sort_sz,-prop_lot,-prop_lot_order,-prop_dbpc,-prop_chk_digit,
											-prop_ace_rec_type,-prop_ace_county,-prop_geo_lat,-prop_geo_long,-prop_ace_msa,-prop_geo_blk,-prop_geo_match, local),
											left.fares_id = right.fares_id and
											left.append_prep_owner_address1 = right.append_prep_owner_address1 and
											left.append_prep_owner_address2 = right.append_prep_owner_address2 and
											left.append_prep_property_address1 = right.append_prep_property_address1 and 
											left.append_prep_property_address2 = right.append_prep_property_address2,
											propAddr(left, right), local);

		allAddr := propertyAddr;
		
	//Normalize by Name
		allAddr	tDeedNormName(allAddr pInput, integer cnt) := transform
			self.nameasis									:=	choose(cnt,pInput.name1, pInput.name2, pInput.seller1);
			self.which_orig								:=	choose(cnt,'1','2','1');
			self.source_code							:=	choose(cnt,'O','O','S')+pInput.source_code[2];
			self													:=	pInput;
			self													:=	[];
		end;
	
		dDeedNormName	:= normalize(allAddr, 3, tDeedNormName(left,counter))(nameasis<>'' and source_code<>'SO');		
		
		//Apply Name Clean Macro - Add NIDs	
		nid.mac_cleanfullnames(dDeedNormName, cleanfullnames, nameasis, nid, ln_entity_type,,,,,,,,,,,,,,,,, true);
		
		EXPORT cleanfullnames_sort := sort(distribute(cleanfullnames, hash(fips)), fips, local):persist('~thor40_241_11::persist::fares_deed_clean_names_fp'+if(isFast,'_d','f'));
		
		LN_PropertyV2_Fast.Layout_Fares_Deeds f1080form(cleanfullnames_sort l, common.ds_sort_fips_lookup r):= transform
			self.vendor 						:= if(r.reid_tax_roll_coverage = 'YES-SUP',
																	'FAR_S',
																	'FAR_F');
			self.own_ace_zip 				:= if(l.own_ace_zip = '00000',
																	'',
																	l.own_ace_zip);
			self.prop_ace_zip				:= if(l.prop_ace_zip = '00000',
																	'',
																	l.prop_ace_zip);
			self.iris_apn						:= l.irs_apn;
			self.lf									:= l.crlf;
			self 										:= l;
		end;
	
		EXPORT dNew := dedup(sort(join(cleanfullnames_sort, common.ds_sort_fips_lookup,
												left.fips = right.fips_code,
												f1080form(left, right), left outer, local), record, local), record, local);

END;
	///////////////////////////////////////////////////////////////////////////////////////////////////////////	
	//Create Deed Search File//////////////////////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	EXPORT search := MODULE
	//Populate Clean Names by Source Code & Orig Name Type
		common.ds_deed_mod addVendor(deed.cleanfullnames_sort l, common.ds_sort_fips_lookup r):= transform
			self.vendor 						:= if(r.reid_tax_roll_coverage = 'YES-SUP',
																		'FAR_S',
																		'FAR_F');
			self.name1_title				:= if(l.source_code[1]='O' and l.ln_entity_type not in ['B','T'],
																		l.cln_title,
																		'');
			self.name1_first				:= if(l.source_code[1]='O' and l.ln_entity_type not in ['B','T'],
																		l.cln_fname,
																		'');
			self.name1_middle				:= if(l.source_code[1]='O' and l.ln_entity_type not in ['B','T'],
																		l.cln_mname,
																		'');
			self.name1_last					:= if(l.source_code[1]='O' and l.ln_entity_type not in ['B','T'],
																		l.cln_lname,
																		'');
			self.name1_suffix				:= if(l.source_code[1]='O' and l.ln_entity_type not in ['B','T'],
																		l.cln_suffix,
																		'');
			self.name1_company			:= if(l.source_code[1]='O' and l.ln_entity_type in ['B','T'],
																		l.nameasis,
																		'');
			self.name2_title				:= if(l.source_code[1]='O' and l.ln_entity_type not in ['B','T'],
																		l.cln_title2,
																		'');
			self.name2_first				:= if(l.source_code[1]='O' and l.ln_entity_type not in ['B','T'],
																		l.cln_fname2,
																		'');
			self.name2_middle				:= if(l.source_code[1]='O' and l.ln_entity_type not in ['B','T'],
																		l.cln_mname2,
																		'');
			self.name2_last					:= if(l.source_code[1]='O' and l.ln_entity_type not in ['B','T'],
																		l.cln_lname2,
																		'');
			self.name2_suffix				:= if(l.source_code[1]='O' and l.ln_entity_type not in ['B','T'],
																		l.cln_suffix2,
																		'');
			self.name2_company			:= if(l.source_code[1]='O' and l.ln_entity_type in ['B','T'],
																		l.nameasis,
																		'');
			self.seller1_title			:= if(l.source_code[1]='S' and l.ln_entity_type not in ['B','T'],
																		l.cln_title,
																		'');
			self.seller1_first			:= if(l.source_code[1]='S' and l.ln_entity_type not in ['B','T'],
																		l.cln_fname,
																		'');
			self.seller1_middle			:= if(l.source_code[1]='S' and l.ln_entity_type not in ['B','T'],
																		l.cln_mname,
																		'');
			self.seller1_last				:= if(l.source_code[1]='S' and l.ln_entity_type not in ['B','T'],
																		l.cln_lname,
																		'');
			self.seller1_suffix			:= if(l.source_code[1]='S' and l.ln_entity_type not in ['B','T'],
																		l.cln_suffix,
																		'');
			self.seller1_company		:= if(l.source_code[1]='S' and l.ln_entity_type in ['B','T'],
																		l.nameasis,
																		'');
			self.seller2_title			:= if(l.source_code[1]='S' and l.ln_entity_type not in ['B','T'],
																		l.cln_title2,
																		'');
			self.seller2_first			:= if(l.source_code[1]='S' and l.ln_entity_type not in ['B','T'],
																		l.cln_fname2,
																		'');
			self.seller2_middle			:= if(l.source_code[1]='S' and l.ln_entity_type not in ['B','T'],
																		l.cln_mname2,
																		'');
			self.seller2_last				:= if(l.source_code[1]='S' and l.ln_entity_type not in ['B','T'],
																		l.cln_lname2,
																		'');
			self.seller2_suffix			:= if(l.source_code[1]='S' and l.ln_entity_type not in ['B','T'],
																		l.cln_suffix2,
																		'');
			self.seller2_company		:= if(l.source_code[1]='S' and l.ln_entity_type in ['B','T'],
																		l.nameasis,
																		'');
			self										:= l;
		end;
		
		cleanNames 			:= join(deed.cleanfullnames_sort, common.ds_sort_fips_lookup,
														left.fips = right.fips_code,
														addVendor(left, right), left outer, local);
		
		layout_deed_mortgage_property_search_mod_temp := record
			LN_PropertyV2.layout_deed_mortgage_property_search_mod;
			string3	ln_buyer_mailing_country_code;
			string3	ln_seller_mailing_country_code;
		end;
																
		//Normalize Search File			
		layout_deed_mortgage_property_search_mod_temp deedNorm(cleanNames l, integer	c)	:= transform
			self.ln_fares_id							:= l.fares_id;	
			self.which_orig								:= '1';
			self.title										:= choose(c, l.name1_title, l.name1_title, l.name2_title, l.name2_title, l.seller1_title, l.seller2_title);
			self.fname 										:= choose(c, l.name1_first, l.name1_first, l.name2_first, l.name2_first, l.seller1_first, l.seller2_first);
			self.mname 										:= choose(c, l.name1_middle, l.name1_middle, l.name2_middle, l.name2_middle, l.seller1_middle, l.seller2_middle);
			self.lname 										:= choose(c, l.name1_last, l.name1_last, l.name2_last, l.name2_last, l.seller1_last, l.seller2_last);
			self.name_suffix 							:= choose(c, l.name1_suffix, l.name1_suffix, l.name2_suffix, l.name2_suffix, l.seller1_suffix, l.seller2_suffix);
			self.cname 										:= choose(c, l.name1_company, l.name1_company, l.name2_company, l.name2_company, l.seller1_company, l.seller2_company)[1..50];			
			self.prim_range 							:= choose(c, l.prop_prim_range, l.own_prim_range, l.prop_prim_range, l.own_prim_range, l.prop_prim_range, l.prop_prim_range);
			self.predir 									:= choose(c, l.prop_predir, l.own_predir, l.prop_predir, l.own_predir, l.prop_predir, l.prop_predir);
			self.prim_name 								:= choose(c, l.prop_prim_name, l.own_prim_name, l.prop_prim_name, l.own_prim_name, l.prop_prim_name, l.prop_prim_name);
			self.suffix 									:= choose(c, l.prop_suffix, l.own_suffix, l.prop_suffix, l.own_suffix, l.prop_suffix, l.prop_suffix);
			self.postdir	 								:= choose(c, l.prop_postdir, l.own_postdir, l.prop_postdir, l.own_postdir, l.prop_postdir, l.prop_postdir);
			self.unit_desig 							:= choose(c, l.prop_unit_desig, l.own_unit_desig, l.prop_unit_desig, l.own_unit_desig, l.prop_unit_desig, l.prop_unit_desig);
			self.sec_range 								:= choose(c, l.prop_sec_range, l.own_sec_range, l.prop_sec_range, l.own_sec_range, l.prop_sec_range, l.prop_sec_range);
			self.p_city_name 							:= choose(c, l.prop_p_city_name, l.own_p_city_name, l.prop_p_city_name, l.own_p_city_name, l.prop_p_city_name, l.prop_p_city_name);
			self.v_city_name 							:= choose(c, l.prop_v_city_name, l.own_v_city_name, l.prop_v_city_name, l.own_v_city_name, l.prop_v_city_name, l.prop_v_city_name);
			self.st 											:= choose(c, l.prop_ace_state, l.own_ace_state, l.prop_ace_state, l.own_ace_state, l.prop_ace_state, l.prop_ace_state);
			self.zip 											:= choose(c, l.prop_ace_zip, l.own_ace_zip, l.prop_ace_zip, l.own_ace_zip, l.prop_ace_zip, l.prop_ace_zip);
			self.zip4 										:= choose(c, l.prop_ace_zip4, l.own_ace_zip4, l.prop_ace_zip4, l.own_ace_zip4, l.prop_ace_zip4, l.prop_ace_zip4);
			self.cart 										:= choose(c, l.prop_cart, l.own_cart, l.prop_cart, l.own_cart, l.prop_cart, l.prop_cart);
			self.cr_sort_sz 							:= choose(c, l.prop_cr_sort_sz, l.own_cr_sort_sz, l.prop_cr_sort_sz, l.own_cr_sort_sz, l.prop_cr_sort_sz, l.prop_cr_sort_sz);
			self.lot 											:= choose(c, l.prop_lot, l.own_lot, l.prop_lot, l.own_lot, l.prop_lot, l.prop_lot);
			self.lot_order 								:= choose(c, l.prop_lot_order, l.own_lot_order, l.prop_lot_order, l.own_lot_order, l.prop_lot_order, l.prop_lot_order);
			self.dbpc 										:= choose(c, l.prop_dbpc, l.own_dbpc, l.prop_dbpc, l.own_dbpc, l.prop_dbpc, l.prop_dbpc);
			self.chk_digit 								:= choose(c, l.prop_chk_digit, l.own_chk_digit, l.prop_chk_digit, l.own_chk_digit, l.prop_chk_digit, l.prop_chk_digit);
			self.rec_type 								:= choose(c, l.prop_ace_rec_type, l.own_ace_rec_type, l.prop_ace_rec_type, l.own_ace_rec_type, l.prop_ace_rec_type, l.prop_ace_rec_type);
			self.county 									:= choose(c, l.prop_ace_county, l.own_ace_county, l.prop_ace_county, l.own_ace_county, l.prop_ace_county, l.prop_ace_county);
			self.geo_lat 									:= choose(c, l.prop_geo_lat, l.own_geo_lat, l.prop_geo_lat, l.own_geo_lat, l.prop_geo_lat, l.prop_geo_lat);
			self.geo_long 								:= choose(c, l.prop_geo_long, l.own_geo_long, l.prop_geo_long, l.own_geo_long, l.prop_geo_long, l.prop_geo_long);
			self.msa 											:= choose(c, l.prop_ace_msa, l.own_ace_msa, l.prop_ace_msa, l.own_ace_msa, l.prop_ace_msa, l.prop_ace_msa);
			self.geo_blk 									:= choose(c, l.prop_geo_blk, l.own_geo_blk, l.prop_geo_blk, l.own_geo_blk, l.prop_geo_blk, l.prop_geo_blk);
			self.geo_match 								:= choose(c, l.prop_geo_match, l.own_geo_match, l.prop_geo_match, l.own_geo_match, l.prop_geo_match, l.prop_geo_match);
			self.err_stat 								:= choose(c, l.prop_err_stat, l.own_err_stat, l.prop_err_stat, l.own_err_stat, l.prop_err_stat, l.prop_err_stat);
			self.source_code 							:= choose(c, 'OP', 'OO', 'OP', 'OO', 'SP', 'SP');
				
				orig_name := if(l.owner_buyer_last_name[30] <> ' ',
																					trim(l.owner_buyer_last_name, left, right)+trim(l.owner_buyer_first_name, left, right),
																					trim(l.owner_buyer_last_name, left, right) + ' ' + trim(l.owner_buyer_first_name, left, right));
				
			self.nameasis 								:= choose(c, orig_name, orig_name, orig_name, orig_name, l.seller_name, l.seller_name);	
			self.name_type								:= l.ln_entity_type;	
			self.vendor_source_flag				:= if(l.vendor = 'FAR_F',
																						'F',
																					if(l.vendor = 'FAR_S',
																						'S',
																						''));
			self.dt_first_seen 						:= (integer)l.recording_date_yyyymmdd[1..6];
			self.dt_last_seen 						:= (integer)l.recording_date_yyyymmdd[1..6];
			self.dt_vendor_last_reported 	:= (integer)l.process_date[1..6];
			self.dt_vendor_first_reported := (integer)l.recording_date_yyyymmdd[1..6];
			self.conjunctive_name_seq 		:= choose(c, '1', '1', '2', '2', '1', '2');
			self.phone_number 						:= '';
			
					prep_prop_addr1 := trim(regexreplace('[ ]+', l.append_prep_property_address1, ' '), left, right);
					prep_prop_addr2 := trim(regexreplace('[ ]+', l.append_prep_property_address2, ' '), left, right);
					
					prep_own_addr1 	:= trim(regexreplace('[ ]+', l.append_prep_owner_address1, ' '), left, right);
					prep_own_addr2 	:= trim(regexreplace('[ ]+', l.append_prep_owner_address2, ' '), left, right);
			
			self.append_prepaddr1 							:= choose(c, prep_prop_addr1, prep_own_addr1, prep_prop_addr1, prep_own_addr1, prep_prop_addr1, prep_prop_addr1);
			self.append_prepaddr2								:= choose(c, prep_prop_addr2, prep_own_addr2, prep_prop_addr2, prep_own_addr2, prep_prop_addr2, prep_prop_addr2);	
			self.append_rawaid 									:= choose(c, l.append_property_raw_aid, l.append_owner_raw_aid, l.append_property_raw_aid, l.append_owner_raw_aid, l.append_property_raw_aid, l.append_property_raw_aid);
			self.ln_buyer_mailing_country_code 	:= choose(c, '', l.ln_buyer_mailing_country_code, '', l.ln_buyer_mailing_country_code, '', '');	
			self.ln_seller_mailing_country_code := choose(c, '', '', '', '', '', '');	
			self.ln_entity_type									:= l.ln_entity_type;
			self																:= l;
		end;

		deed_norm					:= normalize(cleanNames, 6, deedNorm(left, counter));
		
	//Pull U.S. Mailing & Property Addresses for the Search File 
		prop_addr					:= deed_norm(source_code[2]='P');	
		not_prop_addr			:= deed_norm(source_code[2]<>'P');
		
		dom_buyer 				:= not_prop_addr(ln_buyer_mailing_country_code in ['AF','ASM','GUM','PRI','VIR','USA']);		
		dom_seller 				:= not_prop_addr(ln_seller_mailing_country_code in ['AF','ASM','GUM','PRI','VIR','USA']);
			
		domestic_filter 	:= prop_addr + dom_buyer + dom_seller;			
		deed_norm_filter 	:= project(domestic_filter(trim(lname, left, right)<>'' or trim(cname, left, right)<>''), LN_PropertyV2.layout_deed_mortgage_property_search_mod);
		dSearch 					:= dedup(sort(distribute(deed_norm_filter, hash(ln_fares_id)), ln_fares_id, fname, mname, lname, name_suffix, cname, source_code, append_prepaddr1, append_prepaddr2, local), ln_fares_id, fname, mname, lname, name_suffix, cname, source_code, append_prepaddr1, append_prepaddr2, local);

    EXPORT dNew:= dSearch ;
	END;
END;
