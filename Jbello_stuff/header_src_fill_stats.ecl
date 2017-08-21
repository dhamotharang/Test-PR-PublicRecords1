// export header_src_fill_stats := 'todo';
/* 
///////////////////////////////////	GET LICENSES FROM DL
   dl0:=table(DriversV2.File_Dl,{
   				did
   				,qstring24 dln:=trim(dl_number)
   				,qstring24 odln:=trim(old_dl_number)
   				,qstring24 oodln:=trim(oos_previous_dl_number)
   				,qstring2 oost:=trim(oos_previous_st)
   				,st
   				})	:persist('~thor_data400::persist::jbello_dl');
   
   dl1:=normalize(dl0,3,transform(
   							{dl0.did
   							,dl0.dln
   							,dl0.st}
   								,self.did:=left.did
   								,self.dln:=choose(counter,left.dln,left.odln,left.oodln)
   								,self.st:=choose(counter,left.st,left.st,left.oost)
   							));
   
   dl:=dedup(sort(distribute(dl1(dln<>''),hash(did)),did,local),did,all,local)
   						:persist('~thor_data400::persist::jbello_dln');
   ///////////////////////////////////  GET LICENSES FROM VEHICLE
   d:=VehicleV2.File_Vehicles;
   d0:=table(d		,{own_1_did
   				,OWN_1_DRIVER_LICENSE_NUMBER
   				,OWN_1_DOB
   				,OWN_1_SEX
   				,own_2_did
   				,OWN_2_DRIVER_LICENSE_NUMBER
   				,OWN_2_DOB
   				,OWN_2_SEX
   				,reg_1_did
   				,REG_1_DRIVER_LICENSE_NUMBER
   				,REG_1_DOB
   				,REG_1_SEX
   				,reg_2_did
   				,REG_2_DRIVER_LICENSE_NUMBER
   				,REG_2_DOB
   				,REG_2_SEX});
   
   d1:=normalize(d0,4,transform(
   						{did:=d0.own_1_did
   						,vdl:=d0.OWN_1_DRIVER_LICENSE_NUMBER
   						,dob:=d0.OWN_1_DOB
   						,sex:=d0.OWN_1_SEX}
   							,self.did:=choose(counter,left.own_1_did,left.own_2_did,left.reg_1_did,left.reg_2_did)
   							,self.vdl:=choose(counter,left.OWN_1_DRIVER_LICENSE_NUMBER,left.OWN_2_DRIVER_LICENSE_NUMBER,left.REG_1_DRIVER_LICENSE_NUMBER,left.REG_2_DRIVER_LICENSE_NUMBER)
   							,self.dob:=choose(counter,left.OWN_1_DOB,left.OWN_2_DOB,left.REG_1_DOB,left.REG_2_DOB)
   							,self.sex:=choose(counter,left.OWN_1_SEX,left.OWN_2_SEX,left.REG_1_SEX,left.REG_2_SEX)
   						));
   
   d2:=dedup(sort(distribute(d1(trim(did)<>'',trim(vdl)<>''),hash(did)),did,-vdl,local),did,all,local)
   						:persist('~thor_data400::persist::jbello_vdln');
   
*/

///////////////////////////////////  APPEND DL/VEH LICENSES TO HEADER AND FLAG ALL SOURCES
import header,ut,mdr;
hdr0 := table(header.file_headers,{did
									,src
									,ssn
									,dob
									,title
									,fname
									,mname
									,lname
									,name_suffix
									,prim_range
									,prim_name
									,sec_range
									,city_name
									,zip
									,dt_nonglb_last_seen
									,dt_first_seen});

r0:={ unsigned integer6 did, qstring24 dln, qstring2 st };
dl:=dataset(ut.foreign_dataland+'~thor_data400::persist::jbello_dln',r0,flat);
hdr1:=join(distribute(hdr0,hash(did)),distribute(dl,hash(did))
		,	left.did=right.did
		and	mdr.sourcetools.sourceisdl(left.src)
		,transform({hdr0
					,dl.dln}
						,self:=left
						,self:=right)
		,left outer
		,local);

r1:={  string12 did,  string13 vdl,  string8 dob,  string1 sex};
vdl:=dataset('~thor_data400::persist::jbello_vdln',r1,flat);
hdr:=join(distribute(hdr1,hash(did)),distribute(vdl,hash((unsigned6)did))
		,	left.did=(unsigned6)right.did
		and	mdr.sourcetools.sourceisvehicle(left.src)
		,transform({hdr1
					,vdl.vdl
					,dob2:=vdl.dob}
						,self:=left
						,self.dob2:=right.dob
						,self:=right)
		,left outer
		,local);

