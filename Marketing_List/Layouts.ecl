import BIPV2;

EXPORT Layouts :=
module

  export core_business_info_proxid := 
  record
    string100             business_name       ;
    string70              business_address    ;
    string25              city                ;
    string2               state               ;
    string5               zip5                ;
    string5               county              ;
    string4               msa                 ;
    string4               err_stat            ;
    string3               age_of_company      ;
    unsigned4             dt_first_seen       ;
    unsigned4             dt_last_seen        ;
    string10              business_phone      ;
  end;
  
  export core_business_info_seleid := 
  record
    core_business_info_proxid                     ;
    string60                  business_email      ;
    unsigned                  annual_revenue      ;
    string2                   src_revenue         ;
    unsigned                  number_of_employees ;
    string4                   SIC_Primary         ;
    string4                   SIC2                ;
    string4                   SIC3                ;
    string4                   SIC4                ;
    string4                   SIC5                ;
    string6                   NAICS_Primary       ;
    string6                   NAICS2              ;
    string6                   NAICS3              ;
    string6                   NAICS4              ;
    string6                   NAICS5              ;
  end;

  export business_information := 
  record
    unsigned6                 seleid          ;
    unsigned6                 proxid          ;
    unsigned6                 ultid           ;
    unsigned6                 orgid           ;
    core_business_info_seleid seleid_level    ;
    core_business_info_proxid proxid_level    ;        
  end;

  export business_information_prep := 
  record
    unsigned6             seleid              ;
    unsigned6             proxid              ;
    unsigned6             ultid               ;
    unsigned6             orgid               ;
    // string2               source              ;
    string100             business_name       ;
    string10              prim_range          ;
    string2               predir              ;
    string28              prim_name           ;
    string4               addr_suffix         ;
    string2               postdir             ;
    string10              unit_desig          ;
    string8               sec_range           ;
    string25              p_city_name         ;
    string25              v_city_name         ;
    string2               st                  ;
    string5               zip                 ;
    string4               msa                 ;
    string4               err_stat            ;
    string2               fips_state          ;
    string3               fips_county         ;
    string3               age_of_company      ;
    unsigned4             dt_first_seen       ;
    unsigned4             dt_last_seen        ;
    string10              business_phone      ;
    string60              business_email      ;
    unsigned              annual_revenue      ;
    string2               src_revenue         ;
    unsigned              number_of_employees ;
    string4               SIC_Primary         ;
    string4               SIC2                ;
    string4               SIC3                ;
    string4               SIC4                ;
    string4               SIC5                ;
    string6               NAICS_Primary       ;
    string6               NAICS2              ;
    string6               NAICS3              ;
    string6               NAICS4              ;
    string6               NAICS5              ;
  end;

  export business_contact := 
  record
    unsigned6             seleid                ;
    unsigned6             proxid                ;
    unsigned6             lexid                 ;
    unsigned6             empid                 ;
    string                fname                 ;
    string                lname                 ;
    string                title                 ;
    unsigned4             title_dt_first_seen   ;
    unsigned4             title_dt_last_seen    ;

    string                title2                ;
    unsigned4             title2_dt_first_seen  ;
    unsigned4             title2_dt_last_seen   ;
  
    string                title3                ;
    unsigned4             title3_dt_first_seen  ;
    unsigned4             title3_dt_last_seen   ;
  
    string                title4                ;
    unsigned4             title4_dt_first_seen  ;
    unsigned4             title4_dt_last_seen   ;
  
    string                title5                ;
    unsigned4             title5_dt_first_seen  ;
    unsigned4             title5_dt_last_seen   ;
      
    unsigned              person_hierarchy      ;
    
  end;


  export sic_child := 
  record
    string4     SIC                ;
  end;
  
  export naics_child := 
  record
    string6     NAICS              ;
  end;
  

  export base := 
  record
    unsigned6             seleid              ;
    unsigned6             proxid              ;
    string                business_name       ;
    string10              prim_range          ;
    string2               predir              ;
    string28              prim_name           ;
    string4               addr_suffix         ;
    string2               postdir             ;
    string10              unit_desig          ;
    string8               sec_range           ;
    string25              p_city_name         ;
    string25              v_city_name         ;
    string2               st                  ;
    string5               zip                 ;
    string4               msa                 ;
    string4               err_stat            ;
    string2               fips_state          ;
    string3               fips_county         ;
    string3               age_of_company      ;
    string10              business_phone      ;
    string60              business_email      ;
    unsigned              sales               ;
    string2               src_sales           ;
    unsigned              number_of_employees ;
    dataset(sic_child  )  SICs                ;
    dataset(naics_child)  NAICSs              ;
    unsigned4             dt_first_seen       ;
    unsigned4             dt_last_seen        ;
  end;

  export base_old := 
  record
    unsigned6             seleid              ;
    unsigned6             proxid              ;
    string                business_name       ;
    string                street_address      ;
    string                city                ;
    string2               state               ;
    string5               zip5                ;
    string4               msa                 ;
    string4               err_stat            ;
    string3               county              ;
    string3               age_of_company      ;
    string10              business_phone      ;
    string60              business_email      ;
    unsigned              sales               ;
    string2               src_sales           ;
    unsigned              number_of_employees ;
    dataset(sic_child   ) SICs                ;
    dataset(naics_child ) NAICSs              ;
    unsigned4             dt_first_seen       ;
    unsigned4             dt_last_seen        ;
    
  end;

  export source_rank := 
  record
    unsigned2 rank_order  ;
    string2   source      ;
  end;
  
  export sic_naics := 
  record
    unsigned6   seleid              ;
    unsigned6   proxid              ;
    string2     source              ;
    string4     SIC4                ;
    string6     NAICS6              ;
    unsigned4   dt_last_seen        ;
  end;

  export bip_base_prep := 
  record
    unsigned6             seleid              ;
    unsigned6             proxid              ;
    string2               source              ;
    string                business_name       ;
    string10              prim_range          ;
    string2               predir              ;
    string28              prim_name           ;
    string4               addr_suffix         ;
    string2               postdir             ;
    string10              unit_desig          ;
    string8               sec_range           ;
    string25              p_city_name         ;
    string25              v_city_name         ;
    string2               st                  ;
    string5               zip                 ;
    string4               msa                 ; //get this
    string4               err_stat            ; //get this
    string3               age_of_company      ; //get this
    string60              business_email      ; //need this
    string4               SIC_Primary         ;
    string4               SIC2                ;
    string4               SIC3                ;
    string4               SIC4                ;
    string4               SIC5                ;
    string6               NAICS_Primary       ;
    string6               NAICS2              ;
    string6               NAICS3              ;
    string6               NAICS4              ;
    string6               NAICS5              ;
    unsigned4             dt_first_seen       ; //need this
    unsigned4             dt_last_seen        ; //need this
  end;

  
end;