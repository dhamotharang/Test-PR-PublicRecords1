﻿import doxie,header_quick,dx_header,MDR,IDL_Header;

r:=doxie.layout_references;

export Append_addr_ind(dataset(r) in_ds, 
											 BOOLEAN bypassTU = FALSE,		//set to TRUE to bypass Transunion data
											 BOOLEAN returnInsAdr = FALSE,//insurance only addresses, REQUIRES perm use
											 BOOLEAN returnDates = FALSE, //set to TRUE to get dates on output, type of date depends on next flag
											 BOOLEAN usePRDates = TRUE,		//set to FALSE to use insurance dates (more comprehensive, but requires perm use). returnDates needs to be set to TRUE for dates to be populated.
											 BOOLEAN slimOutput = FALSE,	//set to TRUE to remove predir, postdir, and addr_suffix
											 BOOLEAN isFCRA = FALSE,			//set to TRUE to used FCRA addr_unique, header, and header_quick keys
											 BOOLEAN bypassQH = FALSE) 		//set to TRUE to bypass Quick Header data
											 := FUNCTION

import ut;

FCRAUse := IF(isFCRA,1,0);

hdr:= dx_header.key_header(FCRAUse);

qh := IF(isFCRA, header_quick.Key_Did_FCRA, header_quick.key_did);

tu_srcs := MDR.SourceTools.set_Transunion + ['TS'];
bureau_srcs := [MDR.SourceTools.set_Equifax,MDR.SourceTools.set_Transunion, MDR.SourceTools.src_Experian_Credit_Header];
ins_srcs := IDL_Header.SourceTools.set_insurance_sources;
prop_srcs := MDR.SourceTools.set_Property;
utility_srcs := MDR.SourceTools.set_Utility_sources;
veh_srcs := MDR.SourceTools.set_Vehicles;
dl_srcs := MDR.SourceTools.set_DL;
voter_srcs := MDR.SourceTools.src_Voters_v2;

rec := Layout_addr_ind;
rec_full := Layout_addr_ind_full;
newrec := record
  rec_full;
	unsigned6 rid;
	string1 isTU;
	string1 isQH;
	string2 src;
	string18 vendor_id;
	unsigned8 rawaid;
	unsigned4 global_sid;
end;

midrec := record
	newrec - [permissions_ds];
	unsigned8 permissions;
end;

outrec := Layout_addr_ind_out;
 
mindate (unsigned3 dt1, unsigned3 dt2) := MAP(dt1 = 0 => dt2, dt2 = 0 => dt1, min(dt1,dt2));

ua_Key      := dx_Header.Key_Addr_Unique_Expanded(FCRAUse);
get_ua      := join(in_ds,ua_Key,Keyed(left.did = right.did),transform(newrec,self:=right,self:=[]),limit(10000));

high_inds   := dedup(sort(get_ua(addr_ind NOT BETWEEN '91' AND '99'),did,-(integer) addr_ind),did,addr_ind);
datesRolled  := rollup(sort(get_ua,did,-(integer) addr_ind),
                      left.did      = right.did AND 
											left.addr_ind = right.addr_ind,
											transform(newrec,
											          self.dt_first_seen := mindate(left.dt_first_seen,right.dt_first_seen),
											          self.dt_first_seen_pr := mindate(left.dt_first_seen_pr,right.dt_first_seen_pr),
																self.dt_last_seen  := max(left.dt_last_seen,right.dt_last_seen),
																self.dt_last_seen_pr  := max(left.dt_last_seen_pr,right.dt_last_seen_pr),
																self.dt_vendor_first_reported := mindate(left.dt_vendor_first_reported,right.dt_vendor_first_reported),
																self.dt_vendor_first_reported_pr := mindate(left.dt_vendor_first_reported_pr,right.dt_vendor_first_reported_pr),
																self.dt_vendor_last_reported  := max(left.dt_vendor_last_reported,right.dt_vendor_last_reported),
																self.dt_vendor_last_reported_pr  := max(left.dt_vendor_last_reported_pr,right.dt_vendor_last_reported_pr),
																self := right,
																self := left));

