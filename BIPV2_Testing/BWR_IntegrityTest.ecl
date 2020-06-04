/*
This was developed specifically for bug 164557 but I expect it to have future value.  That bug has several WUs listed for reference.
The idea is that you can run a test file through multiple levels of the linking and test the ID Integrity after each.
This is set up specifically for the order of the build as it stands today (201504).  That order may change.



*/

import BIPV2;
mac_i(dataset(BIPV2.CommonBase.Layout) ds, string s, string i) :=
function

	ds_in	:= table(ds, {rcid,dotid,proxid,lgid3,powid,empid,orgid,ultid,seleid});

	return parallel(
		output(BIPV2_DotID.Fields.UIDConsistency(ds).Advanced0, named('integrity1_' + s + i))
		,BIPV2_Tools.idIntegrity(ds).custom(ds_in,rcid,proxid	,'prox_sele_' + s + i		,false,true,seleid)
		,BIPV2_Tools.idIntegrity(ds).custom(ds_in,rcid,lgid3	,'lgid3_sele_' + s + i	,false,true,seleid)
		,BIPV2_Tools.idIntegrity(ds).custom(ds_in,rcid,seleid	,'sele_org_' + s + i		,false,true,orgid)
		,output(count(dedup(ds(proxid > 0), proxid, all)), named('proxid_count_' + s + i))
		,output(count(dedup(ds(lgid3 > 0), lgid3, all)), named('lgid3_count_' + s + i))
		,output(count(dedup(ds(seleid > 0), seleid, all)), named('seleid_count_' + s + i))
		,output(count(dedup(ds(orgid > 0), orgid, all)), named('orgid_count_' + s + i))
		,output(count(dedup(ds(ultid > 0), ultid, all)), named('ultid_count_' + s + i))
		// output(s+i)
	);
	
end;	



	
//and consider filtering these out entirely in your sandbox (proxid attribute files)
// BIPV2_ProxID.file_SrcRidVlid
// BIPV2_ProxID.file_Foreign_Corpkey
// BIPV2_ProxID.file_RA_Addresses
// BIPV2_ProxID.file_filter_Prim_names

doiter(
	dataset(BIPV2.CommonBase.Layout) Infile,
	dataset(DCAV2.layouts.Base.companies) 					mylncad,							
	dataset(recordof(BIPV2_Files.files_hrchy.duns)) mydunsd,							
	dataset(Frandx.layouts.Base)										myfrand,
	string iter,		
	boolean ResetAboveProx
	
) := FUNCTION

	string i := iter + if(ResetAboveProx, '_yes_reset', '_no_reset');
	Mykeyversion := '20990909';

	wDot := BIPV2_Build.proc_dotid().inline_iteration(ds := if(ResetAboveProx,/*BIPV2_Tools.idIntegrity().blank_above_prox(Infile)*/infile(false) ,BIPV2_Tools.idIntegrity().blank_above_lgid3(Infile))) : persist('~thor::persist.cemtemp.wDot'+i);
			
	wProx :=           
		BIPV2_ProxID.Proc_Iterate
			(iter := iter
			,keyversion := Mykeyversion
			,InFile0 := project(wDot, BIPV2_ProxID.Layout_DOT_Base)
			).MM.patched_infile : persist('~thor::persist.cemtemp.wProx'+i);	
			
	wHrchy :=          
		BIPv2_HRCHY.mod_Build
		(head := project(wProx, BIPV2_Files.layout_proxid)
		,lncad := mylncad
		,dunsd := mydunsd
		,frand := myfrand).PatchedFile : persist('~thor::persist.cemtemp.wHrchy'+i);

	wLGID3 := BIPV2_LGID3._proc_lgid3().inline_iteration(ds := wHrchy) : persist('~thor::persist.cemtemp.wLGID3'+i);

		sequential(
			 output('ResetAboveProx set to ' + if(ResetAboveProx, 'TRUE', 'FALSE') + ' in iter ' + iter)
			,output(Infile,,'~thor::cemtemp::Infile'+i, overwrite)
			,mac_i(Infile, 'Infile', i)
			,output(wDot,,'~thor::cemtemp::wDot'+i, overwrite)
			,mac_i(wDot, 'Dot', i)
			,output(wProx,,'~thor::cemtemp::wProx'+i, overwrite)
			,mac_i(wProx, 'Prox', i)
			,output(wHrchy,,'~thor::cemtemp::wHrchy'+i, overwrite)
			,mac_i(wHrchy, 'Hrchy', i)
			,output(wLGID3,,'~thor::cemtemp::wLGID3'+i, overwrite)
			,mac_i(wLGID3, 'LGID3', i)
		);
	return wLGID3;
	// return wHrchy;
	// return wProx;

