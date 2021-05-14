export Proc_Misc_Tasks(filedate) := macro
import Bankruptcyv3,BankruptcyV2,RoxieKeyBuild,orbit_report,_Control,STD;;	

dummy_rec := record
string dummy_field := '';
end;

dummyds := dataset([],dummy_rec);

dummyfile := output(dummyds,,'~thor_data400::dummy::bk::despray',overwrite);

BankruptcyV2.proc_BK_stats(filedate,zRunStatsReference);
	
BankruptcyV3.proc_BK_stats(filedate,zRunStatsReferenceV3);

proc_BK_Stats			    := zRunStatsReference					   : success(output(' V2 Stats created successfully.'));
proc_BK_Stats_v3		    := zRunStatsReferenceV3					   : success(output(' V3 Stats created successfully.'));
new_records_sample_for_qa	:= BankruptcyV2.New_records_sample        : success(fileservices.sendemail('Christopher.Brodeur@lexisnexisrisk.com;Manuel.Tarectecan@lexisnexisrisk.com',
			'BankruptcyV2 Full Build Process Completed ' + filedate,
			'workunit: ' + workunit));
//boolean_build := bankruptcyv2.Proc_Build_Boolean_Key(filedate);
//Bug 182568
scrubs_step2 := bankruptcyV2.proc_build_scrubs_step2(filedate);
Stats_For_DR := bankruptcyv2.BK_Stats_Metadata;
orbit_report.Bankruptcy_Stats(orbitreport);
build_relationships := BankruptcyV2.Proc_Create_Relationships(filedate,'Christopher.Brodeur@lexisnexisrisk.com,Manuel.Tarectecan@lexisnexis.com');
dops_update := Roxiekeybuild.updateversion('BankruptcyV2Keys',filedate,'Christopher.Brodeur@lexisnexisrisk.com,Manuel.Tarectecan@lexisnexis.com','Y',,,'Y');
BIP_dops_update := RoxieKeyBuild.updateversion('BankruptcyV2Keys',filedate,'Christopher.Brodeur@lexisnexisrisk.com,Manuel.Tarectecan@lexisnexis.com',,'BN');
send_package := if(_Control.ThisEnvironment.Name = 'Dataland',output('Package Sent'),
			fileservices.sendemail('Roxiedeployment@seisint.com,QualityAssurance@seisint.com',
			'Roxie Prod NonFCRA BK Package Files ' + ut.GetDate,
			'Non-FCRA BK Package link: http://rigel.br.seisint.com/~hozed/pkgfiles/bknonfcraprodpkg.txt\n'));
deletebasefiles := sequential(
					FileServices.RemoveOwnedSubFiles(Bankruptcyv2.BaseFileNames.mainv3 + '_delete',true),
					FileServices.RemoveOwnedSubFiles(Bankruptcyv2.BaseFileNames.searchv3 + '_delete',true),
					FileServices.RemoveOwnedSubFiles(Bankruptcyv2.BaseFileNames.mainv2 + '_delete',true),
					FileServices.RemoveOwnedSubFiles(Bankruptcyv2.BaseFileNames.searchv2 + '_delete',true),
					FileServices.RemoveOwnedSubFiles(Bankruptcyv2.BaseFileNames.dailymainv3 + '_delete',true),
					FileServices.RemoveOwnedSubFiles(Bankruptcyv2.BaseFileNames.dailysearchv3 + '_delete',true)
					
					);
addfullfilestosuper := sequential(
				fileservices.addsuperfile('~thor_data400::in::bankruptcyv3::main_full','~thor_data400::in::bankruptcyv3::'+filedate+'::main'),
				fileservices.addsuperfile('~thor_data400::in::bankruptcyv3::search_full','~thor_data400::in::bankruptcyv3::'+filedate+'::search')
				);
despraymoxiefiles := sequential(
				fileservices.Despray('~thor_data400::base::bankruptv2_search',_Control.IPAddress.edata12,
 									'/hds_180/bkv3/build/bk_search_v8.d00',,,,TRUE),
				fileservices.Despray('~thor_data400::out::bankruptv2::main_moxie',_Control.IPAddress.edata12,
 									'/hds_180/bkv3/build/bk_main_v8.d00',,,,TRUE),
				fileservices.Despray('~thor_data400::dummy::bk::despray',_Control.IPAddress.edata12,
 									'/hds_180/bkv3/bin/runkeybuild',,,,TRUE)					
									);
// consolidating files

Bankruptcyv2.Consolidate_SubFiles(BankruptcyV2.Layout_In_Case,'~thor_data400::in::bankruptcyv3::case_full',true,caseret);
Bankruptcyv2.Consolidate_SubFiles(BankruptcyV2.Layout_In_Defendants,'~thor_data400::in::bankruptcyv3::defendants_full',true,defret);
Bankruptcyv2.Consolidate_SubFiles(BankruptcyV2.layout_bankruptcy_main_in,'~thor_data400::in::bankruptcyv3::main_full',false,mainret);
Bankruptcyv2.Consolidate_SubFiles(BankruptcyV2.layout_bankruptcy_search_in,'~thor_data400::in::bankruptcyv3::search_full',false,searchret);