bhdr         := join(in_ds,hdr,keyed(left.did = right.s_did),
                    transform(midrec,
									            self.did         :=right.s_did,
														  self.addr_suffix := right.suffix,
														  self.city        := right.city_name,
														  self.isTU           := 'Y';
														  self.best_addr_ind  := 'B';
														  self.best_addr_rank := '1';
															self.addr_ind       := '1';
															self.src_cnt        := 1;
															self.insurance_src_cnt := IF(right.src IN ins_srcs,1,0);
															self.bureau_src_cnt := IF(right.src IN bureau_srcs,1,0);
															self.property_src_cnt := IF(right.src IN prop_srcs,1,0);
															self.utility_src_cnt := IF(right.src IN utility_srcs,1,0);
															self.vehicle_src_cnt := IF(right.src IN veh_srcs,1,0);
															self.dl_src_cnt := IF(right.src IN dl_srcs,1,0);
															self.voter_src_cnt := IF(right.src = voter_srcs,1,0);
															self.src_cnt_total := 1;
															self.insurance_src_cnt_total := IF(right.src IN ins_srcs,1,0);
															self.bureau_src_cnt_total := IF(right.src IN bureau_srcs,1,0);
															self.property_src_cnt_total := IF(right.src IN prop_srcs,1,0);
															self.utility_src_cnt_total := IF(right.src IN utility_srcs,1,0);
															self.vehicle_src_cnt_total := IF(right.src IN veh_srcs,1,0);
															self.dl_src_cnt_total := IF(right.src IN dl_srcs,1,0);
															self.voter_src_cnt_total := IF(right.src = voter_srcs,1,0);
															self.dt_first_seen_pr := right.dt_first_seen;
															self.dt_last_seen_pr := right.dt_last_seen;
															self.dt_vendor_first_reported_pr := right.dt_vendor_first_reported;
															self.dt_vendor_last_reported_pr := right.dt_vendor_last_reported;
														  self:=right,self:=[]),limit(10000));

//Added address permissions for TU data
bhdr_tu      := addAddressPerms(bhdr(src IN tu_srcs),src,vendor_id,dt_first_seen,rid,st,global_sid,permissions,FALSE,FCRAUse);

qhdr0         := join(in_ds,qh,keyed(left.did = right.did),
                    transform(midrec,
														  self.addr_suffix := right.suffix,
														  self.city        := right.city_name,
														  self.isQH           := 'Y';
														  self.best_addr_ind  := 'B';
														  self.best_addr_rank := '1';
															self.addr_ind       := '1';
															self.src_cnt        := 1;
															self.insurance_src_cnt := IF(right.src IN ins_srcs,1,0);
															self.bureau_src_cnt := IF(right.src IN bureau_srcs,1,0);
															self.property_src_cnt := IF(right.src IN prop_srcs,1,0);
															self.utility_src_cnt := IF(right.src IN utility_srcs,1,0);
															self.vehicle_src_cnt := IF(right.src IN veh_srcs,1,0);
															self.dl_src_cnt := IF(right.src IN dl_srcs,1,0);
															self.voter_src_cnt := IF(right.src = voter_srcs,1,0);
															self.src_cnt_total := 1;
															self.insurance_src_cnt_total := IF(right.src IN ins_srcs,1,0);
															self.bureau_src_cnt_total := IF(right.src IN bureau_srcs,1,0);
															self.property_src_cnt_total := IF(right.src IN prop_srcs,1,0);
															self.utility_src_cnt_total := IF(right.src IN utility_srcs,1,0);
															self.vehicle_src_cnt_total := IF(right.src IN veh_srcs,1,0);
															self.dl_src_cnt_total := IF(right.src IN dl_srcs,1,0);
															self.voter_src_cnt_total := IF(right.src = voter_srcs,1,0);
															self.isTU						:= IF(right.src IN tu_srcs,'Y','');
															self.dt_first_seen_pr := right.dt_first_seen;
															self.dt_last_seen_pr := right.dt_last_seen;
															self.dt_vendor_first_reported_pr := right.dt_vendor_first_reported;
															self.dt_vendor_last_reported_pr := right.dt_vendor_last_reported;
														  self:=right,self:=[]),limit(10000));
															
wh_removed := IF(Doxie.DataRestriction.WH,qhdr0(~mdr.sourceTools.sourceisWeeklyHeader(src)),qhdr0);

qhdr := addAddressPerms(wh_removed,src,vendor_id,dt_first_seen,rid,st,global_sid,permissions,FALSE,FCRAUse);

qhdr_tu      := qhdr(src IN tu_srcs);
qhdr_nontu	 := qhdr(src NOT IN tu_srcs);

//replaces old rollup
roll_qh := reduceAddressPerms(qhdr_nontu,FALSE);

qh_perms_updated := join(get_ua,roll_qh,
													left.did						= right.did AND
													left.prim_range			= right.prim_range AND
													left.predir					=	right.predir AND
													left.prim_name			= right.prim_name AND
													left.addr_suffix		= right.addr_suffix AND
													left.postdir				= right.postdir AND
													left.sec_range			=	right.sec_range AND
													left.city						= right.city AND
													left.st							= right.st AND
													left.zip						= right.zip,
													transform(newrec,
																		self.permissions_ds := IF(right.did>0,left.permissions_ds + right.permissions_ds,left.permissions_ds),
																		self := left),left outer);

qh_only := dedup(sort(get_ua + roll_qh,
                       did,prim_range,predir,prim_name,addr_suffix,postdir,sec_range,city,st,zip,isQH),
											 did,prim_range,predir,prim_name,addr_suffix,postdir,sec_range,city,st,zip)(isQH='Y');

