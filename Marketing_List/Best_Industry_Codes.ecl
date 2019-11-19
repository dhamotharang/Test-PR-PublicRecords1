/*
  Get:
    SICs
    NAICSs

  use base file instead of best because the base file has the source of the sic code.  Best file does not.
*/  
  
  // -- 9.  pick best industry codes from single source using first 4 digits in this priority order(if same seleid and same unique id, then keep industry code with most recent dt last seen.  for tie breakers use one listed most often):
  // --     a. dca
  // --     b. equifax
  // --     c. osha
  // --     d. databridge
  // --     e. infutor narb
  // --     f. cortera
  // --     g. accutrend
import BIPV2;

EXPORT Best_Industry_Codes(

   dataset(recordof(Marketing_List.Source_Files().bip_base) ) pDataset_Base = Marketing_List.Source_Files().bip_base
  ,dataset(Marketing_List.Layouts.business_information_prep ) pBest_Prep    = Marketing_List.Best_From_BIP_Best_seleid()
  ,boolean                                                    pDebug          = false
  ,set of unsigned6                                           pSampleProxids  = []
) :=
function

  ds_base               := pDataset_Base;
  set_mktg_sources      := Marketing_List._Config().set_marketing_approved_sources;
  set_industry_sources  := Marketing_List._Config().set_sources_of_industry_codes ;
  ds_industry_sources   := Marketing_List._Config().ds_sources_of_industry_codes  ;

  // -- get debug seleids from proxids
  ds_debug_seleids  := table(pDataset_Base(proxid in pSampleProxids )  ,{seleid},seleid,few);
  set_debug_seleids := set(ds_debug_seleids ,seleid);

  ds_base_clean                   := ds_base;
  ds_base_filt                    := ds_base_clean(
                                       source in set_mktg_sources 
                                      ,source in set_industry_sources
                                      ,trim(seleid_status_public) = ''  //active  
                                      ,(   trim(company_sic_code1  ) != ''  or trim(company_sic_code2  ) != '' or trim(company_sic_code3  ) != '' or trim(company_sic_code4  ) != '' or trim(company_sic_code5  ) != ''
                                       or  trim(company_naics_code1) != ''  or trim(company_naics_code2) != '' or trim(company_naics_code3) != '' or trim(company_naics_code4) != '' or trim(company_naics_code5) != ''
                                    ));

  ds_Base_Prep  := table(ds_base_filt ,{seleid,source,unsigned4 dt_last_seen := max(group,dt_last_seen)
                    ,string4 company_sic_code1 := trim(company_sic_code1)[1..4]
                    ,string4 company_sic_code2 := trim(company_sic_code2)[1..4]
                    ,string4 company_sic_code3 := trim(company_sic_code3)[1..4]
                    ,string4 company_sic_code4 := trim(company_sic_code4)[1..4]
                    ,string4 company_sic_code5 := trim(company_sic_code5)[1..4]
                    ,company_naics_code1
                    ,company_naics_code2
                    ,company_naics_code3
                    ,company_naics_code4
                    ,company_naics_code5
                   },seleid,source  ,trim(company_sic_code1  )[1..4]  ,trim(company_sic_code2  )[1..4]  ,trim(company_sic_code3  )[1..4]  ,trim(company_sic_code4  )[1..4]  ,trim(company_sic_code5  )[1..4]
                                    ,     company_naics_code1         ,     company_naics_code2         ,     company_naics_code3         ,     company_naics_code4         ,     company_naics_code5  
                   ,merge);


  // -- normalize out the sic codes and naics codes so that I can count how many times each one occurs per seleid and source and dt_last_seen
  // -- then i can dedup to only get the ones from the latest dt_last_seen for that seleid and source.
  ds_base_add_priority := join(ds_Base_Prep ,ds_industry_sources  ,left.source = right.source ,transform({unsigned2 rank_order,recordof(left)},self := right,self := left) ,lookup);
  
  ds_base_dedup := dedup(sort(distribute(ds_base_add_priority  ,hash(seleid)) ,seleid,rank_order,-dt_last_seen ,local)  ,seleid ,local);
  
  ds_base_out := project(ds_base_dedup,transform(Marketing_List.Layouts.business_information_prep,

    ds_sics  := dataset([{left.company_sic_code1   },{left.company_sic_code2  },{left.company_sic_code3  },{left.company_sic_code4  },{left.company_sic_code5  }] ,{string4 sic  });
    ds_naics := dataset([{left.company_naics_code1 },{left.company_naics_code2},{left.company_naics_code3},{left.company_naics_code4},{left.company_naics_code5}] ,{string6 naics});
    
    ds_sics_nonblank  := ds_sics (sic   != '');
    ds_naics_nonblank := ds_naics(naics != '');
    
    self.SIC_Primary        := ds_sics_nonblank [1].sic;
    self.SIC2               := ds_sics_nonblank [2].sic;
    self.SIC3               := ds_sics_nonblank [3].sic;
    self.SIC4               := ds_sics_nonblank [4].sic;
    self.SIC5               := ds_sics_nonblank [5].sic;
    self.NAICS_Primary      := ds_naics_nonblank[1].naics;
    self.NAICS2             := ds_naics_nonblank[2].naics;
    self.NAICS3             := ds_naics_nonblank[3].naics;
    self.NAICS4             := ds_naics_nonblank[4].naics;
    self.NAICS5             := ds_naics_nonblank[5].naics;

    self                    := left;
    self                    := []
  ));
  
  output_debug := parallel(
   
    output('---------------------Marketing_List_Best_Industry_Codes---------------------'                ,named('Marketing_List_Best_Industry_Codes'          ),all)
   ,output(choosen(pDataset_Base        (count(pSampleProxids) = 0 or seleid in set_debug_seleids),300)  ,named('Best_Industry_Codes_pDataset_Base'           ),all)
   ,output(choosen(pBest_Prep           (count(pSampleProxids) = 0 or seleid in set_debug_seleids),300)  ,named('Best_Industry_Codes_pBest_Prep'              ),all)
   ,output(choosen(ds_base_clean        (count(pSampleProxids) = 0 or seleid in set_debug_seleids),300)  ,named('Best_Industry_Codes_ds_base_clean'           ),all)
   ,output(choosen(ds_base_filt         (count(pSampleProxids) = 0 or seleid in set_debug_seleids),300)  ,named('Best_Industry_Codes_ds_base_filt'            ),all)
   ,output(choosen(ds_Base_Prep         (count(pSampleProxids) = 0 or seleid in set_debug_seleids),300)  ,named('Best_Industry_Codes_ds_Base_Prep'            ),all)
   ,output(choosen(ds_base_add_priority (count(pSampleProxids) = 0 or seleid in set_debug_seleids),300)  ,named('Best_Industry_Codes_ds_base_add_priority'    ),all)
   ,output(choosen(ds_base_dedup        (count(pSampleProxids) = 0 or seleid in set_debug_seleids),300)  ,named('Best_Industry_Codes_ds_base_dedup'           ),all)
   ,output(choosen(ds_base_out          (count(pSampleProxids) = 0 or seleid in set_debug_seleids),300)  ,named('Best_Industry_Codes_ds_base_out'             ),all)
                                                                                                                                       
  );

  return when(ds_base_out  ,if(pDebug = true ,output_debug));

end;