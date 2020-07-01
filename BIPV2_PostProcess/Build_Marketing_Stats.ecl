import BIPV2;

EXPORT Build_Marketing_Stats (

   pversion             = 'bipv2.KeySuffix'                                             // -- build date
  ,pToday               = 'bipv2.KeySuffix_mod2.MostRecentWithIngestVersionDate'        // -- in case you want to run as of a date in the past.  default to date of newest data.
  ,pCurrentSprint       = '\'\''                                                        // -- Sprint #. Default will use the pversion to figure it out, but you can override that here.
  ,pKeyLinkidsMarketing = 'BIPV2.Key_BH_Linking_Ids.kFetch2_thor(,,,true,,\'built\')'   // -- Linkids key filtered for only marketing sources.  Uses the 'built' version by default because that contains the latest one in the build.
  ,pKeyLinkidsFull      = 'BIPV2.Key_BH_Linking_Ids.kFetch2_thor(,,,false,,\'built\')'  // -- Linkids key filtered for only marketing sources.  Uses the 'built' version by default because that contains the latest one in the build.
  ,pBIP_Clean_Base      = 'BIPV2.commonbase.ds_clean'                                   // -- clean base file(contacts new status score fields).  to use to recalc gold the new way.

) := 
functionmacro

  import BIPV2_PostProcess,STD,BIPV2,BIPV2_Statuses;

  CurrentSprint := if(trim(pCurrentSprint) != '' 
                      ,pCurrentSprint
                      ,'Sprint ' + (string)BIPV2.KeySuffix_mod2.SprintNumber(pversion)
                   );

  ds_linkids_marketing_prep := project(pKeyLinkidsMarketing  ,transform(BIPV2.CommonBase.layout,self := left,self := []));
  ds_linkids_full_prep      := project(pKeyLinkidsFull       ,transform(BIPV2.CommonBase.layout,self := left,self := []));

  // full base file contains new status score fields.  need these to calculate new gold
  // sele_gold does not contain new value for gold though, so that needs to be calculated
  
  // -- calc new gold on base file with all records.
  ds_bip_base       := BIPV2_Statuses.mac_Calculate_Gold(pBIP_Clean_Base);
  ds_bip_base_slim  := table(ds_bip_base  ,{seleid,sele_gold} ,seleid,sele_gold ,merge);

  // -- patch new gold onto marketing and full linkids datasets.  don't need scores for marketing data fill rates yet
  ds_linkids_marketing := join(ds_linkids_marketing_prep  ,ds_bip_base_slim(sele_gold = 'G')  ,left.seleid = right.seleid ,transform(recordof(left),self.sele_gold := if(right.seleid != 0  ,'G',''),self := left)  ,left outer,hash) : persist('~persist::BIPV2_PostProcess::Build_Marketing_Stats::ds_linkids_marketing'  );
  ds_linkids_full      := join(ds_linkids_full_prep       ,ds_bip_base_slim(sele_gold = 'G')  ,left.seleid = right.seleid ,transform(recordof(left),self.sele_gold := if(right.seleid != 0  ,'G',''),self := left)  ,left outer,hash) : persist('~persist::BIPV2_PostProcess::Build_Marketing_Stats::ds_linkids_full'       );

  #UNIQUENAME(ProxFree)
  #UNIQUENAME(PowFree )
  #UNIQUENAME(SeleFree)
  #UNIQUENAME(SeleFreeGold)
  #UNIQUENAME(OrgFree )
  #UNIQUENAME(ProxProb)
  #UNIQUENAME(PowProb )
  #UNIQUENAME(SeleProb)
  #UNIQUENAME(SeleProbGold)
  #UNIQUENAME(OrgProb )
  
  BIPV2_PostProcess.macPartition(ds_linkids_marketing, ProxID, %ProxFree%, %ProxProb%)
  BIPV2_PostProcess.macPartition(ds_linkids_marketing, POWID,  %PowFree%,  %PowProb% )
  BIPV2_PostProcess.macPartition(ds_linkids_marketing, SELEID, %SeleFree%, %SeleProb%)
  BIPV2_PostProcess.macPartition(ds_linkids_full     , SELEID, %SeleFreeGold%, %SeleProbGold%)
  BIPV2_PostProcess.macPartition(ds_linkids_marketing, OrgID,  %OrgFree%,  %OrgProb% )

  // Gold Segmentation
  modgoldSELEV2_marketing      := BIPV2_PostProcess.segmentation_gold (%SeleFreeGold% ,'SELEID'   ,pToday ,'_V2_BIPV2_PostProcess__Build_Marketing_Stats' );
  modProxV2_marketing          := BIPV2_PostProcess.segmentation      (%ProxFree% ,'PROXID'   ,pToday                                                 );
  modPowV2_marketing           := BIPV2_PostProcess.segmentation      (%PowFree%  ,'POWID'    ,pToday                                                 );
  modSeleV2_marketing          := BIPV2_PostProcess.segmentation      (%SeleFree% ,'SELEID'   ,pToday                                                 );
  modorgV2_marketing           := BIPV2_PostProcess.segmentation      (%OrgFree%  ,'ORGID'    ,pToday                                                 );

  ds_recalcd_gold := project(modgoldSELEV2_marketing._gold,    transform(BIPV2_PostProcess.layouts.laysegmentation, self := left, self.inactive := left.inactives[1].inactive, self := []));
  ds_get_orig_gold := join(ds_recalcd_gold  ,table(%SeleFree%(sele_gold = 'G') ,{seleid} ,seleid ,merge)  ,left.ID = right.seleid ,transform(recordof(left),self := left)  ,hash ,keep(1));

  Proxstats_marketing          := BIPV2_PostProcess.fieldstats_prox  (pversion  ,ds_linkids_marketing ,modProxV2_marketing.result);
  Powstats_marketing           := BIPV2_PostProcess.fieldstats_pow   (pversion  ,ds_linkids_marketing ,modPowV2_marketing.result );
  Selestats_marketing          := BIPV2_PostProcess.fieldstats_sele  (pversion  ,ds_linkids_marketing ,modSeleV2_marketing.result);
  orgstats_marketing           := BIPV2_PostProcess.fieldstats_org   (pversion  ,ds_linkids_marketing ,modOrgV2_marketing.result );
  SelestatsGold_marketing      := BIPV2_PostProcess.fieldstats_sele  (pversion  ,ds_linkids_marketing ,pSegStats := ds_get_orig_gold);

  // activeStats_prox           := output(Proxstats.active_fieldStats         , named('V2_FieldStats_Active_PROX'           ));
  // activeStats_pow            := output(Powstats.active_fieldStats          , named('V2_FieldStats_Active_POW'            ));
  // activeStats_sele           := output(Selestats.active_fieldStats         , named('V2_FieldStats_Active_SELE'           ));
  // activeStats_org            := output(orgstats.active_fieldStats          , named('V2_FieldStats_Active_ORG'            ));
  // activeStats_sele_Gold      := output(SelestatsGold.active_fieldStats     , named('V2_FieldStats_Active_SELE_Gold'      ));   
  // inactiveStats_prox         := output(Proxstats.inactive_fieldStats       , named('V2_FieldStats_Inactive_PROX'         ));
  // inactiveStats_pow          := output(Powstats.inactive_fieldStats        , named('V2_FieldStats_Inactive_POW'          ));
  // inactiveStats_sele         := output(Selestats.inactive_fieldStats       , named('V2_FieldStats_Inactive_SELE'         ));
  // inactiveStats_org          := output(orgstats.inactive_fieldStats        , named('V2_FieldStats_Inactive_ORG'          ));

  V2FieldStatsActivePROX_marketing	    :=  Proxstats_marketing.active_fieldStats     ; 
  V2FieldStatsInactivePROX_marketing    :=  Proxstats_marketing.inactive_fieldStats   ; 
    
  V2FieldStatsActivePOW_marketing	      :=  Powstats_marketing.active_fieldStats      ; 
  V2FieldStatsInactivePOW_marketing     :=  Powstats_marketing.inactive_fieldStats    ; 
  
  V2FieldStatsActiveSELE_marketing	    :=  Selestats_marketing.active_fieldStats     ; 
  V2FieldStatsInactiveSELE_marketing    :=  Selestats_marketing.inactive_fieldStats   ; 
  V2FieldStatsActiveSELEGold_marketing  :=  SelestatsGold_marketing.active_fieldStats ;
  
  V2FieldStatsActiveORG_marketing	      :=  orgstats_marketing.active_fieldStats      ; 
  V2FieldStatsInactiveORG_marketing	    :=  orgstats_marketing.inactive_fieldStats    ; 

  PAM	:=  V2FieldStatsActivePROX_marketing      [1];
  PIM :=  V2FieldStatsInactivePROX_marketing    [1];
  
  WAM	:=  V2FieldStatsActivePOW_marketing       [1];
  WIM	:=  V2FieldStatsInactivePOW_marketing     [1];
  
  SAM	:=  V2FieldStatsActiveSELE_marketing      [1];
  SIM :=  V2FieldStatsInactiveSELE_marketing    [1];
  SGM :=  V2FieldStatsActiveSELEGold_marketing  [1];
  
  OAM	:=  V2FieldStatsActiveORG_marketing       [1];
  OIM	:=  V2FieldStatsInactiveORG_marketing     [1];

  real PATM := (real) PAM.countgroup;
  real PITM := (real) PIM.countgroup;
  real WATM := (real) WAM.countgroup;
  real WITM := (real) WIM.countgroup;
  real SATM := (real) SAM.countgroup;
  real SITM := (real) SIM.countgroup;
  real SGTM := (real) SGM.countgroup;
  real OATM := (real) OAM.countgroup;
  real OITM := (real) OIM.countgroup;
                 
  Data_Fill_Rates_marketing :=dataset([
     {'Current Build Fill Rates for Marketing','','','','','','','','','','','','','','','','','','','',''}
    ,{BIPV2_PostProcess.FormatDate(pVersion),'PROXID','','SELEID','','','ORGID','','POWID','','',                                         '','PROXID','','SELEID','','','ORGID','','POWID',''}
    ,{''               ,'Active'                      ,'Inactive'                     ,'Active'                       ,'Inactive'                     ,'Act Gold'                     ,'Active'                       ,'Inactive'                     ,'Active'                       ,'Inactive'                    ,'' ,''               ,'Active'                ,'Inactive'              ,'Active'                ,'Inactive'              ,'Act Gold'              ,'Active'                ,'Inactive'              ,'Active'                ,'Inactive'              }
    ,{'Address','','','','','','','','','','','Address','','','','','','','','',''}
    ,{'Street'         ,PAM.prim_name          /PATM  ,PIM.prim_name           /PITM  ,SAM.prim_name           /SATM  ,SIM.prim_name           /SITM  ,SGM.prim_name           /SGTM  ,OAM.prim_name           /OATM  ,OIM.prim_name           /OITM  ,WAM.prim_name           /WATM  ,WIM.prim_name          /WITM  ,'' ,'Street'         ,PAM.prim_name           ,PIM.prim_name           ,SAM.prim_name           ,SIM.prim_name           ,SGM.prim_name           ,OAM.prim_name           ,OIM.prim_name           ,WAM.prim_name           ,WIM.prim_name           }
    ,{'City'           ,PAM.v_city_name        /PATM  ,PIM.v_city_name         /PITM  ,SAM.v_city_name         /SATM  ,SIM.v_city_name         /SITM  ,SGM.v_city_name         /SGTM  ,OAM.v_city_name         /OATM  ,OIM.v_city_name         /OITM  ,WAM.v_city_name         /WATM  ,WIM.v_city_name        /WITM  ,'' ,'City'           ,PAM.v_city_name         ,PIM.v_city_name         ,SAM.v_city_name         ,SIM.v_city_name         ,SGM.v_city_name         ,OAM.v_city_name         ,OIM.v_city_name         ,WAM.v_city_name         ,WIM.v_city_name         }
    ,{'State'          ,PAM.st                 /PATM  ,PIM.st                  /PITM  ,SAM.st                  /SATM  ,SIM.st                  /SITM  ,SGM.st                  /SGTM  ,OAM.st                  /OATM  ,OIM.st                  /OITM  ,WAM.st                  /WATM  ,WIM.st                 /WITM  ,'' ,'State'          ,PAM.st                  ,PIM.st                  ,SAM.st                  ,SIM.st                  ,SGM.st                  ,OAM.st                  ,OIM.st                  ,WAM.st                  ,WIM.st                  }
    ,{'ZIP'            ,PAM.zip                /PATM  ,PIM.zip                 /PITM  ,SAM.zip                 /SATM  ,SIM.zip                 /SITM  ,SGM.zip                 /SGTM  ,OAM.zip                 /OATM  ,OIM.zip                 /OITM  ,WAM.zip                 /WATM  ,WIM.zip                /WITM  ,'' ,'ZIP'            ,PAM.zip                 ,PIM.zip                 ,SAM.zip                 ,SIM.zip                 ,SGM.zip                 ,OAM.zip                 ,OIM.zip                 ,WAM.zip                 ,WIM.zip                 }
    ,{'Phone'          ,PAM.company_phone      /PATM  ,PIM.company_phone       /PITM  ,SAM.company_phone       /SATM  ,SIM.company_phone       /SITM  ,SGM.company_phone       /SGTM  ,OAM.company_phone       /OATM  ,OIM.company_phone       /OITM  ,WAM.company_phone       /WATM  ,WIM.company_phone      /WITM  ,'' ,'Phone'          ,PAM.company_phone       ,PIM.company_phone       ,SAM.company_phone       ,SIM.company_phone       ,SGM.company_phone       ,OAM.company_phone       ,OIM.company_phone       ,WAM.company_phone       ,WIM.company_phone       }
    ,{'DBA'            ,PAM.dba_name           /PATM  ,PIM.dba_name            /PITM  ,SAM.dba_name            /SATM  ,SIM.dba_name            /SITM  ,SGM.dba_name            /SGTM  ,OAM.dba_name            /OATM  ,OIM.dba_name            /OITM  ,WAM.dba_name            /WATM  ,WIM.dba_name           /WITM  ,'' ,'DBA'            ,PAM.dba_name            ,PIM.dba_name            ,SAM.dba_name            ,SIM.dba_name            ,SGM.dba_name            ,OAM.dba_name            ,OIM.dba_name            ,WAM.dba_name            ,WIM.dba_name            }
    ,{'Industry'       ,'','','','','','','','','','','Industry','','','','','','','','',''}                                                                                                                                                                                                                                                                                                                                                                                                                                                      
    ,{'SIC Primary'    ,PAM.company_sic_code1  /PATM  ,PIM.company_sic_code1   /PITM  ,SAM.company_sic_code1   /SATM  ,SIM.company_sic_code1   /SITM  ,SGM.company_sic_code1   /SGTM  ,OAM.company_sic_code1   /OATM  ,OIM.company_sic_code1   /OITM  ,WAM.company_sic_code1   /WATM  ,WIM.company_sic_code1  /WITM  ,'' ,'SIC Primary'    ,PAM.company_sic_code1   ,PIM.company_sic_code1   ,SAM.company_sic_code1   ,SIM.company_sic_code1   ,SGM.company_sic_code1   ,OAM.company_sic_code1   ,OIM.company_sic_code1   ,WAM.company_sic_code1   ,WIM.company_sic_code1   }
    ,{'NAICS Primary'  ,PAM.company_naics_code1/PATM  ,PIM.company_naics_code1 /PITM  ,SAM.company_naics_code1 /SATM  ,SIM.company_naics_code1 /SITM  ,SGM.company_naics_code1 /SGTM  ,OAM.company_naics_code1 /OATM  ,OIM.company_naics_code1 /OITM  ,WAM.company_naics_code1 /WATM  ,WIM.company_naics_code1/WITM  ,'' ,'NAICS Primary'  ,PAM.company_naics_code1 ,PIM.company_naics_code1 ,SAM.company_naics_code1 ,SIM.company_naics_code1 ,SGM.company_naics_code1 ,OAM.company_naics_code1 ,OIM.company_naics_code1 ,WAM.company_naics_code1 ,WIM.company_naics_code1 }
    ,{'Contact'        ,'','','','','','','','','','','Contact','','','','','','','','',''}                                                                                                                                                                                                                                                                                                                                                                                                                                                       
    ,{'Name'           ,PAM.lname              /PATM  ,PIM.lname               /PITM  ,SAM.lname               /SATM  ,SIM.lname               /SITM  ,SGM.lname               /SGTM  ,OAM.lname               /OATM  ,OIM.lname               /OITM  ,WAM.lname               /WATM  ,WIM.lname              /WITM  ,'' ,'Name'           ,PAM.lname               ,PIM.lname               ,SAM.lname               ,SIM.lname               ,SGM.lname               ,OAM.lname               ,OIM.lname               ,WAM.lname               ,WIM.lname               }
    ,{'Email'          ,PAM.contact_email      /PATM  ,PIM.contact_email       /PITM  ,SAM.contact_email       /SATM  ,SIM.contact_email       /SITM  ,SGM.contact_email       /SGTM  ,OAM.contact_email       /OATM  ,OIM.contact_email       /OITM  ,WAM.contact_email       /WATM  ,WIM.contact_email      /WITM  ,'' ,'Email'          ,PAM.contact_email       ,PIM.contact_email       ,SAM.contact_email       ,SIM.contact_email       ,SGM.contact_email       ,OAM.contact_email       ,OIM.contact_email       ,WAM.contact_email       ,WIM.contact_email       }
    ,{'Phone'          ,PAM.contact_phone      /PATM  ,PIM.contact_phone       /PITM  ,SAM.contact_phone       /SATM  ,SIM.contact_phone       /SITM  ,SGM.contact_phone       /SGTM  ,OAM.contact_phone       /OATM  ,OIM.contact_phone       /OITM  ,WAM.contact_phone       /WATM  ,WIM.contact_phone      /WITM  ,'' ,'Phone'          ,PAM.contact_phone       ,PIM.contact_phone       ,SAM.contact_phone       ,SIM.contact_phone       ,SGM.contact_phone       ,OAM.contact_phone       ,OIM.contact_phone       ,WAM.contact_phone       ,WIM.contact_phone       }
    ,{'Other Content'  ,'','','','','','','','','','',                                                              'Other Content','','','','','','','', '',''}                                                                                                                                                                                                                                                                                                                                                                                       
    ,{'FEIN'           ,PAM.company_fein       /PATM  ,PIM.company_fein        /PITM  ,SAM.company_fein        /SATM  ,SIM.company_fein        /SITM  ,SGM.company_fein        /SGTM  ,OAM.company_fein        /OATM  ,OIM.company_fein        /OITM  ,WAM.company_fein        /WATM  ,WIM.company_fein       /WITM  ,'' ,'FEIN'           ,PAM.company_fein        ,PIM.company_fein        ,SAM.company_fein        ,SIM.company_fein        ,SGM.company_fein        ,OAM.company_fein        ,OIM.company_fein        ,WAM.company_fein        ,WIM.company_fein        }
    ,{'Ticker'         ,PAM.company_ticker     /PATM  ,PIM.company_ticker      /PITM  ,SAM.company_ticker      /SATM  ,SIM.company_ticker      /SITM  ,SGM.company_ticker      /SGTM  ,OAM.company_ticker      /OATM  ,OIM.company_ticker      /OITM  ,WAM.company_ticker      /WATM  ,WIM.company_ticker     /WITM  ,'' ,'Ticker'         ,PAM.company_ticker      ,PIM.company_ticker      ,SAM.company_ticker      ,SIM.company_ticker      ,SGM.company_ticker      ,OAM.company_ticker      ,OIM.company_ticker      ,WAM.company_ticker      ,WIM.company_ticker      }
    ,{'URL'            ,PAM.company_url        /PATM  ,PIM.company_url         /PITM  ,SAM.company_url         /SATM  ,SIM.company_url         /SITM  ,SGM.company_url         /SGTM  ,OAM.company_url         /OATM  ,OIM.company_url         /OITM  ,WAM.company_url         /WATM  ,WIM.company_url        /WITM  ,'' ,'URL'            ,PAM.company_url         ,PIM.company_url         ,SAM.company_url         ,SIM.company_url         ,SGM.company_url         ,OAM.company_url         ,OIM.company_url         ,WAM.company_url         ,WIM.company_url         }

    ,{'WU: '+workunit  ,''                            ,''                             ,''                             ,''                             ,''                             ,''                             ,''                             ,''                             ,''                           ,''  ,'Totals:'        ,PATM                    ,PITM                    ,SATM                    ,SITM                    ,SGTM                    ,OATM                    ,OITM                    ,WATM                    ,WITM                    }
    ,{CurrentSprint,'','','','','','','','','','','','','','','','','','','',''}
    ,{'Build: ' + pVersion,'','','','','','','','','','','','','','','','','','','',''}
  ],BIPV2_PostProcess.layouts.Data_Fill_Rates);


  return sequential(
     output(pversion                    ,named('Marketing_Version'                  ))
    ,output(CurrentSprint               ,named('Marketing_CurrentSprint'            ))
    ,output(pToday                      ,named('Marketing_pToday'                   ))
    ,output(Data_Fill_Rates_marketing   ,named('Marketing_Data_Fill_Rates'          ))
  );
  
endmacro;