//Exact match between core address components 
cleanApt (string apt) := trim(ut.rmv_ld_zeros(StringLib.StringFindReplace(apt,'-','')),all);

qh_matches := join(qh_only,get_ua,
                    left.did                  = right.did AND
										left.prim_range           = right.prim_range AND
										left.prim_name            = right.prim_name  AND
									  cleanApt(left.sec_range)  = cleanApt(right.sec_range)  AND
									  left.st                   = right.st,
										transform(newrec,
										          self.addr_ind      := right.addr_ind,
															self.apt_cnt       := right.apt_cnt,
															self.src_cnt_total := right.src_cnt_total,
															self.insurance_src_cnt_total := right.insurance_src_cnt_total,
															self.bureau_src_cnt_total := right.bureau_src_cnt_total,
															self.property_src_cnt_total := right.property_src_cnt_total,
															self.utility_src_cnt_total := right.utility_src_cnt_total,
															self.vehicle_src_cnt_total := right.vehicle_src_cnt_total,
															self.dl_src_cnt_total := right.dl_src_cnt_total,
															self.voter_src_cnt_total := right.voter_src_cnt_total,
															self.best_addr_ind := [],
															self := left));
															
//QH has a blank sec range while unique Address Key does not
qh_blanksec := join(qh_only,get_ua,
                        left.did         = right.did AND
												left.prim_range  = right.prim_range AND
												left.prim_name   = right.prim_name  AND
												right.sec_range  <> ''              AND
												left.sec_range   =  ''              AND
												left.st          = right.st,
												transform(newrec,
										          self.addr_ind      := right.addr_ind,
															self.apt_cnt       := right.apt_cnt,
															self.src_cnt_total := right.src_cnt_total,
															self.insurance_src_cnt_total := right.insurance_src_cnt_total,
															self.bureau_src_cnt_total := right.bureau_src_cnt_total,
															self.property_src_cnt_total := right.property_src_cnt_total,
															self.utility_src_cnt_total := right.utility_src_cnt_total,
															self.vehicle_src_cnt_total := right.vehicle_src_cnt_total,
															self.dl_src_cnt_total := right.dl_src_cnt_total,
															self.voter_src_cnt_total := right.voter_src_cnt_total,
															self.best_addr_ind  := [],
															self := left));

//QH has a sec range, but the sec range is blank for the Unique Address Key
ua_blankrec     := dedup(sort(get_ua,did,(integer)addr_ind,-sec_range),did,addr_ind);

qh_nonblanksec  := join(qh_only,ua_blankrec,
                        left.did        = right.did AND
												left.prim_range = right.prim_range AND
												left.prim_name  = right.prim_name  AND
												right.sec_range =  ''              AND
												left.sec_range  <> ''              AND
												left.st         = right.st,
												transform(newrec,
										          self.addr_ind      := right.addr_ind,
															self.apt_cnt       := right.apt_cnt,
															self.src_cnt_total := right.src_cnt_total,
															self.insurance_src_cnt_total := right.insurance_src_cnt_total,
															self.bureau_src_cnt_total := right.bureau_src_cnt_total,
															self.property_src_cnt_total := right.property_src_cnt_total,
															self.utility_src_cnt_total := right.utility_src_cnt_total,
															self.vehicle_src_cnt_total := right.vehicle_src_cnt_total,
															self.dl_src_cnt_total := right.dl_src_cnt_total,
															self.voter_src_cnt_total := right.voter_src_cnt_total,
															self.best_addr_ind  := [],
															self := left));

qh_adddates := join(qh_matches + qh_blanksec + qh_nonblanksec,datesRolled,
                 left.did = right.did AND left.addr_ind = right.addr_ind,
								 transform(newrec,
								           self.dt_first_seen := mindate(left.dt_first_seen,right.dt_first_seen),
								           self.dt_first_seen_pr := mindate(left.dt_first_seen_pr,right.dt_first_seen_pr),
													 self.dt_last_seen  := max(left.dt_last_seen,right.dt_last_seen),
													 self.dt_last_seen_pr  := max(left.dt_last_seen_pr,right.dt_last_seen_pr),
													 self.dt_vendor_first_reported := mindate(left.dt_vendor_first_reported,right.dt_vendor_first_reported),
													 self.dt_vendor_first_reported_pr := mindate(left.dt_vendor_first_reported_pr,right.dt_vendor_first_reported_pr),
													 self.dt_vendor_last_reported  := max(left.dt_vendor_last_reported,right.dt_vendor_last_reported),
													 self.dt_vendor_last_reported_pr  := max(left.dt_vendor_last_reported_pr,right.dt_vendor_last_reported_pr),
													 self := left)); 
													 
