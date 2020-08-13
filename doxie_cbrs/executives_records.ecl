IMPORT doxie,ut;

EXPORT executives_records(DATASET(doxie_cbrs.layout_references) bdids) :=
MODULE

doxie_cbrs.mac_Selection_Declare()

execs := doxie_cbrs.contact_records(bdids)(Include_Executives_val);
    
company_title_rec := RECORD
  execs.company_title;
  execs.bdid;
  execs.company_name;
END;

exec_record_base := RECORD
  execs.bdid;
  execs.did;
  execs.dt_last_seen;
  execs.fname;
  execs.mname;
  execs.lname;
  execs.name_suffix;
END;

exec_record := RECORD
  exec_record_base OR company_title_rec;
END;

exec_rolled_rec := RECORD
  exec_record_base;
  DATASET(company_title_rec) company_titles {MAXCOUNT(25)};
  UNSIGNED2 title_rank;
END;

exec_record_plus_rank := RECORD
  exec_record;
  UNSIGNED2 title_rank;
END;

execs_with_title_info := JOIN(execs,executive_titles,
  TRIM(LEFT.company_title,LEFT,RIGHT) = TRIM(RIGHT.stored_title,LEFT,RIGHT),
  TRANSFORM(exec_record_plus_rank,
    SELF.title_rank := RIGHT.title_rank,
    SELF.company_title := RIGHT.display_title,
    SELF := LEFT));

execs_w_did_rolled := ROLLUP(GROUP(SORT(execs_with_title_info(did != 0),did),did),GROUP,TRANSFORM(exec_rolled_rec,
  SELF.company_titles := PROJECT(topn(DEDUP(SORT(rows(LEFT),company_title,bdid,title_rank),company_title,bdid),25,title_rank,company_title,bdid),company_title_rec),
  SELF.dt_last_seen := MAX(rows(LEFT),dt_last_seen),
  SELF.title_rank := MIN(rows(LEFT),title_rank),
  SELF := LEFT));

execs_wo_did_rolled := ROLLUP(GROUP(SORT(execs_with_title_info(did = 0),lname,fname,mname),lname,fname,mname),GROUP,TRANSFORM(exec_rolled_rec,
  SELF.company_titles := PROJECT(topn(DEDUP(SORT(rows(LEFT),company_title,bdid,title_rank),company_title,bdid),25,title_rank,company_title,bdid),company_title_rec),
  SELF.dt_last_seen := MAX(rows(LEFT),dt_last_seen),
  SELF.title_rank := MIN(rows(LEFT),title_rank),
  SELF := LEFT));

SHARED dedup_titles_execs := SORT(execs_w_did_rolled + execs_wo_did_rolled,title_rank,-dt_last_seen,IF(did != 0,0,1));
  
doxie_cbrs.mac_Selection_Declare()
                  
EXPORT records := CHOOSEN(dedup_titles_execs,Max_Executives_val);
EXPORT records_count := COUNT(dedup_titles_execs);
END;
