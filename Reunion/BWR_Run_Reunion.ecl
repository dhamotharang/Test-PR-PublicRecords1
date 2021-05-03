
import ut,wk_ut,std,_Control;

version := (STRING)std.date.Today();
feedfiles := STD.File.RemoteDirectory('bctlpedata11.risk.regn.net','/data/data_lib_2_hus2/mylife/data/','mylife*.dat',true);
cnt := count(feedfiles(regexfind(version[1..6],name)));
feedfilesVersion := if(cnt = 6, regexfind('[0-9]{8}',feedfiles[1].name,0), '');

mode_ := if(cnt = 6, 1, 2);// 1->full/quarterly,   2->monthly

sf_name:='~thor_data400::base::build_status::reunion_';
status       :=reunion.LogBuildStatus(sf_name).GetLatest.versionStatus;
build_ver    :=reunion.LogBuildStatus(sf_name).GetLatest.buildversionName;
feedfile_ver :=reunion.LogBuildStatus(sf_name).GetLatest.feedversionName;

buildVer := if(status <> 900, build_ver, version);
feedVer  := if(status <> 900, feedfile_ver, if(mode_=1, feedfilesVersion, ''));
mode     := if(status <> 900, if(feedfile_ver <> '', 1, 2), mode_);

wname := 'MyLife ' + if(status <> 900,'RECOVER ', '') + if(mode=1,'QUARTERLY FULL BUILD ', 'MONTHLY CORE BUILD ') + buildVer;

ECL:=
 '#Workunit(\'name\',\'' + wname + '\');\n'
+'#Workunit(\'protect\',true);\n'
+'#Workunit(\'priority\',\'high\');\n'
+'#stored(\'did_add_force\',\'thor\');\n'
+'#OPTION(\'multiplePersistInstances\',FALSE);\n'
+'#option(\'maxCsvRowSizeMb\', 90);\n'
+'\n\n'
+'output(\'' + mode + buildVer + feedVer + '\');\n'
+'Reunion.actionBuildReunion(' + mode + ',\'' + buildVer + '\',\'' + feedVer + '\').all;\n'
;

wk_ut.CreateWuid(ECL,'thor400_36_eclcc',wk_ut._constants.ProdEsp);
