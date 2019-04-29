import ut,BIPV2,advo,tools,mdr;
import BIPV2_Lgid3;
import lksd;

EXPORT segmentation_gold(
   dataset(BIPV2.CommonBase.layout )  pInfile             = BIPV2.CommonBase.DS_CLEAN
  ,string                             idName              = 'PROXID'
	,string                             today 					    = bipv2.KeySuffix_mod2.MostRecentWithIngestVersionDate//in case you want to run as of a date in the past.  default to date of newest data.
  ,string                             outputNameModifier  = ''
) := module
	shared hrec := record
		unsigned6 	id;
			pInfile.source;
			// pInfile.dt_first_seen;
			pInfile.dt_last_seen;
			pInfile.company_status_derived;
			pInfile.company_name;
			pInfile.zip;
			pInfile.prim_range;
			pInfile.prim_name;
			pInfile.sec_range;
			string30 company_status_derived_w_date := '';
			string50 source_decoded_w_type := '';
			
			string addr_type := '';
			pInfile.has_lgid;
			boolean has_lgid3_cand := false;
			// string fein;
			// string duns;
			// string lnca;
			// string corp;
			// string ebr;
	end;
	shared triCore 			:= constants.triCore; 
	shared seg_layout 	:= layouts.laysegmentation;
	shared integer twoYears := 730;
	shared integer eighteenMonths := 548;
	shared activeStatus := ['ACTIVE'];
	
	shared rankStatus(string s)   := 
			map(
				s in BIPV2.BL_Tables.CompanyStatusConstants.setActive		=> 10,
				s in BIPV2.BL_Tables.CompanyStatusConstants.setDefunct		=> 9,
				s in BIPV2.BL_Tables.CompanyStatusConstants.setInactive	=> 8,
				0
			);
ds_slim_status := project(pInfile, transform({unsigned6 id,string1 inactive}, self.id := 
                                                                               map(idName = 'PROXID' => left.proxid, 
																																									 idName = 'SELEID' 	=> left.seleid, 
																																									 idName = 'ORGID' 	=> left.orgid, 
																																									 idName = 'ULTID' 	=> left.ultid, 
																																									 idName = 'POWID' 	=> left.POWID, 
																																										left.proxid)
                                                                            , self.inactive := 
                                                                               map(idName = 'PROXID' => left.proxid_status_private, 
																																									 idName = 'SELEID' 	=> left.seleid_status_private, 
																																									 idName = 'ORGID' 	=> left.orgid_status_private, 
																																									 idName = 'ULTID' 	=> left.ultid_status_private, 
																																									 idName = 'POWID' 	=> left.POWID_status_private, 
																																										left.proxid_status_private)
                                                                                    ));
shared ds_set_status_dedup := table(ds_slim_status  ,{id,inactive},id,inactive,merge);

// The lgid candidates file hasn't been renamed or put into the built superfile at this point,
// so need to use the original filename. But I also want it to work if this is rerun after the
// rename so using the original filename if exists, otherwise use the built version.
shared lgidCandKey := BIPV2_LGID3.Keys(BIPV2_LGID3.In_LGID3).Candidates;
shared lgidCandOpt := index(lgidCandkey, BIPV2_LGID3.Keys(BIPV2_LGID3.In_LGID3).CandidatesKeyName, opt);
shared lgidCandBuilt := BIPV2_LGID3.keys2(BIPV2_LGID3.In_LGID3).MatchCandidates.built;
shared lgidCand := if(exists(lgidCandOpt), pull(lgidCandOpt), pull(lgidCandBuilt));

shared infileWithLgid3Cand :=
	join(pInfile, dedup(lgidCand, lgid3, all),
		left.lgid3 = right.lgid3,
		transform({pInfile, hrec.has_lgid3_cand},
			self.has_lgid3_cand := right.lgid3 != 0;
			self := left), hash, limit(1), left outer);
shared input := distribute(project(infileWithLgid3Cand, transform(hrec, self.id := map(idName = 'PROXID' => left.proxid, 
																																									 idName = 'SELEID' 	=> left.seleid, 
																																									 idName = 'ORGID' 	=> left.orgid, 
																																									 idName = 'ULTID' 	=> left.ultid, 
																																										left.proxid), self := left)), hash(id));
	
