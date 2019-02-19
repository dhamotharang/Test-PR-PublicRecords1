export mac_get_overlinking_samples(

   pProxidRecords2Reset
  ,pSeleidRecords2Reset
  ,pGet_all_proxid_records_agg  = 'dataset([],recordof(BIPV2_Tools.Agg_Slim(bipv2.commonbase.layout,proxid)))'
  ,pGet_all_seleid_records_agg  = 'dataset([],recordof(BIPV2_Tools.Agg_Slim(bipv2.commonbase.layout,seleid)))'
) :=
functionmacro

  ds_proxid        := pGet_all_proxid_records_agg(count_cnp_names > 0,count_feins > 0                                                                                                        );
  ds_active_proxid := pGet_all_proxid_records_agg(trim(prox_statuss[1].prox_status) = '',count_cnp_names > 0,count_feins > 0                                               );
  ds_gold_proxid   := pGet_all_proxid_records_agg(trim(prox_statuss[1].prox_status) = '',trim(sele_golds[1].sele_gold           ) = 'G',count_cnp_names > 0,count_feins > 0);
  
  ds_seleid        := pGet_all_seleid_records_agg(count_cnp_names > 0,count_feins > 0                                                                                                        );
  ds_active_seleid := pGet_all_seleid_records_agg(trim(sele_statuss[1].sele_status) = '',count_cnp_names > 0,count_feins > 0                                               );
  ds_gold_seleid   := pGet_all_seleid_records_agg(trim(sele_statuss[1].sele_status) = '',trim(sele_golds[1].sele_gold           ) = 'G',count_cnp_names > 0,count_feins > 0);
  
  lay_proxid_prep := {string seq ,unsigned6 proxid,unsigned cnt,string cnt_cnp_names ,string cnt_feins,string pct_bow_mismatch ,unsigned count_cnp_names ,unsigned count_feins,string pct_bow_mismatches, recordof(ds_proxid) - proxid - count_cnp_names - count_feins - pct_bow_mismatchess - cnt};

  ds_proxid_sample_prep                 := project(ds_proxid        ,transform(lay_proxid_prep,self.pct_bow_mismatches := left.pct_bow_mismatchess[1].pct_bow_mismatches
  ,self.cnt_cnp_names     := '=IF(ROW()=3,H3,IF(OR(H3=0),E2,H3))'
  ,self.cnt_feins         := '=IF(ROW()=3,I3,IF(OR(I3=0),F2,I3))'
  ,self.pct_bow_mismatch  := '=IF(ROW()=3,J3,IF(OR(J3=0),G2,J3))'
  ,self.seq               := '=MOD(IF(ROW()=3,A3,IF(OR(A3=0),B2,A3)),2)'
  ,self := left));
  
  ds_proxid_sample_prep_active          := project(ds_active_proxid ,transform(lay_proxid_prep,self.pct_bow_mismatches := left.pct_bow_mismatchess[1].pct_bow_mismatches
  ,self.cnt_cnp_names     := '=IF(ROW()=3,H3,IF(OR(H3=0),E2,H3))'
  ,self.cnt_feins         := '=IF(ROW()=3,I3,IF(OR(I3=0),F2,I3))'
  ,self.pct_bow_mismatch  := '=IF(ROW()=3,J3,IF(OR(J3=0),G2,J3))'
  ,self.seq               := '=MOD(IF(ROW()=3,A3,IF(OR(A3=0),B2,A3)),2)'
  ,self := left));
  
  ds_proxid_sample_prep_gold            := project(ds_gold_proxid   ,transform(lay_proxid_prep,self.pct_bow_mismatches := left.pct_bow_mismatchess[1].pct_bow_mismatches
  ,self.cnt_cnp_names     := '=IF(ROW()=3,H3,IF(OR(H3=0),E2,H3))'
  ,self.cnt_feins         := '=IF(ROW()=3,I3,IF(OR(I3=0),F2,I3))'
  ,self.pct_bow_mismatch  := '=IF(ROW()=3,J3,IF(OR(J3=0),G2,J3))'
  ,self.seq               := '=MOD(IF(ROW()=3,A3,IF(OR(A3=0),B2,A3)),2)'
  ,self := left));
  

  lay_seleid_prep := {string seq ,unsigned6 seleid,unsigned cnt,string cnt_cnp_names ,string cnt_feins,string pct_bow_mismatch ,unsigned count_cnp_names ,unsigned count_feins,string pct_bow_mismatches, recordof(ds_seleid) - seleid - count_cnp_names - count_feins - pct_bow_mismatchess - cnt};
  ds_seleid_sample_prep                 := project(ds_seleid        ,transform(lay_seleid_prep,self.pct_bow_mismatches := left.pct_bow_mismatchess[1].pct_bow_mismatches
  ,self.cnt_cnp_names     := '=IF(ROW()=3,H3,IF(OR(H3=0),E2,H3))'
  ,self.cnt_feins         := '=IF(ROW()=3,I3,IF(OR(I3=0),F2,I3))'
  ,self.pct_bow_mismatch  := '=IF(ROW()=3,J3,IF(OR(J3=0),G2,J3))'
  ,self.seq               := '=MOD(IF(ROW()=3,A3,IF(OR(A3=0),B2,A3)),2)'
  ,self := left));
  ds_seleid_sample_prep_active          := project(ds_active_seleid ,transform(lay_seleid_prep,self.pct_bow_mismatches := left.pct_bow_mismatchess[1].pct_bow_mismatches  
  ,self.cnt_cnp_names     := '=IF(ROW()=3,H3,IF(OR(H3=0),E2,H3))'
  ,self.cnt_feins         := '=IF(ROW()=3,I3,IF(OR(I3=0),F2,I3))'
  ,self.pct_bow_mismatch  := '=IF(ROW()=3,J3,IF(OR(J3=0),G2,J3))'
  ,self.seq               := '=MOD(IF(ROW()=3,A3,IF(OR(A3=0),B2,A3)),2)'
  ,self := left));

  ds_seleid_sample_prep_gold            := project(ds_gold_seleid   ,transform(lay_seleid_prep,self.pct_bow_mismatches := left.pct_bow_mismatchess[1].pct_bow_mismatches
  ,self.cnt_cnp_names     := '=IF(ROW()=3,H3,IF(OR(H3=0),E2,H3))'
  ,self.cnt_feins         := '=IF(ROW()=3,I3,IF(OR(I3=0),F2,I3))'
  ,self.pct_bow_mismatch  := '=IF(ROW()=3,J3,IF(OR(J3=0),G2,J3))'
  ,self.seq               := '=MOD(IF(ROW()=3,A3,IF(OR(A3=0),B2,A3)),2)'
  ,self := left));
  
   
  ds_all_samples_proxid             := BIPV2_Tools.mac_get_sample_matrix(ds_proxid_sample_prep          ,count_cnp_names          ,count_feins                );
  ds_all_samples_proxid_active      := BIPV2_Tools.mac_get_sample_matrix(ds_proxid_sample_prep_active   ,count_cnp_names          ,count_feins                );
  ds_all_samples_proxid_gold        := BIPV2_Tools.mac_get_sample_matrix(ds_proxid_sample_prep_gold     ,count_cnp_names          ,count_feins                );
  
  ds_all_samples_seleid             := BIPV2_Tools.mac_get_sample_matrix(ds_seleid_sample_prep          ,count_cnp_names          ,count_feins                );
  ds_all_samples_seleid_active      := BIPV2_Tools.mac_get_sample_matrix(ds_seleid_sample_prep_active   ,count_cnp_names          ,count_feins                );
  ds_all_samples_seleid_gold        := BIPV2_Tools.mac_get_sample_matrix(ds_seleid_sample_prep_gold     ,count_cnp_names          ,count_feins                );
  
  
  
  output_samples := if(exists(pGet_all_proxid_records_agg) or exists(pGet_all_seleid_records_agg)
    ,parallel(
     output('1. download these as csv and import into excel.(they are too big for eclwatch to convert them to excel)')
    ,output('2. double click on the bottom right of these fields(when the cross appears) to copy them down to the rest of the spreadsheet')
    ,output('   cnt_cnp_names, cnt_feins, pct_bow_mismatch, seq')
    ,output('3. Select whole spreadsheet, then conditional formatting, manage rules, new rule.  formula: =$B1=1.  select format is shade cell light blue.  click apply.  ')
    ,output('   then each seleid/proxid should be shaded for all of its records')
    ,output('4. click on cell C2 and freeze panes')
    ,output('5. sort & filter-> filter.  this will allow you to filter each column by its values.')
    ,output('6. save as an xlsx.')
    ,output('7. Now you can filter for cnt_cnp_names or cnt_feins or pct_bow_mismatches to look at particular clusters to see what looks overlinked.')
    ,output('8. and figure out what threshold counts you want for those fields to get all the overlinked clusters.  and not the non-overlinked ones.')
    ,output(choosen(ds_all_samples_proxid        ,650,1   ),named('ds_all_samples_proxid_1'       ),all)
    ,output(choosen(ds_all_samples_proxid        ,650,651 ),named('ds_all_samples_proxid_2'       ),all)
    ,output(choosen(ds_all_samples_proxid_active ,650,1   ),named('ds_all_samples_proxid_active_1'),all)
    ,output(choosen(ds_all_samples_proxid_active ,650,651 ),named('ds_all_samples_proxid_active_2'),all)
    ,output(choosen(ds_all_samples_proxid_gold   ,650,1   ),named('ds_all_samples_proxid_gold_1'  ),all)
    ,output(choosen(ds_all_samples_proxid_gold   ,650,651 ),named('ds_all_samples_proxid_gold_2'  ),all)

    ,output(choosen(ds_all_samples_seleid        ,650,1   ),named('ds_all_samples_seleid_1'       ),all)
    ,output(choosen(ds_all_samples_seleid        ,650,651 ),named('ds_all_samples_seleid_2'       ),all)
    ,output(choosen(ds_all_samples_seleid_active ,650,1   ),named('ds_all_samples_seleid_active_1'),all)
    ,output(choosen(ds_all_samples_seleid_active ,650,651 ),named('ds_all_samples_seleid_active_2'),all)
    ,output(choosen(ds_all_samples_seleid_gold   ,650,1   ),named('ds_all_samples_seleid_gold_1'  ),all)
    ,output(choosen(ds_all_samples_seleid_gold   ,650,651 ),named('ds_all_samples_seleid_gold_2'  ),all)
  ));

  ds_base                         := pSeleidRecords2Reset    : persist('~persist::lbentley::ds_base'              );                            
  ds_base_active_seleid           := ds_base(trim(seleid_status_public) = '' ) : persist('~persist::lbentley::ds_base_active_seleid');
  ds_base_gold_seleid             := ds_base(trim(sele_gold           ) = 'G') : persist('~persist::lbentley::ds_base_gold_seleid'  );         