// DF-22748 Bankruptcy: Send email when WithdrawnStatus records are added that contain valid LexID
send_withdrawnstatus_email := IF(COUNT(BankruptcyV3.Key_BankruptcyV3_WithdrawnStatus()((UNSIGNED)did>0))>0,
                               fileservices.sendemail('Christopher.Brodeur@lexisnexisrisk.com,Manuel.Tarectecan@lexisnexisrisk.com',
                               'Bankruptcy Build Version ' + filedate,
                               'BankruptcyV3.Key_BankruptcyV3_WithdrawnStatus() contains '
                               +COUNT(BankruptcyV3.Key_BankruptcyV3_WithdrawnStatus()((UNSIGNED)did>0))
                               +' valid LexID(s)\n\n'
                               +IF((UNSIGNED)BankruptcyV3.Key_BankruptcyV3_WithdrawnStatus()[1].did>0,'LexID = '+BankruptcyV3.Key_BankruptcyV3_WithdrawnStatus()[1].did+'\n','')
                               +IF((UNSIGNED)BankruptcyV3.Key_BankruptcyV3_WithdrawnStatus()[2].did>0,'LexID = '+BankruptcyV3.Key_BankruptcyV3_WithdrawnStatus()[2].did+'\n','')
                               +IF((UNSIGNED)BankruptcyV3.Key_BankruptcyV3_WithdrawnStatus()[3].did>0,'LexID = '+BankruptcyV3.Key_BankruptcyV3_WithdrawnStatus()[3].did+'\n','')
                               +IF((UNSIGNED)BankruptcyV3.Key_BankruptcyV3_WithdrawnStatus()[4].did>0,'LexID = '+BankruptcyV3.Key_BankruptcyV3_WithdrawnStatus()[4].did+'\n','')
                               +IF((UNSIGNED)BankruptcyV3.Key_BankruptcyV3_WithdrawnStatus()[5].did>0,'LexID = '+BankruptcyV3.Key_BankruptcyV3_WithdrawnStatus()[5].did+'\n','')
                               +IF((UNSIGNED)BankruptcyV3.Key_BankruptcyV3_WithdrawnStatus()[6].did>0,'LexID = '+BankruptcyV3.Key_BankruptcyV3_WithdrawnStatus()[6].did+'\n','')
                               +IF((UNSIGNED)BankruptcyV3.Key_BankruptcyV3_WithdrawnStatus()[7].did>0,'LexID = '+BankruptcyV3.Key_BankruptcyV3_WithdrawnStatus()[7].did+'\n','')
                               +IF((UNSIGNED)BankruptcyV3.Key_BankruptcyV3_WithdrawnStatus()[8].did>0,'LexID = '+BankruptcyV3.Key_BankruptcyV3_WithdrawnStatus()[8].did+'\n','')
                               +IF((UNSIGNED)BankruptcyV3.Key_BankruptcyV3_WithdrawnStatus()[9].did>0,'LexID = '+BankruptcyV3.Key_BankruptcyV3_WithdrawnStatus()[9].did+'\n','')
                               +IF((UNSIGNED)BankruptcyV3.Key_BankruptcyV3_WithdrawnStatus()[10].did>0,'LexID = '+BankruptcyV3.Key_BankruptcyV3_WithdrawnStatus()[10].did+'\n','')
                              ));
															
// DF-26343 - A check to ensure the BK consolidated files below have been properly built.												
rFileCheck := record
	string name;
	string status;
end;


dFileCheck := dataset([
											{'~thor_data400::in::bankruptcyv3::case_full'}
											,{'~thor_data400::in::bankruptcyv3::defendants_full'}
											,{'~thor_data400::in::bankruptcyv3::main_full'}
											,{'~thor_data400::in::bankruptcyv3::search_full'}
											],{string name});

rFileCheck xFileCheck(dFileCheck l) := transform
	self.status := if (STD.File.FileExists('~'+l.name)
											,STD.File.VerifyFile(l.name,true)
											,'DOESNT EXIST'
										);
	self := l;
end;

dFileStatus := nothor(projecT(global(dFileCheck,few),xFileCheck(left)));

sequential(/*dops_update
		,*/build_relationships
		//,send_package
		,new_records_sample_for_qa
		,scrubs_step2
		,proc_BK_Stats
		,proc_BK_Stats_v3		
		,Stats_For_DR
		,deletebasefiles
		,dummyfile
		//,despraymoxiefiles
		,orbitreport
		,addfullfilestosuper
		,BIP_dops_update
		,parallel(caseret,defret,mainret,searchret)
		,output(dFileStatus)
		,if (count(dFileStatus(status <> 'OK')) > 0
				,FileServices.SendEmail('Christopher.Brodeur@lexisnexisrisk.com; Manuel.Tarectecan@lexisnexisrisk.com'
				,'BK stats file verification Failure'
				,WORKUNIT + '\n' + '\n' + 'Please check above WUID to see which file failed verification'))
  ,send_withdrawnstatus_email
		) : WHEN(event('Yogurt:BANKRUPTCY ROXIE KEY BUILD COMPLETE','*'), count(1));

endmacro;