IMPORT header_avb, header, _control,dops;

EXPORT run_stats(boolean incremental=false, string versionBuild,string operatorEmailList) := FUNCTION

wuname := 'Create Raw Header Stats: '+ versionBuild;

#WORKUNIT('priority','high');
#WORKUNIT('name', wuname);
#OPTION('AllowedClusters','thor400_36 ,thor400_44');

statsEmailRecepients:=

        operatorEmailList
         +',jose.bello@lexisnexisrisk.com'
         +',Cody.Fouts@lexisnexisrisk.com'
         +',Gavin.Witz@lexisnexisrisk.com'
         +',Ayeesha.Kayttala@lexisnexisrisk.com'
         +',Debendra.Kumar@lexisnexisrisk.com'
         +if(~incremental,
                 ',michael.gould@lexisnexis.com'
                +',manish.shah@lexisnexis.com'
                +',aleida.lima@lexisnexis.com','')
         +',Manjunath.Venkataswamy@lexisnexisrisk.com'
        ;

send_email(string msg):=fileservices.sendemail(
                                                statsEmailRecepients
                                                ,'Raw Header Stats - '+if(incremental,'Incremental','Monthly')
                                                 + ' ('+versionBuild+')'
                                                ,msg
                                                +'Build wuid '+workunit
                                                +FAILMESSAGE
                                                );

stats:= Header_AVB.Stat(incremental,versionBuild,operatorEmailList).build_file(statsEmailRecepients)
	: success(send_email('Completed, a new header_raw is ready for transfer to Alpharetta\n\n'))
	, failure(send_email('failed\n\n'))
	;

run_rel_avb:= output(_control.fSubmitNewWorkunit('Relative_AVB.BWR_proc_BuildData','thor400_44_eclcc'));

return sequential(stats, if(~incremental,run_rel_avb));
END;

boolean incremental:=false;
operatorEmailList:='gabriel.marcan@lexisnexisrisk.com,Debendra.Kumar@lexisnexisrisk.com';

build_version:= header.version_build;
dops_datasetname:='PersonHeaderKeys';
build_component:='STATS:INGEST';
dlog:=dops.TrackBuild().fSetInfoinWorktunit(dops_datasetname,build_version,build_component);

sequential(dlog,run_stats(incremental,header.version_build,operatorEmailList));

// run on p_svc_person_header: Header_AVB.Stat is sandboxed
// run on thor (eg 44) 

// This process detects a new header_raw and creates new stats
// The new stats file version is used in Alpharetta to detect/trigger
// whether a new header_raw needs to be copyed to Alpharetta
// Estimated THOR time: 20Min

// 20181023 W20181029-101350
// 20180724 W20180827-115225
// 20180626 W20180702-091910
// 20180423 
// 20180320 http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180321-123412#/stub/Summary