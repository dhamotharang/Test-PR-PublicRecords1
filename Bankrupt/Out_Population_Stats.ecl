import STRATA;

export Out_Population_Stats(pSearch,pMain,pVersion,zOut)
 :=
  macro

	#uniquename(rPopulationStats_File_BK_Search);
	#uniquename(rPopulationStats_File_BK_Main);
	#uniquename(dPopulationStats_File_BK_Search);
	#uniquename(dPopulationStats_File_BK_Main);
	#uniquename(zSearchStats);
	#uniquename(zMainStats);

	%rPopulationStats_File_BK_Search%
	 :=
	  record
		CountGroup                                     := count(group);
		seq_number_CountNonBlank                       := sum(group,if(pSearch.seq_number<>'',1,0));
		pSearch.court_code;
		case_number_CountNonBlank                      := sum(group,if(pSearch.case_number<>'',1,0));
		debtor_type_CountNonBlank                      := sum(group,if(pSearch.debtor_type<>'',1,0));
		debtor_seq_CountNonBlank                       := sum(group,if(pSearch.debtor_seq<>'',1,0));
		orig_ssn_CountNonBlank                         := sum(group,if(pSearch.orig_ssn<>'',1,0));
		debtor_title_CountNonBlank                     := sum(group,if(pSearch.debtor_title<>'',1,0));
		debtor_fname_CountNonBlank                     := sum(group,if(pSearch.debtor_fname<>'',1,0));
		debtor_mname_CountNonBlank                     := sum(group,if(pSearch.debtor_mname<>'',1,0));
		debtor_lname_CountNonBlank                     := sum(group,if(pSearch.debtor_lname<>'',1,0));
		debtor_name_suffix_CountNonBlank               := sum(group,if(pSearch.debtor_name_suffix<>'',1,0));
		score_CountNonBlank                            := sum(group,if(pSearch.score<>'',1,0));
		debtor_company_CountNonBlank                   := sum(group,if(pSearch.debtor_company<>'',1,0));
		prim_range_CountNonBlank                       := sum(group,if(pSearch.prim_range<>'',1,0));
		predir_CountNonBlank                           := sum(group,if(pSearch.predir<>'',1,0));
		prim_name_CountNonBlank                        := sum(group,if(pSearch.prim_name<>'',1,0));
		suffix_CountNonBlank                           := sum(group,if(pSearch.suffix<>'',1,0));
		postdir_CountNonBlank                          := sum(group,if(pSearch.postdir<>'',1,0));
		unit_desig_CountNonBlank                       := sum(group,if(pSearch.unit_desig<>'',1,0));
		sec_range_CountNonBlank                        := sum(group,if(pSearch.sec_range<>'',1,0));
		p_city_name_CountNonBlank                      := sum(group,if(pSearch.p_city_name<>'',1,0));
		v_city_name_CountNonBlank                      := sum(group,if(pSearch.v_city_name<>'',1,0));
		st_CountNonBlank                               := sum(group,if(pSearch.st<>'',1,0));
		z5_CountNonBlank                               := sum(group,if(pSearch.z5<>'',1,0));
		zip4_CountNonBlank                             := sum(group,if(pSearch.zip4<>'',1,0));
		cart_CountNonBlank                             := sum(group,if(pSearch.cart<>'',1,0));
		cr_sort_sz_CountNonBlank                       := sum(group,if(pSearch.cr_sort_sz<>'',1,0));
		lot_CountNonBlank                              := sum(group,if(pSearch.lot<>'',1,0));
		lot_order_CountNonBlank                        := sum(group,if(pSearch.lot_order<>'',1,0));
		dbpc_CountNonBlank                             := sum(group,if(pSearch.dbpc<>'',1,0));
		chk_digit_CountNonBlank                        := sum(group,if(pSearch.chk_digit<>'',1,0));
		rec_type_CountNonBlank                         := sum(group,if(pSearch.rec_type<>'',1,0));
		county_CountNonBlank                           := sum(group,if(pSearch.county<>'',1,0));
		geo_lat_CountNonBlank                          := sum(group,if(pSearch.geo_lat<>'',1,0));
		geo_long_CountNonBlank                         := sum(group,if(pSearch.geo_long<>'',1,0));
		msa_CountNonBlank                              := sum(group,if(pSearch.msa<>'',1,0));
		geo_blk_CountNonBlank                          := sum(group,if(pSearch.geo_blk<>'',1,0));
		geo_match_CountNonBlank                        := sum(group,if(pSearch.geo_match<>'',1,0));
		err_stat_CountNonBlank                         := sum(group,if(pSearch.err_stat<>'',1,0));
		debtor_DID_CountNonBlank                       := sum(group,if(pSearch.debtor_DID<>'',1,0));
		debtor_ssn_CountNonBlank                       := sum(group,if(pSearch.debtor_ssn<>'',1,0));
		debtor_DID_score_CountNonBlank                 := sum(group,if(pSearch.debtor_DID_score<>'',1,0));
		bdid_CountNonBlank                             := sum(group,if(pSearch.bdid<>'',1,0));
		GLB_flag_CountNonBlank                         := sum(group,if(pSearch.GLB_flag<>'',1,0));
	  end;

	%rPopulationStats_File_BK_Main%
	 :=
	  record
		CountGroup                                            := count(group);
		pMain.source;
		pMain.court_code;
		case_number_CountNonBlank                             := sum(group,if(pMain.case_number<>'',1,0));
		orig_case_number_CountNonBlank                        := sum(group,if(pMain.orig_case_number<>'',1,0));
		id_CountNonBlank                                      := sum(group,if(pMain.id<>'',1,0));
		seq_number_CountNonBlank                              := sum(group,if(pMain.seq_number<>'',1,0));
		date_created_CountNonBlank                            := sum(group,if(pMain.date_created<>'',1,0));
		date_modified_CountNonBlank                           := sum(group,if(pMain.date_modified<>'',1,0));
		court_name_CountNonBlank                              := sum(group,if(pMain.court_name<>'',1,0));
		court_location_CountNonBlank                          := sum(group,if(pMain.court_location<>'',1,0));
		case_closing_date_CountNonBlank                       := sum(group,if(pMain.case_closing_date<>'',1,0));
		chapter_CountNonBlank                                 := sum(group,if(pMain.chapter<>'',1,0));
		orig_filing_type_CountNonBlank                        := sum(group,if(pMain.orig_filing_type<>'',1,0));
		filing_status_CountNonBlank                           := sum(group,if(pMain.filing_status<>'',1,0));
		orig_chapter_CountNonBlank                            := sum(group,if(pMain.orig_chapter<>'',1,0));
		orig_filing_date_CountNonBlank                        := sum(group,if(pMain.orig_filing_date<>'',1,0));
		corp_flag_CountNonBlank                               := sum(group,if(pMain.corp_flag<>'',1,0));
		meeting_date_CountNonBlank                            := sum(group,if(pMain.meeting_date<>'',1,0));
		meeting_time_CountNonBlank                            := sum(group,if(pMain.meeting_time<>'',1,0));
		address_341_CountNonBlank                             := sum(group,if(pMain.address_341<>'',1,0));
		claims_deadline_CountNonBlank                         := sum(group,if(pMain.claims_deadline<>'',1,0));
		complaint_deadline_CountNonBlank                      := sum(group,if(pMain.complaint_deadline<>'',1,0));
		disposed_date_CountNonBlank                           := sum(group,if(pMain.disposed_date<>'',1,0));
		disposition_CountNonBlank                             := sum(group,if(pMain.disposition<>'',1,0));
		converted_date_CountNonBlank                          := sum(group,if(pMain.converted_date<>'',1,0));
		reopen_date_CountNonBlank                             := sum(group,if(pMain.reopen_date<>'',1,0));
		judge_name_CountNonBlank                              := sum(group,if(pMain.judge_name<>'',1,0));
		record_type_CountNonBlank                             := sum(group,if(pMain.record_type<>'',1,0));
		date_filed_CountNonBlank                              := sum(group,if(pMain.date_filed<>'',1,0));
		assets_no_asset_indicator_CountNonBlank               := sum(group,if(pMain.assets_no_asset_indicator<>'',1,0));
		filing_type_CountNonBlank                             := sum(group,if(pMain.filing_type<>'',1,0));
		filer_type_CountNonBlank                              := sum(group,if(pMain.filer_type<>'',1,0));
		pro_se_ind_CountNonBlank                              := sum(group,if(pMain.pro_se_ind<>'',1,0));
		judges_identification_CountNonBlank                   := sum(group,if(pMain.judges_identification<>'',1,0));
		attorney_name_CountNonBlank                           := sum(group,if(pMain.attorney_name<>'',1,0));
		attorney_phone_CountNonBlank                          := sum(group,if(pMain.attorney_phone<>'',1,0));
		attorney_company_CountNonBlank                        := sum(group,if(pMain.attorney_company<>'',1,0));
		attorney_address1_CountNonBlank                       := sum(group,if(pMain.attorney_address1<>'',1,0));
		attorney_address2_CountNonBlank                       := sum(group,if(pMain.attorney_address2<>'',1,0));
		attorney_city_CountNonBlank                           := sum(group,if(pMain.attorney_city<>'',1,0));
		attorney_st_CountNonBlank                             := sum(group,if(pMain.attorney_st<>'',1,0));
		attorney_zip_CountNonBlank                            := sum(group,if(pMain.attorney_zip<>'',1,0));
		attorney_zip4_CountNonBlank                           := sum(group,if(pMain.attorney_zip4<>'',1,0));
		attorney2_name_CountNonBlank                          := sum(group,if(pMain.attorney2_name<>'',1,0));
		attorney2_phone_CountNonBlank                         := sum(group,if(pMain.attorney2_phone<>'',1,0));
		attorney2_company_CountNonBlank                       := sum(group,if(pMain.attorney2_company<>'',1,0));
		attorney2_address1_CountNonBlank                      := sum(group,if(pMain.attorney2_address1<>'',1,0));
		attorney2_address2_CountNonBlank                      := sum(group,if(pMain.attorney2_address2<>'',1,0));
		attorney2_city_CountNonBlank                          := sum(group,if(pMain.attorney2_city<>'',1,0));
		attorney2_st_CountNonBlank                            := sum(group,if(pMain.attorney2_st<>'',1,0));
		attorney2_zip_CountNonBlank                           := sum(group,if(pMain.attorney2_zip<>'',1,0));
		attorney2_zip4_CountNonBlank                          := sum(group,if(pMain.attorney2_zip4<>'',1,0));
		trustee_name_CountNonBlank                            := sum(group,if(pMain.trustee_name<>'',1,0));
		trustee_phone_CountNonBlank                           := sum(group,if(pMain.trustee_phone<>'',1,0));
		trustee_company_CountNonBlank                         := sum(group,if(pMain.trustee_company<>'',1,0));
		trustee_address1_CountNonBlank                        := sum(group,if(pMain.trustee_address1<>'',1,0));
		trustee_address2_CountNonBlank                        := sum(group,if(pMain.trustee_address2<>'',1,0));
		trustee_city_CountNonBlank                            := sum(group,if(pMain.trustee_city<>'',1,0));
		trustee_st_CountNonBlank                              := sum(group,if(pMain.trustee_st<>'',1,0));
		trustee_zip_CountNonBlank                             := sum(group,if(pMain.trustee_zip<>'',1,0));
		trustee_zip4_CountNonBlank                            := sum(group,if(pMain.trustee_zip4<>'',1,0));
	  end;

	%dPopulationStats_File_BK_Search%	:= table(pSearch,
												 %rPopulationStats_File_BK_Search%,
												 court_code,
												 few
												);

	STRATA.createXMLStats(%dPopulationStats_File_BK_Search%,
						  'Bankruptcy',
						  'Search',
						  pVersion,
						  '',
						  %zSearchStats%,
						  'view',
						  'Population'
						 );

	%dPopulationStats_File_BK_Main%	:= table(pMain,
											 %rPopulationStats_File_BK_Main%,
											 source,court_code,
										     few
											);

	STRATA.createXMLStats(%dPopulationStats_File_BK_Main%,
						  'Bankruptcy',
						  'Main',
						  pVersion,
						  '',
						  %zMainStats%,
						  'view',
						  'Population'
						 );

	zOut	:=	parallel(%zSearchStats%,%zMainStats%);

  endmacro
 ;
