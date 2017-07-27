import ut, watchdog,Gong_v2, gong;
EXPORT fn_phone_scoring_attributes (dataset(recordof(Gong_v2.layout_gongMaster)) gong_m) := function

ScoringRecord := RECORD
 Gong_Platinum.LayoutScoringAttributes.KeyLayout;
END;

gong_m_with_phone := Gong.File_History(phone10 <> '');

gong_m_with_phone_curr := gong_m_with_phone(current_record_flag = 'Y');
gong_m_with_phone_hist := join(distribute(gong_m_with_phone(current_record_flag <> 'Y'), hash(phone10)),
													distribute(gong_m_with_phone_curr, hash(phone10)),
													left.phone10 = right.phone10 and
													left.did = right.did and
													left.name_last = right.name_last and
													left.prim_range = right.prim_range and
													left.prim_name = right.prim_name and
													left.sec_range = right.sec_range and
													left.z5 = right.z5,
													left only,
													local);
gong_m_with_phone_d_ph := distribute(gong_m_with_phone_curr + gong_m_with_phone_hist, hash(phone10));

Gong_phone_indiv_dedp := dedup(sort(project(gong_m_with_phone_d_ph, {gong_m_with_phone_d_ph.phone10, gong_m_with_phone_d_ph.did, gong_m_with_phone_d_ph.current_record_flag}), phone10, did, -current_record_flag, local), phone10, did, current_record_flag, local);
Gong_phone_addr_dedp := dedup(sort(gong_m_with_phone_d_ph (trim(prim_range + prim_name + suffix + sec_range, all) <> '' and z5 <> ''), phone10, prim_range, prim_name, suffix, sec_range, z5, -current_record_flag, local), phone10, prim_range, prim_name, suffix, sec_range, z5, current_record_flag, local);
Gong_phone_hhid_dedp := dedup(sort(gong_m_with_phone_d_ph (hhid > 0), phone10, hhid, -current_record_flag, local), phone10, hhid, current_record_flag, local);

//History
num_phone_owners_hist_tb := table(Gong_phone_indiv_dedp (current_record_flag <> 'Y'), {phone10, cnt := count(group)}, phone10);
num_phones_discon_indiv_tb := table(Gong_phone_indiv_dedp(current_record_flag <> 'Y' and did > 0), {did, cnt := count(group)}, did);
num_phones_discon_addr_tb := table(Gong_phone_addr_dedp (current_record_flag <> 'Y'), {adr := prim_range + prim_name + suffix + sec_range + z5, cnt := count(group)}, prim_range + prim_name + suffix + sec_range + z5);
num_phones_discon_hhid_tb := table(Gong_phone_hhid_dedp (current_record_flag <> 'Y'), {hhid, cnt := count(group)}, hhid, few);

//Current
num_phone_owners_cur_tb := table(Gong_phone_indiv_dedp(current_record_flag = 'Y'), {phone10, cnt := count(group)}, phone10);
num_phones_connected_indiv_tb := table(Gong_phone_indiv_dedp (did > 0 and current_record_flag = 'Y' ), {did, cnt := count(group)}, did);
num_phones_connected_hhid_tb := table(Gong_phone_hhid_dedp(hhid > 0 and current_record_flag = 'Y'), {hhid, cnt := count(group)}, hhid);
num_phones_connected_addr_tb := table(Gong_phone_addr_dedp (current_record_flag = 'Y'), {adr := prim_range + prim_name + suffix + sec_range + z5, cnt := count(group)}, prim_range + prim_name + suffix + sec_range + z5);


num_phones_indiv_tb := table(dedup(sort(Gong_phone_indiv_dedp  (did > 0 ), phone10, did, local), phone10, did, local) , {did, cnt := count(group)}, did, few);


temp_ly2 := record
 unsigned did;
 string10 phone10;
  string8 dt_first_seen;
 string8 dt_last_seen;
 unsigned days_in_service := 0;
  boolean is_discon_15_days:=false;
	boolean is_discon_30_days:=false;
	boolean is_discon_60_days:=false;
	boolean is_discon_90_days:=false;
	boolean is_discon_180_days:=false;
	boolean is_discon_360_days:=false;
end;

all_phones := sort(project(gong_m_with_phone (did > 0), 
						   transform(temp_ly2,
						             self.days_in_service := ut.DaysApart(if(left.dt_last_seen <> '', left.dt_last_seen, ut.GetDate), left.dt_first_seen),
									 self := left)) , 
				did, phone10);