qh_matches_all := dedup(sort(qh_adddates,
                             did,prim_range,prim_name,sec_range,st,(integer) addr_ind),
														 did,prim_range,prim_name,sec_range,st);

//New addresses, may need to be linked to each other
qh_mismatches := join(qh_matches_all,qh_only,
                        left.did        = right.did AND
												left.prim_range = right.prim_range AND
												left.prim_name  = right.prim_name  AND
											  left.sec_range  = right.sec_range  AND
												left.st         = right.st,
												right only);

qh_mismatches_nbrd  := iterate(sort(high_inds + qh_mismatches,
                               did,-isQH,(integer) addr_ind,prim_range,prim_name,-sec_range,st),
										           transform(newrec,
											                   self.addr_ind := IF(left.did=right.did,
																				                     IF(left.prim_range = right.prim_range AND
																														    left.prim_name  = right.prim_name  AND
																															 (left.sec_range  = right.sec_range  OR
																															  left.sec_range  = ''               OR
																																right.sec_range = '')              AND
																																left.st         = right.st,
																																left.addr_ind,
																                              ((string2) (((integer) left.addr_ind) + 1))),
																									      	right.addr_ind);
																				 self.best_addr_ind := IF(left.did=right.did,
																				                          IF(self.addr_ind=left.addr_ind,
																																	   '',
																																	   left.best_addr_ind),
																									      	      right.best_addr_ind);
																         self := right))(isQH='Y');																				 

qh_mismatches_rolled := rollup(qh_mismatches_nbrd,
                               left.did = right.did AND left.addr_ind = right.addr_ind,
															 transform(newrec,
															           self.dt_first_seen := mindate(left.dt_first_seen,right.dt_first_seen),
															           self.dt_first_seen_pr := mindate(left.dt_first_seen_pr,right.dt_first_seen_pr),
																				 self.dt_last_seen  := max(left.dt_last_seen,right.dt_last_seen),
																				 self.dt_last_seen_pr  := max(left.dt_last_seen_pr,right.dt_last_seen_pr),
																				 self.dt_vendor_first_reported := mindate(left.dt_vendor_first_reported,right.dt_vendor_first_reported),
																				 self.dt_vendor_first_reported_pr := mindate(left.dt_vendor_first_reported_pr,right.dt_vendor_first_reported_pr),
																				 self.dt_vendor_last_reported  := max(left.dt_vendor_last_reported,right.dt_vendor_last_reported),
																				 self.dt_vendor_last_reported_pr  := max(left.dt_vendor_last_reported_pr,right.dt_vendor_last_reported_pr),
																				 self := right));
																				 
qh_mismatches_dated  := join(qh_mismatches_nbrd,qh_mismatches_rolled,
                             left.did=right.did AND left.addr_ind = right.addr_ind,
														 transform(newrec,
														           self.dt_first_seen := right.dt_first_seen,
														           self.dt_first_seen_pr := right.dt_first_seen_pr,
																			 self.dt_last_seen  := right.dt_last_seen,
																			 self.dt_last_seen_pr  := right.dt_last_seen_pr,
																			 self.dt_vendor_first_reported := right.dt_vendor_first_reported,
																			 self.dt_vendor_first_reported_pr := right.dt_vendor_first_reported_pr,
																			 self.dt_vendor_last_reported  := right.dt_vendor_last_reported,
																			 self.dt_vendor_last_reported_pr  := right.dt_vendor_last_reported_pr,
																			 self := left));

qh_join_rec := RECORD
	string2 addr_ind_new;
	unsigned3 dt_first_seen_ua;
	unsigned3 dt_last_seen_ua;
	newrec;
END;

qh_mismatches_joined := join(high_inds, qh_mismatches_dated(dt_last_seen > 0),
															LEFT.did = RIGHT.did AND RIGHT.dt_last_seen >= LEFT.dt_last_seen,
															TRANSFORM(qh_join_rec,
																				self.addr_ind_new := left.addr_ind;
																				self.dt_first_seen_ua := left.dt_first_seen;
																				self.dt_last_seen_ua := left.dt_last_seen;
																				self:= right),right outer);

qh_mismatches_ordered := dedup(sort(qh_mismatches_joined(dt_last_seen > dt_last_seen_ua OR dt_first_seen >= dt_first_seen_ua),did,(integer)addr_ind,(integer)addr_ind_new,-dt_last_seen,-dt_first_seen),did,addr_ind);

qh_mismatches_unordered := dedup(sort(join(qh_mismatches_dated,qh_mismatches_ordered,
																left.did=right.did and left.addr_ind=right.addr_ind,
																transform(qh_join_rec,
																					self.addr_ind_new := '91';
																					self:=left;self:=[]),left only),
																					did,(integer)addr_ind,(integer)addr_ind_new),
																					did,addr_ind,addr_ind_new);

