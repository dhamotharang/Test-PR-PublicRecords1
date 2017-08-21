//lift spot verification
d_dob:=dedup(sort(distributed(evaluation_data.idv_base(src='2')	,hash(did)),did,-clean_dob,local),did,local);
h_dob:=dedup(sort(distributed(header.File_Headers				,hash(did)),did,-dob,local),did,local);

doblift:=join(	 h_dob(dob=0)
				,d_dob(clean_dob<>'')
				,left.did=right.did
				,transform({ d_dob.did
							,d_dob.clean_dob}
								,self:=right)
				,lookup
				,local);
output(		doblift,named('dob_LIFT_sample'));
output(count(doblift),named('dob_LIFT'));

d_ssn:=dedup(sort(distributed(evaluation_data.idv_base(src='2')	,hash(did)),did,-clean_ssn,local),did,local);
h_ssn:=dedup(sort(distributed(header.File_Headers				,hash(did)),did,-ssn,local),did,local);

ssnlift:=join(	 h_ssn(ssn='')
				,d_ssn(clean_ssn<>'')
				,left.did=right.did
				,transform({ d_ssn.did
							,d_ssn.clean_ssn}
								,self:=right)
				,lookup
				,local);
output(		ssnlift,named('ssn_LIFT_sample'));
output(count(ssnlift),named('ssn_LIFT'));



// dd:=distribute(evaluation_data.idv_base(did>0),hash(did));
// d:=dedup(sort(dd,did,src,local),did,src,local);

// r:=	{
	// d.src
	// ,src_desc:=evaluation_data.layouts_idv.translateSource(d.src)
	// ,CORE			:=sum(group,if(d.ind='CORE',1,0))
	// ,CORE_pct		:=round((sum(group,if(d.ind='CORE',1,0))/count(group)) * 100)
	// ,DEAD			:=sum(group,if(d.ind='DEAD',1,0))
	// ,DEAD_pct		:=round((sum(group,if(d.ind='DEAD',1,0))/count(group)) * 100)
	// ,H_MERGE		:=sum(group,if(d.ind='H_MERGE',1,0))
	// ,H_MERGE_pct	:=round((sum(group,if(d.ind='H_MERGE',1,0))/count(group)) * 100)
	// ,INACTIVE		:=sum(group,if(d.ind='INACTIVE',1,0))
	// ,INACTIVE_pct	:=round((sum(group,if(d.ind='INACTIVE',1,0))/count(group)) * 100)
	// ,C_MERGE		:=sum(group,if(d.ind='C_MERGE',1,0))
	// ,C_MERGE_pct	:=round((sum(group,if(d.ind='C_MERGE',1,0))/count(group)) * 100)
	// ,AMBIG			:=sum(group,if(d.ind='AMBIG',1,0))
	// ,AMBIG_pct		:=round((sum(group,if(d.ind='AMBIG',1,0))/count(group)) * 100)
	// ,NO_SSN			:=sum(group,if(d.ind='NO_SSN',1,0))
	// ,NO_SSN_pct		:=round((sum(group,if(d.ind='NO_SSN',1,0))/count(group)) * 100)
	// ,NOISE			:=sum(group,if(d.ind='NOISE',1,0))
	// ,NOISE_pct		:=round((sum(group,if(d.ind='NOISE',1,0))/count(group)) * 100)
	// ,Total			:=count(group)
	// };
// t:=table(d,r,src,few,local);
// output(t);

// d:=evaluation_data.idv_base;
// r:=	{
	// d.src
	// ,src_desc:=evaluation_data.layouts_idv.translateSource(d.src)
	// ,Total			:=count(group)
	// ,ADL			:=sum(group,if(d.did>0,1,0))
	// ,ADL_pct		:=round((sum(group,if(d.did>0,1,0))/count(group)) * 100)
	// ,not_ADL		:=sum(group,if(d.did=0,1,0))
	// ,not_ADL_pct	:=round((sum(group,if(d.did=0,1,0))/count(group)) * 100)
	// };
// t:=table(d,r,src,few,local);
// output(t);

// dd:=distribute(evaluation_data.idv_base(did>0),hash(did));

// d:=dedup(sort(dd,did,src,local),did,src,local);
// output(table(d,{src,count(group)},src,few,local),named('within_src'));

// d1:=dedup(sort(dd,did,src,local),did,local);
// output(table(d1,{src,count(group)},src,few,local),named('across_srcs'));

// d:=evaluation_data.idv_base(did>0);
// aherzberg_stuff.Mac_Header_Comparison	(
										// evaluation_data.layouts_idv.base
										// , d
										// , did
										// , fname
										// , lname
										// , prim_range
										// , prim_name
										// , sec_range
										// , zip
										// , true
										// , clean_dob
										// , true
										// , clean_ssn
										// );