//  ds_dnbfein                      := ds_base(mdr.sourcetools.SourceIsDunn_Bradstreet_Fein(source),trim(company_fein) != '',ingest_status = 'Old',trim(duns_number) != '') : persist('~persist::lbentley::ds_dnbfein'       );                        
//  ds_dnbfein_active_seleid        := ds_dnbfein (trim(seleid_status_public) = '' ) : persist('~persist::lbentley::ds_dnbfein_active_seleid'     );
//  ds_dnbfein_gold_seleid          := ds_dnbfein (trim(sele_gold           ) = 'G') : persist('~persist::lbentley::ds_dnbfein_gold_seleid'       );       
//  ds_duns                         := ds_base    (trim(duns_number         ) != '' ) : persist('~persist::lbentley::ds_duns'               );                        
//  ds_duns_active_seleid           := ds_duns    (trim(seleid_status_public)  = '' ) : persist('~persist::lbentley::ds_duns_active_seleid' );
//  ds_duns_gold_seleid             := ds_duns    (trim(sele_gold           )  = 'G') : persist('~persist::lbentley::ds_duns_gold_seleid'   );       
//  ds_not_dnb_fein_seleid          := join(ds_base  ,table(ds_dnbfein,{seleid},seleid,merge)  ,left.seleid = right.seleid,transform(left),hash,left only) : persist('~persist::lbentley::ds_not_dnb_fein'               );                        
//  ds_not_dnb_fein_active_seleid   := ds_not_dnb_fein_seleid (trim(seleid_status_public)  = '' ) : persist('~persist::lbentley::ds_not_dnb_fein_active_seleid' );
//  ds_not_dnb_fein_gold_seleid     := ds_not_dnb_fein_seleid (trim(sele_gold           )  = 'G') : persist('~persist::lbentley::ds_not_dnb_fein_gold_seleid'   );       
  
  ds_base_proxid                  := pProxidRecords2Reset    : persist('~persist::lbentley::ds_base_proxid'              );                            
  ds_base_active_proxid           := ds_base_proxid(trim(proxid_status_public) = '' ) : persist('~persist::lbentley::ds_base_active_proxid');
  ds_base_gold_proxid             := ds_base_proxid(trim(proxid_status_public) = '',trim(sele_gold           ) = 'G') : persist('~persist::lbentley::ds_base_gold_proxid'  );         
