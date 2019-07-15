/*
  stats to run(on dev2 25th iteration):
    how often does more than 1 god key match?
    how often does more than 1 type of god key match(duns,corpkey,ent num)?
    how often is cnp name score >0 and a god key matches(active)
    same as above, but with more than 1 type of god key
*/
#workunit('name','Proxid God Key Matches Stats');
kmtchsmpl  := index(BIPV2_ProxID.Keys(BIPV2_ProxID.In_DOT_Base).MatchSample ,BIPV2_ProxID.keynames('20130212_25').match_sample_debug.logical);
kmtchgt21 := kmtchsmpl(conf >= 21);
ddev2      := BIPV2_ProxID.files('20130212_25').base.logical;

dproj := project(
  kmtchgt21
  ,transform(
    {recordof(kmtchsmpl),unsigned2 countGodKeyMatches,unsigned2 countGodKeyTypeMatches,unsigned2 countGodKeyMatchesWithCnpName,unsigned2 countGodKeyTypeMatchesWithCnpName
    ,unsigned2 countActiveGodKeyMatches,unsigned2 countActiveGodKeyTypeMatches,unsigned2 countActiveGodKeyMatchesWithCnpName,unsigned2 countActiveGodKeyTypeMatchesWithCnpName    
    ,unsigned2 countHistGodKeyMatches,unsigned2 countHistGodKeyTypeMatches,unsigned2 countHistGodKeyMatchesWithCnpName,unsigned2 countHistGodKeyTypeMatchesWithCnpName    
    ,unsigned2 countActiveOnlyGodKeyMatches,unsigned2 countActiveOnlyGodKeyTypeMatches,unsigned2 countActiveOnlyGodKeyMatchesWithCnpName,unsigned2 countActiveOnlyGodKeyTypeMatchesWithCnpName    
    },
    active_enterprise_number_score  := if(left.active_enterprise_number_score > 0  ,1  ,0);
    active_domestic_corp_key_score  := if(left.active_domestic_corp_key_score > 0  ,1  ,0);
    active_duns_number_score        := if(left.active_duns_number_score       > 0  ,1  ,0);
    hist_enterprise_number_score    := if(left.hist_enterprise_number_score   > 0  ,1  ,0);
    hist_domestic_corp_key_score    := if(left.hist_domestic_corp_key_score   > 0  ,1  ,0);
    hist_duns_number_score          := if(left.hist_duns_number_score         > 0  ,1  ,0);
    foreign_corp_key_score          := if(left.foreign_corp_key_score         > 0  ,1  ,0);
    unk_corp_key_score              := if(left.unk_corp_key_score             > 0  ,1  ,0);

    countGodKeyMatches              := 
        active_enterprise_number_score
      + active_domestic_corp_key_score
      + active_duns_number_score      
      + hist_enterprise_number_score  
      + hist_domestic_corp_key_score  
      + hist_duns_number_score         
      + foreign_corp_key_score        
      + unk_corp_key_score 
      ;
    countGodKeyTypeMatches          := 
        if((active_enterprise_number_score  + hist_enterprise_number_score                                              ) > 0  ,1  ,0)
      + if((active_domestic_corp_key_score  + hist_domestic_corp_key_score + foreign_corp_key_score + unk_corp_key_score) > 0  ,1  ,0)
      + if((active_duns_number_score        + hist_duns_number_score                                                    ) > 0  ,1  ,0)
      ;
    countGodKeyMatchesWithCnpName := 
      if(countGodKeyMatches     > 0 and left.cnp_name_score > 0  ,countGodKeyMatches     ,0);
      
    countGodKeyTypeMatchesWithCnpName := 
      if(countGodKeyTypeMatches > 0 and left.cnp_name_score > 0  ,countGodKeyTypeMatches ,0);
    
    countActiveGodKeyMatches              := 
        active_enterprise_number_score
      + active_domestic_corp_key_score
      + active_duns_number_score      
      ;
    countActiveGodKeyTypeMatches          := 
        if(active_enterprise_number_score   > 0  ,1  ,0)
      + if(active_domestic_corp_key_score   > 0  ,1  ,0)
      + if(active_duns_number_score         > 0  ,1  ,0)
      ;
    countActiveGodKeyMatchesWithCnpName := 
      if(countActiveGodKeyMatches     > 0 and left.cnp_name_score > 0  ,countActiveGodKeyMatches     ,0);
      
    countActiveGodKeyTypeMatchesWithCnpName := 
      if(countActiveGodKeyTypeMatches > 0 and left.cnp_name_score > 0  ,countActiveGodKeyTypeMatches ,0);


    countHistGodKeyMatches              := 
      + hist_enterprise_number_score  
      + hist_domestic_corp_key_score  
      + hist_duns_number_score         
      ;
      
    countHistGodKeyTypeMatches          := 
        if(hist_enterprise_number_score  > 0  ,1  ,0)
      + if(hist_domestic_corp_key_score  > 0  ,1  ,0)
      + if(hist_duns_number_score        > 0  ,1  ,0)
      ;
    countHistGodKeyMatchesWithCnpName := 
      if(countHistGodKeyMatches     > 0 and left.cnp_name_score > 0  ,countHistGodKeyMatches     ,0);
      
    countHistGodKeyTypeMatchesWithCnpName := 
      if(countHistGodKeyTypeMatches > 0 and left.cnp_name_score > 0  ,countHistGodKeyTypeMatches ,0);

    self.countGodKeyMatches                       := countGodKeyMatches                     ;
    self.countGodKeyTypeMatches                   := countGodKeyTypeMatches                 ;
    self.countGodKeyMatchesWithCnpName            := countGodKeyMatchesWithCnpName          ;
    self.countGodKeyTypeMatchesWithCnpName        := countGodKeyTypeMatchesWithCnpName      ;

    self.countActiveGodKeyMatches                 := countActiveGodKeyMatches               ;
    self.countActiveGodKeyTypeMatches             := countActiveGodKeyTypeMatches           ;
    self.countActiveGodKeyMatchesWithCnpName      := countActiveGodKeyMatchesWithCnpName    ;
    self.countActiveGodKeyTypeMatchesWithCnpName  := countActiveGodKeyTypeMatchesWithCnpName;

    self.countActiveOnlyGodKeyMatches                 := if(countHistGodKeyMatches                = 0  ,countActiveGodKeyMatches               ,0);
    self.countActiveOnlyGodKeyTypeMatches             := if(countHistGodKeyTypeMatches            = 0  ,countActiveGodKeyTypeMatches           ,0);
    self.countActiveOnlyGodKeyMatchesWithCnpName      := if(countHistGodKeyMatchesWithCnpName     = 0  ,countActiveGodKeyMatchesWithCnpName    ,0);
    self.countActiveOnlyGodKeyTypeMatchesWithCnpName  := if(countHistGodKeyTypeMatchesWithCnpName = 0  ,countActiveGodKeyTypeMatchesWithCnpName,0);

    self.countHistGodKeyMatches                   := countHistGodKeyMatches                 ;
    self.countHistGodKeyTypeMatches               := countHistGodKeyTypeMatches             ;
    self.countHistGodKeyMatchesWithCnpName        := countHistGodKeyMatchesWithCnpName      ;
    self.countHistGodKeyTypeMatchesWithCnpName    := countHistGodKeyTypeMatchesWithCnpName  ;
    
    self                                          := left                                   ;

  )
);