// d1:=evaluation_data.idv_base(did>0,src='1');
// aherzberg_stuff.Mac_Header_Comparison	(
										// evaluation_data.layouts_idv.base
										// , d1
										// , did
										// , fname
										// , lname
										// , prim_range
										// , prim_name
										// , sec_range
										// , zip
										// , true
										// , clean_dob
										// , true
										// , clean_ssn
										// );

// d2:=evaluation_data.idv_base(did>0,src='2');
// aherzberg_stuff.Mac_Header_Comparison	(
										// 'impulse_marketing'
										// , evaluation_data.layouts_idv.base
										// , d2
										// , did
										// , fname
										// , lname
										// , prim_range
										// , prim_name
										// , sec_range
										// , zip
										// , true
										// , clean_dob
										// , true
										// , clean_ssn
										// );


// d3:=evaluation_data.idv_base(did>0,src='3');
// aherzberg_stuff.Mac_Header_Comparison	(
										// 'infoDirect'
										// , evaluation_data.layouts_idv.base
										// , d3
										// , did
										// , fname
										// , lname
										// , prim_range
										// , prim_name
										// , sec_range
										// , zip
										// , true
										// , clean_dob
										// , true
										// , clean_ssn
										// );

// d5:=evaluation_data.idv_base(did>0,src='5');
// aherzberg_stuff.Mac_Header_Comparison	(
										// 'teletrack'
										// , evaluation_data.layouts_idv.base
										// , d5
										// , did
										// , fname
										// , lname
										// , prim_range
										// , prim_name
										// , sec_range
										// , zip
										// , true
										// , clean_dob
										// , true
										// , clean_ssn
										// );


// d6:=evaluation_data.idv_base(did>0,src='6');
// aherzberg_stuff.Mac_Header_Comparison	(
										// 'Segment_52'
										// , evaluation_data.layouts_idv.base
										// , d6
										// , did
										// , fname
										// , lname
										// , prim_range
										// , prim_name
										// , sec_range
										// , zip
										// , true
										// , clean_dob
										// , true
										// , clean_ssn
										// );


// d7:=evaluation_data.idv_base(did>0,src='7');
// aherzberg_stuff.Mac_Header_Comparison	(
										// 'Segment_53'
										// , evaluation_data.layouts_idv.base
										// , d7
										// , did
										// , fname
										// , lname
										// , prim_range
										// , prim_name
										// , sec_range
										// , zip
										// , true
										// , clean_dob
										// , true
										// , clean_ssn
										// );


// d8:=evaluation_data.idv_base(did>0,src='8');
// aherzberg_stuff.Mac_Header_Comparison	(
										// 'Segment_54'
										// , evaluation_data.layouts_idv.base
										// , d8
										// , did
										// , fname
										// , lname
										// , prim_range
										// , prim_name
										// , sec_range
										// , zip
										// , true
										// , clean_dob
										// , true
										// , clean_ssn
										// );


// d9:=evaluation_data.idv_base(did>0,src='9');
// aherzberg_stuff.Mac_Header_Comparison	(
										// 'Segment_56'
										// , evaluation_data.layouts_idv.base
										// , d9
										// , did
										// , fname
										// , lname
										// , prim_range
										// , prim_name
										// , sec_range
										// , zip
										// , true
										// , clean_dob
										// , true
										// , clean_ssn
										// );


// d0:=evaluation_data.idv_base(did>0,src='0');
// aherzberg_stuff.Mac_Header_Comparison	(
										// 'Segment_61'
										// , evaluation_data.layouts_idv.base
										// , d0
										// , did
										// , fname
										// , lname
										// , prim_range
										// , prim_name
										// , sec_range
										// , zip
										// , true
										// , clean_dob
										// , true
										// , clean_ssn
										// );


// da:=evaluation_data.idv_base(did>0,src='A');
// aherzberg_stuff.Mac_Header_Comparison	(
										// 'Segment_62'
										// , evaluation_data.layouts_idv.base
										// , da
										// , did
										// , fname
										// , lname
										// , prim_range
										// , prim_name
										// , sec_range
										// , zip
										// , true
										// , clean_dob
										// , true
										// , clean_ssn
										// );


// db:=evaluation_data.idv_base(did>0,src='B');
// aherzberg_stuff.Mac_Header_Comparison	(
										// 'Segment_68'
										// , evaluation_data.layouts_idv.base
										// , db
										// , did
										// , fname
										// , lname
										// , prim_range
										// , prim_name
										// , sec_range
										// , zip
										// , true
										// , clean_dob
										// , true
										// , clean_ssn
										// );

