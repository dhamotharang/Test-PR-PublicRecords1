import dnb_feinv2, Doxie, strata;

get_recs := DNB_FEINv2.File_DNB_Fein_base_main ;


rec_stats := record
  integer countGroup := count(group);
  source              := get_recs.TMSID[1..2];
  bdid_nonzero		:= sum(group, if((unsigned8)get_recs.bdid <> 0, 1, 0));
  // has_bdid    := sum(group,IF((unsigned6)get_recs(orig_company_name <> '').bdid <> 0,1,0))/sum(group,IF(get_recs.orig_company_name <> '',1,0)) * 100;
end;

bDID_main_stats := table(get_recs(orig_company_name <> ''), rec_stats, get_recs.TMSID[1..2], few);


export Dnb_fein_base_main_stats_BDID := output(bDID_main_stats);