r2 := record
 unsigned6 did;
 string2  src;
 string9  ssn;
 string24  dl;
 string8  dob;
 string2  title;
 string20  fname;
 string20  mname;
 string20  lname;
 string5   name_suffix;
 string10  prim_range;
 string28  prim_name;
 string8   sec_range;
 string25   city_name;
 string5   zip;
 string6   in_eq;
 string6   in_en;
 string6   in_wp;
 string6   in_util;
 string6   in_ts;
 string6   in_veh;
 string6   in_prop;
 string6   in_dl;
 string6   in_other;
 string6   only_glb;
end;

// N =name
// L =Lic
// S =SSN
// D =DOB
// A =Addr
// G =Gender
whats_in_it(hdr l) := function
	_N:=if(l.fname<>'','N',' ');
	_L:=if(l.dln<>'' or l.vdl<>'','L',' ');
	_S:=if(l.ssn<>'','S',' ');
	_D:=if(l.dob>0,'D',' ');
	_A:=if(l.zip<>'' or l.city_name<>'','A',' ');
	_G:=if(l.title<>'','G',' ');
	return _N+_L+_S+_D+_A+_G;
end;

r2 t0(hdr le) := transform
	self.in_eq    := if(le.src='EQ',			whats_in_it(le),'');
	self.in_en    := if(le.src='EN',			whats_in_it(le),'');
	self.in_wp    := if(le.src='WP',			whats_in_it(le),'');
	self.in_util  := if(le.src in ['UT','UW'],	whats_in_it(le),'');
	self.in_ts    := if(le.src='TS',			whats_in_it(le),'');
	self.in_veh   := if(mdr.sourcetools.sourceisvehicle(le.src),whats_in_it(le),'');
	self.in_prop  := if(mdr.sourcetools.sourceisproperty(le.src),whats_in_it(le),'');
	self.in_dl    := if(mdr.sourcetools.sourceisdl(le.src),whats_in_it(le),'');
	self.in_other := if(le.src not in ['EQ','EN','WP','UT','UW','TS']
					and ~mdr.sourcetools.sourceisvehicle(le.src)
					and ~mdr.sourcetools.sourceisproperty(le.src)
					and ~mdr.sourcetools.sourceisdl(le.src)
					,whats_in_it(le),'');

	self.only_glb   := if(mdr.sourcetools.sourceisglb(le.src) and ~(header.isPreGLB(le))
					,whats_in_it(le),'');
	self.dl         := map(	mdr.sourcetools.sourceisvehicle(le.src)=>le.vdl
						,mdr.sourcetools.sourceisdl(le.src)=>le.dln
						,'');
	self.dob        := map(	mdr.sourcetools.sourceisdl(le.src)=>le.dob2
							,(string)le.dob);
	self            := le;
end;
// only_glb is overloaded:
	// 1)	at this point it flags whether the record is glb and what data elements are populated
	// 2)	after the final rollup it flags which data element in the link id
		// appear in glb records only
p1 := project(hdr,t0(left));
p1_dist := distribute(p1,hash(did)):persist('~thor_data400:::temp::header::flag_pre_roll');
s:=[4666668
,4667068
,12750033
,13836685
,44143871
,44744025
,52690913
,54121196
,62691784
,67085364
,71699437
,81254702
,96265445
,109779411
];
// output(p1_dist(did in s));
output(p1_dist);

r2 roll_glb_N(r2 l,r2 r) := transform
	_N:=if(	l.fname+l.mname+l.lname+l.name_suffix<>
			r.fname+r.mname+r.lname+l.name_suffix,r.only_glb[1]
			,if(trim(l.only_glb[1])='',l.only_glb[1],r.only_glb[1]));
	_L:=r.only_glb[2];
	_S:=r.only_glb[3];
	_D:=r.only_glb[4];
	_A:=r.only_glb[5];
	_G:=r.only_glb[6];
	self.only_glb:=_N+_L+_S+_D+_A+_G;
	self:=r;
end;
r2 roll_glb_L(r2 l,r2 r) := transform
	_N:=r.only_glb[1];
	_L:=if(	l.dl<>r.dl,r.only_glb[2]
		,if(trim(l.only_glb[2])='',l.only_glb[2],r.only_glb[2]));
	_S:=r.only_glb[3];
	_D:=r.only_glb[4];
	_A:=r.only_glb[5];
	_G:=r.only_glb[6];
	self.only_glb:=_N+_L+_S+_D+_A+_G;
	self:=r;