qh_reordered := iterate(sort(project(high_inds,
														TRANSFORM(qh_join_rec,
																			self.addr_ind_new := left.addr_ind;
																			self:=left;self:=[])) + qh_mismatches_ordered + qh_mismatches_unordered,
																			did,(integer)addr_ind_new,-isQH,-dt_last_seen,-dt_first_seen),
																			transform(qh_join_rec,
																								self.addr_ind_new := IF(left.did <> right.did,'1',
																																				(string)((unsigned)left.addr_ind_new+1));
																								self:=right));

qh_mismatches_updated := join(qh_reordered(isQH = 'Y'),qh_mismatches_ordered + qh_mismatches_unordered,
															left.did = right.did and left.addr_ind = right.addr_ind,
															transform(newrec,
																				self.addr_ind := left.addr_ind_new,
																				self:=right));
															
qh_matches_updated := join(qh_reordered(isQH = ''),get_ua + qh_matches_all,
															left.did = right.did and left.addr_ind = right.addr_ind,
															transform(newrec,
																				self.addr_ind := left.addr_ind_new,
																				self:=right));

qh_all :=  IF(bypassQH,get_ua,qh_mismatches_updated + qh_matches_updated + qh_perms_updated(addr_ind BETWEEN '91' AND '99'));

//replaces old rollup
roll_tu := reduceAddressPerms(IF(bypassQH,bhdr_tu,bhdr_tu+qhdr_tu),FALSE);
																
tu_perms_updated := join(qh_perms_updated,roll_tu,
													left.did						= right.did AND
													left.prim_range			= right.prim_range AND
													left.predir					=	right.predir AND
													left.prim_name			= right.prim_name AND
													left.addr_suffix		= right.addr_suffix AND
													left.postdir				= right.postdir AND
													left.sec_range			=	right.sec_range AND
													left.city						= right.city AND
													left.st							= right.st AND
													left.zip						= right.zip,
													transform(newrec,
																		self.permissions_ds := IF(right.did > 0,left.permissions_ds + right.permissions_ds,left.permissions_ds),
																		self := left),left outer);

//Drop TU records that are already in unique Address Key							 
tu_only := dedup(sort(qh_all + roll_tu,
                       did,prim_range,predir,prim_name,addr_suffix,postdir,sec_range,city,st,zip,isTU),
											 did,prim_range,predir,prim_name,addr_suffix,postdir,sec_range,city,st,zip)(isTU='Y');

//Exact match between core address components 
tu_matches := join(tu_only,qh_all,
                    left.did                  = right.did AND
										left.prim_range           = right.prim_range AND
										left.prim_name            = right.prim_name  AND
									  cleanApt(left.sec_range)  = cleanApt(right.sec_range)  AND
									  left.st                   = right.st,
										transform(newrec,
										          self.addr_ind      := right.addr_ind,
															self.apt_cnt       := right.apt_cnt,
															self.src_cnt_total := right.src_cnt_total,
															self.insurance_src_cnt_total := right.insurance_src_cnt_total,
															self.bureau_src_cnt_total := right.bureau_src_cnt_total,
															self.property_src_cnt_total := right.property_src_cnt_total,
															self.utility_src_cnt_total := right.utility_src_cnt_total,
															self.vehicle_src_cnt_total := right.vehicle_src_cnt_total,
															self.dl_src_cnt_total := right.dl_src_cnt_total,
															self.voter_src_cnt_total := right.voter_src_cnt_total,
															self.best_addr_ind := [],
															self := left));
															
//TU has a blank sec range while unique Address Key does not
tu_blanksec := join(tu_only,qh_all,
                        left.did         = right.did AND
												left.prim_range  = right.prim_range AND
												left.prim_name   = right.prim_name  AND
												right.sec_range  <> ''              AND
												left.sec_range   =  ''              AND
												left.st          = right.st,
												transform(newrec,
										          self.addr_ind      := right.addr_ind,
															self.apt_cnt       := right.apt_cnt,
															self.src_cnt_total := right.src_cnt_total,
															self.insurance_src_cnt_total := right.insurance_src_cnt_total,
															self.bureau_src_cnt_total := right.bureau_src_cnt_total,
															self.property_src_cnt_total := right.property_src_cnt_total,
															self.utility_src_cnt_total := right.utility_src_cnt_total,
															self.vehicle_src_cnt_total := right.vehicle_src_cnt_total,
															self.dl_src_cnt_total := right.dl_src_cnt_total,
															self.voter_src_cnt_total := right.voter_src_cnt_total,
															self.best_addr_ind  := [],
															self := left));

//TU has a sec range, but the sec range is blank for the Unique Address Key
qh_blankrec     := dedup(sort(qh_all,did,(integer)addr_ind,-sec_range),did,addr_ind);

