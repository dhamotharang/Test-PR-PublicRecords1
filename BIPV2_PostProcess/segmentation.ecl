import BIPV2_Files, ut, BIPV2_PROX_SALT_int_fullfile,BIPv2_HRCHY,BIPV2,BIPV2_Tools;
EXPORT segmentation(
   // dataset(BIPv2_HRCHY.Layouts.HrchyBase ) pInfile  = project(bipv2.CommonBase.DS_CLEAN,BIPv2_HRCHY.Layouts.HrchyBase)
   dataset(BIPV2.CommonBase.layout )  pInfile  = BIPV2.CommonBase.DS_CLEAN
  ,string                             idName   = 'PROXID'
	,string                             today 	 = bipv2.KeySuffix_mod2.MostRecentWithIngestVersionDate//in case you want to run as of a date in the past.  default to date of newest data.
  
) := module
	shared triCore 			:= constants.triCore; 
	shared seg_layout 	:= layouts.laysegmentation;
	shared integer twoYears := 730;
	shared integer eighteenMonths := 548;
	shared integer sixMonths := 180;
	shared activeStatus := ['ACTIVE'];
///////	
ds_slim_status := project(pInfile, transform({unsigned6 id,string1 inactive,string1 status_score}
  ,self.id        :=   map(  idName = 'PROXID'  => left.proxid 
                            ,idName = 'SELEID'  => left.seleid 
                            ,idName = 'ORGID'   => left.orgid 
                            ,idName = 'ULTID' 	=> left.ultid 
                            ,idName = 'POWID' 	=> left.POWID 
                            ,                      left.proxid
                       )

        
  ,self.inactive  :=  map(  idName = 'PROXID' => left.proxid_status_private 
                           ,idName = 'SELEID' => left.seleid_status_private
                           ,idName = 'ORGID' 	=> left.orgid_status_private
                           ,idName = 'ULTID' 	=> left.ultid_status_private
                           ,idName = 'POWID' 	=> left.POWID_status_private
                           ,                     left.proxid_status_private
                      )
   
  ,self.status_score :=  if(   idName = 'SELEID'  ,(string1)left.seleid_status_private_score 
                              ,                    ''
                        )
  ));
  
shared ds_set_status_dedup := table(ds_slim_status  ,{id,inactive,status_score},id,inactive,status_score,merge);
/////////
	shared proxFile := project(pinfile, BIPV2_PostProcess.layouts.slim_layout_v1) : 
	// persist('~thor::persist::BIPV2_PostProcess::segmentation.proxFile');
	independent;
	
	shared slim_layout := record
		unsigned6 	rcid;
		unsigned6 	id;
		string2   	source;
		unsigned4 	dt_first_seen;
		unsigned4 	dt_last_seen;
		string30   	company_status_derived;
	end;	
	
// Slim prox layout
// proxfile := BIPV2_Files.files_proxid().DS_PROXID_BASE;//(proxid = 8);
// proxfile_in := if(count(proxFile) = 0, BIPV2_PROX_SALT_int_fullfile.Files().base.qa, proxFile);
export input := distribute(project(proxfile, transform(slim_layout, self.id := map(idName = 'PROXID' => left.proxid, 
																																									 idName = 'SELEID' 	=> left.seleid, 
																																									 idName = 'ORGID' 	=> left.orgid, 
																																									 idName = 'ULTID' 	=> left.ultid, 
																																									 idName = 'POWID' 	=> left.POWID, 
																																									 idName = 'EMPID' 	=> left.EMPID, 
																																										left.proxid), self := left)), id);
	
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
ecore_t1    := table(ecore_s1, {id, unsigned4 dt_last_seen :=Max(group,dt_last_seen), unsigned cnt := count(group)}, id, local);
seg_layout xform_ecore(withCore l, ecore_t1 r) := transform
	lastSeenDate 	:= (string8)r.dt_last_seen;
	self.emergingCore := if(l.reccnt = 1 and ut.DaysApart(today, lastSeenDate) <= twoYears, constants.Ecore_SingleSrcSingleton, '');
	// self.inactive			:= if(                 ut.DaysApart(today, lastSeenDate) >  twoYears, constants.Inactive_NoActivity, '');
	self := l;