tools.mac_LayoutTools(recordof(dproj),justscore  ,false,false,'^(?=.*?(score|count).*).*$'    ,true);
dslim := project(dproj,justscore.layout_record);
output(strata.macf_pops(dslim)  ,named('GodKeyPops'));

//output samples
dGodKeyMatches                            := dproj(countGodKeyMatches                 > 0);
dGodKeyTypeMatches                        := dproj(countGodKeyTypeMatches             > 0);
dGodKeyMatchesWithCnpName                 := dproj(countGodKeyMatchesWithCnpName      > 0);
dGodKeyTypeMatchesWithCnpName             := dproj(countGodKeyTypeMatchesWithCnpName  > 0);
dGodKeyMatchesGT1                         := dproj(countGodKeyMatches                 > 1);
dGodKeyTypeMatchesGT1                     := dproj(countGodKeyTypeMatches             > 1);
dGodKeyMatchesWithCnpNameGT1              := dproj(countGodKeyMatchesWithCnpName      > 1);
dGodKeyTypeMatchesWithCnpNameGT1          := dproj(countGodKeyTypeMatchesWithCnpName  > 1);

dActiveGodKeyMatches                      := dproj(countActiveGodKeyMatches                 > 0);
dActiveGodKeyTypeMatches                  := dproj(countActiveGodKeyTypeMatches             > 0);
dActiveGodKeyMatchesWithCnpName           := dproj(countActiveGodKeyMatchesWithCnpName      > 0);
dActiveGodKeyTypeMatchesWithCnpName       := dproj(countActiveGodKeyTypeMatchesWithCnpName  > 0);
dActiveGodKeyMatchesGT1                   := dproj(countActiveGodKeyMatches                 > 1);
dActiveGodKeyTypeMatchesGT1               := dproj(countActiveGodKeyTypeMatches             > 1);
dActiveGodKeyMatchesWithCnpNameGT1        := dproj(countActiveGodKeyMatchesWithCnpName      > 1);
dActiveGodKeyTypeMatchesWithCnpNameGT1    := dproj(countActiveGodKeyTypeMatchesWithCnpName  > 1);