tu_nonblanksec  := join(tu_only,qh_blankrec,
                        left.did        = right.did AND
												left.prim_range = right.prim_range AND
												left.prim_name  = right.prim_name  AND
												right.sec_range =  ''              AND
												left.sec_range  <> ''              AND
												left.st         = right.st,
												transform(newrec,
										          self.addr_ind      := right.addr_ind,
															self.apt_cnt       := right.apt_cnt,
															self.src_cnt_total := right.src_cnt_total,
															self.insurance_src_cnt_total := right.insurance_src_cnt_total,
															self.bureau_src_cnt_total := right.bureau_src_cnt_total,
															self.property_src_cnt_total := right.property_src_cnt_total,
															self.utility_src_cnt_total := right.utility_src_cnt_total,
															self.vehicle_src_cnt_total := right.vehicle_src_cnt_total,
															self.dl_src_cnt_total := right.dl_src_cnt_total,
															self.voter_src_cnt_total := right.voter_src_cnt_total,
															self.best_addr_ind  := [],
															self := left));

adddates := join(tu_matches + tu_blanksec + tu_nonblanksec,qh_all,
                 left.did = right.did AND left.addr_ind = right.addr_ind,
								 transform(newrec,
								           self.dt_first_seen := right.dt_first_seen,
								           self.dt_first_seen_pr := right.dt_first_seen_pr,
													 self.dt_last_seen  := right.dt_last_seen,
													 self.dt_last_seen_pr  := right.dt_last_seen_pr,
													 self.dt_vendor_first_reported := right.dt_vendor_first_reported,
													 self.dt_vendor_first_reported_pr := right.dt_vendor_first_reported_pr,
													 self.dt_vendor_last_reported  := right.dt_vendor_last_reported,
													 self.dt_vendor_last_reported_pr  := right.dt_vendor_last_reported_pr,
													 self := left)); 

tu_matches_all := dedup(sort(adddates,
                             did,prim_range,prim_name,sec_range,st,(integer) addr_ind),
														 did,prim_range,prim_name,sec_range,st);

//New addresses, may need to be linked to each other
tu_mismatches := join(tu_matches_all,tu_only,
                        left.did        = right.did AND
												left.prim_range = right.prim_range AND
												left.prim_name  = right.prim_name  AND
											  left.sec_range  = right.sec_range  AND
												left.st         = right.st,
												right only);

tu_mismatches_nbrd  := iterate(sort(qh_all + tu_mismatches,
                               did,isTU,(integer) addr_ind,prim_range,prim_name,-sec_range,st),
										           transform(newrec,
											                   self.addr_ind := IF(left.did=right.did,
																				                     IF(left.prim_range = right.prim_range AND
																														    left.prim_name  = right.prim_name  AND
																															 (left.sec_range  = right.sec_range  OR
																															  left.sec_range  = ''               OR
																																right.sec_range = '')              AND
																																left.st         = right.st,
																																left.addr_ind,
																                              ((string2) (((integer) left.addr_ind) + 1))),
																									      	right.addr_ind);
																				 self.best_addr_ind := IF(left.did=right.did,
																				                          IF(self.addr_ind=left.addr_ind,
																																	   '',
																																	   left.best_addr_ind),
																									      	      right.best_addr_ind);
																         self := right))(isTU='Y');

tu_mismatches_rolled := rollup(tu_mismatches_nbrd,
                               left.did = right.did AND left.addr_ind = right.addr_ind,
															 transform(newrec,
															           self.dt_first_seen := mindate(left.dt_first_seen,right.dt_first_seen),
															           self.dt_first_seen_pr := mindate(left.dt_first_seen_pr,right.dt_first_seen_pr),
																				 self.dt_last_seen  := max(left.dt_last_seen,right.dt_last_seen),
																				 self.dt_last_seen_pr  := max(left.dt_last_seen_pr,right.dt_last_seen_pr),
																				 self.dt_vendor_first_reported := mindate(left.dt_vendor_first_reported,right.dt_vendor_first_reported),
																				 self.dt_vendor_first_reported_pr := mindate(left.dt_vendor_first_reported_pr,right.dt_vendor_first_reported_pr),
																				 self.dt_vendor_last_reported  := max(left.dt_vendor_last_reported,right.dt_vendor_last_reported),
																				 self.dt_vendor_last_reported_pr  := max(left.dt_vendor_last_reported_pr,right.dt_vendor_last_reported_pr),
																				 self := right));
																				 
tu_mismatches_dated  := join(tu_mismatches_nbrd,tu_mismatches_rolled,
                             left.did=right.did AND left.addr_ind = right.addr_ind,
														 transform(newrec,
														           self.dt_first_seen := right.dt_first_seen,
														           self.dt_first_seen_pr := right.dt_first_seen_pr,
																			 self.dt_last_seen  := right.dt_last_seen,
																			 self.dt_last_seen_pr  := right.dt_last_seen_pr,
																			 self.dt_vendor_first_reported := right.dt_vendor_first_reported,
																			 self.dt_vendor_first_reported_pr := right.dt_vendor_first_reported_pr,
																			 self.dt_vendor_last_reported  := right.dt_vendor_last_reported,
																			 self.dt_vendor_last_reported_pr  := right.dt_vendor_last_reported_pr,
																			 self := left));

