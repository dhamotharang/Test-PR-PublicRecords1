import ut,did_add,mdr,idl_header;

export Last_Rollup(string filedate) := FUNCTION

inf := distribute(header.with_tnt,hash(did))(src<>'D$');

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

ut.MAC_Patch_Id(inf, rid, rolled_rids, old_rid, new_rid, old_and_new);

dinfile := distribute(old_and_new,hash(rid));

BR_s := sort(dinfile, rid,dt_vendor_last_reported,dt_vendor_first_reported,dt_last_seen,local);

merged := rollup(BR_s,left.rid=right.rid,header.tra_merge_headers(left,right),local);

fix_dates  := header.fn_fix_dates(merged,,filedate);
set_titles := header.fn_apply_title(fix_dates);

if ( count(set_titles(did>rid)) <> 0, output('DID > RID constraint violated') );

_Last_Rollup := (set_titles + Dummy_records.NonFCRAseed) : persist('persist::last_rollup');
return _Last_Rollup;
END;