dActiveOnlyGodKeyMatches                  := dproj(countActiveOnlyGodKeyMatches                 > 0);
dActiveOnlyGodKeyTypeMatches              := dproj(countActiveOnlyGodKeyTypeMatches             > 0);
dActiveOnlyGodKeyMatchesWithCnpName       := dproj(countActiveOnlyGodKeyMatchesWithCnpName      > 0);
dActiveOnlyGodKeyTypeMatchesWithCnpName   := dproj(countActiveOnlyGodKeyTypeMatchesWithCnpName  > 0);
dActiveOnlyGodKeyMatchesGT1               := dproj(countActiveOnlyGodKeyMatches                 > 1);
dActiveOnlyGodKeyTypeMatchesGT1           := dproj(countActiveOnlyGodKeyTypeMatches             > 1);
dActiveOnlyGodKeyMatchesWithCnpNameGT1    := dproj(countActiveOnlyGodKeyMatchesWithCnpName      > 1);
dActiveOnlyGodKeyTypeMatchesWithCnpNameGT1:= dproj(countActiveOnlyGodKeyTypeMatchesWithCnpName  > 1);

dHistGodKeyMatches                        := dproj(countHistGodKeyMatches                 > 0);
dHistGodKeyTypeMatches                    := dproj(countHistGodKeyTypeMatches             > 0);
dHistGodKeyMatchesWithCnpName             := dproj(countHistGodKeyMatchesWithCnpName      > 0);
dHistGodKeyTypeMatchesWithCnpName         := dproj(countHistGodKeyTypeMatchesWithCnpName  > 0);
dHistGodKeyMatchesGT1                     := dproj(countHistGodKeyMatches                 > 1);
dHistGodKeyTypeMatchesGT1                 := dproj(countHistGodKeyTypeMatches             > 1);
dHistGodKeyMatchesWithCnpNameGT1          := dproj(countHistGodKeyMatchesWithCnpName      > 1);
dHistGodKeyTypeMatchesWithCnpNameGT1      := dproj(countHistGodKeyTypeMatchesWithCnpName  > 1);