end;
r2 roll_glb_S(r2 l,r2 r) := transform
	_N:=r.only_glb[1];
	_L:=r.only_glb[2];
	_S:=if(	l.ssn<>r.ssn,r.only_glb[3]
			,if(trim(l.only_glb[3])='',l.only_glb[3],r.only_glb[3]));
	_D:=r.only_glb[4];
	_A:=r.only_glb[5];
	_G:=r.only_glb[6];
	self.only_glb:=_N+_L+_S+_D+_A+_G;
	self:=r;
end;
r2 roll_glb_D(r2 l,r2 r) := transform
	_N:=r.only_glb[1];
	_L:=r.only_glb[2];
	_S:=r.only_glb[3];
	_D:=if(	l.dob<>r.dob,r.only_glb[4]
			,if(trim(l.only_glb[4])='',l.only_glb[4],r.only_glb[4]));
	_A:=r.only_glb[5];
	_G:=r.only_glb[6];
	self.only_glb:=_N+_L+_S+_D+_A+_G;
	self:=r;
end;
r2 roll_glb_A(r2 l,r2 r) := transform
	_N:=r.only_glb[1];
	_L:=r.only_glb[2];
	_S:=r.only_glb[3];
	_D:=r.only_glb[4];
	_A:=if(	l.prim_range+l.prim_name+l.sec_range+l.zip<>
			r.prim_range+r.prim_name+r.sec_range+r.zip,r.only_glb[5]
				,if(trim(l.only_glb[5])='',l.only_glb[5],r.only_glb[5]));
	_G:=r.only_glb[6];
	self.only_glb:=_N+_L+_S+_D+_A+_G;
	self:=r;
end;
r2 roll_glb_G(r2 l,r2 r) := transform
	_N:=r.only_glb[1];
	_L:=r.only_glb[2];
	_S:=r.only_glb[3];
	_D:=r.only_glb[4];
	_A:=r.only_glb[5];
	_G:=if(	l.title<>r.title,r.only_glb[6]
			,if(trim(l.only_glb[6])='',l.only_glb[6],r.only_glb[6]));
	self.only_glb:=_N+_L+_S+_D+_A+_G;
	self:=r;
end;

rollem(string6 l,string6 r) := function
	_N:=if(trim(l[1])='',r[1],l[1]);
	_L:=if(trim(l[2])='',r[2],l[2]);
	_S:=if(trim(l[3])='',r[3],l[3]);
	_D:=if(trim(l[4])='',r[4],l[4]);
	_A:=if(trim(l[5])='',r[5],l[5]);
	_G:=if(trim(l[6])='',r[6],l[6]);
	return _N+_L+_S+_D+_A+_G;
end;

roll_glb(string6 l,string6 r) := function
	_N:=if(trim(l[1])='',l[1],r[1]);
	_L:=if(trim(l[2])='',l[2],r[2]);
	_S:=if(trim(l[3])='',l[3],r[3]);
	_D:=if(trim(l[4])='',l[4],r[4]);
	_A:=if(trim(l[5])='',l[5],r[5]);
	_G:=if(trim(l[6])='',l[6],r[6]);
	return _N+_L+_S+_D+_A+_G;
end;

r2 t1(r2 le, r2 ri) := transform
	self.in_eq    := if(trim(le.in_eq)=''	, ri.in_eq,		rollem(le.in_eq,ri.in_eq));
	self.in_en    := if(trim(le.in_en)=''	, ri.in_en,		rollem(le.in_en,ri.in_en));
	self.in_wp    := if(trim(le.in_wp)=''	, ri.in_wp,		rollem(le.in_wp,ri.in_wp));
	self.in_util  := if(trim(le.in_util)=''	, ri.in_util,	rollem(le.in_util,ri.in_util));
	self.in_ts    := if(trim(le.in_ts)=''	, ri.in_ts,		rollem(le.in_ts,ri.in_ts));
	self.in_veh   := if(trim(le.in_veh)=''	, ri.in_veh,	rollem(le.in_veh,ri.in_veh));
	self.in_prop  := if(trim(le.in_prop)=''	, ri.in_prop,	rollem(le.in_prop,ri.in_prop));
	self.in_dl    := if(trim(le.in_dl)=''	, ri.in_dl,		rollem(le.in_dl,ri.in_dl));
	self.in_other := if(trim(le.in_other)='', ri.in_other,	rollem(le.in_other,ri.in_other));
	self.only_glb := if(trim(le.only_glb)='', ri.only_glb,	roll_glb(le.only_glb,ri.only_glb));
	self          := le;
