import ut,bizlinkfull;

pid_int := 
[130896780,10781487400,130333837];
// [
// 36213397,// - proxid for Hunt Valley Courtyard
// 93042168 //- proxid for Marriott International

// ,4080366 //a couple where wi was lost with my most recent change
// ,5320033
// ,6766862
// ,11458754
// ,1675328
// ,2107	//id integrity issue here and the one above
// ,11124
// ,154459875

// ,5442696,	179373455//id integrity issue

// ,401198,	395358,	377192
// 18106401,	17895560, 13531832, 23058159
// ];


EXPORT Functions := 
MODULE

shared InRec 	:= Layouts.inrec;
shared r1 		:= Layouts.r1;
export r2 		:= Layouts.r2;
shared lgidr 	:= Layouts.lgidr;	



export RemoveConflict(dataset(Inrec) pd) := 
FUNCTION

/*
import lksd;
myproxids := [53864144,687911161,396173084,396104249,
804867490,4993013
,16314326 //should probably still have LNCA preferred
//these two from orig conflict bug 132519
,45770811//no hrchy
,45789692
];

myduns := 
['786679779' , '170052062' ,'829998145' , '181576372', '158134655',	'884114609'];

mydunsi := 
[829998145 , 181576372, 158134655	,884114609];
*/

	tr := record
		Inrec;
		boolean IsParent := false;
		boolean HasParent := false;
		boolean HasFamily := false;
		unsigned2 srcRank := 99;
	end;

	wHasParent :=
	project(
		pd,
		transform(
			tr,
			self.HasParent := (left.parent_id > 0 and left.parent_id <> left.id) or (left.ultimate_id > 0 and left.ultimate_id <> left.id),
			self.srcRank := Constants.Sources.PreferenceRanking(left.src),
			self := left
		)
	);
	
	wIsParent :=
	join(
		wHasParent(id > 0),
		pd(parent_id > 0),
		left.id = right.parent_id
		and left.src = right.src,
		transform(
			tr,
			self_IsParent := right.parent_id > 0;
			self.IsParent := self_IsParent;
			self.HasFamily := self_IsParent or left.HasParent;
			self := left
		),
		keep(1),
		hash,
		left outer
	);

// mywIsParent := wIsParent(id in mydunsi or parent_id in mydunsi or ultimate_id in mydunsi or proxid in myproxids);
// lksd.o(mywIsParent);		

	direct_conflict_loser :=
	join(
		wIsParent(proxid > 0),
		wIsParent(proxid > 0), 
		left.proxid = right.proxid and
		left.src <> right.src and		
		(
		 (left.srcRank > right.srcRank and (right.HasFamily or ~left.HasFamily)) OR	//the right src is preferred and (the right source has family or the left doesnt) 
		 (left.srcRank < right.srcRank and (right.HasFamily and ~left.HasFamily))  	//the right src is not preferred but it has family and the left doesnt
		),
		transform(left),
		keep(1),
		hash
	);

// mydirect_conflict_loser := direct_conflict_loser(id in mydunsi or parent_id in mydunsi or ultimate_id in mydunsi or proxid in myproxids);
// lksd.o(mydirect_conflict_loser);
	
	parent_conflict_loser := 
	join(
		pd,
		direct_conflict_loser,
		left.parent_id = right.id and 
		left.src = right.src,
		transform(left),
		hash
	);	
	
	ultimate_conflict_loser := 
	join(
		pd,
		direct_conflict_loser,
		left.ultimate_id = right.id and 
		left.src = right.src,
		transform(left),
		hash
	);		
	
	conflict_loser := dedup(project(direct_conflict_loser, Inrec) + parent_conflict_loser + ultimate_conflict_loser, id, src, all);
		
	clean :=
	join(
		pd,
		conflict_loser,
		left.id = right.id and 
		left.src = right.src,
		transform(left),
		hash,
		left only
	);
	#IF(Debug)
		output(choosen(direct_conflict_loser, 500), named('direct_conflict_loser'));
		output(choosen(parent_conflict_loser, 500), named('parent_conflict_loser'));
		output(choosen(ultimate_conflict_loser, 500), named('ultimate_conflict_loser'));
		output(choosen(conflict_loser, 500), named('conflict_loser'));
		output(choosen(clean, 500), named('clean'));
	#end
	
	//then apply those to parent and ultimate
	
	return clean;

