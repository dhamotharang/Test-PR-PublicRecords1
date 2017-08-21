//W20070925-130449

import header;

//within the header, death records seem to provide multiple SSN's for a DID
//this identifies those SSN pairs and compares to other sources in an attempt
//to catch possible flipping or single-value inaccuracies

export fn_ssn_mismatch_within_a_source(dataset(recordof(header.layout_header)) in_hdr) := function

ds := in_hdr(ssn<>'');

r0 := record
 string2   src;
 unsigned6 did;
 string9   ssn;
end;

r0 t0(ds le) := transform
 self := le;
end;

p0 := project(ds,t0(left));

death_src := dedup(sort(distribute(p0(src='DE'), hash(did,ssn)),did,ssn,local),did,ssn,local);
other_src0 := dedup(sort(distribute(p0(src!='DE'),hash(did,ssn)),did,ssn,local),did,ssn,local) : persist('jtrost_header_death_recs');

r1 := record
 unsigned6 did;
 string9   ssn1;
 string9   ssn2;
end;

r1 t_j1(death_src le, death_src ri) := transform
 self.did := le.did;
 self.ssn1 := le.ssn;
 self.ssn2 := ri.ssn;
end;

j1 := join(death_src,death_src,
           left.did=right.did and left.ssn>right.ssn,
		   t_j1(left,right)
		  );

j1_dupd0 := dedup(j1,record) : persist('jtrost_ssn_diffs_in_deaths');

j1_dupd00 := distribute(j1_dupd0,hash(did));
other_src := distribute(other_src0,hash(did));

r20 := record
 j1_dupd00;
 boolean other_src_exist_with_ssn;
 boolean ssn1_found_in_other_sources := false;
 boolean ssn2_found_in_other_sources := false;
end;

r20 t_other_sources(j1_dupd00 le, other_src ri) := transform
 self.other_src_exist_with_ssn := if(le.did=ri.did,true,false);			//	<- PROBLEM! this holds true even
 self.ssn1_found_in_other_sources := if(le.ssn1=ri.ssn,true,false);		//	when neither left ssn1 nor ssn2
 //self.ssn2_found_in_other_sources := if(le.ssn2=ri.ssn,true,false);	//	is eq. to  right.ssn producing
 self := le;															//	invalid results of the kind: t,f,f
end;																	//	and insidentally correct ie. f,f,f,
																		//	when only 'DE' source exist.


j1_dupd := join(j1_dupd00,other_src,
                left.did=right.did,
				t_other_sources(left,right),
				left outer, local
			   );

r20 t_other_sources2(j1_dupd le, other_src ri) := transform
 //self.ssn1_found_in_other_sources := if(le.ssn1=ri.ssn,true,false);
 self.ssn2_found_in_other_sources := if(le.ssn2=ri.ssn,true,false);
 self := le;
end;

j1_dupd2 := join(j1_dupd,other_src,
                left.did=right.did,
				t_other_sources2(left,right),
				left outer, local
			   );

r20 t_rollup(j1_dupd2 le, j1_dupd2 ri) := transform
 self.ssn1_found_in_other_sources := if(le.ssn1_found_in_other_sources=true,le.ssn1_found_in_other_sources,ri.ssn1_found_in_other_sources);
 self.ssn2_found_in_other_sources := if(le.ssn2_found_in_other_sources=true,le.ssn2_found_in_other_sources,ri.ssn2_found_in_other_sources);
 self := le;
end;

p_rollup := rollup(j1_dupd2,left.did=right.did and left.ssn1=right.ssn1 and left.ssn2=right.ssn2,t_rollup(left,right),local);

r2 := record
 p_rollup;
 string9 pos_diff;
end;

r2 t_find_diff(p_rollup le) := transform
 
 boolean v1 := le.ssn1[1]=le.ssn2[1];
 boolean v2 := le.ssn1[2]=le.ssn2[2];
 boolean v3 := le.ssn1[3]=le.ssn2[3];
 boolean v4 := le.ssn1[4]=le.ssn2[4];
 boolean v5 := le.ssn1[5]=le.ssn2[5];
 boolean v6 := le.ssn1[6]=le.ssn2[6];
 boolean v7 := le.ssn1[7]=le.ssn2[7];
 boolean v8 := le.ssn1[8]=le.ssn2[8];
 boolean v9 := le.ssn1[9]=le.ssn2[9];
 
 string1 v1a := if(v1=true,' ','1');
 string1 v2a := if(v2=true,' ','2');
 string1 v3a := if(v3=true,' ','3');
 string1 v4a := if(v4=true,' ','4');
 string1 v5a := if(v5=true,' ','5');
 string1 v6a := if(v6=true,' ','6');
 string1 v7a := if(v7=true,' ','7');
 string1 v8a := if(v8=true,' ','8');
 string1 v9a := if(v9=true,' ','9');
 
 self.pos_diff := v1a
                +v2a
				+v3a
				+v4a
				+v5a
				+v6a
				+v7a
				+v8a
				+v9a
				;
 
 self    := le;
end;

p_find_diff := project(p_rollup,t_find_diff(left));

return p_find_diff;

end;