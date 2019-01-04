import ut,did_add,mdr,idl_header;

export FCRA_Last_Rollup(string filedate):= FUNCTION

inf := distribute(header.fn_with_tnt(true,filedate),hash(did));

//-- Slim record to ease the join burdone
sm_rec := record
	inf.did;
	inf.rid;
	inf.src;
	inf.dt_first_seen;
	inf.dt_last_seen;
	inf.dt_vendor_first_reported;
	inf.dt_vendor_last_reported;
	inf.phone;
	inf.ssn;
	inf.dob;
	inf.fname;
	inf.mname;
	inf.lname;
	inf.name_suffix;
	inf.prim_range;
	inf.prim_name;
	inf.sec_range;
	inf.city_name;
	inf.st;
	inf.zip;
	inf.county;
	inf.RawAID; 
end;

//****** Slim down the infile
sm_rec slimHead(header.layout_header L) := transform
 self := l;
end;

me_use := project(inf,slimHead(left)); 

//-- Transform that assigns the right file ID as old_rid and the left file ID as new_rid
//	 Sets flag to RU1 (rule 1)
header.Layout_PairMatch tra(me_use ll, me_use r) := transform
  self.old_rid := r.rid;
  self.new_rid := ll.rid;
  self.pflag := 21;
  end;