END;

export WithParentsChildren(dataset(Inrec) pd) := 
FUNCTION

	//***** FIND PARENTS, GRANDPARENTS, ETC

	d := distribute(nofold(ungroup(pd)), hash(id));			//d must be distributed for local denorm

	mac(infile, outfile, p_derived_levels_above, pid) := 
	MACRO
		outfile :=
		denormalize(
			distribute(infile(pid > 0), hash(pid)),					//don't need to redistribute every time, but it seems to get optimized out or at least go very very fast
			project(d(id > 0), transform(InRec, self.derived_levels_above := p_derived_levels_above, self := left)),
			// pid > 0 and
			left.pid = right.id
			and left.src = right.src,
			transform(
				r1,
				self.parents := left.parents & right,
				self.derived_levels_from_top := left.derived_levels_from_top + if(right.id > 0, 1, 0),
				self := left
			)
			,local
		) 
		+ infile(pid = 0);
	ENDMACRO;

	// d0 := project(dedup(d, all), transform(r1, self := left, self := []));  //i dont think we need the dedup any more
	d0 := project(d, transform(r1, self := left, self := []));

	mac(d0, d1, 1, parent_id)								
	mac(d1, d2, 2, parents[1].parent_id)
	mac(d2, d3, 3, parents[2].parent_id)
	mac(d3, d4, 4, parents[3].parent_id)
	mac(d4, d5, 5, parents[4].parent_id)
	mac(d5, d6, 6, parents[5].parent_id)
	mac(d6, d7, 7, parents[6].parent_id)
	mac(d7, d8, 8, parents[7].parent_id)
	mac(d8, d9, 9, parents[8].parent_id)
	mac(d9, d10, 10, parents[9].parent_id)
	mac(d10, d11, 11, parents[10].parent_id)
	mac(d11, d12, 12, parents[11].parent_id)
	mac(d12, d13, 13, parents[12].parent_id)
	mac(d13, d14, 14, parents[13].parent_id)
	mac(d14, d15, 15, parents[14].parent_id)
	mac(d15, d16, 16, parents[15].parent_id)
	mac(d16, d17, 17, parents[16].parent_id)
	mac(d17, d18, 18, parents[17].parent_id)
	mac(d18, d19, 19, parents[18].parent_id)
	mac(d19, d20, 20, parents[19].parent_id)
	//see BIPv2_HRCHY_Platform.Constants.max_depth_supported



	jc := d20;


	//***** CALCULATE derived_levels_from_top FOR EACH OF PARENTS
	//***** PARENTS LEVELS FROM TOP := CHILDS LEVELS FROM TOP - PARENTS LEVELS ABOVE CHILD

	InRec tra(InRec l, integer dlft) := transform
		self.derived_levels_from_top := dlft - l.derived_levels_above,
		self := l;
	end;

	r1 tra2(r1 l) := transform
		integer dlft := l.derived_levels_from_top;
		self.parents := project(l.parents, tra(left, dlft));
		self := l;
	end;

	jj := project(jc, tra2(left));

	// output(jj, named('WithParents'));


	//***** 
	//***** FIND CHILDREN
	//***** 
	
	jjc := distribute(project(jj, transform(r2, self := left, self.children := [])), hash(id));

	macc(infile, outfile, p_derived_levels_below) :=
	MACRO

		#uniquename(tra)
		#uniquename(tra2)
		r2 %tra%(r2 le, r2 ri) := transform
			integer dlb := p_derived_levels_below;
			integer ldlft := le.derived_levels_from_top;
			self.children := 
			sort(	//sort is really just for readability when viewing results
				le.children 		//my children already gathered
				+ project(ri.children, 	transform(InRec, self.derived_levels_below := left.derived_levels_from_top - ldlft, self := left)) //+ my new grandchildren, etc
				+ project(ri, 					transform(InRec, self.derived_levels_below := left.derived_levels_from_top - ldlft, self := left)) //+ my new children
				, derived_levels_below);
			self := le;
		end;

		outfile :=
		denormalize(
			infile,//this one stays distributed by id through each macro call
			distribute(
				infile(derived_levels_from_top = p_derived_levels_below),		//only rolling up for the derived_levels_from_top set by the macro call
				hash(parent_id)
			),
			left.id = right.parent_id
			and left.src = right.src//roll up underneath your parent
			,
			%tra%(left, right),
			local
		);
	ENDMACRO;

	//The previous approach was to gather children for child1, then child2, etc.  But, if you had 10 kids, and 10 grandkids, you could only gather kids for 20 of them.  it wasnt 20 levels of kids.
	//Now, we start from the bottom and build up.  the first macro call only gathers kids for entities that are 19 levels from the top (if there are any)
	//	then each subsequent call rolls it up another level, so you really support 19 or 20 levels of kids
	
	//see BIPv2_HRCHY_Platform.Constants.max_depth_supported
	macc(jjc,  dc19, 19)  //find parents for those 19 levels from the top, and roll up as their children
	macc(dc19, dc18, 18)  
	macc(dc18, dc17, 17)  
	macc(dc17, dc16, 16)  
	macc(dc16, dc15, 15)  
	macc(dc15, dc14, 14)  
	macc(dc14, dc13, 13)  
	macc(dc13, dc12, 12)  
	macc(dc12, dc11, 11)  
	macc(dc11, dc10, 10)  
	
	macc(dc10, dc9, 9)  
	macc(dc9, dc8, 8)  
	macc(dc8, dc7, 7)  
	macc(dc7, dc6, 6)  
	macc(dc6, dc5, 5)  
	macc(dc5, dc4, 4)  
	macc(dc4, dc3, 3)  
	macc(dc3, dc2, 2)  
	macc(dc2, dc1, 1)  
	
	
	dcdone := 
	
		//this may be a bit lazy, but i want to see if it fixes my issues
	dedup(
		sort(
			dc1, proxid, src, -parent_id, -ultimate_id
		)
		,proxid, src
	);
	
	// output(choosen(jjc, 100), named('jjc'));
	// output(dc1, named('dc1'));
	// output(dc2, named('dc2'));
	// output(dc3, named('dc3'));
	// output(dcdone, named('dcdone'));
	// output(sort(dc4, ultimate_id, id), named('WithParentsChildren'));

	return dcdone;