stdAptCnt := iterate(sort(tu_perms_updated + tu_matches_all + tu_mismatches_dated,
                          did,(integer) addr_ind,-apt_cnt),
													transform(newrec,
													self.apt_cnt := IF(left.did=right.did AND left.addr_ind=right.addr_ind,
																				     left.apt_cnt,
                       											 right.apt_cnt);
												  self := right));

tu_apts_ranked  := iterate(sort(stdAptCnt(apt_cnt>5),
                               did,(integer) addr_ind,sec_range='',-best_addr_ind,(integer) best_addr_rank,isTU),
										           transform(newrec,
											                   self.best_addr_rank := IF(left.did=right.did AND left.addr_ind=right.addr_ind,
																				                           ((string2) (((integer) left.best_addr_rank) + 1)),
                       																				     '1');
																         self := right));
																				 
tu_noapts_ranked  := iterate(sort(stdAptCnt(apt_cnt<=5),
                               did,(integer) addr_ind,-best_addr_ind,sec_range<>'',(integer) best_addr_rank,isTU),
										           transform(newrec,
											                   self.best_addr_rank := IF(left.did=right.did AND left.addr_ind=right.addr_ind,
																				                           ((string2) (((integer) left.best_addr_rank) + 1)),
                       																				     '1');
																         self := right));

tu_apts_combined := tu_apts_ranked + tu_noapts_ranked;
																					
// Join to boca header to get rawaid
add_rawaid_full := join(tu_apts_combined(isQH = ''),bhdr,
                   left.did         = right.did AND
									 left.prim_range  = right.prim_range AND
									 left.predir      = right.predir AND
									 left.prim_name   = right.prim_name AND 
									 left.addr_suffix = right.addr_suffix AND
									 left.postdir     = right.postdir AND
									 left.sec_range   = right.sec_range AND
									 left.city        = right.city AND
									 left.st          = right.st AND 
									 left.zip         = right.zip,
                   transform(outrec,
									           self.rawaid := right.rawaid,
														 self.dt_first_seen := IF(usePRDates,LEFT.dt_first_seen_pr,LEFT.dt_first_seen);
														 self.dt_last_seen := IF(usePRDates,LEFT.dt_last_seen_pr,LEFT.dt_last_seen);
														 self.dt_vendor_first_reported := IF(usePRDates,LEFT.dt_vendor_first_reported_pr,LEFT.dt_vendor_first_reported);
														 self.dt_vendor_last_reported := IF(usePRDates,LEFT.dt_vendor_last_reported_pr,LEFT.dt_vendor_last_reported);
														 self := left),left outer);
														 
add_rawaid_quick := join(tu_apts_combined(isQH = 'Y'),qhdr,
                   left.did         = right.did AND
									 left.prim_range  = right.prim_range AND
									 left.predir      = right.predir AND
									 left.prim_name   = right.prim_name AND 
									 left.addr_suffix = right.addr_suffix AND
									 left.postdir     = right.postdir AND
									 left.sec_range   = right.sec_range AND
									 left.city        = right.city AND
									 left.st          = right.st AND 
									 left.zip         = right.zip,
                   transform(outrec,
									           self.rawaid := right.rawaid,
														 self.dt_first_seen := IF(usePRDates,LEFT.dt_first_seen_pr,LEFT.dt_first_seen);
														 self.dt_last_seen := IF(usePRDates,LEFT.dt_last_seen_pr,LEFT.dt_last_seen);
														 self.dt_vendor_first_reported := IF(usePRDates,LEFT.dt_vendor_first_reported_pr,LEFT.dt_vendor_first_reported);
														 self.dt_vendor_last_reported := IF(usePRDates,LEFT.dt_vendor_last_reported_pr,LEFT.dt_vendor_last_reported);
														 self := left),left outer);
														 
dates_out := project(add_rawaid_full + add_rawaid_quick,TRANSFORM(outrec,
																SELF.predir := IF(slimOutput,'',LEFT.predir);
																SELF.postdir := IF(slimOutput,'',LEFT.postdir);
																SELF.addr_suffix := IF(slimOutput,'',LEFT.addr_suffix);
															  SELF.dt_first_seen := IF(returnDates,LEFT.dt_first_seen,0); 
															  SELF.dt_last_seen := IF(returnDates,LEFT.dt_last_seen,0);  
															  SELF.dt_vendor_first_reported := IF(returnDates,LEFT.dt_vendor_first_reported,0);   
															  SELF.dt_vendor_last_reported := IF(returnDates,LEFT.dt_vendor_last_reported,0);
																SELF.best_addr_ind := IF(LEFT.best_addr_rank = '1' AND LEFT.addr_ind NOT BETWEEN '91' AND '99','B','');
																SELF:=LEFT));

