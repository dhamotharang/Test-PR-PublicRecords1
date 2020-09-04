import BIPV2, BIPV2_Files,BIPV2_Entity,tools,MDR,BIPV2_Best,bizlinkfull,ut;

EXPORT FunctionsShow := 
MODULE

//indexes i need
shared iprox := bizlinkfull.Process_Biz_Layouts.key;								//header payload
shared ipl 	:= BIPV2_Files.files_hrchy.KEY_HRCY_PROXID_FULL();		//find hrchy info by proxid
shared ilgid := BIPV2_Files.files_hrchy.KEY_HRCY_LGID_FULL();			//find hrchy info by lgid


export ShowDirectParentsChildren(dataset({unsigned6 seleid}) ds0) :=
/*
Input a dataset of SELEIDs
Get back the SELEIDs that sit DIRECTLY above (parent) and below (children) the input SELEID in the hrchy
*/
FUNCTION

ds := dedup(ds0, all);

// ipl 	:= BIPV2_Files.files_hrchy.KEY_HRCY_PROXID_FULL();		//index to find hrchy info by proxid
// ilgid := BIPV2_Files.files_hrchy.KEY_HRCY_LGID_FULL();			//index to find hrchy info by lgid

//GET THE LGID INFO.  OK TO TREAT SELE LIKE PROX FOR FETCHING HERE (SINCE THE PROXID IS IN THERE SOMEWHERE)
myipl 	:= join(dedup(ds, seleid, all), 	ipl, 		keyed(left.seleid = right.proxid), transform(right), limit(ut.limits.default, skip));
myilgid := join(dedup(myipl, lgid, all), 	ilgid, 	keyed(left.lgid = right.lgid), 		transform(right), limit(ut.limits.default, skip));

//GET THE SELEIDS FOR ALL THESE
IDs := bizlinkfull.Process_Biz_Layouts.id_stream_complete(dedup(project(myilgid, transform(bizlinkfull.Process_Biz_Layouts.id_stream_layout, self.proxid := left.proxid, self := [])), all));
j1 := dedup(join(myilgid, IDs, left.proxid = right.proxid, transform({myilgid, IDs.SELEID}, self := left, self := right)), all)(seleid > 0);

//TO FIND THE PARENT, LOOK AT THE TOP OF THE LGID AND 1)SEE WHO THEIR PARENT IS AND THEN 2)GET THAT SELEID FROM THE PARENT
parent_prox := join(ds, j1(proxid_level_within_lgid = 0), left.seleid = right.seleid, transform({ds, unsigned6 parent_proxid}, self := left, self := right), keep(1), left outer);
parent_sele := join(parent_prox, j1(proxid_level_within_lgid = 0, seleid > 0), left.parent_proxid = right.proxid and left.seleid <> right.seleid, transform({parent_prox, unsigned6 parent_seleid}, self := left, self.parent_seleid := right.seleid), keep(1), left outer);

//TO FIND THE CHILDREN, GATHER ALL THE PROXIDS FOR YOUR SELE AND SEE IF ANYONE AT THE TOP OF ANOTHER LGID IS REPORTING TO THEM
mysele_proxs 	:= join(ds, dedup(j1, proxid, seleid, all), left.seleid = right.seleid, transform(right));
seles_below 	:= join(mysele_proxs, dedup(j1, parent_proxid, seleid, all), left.proxid = right.parent_proxid and left.seleid <> right.seleid, transform({unsigned6 seleid, unsigned6 child_seleid}, self.seleid := left.seleid, self.child_seleid := right.seleid));

packaged := join(parent_sele, seles_below, left.seleid = right.seleid, transform({parent_sele.seleid, parent_sele.parent_seleid, unsigned6 child_seleid}, self := left, self := right), left outer);


// output(myipl, all, named('myipl'));
// output(myilgid, all, named('myilgid'));
// output(IDs, all, named('IDs'));
// output(j1, all, named('j1'));
// output(parent_prox, named('parent_prox'));
// output(parent_sele, named('parent_sele'));
// output(seles_below, named('seles_below'));
// output(dedup(seles_below, all), named('seles_below_ddp'));

