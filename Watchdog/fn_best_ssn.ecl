import header,ut,mdr,std;

/*
src desc		src	src has ssn cnt	pct of total
LA EXPERIAN DL	6X	3,264,163		0.1%
BANKRUPTCY		BA	20,453,171		0.9%
WV EXPERIAN DL	BX	1,171,675		0.1%
CERTEGY			CY	136,424,686		5.8%
DEATH MASTER	DE	86,822,916		3.7%
DEATH STATE		DS	5,768,485		0.2%
EQUIFAX			EQ	827,412,881		35.3%
FL DL			FD	19,706,505		0.8%
FL VEH			FV	28,229,656		1.2%
FL WATERCRAFT	FW	4,247,628		0.2%
LIENS V2		L2	28,851,323		1.2%
MS WORKER COMP	MW	482,260			0.0%
MA DL			PD	5,339,809		0.2%
TUCS_PTRAK		TS	1,135,037,730	48.5%
UTILITIES		UT	36,875,159		1.6%
UTIL WORK PHONE	UW	782,799			0.0%
WV DL			VD	1,789,439		0.1%

					2,342,660,285	
*/

export fn_best_ssn(dataset(recordof(header.layout_header)) in_hdr) := module

//purposefully excluded UW (it would be a double-counting if i left it in)
//resolve double-counting of UT and EQ sources later in the process (exclude UT only if EQ already provides it)
//append SSN flags

in_hdr_ssn0 := in_hdr(ssn <> '');
header.Mac_flag_legacy_ssn(in_hdr_ssn0,in_hdr_ssn);

rec_ssn := record
in_hdr_ssn.did;
in_hdr_ssn.ssn;
in_hdr_ssn.legacy;
end;
		
hdr_ssn := project(in_hdr_ssn, rec_ssn);

hdr_ssn_dedup := dedup(distribute(hdr_ssn, hash(did)),did,ssn,all,local);

append_ssn_flag:=header.append_ssn_flags(hdr_ssn_dedup(legacy)).legacy_ssn
                +header.append_ssn_flags(hdr_ssn_dedup(~legacy)).randomized_ssn;

//join back to in file

rec_append_ssn_flag := record
  header.layout_header;
  boolean   legacy  :=false;
  boolean   ssn_is_invalid  :=false;
 end;
 

rec_append_ssn_flag tSSN_flag(in_hdr_ssn le, append_ssn_flag ri) := transform

self.ssn_is_invalid := ri.ssn_is_invalid;
self := le;

end;

shared hdr_ssn_flag := join(distribute(in_hdr_ssn,hash(did))
										, distribute(append_ssn_flag,hash(did))
											,   left.did=right.did
											and trim((string9)left.ssn,left, right) = trim(right.ssn,left, right)
											, tSSN_flag(left,right)
											, left outer
											, local);

//keep valid SSN 
hdr_valid_ssn := project(hdr_ssn_flag(ssn_is_invalid = false), header.layout_header);

export hdr1 := distribute(hdr_valid_ssn(ut.full_ssn(ssn)=true and ssn not in ut.set_badssn and src not in mdr.sourceTools.set_Util_WorkPH ),hash(did));

shared unique_eq_confirmeds := watchdog.fn_DID_has_one_confirmed_SSN(hdr1);

//keep the set of ADLs having zero or more than 1 confirmed EQ SSN
header_plus:={header.layout_header,boolean legacy:=false};
header_plus tjoin(hdr1 le, unique_eq_confirmeds ri) := transform
 self := le;
end;
hdr2_ := join(hdr1,unique_eq_confirmeds,left.did=right.did,tjoin(left,right),left only,local);

header_plus tjoin2(hdr2_ le, hdr_ssn_flag ri) := transform
 self.legacy := ri.legacy;
 self := le;
end;
shared hdr2 := join(hdr2_ , hdr_ssn_flag(ssn_is_invalid = false) , left.rid=right.rid,tjoin2(left,right),left outer,local);

//get the MIN DOB for all records, not just those with an SSN
shared r_min_dob := record
 in_hdr.did;
 integer min_dob := min(group,if(in_hdr.dob>0,in_hdr.dob div 10000,9999));
end;

shared ta_dob := table(in_hdr,r_min_dob,did,local);