recordof(temp_ly2 ) t_rollup(all_phones le, all_phones ri) := transform
 self.dt_first_seen := (string) ut.Min2((unsigned)le.dt_first_seen, (unsigned)ri.dt_first_seen);
 self.dt_last_seen :=  (string) ut.Max2((unsigned)le.dt_last_seen, (unsigned)ri.dt_last_seen);
 self.days_in_service := ut.DaysApart(if(self.dt_last_seen <> '', self.dt_last_seen, ut.GetDate), self.dt_first_seen);
 self.is_discon_15_days:= if(self.days_in_service <= 15, true, false);
 self.is_discon_30_days:=if(self.days_in_service <= 30, true, false);
 self.is_discon_60_days:=if(self.days_in_service <= 60, true, false);
 self.is_discon_90_days:=if(self.days_in_service <= 90, true, false);
 self.is_discon_180_days:=if(self.days_in_service <= 180, true, false);
 self.is_discon_360_days:=if(self.days_in_service <= 360, true, false);
 self := ri;
end;


all_phones_rollup := rollup(all_phones,
					left.did = right.did and
					left.phone10 = right.phone10,
					t_rollup(left, right));


temp_ly3 := record
 all_phones_rollup.did;
 avg_days_connected_indiv := ave(group, all_phones_rollup.days_in_service);
 min_days_connected_indiv := min(group, all_phones_rollup.days_in_service);
 max_days_connected_indiv := max(group, all_phones_rollup.days_in_service);
 is_discon_15_days:= max(group, all_phones_rollup.is_discon_15_days);
 is_discon_30_days:=max(group, all_phones_rollup.is_discon_30_days);
 is_discon_60_days:=max(group, all_phones_rollup.is_discon_60_days);
 is_discon_90_days:=max(group, all_phones_rollup.is_discon_90_days);
 is_discon_180_days:=max(group, all_phones_rollup.is_discon_180_days);
 is_discon_360_days:=max(group, all_phones_rollup.is_discon_360_days);
 
end;

connected_indiv_tbl := table(all_phones_rollup, temp_ly3, did);


gong_h_ph_first_indiv := dedup(sort(distribute(gong_m_with_phone(did > 0), hash(did)), did, dt_first_seen, local), did, local);
gong_h_ph_first_indiv_with_phone := dedup(sort(distribute(gong_m_with_phone, hash(phone10)), phone10, did, dt_first_seen, local), phone10, did, local);

gong_h_ph_first_phone := dedup(sort(distribute(gong_m_with_phone, hash(phone10)) , phone10, dt_first_seen, local), phone10, local);



current_in_hist :=join(distribute(gong_m_with_phone, hash(phone10)) (current_record_flag <> 'Y' and did > 0),
							 dedup(sort(distribute(gong_m_with_phone, hash(phone10)) (current_record_flag = 'Y' and did > 0), phone10, did, local), phone10, did, local),
							 left.phone10 = right.phone10 and
							 left.did = right.did,
							 transform(recordof(gong_m_with_phone), self := left), local);
						 	 

current_in_hist_all := current_in_hist + dedup(sort(distribute(gong_m_with_phone, hash(phone10))  (current_record_flag = 'Y' and did > 0), phone10, did, local), phone10, did, local);

temp_ly4 := record
 unsigned did;
 string10 phone10;
  string8 dt_first_seen;
 string8 dt_last_seen;
  unsigned days_in_service := 0;
	unsigned days_interupt := 0;
	boolean has_cur_discon_15_days:=false;
	boolean has_cur_discon_30_days:=false;
	boolean has_cur_discon_60_days:=false;
	boolean has_cur_discon_90_days:=false;
	boolean has_cur_discon_180_days:=false;
	boolean has_cur_discon_360_days:=false;
end;

curr_discon_phones := group(sort(project(current_in_hist_all (did > 0), 
						   transform(temp_ly4,
						             self.days_in_service := ut.DaysApart(if(left.dt_last_seen <> '', left.dt_last_seen, ut.GetDate), left.dt_first_seen),
									 self.has_cur_discon_15_days := if(self.days_in_service <= 15, true, false),
									 self.has_cur_discon_30_days := if(self.days_in_service <= 30, true, false),
									 self.has_cur_discon_60_days := if(self.days_in_service <= 60, true, false),
									 self.has_cur_discon_90_days := if(self.days_in_service <= 90, true, false),
									 self.has_cur_discon_180_days := if(self.days_in_service <= 180, true, false),
									 self.has_cur_discon_360_days := if(self.days_in_service <= 360, true, false),
									 self := left)) , 
				did, phone10,dt_first_seen ),did, phone10);
				

				
