import consumerstatement;

EXPORT layouts := MODULE

  export rec_statement := consumerstatement.layout.nonfcra.consumer;

  export search_in := record
    integer statement_id;
    unsigned6 did;
    string10  phone;
    string10  prim_range;
    string2   predir;
    string28  prim_name;
    string4   addr_suffix;
    string2   postdir;
    string10  unit_desig;
    string8   sec_range;
    string25  p_city_name;
    string25  v_city_name;
    string2   st;
    string5   zip;
    string4 addr_clean_msg;
  end;


  export search_out := record
    unsigned _penalty := 0;
    rec_statement and not [v_city_name, cart, cr_sort_sz, lot, lot_order, dbpc, chk_digit, rec_type,
                           county, geo_lat, geo_long, msa, geo_blk, geo_match];
  end;



END;