//  ds_dnbfein_proxid               := ds_base_proxid(mdr.sourcetools.SourceIsDunn_Bradstreet_Fein(source),trim(company_fein) != '',ingest_status = 'Old',trim(duns_number) != '') : persist('~persist::lbentley::ds_dnbfein_proxid'       );                        
//  ds_dnbfein_active_proxid        := ds_dnbfein_proxid(trim(proxid_status_public) = '' ) : persist('~persist::lbentley::ds_dnbfein_active_proxid'     );
//  ds_dnbfein_gold_proxid          := ds_dnbfein_proxid(trim(proxid_status_public) = '',trim(sele_gold           ) = 'G') : persist('~persist::lbentley::ds_dnbfein_gold_proxid'       );       
//  //ds_duns                         := ds_base (trim(duns_number         ) != '' ) : persist('~persist::lbentley::ds_duns'               );                        
//  ds_duns_active_proxid           := ds_duns (trim(proxid_status_public)  = '' ) : persist('~persist::lbentley::ds_duns_active_proxid' );
//  ds_duns_gold_proxid             := ds_duns (trim(proxid_status_public) = '',trim(sele_gold           )  = 'G') : persist('~persist::lbentley::ds_duns_gold_proxid'   );       
//  ds_not_dnb_fein_proxid          := join(ds_base_proxid  ,table(ds_dnbfein,{proxid},proxid,merge)  ,left.proxid = right.proxid,transform(left),hash,left only) : persist('~persist::lbentley::ds_not_dnb_fein_proxid'               );                        
//  ds_not_dnb_fein_active_proxid   := ds_not_dnb_fein_proxid (trim(proxid_status_public)  = '' ) : persist('~persist::lbentley::ds_not_dnb_fein_active_proxid' );
//  ds_not_dnb_fein_gold_proxid     := ds_not_dnb_fein_proxid (trim(proxid_status_public) = '',trim(sele_gold           )  = 'G') : persist('~persist::lbentley::ds_not_dnb_fein_gold_proxid'   );       
  
  //ds_proxid_agg := BIPV2_Tools.Agg_Slim(ds_base,proxid,50);
  //ds_seleid_agg := BIPV2_Tools.Agg_Slim(ds_base,seleid,50);
  
  ds_seleid_matrix_all                  := bipv2_tools.mac_stat_matrix(ds_base                         ,seleid,'All'                  );
  ds_seleid_matrix_actives              := bipv2_tools.mac_stat_matrix(ds_base_active_seleid           ,seleid,'All_Actives'          );
  ds_seleid_matrix_golds                := bipv2_tools.mac_stat_matrix(ds_base_gold_seleid             ,seleid,'All_Golds'            );