dsummary := dataset([
   {'Total Matches'                                   ,count(kmtchsmpl                              )}
  ,{'Matches > 21 conf'                               ,count(kmtchgt21                              )}
  ,{'God Key > 0'                                     ,count(dGodKeyMatches                         )}
  ,{'God Key Type > 0'                                ,count(dGodKeyTypeMatches                    )}
  ,{'God Key > 0 and cnp name score > 0'              ,count(dGodKeyMatchesWithCnpName             )}
  ,{'God Key Type > 0 and cnp name score > 0'         ,count(dGodKeyTypeMatchesWithCnpName         )}
  ,{'God Key > 1'                                     ,count(dGodKeyMatchesGT1                     )}
  ,{'God Key Type > 1'                                ,count(dGodKeyTypeMatchesGT1                 )}
  ,{'God Key > 1 and cnp name score > 0'              ,count(dGodKeyMatchesWithCnpNameGT1          )}
  ,{'God Key Type > 1 and cnp name score > 0'         ,count(dGodKeyTypeMatchesWithCnpNameGT1      )}

  ,{'Active God Key > 0'                              ,count(dActiveGodKeyMatches                  )}
  ,{'Active God Key Type > 0'                         ,count(dActiveGodKeyTypeMatches              )}
  ,{'Active God Key > 0 and cnp name score > 0'       ,count(dActiveGodKeyMatchesWithCnpName       )}
  ,{'Active God Key Type > 0 and cnp name score > 0'  ,count(dActiveGodKeyTypeMatchesWithCnpName   )}
  ,{'Active God Key > 1'                              ,count(dActiveGodKeyMatchesGT1               )}
  ,{'Active God Key Type > 1'                         ,count(dActiveGodKeyTypeMatchesGT1           )}
  ,{'Active God Key > 1 and cnp name score > 0'       ,count(dActiveGodKeyMatchesWithCnpNameGT1    )}
  ,{'Active God Key Type > 1 and cnp name score > 0'  ,count(dActiveGodKeyTypeMatchesWithCnpNameGT1)}
  
  ,{'Active Only God Key > 0'                              ,count(dActiveOnlyGodKeyMatches                  )}
  ,{'Active Only God Key Type > 0'                         ,count(dActiveOnlyGodKeyTypeMatches              )}
  ,{'Active Only God Key > 0 and cnp name score > 0'       ,count(dActiveOnlyGodKeyMatchesWithCnpName       )}
  ,{'Active Only God Key Type > 0 and cnp name score > 0'  ,count(dActiveOnlyGodKeyTypeMatchesWithCnpName   )}
  ,{'Active Only God Key > 1'                              ,count(dActiveOnlyGodKeyMatchesGT1               )}
  ,{'Active Only God Key Type > 1'                         ,count(dActiveOnlyGodKeyTypeMatchesGT1           )}
  ,{'Active Only God Key > 1 and cnp name score > 0'       ,count(dActiveOnlyGodKeyMatchesWithCnpNameGT1    )}
  ,{'Active Only God Key Type > 1 and cnp name score > 0'  ,count(dActiveOnlyGodKeyTypeMatchesWithCnpNameGT1)}

  ,{'Historical God Key > 0'                              ,count(dHistGodKeyMatches                  )}
  ,{'Historical God Key Type > 0'                         ,count(dHistGodKeyTypeMatches              )}
  ,{'Historical God Key > 0 and cnp name score > 0'       ,count(dHistGodKeyMatchesWithCnpName       )}
  ,{'Historical God Key Type > 0 and cnp name score > 0'  ,count(dHistGodKeyTypeMatchesWithCnpName   )}
  ,{'Historical God Key > 1'                              ,count(dHistGodKeyMatchesGT1               )}
  ,{'Historical God Key Type > 1'                         ,count(dHistGodKeyTypeMatchesGT1           )}
  ,{'Historical God Key > 1 and cnp name score > 0'       ,count(dHistGodKeyMatchesWithCnpNameGT1    )}
  ,{'Historical God Key Type > 1 and cnp name score > 0'  ,count(dHistGodKeyTypeMatchesWithCnpNameGT1)}

],{string name,unsigned8 value});

output(dsummary ,named('GodKeySummary'),all);

output(enth(dGodKeyMatches                  ,50) ,named('dGodKeyMatches'                   ));
output(enth(dGodKeyTypeMatches              ,50) ,named('dGodKeyTypeMatches'               ));
output(enth(dGodKeyMatchesWithCnpName       ,50) ,named('dGodKeyMatchesWithCnpName'        ));
output(enth(dGodKeyTypeMatchesWithCnpName   ,50) ,named('dGodKeyTypeMatchesWithCnpName'    ));
output(enth(dGodKeyMatchesGT1               ,50) ,named('dGodKeyMatchesGT1'                ));
output(enth(dGodKeyTypeMatchesGT1           ,50) ,named('dGodKeyTypeMatchesGT1'            ));
output(enth(dGodKeyMatchesWithCnpNameGT1    ,50) ,named('dGodKeyMatchesWithCnpNameGT1'     ));
output(enth(dGodKeyTypeMatchesWithCnpNameGT1,50) ,named('dGodKeyTypeMatchesWithCnpNameGT1' ));

