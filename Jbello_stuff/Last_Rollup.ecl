import ut,did_add,mdr,header;

inf := header.with_tnt;

merged_dist := distribute(inf,hash(did));

rec := record
 merged_dist.did;
 unsigned3 prop_src_ct   := count(group,mdr.sourcetools.SourceIsProperty(merged_dist.src));
 unsigned3 total_records := count(group);
end;

did_counts := table(merged_dist,rec,did,local);

header.Layout_Header tSetJFlagForPropertyFragments(merged_dist l, did_counts r) := transform
 
 unsigned3 property_count     := r.prop_src_ct;
 unsigned3 total_record_count := r.total_records;
 
 boolean flagged_as_ambig                := l.jflag2=MDR.flagTools.jflag2.Ambiguous;
 
 boolean property_ct_equals_total_ct     := property_count=total_record_count;
 boolean one_property_fragment_rec       := property_ct_equals_total_ct and property_count=1;
 boolean multiple_property_fragment_recs := property_ct_equals_total_ct and property_count>1;
 
 self.jflag2 := map(multiple_property_fragment_recs and ~flagged_as_ambig => MDR.flagTools.jflag2.NotAmbiguousPropertyMultiple,
				    one_property_fragment_rec  	    and  flagged_as_ambig => MDR.flagTools.jflag2.AmbiguousPropertySingleton,
				    one_property_fragment_rec       and ~flagged_as_ambig => MDR.flagTools.jflag2.NotAmbiguousPropertySingleton,
				    multiple_property_fragment_recs and  flagged_as_ambig => MDR.flagTools.jflag2.AmbiguousPropertyMultiple,
				l.jflag2);
 self        := l;
end;

dSetJFlagForPropertyFragments := join(merged_dist,did_counts,
                                      left.did=right.did,
									  tSetJFlagForPropertyFragments(left,right),
									  left outer, local
									 );
									 
fix_dates  := header.fn_fix_dates(dSetJFlagForPropertyFragments);
set_titles := header.fn_apply_title(fix_dates);

today_in_ym := (unsigned3)(ut.GetDate[1..6]);

//IRS dummy data
dummy := dataset(
[{999999000001,999999000001,'','','','DU',199701,today_in_ym,today_in_ym,199901,200107,'','DU000001','','263124372',19600112,'MR','JOHN','','AARDVARK','','123','','MAIN','ST','','','','NEW YORK','NY','12345','1234','061','','','Y','G','','',''},
 {999999000012,999999000012,'','','','DU',199703,today_in_ym,today_in_ym,199901,200107,'','DU000002','','351762209',19630215,'',  'JOAN','','AARDVARK','','123','','MAIN','ST','','','','NEW YORK','NY','12345','1234','061','','','Y','G','','',''},
 {999999000001,999999000002,'','','','DU',198301,199612,	 199902,	 198511,199612,'','DU000001','','263124372',19600112,'MR','JOHN','','AARDVARK','','10','S','NORTH','ST','','APT','206','ANN ARBOR','MI','48103','','161','','','Y','G','','',''},
 {999999000012,999999000013,'','','','DU',198003,199612,	 199902,	 199001,199611,'','DU000002','','351762209',19630215,'',  'JOAN','','AARDVARK','','20','N','SOUTH','ST','','APT','108','YPSILANTI','MI','48197','','161','','','Y','G','','',''},
 {999999001001,999999001001,'','','','DU',199910,today_in_ym,today_in_ym,200101,200107,'','DU001001','','351762213',19750415,'',  'MARK','','MARSUPIAL','','401','N','LAZY LAKE','RD','','','','ANN ARBOR','MI','48104','','161','','','Y','G','','',''},
 {999999001001,999999001002,'','','','DU',199510,199910,     199911,     199510,199910,'','DU001001','','351762213',19750415,'',  'MARK','','MARSUPIAL','','20','N','SOUTH','ST','','APT','106','YPSILANTI','MI','48197','','161','','','Y','G','','',''},
 {999999001012,999999001012,'','','','DU',199910,today_in_ym,today_in_ym,200101,200107,'','DU001002','','263124378',19750712,'',  'MARTIN','','MARSUPIAL','','401','N','LAZY LAKE','RD','','','','ANN ARBOR','MI','48104','','161','','','Y','G','','',''}],header.Layout_Header);
 
export Last_Rollup := (set_titles + dummy) : persist('~thor_data::persist::last_rollup');