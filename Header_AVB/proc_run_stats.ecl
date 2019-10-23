IMPORT _Control,header,data_services,std,header_avb;

EXPORT proc_run_stats(string verion_build='') := function

lc:=data_services.Data_location.prefix('person_header');
getVersion (string s) := regexfind('([_:])(2[0-9]{7})[^0-9]?[:^]?',s,2);

get1stSF_LgclVer(string sf):= getVersion(std.file.SuperFileContents(lc+sf)[1].name);

latestIncVer := get1stSF_LgclVer('thor_data400::base::header_raw_incremental');
latestMntVer := get1stSF_LgclVer('thor_data400::base::header_raw'            );

filedate := if(verion_build='',max(latestIncVer , latestMntVer),verion_build);

isIncremental := filedate=latestIncVer;
raw_type := if(isIncremental,'Incremental','Monthly');

elist:=

        'gabriel.marcan@lexisnexisrisk.com'
        // +',Cody.Fouts@lexisnexisrisk.com'
        // +',Gavin.Witz@lexisnexisrisk.com'
        // +',Ayeesha.Kayttala@lexisnexisrisk.com'
        // +',jose.bello@lexisnexisrisk.com'
        // +',aleida.lima@lexisnexisrisk.com'
        // +',manish.shah@lexisnexisrisk.com'
        // +',michael.gould@lexisnexisrisk.com'
				// +',heather.sherrington@lexisnexis.com'
				;

#WORKUNIT('priority','high');
#WORKUNIT('name', 'Create Raw Header Stats');
#OPTION('AllowedClusters','thor400_44_eclcc,thor400_66_eclcc');

email(string msg):=fileservices.sendemail(
                                            elist
                                            ,'Raw Header Stats - '+raw_type
                                            ,msg
                                            +'Build wuid '+workunit
                                            +FAILMESSAGE
                                            );
action :=
sequential(
            output(raw_type+' '+filedate,named('Stats_version'))
           ,header_avb.Stat(isIncremental,filedate).build_file(elist)
            
):success(email(raw_type+' Completed.\n\nA new header_raw is ready for transfer to Alpharetta\n\n'))
	, failure(email('failed\n\n'))
	;
    
RETURN action;
END;