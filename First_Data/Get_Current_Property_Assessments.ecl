import ln_property, ut, ln_propertyv2;

//FDS brought to our attention several people who should be identified as Owners
//The problem is that the original code only brought in records that had a value in the tax_year field
//This was thought to be necessary in order to sequence the records
//Removing this condition and allowing records with a blank tax_year to be included resolved problem
//Essentially, if no records for an address have a tax_year, the blank tax_year will be thought of as the 'Current' record
d_assr       := ln_propertyv2.File_Assessment(trim(tax_year)='' or (tax_year<>'' and tax_year between '1950' and (string)((integer)ut.GetDate[1..4]+1)));
d_srch       := ln_propertyv2.File_Search_DID(lname<>'',prim_range<>'',prim_name<>'',zip<>'',source_code in ['BP','OP']);//Removed DID<>0

r_slim_assr := record
 string12 ln_fares_id;
 string4  tax_year;
end;

r_slim_srch := record
 string12 ln_fares_id;
 string12 did;
 string20 lname;
 string10 prim_range;
 string2  predir;
 string28 prim_name;
 string2  postdir;
 string8  sec_range;
 string2  st;
 string5  zip;
end;

r_slim_assr t_slim_assr(d_assr l) := transform
 self := l;
end;

r_slim_srch t_slim_srch(d_srch l) := transform
 self.did := intformat(l.did,12,1);
 self     := l;
end;

d_slim_assr := distribute(dedup(project(d_assr,t_slim_assr(left)),ln_fares_id,tax_year,all),hash(ln_fares_id));
d_slim_srch := distribute(dedup(project(d_srch,t_slim_srch(left)),ln_fares_id,lname,did,prim_range,prim_name,sec_range,zip,all),hash(ln_fares_id));

r_add_tax_year := record
 r_slim_srch;
 string4 tax_year;
end;

r_add_tax_year t_add_tax_year(d_slim_assr l, r_slim_srch r) := transform
 self := l;
 self := r;
end;
							
d_srch_with_tax_year := join(d_slim_assr,d_slim_srch,
                             left.ln_fares_id=right.ln_fares_id,
							 t_add_tax_year(left,right),local
							);

p1 := dedup(d_srch_with_tax_year,all);

r1 := record
 string12 did;
 string20 lname;
 string4  tax_year;
 string10 prim_range;
 string2  predir;
 string28 prim_name;
 string2  postdir;
 string8  sec_range;
 string2  st;
 string5  zip;
end;

r1 t_setup(p1 l) := transform
 self := l;
end;

p2 := project(p1,t_setup(left));

p2_dist := distribute(p2,hash(prim_range,predir,prim_name,postdir,sec_range,st,zip));
p2_sort := sort      (p2_dist,prim_range,predir,prim_name,postdir,sec_range,st,zip,-tax_year,local);

r1 t_dunno(p2_sort l, p2_sort r) := transform
 
 v_true := if(l.tax_year>r.tax_year,true,false);
 
 self.lname    := if(v_true,l.lname,r.lname);
 self.did      := if(v_true,l.did,r.did);
 self.tax_year := if(v_true,l.tax_year,r.tax_year);
 self          := l;
end;

r1_rollup := rollup(p2_sort,
                         (left.prim_range =right.prim_range and
						  left.predir     =right.predir     and
						  left.prim_name  =right.prim_name  and
						  left.postdir    =right.postdir    and
						  left.sec_range  =right.sec_range  and
						  left.st         =right.st         and
						  left.zip        =right.zip
						 ),
						 t_dunno(left,right),
						 local
						);
						
r1_rollup_dist := distribute(r1_rollup,hash(prim_range,predir,prim_name,postdir,sec_range,st,zip));
r1_rollup_sort := sort      (r1_rollup_dist,prim_range,predir,prim_name,postdir,sec_range,st,zip,local);

r1 t_get_all(p2_sort l, r1_rollup_sort r) := transform
 self := l;
end;

r1_join := join(p2_sort,r1_rollup_sort,
                     (left.prim_range =right.prim_range and
					  left.predir     =right.predir     and
					  left.prim_name  =right.prim_name  and
					  left.postdir    =right.postdir    and
				      left.sec_range  =right.sec_range  and
					  left.st         =right.st         and
					  left.zip        =right.zip        and
					  left.tax_year   =right.tax_year
					 ),
					 t_get_all(left,right),local,keep(1)
					);

export Get_Current_Property_Assessments := dedup(r1_join,all) : persist('~thor_dell400_2::persist::fds_curr_assr');