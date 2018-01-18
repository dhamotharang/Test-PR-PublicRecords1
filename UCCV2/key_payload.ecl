import doxie,data_services;

standard__addr := RECORD

   string10 prim_range;

   string2 predir;

   string28 prim_name;

   string4 addr_suffix;

   string2 postdir;

   string10 unit_desig;

   string8 sec_range;

   string25 v_city_name;

   string2 st;

   string5 zip5;

   string4 zip4;

   string2 addr_rec_type;

   string2 fips_state;

   string3 fips_county;

   string10 geo_lat;

   string11 geo_long;

   string4 cbsa;

   string7 geo_blk;

   string1 geo_match;

   string4 err_stat;

  END;

 

standard__name := RECORD

   string5 title;

   string20 fname;

   string20 mname;

   string20 lname;

   string5 name_suffix;

   string3 name_score;

  END;

 

full_rec := RECORD

  unsigned integer6 fakeid;
  string1 party_type;
  unsigned integer4 party_bits;
  unsigned integer1 zero;

  string31 tmsid;

  string23 rmsid;

  unsigned integer6 did;

  unsigned integer6 bdid;

  string60 company_name;

  string9 ssn;

  string10 fein;

  standard__addr company_addr;

  standard__addr person_addr;

  standard__name person_name;

  unsigned integer8 __internal_fpos__;

 END;

 

d := dataset([],full_rec);

 

export key_payload := index(d,{fakeid},{d},data_services.data_location.prefix() + 'thor_data400::key::ucc::autokey::payload_' + doxie.Version_SuperKey);
