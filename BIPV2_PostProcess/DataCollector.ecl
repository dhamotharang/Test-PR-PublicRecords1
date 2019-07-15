//I have a strong suspecious that this call can only complete in hthor. 
//using wk_ut.get_DS_Result instead of Dataset(WorkUnit(wuid,'ConfidenceLevels')... OK
import STD,BIPV2_Build,bipv2,wk_ut;
EXPORT DataCollector(string   version_in  = bipv2.KeySuffix) := Module

shared ThisWuid := thorlib.wuid();
shared File_Name :='ConfidenceLevels_total';

shared ds:=BIPV2_Build.files().workunit_history_.qa(version = version_in);
shared PT1:='BIPV2_ProxID '    + version_in + ' iter ';
//shared PT2:='BIPV2_ProxID_mj6 '+ version_in + ' iter ';
shared PT3:='BIPV2_LGID3 ' + version_in + ' iter';
shared ds_prox:=ds(state='completed' and 
					  (
							length(regexfind(PT1, name,0))>0 //OR length(regexfind(PT2, name,0))>0
							)
						);
shared ds_LGID3:=ds(state='completed' and 
					(
					length(regexfind(PT3, name,0))>0 
					)
				);
	
Export version_wuid_rec:=RECORD
		string version;
		string wuid;
end;	

EXPORT file_version_wuid   := '~thor_data400::bipv2_postProcess::datacollector::';
EXPORT logicalFilename_version_wuid := file_version_wuid + ThisWuid;

EXPORT superfile_version_wuid := file_version_wuid  + 'qa';
EXPORT superfile_father_version_wuid := file_version_wuid + 'father';
EXPORT superfile_grandfather_version_wuid := file_version_wuid + 'grandfather';
	
//EXPORT version_wuid_to_reset:=dataset(superfile_version_wuid, version_wuid_rec,flat);	
EXPORT updateSuperFile(string inFile) := FUNCTION
	action := Sequential(
							FileServices.PromoteSuperFileList([superfile_version_wuid, 
																								 superfile_father_version_wuid,
																								 superfile_grandfather_version_wuid], inFile, true)
						);
	return action;
END;

EXPORT createLogicalFile(dataset(version_wuid_rec) datasetVersionWuid) := FUNCTION	
	oldData := IF(nothor(FileServices.FileExists(superfile_version_wuid)), 
							dataset(superfile_version_wuid, version_wuid_rec, thor), 
							dataset([], version_wuid_rec));
	
	output(oldData,named('oldData'));
	AllData := oldData + datasetVersionWuid;
	output(AllData, named('AllData'));
	a := output(AllData, ,logicalFilename_version_wuid, overwrite);
	RETURN a;
END;
export restoreWU:=function
	yy:= 	apply(global(ds_prox,few), sequential(
			output(wk_ut.Restore_Workunit(wuid));
		 ));

  yy1:= apply(global(ds_LGID3,few), sequential(
			output(wk_ut.Restore_Workunit(wuid));
		 ));
		 
return sequential(yy,yy1);
end; 

shared lay_conf := {UNSIGNED2 Conf,UNSIGNED MatchesFound};	
export ProxLgidConf :=function
	xx:= 	apply(global(ds_prox,few), sequential(
			//output(Dataset(WorkUnit(wuid,'ConfidenceLevels'),{UNSIGNED2 Conf,UNSIGNED MatchesFound}),named('ConfidenceLevels_prox'),extend)
			output(wk_ut.get_DS_Result(wuid,'ConfidenceLevels',lay_conf,,,true),named('ConfidenceLevels_prox'),extend)
		 ));

  xx1:= apply(global(ds_LGID3,few), sequential(
			//output(Dataset(WorkUnit(wuid,'ConfidenceLevels'),{UNSIGNED2 Conf,UNSIGNED MatchesFound}),named('ConfidenceLevels_lgid'),extend)
			output(wk_ut.get_DS_Result(wuid,'ConfidenceLevels',lay_conf,,,true),named('ConfidenceLevels_lgid'),extend)
		 ));
		 
		 return sequential(xx,xx1);
end;

EXPORT addCandidates := FUNCTION
		dsAdd:=dataset([{version_in,ThisWuid}],version_wuid_rec); 
		aaa:=restoreWU;
		a0:=ProxLgidConf;
		a := createLogicalFile(dsAdd);
		b := updateSuperFile(logicalFilename_version_wuid);
		c := sequential(
      output(ds_prox  ,named('ds_prox'))
     ,output(ds_LGID3  ,named('ds_LGID3'))
    ,aaa,a0,a,b);
		
		return c;
END;
end;
                