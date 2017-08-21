import utilfile,header,ut,doxie;

r1 := record
 header.layout_header_strings;
 integer belongs_to_minor:=0;
 integer bad_ssn         :=0;
end;

r2 := record
 string2 src;
 string9 ssn;
 integer belongs_to_minor;
 integer bad_ssn;
 integer ssn4;
end;

ds_util   := utilfile.file_util_in(ssn<>'');
ds_deaths := header.File_DID_Death_MasterV2(ssn<>'');

r1 t_map_raw_util(ds_util le) := transform
 self.src := 'UT';
 self.ssn := le.ssn;
 self     := [];
end;

r1 t_map_raw_deaths(ds_deaths le) := transform
 self.src              := 'DE';
 self.ssn              := le.ssn;
 self.belongs_to_minor := if(le.dob8 between '19900317' and ut.GetDate,1,0);
 self                  := [];
end;

util   := project(ds_util,  t_map_raw_util  (left));
deaths := project(ds_deaths,t_map_raw_deaths(left));
hdr    := project(header.file_headers(ssn<>''),r1);
tu     := project(dataset('~thor_dell400_2::persist::transunion_did',header.layout_header,flat)(ssn<>''),r1);
		
concat := (hdr
         + tu
	     + util
	     + deaths
	      );

r2 t0(concat le) := transform

 string9 v_ssn := stringlib.stringfindreplace(le.ssn,'*****','00000');
 string  v_ssn2 := trim(v_ssn,left,right);
 
 integer v_ssn2_length := length(v_ssn2);
 
 //self.src     := if(le.src='UW','UT',le.src);
 self.src     := if(le.src in ['EQ','UT','UW'],'--',
                 if(le.src='LI','L2',
				 if(le.src='DS','DE',
				 le.src)));
 self.bad_ssn := if(((integer)le.ssn in doxie.bad_ssn_list) 
                 or v_ssn2!=stringlib.stringfilter(v_ssn2,'0123456789')
				 or v_ssn2_length not in [4,9],
				 1,0);
 self.ssn4    := if(self.bad_ssn=1,0,
                 if(v_ssn2_length=9 and v_ssn2=stringlib.stringfilter(v_ssn2,'0123456789') and v_ssn2[1..5]='00000',1,
				 if(v_ssn2_length=4 and v_ssn2=stringlib.stringfilter(v_ssn2,'0123456789'),1,
				 0)));				 
 self         := le;
end;

d1      := project(concat,t0(left));
d1_dist := distribute(d1,hash(ssn));
d1_sort := sort      (d1_dist,ssn,src,local);

r2 t_rollup(d1_sort le, d1_sort ri) := transform
 self.bad_ssn := ut.max2(le.bad_ssn,ri.bad_ssn);
 self.ssn4    := ut.max2(le.ssn4   ,ri.ssn4);
 self         := le;
end;

p_rollup := rollup(d1_sort,left.ssn=right.ssn and left.src=right.src,t_rollup(left,right),local);

deaths_minors := dedup(deaths(belongs_to_minor=1 and length(trim(ssn))=9 and ssn[1..5]<>'00000'),ssn,record);

r2 t_append_minors_to_all(p_rollup le, deaths_minors ri) := transform
 self.belongs_to_minor := if(ri.ssn<>'',1,0);
 self                  := le;
end;

j1      := join(p_rollup,deaths_minors,left.ssn=right.ssn,t_append_minors_to_all(left,right),left outer,lookup);

export ssn_gather := j1 : persist('persist::jtrost_ssn_slim');