shared r1 := record
 hdr2.did;
 string9 ssn;
 boolean ssn_belongs_to_relative;
 boolean ssn_only_in_dppa;
 boolean in_eq;
 boolean in_en;
 boolean in_ts;
 boolean in_ssa_deaths;
 boolean in_bk;
 boolean in_liens;
 boolean in_utility;
 boolean in_certegy;
 boolean in_other;
 boolean in_bureau_and_ssa:=false;
 boolean in_one_confident_source;
 integer in_eq_cnt;
 integer in_en_cnt;
 integer in_ts_cnt;
 integer in_ssa_deaths_cnt;
 integer in_bk_cnt;
 integer in_liens_cnt;
 integer in_utility_cnt;
 integer in_certegy_cnt;
 integer in_other_cnt;
 integer total_sources;
 integer total_score;
 integer total_times_seen;
 integer dt_last_seen;
 boolean dt_last_seen_is_recent;
 ta_dob.min_dob;
 string1 old_ssn;
 boolean legacy;
end;

r1 t1(hdr2 le, r_min_dob ri) := transform

 boolean v_in_eq         := le.src='EQ';
 boolean v_in_en         := le.src='EN';
 boolean v_in_ts         := le.src='TS';
 boolean v_in_ssa_deaths := le.src='DE';
 boolean v_in_bk         := le.src='BA';
 boolean v_in_liens      := le.src='L2';
 boolean v_in_utility    := le.src in mdr.sourceTools.set_Util_noWorkPH;
 boolean v_in_certegy    := le.src='CY';

 integer v_score_eq         := 5;
 integer v_score_en         := 5;
 integer v_score_ts         := 3;
 integer v_score_ssa_deaths := 5;
 integer v_score_bk         := 5;
 integer v_score_liens      := 5;
 integer v_score_utility    := 4;
 integer v_score_certegy    := 4;
 integer v_score_other      := 3;
 
 //idea is to use dppa content for scoring
 //we won't return an SSN that's only DPPA sourced
 self.ssn_only_in_dppa        := mdr.sourcetools.sourceisdppa(le.src)=true or le.src in mdr.sourcetools.set_Utility_sources;
 self.ssn_belongs_to_relative := le.valid_ssn='R';
 
 self.in_eq         := v_in_eq;
 self.in_en         := v_in_en;
 self.in_ts         := v_in_ts;
 self.in_ssa_deaths := v_in_ssa_deaths;
 self.in_bk         := v_in_bk;
 self.in_liens      := v_in_liens;
 self.in_utility    := v_in_utility;
 self.in_certegy    := v_in_certegy;
 
 self.in_other := v_in_eq        =false and
                  v_in_en        =false and
                  v_in_ts        =false and
				  v_in_ssa_deaths=false and
				  v_in_bk        =false and
				  v_in_liens     =false and
				  v_in_utility   =false and
				  v_in_certegy   =false
				  ;			  
 self.in_one_confident_source := self.in_eq=true or self.in_en=true or self.in_ssa_deaths=true or self.in_bk=true or self.in_liens=true;
 
 self.in_eq_cnt         := if(v_in_eq        =true,1,0);
 self.in_en_cnt         := if(v_in_en        =true,1,0);
 self.in_ts_cnt         := if(v_in_ts        =true,1,0);
 self.in_ssa_deaths_cnt := if(v_in_ssa_deaths=true,1,0);
 self.in_bk_cnt         := if(v_in_bk        =true,1,0);
 self.in_liens_cnt      := if(v_in_liens     =true,1,0);
 //don't count utility if the same SSN also came from equifax
 //self.in_utility_cnt    := if(v_in_utility   =true,1,0);
 self.in_utility_cnt    := if(v_in_utility   =true and v_in_eq=false,1,0);
 self.in_certegy_cnt    := if(v_in_certegy   =true,1,0);
 self.in_other_cnt      := if(self.in_other  =true,1,0);
 
 self.total_score      := sum(
                          if(v_in_eq        =true,v_score_eq,0)
						 +if(v_in_en        =true,v_score_en,0)
                         +if(v_in_ts        =true,v_score_ts,0)
						 +if(v_in_ssa_deaths=true,v_score_ssa_deaths,0)
						 +if(v_in_bk        =true,v_score_bk,0)
						 +if(v_in_liens     =true,v_score_liens,0)
						 +if(v_in_utility   =true,v_score_utility,0)
						 +if(v_in_certegy   =true,v_score_certegy,0)
						 +if(self.in_other  =true,v_score_other,0)
						 );

 self.old_ssn                :='';
 self.total_sources          := 0;
 self.total_times_seen       := 1;
 self.dt_last_seen           := le.dt_last_seen;
 self.dt_last_seen_is_recent := if(self.dt_last_seen>0 and (header.ConvertYYYYMMToNumberOfMonths((unsigned3)((STRING8)Std.Date.Today())[1..6]) - header.ConvertYYYYMMToNumberOfMonths(self.dt_last_seen) < 24),true,false);
 
 self := le;
 self.min_dob                :=if(ri.min_dob=9999,0,ri.min_dob);
 self := ri;
 