// Cluster Record Count
t1 := table(sort(input, id, local), {id, unsigned reccnt := count(group)} , id, local);
// Append Record Count 
with_reccnt := project(t1, transform(seg_layout, self := left, self := []));
	
// Append core
core_s1   := sort(input, id, source, local);
core_t1  	:= table(core_s1, {id, source, unsigned cnt := count(group)}, id, source, local);
seg_layout doRollup(recordof(core_t1) l, DATASET(recordof(core_t1)) allRows) := TRANSFORM
	coreSource 	:= count(allRows(source in triCore));
	totalSource := count(allRows);
	totalRecs  	:= sum(allRows, cnt);
	
	self.idName	:= idName;
	self.id := l.id;
	self.core := map(coreSource = 3 => constants.Core_Tri,
									 coreSource = 2 => constants.Core_Dual,
									 coreSource <= 1 and totalSource > 1 and totalRecs > 1 => constants.Core_TrustedSrc,
									 coreSource <= 1 and totalSource = 1 and totalRecs > 1 => constants.Core_SingleSrc,
									 '');
	self := [];
end;
core_r1 := ROLLUP(group(sort(core_t1, id), id), GROUP, doRollup(LEFT, ROWS(LEFT)));
withCore := join(with_reccnt, core_r1, left.id = right.id, transform(recordof(left), self.core := right.core, self := left)); 
// Append emerging core
ecore_s1   	:= sort(input, id, -dt_last_seen, local);
// ecore_t1  	:= table(ecore_s1, {id, dt_last_seen, unsigned cnt := count(group)}, id, local);
ecore_t1  	:= table(ecore_s1, {id, unsigned4 dt_last_seen :=Max(group,dt_last_seen), unsigned cnt := count(group)}, id, local);
seg_layout xform_ecore(withCore l, ecore_t1 r) := transform
	lastSeenDate 	:= (string8)r.dt_last_seen;
	self.emergingCore := if(l.reccnt = 1 and ut.DaysApart(today, lastSeenDate) <= twoYears, constants.Ecore_SingleSrcSingleton, '');
	self.inactive			:= if(                 ut.DaysApart(today, lastSeenDate) >  twoYears, constants.Inactive_NoActivity, '');
	self := l;
end;
withECore := join(withCore, ecore_t1, left.id = right.id, xform_ecore(left, right), left outer); 
// Append active status
/*
reported_inactive := dedup(sort(input(company_status_derived != ''), id, -dt_last_seen, -rankStatus(company_status_derived), local), id);//check the most recent status
seg_layout xform_inactive(withECore l, reported_inactive r) := transform
	lastSeenDate 	:= (string8)r.dt_last_seen;
	self.inactive			:= 
	map(
		r.id = 0	=> l.inactive,
			//a bit confusing (But intended), setInactive just gets you flagged as "no activity", setDefunct gets you "reported inactive"
		r.company_status_derived in BIPV2.BL_Tables.CompanyStatusConstants.setDefunct 	=> constants.Inactive_Reported, 
		r.company_status_derived in BIPV2.BL_Tables.CompanyStatusConstants.setInactive 	=> constants.Inactive_NoActivity, 
		l.inactive
	);
								
	self := l;
end;
*/
// withInactive0 := join(withEcore, reported_inactive, left.id = right.id, xform_inactive(left, right), left outer);
////////
seg_layout xform_inactive(withECore l, ds_set_status_dedup r) := transform
	self.inactive			:= r.inactive;
	self := l;
