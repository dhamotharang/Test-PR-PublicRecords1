/* ************************

//\/\/\/\/\/\/\/\   STEP 1	run ssn diffs and  PERSIST


//x := JBello_stuff.fn_ssn_mismatch_within_a_source(header.File_Headers) : persist('~thor_data400::persist::jbello_death_final_v1');
x := JBello_stuff.fn_ssn_mismatch_within_a_source_modifyed(header.File_Headers) : persist('~thor_data400::persist::jbello_death_final');
output(x);



//\/\/\/\/\/\/\/\   STEP 2	obtain all DE recs, dedup, and PERSIST

*/

/*
import header;

ds := header.File_Headers(ssn<>'');

DE	:=	ds(src='DE');

r := record
 string2   src;
 unsigned6 did;
 string9   ssn;
end;


r t0(ds le) := transform
 self := le;
end;

p0 := project(ds,t0(left));

x := dedup(sort(distribute(p0(src='DE'), hash(did,ssn)),did,ssn,local),did,ssn,local) : persist('~thor_data400::persist::jbello_DE');

output(x);


*/

//\/\/\/\/\/\/\/\   STEP 3	count DE and PERSIST

/*
r := record
	string2		src;
	unsigned6	did;
	string9		ssn;
end;

DE := dataset('~thor_data400::persist::jbello_DE',r,flat);

r1 := record
	did						:=	DE.did;
	distinct_ssn_cnt		:=	count(group);
	distinct_conbinations	:=	map(count(group)=10	=>	45,	//	C = n!/(r!(n-r)!) where n=number of distinct
									count(group)=9	=>	36,	//	ssn in one did and r=units in a combination
									count(group)=8	=>	28,	//	set.
									count(group)=7	=>	21,
									count(group)=6	=>	15,
									count(group)=5	=>	10,
									count(group)=4	=>	6,
									count(group)=3	=>	3,
									count(group)=2	=>	1,
									0
									);
end;

x := distribute(table(DE,r1,did),hash(did)) : persist('~thor_data400::persist::jbello_DE_cnt');

output(x);


*/

//\/\/\/\/\/\/\/\   STEP 4	choose sets to validate

/*


r := record
	unsigned6	did;
	integer		distinct_ssn_cnt;
	integer		distinct_conbinations;
end;

x := dataset('~thor_data400::persist::jbello_DE_cnt',r,flat);

//output(x(distinct_conbinations>0));

r1 := record
	distinct_ssn_cnt	:=	x.distinct_ssn_cnt;
	cnt					:=	count(group);
end;
xo:=table(x,r1,distinct_ssn_cnt);
output(xo(distinct_ssn_cnt=2));

//output(sort(x,distinct_ssn_cnt));


*/

//\/\/\/\/\/\/\/\   STEP 5	validate


/*

r := record
 unsigned6	did;
 string9	ssn1;
 string9	ssn2;
 boolean	other_src_exist_with_ssn;
 boolean	ssn1_found_in_other_sources;
 boolean	ssn2_found_in_other_sources;
 string9	pos_diff;
end;

//x := dataset('~thor_data400::persist::jbello_DE_pairs',r,flat);
x := dataset('~thor_data400::persist::jbello_death_final',r,flat);
//output	(x
//			(	(other_src_exist_with_ssn=true and (ssn1_found_in_other_sources=false and ssn2_found_in_other_sources=false)) or
//				(other_src_exist_with_ssn=false and (ssn1_found_in_other_sources=true or ssn2_found_in_other_sources=true))
//			)
//		);

output(x(	other_src_exist_with_ssn=true and
			(ssn1_found_in_other_sources=false or ssn2_found_in_other_sources=false) and
			(length(trim(pos_diff,left,right))=1)),{did,
													n1:=ssn1[trim(pos_diff,left,right)],
													n2:=ssn2[trim(pos_diff,left,right)],
													});


//output(x(did IN [2611080643
//,1229852085
//,1782206359
//,189607478
//,1646753223
//,2710445301
//,1978939754
//,1756944557
//,2727745471
//,944484551
//]));

//y := dataset('~thor_data400::persist::jbello_death_final_v1',r,flat);
//output	(y
//			(	(other_src_exist_with_ssn=true and (ssn1_found_in_other_sources=false and ssn2_found_in_other_sources=false)) or
//				(other_src_exist_with_ssn=false and (ssn1_found_in_other_sources=true or ssn2_found_in_other_sources=true))
//			)
//		);

//output(y(did IN [2611080643
//,1229852085
//,1782206359
//,189607478
//,1646753223
//,2710445301
//,1978939754
//,1756944557
//,2727745471
//,944484551
//]));


*/