END;


export LgidTable(dataset(r2) d) :=
	FUNCTION

	//***** ASSIGN LGIDS

	lgidr0 := record
		unsigned6 lgid;	
		r2;
	end;

	//Find the lowest proxid to use as lgid
	lgid0 := 
	project(
		d,
		transform(
			lgidr0,
			self.lgid := ut.min2(left.proxid, min(left.children(proxid > 0), proxid)), //this does not account for parents, but thats ok because each level is its own lgid and the parent has its own row here
			self := left
		)
	);
	
	//Create a record from each subject
	lgid1a := 
	project(
		lgid0,
		transform(
			lgidr,
			self_ultimate_proxid0 := sort(left.parents(proxid > 0), derived_levels_from_top)[1].proxid; //proxid for highest level parent
			self_ultimate_proxid := if(self_ultimate_proxid0 > 0, self_ultimate_proxid0, self.proxid);  //if thats empty, then use self (you might be the ult parent here)
			self.lgid := left.lgid,
			self.lgid_level := left.derived_levels_from_top,
			self.nodes_below := count(left.children),
			self.proxid := left.proxid,
			self.proxid_level_within_lgid := left.derived_levels_below,
			self.parent_proxid := max(left.parents(derived_levels_above = 1), proxid),
			self.sele_proxid := 
			if(
				left.is_sele_level,
				left.proxid,
				sort(left.parents(is_sele_level or derived_levels_from_top = 0), derived_levels_above)[1].proxid 	//my closest parent that is a sele level (or is ult level)
			),
			self.org_proxid := 
			map(
				exists(left.parents(is_sele_level, proxid > 0)) //if i have a sele parent 
					=> sort(left.parents(is_sele_level, proxid > 0), -derived_levels_above)[1].proxid, //then take my farthest sele parent 
				left.is_sele_level and left.proxid > 0  // otherwise, if i am a sele myself, use me
					=> left.proxid,
				self_ultimate_proxid	//otherwise, just take the ultimate proxid
			);
			self.ultimate_proxid := self_ultimate_proxid,
			self.proxid_is_SELE_level := left.is_SELE_level,
			// self.proxid_is_org_level := FALSE,
			self.src := left.src,
			self.biz_type := left.biz_type
		)
	);
	
	//Create a record from each child
	lgid1b0 :=
	normalize(
		lgid0,
		count(left.children),
		transform(
			lgidr,
			self.lgid := left.lgid,
			self.lgid_level := left.derived_levels_from_top,
			self.nodes_below := 0,
			self.proxid_level_within_lgid := left.children[counter].derived_levels_below,
			self.parent_proxid := 0,
			self.sele_proxid := 0,
			self.org_proxid := 0,
			self.ultimate_proxid := 0,		
			self.proxid_is_SELE_level := left.children[counter].is_SELE_level,
			// self.proxid_is_org_level := FALSE,
			self := left.children[counter]
		)
	);	
	
	//patch the child record with info from the subject record 
	lgid1b :=
	join(
		lgid1b0(proxid > 0),
		lgid1a(proxid > 0),
		left.proxid = right.proxid and left.src = right.src,
		transform(
			lgidr,
			self.parent_proxid := right.parent_proxid,
			self.sele_proxid := right.sele_proxid,
			self.org_proxid := right.org_proxid,
			self.ultimate_proxid := right.ultimate_proxid,
			self.nodes_Below := right.nodes_below,
			self := left
		),
		keep(1),
		left outer
	)
	+lgid1b0(proxid = 0);
	
	lgid1 := lgid1a + lgid1b;
	
	//now assign lgid_is_org_level
	/*
	lgid2 :=
	join(
		lgid1(lgid > 0),
		lgid1(proxid_is_org_level, proxid > 0),
		left.lgid = right.proxid and left.src = right.src,
		transform(
			lgidr,
			self.lgid_is_org_level := right.proxid_is_org_level,
			self := left
		),
		left outer,
		keep(1)
	)
	+lgid1(lgid = 0);
	*/
	myids := [219872093,221053333];

	// output(sort(lgid0, id, ultimate_id), {lgid0, count(lgid0.children)}, named('lgid0'));
	// output(choosen(lgid0, 500), named('lgid0'));
	// output(lgid0(proxid in pid_int), named('lgid0_int'));
	// output(choosen(lgid1a, 500), named('lgid1a'));
	// output(lgid1a(proxid in pid_int), named('lgid1a_int'));
	// output(count(lgid1a(proxid > 0 and proxid < lgid)), named('cnt_lgid1a_integrity_issue'));
	// output(choosen(lgid1a(proxid > 0 and proxid < lgid), 100), named('lgid1a_integrity_issue'));
	// output(lgid1b, named('lgid1b'));
	// output(lgid1b(proxid in pid_int), named('lgid1b_int'));
	// output(count(lgid1b(proxid > 0 and proxid < lgid)), named('cnt_lgid1b_integrity_issue'));
	// output(choosen(lgid1b(proxid > 0 and proxid < lgid), 100), named('lgid1b_integrity_issue'));
	// output(lgid1b0, named('lgid1b0'));
	// output(lgid1b0(proxid in pid_int), named('lgid1b0_int'));
	// output(count(lgid1b0(proxid > 0 and proxid < lgid)), named('cnt_lgid1b0_integrity_issue'));
	// output(choosen(lgid1b0(proxid > 0 and proxid < lgid), 100), named('lgid1b0_integrity_issue'));
	// output(lgid1, named('lgid1'));
	// output(sort(lgid1, lgid, lgid_level), named('LgidTable'));

	// return lgid2;
	return lgid1;
