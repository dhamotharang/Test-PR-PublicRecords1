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
    string31              county_name         ;
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
    integer                   annual_revenue      ;
    string2                   src_revenue         ;
    integer                   number_of_employees ;
    string2                   src_employees       ;
    string4                   SIC_Primary         ;
    string4                   SIC2                ;
    string4                   SIC3                ;
    string4                   SIC4                ;
    string4                   SIC5                ;
    string2                   src_sics            ;
    string6                   NAICS_Primary       ;
    string6                   NAICS2              ;
    string6                   NAICS3              ;
    string6                   NAICS4              ;
    string6                   NAICS5              ;
    string2                   src_naics           ;
  end;

  // export business_information := 
  // record
    // unsigned6                 seleid          ;
    // unsigned6                 proxid          ;
    // unsigned6                 ultid           ;
    // unsigned6                 orgid           ;
    // core_business_info_seleid - src_employees - src_sics - src_naics seleid_level    ;
    // core_business_info_proxid proxid_level    ;        
  // end;

  export business_information := 
  record
    unsigned6                 seleid          ;
    unsigned6                 proxid          ;
    unsigned6                 ultid           ;
    unsigned6                 orgid           ;
    core_business_info_seleid seleid_level    ;
    core_business_info_proxid proxid_level    ;        
  end;

  export business_contact := 
  record
    unsigned6             seleid                ;
    unsigned6             proxid                ;
    unsigned6             lexid                 ;
    unsigned6             empid                 ;
    string                fname                 ;
    string                lname                 ;
   
    unsigned4             Age                   ;
    unsigned              executive_ind         ;
    string2               src_name              ;

   // -- new
    unsigned4             dt_first_seen         ;
    unsigned4             dt_last_seen          ;
    
    string70              contact_address       ;
    string25              city                  ;
    string2               state                 ;
    string5               zip5                  ;
    string5               county                ;
    string31              county_name           ;

    string60              contact_email_address ;
    // -- end new
    
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

  // export business_contact_prep := 
  // record
    // unsigned4 Age           ;
    // unsigned  executive_ind ;
    // string2   src_name      ;
    // business_contact        ;
  // end;

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
    string31              county_name         ;
    string3               age_of_company      ;
    unsigned4             dt_first_seen       ;
    unsigned4             dt_last_seen        ;
    string10              business_phone      ;
    string60              business_email      ;
    unsigned              annual_revenue      ;
    string2               src_revenue         ;
    unsigned              number_of_employees ;
    string2               src_employees       ;
    string4               SIC_Primary         ;
    string4               SIC2                ;
    string4               SIC3                ;
    string4               SIC4                ;
    string4               SIC5                ;
    string2               src_sics            ;
    string6               NAICS_Primary       ;
    string6               NAICS2              ;
    string6               NAICS3              ;
    string6               NAICS4              ;
    string6               NAICS5              ;
    string2               src_naics           ;

  end;

  export source_rank := 
  record
    unsigned2 rank_order  ;
    string2   source      ;
  end;

  export best_lexid_contact_address :=
  record
    unsigned6             lexid                 ;
    string70              contact_address       ;
    string25              city                  ;
    string2               state                 ;
    string5               zip5                  ;
  end;
  
end;