//  ds_seleid_matrix_dnb_fein_all         := bipv2_tools.mac_stat_matrix(ds_dnbfein                      ,seleid,'DNB_Fein_All'         );
//  ds_seleid_matrix_dnb_fein_actives     := bipv2_tools.mac_stat_matrix(ds_dnbfein_active_seleid        ,seleid,'DNB_Fein_Actives'     );
//  ds_seleid_matrix_dnb_fein_golds       := bipv2_tools.mac_stat_matrix(ds_dnbfein_gold_seleid          ,seleid,'DNB_Fein_Golds'       );
//  ds_seleid_matrix_duns_all             := bipv2_tools.mac_stat_matrix(ds_duns                         ,seleid,'Duns_Numbers_All'     );
//  ds_seleid_matrix_duns_actives         := bipv2_tools.mac_stat_matrix(ds_duns_active_seleid           ,seleid,'Duns_Numbers_Actives' );
//  ds_seleid_matrix_duns_golds           := bipv2_tools.mac_stat_matrix(ds_duns_gold_seleid             ,seleid,'Duns_Numbers_Golds'   );
//  ds_seleid_matrix_not_dnbfein_all      := bipv2_tools.mac_stat_matrix(ds_not_dnb_fein_seleid          ,seleid,'Not_DNB Fein_All'     );
//  ds_seleid_matrix_not_dnbfein_actives  := bipv2_tools.mac_stat_matrix(ds_not_dnb_fein_active_seleid   ,seleid,'Not_DNB Fein_Actives' );
//  ds_seleid_matrix_not_dnbfein_golds    := bipv2_tools.mac_stat_matrix(ds_not_dnb_fein_gold_seleid     ,seleid,'Not_DNB Fein_Golds'   );
  
  ds_proxid_matrix_all                  := bipv2_tools.mac_stat_matrix(ds_base                         ,proxid,'All'                  );
  ds_proxid_matrix_actives              := bipv2_tools.mac_stat_matrix(ds_base_active_proxid           ,proxid,'All_Actives'          );
  ds_proxid_matrix_golds                := bipv2_tools.mac_stat_matrix(ds_base_gold_proxid             ,proxid,'All_Golds'            );