END;




export WithIDs(
	// dataset(Inrec) d
	dataset(r2) w2,			//this is your result from WithParentsChildren
	dataset(lgidr) lt		//this is your result from LgidTable
	) := 
FUNCTION

//***** ASSIGN ULTIDS

// w2 := WithParentsChildren(d);
// lt := LgidTable(w2);


r4 := BIPv2_HRCHY_Platform.Layouts.r4;


//FIND SELEID to go with each sele_proxid.  then, do the same for org and ult
seleids := dedup(sort(lt(proxid > 0), sele_proxid,     src, proxid), sele_proxid); 
orgids  := dedup(sort(lt(proxid > 0), org_proxid,      src, proxid), org_proxid);
//ultids slightly diff since we want to count the total proxids in there
//1 - dedup by proxid, src
//2 - project into r6 and set nodes_total = 1
//3 - sort in anticipation of rollup
//4 - rollup by ultimate_proxid and src, keep the lower proxid (for the base ultid value) and sum up the nodes_total (for the entire ult)
// OLD ultids  := dedup(sort(lt(proxid > 0), ultimate_proxid, proxid), ultimate_proxid); - this did the same thing except lost track of node count
r6 := {lgidr, r4.nodes_total};
ultids :=
rollup(
	sort(
		project(
			dedup(lt(proxid > 0), proxid, all),
			transform(
				r6,
				self.nodes_total := 1,
				self := left
			)
		),
		ultimate_proxid, src
	),
	left.ultimate_proxid = right.ultimate_proxid and left.src = right.src,
	transform(
		r6,
		self.nodes_total := left.nodes_total + right.nodes_total,
		self.proxid := ut.Min2(left.proxid, right.proxid),
		self := left
	)
);