end;

p1g:= group(sort(p1_dist,did,local),did,local);
i1 := iterate(sort(p1g,fname,mname,lname,name_suffix,-only_glb),roll_glb_N(left,right));
i2 := iterate(sort(i1,prim_range,prim_name,sec_range,zip,-only_glb),roll_glb_A(left,right));
i3 := iterate(sort(i2,dl,-only_glb),roll_glb_L(left,right));
i4 := iterate(sort(i3,dob,-only_glb),roll_glb_D(left,right));
i5 := iterate(sort(i4,title,-only_glb),roll_glb_G(left,right));
i6 := rollup(sort(i5,-only_glb),left.did=right.did,t1(left,right)):persist('~thor_data400::temp:header::flag');

// output(i6(	only_glb[1] in ['N',' ']
			// ,only_glb[2]=' '
			// ,only_glb[3] in ['S',' ']
			// ,only_glb[4]='D'
			// ,only_glb[5] in ['A',' ']
			// ,only_glb[6]=' '
			// ),all);
output(i6);

///////////////////////////////////  PRODUCE STATS

stats:=table(group(i6),{
			Total_Name	:=sum(group,if(stringlib.stringfind(in_eq,'N',1)>0
									or stringlib.stringfind(in_en,'N',1)>0
									or stringlib.stringfind(in_wp,'N',1)>0
									or stringlib.stringfind(in_util,'N',1)>0
									or stringlib.stringfind(in_ts,'N',1)>0
									or stringlib.stringfind(in_veh,'N',1)>0
									or stringlib.stringfind(in_prop,'N',1)>0
									or stringlib.stringfind(in_dl,'N',1)>0
									or stringlib.stringfind(in_other,'N',1)>0
									or stringlib.stringfind(only_glb,'N',1)>0
									,1,0))
			,name_fill_eq_cnt	:=sum(group,if(stringlib.stringfind(in_eq,'N',1)>0 ,1,0))
			,name_fill_en_cnt	:=sum(group,if(stringlib.stringfind(in_en,'N',1)>0,1,0))
			,name_fill_wp_cnt	:=sum(group,if(stringlib.stringfind(in_wp,'N',1)>0,1,0))
			,name_fill_ut_cnt	:=sum(group,if(stringlib.stringfind(in_util,'N',1)>0,1,0))
			,name_fill_ts_cnt	:=sum(group,if(stringlib.stringfind(in_ts,'N',1)>0,1,0))
			,name_fill_vh_cnt	:=sum(group,if(stringlib.stringfind(in_veh,'N',1)>0,1,0))
			,name_fill_pr_cnt	:=sum(group,if(stringlib.stringfind(in_prop,'N',1)>0,1,0))
			,name_fill_dl_cnt	:=sum(group,if(stringlib.stringfind(in_dl,'N',1)>0,1,0))
			,name_fill_ot_cnt	:=sum(group,if(stringlib.stringfind(in_other,'N',1)>0,1,0))
			,name_fill_og_cnt	:=sum(group,if(stringlib.stringfind(only_glb,'N',1)>0,1,0))

			,Total_Lic	:=sum(group,if(stringlib.stringfind(in_eq,'L',1)>0
									or stringlib.stringfind(in_en,'L',1)>0
									or stringlib.stringfind(in_wp,'L',1)>0
									or stringlib.stringfind(in_util,'L',1)>0
									or stringlib.stringfind(in_ts,'L',1)>0
									or stringlib.stringfind(in_veh,'L',1)>0
									or stringlib.stringfind(in_prop,'L',1)>0
									or stringlib.stringfind(in_dl,'L',1)>0
									or stringlib.stringfind(in_other,'L',1)>0
									or stringlib.stringfind(only_glb,'L',1)>0
									,1,0))
			,Lic_fill_eq_cnt	:=sum(group,if(stringlib.stringfind(in_eq,'L',1)>0,1,0))
			,Lic_fill_en_cnt	:=sum(group,if(stringlib.stringfind(in_en,'L',1)>0,1,0))
			,Lic_fill_wp_cnt	:=sum(group,if(stringlib.stringfind(in_wp,'L',1)>0,1,0))
			,Lic_fill_ut_cnt	:=sum(group,if(stringlib.stringfind(in_util,'L',1)>0,1,0))
			,Lic_fill_ts_cnt	:=sum(group,if(stringlib.stringfind(in_ts,'L',1)>0,1,0))
			,Lic_fill_vh_cnt	:=sum(group,if(stringlib.stringfind(in_veh,'L',1)>0,1,0))
			,Lic_fill_pr_cnt	:=sum(group,if(stringlib.stringfind(in_prop,'L',1)>0,1,0))
			,Lic_fill_dl_cnt	:=sum(group,if(stringlib.stringfind(in_dl,'L',1)>0,1,0))
			,Lic_fill_ot_cnt	:=sum(group,if(stringlib.stringfind(in_other,'L',1)>0,1,0))
			,Lic_fill_og_cnt	:=sum(group,if(stringlib.stringfind(only_glb,'L',1)>0,1,0))

			,Total_SSN	:=sum(group,if(stringlib.stringfind(in_eq,'S',1)>0
									or stringlib.stringfind(in_en,'S',1)>0
									or stringlib.stringfind(in_wp,'S',1)>0
									or stringlib.stringfind(in_util,'S',1)>0
									or stringlib.stringfind(in_ts,'S',1)>0
									or stringlib.stringfind(in_veh,'S',1)>0
									or stringlib.stringfind(in_prop,'S',1)>0
									or stringlib.stringfind(in_dl,'S',1)>0
									or stringlib.stringfind(in_other,'S',1)>0
									or stringlib.stringfind(only_glb,'S',1)>0
									,1,0))
			,SSN_fill_eq_cnt	:=sum(group,if(stringlib.stringfind(in_eq,'S',1)>0,1,0))
			,SSN_fill_en_cnt	:=sum(group,if(stringlib.stringfind(in_en,'S',1)>0,1,0))
			,SSN_fill_wp_cnt	:=sum(group,if(stringlib.stringfind(in_wp,'S',1)>0,1,0))
			,SSN_fill_ut_cnt	:=sum(group,if(stringlib.stringfind(in_util,'S',1)>0,1,0))
			,SSN_fill_ts_cnt	:=sum(group,if(stringlib.stringfind(in_ts,'S',1)>0,1,0))
			,SSN_fill_vh_cnt	:=sum(group,if(stringlib.stringfind(in_veh,'S',1)>0,1,0))
			,SSN_fill_pr_cnt	:=sum(group,if(stringlib.stringfind(in_prop,'S',1)>0,1,0))
			,SSN_fill_dl_cnt	:=sum(group,if(stringlib.stringfind(in_dl,'S',1)>0,1,0))
			,SSN_fill_ot_cnt	:=sum(group,if(stringlib.stringfind(in_other,'S',1)>0,1,0))
			,SSN_fill_og_cnt	:=sum(group,if(stringlib.stringfind(only_glb,'S',1)>0,1,0))

			,Total_DOB	:=sum(group,if(stringlib.stringfind(in_eq,'D',1)>0
									or stringlib.stringfind(in_en,'D',1)>0
									or stringlib.stringfind(in_wp,'D',1)>0
									or stringlib.stringfind(in_util,'D',1)>0
									or stringlib.stringfind(in_ts,'D',1)>0
									or stringlib.stringfind(in_veh,'D',1)>0
									or stringlib.stringfind(in_prop,'D',1)>0
									or stringlib.stringfind(in_dl,'D',1)>0
									or stringlib.stringfind(in_other,'D',1)>0
									or stringlib.stringfind(only_glb,'D',1)>0
									,1,0))
			,DOB_fill_eq_cnt	:=sum(group,if(stringlib.stringfind(in_eq,'D',1)>0,1,0))
			,DOB_fill_en_cnt	:=sum(group,if(stringlib.stringfind(in_en,'D',1)>0,1,0))
			,DOB_fill_wp_cnt	:=sum(group,if(stringlib.stringfind(in_wp,'D',1)>0,1,0))
			,DOB_fill_ut_cnt	:=sum(group,if(stringlib.stringfind(in_util,'D',1)>0,1,0))
			,DOB_fill_ts_cnt	:=sum(group,if(stringlib.stringfind(in_ts,'D',1)>0,1,0))
			,DOB_fill_vh_cnt	:=sum(group,if(stringlib.stringfind(in_veh,'D',1)>0,1,0))
			,DOB_fill_pr_cnt	:=sum(group,if(stringlib.stringfind(in_prop,'D',1)>0,1,0))
			,DOB_fill_dl_cnt	:=sum(group,if(stringlib.stringfind(in_dl,'D',1)>0,1,0))
			,DOB_fill_ot_cnt	:=sum(group,if(stringlib.stringfind(in_other,'D',1)>0,1,0))
			,DOB_fill_og_cnt	:=sum(group,if(stringlib.stringfind(only_glb,'D',1)>0,1,0))

			,Total_Sex	:=sum(group,if(stringlib.stringfind(in_eq,'G',1)>0
									or stringlib.stringfind(in_en,'G',1)>0
									or stringlib.stringfind(in_wp,'G',1)>0
									or stringlib.stringfind(in_util,'G',1)>0
									or stringlib.stringfind(in_ts,'G',1)>0
									or stringlib.stringfind(in_veh,'G',1)>0
									or stringlib.stringfind(in_prop,'G',1)>0
									or stringlib.stringfind(in_dl,'G',1)>0
									or stringlib.stringfind(in_other,'G',1)>0
									or stringlib.stringfind(only_glb,'G',1)>0
									,1,0))
			,Sex_fill_eq_cnt	:=sum(group,if(stringlib.stringfind(in_eq,'G',1)>0,1,0))
			,Sex_fill_en_cnt	:=sum(group,if(stringlib.stringfind(in_en,'G',1)>0,1,0))
			,Sex_fill_wp_cnt	:=sum(group,if(stringlib.stringfind(in_wp,'G',1)>0,1,0))
			,Sex_fill_ut_cnt	:=sum(group,if(stringlib.stringfind(in_util,'G',1)>0,1,0))
			,Sex_fill_ts_cnt	:=sum(group,if(stringlib.stringfind(in_ts,'G',1)>0,1,0))
			,Sex_fill_vh_cnt	:=sum(group,if(stringlib.stringfind(in_veh,'G',1)>0,1,0))
			,Sex_fill_pr_cnt	:=sum(group,if(stringlib.stringfind(in_prop,'G',1)>0,1,0))
			,Sex_fill_dl_cnt	:=sum(group,if(stringlib.stringfind(in_dl,'G',1)>0,1,0))
			,Sex_fill_ot_cnt	:=sum(group,if(stringlib.stringfind(in_other,'G',1)>0,1,0))
			,Sex_fill_og_cnt	:=sum(group,if(stringlib.stringfind(only_glb,'G',1)>0,1,0))

			,Total_Addr	:=sum(group,if(stringlib.stringfind(in_eq,'A',1)>0
									or stringlib.stringfind(in_en,'A',1)>0
									or stringlib.stringfind(in_wp,'A',1)>0
									or stringlib.stringfind(in_util,'A',1)>0
									or stringlib.stringfind(in_ts,'A',1)>0
									or stringlib.stringfind(in_veh,'A',1)>0
									or stringlib.stringfind(in_prop,'A',1)>0
									or stringlib.stringfind(in_dl,'A',1)>0
									or stringlib.stringfind(in_other,'A',1)>0
									or stringlib.stringfind(only_glb,'A',1)>0
									,1,0))
			,Addr_fill_eq_cnt	:=sum(group,if(stringlib.stringfind(in_eq,'A',1)>0,1,0))
			,Addr_fill_en_cnt	:=sum(group,if(stringlib.stringfind(in_en,'A',1)>0,1,0))
			,Addr_fill_wp_cnt	:=sum(group,if(stringlib.stringfind(in_wp,'A',1)>0,1,0))
			,Addr_fill_ut_cnt	:=sum(group,if(stringlib.stringfind(in_util,'A',1)>0,1,0))
			,Addr_fill_ts_cnt	:=sum(group,if(stringlib.stringfind(in_ts,'A',1)>0,1,0))
			,Addr_fill_vh_cnt	:=sum(group,if(stringlib.stringfind(in_veh,'A',1)>0,1,0))
			,Addr_fill_pr_cnt	:=sum(group,if(stringlib.stringfind(in_prop,'A',1)>0,1,0))
			,Addr_fill_dl_cnt	:=sum(group,if(stringlib.stringfind(in_dl,'A',1)>0,1,0))
			,Addr_fill_ot_cnt	:=sum(group,if(stringlib.stringfind(in_other,'A',1)>0,1,0))
			,Addr_fill_og_cnt	:=sum(group,if(stringlib.stringfind(only_glb,'A',1)>0,1,0))
			},few,local);

output(stats);