//  ds_proxid_matrix_dnb_fein_all         := bipv2_tools.mac_stat_matrix(ds_dnbfein_proxid               ,proxid,'DNB_Fein_All'         );
//  ds_proxid_matrix_dnb_fein_actives     := bipv2_tools.mac_stat_matrix(ds_dnbfein_active_proxid        ,proxid,'DNB_Fein_Actives'     );
//  ds_proxid_matrix_dnb_fein_golds       := bipv2_tools.mac_stat_matrix(ds_dnbfein_gold_proxid          ,proxid,'DNB_Fein_Golds'       );
//  ds_proxid_matrix_duns_all             := bipv2_tools.mac_stat_matrix(ds_duns                         ,proxid,'Duns_Numbers_All'     );
//  ds_proxid_matrix_duns_actives         := bipv2_tools.mac_stat_matrix(ds_duns_active_proxid           ,proxid,'Duns_Numbers_Actives' );
//  ds_proxid_matrix_duns_golds           := bipv2_tools.mac_stat_matrix(ds_duns_gold_proxid             ,proxid,'Duns_Numbers_Golds'   );
//  ds_proxid_matrix_not_dnbfein_all      := bipv2_tools.mac_stat_matrix(ds_not_dnb_fein_proxid          ,proxid,'Not_DNB Fein_All'     );
//  ds_proxid_matrix_not_dnbfein_actives  := bipv2_tools.mac_stat_matrix(ds_not_dnb_fein_active_proxid   ,proxid,'Not_DNB Fein_Actives' );
//  ds_proxid_matrix_not_dnbfein_golds    := bipv2_tools.mac_stat_matrix(ds_not_dnb_fein_gold_proxid     ,proxid,'Not_DNB Fein_Golds'   );
  
  
  ds_total_matrix := 
    ds_seleid_matrix_all                
  + ds_seleid_matrix_actives            
  + ds_seleid_matrix_golds              
