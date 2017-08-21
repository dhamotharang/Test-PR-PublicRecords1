import autokeyb2,doxie;

standard__base := RECORD
   string10 prim_range;
   string2 predir;
   string28 prim_name;
   string4 addr_suffix;
   string2 postdir;
   string10 unit_desig;
   string8 sec_range;
   string25 p_city_name;
   string25 v_city_name;
   string2 st;
   string5 zip5;
   string4 zip4;
   string2 fips_state;
   string3 fips_county;
   string2 addr_rec_type;
  END;

rec := RECORD
  unsigned integer6 fakeid;
  big_endian unsigned integer4 activity_number;
  big_endian unsigned integer4 last_activity_date;
  big_endian unsigned integer4 previous_activity_number;
  string30 cname;
  unsigned integer6 bdid;
  unsigned integer2 bdid_score;
  string9 fein_append;
  standard__base addr;
  unsigned integer1 zero;
  string1 blank;
  unsigned integer6 fdid;
 END;

d := dataset([],rec);

export Key_OSHAIR_autokey_payload_bid := index(d,{fakeid},{d},'~thor_data400::key::oshair::' + doxie.Version_SuperKey + '::autokey::bid::payload');