ins_rem := if(returnInsAdr,dates_out,dates_out(src_cnt <> insurance_src_cnt));
															
roll_out := ROLLUP(sort(ins_rem,did,(integer)addr_ind,prim_name,prim_range,sec_range,city,st,zip,predir,postdir,addr_suffix,(integer)best_addr_rank),
									 TRANSFORM(outrec,
														 SELF.addr_ind := LEFT.addr_ind;
														 SELF.best_addr_ind := IF(LEFT.best_addr_ind <> 'B',RIGHT.best_addr_ind,LEFT.best_addr_ind);
														 SELF.best_addr_rank := LEFT.best_addr_rank;
														 SELF.apt_cnt := MAX(LEFT.apt_cnt,RIGHT.apt_cnt);
														 i_src_cnt := MAX(LEFT.insurance_src_cnt,RIGHT.insurance_src_cnt);
														 b_src_cnt := MAX(LEFT.bureau_src_cnt,RIGHT.bureau_src_cnt);
														 p_src_cnt := MAX(LEFT.property_src_cnt,RIGHT.property_src_cnt);
														 u_src_cnt := MAX(LEFT.utility_src_cnt,RIGHT.utility_src_cnt);
														 v_src_cnt := MAX(LEFT.vehicle_src_cnt,RIGHT.vehicle_src_cnt);
														 d_src_cnt := MAX(LEFT.dl_src_cnt,RIGHT.dl_src_cnt);
														 o_src_cnt := MAX(LEFT.voter_src_cnt,RIGHT.voter_src_cnt);
														 x_src_cnt := MAX(LEFT.src_cnt - (LEFT.insurance_src_cnt + LEFT.bureau_src_cnt + LEFT.property_src_cnt + LEFT.utility_src_cnt + LEFT.vehicle_src_cnt + LEFT.dl_src_cnt + LEFT.voter_src_cnt),
																							RIGHT.src_cnt - (RIGHT.insurance_src_cnt + RIGHT.bureau_src_cnt + RIGHT.property_src_cnt + RIGHT.utility_src_cnt + RIGHT.vehicle_src_cnt + RIGHT.dl_src_cnt + RIGHT.voter_src_cnt));
														 SELF.src_cnt := i_src_cnt + b_src_cnt + p_src_cnt + u_src_cnt + v_src_cnt + d_src_cnt + o_src_cnt + x_src_cnt;
														 SELF.insurance_src_cnt := i_src_cnt;
														 SELF.bureau_src_cnt := b_src_cnt;
														 SELF.property_src_cnt := p_src_cnt;
														 SELF.utility_src_cnt := u_src_cnt;
														 SELF.vehicle_src_cnt := v_src_cnt;
														 SELF.dl_src_cnt := d_src_cnt;
														 SELF.voter_src_cnt := o_src_cnt;
														 SELF:=LEFT),
												did,prim_name,prim_range,sec_range,city,st,zip,predir,postdir,addr_suffix);

newIndRec := RECORD
	unsigned8 did;
	string2 addr_ind;
	string2 new_ind;
END;

ded_newind := project(dedup(roll_out,did,addr_ind),TRANSFORM(newIndRec,SELF:=LEFT,SELF:=[]));
												
ded_reind := iterate(SORT(ded_newind,did,(integer)addr_ind),TRANSFORM(newIndRec,
																										SELF.new_ind := IF(LEFT.did <> RIGHT.did,'1',
																																		IF(RIGHT.addr_ind between '91' and '99' and left.addr_ind NOT between '91' and '99',
																																		RIGHT.addr_ind,(string2)(((integer)LEFT.new_ind) + 1)));
																										SELF := RIGHT));

join_inds := JOIN(roll_out,ded_reind,LEFT.did = RIGHT.did AND LEFT.addr_ind = RIGHT.addr_ind,TRANSFORM(outrec,SELF.addr_ind := RIGHT.new_ind; SELF:=LEFT));
																				 
ded_out_ranked := iterate(sort(join_inds,did,(integer)addr_ind,(integer)best_addr_rank),
									TRANSFORM(outrec, SELF.best_addr_rank := IF(LEFT.did = RIGHT.did and LEFT.addr_ind = RIGHT.addr_ind,
																															(string2)(((integer)LEFT.best_addr_rank) + 1),'1');
																		SELF:= RIGHT));
									           													 
return sort(ded_out_ranked(IF(bypassTU,isTU<>'Y',TRUE)),did,(integer) addr_ind, (integer) best_addr_rank); 

end;