temp_ly4 t_days_interupt(curr_discon_phones le, curr_discon_phones ri) := transform
self.days_interupt := if(le.dt_last_seen <> '' , ut.DaysApart(ri.dt_first_seen, le.dt_last_seen), 0);
self := ri;
end;

days_interupt := ungroup(iterate(curr_discon_phones, t_days_interupt(LEFT,RIGHT)));

temp_ly5 := record
 days_interupt.did;
 days_interupt.phone10;
  num_interrupts_cur := count(group);
  avg_days_interrupt := ave(group, days_interupt.days_interupt);
  min_days_interrupt := min(group, days_interupt.days_interupt);
  max_days_interrupt := max(group, days_interupt.days_interupt);
  has_cur_discon_15_days:=max(group, days_interupt.has_cur_discon_15_days);
  has_cur_discon_30_days:=max(group, days_interupt.has_cur_discon_30_days);
  has_cur_discon_60_days:=max(group, days_interupt.has_cur_discon_60_days);
  has_cur_discon_90_days:=max(group, days_interupt.has_cur_discon_90_days);
  has_cur_discon_180_days:=max(group, days_interupt.has_cur_discon_180_days);
  has_cur_discon_360_days:=max(group, days_interupt.has_cur_discon_360_days);
end;

cur_discon_tbl := table(days_interupt (days_interupt > 0), temp_ly5, did, phone10);
			 
//Append Phone level

phone_level_att := project(num_phone_owners_hist_tb,transform(LayoutScoringAttributes.Phone_level,
																										self.num_phone_owners_hist := left.cnt,
																										self := left)) + 
									 project(num_phone_owners_cur_tb, transform(LayoutScoringAttributes.Phone_level,
																										self.num_phone_owners_cur := left.cnt,
																										self := left)) +
									 project(gong_h_ph_first_phone, transform(LayoutScoringAttributes.Phone_level,
																									self.days_phone_first_seen := ut.DaysApart(ut.GetDate, left.dt_first_seen),
																									self := left));
									 
LayoutScoringAttributes.Phone_level t_rollup_by_phone(phone_level_att le, phone_level_att ri) := transform
self.num_phone_owners_hist := ut.max2(le.num_phone_owners_hist,ri.num_phone_owners_hist);
self.num_phone_owners_cur := ut.max2(le.num_phone_owners_cur,ri.num_phone_owners_cur);
self.days_phone_first_seen := ut.max2(le.days_phone_first_seen,ri.days_phone_first_seen);
self := ri;
end;

phone_level_att_r := rollup(sort(phone_level_att, phone10),
					left.phone10 = right.phone10,
					t_rollup_by_phone(left, right));

							 
append_phone_level := join(distribute(gong_m (phone10 <> ''), hash(phone10)),
											distribute(phone_level_att_r, hash(phone10)),
											 left.phone10 = right.phone10,
											 transform(ScoringRecord, 
																	self.days_in_service := ut.DaysApart(if(left.dt_last_seen <> '', left.dt_last_seen, ut.GetDate), left.dt_first_seen);
																	self.phone10 := left.phone10,
																	self := right, 
																	self := left),
											 left outer,
											 local);


//Append Did Level
did_level_att := project(num_phones_indiv_tb, transform(LayoutScoringAttributes.Did_level,
																							self.num_phones_indiv := left.cnt,
																							self := left)) + 
									 project(num_phones_connected_indiv_tb, transform(LayoutScoringAttributes.Did_level,
																							self.num_phones_connected_indiv := left.cnt,
																							self := left)) +
									 project(num_phones_discon_indiv_tb, transform(LayoutScoringAttributes.Did_level,
																							self.num_phones_discon_indiv := left.cnt,
																							self := left)) +
									 project(connected_indiv_tbl, LayoutScoringAttributes.Did_level)+
									 project(gong_h_ph_first_indiv, transform(LayoutScoringAttributes.Did_level,
																							self.days_indiv_first_seen := ut.DaysApart(ut.GetDate, left.dt_first_seen),
																							self := left));