/*
r := record
	unsigned6	did;
	string9		ssn1;
	string9		ssn2;
	boolean		other_src_exist_with_ssn;
	boolean		ssn1_found_in_other_sources;
	boolean		ssn2_found_in_other_sources;
	string9		pos_diff;
end;

v1 := dataset('~thor_data400::persist::jbello_death_final_v1',r,flat);
v2 := dataset('~thor_data400::persist::jbello_death_final',r,flat);

rOUT := record
	string2		version := '';
	r;
end;
rOUT crossCHECK(r le,string2 ver)	:= transform
	self.version	:=	ver;
	self			:=	le;
end;

x1	:=	project(distribute(v1,hash(did,ssn1)),crossCHECK(left,'v1'));
x2	:=	project(distribute(v2,hash(did,ssn1)),crossCHECK(left,'v2'));
x	:=	merge(	sort(x1,	did,
							ssn1,
							ssn2,local),
				sort(x2,	did,
							ssn1,
							ssn2,local)) : persist('~thor_data400::persist::jbello_death_final_v1v2_merged');

output(x);
*/



/*
r := record
	string2		version;
	unsigned6	did;
	string9		ssn1;
	string9		ssn2;
	boolean		other_src_exist_with_ssn;
	boolean		ssn1_found_in_other_sources;
	boolean		ssn2_found_in_other_sources;
	string9		pos_diff;
end;

x := dataset('~thor_data400::persist::jbello_death_final_v1v2_merged',r,flat);

rr	:= record
	integer		cnt							:=	1;
	x;
end;

xx:=table(x,rr);

rr Xform(rr le, rr ri) := transform
	self.cnt	:=	le.cnt	+	1;
	self		:=	le;
end;

xo	:=	rollup	(xx,
				left.did							=	right.did							and
				left.ssn1							=	right.ssn1							and
				left.ssn2							=	right.ssn2						,//	and
//				left.other_src_exist_with_ssn		=	right.other_src_exist_with_ssn		and
//				left.ssn1_found_in_other_sources	=	right.ssn1_found_in_other_sources	and
//				left.ssn2_found_in_other_sources	=	right.ssn2_found_in_other_sources	and
//				left.pos_diff						=	right.pos_diff,
				Xform(left,right),local
				);

output(xo(cnt>2));

*/

