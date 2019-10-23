import Marketing_List;

EXPORT _Filters :=
module

  export mac_Filter_BIP_Base (

    pbip_base = 'Marketing_List.Source_Files().bip_base'  //by default, use BIP commonbase file in QA superfile.  On dataland, use prod file, on prod, use prod file.
  
  ) := 
  functionmacro

    set_mkting_srcs := Marketing_List._Config().set_marketing_approved_sources;

    ds_bip_base_filtered := pbip_base(
            source                in set_mkting_srcs  // -- only marketing approved sources
      ,trim(company_name        ) != ''               // -- must have name
      ,trim(prim_name           ) != ''               // -- must have address
      ,trim(v_city_name         ) != ''             
      ,trim(st                  ) != ''             
      ,trim(zip                 ) != ''             
      ,trim(proxid_status_public)  = ''               // -- only active entities
    );
    
    return ds_bip_base_filtered;
    
  endmacro;


end;