//SAMPLE CALL
// mysele := dataset([{456},/*has no parent and no children*/ 	{4881204}, /*has parent and children*/ {4942288}, /*has only a parent*/ 			{2620068}/*has only children*/ ], {unsigned6 seleid});
// output(mysele, named('mysele'));
// output(BIPv2_HRCHY.FunctionsShow.ShowDirectParentsChildren(mysele), named('results'));//W20151218-091718
// /*http://10.241.12.204:8010/WsWorkunits/WUResultView?Wuid=W20151217-104406&ResultName=CHART_VERTICALTREE_FamilyTree&ViewName=EmbeddedView*/

return packaged;

END;



export GetLGID(
	unsigned6 myproxid
	,string1 SourcePicked = ''/*default is to pick based on availability of preferred hrchy sources, but you may specify one of BIPv2_HRCHY_Dev.Constants.Sources*/) :=
FUNCTION

//layouts
iprox_slimrec := record
	iprox.proxid;
	iprox.seleid;
	iprox.ultid;
	iprox.company_name;
	iprox.prim_name;
	iprox.st;
end;

//find lgid for my proxid,lgid_level = 0 is the full tree.  
lgids_raw := ipl(keyed(proxid = myproxid), lgid_level = 0);	

//limit to one hrchy source
theSource := if(SourcePicked <> '', SourcePicked, Constants.Sources.Preferred(set(lgids_raw, src)));
lgids := lgids_raw(src = theSource);

//grab all the nodes for this tree
lgidinfo := 
join(
	lgids,
	ilgid,
	keyed(left.lgid = right.lgid) 
	and left.lgid_level = right.lgid_level,
	transform(right),
	limit(ut.limits.default, skip)
);

// output(lgids_raw, all, named('lgids_raw'));
// output(lgidinfo, all, named('lgidinfo'));
// output(dedup(lgidinfo, all), all, named('lgidinfo_dedup'));
return dedup(lgidinfo, all);

END;//GetLGID

//a function macro could just add the best onto your file and then you wouldnt have to do two "append back" joins
shared AddBest(
	dataset(recordof(ilgid)) lgidinfo
) :=
FUNCTION

bestf := BIPV2_Best.Key_LinkIds.KFetch(
	inputs := dedup(project(lgidinfo, transform(BIPV2.IDlayouts.l_xlink_ids, self.proxid := left.proxid, self := [])), proxid, all)
	)(proxid > 0);	//if no proxid, its a higher level (like sele) best record

rec_wbest := record
	lgidinfo.proxid;
	lgidinfo.parent_proxid;
	lgidinfo.ultimate_proxid;
	lgidinfo.proxid_level_within_lgid;
	bestf.company_name.company_name;
end;
	
lb :=
dedup(
	join(
		lgidinfo,
		bestf,
		left.proxid = right.proxid,
		transform(
			rec_wbest,
			self.company_name := right.company_name[1].company_name;
			self := left
		)
		, left outer //a ghost record may be part of a hrcy, but it will have no best info
	)
	, all
);

return lb;
END;//AddBest



export ShowParents(
	unsigned6 myproxid
	,string1 SourcePicked = ''/*default it to pick based on availability of preferred hrchy sources, but you may specify one of BIPv2_HRCHY_Dev.Constants.Sources*/) :=
FUNCTION

li :=  GetLGID(myproxid, SourcePicked);

rec_without_best := record
	li.proxid;
	li.parent_proxid;
	li.ultimate_proxid;
	li.proxid_level_within_lgid;
  boolean need_parent_now := FALSE;  //this will be my signal of which record needs to find a parent in the next look
  unsigned2 levels_above_subject := 0;
end;

  
//set my subject record to be the first to find a parent  
lb := dedup(project(li, transform(rec_without_best, self.need_parent_now := left.proxid = myproxid; self := left)), all);