/*


rx := record
	unsigned6	did;
	integer		distinct_ssn_cnt;
	integer		distinct_conbinations;
end;
x := dataset('~thor_data400::persist::jbello_DE_cnt',rx,flat);


ry := record
	unsigned6	did;
	string9		ssn1;
	string9		ssn2;
	boolean		other_src_exist_with_ssn;
	boolean		ssn1_found_in_other_sources;
	boolean		ssn2_found_in_other_sources;
	string9		pos_diff;
end;
y := dataset('~thor_data400::persist::jbello_death_final',ry,flat);


xy := record
	ry;
	integer	p_diff;
	rx.distinct_ssn_cnt;
	rx.distinct_conbinations;
	integer	intersect_ratio;
end;

xy join_xy(x l, y r) := transform

	self.did							:= r.did;
	self.p_diff							:= length(regexreplace(' ',r.pos_diff,''));

	string1	lv1							:= if(r.pos_diff[1]<>' ',r.ssn1[1],' ');
	string1	lv2							:= if(r.pos_diff[2]<>' ',r.ssn1[2],' ');
	string1	lv3							:= if(r.pos_diff[3]<>' ',r.ssn1[3],' ');
	string1	lv4							:= if(r.pos_diff[4]<>' ',r.ssn1[4],' ');
	string1	lv5							:= if(r.pos_diff[5]<>' ',r.ssn1[5],' ');
	string1	lv6							:= if(r.pos_diff[6]<>' ',r.ssn1[6],' ');
	string1	lv7							:= if(r.pos_diff[7]<>' ',r.ssn1[7],' ');
	string1	lv8							:= if(r.pos_diff[8]<>' ',r.ssn1[8],' ');
	string1	lv9							:= if(r.pos_diff[9]<>' ',r.ssn1[9],' ');

	self.ssn1							:= lv1+lv2+lv3+lv4+lv5+lv6+lv7+lv8+lv9;

	string1	rv1							:= if(r.pos_diff[1]<>' ',r.ssn2[1],' ');
	string1	rv2							:= if(r.pos_diff[2]<>' ',r.ssn2[2],' ');
	string1	rv3							:= if(r.pos_diff[3]<>' ',r.ssn2[3],' ');
	string1	rv4							:= if(r.pos_diff[4]<>' ',r.ssn2[4],' ');
	string1	rv5							:= if(r.pos_diff[5]<>' ',r.ssn2[5],' ');
	string1	rv6							:= if(r.pos_diff[6]<>' ',r.ssn2[6],' ');
	string1	rv7							:= if(r.pos_diff[7]<>' ',r.ssn2[7],' ');
	string1	rv8							:= if(r.pos_diff[8]<>' ',r.ssn2[8],' ');
	string1	rv9							:= if(r.pos_diff[9]<>' ',r.ssn2[9],' ');

	self.ssn2							:= rv1+rv2+rv3+rv4+rv5+rv6+rv7+rv8+rv9;

	self.other_src_exist_with_ssn		:= r.other_src_exist_with_ssn;
	self.ssn1_found_in_other_sources	:= r.ssn1_found_in_other_sources;
	self.ssn2_found_in_other_sources	:= r.ssn2_found_in_other_sources;
	self.pos_diff						:= r.pos_diff;

	self.distinct_ssn_cnt				:= l.distinct_ssn_cnt;
	self.distinct_conbinations			:= l.distinct_conbinations;

	string	b1	:=	'[^'+lv1+']';
	string	b2	:=	'[^'+lv2+']';
	string	b3	:=	'[^'+lv3+']';
	string	b4	:=	'[^'+lv4+']';
	string	b5	:=	'[^'+lv5+']';
	string	b6	:=	'[^'+lv6+']';
	string	b7	:=	'[^'+lv7+']';
	string	b8	:=	'[^'+lv8+']';
	string	b9	:=	'[^'+lv9+']';
	self.intersect_ratio				:=	(if(lv1<>' '
												and regexfind(lv1,self.ssn2)
												and length(trim(regexreplace(b1,self.ssn1,''),left,right))<=length(trim(regexreplace(b1,self.ssn2,''),left,right))
												,1,if(lv1<>' '
														and regexfind(lv1,self.ssn2),
														1/(abs(length(trim(regexreplace(b1,self.ssn1,''),left,right))-length(trim(regexreplace(b1,self.ssn2,''),left,right)))+1),0))+
											if(lv2<>' '
												and regexfind(lv2,self.ssn2)
												and length(trim(regexreplace(b2,self.ssn1,''),left,right))<=length(trim(regexreplace(b2,self.ssn2,''),left,right))
												,1,if(lv2<>' '
														and regexfind(lv2,self.ssn2),
														1/(abs(length(trim(regexreplace(b2,self.ssn1,''),left,right))-length(trim(regexreplace(b2,self.ssn2,''),left,right)))+1),0))+
											if(lv3<>' '
												and regexfind(lv3,self.ssn2)
												and length(trim(regexreplace(b3,self.ssn1,''),left,right))<=length(trim(regexreplace(b3,self.ssn2,''),left,right))
												,1,if(lv3<>' '
														and regexfind(lv3,self.ssn2),
														1/(abs(length(trim(regexreplace(b3,self.ssn1,''),left,right))-length(trim(regexreplace(b3,self.ssn2,''),left,right)))+1),0))+
											if(lv4<>' '
												and regexfind(lv4,self.ssn2)
												and length(trim(regexreplace(b4,self.ssn1,''),left,right))<=length(trim(regexreplace(b4,self.ssn2,''),left,right))
												,1,if(lv4<>' '
														and regexfind(lv4,self.ssn2),
														1/(abs(length(trim(regexreplace(b4,self.ssn1,''),left,right))-length(trim(regexreplace(b4,self.ssn2,''),left,right)))+1),0))+
											if(lv5<>' '
												and regexfind(lv5,self.ssn2)
												and length(trim(regexreplace(b5,self.ssn1,''),left,right))<=length(trim(regexreplace(b5,self.ssn2,''),left,right))
												,1,if(lv5<>' '
														and regexfind(lv5,self.ssn2),
														1/(abs(length(trim(regexreplace(b5,self.ssn1,''),left,right))-length(trim(regexreplace(b5,self.ssn2,''),left,right)))+1),0))+
											if(lv6<>' '
												and regexfind(lv6,self.ssn2)
												and length(trim(regexreplace(b6,self.ssn1,''),left,right))<=length(trim(regexreplace(b6,self.ssn2,''),left,right))
												,1,if(lv6<>' '
														and regexfind(lv6,self.ssn2),
														1/(abs(length(trim(regexreplace(b6,self.ssn1,''),left,right))-length(trim(regexreplace(b6,self.ssn2,''),left,right)))+1),0))+
											if(lv7<>' '
												and regexfind(lv7,self.ssn2)
												and length(trim(regexreplace(b7,self.ssn1,''),left,right))<=length(trim(regexreplace(b7,self.ssn2,''),left,right))
												,1,if(lv7<>' '
														and regexfind(lv7,self.ssn2),
														1/(abs(length(trim(regexreplace(b7,self.ssn1,''),left,right))-length(trim(regexreplace(b7,self.ssn2,''),left,right)))+1),0))+
											if(lv8<>' '
												and regexfind(lv8,self.ssn2)
												and length(trim(regexreplace(b8,self.ssn1,''),left,right))<=length(trim(regexreplace(b8,self.ssn2,''),left,right))
												,1,if(lv8<>' '
														and regexfind(lv8,self.ssn2),
														1/(abs(length(trim(regexreplace(b8,self.ssn1,''),left,right))-length(trim(regexreplace(b8,self.ssn2,''),left,right)))+1),0))+
											if(lv9<>' '
												and regexfind(lv9,self.ssn2)
												and length(trim(regexreplace(b9,self.ssn1,''),left,right))<=length(trim(regexreplace(b9,self.ssn2,''),left,right))
												,1,if(lv9<>' '
														and regexfind(lv9,self.ssn2),
														1/(abs(length(trim(regexreplace(b9,self.ssn1,''),left,right))-length(trim(regexreplace(b9,self.ssn2,''),left,right)))+1),0))) /
											length(regexreplace(' ',trim(r.pos_diff,left,right),''))*100;

	self								:= l;
end;

joined_xy := join(	x, y,
						left.did=right.did and
						right.other_src_exist_with_ssn=true and
						(right.ssn1_found_in_other_sources=false or right.ssn2_found_in_other_sources=false)
//						and left.distinct_ssn_cnt=2,
					,join_xy(left,right),
					inner,
					local
					) : persist('~thor_data400::persist::jbello_death_final_plus');


output(joined_xy(
					length(regexreplace(' ',pos_diff,'')) in [3,4,5,6,7,8,9] and intersect_ratio>90// and	// digits
		//			length(trim(pos_diff,left,right))=6			// spread
				)
		);


*/