end;
export withInactive0 := join(withEcore, ds_set_status_dedup, left.id = right.id, xform_inactive(left, right), left outer,keep(1)); 
////////
// lksd.o(with_reccnt)
// lksd.o(withCore)
// lksd.o(withECore)
// lksd.o(withInactive0)
shared withInactive := withInactive0; 
export result := withInactive;
/* -------------------------------------------------------------------- */
// export activeClusters 	:= withInactive(inactive = '');
// export coreClusters 		:= distribute(activeClusters(core != ''), hash(id));
// export ecoreClusters 		:= distribute(activeClusters(emergingCore != ''), hash(id));
export inactiveClusters := distribute(withInactive(inactive != ''), hash(id));
/*
tCore0 	:= table(sort(coreClusters, core, local), 	{core, unsigned4 cnt := count(group)}, core, local);
tCore 	:= table(sort(tcore0,  core), {core, string20 segtype := constants.core, unsigned4 total:=sum(group,cnt)}, core);
teCore0 := table(sort(ecoreClusters, emergingCore, local), 	{emergingCore, unsigned4 cnt := count(group)}, emergingCore, local);
teCore 	:= table(sort(teCore0,  emergingCore), {emergingCore, string20 segtype := constants.ecore, unsigned4 total:=sum(group,cnt)}, emergingcore);
tinactive0 	:= table(sort(inactiveClusters, inactive, local), 	{inactive, unsigned4 cnt := count(group)}, inactive, local);
tinactive 	:= table(sort(tinactive0,  inactive), {inactive, string20 segtype := constants.inactive, unsigned4 total:=sum(group,cnt)}, inactive);
export stats := project(tcore,     transform(layouts.stats_layout, self.segSubType := BIPV2_PostProcess.constants.fCoreDesc(left.core), self := left)) +
								project(tecore,    transform(layouts.stats_layout, self.segSubType := BIPV2_PostProcess.constants.fECoreDesc(left.emergingCore), self := left)) +
								project(tinactive, transform(layouts.stats_layout, self.segSubType := BIPV2_PostProcess.constants.fInactiveDesc(left.inactive), self := left));
*/
WithHeader0 := 
	join(
		distribute(result, hash(ID)),
		input,
    left.ID = right.ID
		,transform(
			{result, hrec/*, string50 source_decoded, string50 source_decoded_plus*/}, 
			// self.source_decoded := mdr.sourceTools.fTranslateSource(right.source),
			self.source_decoded_w_type := 
			map
				(right.source in BIPV2_PostProcess.constants.tricore 						=> '(**CORE**): ', 
				 right.source in BIPV2_PostProcess.constants.secondTierSources  => '(*2nd Tier*): ',
				'') + mdr.sourceTools.fTranslateSource(right.source),
			self.company_status_derived_w_date := if(right.company_status_derived = '', '', trim(right.company_status_derived, left, right) + ' ' + ((string)right.dt_last_seen)[1..6] + ' ' + mdr.sourceTools.fTranslateSource(right.source)),
			// self.fein := if(right.company_fein <> '', 'Y', ''); 
			// self.ebr := if(right.ebr_file_number <> '', 'Y', ''); 
			// self.duns := if(right.active_duns_number <> '', 'A', if(right.hist_duns_number <> '', 'H', '')); 
			// self.lnca := if(right.active_enterprise_number <> '', 'A', if(right.hist_enterprise_number <> '', 'H', '')); 
			// self.corp := 
			// map(
				// right.active_domestic_corp_key	<> '' => 'A',
				// right.hist_domestic_corp_key		<> '' => 'H',
				// right.foreign_corp_key		<> '' => 'F',
				// right.unk_corp_key	<> '' => 'U',
				// ''
			// );
			self := left,
			self := right
		),
		keep(25000),
		local
	);
// lksd.oc(WithHeader0)
{WithHeader0} whx(WithHeader0 le, Advo.Key_Addr1 ri) :=
transform
	self.addr_type :=
				map(ri.Residential_or_Business_Ind = 'A'		=> 'R',
						ri.Residential_or_Business_Ind = 'B'		=> 'B',			
						le.addr_type);
	self := le;
end;
//add addr type
WithHeader_pull := 
	join(
		WithHeader0,
		pull(Advo.Key_Addr1),
			left.zip = right.zip and 
			left.prim_range = right.prim_Range and
			left.prim_name = right.prim_name and			
			left.sec_range = right.sec_range		
		,whx(left, right),
		keep(1),
		left outer ,hash
	);
WithHeader_keyed := 
	join(
		WithHeader0,
		Advo.Key_Addr1,
			keyed(left.zip = right.zip) and 
			keyed(left.prim_range = right.prim_Range) and
			keyed(left.prim_name = right.prim_name) and			
			left.sec_range = right.sec_range
		,whx(left, right),
		keep(1),
		left outer
	);
	