//loop through and add a parent each time
lp := 
  LOOP(
    lb, 
    ut.min2(BIPv2_HRCHY.Constants.max_depth_supported, max(lb(proxid = myproxid), proxid_level_within_lgid)),//might need + 1 on the second item here, test to see
    join(
      rows(left), 
      lb, 
      left.parent_proxid > 0 and left.parent_proxid = right.proxid and left.need_parent_now,
      transform(
        recordof(lb),
        SELF.need_parent_now := TRUE;
        SELF.levels_above_subject := left.levels_above_subject + 1;
        SELF := right;
      )
      ,hash
			,keep(1) //each should only have 1 parent
     )
     +lb(need_parent_now)//this holds onto the child while the join adds the parent
  );
	
//Get a hold of the best info	
be := AddBest(lgidinfo := project(lp, transform(recordof(ilgid), self := left, self := [])));

//append it back to lp
lpb :=
join(
	lp,
	be,
	left.proxid = right.proxid,
	transform(
		{recordof(lp), be.company_name},
		self.company_name := right.company_name,
		self := left
	)
);

// output(li, all, named('li'));
// output(dedup(li, all), all, named('li_dedup'));
// output(li(proxid = 29142437942 or parent_proxid = 29142437942), all, named('li_29142437942'));
// output(lp, all, named('lp'));
// output(be, all, named('be'));
lpslim := sort(project(lpb, {lpb.proxid, lpb.parent_proxid, lpb.levels_above_subject, lpb.company_name}), levels_above_subject);
return lpslim;

END;//ShowParents



export ShowHrchy( 
	unsigned6 myproxid
	,string1 SourcePicked = ''/*default it to pick based on availability of preferred hrchy sources, but you may specify one of BIPv2_HRCHY_Dev.Constants.Sources*/) :=
FUNCTION


li :=  GetLGID(myproxid, SourcePicked);
lb :=  AddBest(li);


top := lb(proxid = ultimate_proxid);


rec_w1 := {top, dataset(recordof(top)) children};
rec_w2 := {top, dataset(recordof(rec_w1)) children};
rec_w3 := {top, dataset(recordof(rec_w2)) children};
rec_w4 := {top, dataset(recordof(rec_w3)) children};
rec_w5 := {top, dataset(recordof(rec_w4)) children};
rec_w6 := {top, dataset(recordof(rec_w5)) children};
rec_w7 := {top, dataset(recordof(rec_w6)) children};
rec_w8 := {top, dataset(recordof(rec_w7)) children};
rec_w9 := {top, dataset(recordof(rec_w8)) children};
rec_w10 := {top, dataset(recordof(rec_w9)) children};
rec_w11 := {top, dataset(recordof(rec_w10)) children};
rec_w12 := {top, dataset(recordof(rec_w11)) children};
rec_w13 := {top, dataset(recordof(rec_w12)) children};
rec_w14 := {top, dataset(recordof(rec_w13)) children};
rec_w15 := {top, dataset(recordof(rec_w14)) children};
rec_w16 := {top, dataset(recordof(rec_w15)) children};
rec_w17 := {top, dataset(recordof(rec_w16)) children};
rec_w18 := {top, dataset(recordof(rec_w17)) children};
rec_w19 := {top, dataset(recordof(rec_w18)) children};
rec_w20 := {top, dataset(recordof(rec_w19)) children};

fmac_den(le) := functionmacro

	den := 
	denormalize(
		project(le, transform(rec_w1, self := left, self := [])),
    lb,
		left.proxid = right.parent_proxid,
		transform(
			rec_w1,
			self.children := (left.children + right)(parent_proxid > 0);
			self := left;
		)
	);
  
  return den;
endmacro;

