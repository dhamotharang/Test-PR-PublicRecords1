import Doxie, vehiclev2_services, vehicle_wildcard;

export Layout_VehRawBatchInput := module

  export input_layout := record

    unsigned8 seq;
    unsigned6 DID;
    unsigned6 BDID;
    string30 vin_value;
    string20 tag_value;
    string25 vid_value;
    string2 st_code_value;
    string20 veh_num_value;
    STRING28 prim_name;
    STRING10 prim_range;
    STRING2 st;
    string25 v_city_name ;
    STRING5 zip;
    STRING8 sec_range;
    string40 cname_indic;
    string40 cname_sec;

  end;

  export input_w_keys := record
    input_layout input;
    VehicleV2_Services.Layout_Vehicle_Key;
    vehicle_wildcard.Layout_Hole_Veh.wd_person_source;
  end;

  export out_layout := record
    input_layout input;
    Doxie.Layout_VehicleSearch;
  end;

end;