end;

p1 := join(hdr2,ta_dob,left.did=right.did,t1(left,right),left outer,local);

r1 t_issued_before_dob(r1 le, header.Layout_SSN_Map ri) := transform
  self.old_ssn := map(le.ssn[1..5]=ri.ssn5 and le.legacy and le.min_dob <= (integer)(string)ri.end_date[1..4] => 'N'
											,le.ssn[1..5]=ri.ssn5 and le.legacy and le.min_dob  > (integer)(string)ri.end_date[1..4] => 'Y'
											,'N');
  self                       := le;
end;

j0 := join(p1,header.file_ssn_map(ssn5<>'' and end_date<(STRING8)Std.Date.Today()),left.ssn[1..5]=right.ssn5 and left.ssn[6..9] between right.start_serial and right.end_serial,t_issued_before_dob(left,right),left outer,lookup);

p1_dist := distribute(j0,hash(did,ssn));
p1_sort := sort(p1_dist,did,ssn,local);

r1 t2(r1 le, r1 ri) := transform

 self.ssn_only_in_dppa        := if(le.ssn_only_in_dppa=false,      le.ssn_only_in_dppa,       ri.ssn_only_in_dppa);
 self.ssn_belongs_to_relative := if(le.ssn_belongs_to_relative=true,le.ssn_belongs_to_relative,ri.ssn_belongs_to_relative);
 
 self.in_eq         := if(le.in_eq        =true,le.in_eq,        ri.in_eq);
 self.in_en         := if(le.in_en        =true,le.in_en,        ri.in_en);
 self.in_ts         := if(le.in_ts        =true,le.in_ts,        ri.in_ts);
 self.in_ssa_deaths := if(le.in_ssa_deaths=true,le.in_ssa_deaths,ri.in_ssa_deaths);
 self.in_bk         := if(le.in_bk        =true,le.in_bk,        ri.in_bk);
 self.in_liens      := if(le.in_liens     =true,le.in_liens,     ri.in_liens);
 self.in_utility    := if(le.in_utility   =true,le.in_utility,   ri.in_utility);
 self.in_certegy    := if(le.in_certegy   =true,le.in_certegy,   ri.in_certegy);
 self.in_other      := if(le.in_other     =true,le.in_other,     ri.in_other);
 
 self.in_one_confident_source := if(le.in_one_confident_source=true,le.in_one_confident_source,ri.in_one_confident_source);
 
 self.in_eq_cnt         := le.in_eq_cnt        +ri.in_eq_cnt;
 self.in_en_cnt         := le.in_en_cnt        +ri.in_en_cnt;
 self.in_ts_cnt         := le.in_ts_cnt        +ri.in_ts_cnt;
 self.in_ssa_deaths_cnt := le.in_ssa_deaths_cnt+ri.in_ssa_deaths_cnt;
 self.in_bk_cnt         := le.in_bk_cnt        +ri.in_bk_cnt;
 self.in_liens_cnt      := le.in_liens_cnt     +ri.in_liens_cnt;
 self.in_utility_cnt    := le.in_utility_cnt   +ri.in_utility_cnt;
 self.in_certegy_cnt    := le.in_certegy_cnt   +ri.in_certegy_cnt;
 self.in_other_cnt      := le.in_other_cnt     +ri.in_other_cnt;

 self.total_score          := le.total_score     +ri.total_score;
 self.total_times_seen     := le.total_times_seen+1;
 self.dt_last_seen := max(le.dt_last_seen,ri.dt_last_seen);
 self.dt_last_seen_is_recent := if(le.dt_last_seen_is_recent=true,le.dt_last_seen_is_recent,ri.dt_last_seen_is_recent);
 
 self := le;
end;

shared p2 := rollup(p1_sort,left.did=right.did and left.ssn=right.ssn,t2(left,right),local);

shared r2 := record
 unsigned6 did;
 integer   nbr_of_ssns;
end;

r2 t3(r1 le) := transform
 self.nbr_of_ssns := 1;
 self             := le;
end;

p3      := project(p2,t3(left));
p3_dist := distribute(p3,hash(did));
p3_sort := sort(p3_dist,did,local);

r2 t4(r2 le, r2 ri) := transform
 self.nbr_of_ssns := le.nbr_of_ssns+1;
 self             := le;
end;

shared p4 := rollup(p3_sort,left.did=right.did,t4(left,right),local);

shared r3 := record
 p2;
 p4.nbr_of_ssns;
