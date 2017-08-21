import header,ut,address,mdr,idl_header;

export MAC_BasicMatch(inPH, inNHR, oNMPH, oNMNHR, oMNHR) := MACRO

r1:= record
	header.layout_header_strings
	,unsigned8 uid:=0
	,string8   dob_string:=''
	,integer   has_ssn_cnt:=0
	,integer   has_dob_cnt:=0
end;

PH1  := distribute(project(inPH,r1),  hash(src,fname,lname,prim_range,prim_name,st));
NHR1 := distribute(project(inNHR,r1), hash(src,fname,lname,prim_range,prim_name,st));

// use l.rid and r.uid to establish which side to keep.
// 1. l.rid>0 and r.uid>0 then NHR match to at least one PH; keep NHR. Matched, done.
// 2. l.rid=0 and r.uid>0 then NHR did not match any PH; keep NHR. Not Matched, try it again with the looser join.
// 3. l.rid>0 and r.uid=0 then PH did not match any NHR; keep PH. Not Matched, try it again with the looser join.
r1 add_rid_all(PH1 l, NHR1 r) := transform
	close := ut.DaysApart((STRING6)l.dt_first_seen+'01',(STRING6)r.dt_first_seen+'01')<4*30;
	self.did            := l.did;
	self.rid            := l.rid;
	self.pflag1         := if(l.rid>0 and r.uid>0 and close,'C',l.pflag1);
	self.dodgy_tracking := l.dodgy_tracking;
	self.uid            := r.uid;
	self                := if(l.rid>0 and r.uid=0,l,r);
end;

//I. tight but loose on dt_first_seen join - pull rolled and unrolled records
Match1 :=  join(PH1, NHR1
					,	left.src		=right.src
					and	left.fname		=right.fname
					and	left.lname		=right.lname
					and	left.prim_range =right.prim_range
					and	left.prim_name  =right.prim_name
					and	left.st			=right.st
					and	(
								(ut.nneq(left.ssn				,right.ssn)
							and	ut.NNEQ_Date(left.dob			,right.dob)
							and	ut.nneq(left.phone				,right.phone)
							and	ut.nneq(left.mname				,right.mname)
							and	ut.nneq(left.name_suffix		,right.name_suffix)
							and	ut.nneq(left.sec_range			,right.sec_range)
							and	ut.nneq(left.zip				,right.zip)
							and	ut.nneq(left.county				,right.county)
							)
						)
				,add_rid_all(left,right)
				,full outer
				,local)
				:persist('~thor_data::persist::Header_joined_J1')
				;

// use rid and uid to establish whether it was matched.
// . rid>0 and uid>0 then NHR was match, done.
M1   := dedup(Match1(rid>0,uid>0),record,all,local) :persist('~thor_data::persist::Header_joined_M1');
////////////////////////////////////////////////////////////////////////////////////////////////////
// . rid=0 and uid>0 then NHR did not match any PH; try it again with fozzy join.
NHR2 := dedup(Match1(rid>0,uid>0,pflag1<>'C'),record,all,local);

r1 add_rid_all2(PH1 l, NHR2 r) := transform
	self.did            := l.did;
	self.rid            := l.rid;
	self.dodgy_tracking := l.dodgy_tracking;
	self.uid            := r.uid;
	self                := if(l.rid>0,l,r);
end;

//II. tight but loose on dt_first_seen join - pull rolled records
Match2 :=  join(PH1, NHR2
					,	left.src		=right.src
					and	left.fname		=right.fname
					and	left.lname		=right.lname
					and	left.prim_range =right.prim_range
					and	left.prim_name  =right.prim_name
					and	left.st			=right.st
					and	(
								(ut.nneq(left.ssn				,right.ssn)
							and	ut.NNEQ_Date(left.dob			,right.dob)
							and	ut.nneq(left.phone				,right.phone)
							and	ut.nneq(left.mname				,right.mname)
							and	ut.nneq(left.name_suffix		,right.name_suffix)
							and	ut.nneq(left.sec_range			,right.sec_range)
							and	ut.nneq(left.zip				,right.zip)
							and	ut.nneq(left.county				,right.county)
							and ut.DaysApart((STRING6)left.dt_first_seen+'01',(STRING6)right.dt_first_seen+'01')>3*30
							)
						)
				,add_rid_all2(left,right)
				,full outer
				,local)
				:persist('~thor_data::persist::Header_joined_J2')
				;

// use rid and uid to establish whether it was matched.
// . rid>0 and uid>0 then NHR was match, done.
M2   := dedup(Match2(rid>0,uid>0),record,all,local) :persist('~thor_data::persist::Header_joined_M2');
////////////////////////////////////////////////////////////////////////////////////////////////////
// . rid>0 and uid=0 then PH did not match any NHR; try it again with fozzy join.
PH3  := dedup(Match1(rid>0,uid=0),record,all,local);
// . rid=0 and uid>0 then NHR did not match any PH; try it again with fozzy join.
NHR3 := dedup(Match1(rid=0,uid>0),record,all,local);