//first, join lt to itself to find the seleid (lgid)
ltj :=
join(
	dedup(lt, proxid, sele_proxid, all),
	seleids,
	left.sele_proxid = right.sele_proxid and
	left.src = right.src and
	left.sele_proxid > 0,
	transform(
		r4,
		self.derived_seleid := if(right.proxid > 0, right.proxid, left.proxid),//if stmt covers the left outer case
		self.is_SELE_level := left.proxid_is_SELE_level,
		self := left,
		self := []
	)
	,hash
	,left outer //not every cluster has a sele level entity
);

//now, join back to lt to find the orgid (lgid)
ltj2 :=
join(
	ltj,
	orgids,
	left.org_proxid = right.org_proxid and
	left.src = right.src and	
	left.org_proxid > 0,
	transform(
		r4,
		self.derived_orgid := right.proxid,
		self := left,
		self := []
	)
	,hash	
)
+project(ltj(org_proxid = 0), r4);

//now, join back to lt to find the ultid (lgid) 
ltj3 :=
join(
	ltj2,
	ultids,
	left.ultimate_proxid = right.ultimate_proxid and 
	left.src = right.src and	
	left.ultimate_proxid > 0,
	transform(
		r4,
		self.derived_ultid := right.proxid,
		// self.nodes_total := right.nodes_below + 1;
		self.nodes_total := right.nodes_total;	
		self := left
	)
	,hash	
)
;	

//assign is_Ult_level and is_Org_level
ltj4 :=
project(
	ltj3,
	transform(
		r4,
		self.is_Org_level := left.proxid > 0 and left.proxid = left.org_proxid;
		self.is_Ult_level := left.proxid > 0 and left.proxid = left.ultimate_proxid;
		self := left
	)
)
;

		
//slap the answers back onto the file
wa :=
join(
	w2,
	dedup(sort(ltj4(proxid > 0), proxid, constants.sources.PreferenceRanking(src)), proxid),
	left.proxid = right.proxid
	and left.proxid > 0,
	transform(
		BIPv2_HRCHY_Platform.Layouts.rWithIDs,
		self := right,
		self := left
	),
	left outer
	,hash	
);

// output(choosen(seleids, 500), named('seleids'));
// output(choosen(ultids, 500), named('ultids'));
// output(choosen(ultids(proxid in pid_int or ultimate_proxid in pid_int), 500), named('ultids_int'));		
// output(choosen(ltj, 500), named('ltj'));
// output(choosen(ltj(proxid in pid_int), 500), named('ltj_int'));
// output(choosen(ltj2, 500), named('ltj2'));
// output(choosen(ltj2(proxid in pid_int), 500), named('ltj2_int'));
// output(choosen(ltj3, 500), named('ltj3'));
// output(choosen(ltj3(proxid in pid_int), 500), named('ltj3_int'));
// output(choosen(ltj4, 500), named('ltj4'));
// output(choosen(ltj4(proxid in pid_int), 500), named('ltj4_int'));
// output(choosen(wa, 500), named('wa'));
// output(choosen(wa(proxid in pid_int), 500), named('wa_int'));
		