LayoutScoringAttributes.Did_level t_rollup_by_Did(did_level_att le, did_level_att ri) := transform
self.num_phones_indiv := ut.max2(le.num_phones_indiv , ri.num_phones_indiv);
self.num_phones_connected_indiv := ut.max2(le.num_phones_connected_indiv , ri.num_phones_connected_indiv);
self.num_phones_discon_indiv := ut.max2(le.num_phones_discon_indiv, ri. num_phones_discon_indiv );
self.avg_days_connected_indiv  := ut.max2(le.avg_days_connected_indiv, ri.avg_days_connected_indiv);
self.min_days_connected_indiv  := ut.max2(le.min_days_connected_indiv, ri.min_days_connected_indiv);
self.max_days_connected_indiv := ut.max2(le.max_days_connected_indiv, ri.max_days_connected_indiv );
self.is_discon_15_days := (boolean)ut.max2((unsigned)le.is_discon_15_days, (unsigned)ri.is_discon_15_days); 
self.is_discon_30_days := (boolean)ut.max2((unsigned)le.is_discon_30_days, (unsigned)ri.is_discon_30_days);
self.is_discon_60_days := (boolean)ut.max2((unsigned)le.is_discon_60_days, (unsigned)ri.is_discon_60_days);
self.is_discon_90_days := (boolean)ut.max2((unsigned)le.is_discon_90_days, (unsigned)ri.is_discon_90_days);
self.is_discon_180_days := (boolean)ut.max2((unsigned)le.is_discon_180_days, (unsigned)ri.is_discon_180_days);
self.is_discon_360_days := (boolean)ut.max2((unsigned)le.is_discon_360_days, (unsigned)ri.is_discon_360_days);
self.days_indiv_first_seen := ut.max2(le.days_indiv_first_seen, ri.days_indiv_first_seen);
self := ri;
end;


did_level_att_r := rollup(sort(did_level_att, did),
					left.did = right.did,
					t_rollup_by_Did(left, right));



									 
append_did_level := join(distribute(append_phone_level (did > 0), hash(did)),
											distribute(did_level_att_r(did > 0), hash(did)),
											 left.did = right.did,
											 transform(ScoringRecord, self.did := left.did, 
											                          self := right, 
																								self := left),
											 left outer,
											 local);
											 

//Append watchdog
ScoringRecord append_wd(append_did_level le, watchdog.File_Best ri) := transform
self.address_match_best := if(ri.did > 0 , true, le.address_match_best);
self.months_addr_last_seen := (unsigned) if(ri.addr_dt_last_seen > 0, (ut.DaysApart(ut.GetDate, (string)(ri.addr_dt_last_seen + '01') [..8])/30), 0);
self := le;
end;

append_best := join(append_did_level (did > 0), 
							  dedup(sort(distribute(watchdog.File_Best, hash(did)), did, -addr_dt_last_seen, local) , did, local),
							  left.did = right.did ,
							  append_wd(left, right),
							  left outer,
								local);	


all_recs_did_level := append_best + append_phone_level (did = 0);

//Append at phone, did level
phone_did_level_att := project(gong_h_ph_first_indiv_with_phone,transform(LayoutScoringAttributes.Phone_Did_level,
																																self.days_indiv_first_seen_with_phone := ut.DaysApart(ut.GetDate, left.dt_first_seen),
																																self := left)) + 
									 project(current_in_hist, transform(LayoutScoringAttributes.Phone_Did_level,
																											self.is_current_in_hist := if(left.phone10 <> '', true, false),
																											self := left))+
									 project(cur_discon_tbl, LayoutScoringAttributes.Phone_Did_level) ;



LayoutScoringAttributes.Phone_Did_level t_rollup_by_Phone_Did(phone_did_level_att le, phone_did_level_att ri) := transform
self.num_interrupts_cur := ut.max2(le.num_interrupts_cur, ri.num_interrupts_cur);
self.avg_days_interrupt := ut.max2(le.avg_days_interrupt, ri.avg_days_interrupt);
self.min_days_interrupt  := ut.max2(le.min_days_interrupt, ri.min_days_interrupt);
self.max_days_interrupt  := ut.max2(le.max_days_interrupt, ri.max_days_interrupt );
self.has_cur_discon_15_days := (boolean)ut.max2((unsigned)le.has_cur_discon_15_days, (unsigned)ri.has_cur_discon_15_days); 
self.has_cur_discon_30_days := (boolean)ut.max2((unsigned)le.has_cur_discon_30_days, (unsigned)ri.has_cur_discon_30_days);
self.has_cur_discon_60_days := (boolean)ut.max2((unsigned)le.has_cur_discon_60_days, (unsigned)ri.has_cur_discon_60_days);
self.has_cur_discon_90_days := (boolean)ut.max2((unsigned)le.has_cur_discon_90_days, (unsigned)ri.has_cur_discon_90_days);
self.has_cur_discon_180_days := (boolean)ut.max2((unsigned)le.has_cur_discon_180_days, (unsigned)ri.has_cur_discon_180_days);
self.has_cur_discon_360_days := (boolean)ut.max2((unsigned)le.has_cur_discon_360_days, (unsigned)ri.has_cur_discon_360_days);
self.days_indiv_first_seen_with_phone := ut.max2(le.days_indiv_first_seen_with_phone, ri.days_indiv_first_seen_with_phone);
self.is_current_in_hist := (boolean)ut.max2((unsigned)le.is_current_in_hist, (unsigned)ri.is_current_in_hist);
self := ri;
end;