WithHeader := if(count(WithHeader0) > 1000000, WithHeader_pull, WithHeader_keyed);
// lksd.oc(WithHeader)
WithHeaderDatesRolledGrpd :=
iterate(
	sort(group(sort(distribute(WithHeader, hash(ID)), ID, local), ID, local), -dt_last_seen),
	transform(
		{WithHeader},
		// self.dt_first_seen := if (left.dt_first_seen < right.dt_first_seen and left.dt_first_seen != 0, left.dt_first_seen, right.dt_first_seen);
		self.dt_last_seen := if (left.dt_last_seen > right.dt_last_seen, left.dt_last_seen, right.dt_last_seen);
		self := right
	)
);
WithHeaderDatesRolled := ungroup(WithHeaderDatesRolledGrpd);
// lksd.oc(WithHeaderDatesRolled)
	// parallel(
		// output(choosen(enth(myk, 1000), 1000), named('full_flat_enth1K_'+s)),
WithHeaderRolled1 :=tools.mac_AggregateFieldsPerID( WithHeaderDatesRolled, ID,,FALSE);
WithHeaderRolled0 := WithHeaderRolled1 : persist('~thor_data400::BIPV2_PostProcess.segmentation_gold_'+idName+outputNameModifier);
// lksd.ec(WithHeaderRolled1)
// lksd.ec(WithHeaderRolled0)
WithHeaderRolled := 
project(
	WithHeaderRolled0,
	transform(
		{WithHeaderRolled0, unsigned2 cnt_sources := 0, unsigned2 cnt_core_sources_total := 0, unsigned2 cnt_core_sources_super := 0, unsigned2 cnt_core_sources_other := 0, unsigned2 cnt_2t_sources := 0, unsigned2 cnt_corp_sources, unsigned2 cnt_bizreg_sources},
		self.cnt_sources := count(left.sources),
		self.cnt_core_sources_total := count(left.sources(source in BIPV2_PostProcess.constants.tricore)),
		self.cnt_core_sources_super := count(left.sources(source in BIPV2_PostProcess.constants.SuperCore)),
		self.cnt_core_sources_other := count(left.sources(source in BIPV2_PostProcess.constants.tricore, source not in BIPV2_PostProcess.constants.SuperCore)),
		self.cnt_2t_sources :=  count(left.sources(source in BIPV2_PostProcess.constants.secondTierSources)),
		self.cnt_corp_sources := count(left.sources(source in MDR.sourceTools.set_CorpV2)),
		self.cnt_bizreg_sources := count(left.sources(source in BIPV2_PostProcess.constants.bizRegSources)),
		self := left
	)
);
		
// lksd.ec(WithHeaderRolled)
//ATTRIBUTES
//active
shared AddBackNew := WithHeaderRolled;
// isActive := AddBackNew.new_segtype <> 'INACTIVE';
shared isActive := ~exists(AddBackNew.inactives(inactive != ''));
//address
shared isRes := exists(AddBackNew.addr_types(addr_type = 'R')) and count(AddBackNew.addr_types) = count(AddBackNew.addr_types(addr_type = 'R'));
shared hasBizAddr := exists(AddBackNew.addr_types(addr_type = 'B'));
shared isJustPOBox := exists(AddBackNew.prim_names(prim_name[1..6] = 'PO BOX')) and count(AddBackNew.prim_names) = count(AddBackNew.prim_names(prim_name[1..6] = 'PO BOX'));
shared isNotJustPOBox := ~isJustPOBox;
//sources
shared hasMultipleSources := AddBackNew.cnt_sources > 1;
shared hasOtherCoreSrc := AddBackNew.cnt_core_sources_other > 0;
shared hasSuperCoreSrc := AddBackNew.cnt_core_sources_super > 0;
shared no2TSrc 	:= AddBackNew.cnt_2t_sources = 0;
shared has2TSrc 	:= ~no2TSrc;
shared noBizRegSrc 	:= AddBackNew.cnt_BizReg_sources = 0;
shared hasBizRegSrc 	:= ~noBizRegSrc;
shared noCorpSrc 	:= AddBackNew.cnt_Corp_sources = 0;
shared hasCorpSrc 	:= ~noCorpSrc;
shared isJustCorp	:= AddBackNew.cnt_Corp_sources = AddBackNew.cnt_sources;
shared isNotJustCorp := ~isJustCorp;
shared isJustBizReg	:= AddBackNew.cnt_BizReg_sources = AddBackNew.cnt_sources;
shared isNotJustBizReg := ~isJustBizReg;
shared isJustCorpAndBizReg := hasBizRegSrc and hasCorpSrc and AddBackNew.cnt_Corp_sources + AddBackNew.cnt_BizReg_sources = AddBackNew.cnt_sources;
//records
shared hasMultipleRecords := AddBackNew.reccnts[1].reccnt > 1;
shared inHrchy := exists(AddBackNew.has_lgids(has_lgid));
shared isLgid3Linkable := exists(AddBackNew.has_lgid3_cands(has_lgid3_cand));
		