return wa(nodes_total >= BIPv2_HRCHY_Platform.Constants.min_nodes_supported);		//previously, we let the nodes_total = 1 crowd through, but that messes up the lgid3 iterating functionality (bug 164557)

/*
uj :=
join(
	w2(proxid > 0),
	lt(lgid_level = 0, proxid > 0),
	left.proxid = right.proxid,
	transform(
		r2,
		self.derived_ultid := right.lgid,
		self := left
	),
	left outer,
	keep(1)
) 
+ w2(proxid = 0);

//***** ASSIGN ORGIDS

oj :=
join(
	uj(proxid > 0),
	lt(lgid_is_org_level, proxid > 0),
	left.proxid = right.proxid,
	transform(
		r2,
		self.derived_orgid := if(right.lgid > 0, right.lgid, left.derived_ultid),
		self := left
	),
	left outer,
	keep(1)
)
+ uj(proxid = 0);

return  oj;
*/
END;

import BIPV2_Files,BIPV2;

EXPORT PatchHeader(
	dataset(BIPV2_Files.layout_proxid)			head
	,dataset(BIPv2_HRCHY_Platform.Layouts.rWithIDs)	wi
) := FUNCTION
	
	//first, clear the way...need upper level IDs reset for the clusters where we are going to apply these results

	lgid3s_affected := 
	join(
		head,
		wi,
		left.proxid = right.proxid,
		transform(left),
		hash
	)
	;	

	head_clear :=
	join(
		head,
		dedup(lgid3s_affected, lgid3, all),
		left.lgid3 = right.lgid3 ,
		transform(
			recordof(head),
			self.ultid 	:= if(right.lgid3 > 0, left.proxid, left.ultid),
			self.orgid 	:= if(right.lgid3 > 0, left.proxid, left.orgid),
			self.seleid := if(right.lgid3 > 0, left.proxid, left.seleid),
			self.lgid3 	:= if(right.lgid3 > 0, left.proxid, left.lgid3),
			self := left
		)
		,hash
		,left outer
	);
	

	//now apply
	patched1 := join(
		head_clear,
		wi(proxid > 0),
		left.proxid = right.proxid,
		transform(
			BIPV2.CommonBase.Layout,
			self.ultid 	:= if(right.derived_ultid > 0, 	right.derived_ultid, 	left.ultid);
			self.orgid 	:= if(right.derived_orgid > 0, 	right.derived_orgid, 	left.orgid);
			self.SELEid := if(right.derived_SELEid > 0, right.derived_SELEid, left.SELEid);
			
			self.ultimate_proxid := right.ultimate_proxid;
			self.org_proxid := right.org_proxid;
			self.sele_proxid := right.sele_proxid;

			self.is_Ult_level := right.is_Ult_level;
			self.is_Org_level := right.is_Org_level;
			self.is_SELE_level := right.is_sele_level;

			self.has_lgid := right.proxid > 0;
			self.parent_proxid := right.parent_proxid;
			
			self.levels_from_top := right.derived_levels_from_top;
			self.nodes_below := right.nodes_below;
			self.nodes_total := right.nodes_total;
			
			self := left;
		)
		,hash
		,left outer
		,keep(1)
	)
	#IF(Debug)
		: persist('~thor_data400::BIPv2_HRCHY_Platform::mod_Build.patched1')
	#END
	;

	// output(head,,'~thor::cemtemp.PatchHeader.head', overwrite);
	// output(wi,,'~thor::cemtemp.PatchHeader.wi', overwrite);
	// output(head,,'~thor::cemtemp.PatchHeader.patched1', overwrite);

	// set_ults_1 := [226166362,96570304];
	// set_ults_2 := [97950934,930440932];

	// set_seles_1 := [226166362,96570304];
	// set_seles_2 := [930440932];
	
	// mac(ds, s) := functionmacro
	
		// return 
		// parallel(
			 // output(dedup(ds(ultid in set_ults_1),ultid, orgid, seleid, lgid3, proxid, all), named('ults1_' + s))
			// ,output(dedup(ds(ultid in set_ults_2),ultid, orgid, seleid, lgid3, proxid, all), named('ults2_' + s))
			// ,output(dedup(ds(seleid in set_seles_1 or lgid3 in set_seles_1),ultid, orgid, seleid, lgid3, proxid, all), named('seles1_' + s))
			// ,output(dedup(ds(seleid in set_seles_2 or lgid3 in set_seles_2),ultid, orgid, seleid, lgid3, proxid, all), named('seles2_' + s))
		// );
	
	// endmacro;
	
	// mh 	:= mac(head, 			'head');
	// mu	:= mac(ults_affected, 'ults_affected');
	// mhc := mac(head_clear, 'head_clear');
	// mp 	:= mac(patched1, 	'patched1');
	
	
	
	return patched1;
	// return parallel(mh, mu, mhc, mp);


