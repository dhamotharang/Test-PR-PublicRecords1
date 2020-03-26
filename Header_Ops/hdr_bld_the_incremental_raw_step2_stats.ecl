IMPORT header_avb, header, _control,dops;

EXPORT run_stats(boolean incremental=false, string versionBuild,string operatorEmailList) := FUNCTION

wuname := 'Create Raw Header Stats: '+ versionBuild;
#WORKUNIT('priority','high');
#WORKUNIT('name', wuname);
#OPTION('AllowedClusters','thor400_36 ,thor400_44');

statsEmailRecepients:= if(incremental, Header.email_list.statsInc, Header.email_list.statsMon);

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

build_version := '20191128';
// run_stats(true,build_version,Header.email_list.BocaDevelopers);

inc_bld := '~thor_data400::out::header_ingest_status_inc';
inc_ver    := Header.LogBuildStatus(inc_bld).Read[1].version;
inc_status := Header.LogBuildStatus(inc_bld).Read[1].status;

incremental := if(build_version = inc_ver, true, false);
dops_datasetname:='PersonHeaderKeys';
build_component:='STATS:INGEST';
dlog:=dops.TrackBuild().fSetInfoinWorktunit(dops_datasetname,build_version,build_component);

//incremental
// run_stats(true,build_version,Header.email_list.BocaDevelopers);

//monthly
sequential(
     dlog,
     run_stats(false,build_version,Header.email_list.BocaDevelopers)
     );

// run on p_svc_person_header: Header_AVB.Stat is sandboxed
// run on thor (eg 44) 

// This process detects a new header_raw and creates new stats
// The new stats file version is used in Alpharetta to detect/trigger
// whether a new header_raw needs to be copyed to Alpharetta
// Estimated THOR time: 20Min

// "W:\Projects\Header\Incremental Raw\Boca Header RAW Stats.ecl"
/*
Previous runs-
-------------
20191023 W20191025-123841(M)
20191010 W20191014-101348(W)
20190610 W20190614-173136
20190513 W20190516-224841
20190506 W20190509-100743
20190429 W20190502-091949
20190415 W20190417-193427
20190407 W20190409-091004
20190324 W20190325-110601(M)
20190317 W20190319-154804
20190310 W20190311-092702
20190225 W20190227-142320(M)
20190122 W20190123-125213
20190113 W20190114-220641
20190106 W20190108-101646
20181231 W20190102-092518
20181216 W20181219-133600
20181209 W20181211-062743
20181202 W20181203-100549
20181118 W20181119-171109
20181031 W20181102-125955
20181002 W20181003-155000
20180911 W20180912-233629
20180904 W20180905-164827
20180730 W20180801-092539
20180717 W20180723-102135
20180710 W20180711-093259
20180703 W20180705-161249
20180619 W20180620-185112
20180612 W20180615-110316
20180508 W20180510-103137
20180501 http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180503-182425#/stub/Summary
20180418 http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180419-103607#/stub/Summary
20180417 

http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180412-090333#/stub/Summary
http://prod_esp.br.seisint.com:8010/?Wuid=W20180405-103558&Widget=WUDetailsWidget#/stub/Summary
// 20180313 W20180315-112303
// 20180306 W20180312-115106
// 20180227 W20180301-112650
// 20180116 W20180118-084300
// 20180109 W20180111-104008
// 20180102 W20180104-213317
// 20171217 W20171221-150848
// 20171213 W20171214-154355
// 20171206 W20171208-063130
// 20171128 W20171201-103034
// W20171116-121227 20171115
// W20171108-155350 20171107
// W20171102-122534 20171031
// W20171019-162655 20171017
// W20171012-231735 20171011
// W20170922-084737 20170920
// W20170914-130505 20170913
// W20170823-213947 20170821
// W20170816-102639 20170814
// W20170810-093406  20170808
// W20170803-094733  20170731
// W20170719-143023  20170717
// W20170714-084215  20170710
// W20170707-151956   20170705
// W20170616-135410-1 20170613 inc
// W20170607-163429   20170606 inc
// W20170607-163429   20170606 inc
// W20170602-120653   21070531 inc
//                   20170522
// W20170518-114932 20170516 inc
// W20170512-102342 20170509
//                  20170430 full
// W20170421-100154 20170418
// W20170411-114133 20170404
// W20170330-121443 20170328 (ran on _60)
// W20170317-115600 20170315
// W20170309-092927 20170307
// W20170303-090020
// W20170212-130514 20170207
// W20170203-092412 20170131
// W20170118-112640
// W20161229-074438
// W20161214-131255
// */