//****** Join the infile to itself
	j := join(me_use,me_use,
						left.did=right.did
					and left.rid < right.rid
					and	left.src        =right.src
					and	left.fname      =right.fname
					and	left.lname      =right.lname
					and	left.prim_range =right.prim_range
					and	left.prim_name  =right.prim_name
					and	left.sec_range  =right.sec_range
					and	left.city_name  =right.city_name
					and	left.st         =right.st
					and	(
								(left.ssn          =right.ssn
							and	left.dob         =right.dob
							and	left.phone       =right.phone
							and	left.mname       =right.mname
							and	left.name_suffix =right.name_suffix
							and	left.zip         =right.zip
							and	left.county      =right.county)
								or (
											(
															left.ssn=''
													or left.ssn=right.ssn 
													or (
																	ut.nneq(left.ssn, right.ssn)
																and	(//all dates are populated
																		(left.dt_first_seen>0 and	left.dt_last_seen>0
																and right.dt_first_seen>0 and right.dt_last_seen>0
																and	left.dt_vendor_first_reported>0 and	left.dt_vendor_last_reported>0
																and right.dt_vendor_first_reported>0 and right.dt_vendor_last_reported>0)
																or // or all dates are zero
																	(left.dt_first_seen=0 and	left.dt_last_seen=0
																and right.dt_first_seen=0 and right.dt_last_seen=0
																and	left.dt_vendor_first_reported=0 and	left.dt_vendor_last_reported=0
																and right.dt_vendor_first_reported=0 and right.dt_vendor_last_reported=0)
																)// both seen and vendor date ranges overlap respectively
															and (left.dt_first_seen between right.dt_first_seen and right.dt_last_seen
																	or left.dt_last_seen between right.dt_first_seen and right.dt_last_seen
															    or right.dt_first_seen between left.dt_first_seen and left.dt_last_seen
																	or right.dt_last_seen between left.dt_first_seen and left.dt_last_seen)
															and (left.dt_vendor_first_reported between right.dt_vendor_first_reported and right.dt_vendor_last_reported
																	or left.dt_vendor_last_reported between right.dt_vendor_first_reported and right.dt_vendor_last_reported
															    or right.dt_vendor_first_reported between left.dt_vendor_first_reported and left.dt_vendor_last_reported
																	or right.dt_vendor_last_reported between left.dt_vendor_first_reported and left.dt_vendor_last_reported)
															)
													or (//one of the seen dates is missing
																ut.nneq(left.ssn, right.ssn)
															and	(left.dt_first_seen=0 or right.dt_first_seen=0 or left.dt_last_seen=0 or right.dt_last_seen=0)
															and	left.dt_vendor_first_reported>0 and	left.dt_vendor_last_reported>0
															and right.dt_vendor_first_reported>0 and right.dt_vendor_last_reported>0
															// and vendor dates ranges overlap
															and (left.dt_vendor_first_reported between right.dt_vendor_first_reported and right.dt_vendor_last_reported
																	or left.dt_vendor_last_reported between right.dt_vendor_first_reported and right.dt_vendor_last_reported
															    or right.dt_vendor_first_reported between left.dt_vendor_first_reported and left.dt_vendor_last_reported
																	or right.dt_vendor_last_reported between left.dt_vendor_first_reported and left.dt_vendor_last_reported)
															)
													or (//one of the seen dates and one of the vendor dates are missing
																ut.nneq(left.ssn, right.ssn)
															and	(left.dt_first_seen=0 or right.dt_first_seen=0 or left.dt_last_seen=0 or right.dt_last_seen=0)
															and	(left.dt_vendor_first_reported=0 or right.dt_vendor_first_reported=0 or left.dt_vendor_last_reported=0 or right.dt_vendor_last_reported=0)
															)
											)
									and	(
															left.dob=0
													or left.dob=right.dob 
													or (
																	ut.NNEQ_Date(left.dob, right.dob)
																and	(//all dates are populated or all dates are zero
																		(left.dt_first_seen>0 and	left.dt_last_seen>0
																and right.dt_first_seen>0 and right.dt_last_seen>0
																and	left.dt_vendor_first_reported>0 and	left.dt_vendor_last_reported>0
																and right.dt_vendor_first_reported>0 and right.dt_vendor_last_reported>0)
																or
																	(left.dt_first_seen=0 and	left.dt_last_seen=0
																and right.dt_first_seen=0 and right.dt_last_seen=0
																and	left.dt_vendor_first_reported=0 and	left.dt_vendor_last_reported=0
																and right.dt_vendor_first_reported=0 and right.dt_vendor_last_reported=0)
																)// both seen and vendor date ranges overlap respectively
															and (left.dt_first_seen between right.dt_first_seen and right.dt_last_seen
																	or left.dt_last_seen between right.dt_first_seen and right.dt_last_seen
															    or right.dt_first_seen between left.dt_first_seen and left.dt_last_seen
																	or right.dt_last_seen between left.dt_first_seen and left.dt_last_seen)
															and (left.dt_vendor_first_reported between right.dt_vendor_first_reported and right.dt_vendor_last_reported
																	or left.dt_vendor_last_reported between right.dt_vendor_first_reported and right.dt_vendor_last_reported
															    or right.dt_vendor_first_reported between left.dt_vendor_first_reported and left.dt_vendor_last_reported
																	or right.dt_vendor_last_reported between left.dt_vendor_first_reported and left.dt_vendor_last_reported)
															)
													or (
																ut.NNEQ_Date(left.dob, right.dob)
															and	(left.dt_first_seen=0 or right.dt_first_seen=0 or left.dt_last_seen=0 or right.dt_last_seen=0)
															and	left.dt_vendor_first_reported>0 and	left.dt_vendor_last_reported>0
															and right.dt_vendor_first_reported>0 and right.dt_vendor_last_reported>0
															// and vendor dates ranges overlap
															and (left.dt_vendor_first_reported between right.dt_vendor_first_reported and right.dt_vendor_last_reported
																	or left.dt_vendor_last_reported between right.dt_vendor_first_reported and right.dt_vendor_last_reported
															    or right.dt_vendor_first_reported between left.dt_vendor_first_reported and left.dt_vendor_last_reported
																	or right.dt_vendor_last_reported between left.dt_vendor_first_reported and left.dt_vendor_last_reported)
															)
													or (//one of the seen dates and one of the vendor dates are missing
																ut.NNEQ_Date(left.dob, right.dob)
															and	(left.dt_first_seen=0 or right.dt_first_seen=0 or left.dt_last_seen=0 or right.dt_last_seen=0)
															and	(left.dt_vendor_first_reported=0 or right.dt_vendor_first_reported=0 or left.dt_vendor_last_reported=0 or right.dt_vendor_last_reported=0)
															)
										)
							and	ut.nneq(left.phone       ,right.phone)
							and	(
									ut.nneq(left.mname       ,right.mname)
								or (if(left.mname[1]=right.mname[1] and (length(trim(left.mname))=1 or length(trim(right.mname))=1),true,false))
								)
							and	ut.nneq(left.name_suffix ,right.name_suffix)
							and	ut.nneq(left.zip         ,right.zip)
							and	ut.nneq(left.county      ,right.county)

							and	(left.dt_first_seen=right.dt_first_seen or left.dt_first_seen=0 or right.dt_first_seen=0)
							)
						)
					,tra(left,right)
					,local);
                