output(enth(dActiveGodKeyMatches                  ,50) ,named('dActiveGodKeyMatches'                    ));
output(enth(dActiveGodKeyTypeMatches              ,50) ,named('dActiveGodKeyTypeMatches'                ));
output(enth(dActiveGodKeyMatchesWithCnpName       ,50) ,named('dActiveGodKeyMatchesWithCnpName'         ));
output(enth(dActiveGodKeyTypeMatchesWithCnpName   ,50) ,named('dActiveGodKeyTypeMatchesWithCnpName'     ));
output(enth(dActiveGodKeyMatchesGT1               ,50) ,named('dActiveGodKeyMatchesGT1'                 ));
output(enth(dActiveGodKeyTypeMatchesGT1           ,50) ,named('dActiveGodKeyTypeMatchesGT1'             ));
output(enth(dActiveGodKeyMatchesWithCnpNameGT1    ,50) ,named('dActiveGodKeyMatchesWithCnpNameGT1'      ));
output(enth(dActiveGodKeyTypeMatchesWithCnpNameGT1,50) ,named('dActiveGodKeyTypeMatchesWithCnpNameGT1'  ));

output(enth(dActiveOnlyGodKeyMatches                  ,50) ,named('dActiveOnlyGodKeyMatches'                    ));
output(enth(dActiveOnlyGodKeyTypeMatches              ,50) ,named('dActiveOnlyGodKeyTypeMatches'                ));
output(enth(dActiveOnlyGodKeyMatchesWithCnpName       ,50) ,named('dActiveOnlyGodKeyMatchesWithCnpName'         ));
output(enth(dActiveOnlyGodKeyTypeMatchesWithCnpName   ,50) ,named('dActiveOnlyGodKeyTypeMatchesWithCnpName'     ));
output(enth(dActiveOnlyGodKeyMatchesGT1               ,50) ,named('dActiveOnlyGodKeyMatchesGT1'                 ));
output(enth(dActiveOnlyGodKeyTypeMatchesGT1           ,50) ,named('dActiveOnlyGodKeyTypeMatchesGT1'             ));
output(enth(dActiveOnlyGodKeyMatchesWithCnpNameGT1    ,50) ,named('dActiveOnlyGodKeyMatchesWithCnpNameGT1'      ));
output(enth(dActiveOnlyGodKeyTypeMatchesWithCnpNameGT1,50) ,named('dActiveOnlyGodKeyTypeMatchesWithCnpNameGT1'  ));

output(enth(dHistGodKeyMatches                  ,50) ,named('dHistGodKeyMatches'                    ));
output(enth(dHistGodKeyTypeMatches              ,50) ,named('dHistGodKeyTypeMatches'                ));
output(enth(dHistGodKeyMatchesWithCnpName       ,50) ,named('dHistGodKeyMatchesWithCnpName'         ));
output(enth(dHistGodKeyTypeMatchesWithCnpName   ,50) ,named('dHistGodKeyTypeMatchesWithCnpName'     ));
output(enth(dHistGodKeyMatchesGT1               ,50) ,named('dHistGodKeyMatchesGT1'                 ));
output(enth(dHistGodKeyTypeMatchesGT1           ,50) ,named('dHistGodKeyTypeMatchesGT1'             ));
output(enth(dHistGodKeyMatchesWithCnpNameGT1    ,50) ,named('dHistGodKeyMatchesWithCnpNameGT1'      ));
output(enth(dHistGodKeyTypeMatchesWithCnpNameGT1,50) ,named('dHistGodKeyTypeMatchesWithCnpNameGT1' ));
//output(justscore);
/*
justscore :=
module
	export layout_record :=
	record
		integer2             cnp_number_score                                                            ;
		integer2             prim_range_score                                                            ;
		integer2             prim_name_score                                                             ;
		integer2             st_score                                                                    ;
		integer2             ebr_file_number_score                                                       ;
		integer2             active_enterprise_number_score                                              ;
		integer2             hist_enterprise_number_score                                                ;
		integer2             hist_duns_number_score                                                      ;
		integer2             hist_domestic_corp_key_score                                                ;
		integer2             unk_corp_key_score                                                          ;
		integer2             company_fein_score                                                          ;
		integer2             active_domestic_corp_key_score                                              ;
		integer2             company_phone_score                                                         ;
		integer2             foreign_corp_key_score                                                      ;
		integer2             active_duns_number_score                                                    ;
		integer2             cnp_name_score                                                              ;
		integer2             zip_score                                                                   ;
		integer2             company_csz_score                                                           ;
		integer2             sec_range_score                                                             ;
		integer2             v_city_name_score                                                           ;
		integer2             cnp_btype_score                                                             ;
		integer2             iscorp_score                                                                ;
		integer2             company_addr1_score                                                         ;
		integer2             company_address_score                                                       ;
	end;
*/