//62413	/ 94929	= 0.65747032

//W20071228-152133
//1	1	53.400963	50693
//2	2	11.110409	10547
//2	3	0.565686	537
//2	4	0.113769	108
//2	5	0.084274	80
//2	6	0.061098	58
//2	7	0.056885	54
//2	8	0.018962	18
//2	9	0.007374	7
//3	3	1.196684	1136
//3	4	0.365536	347
//3	5	0.080060	76
//3	6	0.053724	51
//3	7	0.045297	43
//3	8	0.024229	23
//4	4	1.363124	1294
//4	5	0.211737	201
//4	6	0.212791	202
//4	7	0.245447	233
//4	8	0.058991	56
//4	9	0.007374	7
//5	5	0.593075	563
//5	6	0.902780	857
//5	7	1.302026	1236
//5	8	0.333934	317
//5	9	0.035816	34
//6	6	1.558007	1479
//6	7	3.715408	3527
//6	8	1.625425	1543
//6	9	0.284423	270
//7	7	5.039556	4784
//7	8	3.897650	3700
//7	9	1.196684	1136
//8	8	4.627669	4393
//8	9	2.711500	2574
//9	9	2.891635	2745





/*

#workunit('name', 'test')


r := record
	unsigned6	did;
	string9		ssn1;
	string9		ssn2;
	boolean		other_src_exist_with_ssn;
	boolean		ssn1_found_in_other_sources;
	boolean		ssn2_found_in_other_sources;
	string9		pos_diff;
	integer		distinct_ssn_cnt;
	integer		distinct_conbinations;
	real		intersect_ratio;
end;

x := dataset('~thor_data400::persist::jbello_death_final_plus',r,flat);

r1 := record
	digit_cnt		:=	length(regexreplace(' ',trim(x.pos_diff,left,right),''));								// none adjacent digits
	digit_spread	:=	length(trim(x.pos_diff,left,right));													// adjacent digits
	pct				:=	count(group)/count(x)*100;
	cnt				:=	count(group);
end;

xo:=table(x(
//			length(trim(pos_diff,left,right))=length(regexreplace(' ',trim(pos_diff,left,right),'')) and	// adjacent digits
//			length(trim(pos_diff,left,right))>length(regexreplace(' ',trim(pos_diff,left,right),'')) and	// none adjacent digits
//			other_src_exist_with_ssn=true and
//			(ssn1_found_in_other_sources=false or ssn2_found_in_other_sources=false) and
//			distinct_ssn_cnt=2
//			),r1,length(trim(pos_diff,left,right)));														// adjacent digits
//			),r1,length(regexreplace(' ',trim(pos_diff,left,right),'')));									// none adjacent digits
			),r1,length(regexreplace(' ',trim(pos_diff,left,right),'')),length(trim(x.pos_diff,left,right)));


output(xo);



*/




r := record
	unsigned6	did;
	string9		ssn1;
	string9		ssn2;
	boolean		other_src_exist_with_ssn;
	boolean		ssn1_found_in_other_sources;
	boolean		ssn2_found_in_other_sources;
	string9		pos_diff;
	integer		p_diff;
	integer		distinct_ssn_cnt;
	integer		distinct_conbinations;
	integer		intersect_ratio;
end;

x := dataset('~thor_data400::persist::jbello_death_final_plus',{r,UNSIGNED8 RecPos{virtual(FilePosition)}},flat);


buildindex (x,{p_diff
				,distinct_ssn_cnt
				,distinct_conbinations
				,intersect_ratio
				,RecPos},
			'~thor_data400::persist::key::jbello_death_final_plus');

output(x);





















