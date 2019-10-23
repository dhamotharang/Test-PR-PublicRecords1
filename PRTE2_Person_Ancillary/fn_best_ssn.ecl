
import idl_header, ut, mdr, header;

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

export fn_best_ssn(dataset(recordof(layouts.Layout_Header_Link)) in_hdr) := module

shared hdr_layout := Layouts.Layout_Header_Link;

//purposefully excluded UW (it would be a double-counting if i left it in)
//resolve double-counting of UT and EQ sources later in the process (exclude UT only if EQ already provides it)
//export hdr1 := distribute(in_hdr(ut.full_ssn(ssn)=true and ssn not in ut.set_badssn and src<>'ADLUW'),hash(did));

export hdr1 := distribute(in_hdr(ut.full_ssn(ssn)=true and ssn not in ut.set_badssn and src<>'UW'),hash(did));

//shared unique_eq_confirmeds := insuranceheader_bestofbest.fn_IDL_has_one_confirmed_SSN(hdr1);
shared unique_eq_confirmeds := fn_IDL_has_one_confirmed_SSN(hdr1);

//keep the set of ADLs having zero or more than 1 confirmed EQ SSN
hdr_layout tjoin(hdr1 le, unique_eq_confirmeds ri) := transform
 self := le;
end;

shared hdr2 := join(hdr1,unique_eq_confirmeds,left.did=right.did,tjoin(left,right),left only,local);

//get the MIN DOB for all records, not just those with an SSN
shared r_min_dob := record
 in_hdr.did;
 integer min_dob := min(group,in_hdr.dob div 10000);
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
 boolean in_insurance;
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
 integer in_insurance_cnt;
 integer in_other_cnt;
 integer total_sources;
 integer total_score;
 integer total_times_seen;
 integer dt_last_seen;
 boolean dt_last_seen_is_recent;
 ta_dob.min_dob;
 string1 old_ssn;
end;

r1 t1(hdr2 le, r_min_dob ri) := transform

 // boolean v_in_eq         := le.src='ADLEQ';
 // boolean v_in_en         := le.src='ADLEN';
 // boolean v_in_ts         := le.src='ADLTS';
 // boolean v_in_ssa_deaths := le.src='ADLDE';
 // boolean v_in_bk         := le.src='ADLBA';
 // boolean v_in_liens      := le.src='ADLL2';
 // boolean v_in_utility    := le.src='ADLUT';
 // boolean v_in_certegy    := le.src='ADLCY';
 
 boolean v_in_eq := le.src='EQ';
 boolean v_in_en := le.src='EN';
 boolean v_in_ts := le.src='TS';
 boolean v_in_ssa_deaths := le.src='DE';
 boolean v_in_bk := le.src='BA';
 boolean v_in_liens := le.src='L2';
 boolean v_in_utility := le.src='UT';
 boolean v_in_certegy := le.src='CY';

 //boolean v_in_insurance  := (le.src[1..3]='IVS' or le.src[1..3] = 'ICP' or le.src[1..3] = 'ICA');
 boolean v_in_insurance  := false;

 integer v_score_eq         := 5;
 integer v_score_en         := 5;
 integer v_score_ts         := 3;
 integer v_score_ssa_deaths := 5;
 integer v_score_bk         := 5;
 integer v_score_liens      := 5;
 integer v_score_utility    := 4;
 integer v_score_certegy    := 4;
 integer v_score_other      := 3;
 integer v_score_insurance  := 5;
 
 //idea is to use dppa content for scoring
 //we won't return an SSN that's only DPPA sourced
  self.ssn_only_in_dppa        := mdr.sourcetools.sourceisdppa(le.src)=true;
 //self.ssn_only_in_dppa        := false;
 self.ssn_belongs_to_relative := le.ssn_ind='R';
 
 self.in_eq         := v_in_eq;
 self.in_en         := v_in_en;
 self.in_ts         := v_in_ts;
 self.in_ssa_deaths := v_in_ssa_deaths;
 self.in_bk         := v_in_bk;
 self.in_liens      := v_in_liens;
 self.in_utility    := v_in_utility;
 self.in_certegy    := v_in_certegy;
 self.in_insurance  := v_in_insurance;
 
 self.in_other := v_in_eq        =false and
                  v_in_en        =false and
                  v_in_ts        =false and
									v_in_ssa_deaths=false and
									v_in_bk        =false and
									v_in_liens     =false and
									v_in_utility   =false and
									v_in_certegy   =false and
									v_in_insurance =false
				  ;			  
 self.in_one_confident_source := self.in_eq=true or self.in_en=true or self.in_ssa_deaths=true or self.in_bk=true or self.in_liens=true or self.in_insurance=true;
 
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
 self.in_insurance_cnt  := if(v_in_insurance =true,1,0);
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
												 +if(v_in_insurance =true,v_score_insurance,0)
												 +if(self.in_other  =true,v_score_other,0)
						 );

 self.old_ssn                :='';
 self.total_sources          := 0;
 self.total_times_seen       := 1;
 self.dt_last_seen           := le.dt_last_seen;
 self.dt_last_seen_is_recent := if(self.dt_last_seen>0 and (header.ConvertYYYYMMToNumberOfMonths((unsigned3)ut.getdate[1..6]) - header.ConvertYYYYMMToNumberOfMonths(self.dt_last_seen) < 24),true,false);
 
 self := le;
 self := ri;
 
end;

p1 := join(hdr2,ta_dob,left.did=right.did,t1(left,right),left outer,local);

r1 t_issued_before_dob(r1 le, layouts.Layout_SSN_Map ri) := transform
  self.old_ssn := if(le.min_dob <= (integer)(string)ri.end_date[1..4],'N',
                  if(le.min_dob  > (integer)(string)ri.end_date[1..4],'Y',
				  ''));
  self                       := le;
end;

j0 := join(p1,files.file_ssn_map(ssn5<>'' and end_date<ut.getdate),left.ssn[1..5]=right.ssn5 and left.ssn[6..9] between right.start_serial and right.end_serial,t_issued_before_dob(left,right),left outer,lookup);

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
 self.in_insurance  := if(le.in_insurance =true,le.in_insurance, ri.in_insurance);
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
 self.in_insurance_cnt  := le.in_insurance_cnt +ri.in_insurance_cnt;
 self.in_other_cnt      := le.in_other_cnt     +ri.in_other_cnt;

 self.total_score          := le.total_score     +ri.total_score;
 self.total_times_seen     := le.total_times_seen+1;
 self.dt_last_seen := ut.max2(le.dt_last_seen,ri.dt_last_seen);
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
						      +if(le.in_insurance =true,1,0)
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
export ranked := one_possibility + f3;

end;