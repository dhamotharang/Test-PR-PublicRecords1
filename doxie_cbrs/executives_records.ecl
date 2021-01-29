IMPORT doxie_cbrs;

doxie_cbrs.mac_Selection_Declare()

EXPORT executives_records(DATASET(doxie_cbrs.layout_references) bdids) :=
MODULE

execs := doxie_cbrs.contact_records(bdids)(Include_Executives_val); 
    
outrec := doxie_cbrs.layout_contact.exec_with_titles_rec;

execs_with_title_info := JOIN(execs, doxie_cbrs.executive_titles,
  TRIM(LEFT.company_title,LEFT,RIGHT) = TRIM(RIGHT.stored_title,LEFT,RIGHT),
  TRANSFORM(doxie_cbrs.layout_contact.exec_plus_rank_rec,
    SELF.title_rank := RIGHT.title_rank,
    SELF.company_title := RIGHT.display_title,
    SELF := LEFT));

outrec xtOut(doxie_cbrs.layout_contact.exec_plus_rank_rec L, DATASET(doxie_cbrs.layout_contact.exec_plus_rank_rec) group_recs) := TRANSFORM
  trecs := TOPN(DEDUP(SORT(group_recs, company_title, bdid, title_rank), company_title, bdid), doxie_cbrs.layout_contact.MAX_TITLE_RECS,
    title_rank, company_title, bdid);
  SELF.company_titles := PROJECT(trecs, doxie_cbrs.layout_contact.company_title_rec);
  SELF.dt_last_seen := MAX(group_recs,dt_last_seen);
  SELF.title_rank := MIN(group_recs,title_rank);
  SELF := L;
END;

execs_w_did_rolled := ROLLUP(GROUP(SORT(execs_with_title_info(did != 0), did), did), 
  GROUP, xtOut(LEFT, ROWS(LEFT)));

execs_wo_did_rolled := ROLLUP(GROUP(SORT(execs_with_title_info(did = 0),lname,fname,mname),lname,fname,mname),
  GROUP, xtOut(LEFT, ROWS(LEFT)));

SHARED dedup_titles_execs := SORT(execs_w_did_rolled + execs_wo_did_rolled,title_rank,-dt_last_seen,IF(did != 0,0,1));
  
EXPORT records := CHOOSEN(dedup_titles_execs, Max_Executives_val);
EXPORT records_count := COUNT(dedup_titles_execs);
END;