//see BIPv2_HRCHY.Constants.max_depth_supported
rec_w1 mr1(dataset(recordof(top)) le) := fmac_den(le);
rec_w2 mr2(rec_w1 le) := transform self.children := mr1(le.children);                 self := le; end;
rec_w3 mr3(rec_w2 le) := transform self.children := project(le.children, mr2(left));  self := le; end;
rec_w4 mr4(rec_w3 le) := transform self.children := project(le.children, mr3(left));  self := le; end;
rec_w5 mr5(rec_w4 le) := transform self.children := project(le.children, mr4(left));  self := le; end;
rec_w6 mr6(rec_w5 le) := transform self.children := project(le.children, mr5(left));  self := le; end;
rec_w7 mr7(rec_w6 le) := transform self.children := project(le.children, mr6(left));  self := le; end;
rec_w8 mr8(rec_w7 le) := transform self.children := project(le.children, mr7(left));  self := le; end;
rec_w9 mr9(rec_w8 le) := transform self.children := project(le.children, mr8(left));  self := le; end;
rec_w10 mr10(rec_w9 le) := transform self.children  := project(le.children, mr9(left));   self := le; end;
rec_w11 mr11(rec_w10 le) := transform self.children := project(le.children, mr10(left));  self := le; end;
rec_w12 mr12(rec_w11 le) := transform self.children := project(le.children, mr11(left));  self := le; end;
rec_w13 mr13(rec_w12 le) := transform self.children := project(le.children, mr12(left));  self := le; end;
rec_w14 mr14(rec_w13 le) := transform self.children := project(le.children, mr13(left));  self := le; end;
rec_w15 mr15(rec_w14 le) := transform self.children := project(le.children, mr14(left));  self := le; end;
rec_w16 mr16(rec_w15 le) := transform self.children := project(le.children, mr15(left));  self := le; end;
rec_w17 mr17(rec_w16 le) := transform self.children := project(le.children, mr16(left));  self := le; end;
rec_w18 mr18(rec_w17 le) := transform self.children := project(le.children, mr17(left));  self := le; end;
rec_w19 mr19(rec_w18 le) := transform self.children := project(le.children, mr18(left));  self := le; end;
rec_w20 mr20(rec_w19 le) := transform self.children := project(le.children, mr19(left));  self := le; end;

w1 := mr1(top);
w2 := project(w1, mr2(left));
w3 := project(w2, mr3(left));
w4 := project(w3, mr4(left));
w5 := project(w4, mr5(left));
w6 := project(w5, mr6(left));
w7 := project(w6, mr7(left));
w8 := project(w7, mr8(left));
w9 := project(w8, mr9(left));
w10 := project(w9, mr10(left));
w11 := project(w10, mr11(left));
w12 := project(w11, mr12(left));
w13 := project(w12, mr13(left));
w14 := project(w13, mr14(left));
w15 := project(w14, mr15(left));
w16 := project(w15, mr16(left));
w17 := project(w16, mr17(left));
w18 := project(w17, mr18(left));
w19 := project(w18, mr19(left));
w20 := project(w19, mr20(left));

// output(lb, named('lb'));
// output(top, named('top'));
return w20;

end;//ShowHrchy


export ShowHrchyOld(//W20150401-152704 shows a sample use.  i am keeping this code for now because it works with the old VL stuff
	unsigned6 myproxid
	,string1 SourcePicked = ''/*default it to pick based on availability of preferred hrchy sources, but you may specify one of BIPv2_HRCHY_Dev.Constants.Sources*/) :=
FUNCTION


//indexes i need
// iprox := bizlinkfull.Process_Biz_Layouts.key;
// ipl 	:= BIPV2_Files.files_hrchy.KEY_HRCY_PROXID_FULL();
// ilgid := BIPV2_Files.files_hrchy.KEY_HRCY_LGID_FULL();