end;

r3 t5(r1 le, r2 ri) := transform
 self.in_bureau_and_ssa    := (le.in_eq=true or le.in_en=true) and le.in_ssa_deaths=true;
 self.total_sources := sum(
                               if(le.in_eq        =true,1,0)
							  +if(le.in_en        =true,1,0)
                              +if(le.in_ts        =true,1,0)
						      +if(le.in_ssa_deaths=true,1,0)
						      +if(le.in_bk        =true,1,0)
						      +if(le.in_liens     =true,1,0)
						      +if(le.in_utility   =true,1,0)
						      +if(le.in_certegy   =true,1,0)
						      +if(le.in_other     =true,1,0)
						         );
 self := le;
 self := ri;
end;

shared j1 := join(distribute(p2,hash(did)),p4,left.did=right.did,t5(left,right),local);

//if an ADL has only 1 SSN, choose it
shared one_possibility := j1(nbr_of_ssns=1 and ssn_only_in_dppa=false);

//if an ADL has more than 2 SSNs, pick the 2 best based on...
f3      := j1(nbr_of_ssns>2);
f3_sort := sort(f3,did,-total_sources,-total_score,-dt_last_seen,-in_bureau_and_ssa,local);
f3_dupd := dedup(f3_sort,did,keep(2),local);

r4 := record
 j1;
 string9 other_ssn;
 boolean other_ssn_belongs_to_relative;
 boolean other_in_one_confident_source;
 integer other_total_sources;
 integer other_total_score;
 integer other_total_times_seen;
 integer other_dt_last_seen;
 boolean other_dt_last_seen_is_recent;
 string1 other_old_ssn;
 boolean other_ssn_in_bureau_and_ssa;
 integer months_apart;
end;

r4 t6(r3 le, r3 ri) := transform
 self.other_ssn                     := ri.ssn;
 self.other_ssn_belongs_to_relative := ri.ssn_belongs_to_relative;
 self.other_in_one_confident_source := ri.in_one_confident_source;
 self.other_total_sources           := ri.total_sources;
 self.other_total_score             := ri.total_score;
 self.other_total_times_seen        := ri.total_times_seen;
 self.other_dt_last_seen            := ri.dt_last_seen;
 self.other_dt_last_seen_is_recent  := ri.dt_last_seen_is_recent;
 self.other_old_ssn   := ri.old_ssn;
 self.other_ssn_in_bureau_and_ssa   := ri.in_bureau_and_ssa;
 self.months_apart                  := if(le.dt_last_seen>0 and self.other_dt_last_seen>0,header.ConvertYYYYMMToNumberOfMonths(le.dt_last_seen)-header.ConvertYYYYMMToNumberOfMonths(self.other_dt_last_seen),0);
 self                               := le;
end;

//this is the set of ADLs with 2 SSNs where we pick the best one
f2 := j1(nbr_of_ssns=2)+f3_dupd;

//doing "<>" instead of ">" so both SSNs appear in the left dataset
//understood there is duplication
j2 := dedup(join(f2,f2,left.did=right.did and left.ssn<>right.ssn,t6(left,right),local),record,all,local);

ut.mac_ssn_diffs(j2,ssn,other_ssn,check_for_ff0);

export check_for_ff := check_for_ff0;

//f_potential_dodgy := dedup(check_for_ff(total_sources>2 and other_total_sources>2 and ssn_switch='N'),did,all);
//output(count(f_potential_dodgy),named('potential_dodgies_cnt'));
//output(f_potential_dodgy,named('potential_dodgies'));

//more sources
try1 := check_for_ff(
 total_sources > other_total_sources
 and
 old_ssn='N'
 //total sources implies more than 1 contributing source (i.e. can't be dppa only)
);
 
try1_leftover := join(check_for_ff,try1,left.did=right.did,transform({recordof(check_for_ff)},self:=left),left only,local);

//in both a bureau and the ssa
try2 := try1_leftover(
 in_bureau_and_ssa=true
 and
 other_ssn_in_bureau_and_ssa=false
 //bureau and ssa implies more than 1 contributing source (i.e. can't be dppa only)
);
 
try2_leftover := join(try1_leftover,try2,left.did=right.did,transform({recordof(check_for_ff)},self:=left),left only,local);

//much higher score
try3 := try2_leftover(
  (
  ((total_score >= other_total_score*2+1)
  and
  in_one_confident_source=true
  )
  or
  total_score >= other_total_score*5
  )
  and
  ssn_only_in_dppa=false
 );

try3_leftover := join(try2_leftover,try3,left.did=right.did,transform({recordof(check_for_ff)},self:=left),left only,local);

