EXPORT Out_Evictions_STRATA_Population(pMain
							          ,pVersion
									  ,zOut) := MACRO

import STRATA;

	#uniquename(rPopulationStats_Evictions_Main);
	#uniquename(dPopulationStats_Evictions_Main);
	#uniquename(zMain);

%rPopulationStats_Evictions_Main%
 :=
  record
    CountGroup                                             := count(group);
    indivbusun_CountNonBlank                      := sum(group,if(pMain.indivbusun<>'',1,0));
    aka_yn_CountNonBlank                          := sum(group,if(pMain.aka_yn<>'',1,0));
    assoccode_CountNonBlank                       := sum(group,if(pMain.assoccode<>'',1,0));
    courtid_CountNonBlank                         := sum(group,if(pMain.courtid<>'',1,0));
    court_desc_CountNonBlank                      := sum(group,if(pMain.court_desc<>'',1,0));
    filetypeid_CountNonBlank                      := sum(group,if(pMain.filetypeid<>'',1,0));
    filingtype_desc_CountNonBlank                 := sum(group,if(pMain.filingtype_desc<>'',1,0));
    casenumber_CountNonBlank                      := sum(group,if(pMain.casenumber<>'',1,0));
    book_CountNonBlank                            := sum(group,if(pMain.book<>'',1,0));
    page_CountNonBlank                            := sum(group,if(pMain.page<>'',1,0));
    filing_date_CountNonBlank                     := sum(group,if(pMain.filing_date<>'',1,0));
    release_date_CountNonBlank                    := sum(group,if(pMain.release_date<>'',1,0));
    amount_CountNonBlank                          := sum(group,if(pMain.amount<>'',1,0));
    assets_CountNonBlank                          := sum(group,if(pMain.assets<>'',1,0));
    plaintiff_CountNonBlank                       := sum(group,if(pMain.plaintiff<>'',1,0));
    othercase_CountNonBlank                       := sum(group,if(pMain.othercase<>'',1,0));
    orig_ssn_CountNonBlank                        := sum(group,if(pMain.orig_ssn<>'',1,0));
    defname_CountNonBlank                         := sum(group,if(pMain.defname<>'',1,0));
    generation_CountNonBlank                      := sum(group,if(pMain.generation<>'',1,0));
    orig_address_CountNonBlank                    := sum(group,if(pMain.orig_address<>'',1,0));
    orig_city_CountNonBlank                       := sum(group,if(pMain.orig_city<>'',1,0));
    pMain.orig_state;
    orig_zip_CountNonBlank                        := sum(group,if(pMain.orig_zip<>'',1,0));
    uploaddate_CountNonBlank                      := sum(group,if(pMain.uploaddate<>'',1,0));
    unlawdetyn_CountNonBlank                      := sum(group,if(pMain.unlawdetyn<>'',1,0));
    origcase_CountNonBlank                        := sum(group,if(pMain.origcase<>'',1,0));
    origbook_CountNonBlank                        := sum(group,if(pMain.origbook<>'',1,0));
    origpage_CountNonBlank                        := sum(group,if(pMain.origpage<>'',1,0));
    actiontype_CountNonBlank                      := sum(group,if(pMain.actiontype<>'',1,0));
    stl_type_CountNonBlank                        := sum(group,if(pMain.stl_type<>'',1,0));
    rmsid_CountNonBlank                           := sum(group,if(pMain.rmsid<>'',1,0));
    def_title_CountNonBlank                       := sum(group,if(pMain.def_title<>'',1,0));
    def_fname_CountNonBlank                       := sum(group,if(pMain.def_fname<>'',1,0));
    def_mname_CountNonBlank                       := sum(group,if(pMain.def_mname<>'',1,0));
    def_lname_CountNonBlank                       := sum(group,if(pMain.def_lname<>'',1,0));
    def_name_suffix_CountNonBlank                 := sum(group,if(pMain.def_name_suffix<>'',1,0));
    def_name_score_CountNonBlank                  := sum(group,if(pMain.def_name_score<>'',1,0));
    def_company_CountNonBlank                     := sum(group,if(pMain.def_company<>'',1,0));
    plain_title_CountNonBlank                     := sum(group,if(pMain.plain_title<>'',1,0));
    plain_fname_CountNonBlank                     := sum(group,if(pMain.plain_fname<>'',1,0));
    plain_mname_CountNonBlank                     := sum(group,if(pMain.plain_mname<>'',1,0));
    plain_lname_CountNonBlank                     := sum(group,if(pMain.plain_lname<>'',1,0));
    plain_name_suffix_CountNonBlank               := sum(group,if(pMain.plain_name_suffix<>'',1,0));
    plain_name_score_CountNonBlank                := sum(group,if(pMain.plain_name_score<>'',1,0));
    plain_company_CountNonBlank                   := sum(group,if(pMain.plain_company<>'',1,0));
    prim_range_CountNonBlank                      := sum(group,if(pMain.prim_range<>'',1,0));
    predir_CountNonBlank                          := sum(group,if(pMain.predir<>'',1,0));
    prim_name_CountNonBlank                       := sum(group,if(pMain.prim_name<>'',1,0));
    suffix_CountNonBlank                          := sum(group,if(pMain.suffix<>'',1,0));
    postdir_CountNonBlank                         := sum(group,if(pMain.postdir<>'',1,0));
    unit_desig_CountNonBlank                      := sum(group,if(pMain.unit_desig<>'',1,0));
    sec_range_CountNonBlank                       := sum(group,if(pMain.sec_range<>'',1,0));
    p_city_name_CountNonBlank                     := sum(group,if(pMain.p_city_name<>'',1,0));
    v_city_name_CountNonBlank                     := sum(group,if(pMain.v_city_name<>'',1,0));
    state_CountNonBlank                           := sum(group,if(pMain.state<>'',1,0));
    zip_CountNonBlank                             := sum(group,if(pMain.zip<>'',1,0));
    zip4_CountNonBlank                            := sum(group,if(pMain.zip4<>'',1,0));
    cart_CountNonBlank                            := sum(group,if(pMain.cart<>'',1,0));
    cr_sort_sz_CountNonBlank                      := sum(group,if(pMain.cr_sort_sz<>'',1,0));
    lot_CountNonBlank                             := sum(group,if(pMain.lot<>'',1,0));
    lot_order_CountNonBlank                       := sum(group,if(pMain.lot_order<>'',1,0));
    dbpc_CountNonBlank                            := sum(group,if(pMain.dbpc<>'',1,0));
    chk_digit_CountNonBlank                       := sum(group,if(pMain.chk_digit<>'',1,0));
    rec_type_CountNonBlank                        := sum(group,if(pMain.rec_type<>'',1,0));
    county_CountNonBlank                          := sum(group,if(pMain.county<>'',1,0));
    geo_lat_CountNonBlank                         := sum(group,if(pMain.geo_lat<>'',1,0));
    geo_long_CountNonBlank                        := sum(group,if(pMain.geo_long<>'',1,0));
    msa_CountNonBlank                             := sum(group,if(pMain.msa<>'',1,0));
    geo_blk_CountNonBlank                         := sum(group,if(pMain.geo_blk<>'',1,0));
    geo_match_CountNonBlank                       := sum(group,if(pMain.geo_match<>'',1,0));
    err_stat_CountNonBlank                        := sum(group,if(pMain.err_stat<>'',1,0));
    did_CountNonBlank                             := sum(group,if(pMain.did<>'',1,0));
    did_score_CountNonBlank                       := sum(group,if(pMain.did_score<>'',1,0));
    ssn_appended_CountNonBlank                    := sum(group,if(pMain.ssn_appended<>'',1,0));
    bdid_CountNonBlank                            := sum(group,if(pMain.bdid<>'',1,0));
    glb_flag_CountNonBlank                        := sum(group,if(pMain.glb_flag<>'',1,0));
  end;
  
// Create the Main table and run the STRATA statistics
%dPopulationStats_Evictions_Main% := table(pMain
										 ,%rPopulationStats_Evictions_Main%
										 ,orig_state
										 ,few);
STRATA.createXMLStats(%dPopulationStats_Evictions_Main%
					 ,'Evictions'
					 ,'Main file'
					 ,pVersion
					 ,''
					 ,%zMain%);
					 
zOut := %zMain%;

ENDMACRO;