﻿// The following key definition was written as a result of the Cortera_Tradeline.Key_LinkIds
// being removed from the ThorProd repository.
file_layout := RECORD
  unsigned6 ultid;
  unsigned6 orgid;
  unsigned6 seleid;
  unsigned6 proxid;
  unsigned6 powid;
  unsigned6 empid;
  unsigned6 dotid
  =>
  unsigned2 ultscore;
  unsigned2 orgscore;
  unsigned2 selescore;
  unsigned2 proxscore;
  unsigned2 powscore;
  unsigned2 empscore;
  unsigned2 dotscore;
  unsigned2 ultweight;
  unsigned2 orgweight;
  unsigned2 seleweight;
  unsigned2 proxweight;
  unsigned2 powweight;
  unsigned2 empweight;
  unsigned2 dotweight;
  unsigned4 link_id;
  string32 account_key;
  string2 segment_id;
  string8 ar_date;
  string20 total_ar;
  string20 current_ar;
  string20 aging_1to30;
  string20 aging_31to60;
  string20 aging_61to90;
  string20 aging_91plus;
  string20 credit_limit;
  string8 first_sale_date;
  string8 last_sale_date;
  string2 source;
  string1 status;
  unsigned4 filedate;
  unsigned4 process_date;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  unsigned4 dt_vendor_first_reported;
  unsigned4 dt_vendor_last_reported;
  unsigned4 deletion_date;
  unsigned6 bdid;
  unsigned1 bdid_score;
  unsigned8 record_sid;
  unsigned4 global_sid;
  unsigned4 dt_effective_first;
  unsigned4 dt_effective_last;
  unsigned1 delta_ind;
  integer1 fp;
END;

baserecset := DATASET([],file_layout);
keys       := {file_layout.ultid, file_layout.orgid, file_layout.seleid, file_layout.proxid, file_layout.powid, file_layout.empid, file_layout.dotid};
payload    := file_layout AND NOT [ ultid, orgid, seleid, proxid, powid, empid, dotid ];
indexfile  := '~thor_data400::key::Cortera_Tradeline::qa::linkIds';

EXPORT Cortera_Tradeline_Key_LinkIds_alias := INDEX( baserecset, keys, payload, indexfile );