//did=533115
//looks like son initially had mom's ssn but is now showing up with his own
try4 := try3_leftover(
 total_score*2 <= other_total_score
 and
 dt_last_seen_is_recent=true
 and
 other_dt_last_seen_is_recent=false
 and
 other_dt_last_seen > 0
 and
 months_apart > 12
 and
 old_ssn='N'
 and
 in_one_confident_source=true
 and
 ssn_only_in_dppa=false
);

try4_leftover := join(try3_leftover,try4,left.did=right.did,transform({recordof(check_for_ff)},self:=left),left only,local);

//fat fingered, multiple sources, seen more recent
try5 := try4_leftover(
 ssn_switch='Y'
 and
 months_apart >= 12
 and
 total_sources > 1
 //total sources implies more than 1 contributing source (i.e. can't be dppa only)
);

try5_leftover := join(try4_leftover,try5,left.did=right.did,transform({recordof(check_for_ff)},self:=left),left only,local);

//higher score, seen more (recent)
try6 := try5_leftover(
 total_score > other_total_score
 and
 (total_times_seen > other_total_times_seen or months_apart >= 12)
 and
 old_ssn='N'
 and
 in_one_confident_source=true
 and
 ssn_only_in_dppa=false
);

try6_leftover := join(try5_leftover,try6,left.did=right.did,transform({recordof(check_for_ff)},self:=left),left only,local);

//multiple sources and the other belongs to a relative
try7 := try6_leftover(
 total_sources > 1
 and
 other_ssn_belongs_to_relative=true
 //total sources implies more than 1 contributing source (i.e. can't be dppa only)
);

try7_leftover := join(try6_leftover,try7,left.did=right.did,transform({recordof(check_for_ff)},self:=left),left only,local);

//seen more (recent), higher score, fat-fingered
try8 := try7_leftover(
 total_times_seen=other_total_times_seen
 and
 total_score > other_total_score
 and
 ssn_switch='Y'
 and
 months_apart>=12
 and
 ssn_only_in_dppa=false
);

try8_leftover := join(try7_leftover,try8,left.did=right.did,transform({recordof(check_for_ff)},self:=left),left only,local);

//fat-fingered, other ssn issued before dob
try9 := try8_leftover(
 ssn_switch='Y'
 and
 old_ssn='N'
 and
 other_old_ssn='Y'
 and
 ssn_only_in_dppa=false
);			 

try9_leftover := join(try8_leftover,try9,left.did=right.did,transform({recordof(check_for_ff)},self:=left),left only,local);

//easily cannot decide
cant_decide := try9_leftover(
 total_sources=other_total_sources 
 and
 ssn_belongs_to_relative=false
 and
 (total_score = other_total_score or total_score+1 = other_total_score or total_score = other_total_score+1)
 and
 (total_times_seen=other_total_times_seen or total_times_seen+1=other_total_times_seen or total_times_seen=other_total_times_seen+1)
);
				 
j_cant_decide := join(try9_leftover,cant_decide,left.did=right.did,transform({recordof(check_for_ff)},self:=left),left only,local);

r_out := record
 unsigned6 did;
 string9   ssn;
 string1   old_ssn;
 string1   why;
 //boolean   ssn_only_in_dppa;
end;

prC  := project(unique_eq_confirmeds,transform({r_out},self.why:='C',self.old_ssn:='N',self:=left));
prU  := project(one_possibility,     transform({r_out},self.why:='U',self:=left));
pr1  := project(try1,                transform({r_out},self.why:='1',self:=left));
pr2  := project(try2,                transform({r_out},self.why:='2',self:=left));
pr3  := project(try3,                transform({r_out},self.why:='3',self:=left));
pr4  := project(try4,                transform({r_out},self.why:='4',self:=left));
pr5  := project(try5,                transform({r_out},self.why:='5',self:=left));
pr6  := project(try6,                transform({r_out},self.why:='6',self:=left));
pr7  := project(try7,                transform({r_out},self.why:='7',self:=left));
pr8  := project(try8,                transform({r_out},self.why:='8',self:=left));
pr9  := project(try9,                transform({r_out},self.why:='9',self:=left));
//want to ultimately remove these
pr10 := project(cant_decide,         transform({r_out},self.why:='X',self:=left));

concat := 
  prC
+ prU
+ pr1
+ pr2
+ pr3
+ pr4
+ pr5
+ pr6
+ pr7
+ pr8
+ pr9
//+ pr10
;

export concat_them := dedup(sort(distribute(concat,hash(did)),did,why,local),did,local);

end;