end;
withECore := join(withCore, ecore_t1, left.id = right.id, xform_ecore(left, right), left outer); 
// Append active status
// reported_inactive0 := dedup(sort(input(company_status_derived != ''), id, -dt_last_seen, local), id);
	//join to most recent record from this cluster to make sure we are only using statuses that are relatively recent
// reported_inactive := join(reported_inactive0, dedup(sort(input, id, -dt_last_seen, local), id, local), left.id = right.id and ut.DaysApart((string8)left.dt_last_seen, (string8)right.dt_last_seen) <= sixMonths, transform(left), local);
// seg_layout xform_inactive(withECore l, reported_inactive r) := transform
	// self.inactive			:= 
	// map(
		// r.company_status_derived in BIPV2.BL_Tables.CompanyStatusConstants.setDefunct 	=> constants.Inactive_Reported, 
		// r.company_status_derived in BIPV2.BL_Tables.CompanyStatusConstants.setInactive 	=> constants.Inactive_NoActivity, 
		// l.inactive);
	// self := l;
// end;
seg_layout xform_inactive(withECore l, ds_set_status_dedup r) := transform
	self.inactive			:= r.inactive;
  self.status_score := r.status_score;
	self := l;
end;
export withInactive := join(withEcore, ds_set_status_dedup, left.id = right.id, xform_inactive(left, right), left outer,keep(1)); 
/////
/////
// output(withcore);
// output(ecore_t1);
// output(withEcore);
// output(withInactive);
export result := withInactive;
/* -------------------------------------------------------------------- */
export activeClusters 	:= withInactive(inactive = '');
export coreClusters 		:= distribute(activeClusters(core != ''), id);
export ecoreClusters 		:= distribute(activeClusters(emergingCore != ''), id);
export inactiveClusters := distribute(withInactive(inactive != ''), id);
rec_w_desc := record
	result;
	string1 s1code;
	string desc;
end;
export result_w_desc := 
 project(coreClusters, 			transform(rec_w_desc, self.s1code :=	left.core, 					self.desc := BIPV2_PostProcess.constants.fCoreDesc(left.core), self := left))
+project(ecoreClusters, 		transform(rec_w_desc, self.s1code := 	left.emergingCore, 	self.desc := BIPV2_PostProcess.constants.fECoreDesc(left.emergingCore), self := left))
+project(inactiveClusters, 	transform(rec_w_desc, self.s1code := 	left.inactive, 			self.desc := BIPV2_PostProcess.constants.fInactiveDesc(left.inactive), self := left));
tCore0 	:= table(sort(coreClusters, core, local), 	{core, unsigned4 cnt := count(group)}, core, local);
tCore 	:= table(sort(tcore0,  core), {core, string20 segtype := constants.core, unsigned4 total:=sum(group,cnt)}, core);
teCore0 := table(sort(ecoreClusters, emergingCore, local), 	{emergingCore, unsigned4 cnt := count(group)}, emergingCore, local);
teCore 	:= table(sort(teCore0,  emergingCore), {emergingCore, string20 segtype := constants.ecore, unsigned4 total:=sum(group,cnt)}, emergingcore);
tinactive0 	:= table(sort(inactiveClusters, inactive, local), 	{inactive, unsigned4 cnt := count(group)}, inactive, local);
tinactive 	:= table(sort(tinactive0,  inactive), {inactive, string20 segtype := constants.inactive, unsigned4 total:=sum(group,cnt)}, inactive);
stats0 := project(tcore,     transform(layouts.stats_layout, self.segSubType := BIPV2_PostProcess.constants.fCoreDesc(left.core), self := left)) +
								project(tecore,    transform(layouts.stats_layout, self.segSubType := BIPV2_PostProcess.constants.fECoreDesc(left.emergingCore), self := left)) +
								project(tinactive, transform(layouts.stats_layout, self.segSubType := BIPV2_PostProcess.constants.fInactiveDesc(left.inactive), self := left));
// output(coreClusters, named('coreClusters'));
export stats := 
sort(stats0, segType, segSubType) &
project(
	dataset([{1}], {unsigned a}),
	transform(
		layouts.stats_layout,
		self.segType := '  TOTAL';
		self.segSubType := '  Active';
		self.total := sum(stats0(segType in [BIPV2_PostProcess.constants.Core, BIPV2_PostProcess.constants.Ecore]), total);
	)
);
		
		
end;