shared isGold := 
	isActive
	AND isNotJustPOBox
	AND (inHrchy OR isLgid3Linkable)
	AND (
		hasSuperCoreSrc 
		OR 
		((hasOtherCoreSrc or has2TSrc) and hasMultipleSources)
	);			
shared Gold := AddBackNew(isGold);
shared NotGold := AddBackNew(~isGold);
shared abn := table(AddBackNew, {AddBackNew, isGold, isActive, isNotJustPOBox, hasSuperCoreSrc, hasOtherCoreSrc, has2TSrc, hasMultipleSources, hasBizAddr});
shared attrec := record
	abn.isGold;
	abn.isActive;
	abn.hasSuperCoreSrc;
	abn.hasOtherCoreSrc;
	abn.has2TSrc;
	abn.hasMultipleSources;
	abn.hasBizAddr;
	abn.isNotJustPOBox;
	cnt := count(group);
	pct_of_all 				:= (integer)(100 * count(group) / count(abn));
	pct_of_gold 			:= (integer)(100 * count(group) / count(Gold));
	pct_of_not_gold 	:= (integer)(100 * count(group) / count(NotGold));
end;
shared atttab0 := table(abn, attrec, isGold, isActive, isNotJustPOBox, hasSuperCoreSrc, hasOtherCoreSrc, has2TSrc, hasMultipleSources, hasBizAddr);
shared atttab :=
sort(
	project(
		atttab0,
		transform(
			{attrec, string description},
			self.pct_of_gold 			:= if(left.isGold,  left.pct_of_gold, 0);
			self.pct_of_not_gold 	:= if(~left.isGold, left.pct_of_not_gold, 0);
			self.description :=
			 if(left.isgold, 						'Gold: ', 																'Not Gold: ')
			+if(left.isActive, 					'Active, ',																'Inactive, ')
			+if(left.hasSuperCoreSrc, 	'Has LNCA, ', 														'No LNCA, ')
			+if(left.hasOtherCoreSrc, 	'Has 1 or more of DMI/EBR, ', 						'No DMI/EBR, ')
			+if(left.has2TSrc, 					'Has 1 or more second tier source, ', 		'No second tier source, ')
			+if(left.hasMultipleSources,'Has 2 or more total sources, ', 					'Has 1 total source, ')
			+if(left.isNotJustPOBox,		'', 																			'Only has PO Box, ')
			+if(left.hasBizAddr,				'At Business Address ', 									'At Residential or Unknown Address ')
			;
			self := left;
		)
	)
, -cnt
);
// *** this part looks duplicated.  its the same ECL but with a source breakdown.  i am not sure if there is a cleaner way to code this (macro?)
// shared msrc(i) := macro
	// sort(left.sources, source)[i].source + ' '
// endmacro;
shared abn_src := 
project(
	abn,
	transform(
		{abn, string str_sources},
    top15_sources     := topn(left.sources,15,source);
		self.str_sources  := top15_sources[1].source+' '+top15_sources[2].source+' '+top15_sources[3].source+' '+top15_sources[4].source+' '+top15_sources[5].source+' '+top15_sources[6].source+' '+top15_sources[7].source+' '+top15_sources[8].source+' '+top15_sources[9].source+' '+top15_sources[10].source+' '+top15_sources[11].source+' '+top15_sources[12].source+' '+top15_sources[13].source+' '+top15_sources[14].source+' '+top15_sources[15].source,
		self              := left
	)
);
shared attrec_src := record
	abn_src.isGold;
	abn_src.isActive;
	abn_src.hasSuperCoreSrc;
	abn_src.hasOtherCoreSrc;
	abn_src.has2TSrc;
	abn_src.hasMultipleSources;
	abn_src.hasBizAddr;
	abn_src.isNotJustPOBox;
	abn_src.str_sources;
	cnt := count(group);
	pct_of_all 				:= (integer)(100 * count(group) / count(abn));
	pct_of_gold 			:= (integer)(100 * count(group) / count(Gold));
	pct_of_not_gold 	:= (integer)(100 * count(group) / count(NotGold));
