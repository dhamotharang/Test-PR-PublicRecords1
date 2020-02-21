//Gong_Neustar.layout_history

EXPORT Layout_History := RECORD
  $.layout_prepped_for_keys;
  unsigned6 did;
  unsigned6 hhid;
  unsigned6 bdid;
  string8 dt_first_seen;
  string8 dt_last_seen;
  string1 current_record_flag;  
  string8 deletion_date;
  unsigned2 disc_cnt6 := 0;
  unsigned2 disc_cnt12 := 0;
  unsigned2 disc_cnt18 := 0;
  unsigned8 rawaid;
  string pclean;
  string5 pdid;
  string1 nametype;
  string80 preppedname;
  unsigned8 nid;
  unsigned2 name_ind;
  unsigned8 persistent_record_id;
  unsigned6 dotid;
  unsigned2 dotscore;
  unsigned2 dotweight;
  unsigned6 empid;
  unsigned2 empscore;
  unsigned2 empweight;
  unsigned6 powid;
  unsigned2 powscore;
  unsigned2 powweight;
  unsigned6 proxid;
  unsigned2 proxscore;
  unsigned2 proxweight;
  unsigned6 seleid;
  unsigned2 selescore;
  unsigned2 seleweight;
  unsigned6 orgid;
  unsigned2 orgscore;
  unsigned2 orgweight;
  unsigned6 ultid;
  unsigned2 ultscore;
  unsigned2 ultweight;
  //CCPA-22 CCPA new fields
  UNSIGNED4 global_sid := 0;
  UNSIGNED8 record_sid := 0;
END;