sj := sort(distribute(j,old_rid),old_rid,new_rid,local);

rolled_rids := dedup(sj,old_rid,local);

inf_seqd:=project(inf,transform({inf},self.persistent_record_ID:=left.rid,self:=left));

ut.MAC_Patch_Id(inf_seqd, rid, rolled_rids, old_rid, new_rid, old_and_new);

dinfile := distribute(old_and_new,hash(rid));

BR_s := sort(dinfile, rid,dt_vendor_last_reported,dt_vendor_first_reported,dt_last_seen,persistent_record_ID,local);

hddpd := rollup(BR_s,left.rid=right.rid,header.tra_merge_headers(left,right),local);

merged_dist0 := distribute(hddpd,hash(did));

//remove death records that have been purged from Death Master since the last Header
head := header.fn_remove_deaths_not_in_death_master(merged_dist0);

//i wanted to move this ahead of the 'repeated value' check so that ZZZZZZZZZZ (10 Z's) 
//would be removed rather than just truncate to ZZZZZ (5 Z's)
remove_junk_names := header.fn_junk_names(head);

//created just so we have a single point of reference for straightening-up
header.layout_header more_cleanup(header.layout_header le) := transform

  self.ssn   := if(le.ssn in ut.set_badssn,'',le.ssn);
  self.phone := header.fn_blank_bogus_phones(le.phone);
  
  self.title     := '';
  self.fname     := if(header.mod_value_is_repeated(le.fname).is_repeated,    header.mod_value_is_repeated(le.fname).fixed,    le.fname);
  self.mname     := if(header.mod_value_is_repeated(le.mname).is_repeated,    header.mod_value_is_repeated(le.mname).fixed,    le.mname);
  self.lname     := if(header.mod_value_is_repeated(le.lname).is_repeated,    header.mod_value_is_repeated(le.lname).fixed,    le.lname);
  self.prim_name := if(header.mod_value_is_repeated(le.prim_name).is_repeated,header.mod_value_is_repeated(le.prim_name).fixed,le.prim_name);
  self.name_suffix := fn_cleanup_name_suffix(le.name_suffix);
  self := le;

end;

noJunk1 := project(remove_junk_names,more_cleanup(left));
Header.Mac_dedup_header(noJunk1, noJunk, '_fcra_lr');

//****** Remove some known bad names  city_name='OZ' and st
isjunky := header.BogusNames(noJunk.FNAME, noJunk.MNAME, noJunk.LNAME) or header.BogusCities(noJunk.city_name, noJunk.st);
kill_junk := noJunk(not isjunky);
the_junk  := noJunk(isjunky);
output(the_junk,,'base::header_bogusjunk' + thorlib.wuid(),overwrite);

///////////////////////////////////////////////////////////////
// remove_EN_deletes0 := Header.Fn_Remove_EN_deletes(kill_junk); 

noComp   := fn_remove_companies(project(kill_junk,header.layout_header)): persist('~thor_data400::fcra_last_rollup::patched');

patched := noComp;
if ( count(patched(did>rid)) <> 0, output('DID > RID constraint violated') );

//this filter is applied because of mac_flipnames rule 2; this can result in records with no last_name W20100505-090313
merged   := patched(fname<>'' and lname<>'');

header.EntropyMatch(merged,entropy_matches,entropy_nonmatches);

merged mark_amb(merged le, entropy_nonmatches ri) :=
TRANSFORM
	SELF.jflag2 := IF(ri.old_rid<>0,'A','');
	SELF := le;
END;
amb_marked := JOIN(merged,entropy_nonmatches,LEFT.did=RIGHT.old_rid,mark_amb(LEFT,RIGHT),LEFT OUTER,HASH);

//bypass ambigous marking if BOCA linked b/c it was already done in header.With_Did, else, flag entropy ambigous
merged_dist := distribute(amb_marked,hash(did));

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
									 
fix_dates  := header.fn_fix_dates(dSetJFlagForPropertyFragments,,filedate);
set_titles := header.fn_apply_title(fix_dates);
append_PID := header.fn_persistent_record_ID(set_titles);
 
_FCRA_Last_Rollup := (append_PID + Dummy_records.FCRAseed) : persist('persist::fcra_last_rollup');
return _FCRA_Last_Rollup;
end;