END;//doiter


	//ver small samples 
	// Infile := choosen(bipv2.CommonBase.ds_prod, 50);
	// mylncad := choosen(BIPV2_Files.files_hrchy.lnca, 50);						
	// mydunsd := choosen(BIPV2_Files.files_hrchy.duns, 50);							
	// myfrand := choosen(BIPV2_Files.files_hrchy.fran, 50);	
	
	//sample where results might actually mean something
	cb := bipv2.CommonBase.ds_prod;
	cb_random := enth(cb, 1000);
	cb_lgid3 := enth(cb(cnt_prox_per_lgid3 > 1 and nodes_total = 0), 300);
	cb_sele := enth(cb(nodes_total > 1), 300);
	cb_boca := cb(p_city_name = 'BOCA RATON' and company_name[1] = 'M' and company_name_type_derived = 'LEGAL');
	myults := dedup(cb_random + cb_lgid3 + cb_sele + cb_boca, ultid, all);
	// Infile0 := join(cb, myults, left.ultid = right.ultid, transform(left), hash);
	Infile0 := dataset('~thor::cemtemp::myrecs.dl2', recordof(cb), thor);
	t := table(infile0, {ultid, cnt := count(Group)}, ultid);
	// Infile := join(Infile0, t(cnt < 10000), left.ultid = right.ultid, transform(left), hash);
	// output(infile,,'~thor::cemtemp::myrecs2',overwrite);
	infile := dataset('~thor::cemtemp::myrecs2.dl2', recordof(cb), thor);

	mylncad := choosen(BIPV2_Files.files_hrchy.lnca, all) : persist('~thor::persist.cemtemp.mylncad');						
	mydunsd := choosen(BIPV2_Files.files_hrchy.duns, all) : persist('~thor::persist.cemtemp.mydunsd');							
	myfrand := choosen(BIPV2_Files.files_hrchy.fran, all) : persist('~thor::persist.cemtemp.myfrand');	

	// --- you may want/need to build specificities first.  if so, run these next 4 lines
	// Infile_Layout_Dot 			:= project(Infile, BIPV2_DotID.Layout_DOT);
	// Infile_Layout_Dot_Base 	:= project(Infile, BIPV2_ProxID.Layout_DOT_Base);
	// Infile_Layout_LGID3 := project(Infile, BIPV2_LGID3.Layout_LGID3);
	// BIPV2_DotID.specificities(Infile_Layout_Dot).Build;
	// BIPV2_ProxID.specificities(Infile_Layout_Dot_Base).Build;
	// BIPV2_LGID3.specificities(Infile_Layout_LGID3).Build;

	// do1T := doiter(Infile	,mylncad,mydunsd,myfrand,'1',ResetAboveProx := TRUE)	;
	// output(do1T,,'~thor::cemtemp::do1T',overwrite);//W20150331-160530
	// do2T := doiter(do1T		,mylncad,mydunsd,myfrand,'2',ResetAboveProx := TRUE)	;
	// output(do2T,,'~thor::cemtemp::do2T',overwrite);
	
	do1F := doiter(Infile	,mylncad,mydunsd,myfrand,'1',ResetAboveProx := FALSE)	;
	output(do1F,,'~thor::cemtemp::do1F',overwrite);
	// do1F := dataset('~thor::cemtemp::do1F', BIPV2.CommonBase.Layout, thor);
	// do2F := doiter(do1F		,mylncad,mydunsd,myfrand,'2',ResetAboveProx := FALSE)	;	
	// output(do2F,,'~thor::cemtemp::do2F',overwrite);
