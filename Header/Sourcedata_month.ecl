IMPORT header_quick;
export Sourcedata_month := module
 export v_version             := header_quick._config.get_v_version;
 export v_eq_as_of_date       := header_quick._config.get_v_eq_as_of_date;
 ;
 export v_nbr_of_days_to_keep := 45;
  export v_fheader_days_to_keep := 120;
end;



 


