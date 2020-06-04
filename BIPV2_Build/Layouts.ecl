import bipv2_best,bipv2;

EXPORT Layouts :=
module

export external_append_lay := 
RECORD
   string version;
   string5 src;
   integer8 count_0;
   real8 perc_0;
   integer8 count_25;
   real8 perc_25;
   integer8 count_50;
   real8 perc_50;
   integer8 count_75;
   real8 perc_75;
  END;

export dashboard := 
RECORD
  string build_date;
  string sprint;
  RECORD
   string version;
   unsigned8 total_gold;
   unsigned8 total_active;
   unsigned8 total_inactive;
   unsigned8 total_defunct;
  END sele_segmentation;
  { string version, real8 seleid, real8 proxid } pct_same_seleids;
  DATASET({ string version, integer4 precision, integer4 recall }) precision_recall;
  RECORD
   string version;
   integer8 records;
   integer8 empid;
   integer8 powid;
   integer8 proxid;
   integer8 seleid;
   integer8 lgid3;
   integer8 orgid;
  END entitycount_flat;
  DATASET(RECORD
   string id;
   real8 average_count;
   unsigned6 median_count;
   unsigned6 max_count;
   unsigned6 total_count;
   unsigned6 total_ids;
   unsigned6 sum_buckets;
  END) idcountbuckets;
  DATASET(external_append_lay) external_append;
 END;

  shared b := pull(choosen(BIPV2_Best.Key_LinkIds.KeyBuilt, ALL));// : persist('~thor_data400::cemtemp.b');
  shared h := choosen(BIPV2.CommonBase.DS_BASE, ALL);// : persist('~thor_data400::cemtemp.h');

  //layouts
  export Best_Flat := {b.ultid, b.orgid, b.seleid, b.proxid, b.company_name.company_name, b.company_phone.company_phone, b.company_fein.company_fein, b.company_url.company_url, 
    b.company_address.company_prim_range, b.company_address.company_prim_name, b.company_address.company_sec_range, b.company_address.address_v_city_name,
    b.company_address.company_st, b.company_address.company_zip5, b.company_address.company_zip4,
    b.company_incorporation_date.company_incorporation_date, b.duns_number.duns_number,string8 company_sic_code,string6 company_naics_code,
    string20 segmentation};
    
  export BIP_Owners := {h.ultid, h.orgid, h.seleid, h.proxid, h.company_name, h.fname, h.mname, h.lname, h.name_suffix,h.contact_did, h.contact_type_derived,h.prim_range,h.predir,h.prim_name,h.addr_suffix,h.postdir,h.unit_desig,h.sec_range,h.v_city_name,h.st,h.zip,h.zip4,h.contact_ssn};

  export HighRiskCodesListLayout := record
    string10 code;
		string5 code_type;
  end;
end;