/*
//this code just for testing results of dev builds
import BIPV2;
ref :=
	bipv2_hrchy_dev;
	// bipv2_hrchy;
ipl 	:= INDEX(
		dedup(dataset([], ref.Layouts.lgidr), proxid, lgid, lgid_level, proxid_level_within_lgid, src, all),
		{proxid},
		{lgid, lgid_level, proxid_level_within_lgid, src, biz_type},		
		// '~thor_data400::bipv2_hrchy::key::'+BIPV2.KeySuffix+'::proxid'
		'~thor_data400::bipv2_files.files_hrchy.keyname_hrcy_proxid_lftest132519'
	);

ilgid := INDEX(
		dataset([], ref.Layouts.lgidr),
		{lgid},
		{dataset([], ref.Layouts.lgidr)},		
		// '~thor_data400::bipv2_hrchy::key::'+BIPV2.KeySuffix+'::lgid'
		'~thor_data400::bipv2_files.files_hrchy.keyname_hrcy_lgid_lftest132519'
	);	
*/



//layouts
iprox_slimrec := record
	iprox.proxid;
	iprox.seleid;
	iprox.ultid;
	iprox.company_name;
	iprox.prim_name;
	iprox.st;
end;

//read the indexes
lgids_raw := ipl(keyed(proxid = myproxid));
theSource := if(SourcePicked <> '', SourcePicked, Constants.Sources.Preferred(set(lgids_raw, src)));
headerSrcFilter := 
	map(
		theSource = constants.sources.LNCA => mdr.sourceTools.src_DCA,
		theSource = constants.sources.Duns => mdr.sourceTools.src_Dunn_Bradstreet,
		mdr.sourceTools.src_DCA
	);
lgids := lgids_raw(src = theSource);
// lgidinfo := ilgid(keyed(lgid in set(lgids, lgid)));
lgidinfo_nohier := 
join(
	lgids,
	ilgid,
	keyed(left.lgid = right.lgid) 
	and left.lgid_level = right.lgid_level,
	transform(right),
	limit(ut.limits.default, skip)
);

import BIPV2;
lgidinfo := BIPV2.IDmacros.mac_AppendHierarchyIDs(lgidinfo_nohier, proxid);

//for parents and siblings
lgidinfo0 := lgidinfo(lgid_level = 0);
unsigned2 mylevel := max(lgidinfo0(proxid = myproxid), proxid_level_within_lgid);//only one record here
ds_top := lgidinfo0(proxid_level_within_lgid <= mylevel);

//for children
my_lgid 				:= max(lgidinfo(proxid = myproxid and proxid_level_within_lgid = 0), lgid);
my_lgid_level 	:= max(lgidinfo(proxid = myproxid and proxid_level_within_lgid = 0), lgid_level);
ds_children := lgidinfo(lgid = my_lgid and lgid_level = my_lgid_level and proxid <> myproxid);

//function for finding my parents proxids up to the top
integer myparentsprox(unsigned6 myprox, unsigned2 levelsabove) := 
FUNCTION
	parent1 := max(ds_top(proxid = myprox), parent_proxid);
	parent2 := max(ds_top(proxid = parent1), parent_proxid);
	parent3 := max(ds_top(proxid = parent2), parent_proxid);
	parent4 := max(ds_top(proxid = parent3), parent_proxid);
	parent5 := max(ds_top(proxid = parent4), parent_proxid);
	parent6 := max(ds_top(proxid = parent5), parent_proxid);
	parent7 := max(ds_top(proxid = parent6), parent_proxid);
	parent8 := max(ds_top(proxid = parent7), parent_proxid);
	parent9 := max(ds_top(proxid = parent8), parent_proxid);
	parent10 := max(ds_top(proxid = parent9), parent_proxid);
	parent11 := max(ds_top(proxid = parent10), parent_proxid);
	parent12 := max(ds_top(proxid = parent11), parent_proxid);
	parent13 := max(ds_top(proxid = parent12), parent_proxid);
	parent14 := max(ds_top(proxid = parent13), parent_proxid);
	parent15 := max(ds_top(proxid = parent14), parent_proxid);
	parent16 := max(ds_top(proxid = parent15), parent_proxid);
	parent17 := max(ds_top(proxid = parent16), parent_proxid);
	parent18 := max(ds_top(proxid = parent17), parent_proxid);
	parent19 := max(ds_top(proxid = parent18), parent_proxid);
	parent20 := max(ds_top(proxid = parent19), parent_proxid);
	
		// output(parent1, named('parent1'));
		// output(parent2, named('parent2'));
		// output(parent3, named('parent3'));
	
	return
	case(//yes, there is a better way to do this
		levelsabove,
		1 => parent1,
		2 => parent2,
		3 => parent3,
		4 => parent4,
		5 => parent5,
		6 => parent6,
		7 => parent7,
		8 => parent8,
		9 => parent9,
		10 => parent10,
		11 => parent11,
		12 => parent12,
		13 => parent13,
		14 => parent14,
		15 => parent15,
		16 => parent16,
		17 => parent17,
		18 => parent18,
		19 => parent19,
		20 => parent20,
		0
	);