END;//PatchHeader

END;//Functions
/* 
// SAMPLE CALL

r0 := record
	boolean is_org_level;
	unsigned6 derived_ultid;
	unsigned6 derived_orgid;
	unsigned6 proxid;
  unsigned6 id;
  unsigned6 parent_id;
  unsigned6 ultimate_id;
	integer derived_levels_above;
	integer derived_levels_below;
	integer derived_levels_from_top;
	string20 name;
end;

r := BIPv2_HRCHY_Platform.layouts.Inrec;

dl := dataset([
{false,0,0,2000,200,0  ,200,0,0,0,'ult'},
{false,0,0,2001,201,200,200,0,0,0,'child1'},
{false,0,0,2002,202,200,200,0,0,0,'child2'},
{false,0,0,2003,203,200,200,0,0,0,'child3'},
{false,0,0,2004,204,200,200,0,0,0,'child4'},
{false,0,0,2005,205,200,200,0,0,0,'child5'},
{false,0,0,2011,211,201,200,0,0,0,'gchild1a'},
{false,0,0,2012,212,202,200,0,0,0,'gchild2a'},
{false,0,0,2013,213,203,200,0,0,0,'gchild3a'},
{false,0,0,2014,214,204,200,0,0,0,'gchild4a'},
{false,0,0,2015,215,205,200,0,0,0,'gchild5a'},
{false,0,0,2016,216,205,200,0,0,0,'gchild5b'},

{false,0,0,101,1,0,1,0,0,0,'my grandad'},
{false,0,0,102,2,1,1,0,0,0,'my mom'},
{true ,0,0,103,3,2,1,0,0,0,'me'},
{true ,0,0,104,4,2,1,0,0,0,'my sister'},
{false,0,0,105,5,4,1,0,0,0,'my neice'},
{false,0,0,106,6,4,1,0,0,0,'my nephew'},
{false,0,0,107,7,3,1,0,0,0,'my daughter'},

{false,0,0,111,11,0 ,11,0,0,0,'bob'},
{false,0,0,112,12,11,11,0,0,0,'bob 2'},
{false,0,0,115,13,12,11,0,0,0,'bob 3'},
{false,0,0,114,14,13,11,0,0,0,'bob 4'},
{false,0,0,113,14,13,11,0,0,0,'bob 4b'}

], r0);

dd := dataset([
{true ,0,0,103,883,0,883,0,0,0,'me'},
{false,0,0,107,887,883,883,0,0,0,'my daughter'},
{false,0,0,108,888,883,883,0,0,0,'my son'}

], r0);

output(dl, named('InputRawL'));
output(dd, named('InputRawD'));
d :=
project(
	dl,
	transform(
		r,
		self := left,
		self.src := 'L',
		self := []
	)
)
+
project(
	dd,
	transform(
		r,
		self := left,
		self.src := 'D',
		self := []
	)
)
;
output(d, named('Input'));

cln := BIPv2_HRCHY_Platform.Functions.RemoveConflict(d);
wpc := BIPv2_HRCHY_Platform.Functions.WithParentsChildren(cln);
lt :=  BIPv2_HRCHY_Platform.Functions.LgidTable(wpc);
wi :=  BIPv2_HRCHY_Platform.Functions.WithIds(wpc,lt);
output(cln, named('cln'));
output(wpc, named('wpc'));
output(lt, named('lt'));
output(wi, named('wi'));

*/