fn_strip_trailing_zeroes(integer in_dob) := function
	string dob_string := (string)in_dob;
	string v_yyyy     := dob_string[1..4];
	string v_mm       := dob_string[5..6];
	string v_dd       := dob_string[7..8];

	string v_yyyy2 := if(v_yyyy='0000','',v_yyyy);
	string v_mm2   := if(v_mm='00','',v_mm);
	string v_dd2   := if(v_dd='00','',v_dd);

	return if(in_dob=0,'',(string)(v_yyyy2+v_mm2+v_dd2));
end;

//-- slimmer record format for header file (match_to)
r1 t1(NHR3 le) := transform
	self.fname      := trim(le.fname);
	self.lname      := trim(le.lname);
	self.prim_range := trim(le.prim_range);
	self.zip        := trim(le.zip);
	self            := le;
end;

infile := project(NHR3,t1(left));

//****** where header file has valid name, project into slimmer record format
match_to := PH3;

nhr_fieldpops := header.new_header_records_fieldpopulations;

//-- transform used to push header into slimmer record format
r1 slim(match_to le, nhr_fieldpops ri) := transform
	self.fname         := trim(le.fname);
	self.lname         := trim(le.lname);
	self.prim_range    := trim(le.prim_range);
	self.zip           := trim(le.zip);
	self.dob_string    := fn_strip_trailing_zeroes(le.dob);
	self.has_ssn_cnt   := ri.has_ssn_cnt;
	self.has_dob_cnt   := ri.has_dob_cnt;
	self               := le;
end;

j1    := join(match_to,nhr_fieldpops,left.src=right.src,slim(left,right),left outer,lookup);
hname := j1((fname<>'' and lname<>'') or (mdr.sourcetools.sourceisdeath(src) and fname<>'' and lname<>'' and ssn<>''));
h1    := distribute(hname,hash(src,fname,lname,prim_range,prim_name,st));

r1 t_flag_partials(r1 le) := transform
	self.dob_string  := fn_strip_trailing_zeroes(le.dob);
	self             := le;
end;

the_rest := distribute(project(infile,t_flag_partials(left)),hash(src,fname,lname,prim_range,prim_name,st));

r1 add_rid_all3(PH1 l, NHR1 r) := transform
	self.did            := l.did;
	self.rid            := l.rid;
	self.dodgy_tracking := l.dodgy_tracking;
	self.uid            := r.uid;
	self                := if(l.rid>0 and r.uid=0,l,r);
end;

//III. loose join - the old way 
Match3 :=  join(h1, the_rest,
                header.fn_bm_lr_commonality(left.fname,left.lname,left.prim_range,left.prim_name,left.zip,
				                            right.fname,right.lname,right.prim_range,right.prim_name,right.zip,
							                left.mname,right.mname,
							                left.name_suffix,right.name_suffix,
							                left.sec_range,right.sec_range,
							                left.phone,right.phone,
							                left.src,right.src,
											left.RawAID,right.RawAID) and 
				if(left.has_ssn_cnt=0 or ut.keep_fuller_ssn(left.ssn,right.ssn)<>'',true,
				if(left.pflag3 not in ['','W'],ut.nneq(left.ssn,right.ssn),
				left.ssn=right.ssn))
				and
				if(left.has_dob_cnt=0,true,left.dob_string[1..4]=right.dob_string[1..4] and ut.nneq(left.dob_string[5..6],right.dob_string[5..6]) and ut.nneq(left.dob_string[7..8],right.dob_string[7..8]))
				,add_rid_all3(left,right)
				,full outer
				,local)
				:persist('~thor_data::persist::Header_joined_J3')
				;

// use rid and uid to establish whether it was matched.
// . rid>0 and uid>0 then NHR was match, done.
M3     := dedup(Match3(rid>0,uid>0),record,all,local) :persist('~thor_data::persist::Header_joined_M3');

////////////////////////// EXIT //////////////////////////////////////////
// . rid>0 and uid=0 then PH did not match any NHR; these are no-longer-updating Header records (NLU).
oNMPH  := dedup(project(Match3(rid>0,uid=0),transform({inPH},self:=left)) ,record,all,local)
                                                      :persist('~thor_data::persist::Header_joined_NMPH');
// . rid=0 and uid>0 then NHR did not match any PH; these are first seen and/or unrolled records.
oNMNHR := dedup(Match3(rid=0,uid>0),record,all,local) :persist('~thor_data::persist::Header_joined_NMNHR');
oMNHR  := M1 + M2 + M3;
//////////////////////////////////////////////////////////////////////////
endmacro;