phone_did_level_att_r := rollup(sort(phone_did_level_att, phone10, did),
					left.phone10 = right.phone10 and 
					left.did = right.did,
					t_rollup_by_Phone_Did(left, right));

append_phone_did_level := join(distribute(all_recs_did_level, hash(phone10)),
											distribute(phone_did_level_att_r, hash(phone10)),
											 left.phone10 = right.phone10 and
											 left.did = right.did,
											 transform(ScoringRecord, self.did := left.did, 
																								self.phone10 := left.phone10, 
																								self := right, 
																								self := left),
											 left outer,
											 local);
											 

//Append address level

addr_level_att := project(num_phones_connected_addr_tb,transform(LayoutScoringAttributes.Address_level,
																												self.num_phones_connected_addr := left.cnt,
																												self := left)) + 
									 project(num_phones_discon_addr_tb, transform(LayoutScoringAttributes.Address_level,
																											self.num_phones_discon_addr := left.cnt,
																											self := left));

LayoutScoringAttributes.Address_level t_rollup_by_Address(addr_level_att le, addr_level_att ri) := transform
self.num_phones_connected_addr:= ut.max2(le.num_phones_connected_addr, ri.num_phones_connected_addr);
self.num_phones_discon_addr:= ut.max2(le.num_phones_discon_addr, ri.num_phones_discon_addr);
self := ri;
end;

address_level_att_r := rollup(sort(addr_level_att, adr),
					left.adr = right.adr,
					t_rollup_by_Address(left, right));

append_address_level := join(distribute(append_phone_did_level(trim(prim_range + prim_name + suffix + sec_range, all) <> '' and z5 <> ''), hash(prim_range + prim_name + suffix + sec_range + z5)),
											distribute(address_level_att_r, hash(adr)),
											 left.prim_range + left.prim_name + left.suffix + left.sec_range + left.z5 = right.adr,
											 transform(ScoringRecord, self := right, self := left),
											 left outer,
											 local);



all_recs_address_level := 	append_address_level + append_phone_did_level(trim(prim_range + prim_name + suffix + sec_range, all) = '' or z5 = '');					  

//append hhid level
hhid_level_att := project(num_phones_connected_hhid_tb, transform(LayoutScoringAttributes.hhid_level,
																												self.num_phones_connected_hhid := left.cnt,
																												self := left)) + 
									 project(num_phones_discon_hhid_tb, transform(LayoutScoringAttributes.hhid_level,
																											self.num_phones_discon_hhid := left.cnt,
																											self := left));

LayoutScoringAttributes.hhid_level t_rollup_by_hhid(hhid_level_att le,hhid_level_att ri) := transform
self.num_phones_connected_hhid:= ut.max2(le.num_phones_connected_hhid, ri.num_phones_connected_hhid);
self.num_phones_discon_hhid:= ut.max2(le.num_phones_discon_hhid, ri.num_phones_discon_hhid);
self := ri;
end;


hhid_level_att_r := rollup(sort(hhid_level_att, hhid),
					left.hhid = right.hhid,
					t_rollup_by_hhid(left, right));

append_hhid_level := join(distribute(all_recs_address_level (hhid > 0), hash(hhid)),
											distribute(hhid_level_att_r, hash(hhid)),
											 left.hhid = right.hhid,
											 transform(ScoringRecord, self.hhid := left.hhid,
																								self := right, 
																								self := left),
											 left outer,
											 local);


all_recs_hhid_level := append_hhid_level + all_recs_address_level (hhid = 0): persist('~persist::gong::scoring_attributes');
	

return all_recs_hhid_level ;
end;