end;
shared atttab0_src := table(abn_src, attrec_src, isGold, isActive, isNotJustPOBox, hasSuperCoreSrc, hasOtherCoreSrc, has2TSrc, hasMultipleSources, hasBizAddr, str_sources,merge);
shared atttab_src :=
// sort(
	project(
		atttab0_src,
		transform(
			{attrec_src, string description},
			self.pct_of_gold 			:= if(left.isGold,  left.pct_of_gold, 0);
			self.pct_of_not_gold 	:= if(~left.isGold, left.pct_of_not_gold, 0);
			self.description :=
			 if(left.isgold, 						'Gold: ', 																'Not Gold: ')
			+if(left.isActive, 					'Active, ',																'Inactive, ')
			+if(left.hasSuperCoreSrc, 	'Has LNCA, ', 														'No LNCA, ')
			+if(left.hasOtherCoreSrc, 	'Has 1 or more of DMI/EBR, ', 						'No DMI/EBR, ')
			+if(left.has2TSrc, 					'Has 1 or more second tier source, ', 		'No second tier source, ')
			+if(left.hasMultipleSources,'Has 2 or more total sources, ', 					'Has 1 total source, ')
			+if(left.isNotJustPOBox,		'', 																			'Only has PO Box, ')
			+if(left.hasBizAddr,				'At Business Address ', 									'At Residential or Unknown Address ')
			;
			self := left;
		)
	// )
// , -cnt
);
shared ostring := idName + ' ' + outputNameModifier;
export _gold := gold;
export _NotGold := NotGold;
export out := 
parallel(
	output(count(gold), named('count_Gold_'+ostring))
	,output(enth(gold, 500), {gold, isActive, isNotJustPOBox, hasSuperCoreSrc, hasOtherCoreSrc, has2TSrc, hasMultipleSources, hasBizAddr}, all, named('ent_Gold_'+ostring))
	,output(count(NotGold), named('count_NotGold_'+ostring))
	,output(enth(NotGold, 500), {NotGold, isActive, isNotJustPOBox, hasSuperCoreSrc, hasOtherCoreSrc, has2TSrc, hasMultipleSources, hasBizAddr},all, named('ent_NotGold_'+ostring))	
	// ,output(enth(NotGold(~isNotJustPOBox,hasBizAddr) , 500), {NotGold, isActive, isNotJustPOBox, hasSuperCoreSrc, hasOtherCoreSrc, has2TSrc, hasMultipleSources, hasBizAddr},all, named('ent_NotGold_BizAddr_POBOX'+ostring))	
	// ,output(count(AddBackNew(hasSuperCoreSrc,hasMultipleSources)), named('cnt_LNCA_multiple_src'))
	// ,output(count(AddBackNew(hasSuperCoreSrc,~hasMultipleSources)), named('cnt_LNCA_only_src'))	
	// ,output(enth(AddBackNew(hasSuperCoreSrc,hasMultipleSources) , 500), {NotGold, isActive, isNotJustPOBox, hasSuperCoreSrc, hasOtherCoreSrc, has2TSrc, hasMultipleSources, hasBizAddr},all, named('ent_LNCA_multiple_src'+ostring))	
	// ,output(enth(AddBackNew(hasSuperCoreSrc,~hasMultipleSources) , 500), {NotGold, isActive, isNotJustPOBox, hasSuperCoreSrc, hasOtherCoreSrc, has2TSrc, hasMultipleSources, hasBizAddr},all, named('ent_LNCA_only_src'+ostring))	
	// ,output(choosen(AddBackNew, 500), named('AddBackNew'))
	// ,output(choosen(abn, 500), named('abn'))
	// ,output(choosen(abnsrc, 500), named('abnsrc'))
	,output(atttab,all, named('Attribute_Table_'+ostring))	
	,output(atttab(isGold),all, named('Attribute_Table_Gold_'+ostring))	
	,output(atttab(~isGold),all, named('Attribute_Table_Not_Gold_'+ostring))	
	,output(topn(atttab_src(isGold),1000,-cnt), named('Attribute_Table_Gold_BySource'+ostring))	
	,output(topn(atttab_src(~isGold),1000,-cnt), named('Attribute_Table_Not_Gold_BySource'+ostring))		
	
	// ,output(_gold,,'~thor_data400::cemtemp::gold_new_'+ostring)
	// ,output(AddBackNew(isActive),,'~thor_data400::cemtemp::active', overwrite)
);
END;
