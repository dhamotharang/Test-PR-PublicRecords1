//Run this in a build window before platform and after platform change and write down the corresponding Workunits, 
//respectively. The workunits need to go to QA_PlateFormComparisonSummary as WU_BeforUpgrade and WU_BeforUpgrade 

#workunit('priority','high');
import BIPV2,BIPV2_DotID,bipv2_dotId_Platform,BIPV2_Build, DCAV2,DNB_DMI,frandx,BIPv2_HRCHY,bipv2_hrchy_platform,BIPV2_LGID3,bipv2_lgid3_platform,BIPV2_Files,BIPV2_Tools,BIPV2_ProxID, bipv2_proxid_platform,SALT30,SALT33;

mac_i(dataset(BIPV2.CommonBase.Layout) ds, string s, string i) :=function
	ds_in	:= table(ds, {rcid,dotid,proxid,lgid3,powid,empid,orgid,ultid,seleid});
	return parallel(
		output(BIPV2_DotID_Platform.Fields.UIDConsistency(ds).Advanced0, named('integrity1_' + s + i))
		,BIPV2_Tools.idIntegrity(ds).custom(ds_in,rcid,proxid	,'prox_sele_' + s + i		,false,true,seleid)
		,BIPV2_Tools.idIntegrity(ds).custom(ds_in,rcid,lgid3	,'lgid3_sele_' + s + i	,false,true,seleid)
		,BIPV2_Tools.idIntegrity(ds).custom(ds_in,rcid,seleid	,'sele_org_' + s + i		,false,true,orgid)
		,output(count(dedup(ds(proxid > 0), proxid, all)), named('proxid_count_' + s + i))
		,output(count(dedup(ds(lgid3 > 0), lgid3, all)),   named('lgid3_count_' + s + i))
		,output(count(dedup(ds(seleid > 0), seleid, all)), named('seleid_count_' + s + i))
		,output(count(dedup(ds(orgid > 0), orgid, all)),   named('orgid_count_' + s + i))
		,output(count(dedup(ds(ultid > 0), ultid, all)),   named('ultid_count_' + s + i))
		// output(s+i)
	);
end;	

doiter(
	dataset(BIPV2.CommonBase.Layout) Infile, //dataset(BIPV2.CommonBase.Layout) Infile,
	dataset(DCAV2.layouts.Base.companies) 					mylncad,							
	dataset(recordof(BIPV2_Files.files_hrchy.duns)) mydunsd,							
	dataset(Frandx.layouts.Base)										myfrand,
	string iter,		
	boolean ResetAboveProx
	) := FUNCTION
	string i := iter + if(ResetAboveProx, '_yes_reset', '_no_reset');
	Mykeyversion := '20990909';
	output(count(Infile), named('count_Infile')); 
	wDot := BIPV2_Build.proc_dotid().inline_iteration(ds := if(ResetAboveProx,/*BIPV2_Tools.idIntegrity().blank_above_prox(Infile)*/infile(false) ,BIPV2_Tools.idIntegrity().blank_above_lgid3(Infile)));// : persist('~thor::persist.cemtemp.wDot'+i);
	output(count(wDot),named('count_wDot'));		
			
	wProx := project(          
		BIPV2_ProxID_Platform.Proc_Iterate
			(iter := iter
			,keyversion := Mykeyversion
			,InFile0 := project(wDot, BIPV2_ProxID_Platform.Layout_DOT_Base)
			).MM.patched_infile, transform(bipv2.commonbase.layout, self := left, self := []));// : persist('~thor::persist.cemtemp.wProx'+i);	
output(count(wProx),named('count_wProx'));				
			
	wHrchy :=          
		BIPv2_HRCHY_Platform.mod_Build
		(head := project(wProx, transform(BIPV2_Files.layout_proxid, self := left, self := []))
		,lncad := mylncad
		,dunsd := mydunsd
		,frand := myfrand).PatchedFile;// : persist('~thor::persist.cemtemp.wHrchy'+i);
output(count(wHrchy),named('count_wHrchy'));

	wLGID3 := BIPV2_LGID3_Platform._proc_lgid3().inline_iteration(ds := wHrchy);// : persist('~thor::persist.cemtemp.wLGID3'+i);
  output(count(wLGID3),named('count_wLGID3'));
	
string TestUse :=if(BIPV2_Testing.Constants.PlatFormTest='', '', BIPV2_Testing.Constants.PlatFormTest +'::');
		sequential(
			 output('ResetAboveProx set to ' + if(ResetAboveProx, 'TRUE', 'FALSE') + ' in iter ' + iter)
			,output(Infile,,'~thor::cemtemp::' + TestUse + 'Infile'+i, overwrite)
			,mac_i(Infile, 'Infile', i)
			,output(wDot,,'~thor::cemtemp::' + TestUse + 'wDot'+i, overwrite)
			,mac_i(wDot, 'Dot', i)
			,output(wProx,,'~thor::cemtemp::' + TestUse + 'wProx'+i, overwrite)
			,mac_i(wProx, 'Prox', i)
			,output(wHrchy,,'~thor::cemtemp::' + TestUse + 'wHrchy'+i, overwrite)
			,mac_i(wHrchy, 'Hrchy', i)
			,output(wLGID3,,'~thor::cemtemp::' + TestUse + 'wLGID3'+i, overwrite)
			,mac_i(wLGID3, 'LGID3', i)
		);
	return wLGID3;
	// return wHrchy;
	// return wProx;
END;//doiter
	
  cb := bipv2.CommonBase.DS_BUILT;
	
	//Infile :=  choosen(dataset('~thor::cemtemp::myrecs2', recordof(cb), thor), 10000);
	Infile :=  choosen(cb, 10000);
	//Infile :=  choosen(dataset('~thor::cemtemp::myrecs2', rrrr, thor), 10000);
	mylncad := choosen(dataset('~thor::persist.cemtemp.mylncad', DCAV2.layouts.Base.companies, thor), 10000);
	mydunsd := choosen(dataset('~thor::persist.cemtemp.mydunsd', DNB_DMI.layouts.base.CompaniesForBIP2, thor), 10000);							
	myfrand := choosen(dataset('~thor::persist.cemtemp.myfrand', frandx.layouts.Base, thor), 10000);
	
	//infile   := dataset('~thor::cemtemp::myrecs2', recordof(cb), thor);
	//mylncad  := dataset('~thor::persist.cemtemp.mylncad', DCAV2.layouts.Base.companies, thor);
	//mydunsd  := dataset('~thor::persist.cemtemp.mydunsd', DNB_DMI.layouts.base.CompaniesForBIP2, thor);
	//myfrand  := dataset('~thor::persist.cemtemp.myfrand', frandx.layouts.Base, thor);
  
	
	do1F := doiter(Infile	,mylncad,mydunsd,myfrand,'1',ResetAboveProx := FALSE)	;
	output(do1F,,'~thor::cemtemp::do1F',overwrite);
	
	// do1F := dataset('~thor::cemtemp::do1F', BIPV2.CommonBase.Layout, thor);
	// do2F := doiter(do1F		,mylncad,mydunsd,myfrand,'2',ResetAboveProx := FALSE)	;	
	// output(do2F,,'~thor::cemtemp::do2F',overwrite);
	