//  + ds_seleid_matrix_dnb_fein_all       
//  + ds_seleid_matrix_dnb_fein_actives   
//  + ds_seleid_matrix_dnb_fein_golds     
//  + ds_seleid_matrix_duns_all           
//  + ds_seleid_matrix_duns_actives       
//  + ds_seleid_matrix_duns_golds         
//  + ds_seleid_matrix_not_dnbfein_all    
//  + ds_seleid_matrix_not_dnbfein_actives
//  + ds_seleid_matrix_not_dnbfein_golds  
  + ds_proxid_matrix_all                
  + ds_proxid_matrix_actives            
  + ds_proxid_matrix_golds              
//  + ds_proxid_matrix_dnb_fein_all       
//  + ds_proxid_matrix_dnb_fein_actives   
//  + ds_proxid_matrix_dnb_fein_golds     
//  + ds_proxid_matrix_duns_all           
//  + ds_proxid_matrix_duns_actives       
//  + ds_proxid_matrix_duns_golds         
//  + ds_proxid_matrix_not_dnbfein_all    
//  + ds_proxid_matrix_not_dnbfein_actives
//  + ds_proxid_matrix_not_dnbfein_golds  
  ;
  
  //output(topn(ds_total_matrix      ,500,ID,Notes,map(cnt_feins in ['0','1','2','3','4','5'] => (unsigned)cnt_feins,cnt_feins = '6-10' => 6,cnt_feins = '11-15' => 11,15)) ,named('ds_stat_matrix'     ),all);
  //
  output_stat_matrix := if(exists(pGet_all_proxid_records_agg) or exists(pGet_all_seleid_records_agg)
  ,parallel(
     output(topn(ds_seleid_matrix_all                 ,500,ID,Notes,map(cnt_feins in ['0','1','2','3','4','5'] => (unsigned)cnt_feins,cnt_feins = '6-10' => 6,cnt_feins = '11-15' => 11,15)) ,named('ds_seleid_matrix_all'                     ))
    ,output(topn(ds_seleid_matrix_actives             ,500,ID,Notes,map(cnt_feins in ['0','1','2','3','4','5'] => (unsigned)cnt_feins,cnt_feins = '6-10' => 6,cnt_feins = '11-15' => 11,15)) ,named('ds_seleid_matrix_actives'                 ))
    ,output(topn(ds_seleid_matrix_golds               ,500,ID,Notes,map(cnt_feins in ['0','1','2','3','4','5'] => (unsigned)cnt_feins,cnt_feins = '6-10' => 6,cnt_feins = '11-15' => 11,15)) ,named('ds_seleid_matrix_golds'                   ))
    ,output(topn(ds_proxid_matrix_all                 ,500,ID,Notes,map(cnt_feins in ['0','1','2','3','4','5'] => (unsigned)cnt_feins,cnt_feins = '6-10' => 6,cnt_feins = '11-15' => 11,15)) ,named('ds_proxid_matrix_all'                     ))
    ,output(topn(ds_proxid_matrix_actives             ,500,ID,Notes,map(cnt_feins in ['0','1','2','3','4','5'] => (unsigned)cnt_feins,cnt_feins = '6-10' => 6,cnt_feins = '11-15' => 11,15)) ,named('ds_proxid_matrix_actives'                 ))
    ,output(topn(ds_proxid_matrix_golds               ,500,ID,Notes,map(cnt_feins in ['0','1','2','3','4','5'] => (unsigned)cnt_feins,cnt_feins = '6-10' => 6,cnt_feins = '11-15' => 11,15)) ,named('ds_proxid_matrix_golds'                   ))
  ));

  return parallel(output_stat_matrix,output_samples);

endmacro;