END;	


ds_top_info :=
join(
	ds_top,
	iprox,
	keyed(left.ultid = right.ultid) and
	keyed(left.orgid = right.orgid) and
	keyed(left.seleid = right.seleid) and
	keyed(left.proxid = right.proxid) and
	right.source = headerSrcFilter,
	transform(
		{unsigned6 parent_proxid, string5 level_within_lgid, string3 biz_type, string2 src, boolean is_sele_level, string30 label, iprox_slimrec},
		self.level_within_lgid := (string)left.proxid_level_within_lgid,
		self.label := 
		map(
			left.proxid = myproxid
			=> 'v) SELF',
			left.proxid <> myproxid and left.proxid_level_within_lgid = mylevel and left.lgid_level = 0
			=> 'w) SIBLING',		
			left.proxid_level_within_lgid = 0 and left.lgid_level = 0
			=> 'a) ULTIMATE PARENT',		
			
			left.proxid = myparentsprox(myproxid, 1) => 'u) PARENT 1 LEVEL ABOVE SELF',
			left.proxid = myparentsprox(myproxid, 2) => 't) PARENT 2 LEVEL ABOVE SELF',
			left.proxid = myparentsprox(myproxid, 3) => 's) PARENT 3 LEVEL ABOVE SELF',
			left.proxid = myparentsprox(myproxid, 4) => 'r) PARENT 4 LEVEL ABOVE SELF',
			left.proxid = myparentsprox(myproxid, 5) => 'q) PARENT 5 LEVEL ABOVE SELF',
			left.proxid = myparentsprox(myproxid, 6) => 'p) PARENT 6 LEVEL ABOVE SELF',
			left.proxid = myparentsprox(myproxid, 7) => 'o) PARENT 7 LEVEL ABOVE SELF',
			left.proxid = myparentsprox(myproxid, 8) => 'n) PARENT 8 LEVEL ABOVE SELF',
			left.proxid = myparentsprox(myproxid, 9) => 'm) PARENT 9 LEVEL ABOVE SELF',
			left.proxid = myparentsprox(myproxid, 10) => 'l) PARENT 10 LEVEL ABOVE SELF',
			left.proxid = myparentsprox(myproxid, 11) => 'k) PARENT 11 LEVEL ABOVE SELF',
			left.proxid = myparentsprox(myproxid, 12) => 'j) PARENT 12 LEVEL ABOVE SELF',
			left.proxid = myparentsprox(myproxid, 13) => 'i) PARENT 13 LEVEL ABOVE SELF',
			left.proxid = myparentsprox(myproxid, 14) => 'h) PARENT 14 LEVEL ABOVE SELF',
			left.proxid = myparentsprox(myproxid, 15) => 'g) PARENT 15 LEVEL ABOVE SELF',
			left.proxid = myparentsprox(myproxid, 16) => 'f) PARENT 16 LEVEL ABOVE SELF',
			left.proxid = myparentsprox(myproxid, 17) => 'e) PARENT 17 LEVEL ABOVE SELF',
			left.proxid = myparentsprox(myproxid, 18) => 'd) PARENT 18 LEVEL ABOVE SELF',
			left.proxid = myparentsprox(myproxid, 19) => 'c) PARENT 19 LEVEL ABOVE SELF',
			left.proxid = myparentsprox(myproxid, 20) => 'b) PARENT 20 LEVEL ABOVE SELF',				

			''
		);
		self.parent_proxid := left.parent_proxid;
		self.biz_type := left.biz_type;
		self.is_sele_level := left.proxid_is_sele_level;
		self.src := left.src;		
		self := right
	),
	limit(ut.limits.default, skip)
);

