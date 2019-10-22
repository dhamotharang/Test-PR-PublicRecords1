/*
  Get:
    SICs
    NAICSs
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
) :=
function

  ds_base               := pDataset_Base;
  set_mktg_sources      := Marketing_List._Config().set_marketing_approved_sources;
  set_industry_sources  := Marketing_List._Config().set_sources_of_industry_codes ;
  ds_industry_sources   := Marketing_List._Config().ds_sources_of_industry_codes  ;

  ds_base_clean                   := ds_base;
  ds_base_filt                    := ds_base_clean(source in set_mktg_sources ,source in set_industry_sources,trim(seleid_status_public) = ''  
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
                   },seleid,source  ,trim(company_sic_code1)[1..4]  ,trim(company_sic_code2)[1..4]  ,trim(company_sic_code3)[1..4]  ,trim(company_sic_code4)[1..4]  ,trim(company_sic_code5)[1..4]
                                    ,company_naics_code1            ,company_naics_code2            ,company_naics_code3            ,company_naics_code4            ,company_naics_code5  ,merge);


  // -- normalize out the sic codes and naics codes so that I can count how many times each one occurs per seleid and source and dt_last_seen
  // -- then i can dedup to only get the ones from the latest dt_last_seen for that seleid and source.
  // -- quick n dirty first for samples
  ds_base_add_priority := join(ds_Base_Prep ,ds_industry_sources  ,left.source = right.source ,transform({unsigned2 rank_order,recordof(left)},self := right,self := left) ,lookup);
  
  ds_base_dedup := dedup(sort(distribute(ds_base_add_priority  ,hash(seleid)) ,seleid,rank_order,-dt_last_seen ,local)  ,seleid ,local);
  
  ds_base_out := project(ds_base_dedup,transform(Marketing_List.Layouts.business_information_prep,
    self                    := left;
    self.SIC_Primary        := left.company_sic_code1;
    self.SIC2               := left.company_sic_code2;
    self.SIC3               := left.company_sic_code3;
    self.SIC4               := left.company_sic_code4;
    self.SIC5               := left.company_sic_code5;
    self.NAICS_Primary      := left.company_naics_code1;
    self.NAICS2             := left.company_naics_code2;
    self.NAICS3             := left.company_naics_code3;
    self.NAICS4             := left.company_naics_code4;
    self.NAICS5             := left.company_naics_code5;

    self := []
  ));
  
  return ds_base_out;

end;