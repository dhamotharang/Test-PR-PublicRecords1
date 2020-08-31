IMPORT uccv2, BIPV2;

k_party := uccv2.layout_UCC_common.layout_party;

EXPORT layout_ucc_party_raw_src := RECORD
  k_party.tmsid;
  k_party.rmsid; // Added 11/10/09 for change to report service filings section
  k_party.bdid;
  BIPV2.IDlayouts.l_header_ids;
  k_party.did;
  
  k_party.Party_type;
  
  k_party.Orig_name;
  k_party.title;
  k_party.lname;
  k_party.fname;
  k_party.mname;
  k_party.name_suffix;
  k_party.company_name;
  
  k_party.ssn;
  k_party.fein;
  k_party.Incorp_state;
  k_party.corp_number;
  k_party.corp_type;
  
  k_party.Orig_address1;
  k_party.Orig_address2;
  k_party.orig_city;
  k_party.orig_state;
  k_party.orig_zip5;
  k_party.orig_zip4;
  k_party.orig_country;
  k_party.orig_province;
  k_party.orig_postal_code;
  k_party.foreign_indc;

  TYPEOF(k_party.Orig_address1) address1;
  TYPEOF(k_party.Orig_address2) address2;
  
  k_party.prim_range;
  k_party.predir;
  k_party.prim_name;
  TYPEOF(k_party.suffix) addr_suffix;
  k_party.postdir;
  k_party.unit_desig;
  k_party.sec_range;
  k_party.p_city_name;
  k_party.v_city_name;
  k_party.st;
  k_party.zip5;
  k_party.zip4;
  k_party.geo_lat;
  k_party.geo_long;
  k_party.geo_match;
END;