ds_children_info :=
join(
	ds_children,
	iprox,
	keyed(left.ultid = right.ultid) and
	keyed(left.orgid = right.orgid) and
	keyed(left.seleid = right.seleid) and
	keyed(left.proxid = right.proxid) /*and
	right.source = headerSrcFilter*/,	
	transform(
		{unsigned6 parent_proxid, string5 level_within_lgid, string3 biz_type, string2 src, boolean is_sele_level, string30 label, iprox_slimrec},
		self.level_within_lgid := (string)(left.proxid_level_within_lgid + left.lgid_level),
		self.label := 'x) CHILD '+(string)left.proxid_level_within_lgid+' LEVEL BELOW SELF',
		self.parent_proxid := left.parent_proxid,
		self.biz_type := left.biz_type;	
		self.is_sele_level := left.proxid_is_sele_level;
		self.src := left.src;
		self := right
	),
	// limit(ut.limits.default, skip)
	keep(ut.limits.default)
);

ds_info := ds_top_info(label <> '') + ds_children_info;
ds_rolled := sort(tools.mac_AggregateFieldsPerID(ds_info, proxid), labels[1].label, proxid);

#if(debug)
	output(myproxid, named('myproxid'));
	output(mylevel, named('mylevel'));
	output(choosen(lgids_raw, 200), named('lgids_raw'));
	output(choosen(lgids, 200), named('lgids'));
	output(choosen(lgidinfo(proxid = myproxid), 200), named('lgidinfoself'));
	output(choosen(lgidinfo(proxid = 56091671), 200), named('lgidinfo56091671'));
	output(choosen(lgidinfo, 200), named('lgidinfo'));
	output(choosen(lgidinfo0, 200), named('lgidinfo0'));
	output(choosen(ds_top, 200), named('ds_top'));
	output(choosen(ds_top_info, 200), named('ds_top_info'));
	output(choosen(ds_children_info, 200), named('ds_children_info'));
	output(choosen(ds_rolled, 200), named('ds_rolled'));

	output(my_lgid, named('my_lgid'));
	output(choosen(ds_children, 200), named('ds_children'));
#end
// output(
// map(
	// exists(lgids) and not exists(ds_rolled)
	// => 'HRCHY AVAILABLE, BUT OUTSIDE SCOPE OF THIS GEOGRAPHICAL REGION.', 
	// exists(ds_rolled)
	// => 'HRCHY SHOWN BELOW',
	// 'NO HRCHY AVAILABLE'
// )
// , named('HRCHY_INFO_' + SourcePicked));
return ds_rolled;

end;//ShowHrchyOLD



END;//FunctionsShow

/*
//this code just for testing results of dev builds
import BIPV2;
ref :=
	bipv2_hrchy_dev;
	// bipv2_hrchy;
ipl 	:= INDEX(
		dedup(dataset([], ref.Layouts.lgidr), proxid, lgid, lgid_level, proxid_level_within_lgid, src, all),
		{proxid},
		{lgid, lgid_level, proxid_level_within_lgid, src, biz_type},		
		// '~thor_data400::bipv2_hrchy::key::'+BIPV2.KeySuffix+'::proxid'
		'~thor_data400::bipv2_files.files_hrchy.keyname_hrcy_proxid_lftest132519'
	);

ilgid := INDEX(
		dataset([], ref.Layouts.lgidr),
		{lgid},
		{dataset([], ref.Layouts.lgidr)},		
		// '~thor_data400::bipv2_hrchy::key::'+BIPV2.KeySuffix+'::lgid'
		'~thor_data400::bipv2_files.files_hrchy.keyname_hrcy_lgid_lftest132519'
	);	
*/