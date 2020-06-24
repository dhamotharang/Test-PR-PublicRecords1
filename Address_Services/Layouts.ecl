IMPORT address;

EXPORT Layouts := MODULE

  export clean_rec := record
    address.Layout_Clean182.prim_range;
    address.Layout_Clean182.predir;
    address.Layout_Clean182.prim_name;
    address.Layout_Clean182.addr_suffix;
    address.Layout_Clean182.postdir;
    address.Layout_Clean182.unit_desig;
    address.Layout_Clean182.sec_range;
    address.Layout_Clean182.p_city_name;
    address.Layout_Clean182.st;
    address.Layout_Clean182.zip;
  end;
  
  export int_rec := record
    clean_rec;
    boolean valid;
  end;
  
  
END;
