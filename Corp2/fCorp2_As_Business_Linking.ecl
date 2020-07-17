IMPORT Address, AID, Business_Header, CORP, MDR, UT, _Validate;

EXPORT fCorp2_As_Business_Linking(dataset(Layout_Corporate_Direct_Corp_AID) pCorp_Base, dataset(Layout_Corporate_Direct_Cont_AID) pCont_Base , dataset(Corp2.Layout_Corporate_Direct_Event_Base) pEvent_Base) := function

		SET_OF_UNDESIRED_CORP_NAMES := ['X','SAME','NATIONAL REGISTERED AGENTS, INC.','NATIONAL REGISTERED AGENTS'];

		BadAddr	:=	['NOT PROVIDED','---'];

		//////////////////////////////////////////////////////////////////////////////////////////////
		// --Company Mapping
		//////////////////////////////////////////////////////////////////////////////////////////////
		base_company 			 	:= 	pCorp_Base(corp_legal_name NOT IN SET_OF_UNDESIRED_CORP_NAMES); //eliminate bad corp names

		corpDist	:=	distribute(base_company,hash(corp_key));
		deDupCorp	:=	dedup(sort(corpDist,record,local),record,local);

		pEvent_base	chkCorpKey(pEvent_base l)	:=	transform
				source				:= 	MDr.sourceTools.fCorpV2(l.corp_key, l.corp_state_origin);
				corp_key			:= 	corp2.Linking_filters.corp_key('',source,l.corp_key);
				self.corp_key	:=	l.corp_key;
				self					:=	l;
		end;

		base_event := dedup(sort(distribute(project(pEvent_base(_validate.date.fIsValid(event_filing_date)),chkCorpKey(left)),hash(corp_key)),corp_key,event_filing_date,dt_vendor_first_reported,dt_vendor_last_reported,local),corp_key,event_filing_date,dt_vendor_first_reported,dt_vendor_last_reported,local);

		Layout_Add_RecID := record
				unsigned6 record_id := 0;
				corp2.Layout_Corporate_Direct_Corp_AID;
				unsigned4 event_filing_date;
		end;

		Layout_Add_RecID AddEvent(corp2.Layout_Corporate_Direct_Corp_AID l, base_event r) := transform
				self.event_filing_date	:=	if(_validate.date.fIsValid(r.event_filing_date),(unsigned4)r.event_filing_date,0);
				self 										:= 	l;
		end;

		ds_combined1 := join(deDupCorp,
												base_event,
												left.corp_key = right.corp_key and
												(
                              (     left.dt_vendor_first_reported = right.dt_vendor_first_reported
                                and left.dt_vendor_last_reported  = right.dt_vendor_last_reported
                              )
                        )
                        ,
												AddEvent(left,right),
												left outer, local,keep(1));
    ds_combined1_nomatch := project(ds_combined1(event_filing_date = 0) ,corp2.Layout_Corporate_Direct_Corp_AID);

		ds_combined2 := join(ds_combined1_nomatch,
												base_event,
												left.corp_key = right.corp_key and
												(
                              ut.date_overlap(left.dt_vendor_first_reported , left.dt_vendor_last_reported
                                             ,right.dt_vendor_first_reported, right.dt_vendor_last_reported) > 0

                        )
                        ,
												AddEvent(left,right),
												left outer, local,keep(1));

		ds_combined := ds_combined1(event_filing_date != 0) + ds_combined2;

		Layout_Add_RecID AddRecordID(Layout_Add_RecID L) := transform
				// self.record_id	:= cnt;
				unsigned4 dt_first_seen :=
													ut.EarliestDate((unsigned4)corp2.fCheckDate(l.corp_filing_date),
													ut.EarliestDate((unsigned4)corp2.fCheckDate(l.corp_address1_effective_date),
													ut.EarliestDate((unsigned4)corp2.fCheckDate(l.corp_address2_effective_date),
													ut.EarliestDate((unsigned4)corp2.fCheckDate(l.corp_status_date),
																					(unsigned4)corp2.fCheckDate((string)l.event_filing_date)))));
				unsigned4 dt_last_seen :=
													max((unsigned4)corp2.fCheckDate(l.corp_filing_date),
													max((unsigned4)corp2.fCheckDate(l.corp_address1_effective_date),
													max((unsigned4)corp2.fCheckDate(l.corp_address2_effective_date),
													max((unsigned4)corp2.fCheckDate(l.corp_status_date),
																				(unsigned4)corp2.fCheckDate((string)l.event_filing_date)))));
				self.dt_first_seen	:=	dt_first_seen;
				self.dt_last_seen		:=	dt_last_seen;
				self := L;
		end;

		company_seq1 := distribute(PROJECT(ds_combined, AddRecordID(LEFT)));
    ut.MAC_Sequence_Records(company_seq1  ,record_id  ,company_seq);

		reformatDate1(string8 inDate)	:=	function
				clean_inDate		:= trim(inDate,all);
				Position1				:= StringLib.StringFind(clean_inDate,'/',1);
	      position2				:= StringLib.StringFind(clean_inDate,'/',2);
		    STRING8 newDate := clean_inDate[position2+1..position2+4]+IF(position1=2, '0'+ clean_inDate[1],clean_inDate[1..2])+
			                          IF(position2-position1=3,clean_inDate[position1+1..position1+2], '0'+clean_inDate[position1+1..position2]);
			RETURN  newDate;

		END;

		reformatDate2(string8 inDate)	:=	function
				clean_inDate		:= trim(inDate,all);
				String8 newdate	:=	if (length(clean_inDate)=7,
																		clean_inDate[4..7] + '0' + clean_inDate[1..3],
																		clean_inDate[5..8] + clean_inDate[1..4]
																);
				RETURN  newDate;

		END;

	  DBApattern		:= '^(.*?)(DBA - |/ DBA |, DBA| DBA/|DBA / | DBA | DBA:|D/B/A:| D/B/A |D/B/A | DBA| D/B/A| AKA | A\\.K\\.A\\. |: WHICH WILL DO BUSINESS IN CALIFORNIA AS )(.+)';
	  CareOfPattern	:= '^(.*?)( C/O | C/0 )(.+)';

		//////////////////////////////////////////////////////////////////////////////////////////////
		// -- Map to BH-Company format
		//////////////////////////////////////////////////////////////////////////////////////////////
		bh_layout_tmp_company := record
				unsigned6 record_id;
				business_header.Layout_Business_Linking.Company_;
				string30  corp_phone_number;
				string15  corp_fax_nbr;
		end;

		bh_layout_company := record
				unsigned6 record_id;
				business_header.Layout_Business_Linking.Company_;
				string clean_company;
		end;

		bh_layout_tmp_company Translate_To_Company_BHL(company_seq L, INTEGER c) := transform
				self.source												:= MDr.sourceTools.fCorpV2(l.corp_key, l.corp_state_origin);
				temp_name													:= IF (regexfind(CareOfPattern,l.corp_legal_name), REGEXFIND(CareOfPattern,l.corp_legal_name,1), l.corp_legal_name);
				corp_key													:= corp2.Linking_filters.corp_key(temp_name,l.corp_state_origin,l.corp_key);
				self.tmp_join_id_company         	:= corp_key;
				self.vl_id 				  							:= corp_key;
				self.company_charter_number				:= corp2.Linking_filters.corp_sos_charter_nbr(temp_name,l.corp_state_origin,l.corp_sos_charter_nbr);
				self.company_name 								:= corp2.Linking_filters.corp_legal_name(temp_name,l.corp_state_origin,l.corp_sos_charter_nbr);
				self.company_name_type_raw				:= corp2.Linking_filters.name_type(l.corp_ln_name_type_desc,l.corp_state_origin,l.corp_orig_org_structure_desc,l.corp_orig_bus_type_desc,L.corp_name_comment);
				self.company_name_status_raw			:= corp2.Linking_filters.name_status(l.corp_name_comment,l.corp_state_origin,l.corp_status_desc);

				self.dt_first_seen 								:= l.dt_first_seen;
				self.dt_last_seen 								:= l.dt_last_seen;
				self.dt_vendor_first_reported			:= l.dt_vendor_first_reported;
				self.dt_vendor_last_reported			:= l.dt_vendor_last_reported;
				self.rcid													:= 0;
				self.company_bdid									:= l.bdid;
				FilingDate												:= if(l.corp_state_origin='LA' and not _validate.date.fIsValid(l.corp_filing_date),
																									reformatDate1(l.corp_filing_date),
																									l.corp_filing_date
																								);
				self.company_filing_date					:= if(_validate.date.fIsValid(FilingDate),(unsigned4)FilingDate,0);
				StatusDate												:= if(l.corp_state_origin='LA' and not _validate.date.fIsValid(l.corp_status_date),
																									reformatDate2(l.corp_status_date),
																									l.corp_status_date
																								);
				self.company_status_date					:= if(_validate.date.fIsValid(StatusDate),(unsigned4)StatusDate,0);
				self.company_rawaid								:= choose(c,l.append_addr1_rawaid,			l.append_addr2_rawaid);
				self.company_aceaid								:= choose(c,l.append_addr1_aceaid,			l.append_addr2_aceaid);
				self.company_address.prim_range 	:= choose(c,l.corp_addr1_prim_range,		l.corp_addr2_prim_range);
				self.company_address.predir 			:= choose(c,l.corp_addr1_predir,				l.corp_addr2_predir);
				self.company_address.prim_name 		:= choose(c,if(l.corp_addr1_prim_name not in BadAddr, l.corp_addr1_prim_name, ''),if(l.corp_addr2_prim_name not in BadAddr, l.corp_addr2_prim_name,'') );
				self.company_address.addr_suffix	:= choose(c,l.corp_addr1_addr_suffix,		l.corp_addr2_addr_suffix);
				self.company_address.postdir 			:= choose(c,l.corp_addr1_postdir,				l.corp_addr2_postdir);
				self.company_address.unit_desig 	:= choose(c,l.corp_addr1_unit_desig,		l.corp_addr2_unit_desig);
				self.company_address.sec_range 		:= choose(c,l.corp_addr1_sec_range,			l.corp_addr2_sec_range);
				self.company_address.p_city_name 	:= choose(c,l.corp_addr1_p_city_name,		l.corp_addr2_p_city_name);
				self.company_address.v_city_name 	:= choose(c,l.corp_addr1_v_city_name,		l.corp_addr2_v_city_name);
				self.company_address.st 					:= choose(c,l.corp_addr1_state,					l.corp_addr2_state);
				self.company_address.zip	 				:= choose(c,l.corp_addr1_zip5,					l.corp_addr2_zip5);
				self.company_address.zip4 				:= choose(c,l.corp_addr1_zip4,					l.corp_addr2_zip4);
				self.company_address.cart 				:= choose(c,l.corp_addr1_cart,					l.corp_addr2_cart);
				self.company_address.cr_sort_sz 	:= choose(c,l.corp_addr1_cr_sort_sz,		l.corp_addr2_cr_sort_sz);
				self.company_address.lot 					:= choose(c,l.corp_addr1_lot,						l.corp_addr2_lot);
				self.company_address.lot_order 		:= choose(c,l.corp_addr1_lot_order,			l.corp_addr2_lot_order);
				self.company_address.chk_digit 		:= choose(c,l.corp_addr1_chk_digit,			l.corp_addr2_chk_digit);
				self.company_address.rec_type 		:= choose(c,l.corp_addr1_rec_type,			l.corp_addr2_rec_type);
				self.company_address.fips_state		:= choose(c,l.corp_addr1_ace_fips_st,		l.corp_addr2_ace_fips_st);
				self.company_address.fips_county	:= choose(c,l.corp_addr1_county,				l.corp_addr2_county);
				self.company_address.geo_lat 			:= choose(c,l.corp_addr1_geo_lat,				l.corp_addr2_geo_lat);
				self.company_address.geo_long 		:= choose(c,l.corp_addr1_geo_long,			l.corp_addr2_geo_long);
				self.company_address.msa 					:= choose(c,l.corp_addr1_msa,						l.corp_addr2_msa);
				self.company_address.geo_blk 			:= choose(c,l.corp_addr1_geo_blk,				l.corp_addr2_geo_blk);
				self.company_address.geo_match 		:= choose(c,l.corp_addr1_geo_match,			l.corp_addr2_geo_match);
				self.company_address.err_stat 		:= choose(c,l.corp_addr1_err_stat,			l.corp_addr2_err_stat);
				self.company_address_type_raw			:= choose(c,l.corp_address1_type_desc,	l.corp_address2_type_desc);
				self.company_fein 								:= IF (Business_Header.ValidFEIN((unsigned4)stringLib.stringFilter(l.corp_fed_tax_id,'0123456789')), stringLib.stringFilter(l.corp_fed_tax_id,'0123456789'), '');
				self.company_status_raw						:= corp2.Linking_filters.company_status(l.corp_status_desc,l.corp_state_origin, l.corp_status_comment);
				self.company_ticker								:= l.corp_ticker_symbol;
				self.company_ticker_exchange			:= l.corp_stock_exchange;
				self.company_inc_state						:= l.corp_state_origin;
				self.company_incorporation_date		:= if(_validate.date.fIsValid(l.corp_inc_date),(unsigned4)l.corp_inc_date,0);
				self.company_foreign_domestic			:= corp2.Linking_filters.Foreign_Domestic(l.corp_orig_org_structure_desc,l.corp_foreign_domestic_ind);
				self.company_foreign_date					:= if(_validate.date.fIsValid(l.corp_forgn_date),(unsigned4)l.corp_forgn_date,0);
				self.company_org_structure_raw		:= corp2.Linking_filters.org_structure(l.corp_orig_org_structure_desc,l.corp_state_origin,l.corp_orig_bus_type_desc,l.corp_name_comment);
				self.company_sic_code1						:= l.corp_sic_code;
				self.company_naics_code1					:= l.corp_naic_code;
				self.company_url									:= l.corp_web_address;
				self.current											:= IF (l.record_type = 'C',true,false);
				self.source_record_id							:= l.source_rec_id;
				self.glb													:= FALSE;
				self.dppa													:= FALSE;
				self.match_company_name						:= '';
				self.match_branch_city						:= '';
				self.match_geo_city								:= '';
				self															:= l;
				self															:= [];
		end;

		chooseAddr(unsigned8 pAddr2_aceaid, string pAddr2_City, string2 pAddr2_State, string5 pAddr2_Zip) := if(pAddr2_aceaid !=0 or
																																																						(pAddr2_City <>'' and pAddr2_State <>'' and pAddr2_Zip <> ''), 2, 1);

		ds_company_norm	:= normalize(company_seq, chooseAddr(left.append_addr2_aceaid, left.corp_addr2_p_city_name, left.corp_addr2_state, left.corp_addr2_zip5), Translate_To_Company_BHL(left,counter),local);

		bh_layout_company Translate_To_Company_BHL2(bh_layout_tmp_company L, INTEGER c) := transform
				self.company_phone 								:= choose(c,ut.cleanphone(l.corp_phone_number), ut.cleanphone(l.corp_fax_nbr));
				self.phone_type										:= choose(c,if (ut.cleanphone(l.corp_phone_number) != '','T',''), if (ut.cleanphone(l.corp_fax_nbr) !='','F',''));
				self.phone_score 									:= IF(self.company_phone <> '', 1, 0);
        self.clean_company                := ut.CleanCompany(l.company_name);
				self															:= l;
		end;

		choosePhone(string pPhone1, string pPhone2) := map(pPhone2!='' => 2, 1);

		ds_company_norm2	:= normalize(distribute(ds_company_norm), choosePhone(left.corp_phone_number, left.corp_fax_nbr), Translate_To_Company_BHL2(left,counter),local);

		ds_company_norm_dist  := distribute(ds_company_norm2, hash(record_id, clean_company));
		ds_company_sort				:= sort(ds_company_norm_dist, record_id, clean_company, company_address.zip, company_address.prim_name, company_address.prim_range, company_address.v_city_name ,company_address.st, local);

		bh_layout_company Rollup_Corp_Norm(bh_layout_company l, bh_layout_company r) := transform
				self              := l;
		end;

		ds_company_rollup			:= rollup(ds_company_sort
																		,left.record_id  									 	= right.record_id and
																		 left.clean_company = right.clean_company and
																		((left.company_address.zip			 	  = right.company_address.zip and
																		 left.company_address.prim_name 	  = right.company_address.prim_name and
																		 left.company_address.prim_range   	= right.company_address.prim_range and
																		 left.company_address.v_city_name  	= right.company_address.v_city_name and
																		 left.company_address.st					  = right.company_address.st
																		 )
																		OR
																		 (right.company_address.zip				= '' and
																		  right.company_address.prim_name 	= '' and
																			right.company_address.prim_range	= '' and
																			right.company_address.v_city_name	= '' and
																			right.company_address.st			 		= ''
																			))
																		,Rollup_Corp_Norm(left,right)
																		,local);

		// count(ds_company_rollup);

		layout_group_list := record
				ds_company_rollup.record_id;
		end;

		corp_group_list := table(ds_company_rollup, layout_group_list,local);

		layout_group_stat := record
				corp_group_list.record_id;
				cnt := count(group);
		end;

		corp_group_stat := table(corp_group_list,layout_group_stat,record_id,local);

		business_header.Layout_Business_Linking.Company_ Translate_To_Corp_BHL(bh_layout_company L, layout_group_stat r) := transform
				self 					 := l;
		end;

		corp_group_clean := join(ds_company_rollup
														,corp_group_stat(cnt > 1)
														,left.record_id = right.record_id
														,Translate_To_Corp_BHL(left, right)
														,left outer
														,lookup);

		// count(corp_group_clean);

		business_header.Layout_Business_Linking.Company_ Rollup_Corp(	business_header.Layout_Business_Linking.Company_ L, 	business_header.Layout_Business_Linking.Company_ r) := transform
				self.dt_first_seen								:=	ut.EarliestDate(
																								ut.EarliestDate(l.dt_first_seen, r.dt_first_seen),
																								ut.EarliestDate(l.dt_last_seen, r.dt_last_seen)
																								);
				self.dt_last_seen									:=	max(l.dt_last_seen,r.dt_last_seen);
				self.dt_vendor_first_reported			:=	ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
				self.dt_vendor_last_reported			:=	max(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
				self.company_name 								:= if(l.company_name = '', r.company_name, l.company_name);
				self.company_rawaid								:= if(l.company_rawaid	= 0								and	l.company_address.zip4 = '', r.company_rawaid,							l.company_rawaid);
				self.company_aceaid								:= if(l.company_aceaid	= 0								and	l.company_address.zip4 = '', r.company_aceaid,							l.company_aceaid);
				self.company_address.prim_range 	:= if(l.company_address.prim_range = '' 	and l.company_address.zip4 = '', r.company_address.prim_range, 	l.company_address.prim_range);
				self.company_address.predir 			:= if(l.company_address.predir = '' 			and l.company_address.zip4 = '', r.company_address.predir, 			l.company_address.predir);
				self.company_address.prim_name 		:= if(l.company_address.prim_name = '' 		and l.company_address.zip4 = '', r.company_address.prim_name, 	l.company_address.prim_name);
				self.company_address.addr_suffix	:= if(l.company_address.addr_suffix = '' 	and l.company_address.zip4 = '', r.company_address.addr_suffix, l.company_address.addr_suffix);
				self.company_address.postdir 			:= if(l.company_address.postdir = '' 			and l.company_address.zip4 = '', r.company_address.postdir, 		l.company_address.postdir);
				self.company_address.unit_desig 	:= if(l.company_address.unit_desig = ''		and l.company_address.zip4 = '', r.company_address.unit_desig, 	l.company_address.unit_desig);
				self.company_address.sec_range 		:= if(l.company_address.sec_range = '' 		and l.company_address.zip4 = '', r.company_address.sec_range, 	l.company_address.sec_range);
				self.company_address.p_city_name 	:= if(l.company_address.p_city_name = '' 	and l.company_address.zip4 = '', r.company_address.p_city_name, l.company_address.p_city_name);
				self.company_address.v_city_name 	:= if(l.company_address.v_city_name = '' 	and l.company_address.zip4 = '', r.company_address.v_city_name, l.company_address.v_city_name);
				self.company_address.st 					:= if(l.company_address.st = '' 					and l.company_address.zip4 = '', r.company_address.st, 					l.company_address.st);
				self.company_address.zip	 				:= if(l.company_address.zip = '' 					and l.company_address.zip4 = '', r.company_address.zip, 				l.company_address.zip);
				self.company_address.zip4 				:= if(l.company_address.zip4 = '', 																				 r.company_address.zip4, 				l.company_address.zip4);
				self.company_address.fips_state 	:= if(l.company_address.fips_state = '' 	and l.company_address.zip4 = '', r.company_address.fips_state,	l.company_address.fips_state);
				self.company_address.fips_county 	:= if(l.company_address.fips_county = '' 	and l.company_address.zip4 = '', r.company_address.fips_county,	l.company_address.fips_county);
				self.company_address.geo_lat 			:= if(l.company_address.geo_lat = '' 			and l.company_address.zip4 = '', r.company_address.geo_lat, 		l.company_address.geo_lat);
				self.company_address.geo_long 		:= if(l.company_address.geo_long = '' 		and l.company_address.zip4 = '', r.company_address.geo_long, l.company_address.geo_long);
				self.company_address.msa 					:= if(l.company_address.msa = '' 					and l.company_address.zip4 = '', r.company_address.msa, l.company_address.msa);
				self.company_fein 								:= if(l.company_fein = '', r.company_fein, l.company_fein);
				self.company_phone								:= if(ut.cleanphone(l.company_phone) = '', r.company_phone, l.company_phone);
				self.phone_type										:= if(ut.cleanphone(l.company_phone) = '', r.phone_type, l.phone_type);
				self.vl_id 												:= if(l.vl_id = '', r.vl_id, l.vl_id);
				self.phone_score 									:= if(ut.cleanphone(l.company_phone) = '',r.phone_score, l.phone_score);
				self 														  := l;
		end;

		corp_clean_dist := distribute(corp_group_clean,hash(trim(company_address.zip),trim(company_address.prim_name),trim(company_address.prim_range),trim(company_name)));

		corp_clean_sort := sort(corp_clean_dist,company_address.zip,company_address.prim_range,company_address.prim_name,company_name
													,if(company_address.sec_range<>'',0,1), company_address.sec_range
													,if(company_phone<>'',0,1), company_phone
													,if(company_fein<>'',0,1), company_fein
													,dt_vendor_last_reported
													,dt_vendor_first_reported
													,dt_last_seen
													,local);

		ds_company := rollup(corp_clean_sort
															 ,left.company_address.zip 				= right.company_address.zip and
																left.company_address.prim_name 	= right.company_address.prim_name and
																left.company_address.prim_range = right.company_address.prim_range and
																left.company_name 							= right.company_name and
															 (right.company_address.sec_range = '' or
																left.company_address.sec_range 	= right.company_address.sec_range) and
															 (right.company_phone							= ''  or
																left.company_phone 							= right.company_phone) and
															 (right.company_fein 							= ''  or
															  left.company_fein 							= right.company_fein)
															 ,Rollup_Corp(left, right),
																local);

		//////////////////////////////////////////////////////////////////////////////////////////////
		// --Contact Mapping
		//////////////////////////////////////////////////////////////////////////////////////////////
		corp_base := deDupCorp;

		layout_corpkeys	:= record
				corp_base.corp_key;
		end;

		corpkeys_list				:= table(corp_base, layout_corpkeys, corp_key);
		corpkeys_list_dist	:= distribute(corpkeys_list, hash(corp_key));

		ContSlimLayout	:=	record
			unsigned6 did := 0;
			string30  corp_key;
			string2   corp_state_origin;
			string350 corp_legal_name;
			string60  cont_type_desc;
			string60  cont_title_desc;
			string9   cont_ssn;
			string8   cont_dob;
			string60  cont_status_desc; // new
			string30  cont_email_address;
			AID.Common.xAID	Append_Cont_Addr_RawAID;
			AID.Common.xAID	Append_Cont_Addr_ACEAID;
			string60  cont_address_type_desc;
			unsigned4 dt_first_seen;
			unsigned4 dt_last_seen;
			unsigned4 dt_vendor_first_reported;
			unsigned4 dt_vendor_last_reported;
			string100 cont_name;
			string5   cont_title;
			string20  cont_fname;
			string20  cont_mname;
			string20  cont_lname;
			string5   cont_name_suffix;
			string10  cont_prim_range;
			string2   cont_predir;
			string28  cont_prim_name;
			string4   cont_addr_suffix;
			string2   cont_postdir;
			string10  cont_unit_desig;
			string8   cont_sec_range;
			string25  cont_p_city_name;
			string25  cont_v_city_name;
			string2   cont_state;
			string5   cont_zip5;
			string4   cont_zip4;
			string4   cont_cart;
			string1   cont_cr_sort_sz;
			string4   cont_lot;
			string1   cont_lot_order;
			string2   cont_dpbc;
			string1   cont_chk_digit;
			string2   cont_rec_type;
			string2   cont_ace_fips_st;
			string3   cont_county;
			string10  cont_geo_lat;
			string11  cont_geo_long;
			string4   cont_msa;
			string7   cont_geo_blk;
			string1   cont_geo_match;
			string4   cont_err_stat;
			string10  cont_phone10;
		end;

		ContSlimLayout	SlimContacts(pCont_Base l)	:=	transform
			dt_first_seen 			:=
															ut.EarliestDate((unsigned4)corp2.fCheckDate(l.cont_filing_date),
															ut.EarliestDate((unsigned4)corp2.fCheckDate(l.cont_effective_date), (unsigned4)corp2.fCheckDate(l.cont_address_effective_date)));
			dt_last_seen 				:= 	if(
																max((unsigned4)corp2.fCheckDate(l.cont_filing_date),
																max((unsigned4)corp2.fCheckDate(l.cont_effective_date), (unsigned4)corp2.fCheckDate(l.cont_address_effective_date))) <> 0,
																max((unsigned4)corp2.fCheckDate(l.cont_filing_date),
																max((unsigned4)corp2.fCheckDate(l.cont_effective_date), (unsigned4)corp2.fCheckDate(l.cont_address_effective_date))),
																0);
			self.dt_first_seen	:=	dt_first_seen;
			self.dt_last_seen		:=	dt_last_seen;
			self	:=	l;
		end;

		contSlim						:= project(pCont_Base, SlimContacts(left));

		bad_contacts	 			:= contSlim.cont_name IN Corp.Set_Bad_Contact_Names OR
													 regexfind('REGISTERED AGENT',contSlim.cont_title_desc, nocase);
		base_contact				:= contSlim(NOT bad_contacts);
    // -- change -- Rollup instead of dedup
		// base_contact_dist		:= dedup(sort(distribute(base_contact, hash(corp_key)),record,local),record, EXCEPT dt_first_seen, dt_last_seen,local);
		base_contact_dist		:= rollup(sort(distribute(base_contact, hash(corp_key)),record, EXCEPT dt_vendor_first_reported, dt_vendor_last_reported, dt_first_seen, dt_last_seen,local),transform(
       recordof(left)
      ,self.dt_first_seen             := ut.EarliestDate(left.dt_first_seen           ,right.dt_first_seen            );
      ,self.dt_last_seen              := max  (left.dt_last_seen            ,right.dt_last_seen             );
      ,self.dt_vendor_first_reported  := ut.EarliestDate(left.dt_vendor_first_reported,right.dt_vendor_first_reported );
      ,self.dt_vendor_last_reported   := max  (left.dt_vendor_last_reported ,right.dt_vendor_last_reported  );
      ,self                           := left
    ),record, EXCEPT dt_vendor_first_reported, dt_vendor_last_reported, dt_first_seen, dt_last_seen,local);

		ContSlimLayout SelectContacts(ContSlimLayout l,corpkeys_list r) := transform
				self := l;
		end;

		base_contact_select := join(base_contact_dist,corpkeys_list_dist
															 ,left.corp_key = right.corp_key
															 ,SelectContacts(left,right)
															 ,local);

		//////////////////////////////////////////////////////////////////////////////////////////////
		// -- Map to BH-Contact format
		//////////////////////////////////////////////////////////////////////////////////////////////
		bh_layout_contact := {unsigned4 dt_vendor_first_reported,unsigned4  dt_vendor_last_reported,business_header.Layout_Business_Linking.Contact};

		//////////////////////////////////////////////////////////////////////////////////////////////
		// -- Map to Business Contact Layout
		//////////////////////////////////////////////////////////////////////////////////////////////
		bh_layout_contact Translate_To_Contact_BHL(base_contact_select l) := transform
				self.contact_did                 	:= l.did;
				source 														:= MDr.sourceTools.fCorpV2(l.corp_key, l.corp_state_origin);
				temp_name													:= regexfind(CareOfPattern,l.corp_legal_name,1);
				corp_key													:= corp2.Linking_filters.corp_key(temp_name,source,l.corp_key);
				self.tmp_join_id_contact					:= corp_key;
				self.contact_type_raw							:= l.cont_type_desc;
				self.contact_job_title_raw       	:= l.cont_title_desc;
				self.contact_ssn			           	:= l.cont_ssn;
				self.contact_dob								 	:= (unsigned4)l.cont_dob;
				self.contact_status_raw						:= l.cont_status_desc;
				self.contact_email							 	:= l.cont_email_address;

				self.contact_rawaid				       	:= l.Append_Cont_Addr_RawAID;
				self.contact_aceaid				       	:= l.Append_Cont_Addr_ACEAID;

				self.contact_address.prim_range  	:= l.cont_prim_range;
				self.contact_address.predir      	:= l.cont_predir;
				self.contact_address.prim_name   	:= l.cont_prim_name;
				self.contact_address.addr_suffix 	:= l.cont_addr_suffix;
				self.contact_address.postdir     	:= l.cont_postdir;
				self.contact_address.unit_desig  	:= l.cont_unit_desig;
				self.contact_address.sec_range   	:= l.cont_sec_range;
				self.contact_address.p_city_name 	:= l.cont_p_city_name;
				self.contact_address.v_city_name 	:= l.cont_v_city_name;
				self.contact_address.st          	:= l.cont_state;
				self.contact_address.zip        	:= l.cont_zip5;
				self.contact_address.zip4        	:= l.cont_zip4;
				self.contact_address.cart       	:= l.cont_cart;
				self.contact_address.cr_sort_sz  	:= l.cont_cr_sort_sz;
				self.contact_address.lot         	:= l.cont_lot;
				self.contact_address.lot_order	 	:= l.cont_lot_order;
				self.contact_address.dbpc        	:= l.cont_dpbc;
				self.contact_address.chk_digit   	:= l.cont_chk_digit;
				self.contact_address.rec_type		 	:= l.cont_rec_type;
				self.contact_address.fips_state 	:= l.cont_ace_fips_st;
				self.contact_address.fips_county 	:= l.cont_county;
				self.contact_address.geo_lat     	:= l.cont_geo_lat;
				self.contact_address.geo_long    	:= l.cont_geo_long;
				self.contact_address.msa         	:= l.cont_msa;
				self.contact_address.geo_blk     	:= l.cont_geo_blk;
				self.contact_address.geo_match   	:= l.cont_geo_match;
				self.contact_address.err_stat    	:= l.cont_err_stat;
				self.contact_address_type    			:= map(	l.cont_address_type_desc = 'PRINCIPAL ADDRESS' => 'CP',
																									l.cont_address_type_desc = 'MAILING' => 'CM',
																									'C'
																								 );
				self.dt_first_seen_contact       	:= l.dt_first_seen;
				self.dt_last_seen_contact        	:= l.dt_last_seen;
				self.dt_vendor_first_reported     := l.dt_vendor_first_reported;
				self.dt_vendor_last_reported      := l.dt_vendor_last_reported ;

				self.contact_name.title          	:= l.cont_title;
				self.contact_name.fname          	:= l.cont_fname;
				self.contact_name.mname          	:= l.cont_mname;
				self.contact_name.lname          	:= l.cont_lname;
				self.contact_name.name_suffix		 	:= l.cont_name_suffix;
				self.contact_name.name_score     	:= Business_Header.CleanName(self.contact_name.fname,self.contact_name.mname,self.contact_name.lname,self.contact_name.name_suffix)[142];
				self.contact_phone               	:= ut.cleanphone(l.cont_phone10);
				self.cid												 	:= 0;
				self.contact_score 							 	:= 0;
				self.from_hdr										 	:= 'N';
				self.company_department					 	:=	'';
				self := l;
				self := [];
		end;

		ds_contact_proj := project(base_contact_select, Translate_To_Contact_BHL(LEFT));

		ds_contact 			:= ds_contact_proj((INTEGER)contact_name.name_score < 3, Business_Header.CheckPersonName(contact_name.fname, contact_name.mname, contact_name.lname, contact_name.name_suffix));

		ds_company_dist := distribute(ds_company,hash(tmp_join_id_company));
		ds_contact_dist := distribute(ds_contact,hash(tmp_join_id_contact));

		Business_Header.Layout_Business_Linking.Combined joinfiles(Business_Header.Layout_Business_Linking.Company_ L, bh_layout_contact R) := transform
				self.contact_address_type			:= 	if(l.company_aceaid=r.contact_aceaid, 'CC', r.contact_address_type);
				self.company_address_type_raw := 	if(l.company_aceaid=r.contact_aceaid, 'CC', l.company_address_type_raw);
				self := l;
				self := r;
		end;

		j1 := join(ds_company_dist,ds_contact_dist
      ,   left.tmp_join_id_company = right.tmp_join_id_contact
      and (
            (     left.dt_vendor_first_reported = right.dt_vendor_first_reported
              and left.dt_vendor_last_reported  = right.dt_vendor_last_reported
            )
            or
            (
              ut.date_overlap(left.dt_vendor_first_reported , left.dt_vendor_last_reported
                             ,right.dt_vendor_first_reported, right.dt_vendor_last_reported) > 0

            )
          )
    ,joinfiles(left,right),left outer,local);

		Business_Header.Layout_Business_Linking.Combined x9(Business_Header.Layout_Business_Linking.Combined l, integer c) := transform
				self.company_rawaid              := choose(c, l.company_rawaid, l.contact_rawaid);
				self.company_address.prim_range  := choose(c, l.company_address.prim_range, l.contact_address.prim_range);
				self.company_address.predir      := choose(c, l.company_address.predir, l.contact_address.predir);
				self.company_address.prim_name   := choose(c, l.company_address.prim_name, l.contact_address.prim_name);
				self.company_address.addr_suffix := choose(c, l.company_address.addr_suffix, l.contact_address.addr_suffix);
				self.company_address.postdir     := choose(c, l.company_address.postdir, l.contact_address.postdir);
				self.company_address.unit_desig  := choose(c, l.company_address.unit_desig, l.contact_address.unit_desig);
				self.company_address.sec_range   := choose(c, l.company_address.sec_range, l.contact_address.sec_range);
				self.company_address.p_city_name := choose(c, l.company_address.p_city_name, l.contact_address.p_city_name);
				self.company_address.v_city_name := choose(c, l.company_address.v_city_name, l.contact_address.v_city_name);
				self.company_address.st          := choose(c, l.company_address.st, l.contact_address.st);
				self.company_address.zip	       := choose(c, l.company_address.zip, l.contact_address.zip);
				self.company_address.zip4        := choose(c, l.company_address.zip4, l.contact_address.zip4);
				self.company_address.fips_state  := choose(c, l.company_address.fips_state, l.contact_address.fips_state);
				self.company_address.fips_county := choose(c, l.company_address.fips_county, l.contact_address.fips_county);
				self.company_address.msa         := choose(c, l.company_address.msa, l.contact_address.msa);
				self.company_address.geo_lat     := choose(c, l.company_address.geo_lat, l.contact_address.geo_lat);
				self.company_address.geo_long    := choose(c, l.company_address.geo_long, l.contact_address.geo_long);
				self.company_address_type_raw    := choose(c, l.company_address_type_raw, l.contact_address_type);
				self 														 := l;
		end;

		norm_j1 := normalize(j1, if(left.contact_address.prim_range<>'' or
																left.contact_address.prim_name<>'' or
																left.contact_address.zip<>'',2,1), x9(left, counter) );

		concat      	:= j1 + norm_j1;

		GetCorpName(string dname, string pattern2Chk)	:= FUNCTION
			string uppercorp	:= StringLib.StringToUppercase(trim(dname,left,right));
			boolean temp_corp	:= regexfind(pattern2Chk,uppercorp);
			return temp_corp;
		END;

		NewLayout	:=	record
		 Business_Header.Layout_Business_Linking.Combined;
		 boolean DBAFound;
		end;

		NewLayout	trfChkDBA	(Business_Header.Layout_Business_Linking.Combined l)	:=	transform
		 self.DBAFound	:=	GetCorpName(l.company_name, DBApattern);
		 self						:=	l;
		end;

		ChkFile		:=	project(concat,trfChkDBA(left));

		DBAFile		:=	ChkFile(DBAFound and COMPANY_NAME_TYPE_RAW = 'LEGAL');

		NonDBAFile	:=	Project(ChkFile(Not DBAFound or COMPANY_NAME_TYPE_RAW != 'LEGAL'),TRANSFORM(Business_Header.Layout_Business_Linking.Combined,SELF := LEFT;));

		Business_Header.Layout_Business_Linking.Combined trfDBAName(NewLayout l, integer c) := transform
			self.company_name						:= choose(c, StringLib.StringCleanSpaces(trim(regexfind(DBApattern, StringLib.StringToUppercase(l.company_name),1),left,right)) , StringLib.StringCleanSpaces(trim(regexfind(DBApattern, StringLib.StringToUppercase(l.company_name),3),left,right)));
			self.company_name_type_raw	:= choose(c, 'LEGAL' , 'DBA');
			self												:= l;
		end;

		norm_DBAFile 	:= normalize(DBAFile, 2, trfDBAName(left, counter),local)(company_name!='');

		concat2				:=	norm_DBAFile + NonDBAFile;

		concatDist				:= 	sort(distribute(concat2, hash(vl_id)),record, except contact_name.name_score,company_rawaid,local);
		concat_dupd 			:= 	dedup(project(concatDist,Business_Header.Layout_Business_Linking.Linking_Interface),except contact_name.name_score,company_rawaid,local)(company_name !='');

	return concat_dupd;

end;
