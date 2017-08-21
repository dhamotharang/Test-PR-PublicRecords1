// GetCurrentPreppedSuperFiles - Returns a List of the logical files existing in the Prepped Super Files
// lastExecutedAgencyBuildVersion - Returns the last executed agency build version extracted from the server workunits log.
// GetPreppedAgencyBuildVersion - Returns the agency build version to be added to prepped logical file name.  
// lastAgencyBuildResolved() - Returns TRUE if last agency build version status in Orbit is either "Built" or "Graveyard". Returns FALSE otherwise.

// pushLastBuildManifest - Creates the Build manifest comprised of the list of files updated by either build All or build Prep. Notifies CRON scheduler running at DR Server.

// FindNextPrepBuildReadyToGo - Orbit Queue for Prep builds. Returns the next XML file ready to be processed. 
// BairBuildReadyToGo() - Orbit Queue for Bair Nightly Delta builds. Returns the next Bair nightly Delta version ready to be processed. 
// AgencyBuildReadyToGo() - Orbit Queue for Agencies Delta builds. Returns the next Agencies Delta Build version ready to be processed. 

// UpdatePrepBuildStatus _ Updates the Orbit Prep build Status according to the prep processing call. 
// UpdateOrbitStatus - Updates the Orbit Status of both bair_input_update and agencies_input_update builds.
// UpdateSplitBuildOrbitStatus - Updates Orbit Status and transfer the build manifest to DR when either the COMPOSITE or BOOLEAN task is the last one being completed.

// SetOrbitForPrepBuild - Creates the dataset prep build in Orbit. 
// SetOrbitForBuildAll - Creates new bair_input_update or agencies_input_update build in Orbit or update existing build status to initiate the build. 
// SetOrbitBuildToReprocess - Set Orbit Status to allow a prep build to be re-processed. 

// SetOrbitForPrepBatch - Creates the prep batch builds in the orbit.

IMPORT BAIR, STD, VersionControl,_Control, ut, lib_fileservices, tools, Bair_Importer,wk_ut, PromoteSupers;

EXPORT Orbit_Update := MODULE

SHARED preppedSFSet := 	SET(Bair._Constant.prepSF,supername);		
															
EXPORT GetCurrentPreppedSuperFiles() := FUNCTION

preppedFiles 		:= STD.File.LogicalFileSuperSubList()(supername in preppedSFSet and subname!='');

Return preppedFiles;

END;

EXPORT lastExecutedAgencyBuildVersion() := FUNCTION

wuname 											:= 'Bair DELTA Build All - AGENCIES*?';
lastAgencyBuild 						:= sort(nothor(WorkunitServices.WorkunitList('',NAMED jobname:=wuname))(wuid <> thorlib.wuid()), -wuid)[1];
lastAgencyBuildVersion 			:= STD.STR.SplitWords(lastAgencyBuild.job,' ')[7];//lastAgencyBuild.job[33..47]; Change to by pass Oscar's reimporting inconsistency 

return lastAgencyBuildVersion;

END;

EXPORT GetPreppedAgencyBuildVersion() := FUNCTION

preppedFiles 						:= GetCurrentPreppedSuperFiles();
preppedFilesCount       := COUNT(preppedFiles);

STRING pDate 						:= (STRING8)Std.Date.Today():INDEPENDENT;
STRING pTime 						:= Std.Date.SecondsToString(Std.date.CurrentSeconds(true), '%H%M%S');
STRING pVersion 				:= pDate + '_' + pTime;

preppedCurrentFilesCnt       := Count(STD.STR.SplitWords(preppedFiles[1].subname,'::'));
preppedCurrentFilesVersion   := STD.STR.SplitWords(preppedFiles[1].subname,'::')[preppedCurrentFilesCnt];
preppedAgencyBuildVersion    := if (preppedFilesCount = 0,pVersion,preppedCurrentFilesVersion);

Return preppedAgencyBuildVersion;

END;

EXPORT lastAgencyBuildResolved() := FUNCTION
//Bair DELTA Build All - AGENCIES 20160526_144502033 
STRING36  oLogin				    := Bair.Orbit_SOAPCalls.login.creds		: INDEPENDENT	;
orbitLastAgencyBuildStatus 	:= Bair.Orbit_SOAPCalls.GetBuildInstance('agencies_input_update',lastExecutedAgencyBuildVersion() , oLogin).Builds.BuildIBR.BuildStatus;	
lstAgencyBuildResolved      := orbitLastAgencyBuildStatus IN ['Graveyard','Built',''];

return lstAgencyBuildResolved;

END;

EXPORT pushLastBuildManifest(STRING50 pBuildNameFull, STRING40 pAgencyBuildVersionIncludedFull, STRING40 pVersionFull , STRING pType =' ') := FUNCTION

FS															:= fileservices;
targetIP    										:= Bair._Constant.manifestToIP;
pTypeStatus											:= STD.Str.toLowerCase(pType);

pVersion        						:= STD.Str.RemoveSuffix(pVersionFull,' ');
buildName       						:= STD.Str.RemoveSuffix(pBuildNameFull,' ');
agencyBuildVersionIncluded 	:= STD.Str.RemoveSuffix(pAgencyBuildVersionIncludedFull,' ');

baseManifestFileName    				:= '~thor_data400::out::bair::backup::last_base_manifest';
compositeManifestFileName    		:= '~thor_data400::out::bair::backup::last_composite_manifest';
pWuid := STD.System.Job.WUID();
preppedManifestFileName 				:= '~thor_data400::out::bair::backup::last_prep_manifest_'+pWuid;
//preppedManifestFileName 				:= '~thor_data400::out::bair::backup::last_prep_manifest_'+pVersion;
//baseManifestFileNameSent    		:= '~thor_data400::out::bair::backup::last_base_manifest_sent_'+pVersion;
//preppedManifestFileNameSent 		:= preppedManifestFileName; //'~thor_data400::out::bair::backup::last_prep_manifest_sent_'+STD.System.Job.WUID();
logicalFileName  								:= map (std.str.find(pBuildNameFull,'prep')>0 => preppedManifestFileName
																				,pTypeStatus ='composite' => compositeManifestFileName
																				,baseManifestFileName);
//logicalFileNameSent  						:= if (std.str.find(pBuildNameFull,'prep')>0,preppedManifestFileNameSent,baseManifestFileNameSent);

baseSFSET                   := SET(Bair._Constant.baseSF,supername);
basePackageSFSET            := SET(Bair._Constant.packageSF,supername);
baseCtrlSFSET               := SET(Bair._Constant.baseCtrlSF,supername);

compositeSFSET              := SET(Bair._Constant.compositeSF,supername);

prepSFSET										:= SET(Bair._Constant.prepSF,supername);
prepCtrlSFSET               := SET(Bair._Constant.prepCtrlSF,supername);
prepByPeriodSFSET    				:= SET(Bair._Constant.prepByPeriodSF,supername);

baseList										:=nothor(STD.File.LogicalFileSuperSubList()(std.str.find(subname,pVersion)>0  and supername in baseSFSET ));
compositeList								:=nothor(STD.File.LogicalFileSuperSubList()(std.str.find(subname,pVersion)>0  and supername in compositeSFSET ));
prepList										:=nothor(STD.File.LogicalFileSuperSubList()(std.str.find(subname,pVersion)>0  and supername in prepSFSET ));
list 												:= map(std.str.find(pBuildNameFull,'prep')>0 =>prepList
																		,pTypeStatus ='composite' =>compositeList
																		,baseList);

baseControlList 						:= nothor(STD.File.LogicalFileSuperSubList()(std.str.ToLowerCase(supername) in baseCtrlSFSET  and subname!=''));
prepControlList 						:= nothor(STD.File.LogicalFileSuperSubList()(std.str.ToLowerCase(supername) in prepCtrlSFSET  and subname!=''));
controlList     						:= map(std.str.find(pBuildNameFull,'prep')>0 =>prepControlList
																	,pTypeStatus ='composite' =>baseControlList
																	,baseControlList);

packageList                 :=nothor(STD.File.LogicalFileSuperSubList()(supername in basePackageSFSET ));

prepByPeriodList            :=nothor(STD.File.LogicalFileSuperSubList()(std.str.find(subname,pVersion)>0 and supername in prepByPeriodSFSET ));

Bair._Constant.manifest_layout tCandidates(list L) 	:= TRANSFORM
          SELF.buildName := buildName;
					SELF.agencyBuildVersionIncluded := agencyBuildVersionIncluded;
          SELF.version := pVersion;
				  SELF := L;
END;
dList     				:= PROJECT(list, tCandidates(LEFT));

Bair._Constant.manifest_layout tPackageCandidates(packageList L) 	:= TRANSFORM
          SELF.buildName := 'package';
					SELF.agencyBuildVersionIncluded := agencyBuildVersionIncluded;
          SELF.version := pVersion;
				  SELF := L;
END;
dPackageList			:= PROJECT(packageList, tPackageCandidates(LEFT));

Bair._Constant.manifest_layout tControlCandidates(controlList L) 	:= TRANSFORM
          SELF.buildName := map(std.str.find(pBuildNameFull,'prep')>0 =>'prep_control'
																,pTypeStatus ='composite' =>'composite_control'
																,'base_control');
					SELF.agencyBuildVersionIncluded := agencyBuildVersionIncluded;
          SELF.version := pVersion;
				  SELF := L;
END;
dControlList			:= PROJECT(controlList, tControlCandidates(LEFT));

Bair._Constant.manifest_layout tByPeriodCandidates(prepByPeriodList L) 	:= TRANSFORM
          SELF.buildName := 'prepByPeriod';
					SELF.agencyBuildVersionIncluded := agencyBuildVersionIncluded;
          SELF.version := pVersion;
				  SELF := L;
END;
dPrepByPeriodList			:= PROJECT(prepByPeriodList, tByPeriodCandidates(LEFT));

dDelta 						:= dList + dControlList + dPackageList;
dComposite				:= dList + dControlList + dPackageList;
dPrepped					:= dList + dControlList + dPrepByPeriodList;
d                 := map(std.str.find(pBuildNameFull,'prep')>0 =>dPrepped
													,pTypeStatus ='composite' =>dComposite
													,dDelta);

deleteCurFile 				:= STD.File.DeleteLogicalFile(logicalFileName); 
createNewFile 				:= output(d,,logicalFileName,THOR,OVERWRITE);

THOR:='hthor';
ECL1:='NOTIFY(\'transfer_prep_manifest\',\'*\');';
ECL2:='NOTIFY(\'transfer_composite_manifest\',\'*\');';
ECL3:='NOTIFY(\'transfer_base_manifest\',\'*\');';

ECL :=map(std.str.find(pBuildNameFull,'prep')>0=>ECL1
					,pTypeStatus ='composite' =>ECL2
					,ECL3);

// n1:=wk_ut.CreateWuid(ECL1,THOR,_Control.IPAddress.bair_DR_ESP);
// n2:=wk_ut.CreateWuid(ECL2,THOR,_Control.IPAddress.bair_DR_ESP);
// pushLastVersionFile 	:= if(std.str.find(pBuildNameFull,'prep')>0, n1, n2);

// ***** Makes DR ESP IP depending on source IP ******* //
notifyDR						 	:= wk_ut.CreateWuid(ECL,THOR,Bair._Constant.notifyIP);

updLastBuildManifest 	:= Sequential(deleteCurFile
																	,createNewFile
																	//,pushLastVersionFile 
																	,notifyDR);

Return updLastBuildManifest;

END;

EXPORT FindXMLFile (string pServerIP, string LandingZone, string filename) := FUNCTION

readyFolder 		:= LandingZone;
errorFolder 		:= STD.STR.FindReplace(LandingZone,'ready','error');
sprayingFolder 	:= STD.STR.FindReplace(LandingZone,'ready','spraying');
doneFolder     	:= STD.STR.FindReplace(LandingZone,'ready','done');

foundInReadyFolder    := FileServices.RemoteDirectory(pServerIP, readyFolder, fileName);
foundInErrorFolder    := FileServices.RemoteDirectory(pServerIP, errorFolder, fileName);
foundInSprayingFolder := FileServices.RemoteDirectory(pServerIP, sprayingFolder, fileName);
foundInDoneFolder     := FileServices.RemoteDirectory(pServerIP, doneFolder, fileName);

foundFileName 				:= MAP(EXISTS(foundInReadyFolder)    => foundInReadyFolder[1].name + ' ' + readyFolder,
														 EXISTS(foundInErrorFolder)    => foundInErrorFolder[1].name + ' ' + errorFolder,
														 EXISTS(foundInSprayingFolder) => foundInSprayingFolder[1].name + ' ' + sprayingFolder,
														 EXISTS(foundInDoneFolder)     => foundInDoneFolder[1].name + ' ' + doneFolder,
														' ');

Return foundFileName; 

END;



EXPORT FindNextPrepBuildReadyToGo (STRING buildType=' ') := FUNCTION 

STRING36  oLogin				:= Bair.Orbit_SOAPCalls.login.creds		: INDEPENDENT	;
STRING		pServerIP			:= Bair._Constant.bair_batchlz;
rgxVersion 							:= '\\_([0-9]{8})\\_([0-9]{9})\\.';
rgxverfilter 						:= '([0-9]{8}[_][0-9]{9})';
rgxAgency								:='\\_([0-9]+)\\_';	
rgxName		 							:= '([a-zA-Z]+)\\_([0-9]+)\\_([0-9]{8})\\_([0-9]{9}).';	
rgxLandingZone 					:= 'data\\/([a-zA-Z]+)\\/ready';	

fCandidates := Bair.Orbit_SOAPCalls.GetCandidates('allagencies_input_prep', 'candidates', oLogin  ).BuildsComponents.BuildData.CandidatesR.OutDs(ReceivingStatus='Loaded' and (Integer)receivingid >360047);
// fCandidates;
Rec_file	:= Record
STRING receivingid;
STRING fullfilename;
STRING FileCurLocation;
end;
sCandidates := RECORD
  STRING fileVersion;
	STRING fileDate;
  STRING buildName;
	STRING FileName;
	STRING FileType;
	STRING fileextension;
	STRING Agency;
  STRING fullFileName;
	STRING buildStatus :='';
	STRING prepFabBuildStatus:='';
	STRING isItemOnHold := '';
	STRING BatchR3LandingZone;
	STRING masterBuild;
	STRING member_id :='' ;
	STRING filesource_id :='';
	STRING receivingID;
	STRING ReadyToGo := 'false';
	DATASET({Rec_file}) Receivings;
END;

sCandidates tCandidates(fCandidates L) := TRANSFORM
			SELF.fileVersion  	:= regexfind(rgxVersion, L.FileName,1)+ '_'+ regexfind(rgxVersion, L.FileName,2);
			SELF.fileDate     	:= regexfind(rgxVersion, L.FileName,1);
      SELF.buildName    	:= regexfind(rgxLandingZone, STD.Str.FindReplace( L.BatchR3LandingZone, '_', ''),1) + '_' + STD.STR.SplitWords(L.FileName,'_')[1]+ '_input_prep';
			SELF.FileType				:= STD.STR.SplitWords(L.FileName,'_')[1];
			SELF.fileextension	:= map(regexfind('.xml',L.Filename,nocase)	=>'XML'
																,regexfind('.utf8',L.FileName,nocase)	=>'UTF8'
																,'');
			SELF.Agency					:= regexfind(rgxAgency,L.FileName,1);
      SELF.masterBuild  	:= 'mb_allgencies_prep';// + regexfind(rgxLandingZone, STD.Str.FindReplace( L.LandingZone, '_', ''),1) + '_prep';
			SELF.fullFileName   := FileServices.RemoteDirectory(pServerIP, L.BatchR3LandingZone, '*'+L.FileName)[1].name;
			SELF.member_id 			:= REGEXFIND('_m([\\S\\s]+)_', SELF.fullFileName , 1)[1..4];
	    SELF.filesource_id 	:= REGEXFIND('_m([\\S\\s]+)_', SELF.fullFileName , 1)[5];
			SELF.Receivings			:=[];
      SELF := L;
END;
rFilesVersions      			:= PROJECT(fCandidates, tCandidates(LEFT))(regexfind(rgxverfilter,fileversion),fileextension='XML');
sortedFilesVersions 			:= SORT(rFilesVersions,buildName,fileVersion,fileextension):INDEPENDENT;

sCandidates tBuilds(sCandidates L) := TRANSFORM
		SELF.prepFabBuildStatus := Bair.Orbit_SOAPCalls.GetBuildInstance(L.buildName, L.fileVersion, oLogin).Builds.BuildIBR.BuildStatus;	
		SELf.isItemOnHold 			:= Bair.Orbit_SOAPCalls.GetContributionData(L.filesource_id, L.member_id, oLogin).Items.ContributionItem.IsItemOnHold;
   	SELF := L;
END;
rFabLPRBuild := PROJECT(sortedFilesVersions, tBuilds(LEFT))(std.str.find(buildName,'LPR')>0);
rFabNonLPRBuild := PROJECT(sortedFilesVersions, tBuilds(LEFT))(std.str.find(buildName,'LPR')=0);
rFabAllBuild := PROJECT(sortedFilesVersions, tBuilds(LEFT));
rFabBuilds := Map (buildType='LPR' => rFabLPRBuild,
                   buildType='NonLPR' => rFabNonLPRBuild,
									 rFabAllBuild):INDEPENDENT;
					 

rFabBuildPrep	:= Project(rFabBuilds,transform(sCandidates
									,self.Receivings := Dataset([{left.receivingid
																				,if(left.prepFabBuildStatus='BuildAvailableForUse',STD.STR.SplitWords(findXMLfile(pServerIP,left.BatchR3LandingZone,'*'+left.FileName),' ')[1],left.fullfilename)																								
																				,if(left.prepFabBuildStatus='BuildAvailableForUse',STD.STR.SplitWords(findXMLfile(pServerIP,left.BatchR3LandingZone,'*'+left.FileName),' ')[2],'')}],{Rec_file})
									,self:=left));
rFabBuildRoll := rFabBuildPrep(exists(Receivings(fullfilename<>'')));

sCandidates	fbuild(rFabBuildRoll L, rFabBuildRoll R):= Transform
				SELF.Receivings := L.Receivings +R.Receivings ;
				SELF.receivingid := L.receivingid +' '+R.receivingid;
				SELF:=L;
				SELF:=R;
			  END;
RollCSV	:= Rollup(rFabBuildRoll(fileextension='UTF8'),left.buildName=right.buildName and left.fileVersion=right.fileVersion and left.fileextension=right.fileextension,	fbuild(Left,Right));
RollCSV_Final	:= Project(RollCSV,Transform(sCandidates,
																self.ReadyToGo:= MAP(left.FileType ='CFS' and count(left.Receivings)=2 =>'true'
																										,left.FileType ='EVENT' and exists(RollCSV.Receivings(regexfind('EVENT_MO',fullfilename)))=>'true'
																										,left.FileType ='CRASH' and exists(RollCSV.Receivings(regexfind('CRASH_CRASH',fullfilename)))=>'true'
																										,left.FileType ='OFFENDERS' and exists(RollCSV.Receivings(regexfind('OFFENDERS_OFFENDER',fullfilename)))=>'true'
																										,left.FileType ='LPR' =>'true'
																										,'false');
																self:=left));				
								
RollXml := Project(rFabBuildRoll(fileextension='XML'),transform(sCandidates, self.ReadyToGo:='true',self:=left));
RollFiles	:= RollXml;//RollCSV_Final(readytogo='true')+RollXml; 
RollFinal	:= sort(RollFiles,receivingID);

preplayout := RECORD
	STRING buildName;
	STRING buildVersion;
	STRING FileType;
	STRING fileextension;
	STRING Agency;
	STRING LandingZone;
	STRING preppedAgencyBuildVersion;
	STRING ReProcessFlag;
	STRING Receivingid;
	DATASET({Rec_file}) Receivings;
END;

rNextReprocessPrep := choosen(RollFinal(buildName<>'',(INTEGER)fileDate > 20160408, prepFabBuildStatus ='BuildAvailableForUse'),1):INDEPENDENT;
rNextReprocessReadyToGo:= Project(rNextReprocessPrep,transform(preplayout
																										,self.preppedAgencyBuildVersion:= GetPreppedAgencyBuildVersion()
																										,self.LandingZone := left.BatchR3LandingZone
																										,self.buildversion :=left.fileversion
																										,self.ReProcessFlag:='Reprocess'
																										,self:=left));
													
rNextNewPrep 			:= choosen(RollFinal(buildName<>'',(INTEGER)fileDate > 20160408, prepFabBuildStatus ='', fullFileName<>'',isItemOnHold='false' ),1):INDEPENDENT;

rNextNewReadyToGo := Project(rNextNewPrep,transform(preplayout
																					,self.preppedAgencyBuildVersion:= GetPreppedAgencyBuildVersion()
																					,self.LandingZone := left.BatchR3LandingZone
																					,self.buildversion :=left.fileversion
																					,self.ReProcessFlag:=''
																					,self:=left));

existPrepBuidReady      := rNextReprocessReadyToGo[1].buildName<>'' or rNextNewReadyToGo[1].buildName <>'';

prepfabBuildVersionNextToGo := if (existPrepBuidReady,
                                  if (rNextReprocessReadyToGo[1].buildname<>'',rNextReprocessReadyToGo, rNextNewReadyToGo)
																	);
Return prepFabBuildVersionNextToGo;

END;


EXPORT BairBuildReadyToGo() := FUNCTION 

STRING36  	oLogin			:= Bair.Orbit_SOAPCalls.login.creds		: INDEPENDENT	;
STRING		pServerIP			:= Bair._Constant.bair_batchlz;

readytogo := FileServices.RemoteDirectory(pServerIP, '/data/bair/ready/', 'readytogo');

rgxBairVersion 		:= '\\.([0-9]+)\\.([0-9]+)\\.';
rgxBairName		 		:= '([a-zA-Z]+)\\.([a-zA-Z_0-9]+)\\.([a-zA-Z_0-9]+)\\.([a-zA-Z_0-9]+)\\.([a-zA-Z_0-9]+)\\.([a-zA-Z_0-9]+)\\.([a-zA-Z_0-9]+)\\.([a-zA-Z_0-9]+)\\.([a-zA-Z_0-9]+)';	

STRING pDate 			:= ut.GetDate:INDEPENDENT;
STRING pTime 			:= ut.GetTime():INDEPENDENT;
STRING pVersion 	:= pDate + '_' + pTime;

STRING buildName 	:='bair_input_update';

BOOLEAN isTimeToBuildBair := (INTEGER)pTime > 95959;
fCandidates := Bair.Orbit_SOAPCalls.GetCandidates('bair_input_candidate', 'allversions', oLogin  ).BuildsComponents.BuildData.CandidatesR.OutDs(ReceivingStatus='Loaded');

sCandidates := RECORD
  STRING 	fileVersion;
  STRING 	fileVersionDate;
	STRING 	pFileVersion;
	STRING 	sourceName;
	INTEGER fileCount := 1;
	STRING 	buildStatus := '';
	INTEGER filesAvailableCount := 0;
	BOOLEAN readyToGo := FALSE;
END;

sCandidates tCandidates(fCandidates L) 	:= TRANSFORM
									SELF.fileVersion     	:= regexfind(rgxBairVersion, L.FileName,1) + regexfind(rgxBairVersion, L.FileName,2);
									SELF.fileVersionDate 	:= regexfind(rgxBairVersion, L.FileName,1);
									SELF.pFileVersion    	:= regexfind(rgxBairVersion, L.FileName,1) + '_' + regexfind(rgxBairVersion, L.FileName,2);
									SELF.sourceName      	:= L.sourceName;
									SELF                 	:= L;
END;
rFilesVersions      									 	:= PROJECT(fCandidates, tCandidates(LEFT));
sortedFilesVersions 										:= SORT(rFilesVersions,sourcename, fileVersion);

sCandidates tBuilds(sCandidates L, sCandidates R) := TRANSFORM
    SELF.fileCount              				:= L.fileCount + 1;
		SELF                        				:= L;
		SELF                        				:= R;
END;
rFabBuildsRollup := ROLLUP(sortedFilesVersions,LEFT.sourceName = RIGHT.sourceName AND LEFT.pFileVersion = RIGHT.pFileVersion, tBuilds(LEFT,RIGHT)):INDEPENDENT;

sCandidates bdCandidates(rFabBuildsRollup L) := TRANSFORM
			SELF.buildStatus        					:= Bair.Orbit_SOAPCalls.GetBuildInstance(buildName, L.pFileVersion, oLogin).Builds.BuildIBR.BuildStatus;	
			SELF                 							:= L;
END;
rBuildStatus										:= PROJECT(rFabBuildsRollup, bdCandidates(LEFT));
rLastBuilt                      := SORT(rBuildStatus,-fileversion)(buildstatus='Built')[1];
//rBuildsAfterLastBuilt           := rBuildStatus((INTEGER)fileVersionDate > (INTEGER)rLastBuilt.fileVersionDate);
rBuildsAfterLastBuilt           := rBuildStatus((INTEGER)std.str.findreplace(pfileversion,'_','') > (INTEGER)std.str.findreplace(rLastBuilt.pfileversion,'_',''));
buildInProgress                 := COUNT(rBuildsAfterLastBuilt(buildStatus IN ['BuildInProgress','BuildOnHold'])) > 0;
buildToProcess                  := sort(rBuildsAfterLastBuilt(buildStatus IN ['BuildAvailableForUse','']), -fileversion);

toProcessFilesAvailable := FileServices.RemoteDirectory(pServerIP, '/data/bair/ready/', '*'+STD.Str.FindReplace(buildToProcess[1].pFileVersion,'_','.')+'*');
toProcessFileTypeRec 		:= RECORD
    INTEGER fileCount      	:= 1;
    STRING fileType  				:= regexfind(rgxBairName, toProcessFilesAvailable.name,5) + '.'
															+regexfind(rgxBairName, toProcessFilesAvailable.name,6) + '.'
															+regexfind(rgxBairName, toProcessFilesAvailable.name,7); 
END;		
toProcessFilesTypeTBL 	:= TABLE(toProcessFilesAvailable, toProcessFileTypeRec):INDEPENDENT;
toProcessFilesTypeSET 	:= SET(toProcessFilesTypeTBL,fileType);

toProcessFilesTypeTBLSorted := SORT(toProcessFilesTypeTBL,fileType):INDEPENDENT;
toProcessFileTypeRec  ttoProcessFileTypes(toProcessFileTypeRec  L, toProcessFileTypeRec  R) := TRANSFORM
    SELF.fileCount              				:= L.fileCount + 1;
		SELF                        				:= L;
		SELF                        				:= R;
END;
toProcessFilesTypeRU := ROLLUP(toProcessFilesTypeTBLSorted,LEFT.fileType = RIGHT.fileType, ttoProcessFileTypes(LEFT,RIGHT)):INDEPENDENT;
existToProcessFilesTypeDuplicate := exists(toProcessFilesTypeRU(filecount>1));

requiredFilesType 			  := Bair._Constant.bairFiles(requiredFlag=TRUE):INDEPENDENT;

toProcessFilesTypeAllAvailableToday 			:= COUNT(requiredFilesType(fileType NOT IN toProcessFilesTypeSET))=0:INDEPENDENT;
toProcessFilesTypeAllAvailableTodayList 	:= requiredFilesType(fileType NOT IN toProcessFilesTypeSET):INDEPENDENT;
toProcessFilesAllLoadedToday        			:= buildToProcess[1].fileCount >= COUNT(requiredFilesType):INDEPENDENT;

existBuildToGo	:= if (COUNT(buildToProcess)>0,TRUE,FALSE);

buildBairGo 		:= IF (buildInProgress = False 
                   AND existBuildToGo = True 
									 AND existToProcessFilesTypeDuplicate = FALSE
									 AND toProcessFilesAllLoadedToday=True 
									 AND toProcessFilesTypeAllAvailableToday=TRUE
									 AND lastAgencyBuildResolved() =TRUE
									 AND count(readytogo) > 0
									 , True,False);

reProcessFlag 	:= if(buildToProcess[1].buildStatus = 'AvailableForUse','Reprocess','');

bairBuild   		:= IF (buildBairGo = TRUE, 'bair_input_update ' + buildToProcess[1].pFileVersion + ' ' + reProcessFlag, '');

Return bairBuild;

END;

EXPORT AgencyBuildReadyToGo() := FUNCTION 

STRING36  oLogin			  		:= Bair.Orbit_SOAPCalls.login.creds		: INDEPENDENT	;
STRING		pServerIP					:= Bair._Constant.bair_batchlz;
STRING 		pTime 						:= Std.Date.SecondsToString(Std.date.CurrentSeconds(true), '%H%M%S');

preppedFiles 								:= GetCurrentPreppedSuperFiles();
agencyPreppedFilesCount  		:= COUNT(preppedFiles);

buildVersion 								:= GetPreppedAgencyBuildVersion();
existBuildVersion 	    		:= Bair.Orbit_SOAPCalls.GetBuildInstance('agencies_input_update',buildVersion , oLogin).Builds.BuildIBR.BuildStatus !='';
incrementedBuildVersion 		:= STD.STR.SplitWords(buildVersion,'_')[1] + '_' + pTime;
preppedAgencyBuildVersion 	:= if (existBuildVersion,incrementedBuildVersion,buildVersion);

agencyBuild             		:= if(agencyPreppedFilesCount > 0 and lastAgencyBuildResolved() = True, 'agencies_input_update ' + preppedAgencyBuildVersion,'');

Return agencyBuild;

END;


EXPORT UpdatePrepBuildStatus( STRING pBuildName,
															STRING pVersion, 
															STRING pStatusPassed,
															STRING pReceivingID,
															STRING pBuildVersion=' ',
															STRING pComment=' ') := FUNCTION
											 
pStatus 								:= 	STD.Str.ToTitleCase(pStatusPassed);										 
											 
STRING36  	oLogin			:= Bair.Orbit_SOAPCalls.login.creds		: INDEPENDENT;

receiveDate 						:= Std.Date.ConvertDateFormat(ut.GetDate, '%Y%m%d', '%Y-%m-%d'):INDEPENDENT;

VARSTRING pBuildStatus 	:= MAP(pStatus = 'Reformatted' => 'Built',
																pStatus = 'Failed'      => 'Failed',' ');

updateBuilt     				:= Sequential(Bair.Orbit_SOAPCalls.UpdateReceive( receiveDate	, pReceivingID	, pStatus , oLogin),
																			Bair.Orbit_SOAPCalls.UpdateBuildStatus(pBuildName, TRIM(pBuildStatus,LEFT,RIGHT), pVersion, pComment, oLogin),			
																			Bair.Orbit_SOAPCalls.AddComponentsToABuild (pBuildName, pVersion,pReceivingId, oLogin).OrbitStatus.OrbitStatusDescription//,
																			//pushLastVersionBuiltFile(pBuildName, pVersion+'::'+pBuildVersion)
																			// pushLastBuildManifest(pBuildName, pBuildVersion, pVersion)
																			);

updateFailed    				:= Sequential(Bair.Orbit_SOAPCalls.UpdateReceive( receiveDate	, pReceivingID	, pStatus , oLogin),
																			Bair.Orbit_SOAPCalls.UpdateBuildStatus(pBuildName, TRIM(pBuildStatus,LEFT,RIGHT), pVersion, pComment, oLogin));

updateReceive    				:= Sequential(Bair.Orbit_SOAPCalls.UpdateReceive( receiveDate	, pReceivingID	, pStatus , oLogin));


Return Sequential(if (pStatus = 'Failed', 
                      updateFailed,
											if (pStatus ='Reformatted',
											    updateBuilt, 
													updateReceive
													)
											)
									);

END;

EXPORT UpdateOrbitStatus(STRING pBuildName,
												 STRING pVersion, 
												 STRING pStatus, 
												 STRING pComment=' ') := FUNCTION

STRING36  	oLogin			:= Bair.Orbit_SOAPCalls.login.creds		: INDEPENDENT	;

updBuildStatus  				:= Bair.Orbit_SOAPCalls.UpdateBuildStatus(pBuildName, pStatus, pVersion, pComment, oLogin)	;

Return updBuildStatus;

END;

EXPORT UpdateSplitBuildOrbitStatus(STRING pBuildName,
												           STRING pVersion, 
												           STRING pStatusRequested, 
												           STRING pComment=' '
																	 ) := FUNCTION

segment      := STD.Str.toLowerCase(pComment);//'COMPOSITE';																	 
pStatus			 := STD.Str.ToTitleCase(pStatusRequested);  
buildName     := std.str.SplitWords(pBuildName,' ')[1]; 
buildName2    := std.str.SplitWords(pBuildName,' ')[2];
preppedComment := if(buildName2!='', 'Contains *in::prepped::*::' + buildName2 + ' files\n Updated by the ' + segment + ' segment','');

STRING36  	oLogin	:= Bair.Orbit_SOAPCalls.login.creds		: INDEPENDENT	;
updBuildStatus      := Bair.Orbit_SOAPCalls.UpdateBuildStatus(buildName, pStatus, pVersion, preppedComment, oLogin);

pushLastVersionFile := pushLastBuildManifest(buildName, buildName2, pVersion): INDEPENDENT;

completeBuild       := Sequential (updBuildStatus
																	 ,pushLastVersionFile);
  
Return completeBuild;

END;

EXPORT SetOrbitForPrepBuild(STRING pBuildName,
                           STRING pVersion,
													 STRING pReprocess =' ') := FUNCTION

STRING36  	oLogin		:= Bair.Orbit_SOAPCalls.login.creds		: INDEPENDENT	;
pBuildMaster	:= 'mb_'+ STD.Str.toLowerCase(STD.STR.SplitWords(pBuildName,'_')[1]) +'_prep';

updateBuild := Bair.Orbit_SOAPCalls.UpdateBuildStatus(pBuildName, 'BuildOnHold',pVersion, ' ', oLogin);
createBuild := Bair.Orbit_SOAPCalls.CreateBuild(pBuildName,'BuildInProgress',pVersion,'WU', pBuildMaster,oLogin);

Return if (pReprocess = 'Reprocess',
                       updateBuild,
								       createBuild);

END;

EXPORT SetOrbitForBuildAll(STRING pBuildName,
                           STRING pVersion,
													 STRING pReprocess =' ') := FUNCTION
											 
STRING36  	oLogin		:= Bair.Orbit_SOAPCalls.login.creds		: INDEPENDENT	;

pBuildMaster 			    := if(pBuildName[1..4]='bair','mb_bair_input_update','mb_agencies_input_update');

updateBuild  			    := Sequential(Bair.Orbit_SOAPCalls.UpdateBuildStatus(pBuildName,'BuildOnHold',pVersion, ' ', oLogin));
createBuild  			    := Sequential(Bair.Orbit_SOAPCalls.CreateBuild(pBuildName,'BuildInProgress',pVersion,'WU',pBuildMaster,oLogin));

updBuildStatus        := if(pReprocess='Reprocess',updateBuild,createBuild); 

Return updBuildStatus;

END;


EXPORT SetOrbitBuildToReprocess (STRING pBuildName, STRING buildVersionToReprocess) := FUNCTION

STRING36  	oLogin			 := Bair.Orbit_SOAPCalls.login.creds		: INDEPENDENT	;

buildName := pBuildName;
fCandidates := Bair.Orbit_SOAPCalls.GetCandidates('allagencies_input_prep', 'candidates', oLogin  ).BuildsComponents.BuildData.CandidatesR.OutDs(STD.STR.Find(filename,buildVersionToReprocess)>0):INDEPENDENT;
pReceivingID  := fCandidates[1].receivingId;
receiveDate := Std.Date.ConvertDateFormat((STRING8)Std.Date.Today(), '%Y%m%d', '%Y-%m-%d'):INDEPENDENT;

CurrentBuildStatus       := Bair.Orbit_SOAPCalls.GetBuildInstance(buildName, buildVersionToReprocess, oLogin).Builds.BuildIBR.BuildStatus:INDEPENDENT;	

SeqFromBuiltORInProgress := Sequential(Bair.Orbit_SOAPCalls.UpdateBuildStatus(buildName, 'FailedQA',buildVersionToReprocess, ' ', oLogin)
																		  ,Bair.Orbit_SOAPCalls.UpdateBuildStatus(buildName, 'BuildOnHold',buildVersionToReprocess, ' ', oLogin)
                                      ,Bair.Orbit_SOAPCalls.UpdateBuildStatus(buildName, 'BuildAvailableForUse',buildVersionToReprocess, ' ', oLogin)
																			,Bair.Orbit_SOAPCalls.UpdateReceive(receiveDate	, pReceivingID	, 'Failed', oLogin)						
																			,Bair.Orbit_SOAPCalls.UpdateReceive(receiveDate	, pReceivingID	, 'Loaded', oLogin)			
																			);

SeqFromFailedQA          := Sequential(Bair.Orbit_SOAPCalls.UpdateBuildStatus(buildName, 'BuildOnHold',buildVersionToReprocess, ' ', oLogin)
                                      ,Bair.Orbit_SOAPCalls.UpdateBuildStatus(buildName, 'BuildAvailableForUse',buildVersionToReprocess, ' ', oLogin)
																		 	,Bair.Orbit_SOAPCalls.UpdateReceive(receiveDate	, pReceivingID	, 'Failed', oLogin)						
																			,Bair.Orbit_SOAPCalls.UpdateReceive( receiveDate	, pReceivingID	, 'Loaded' , oLogin)			
																			);
																		 
SeqFromBuildOnHold       := Sequential(Bair.Orbit_SOAPCalls.UpdateBuildStatus(buildName, 'BuildAvailableForUse',buildVersionToReprocess, ' ', oLogin)
																			,Bair.Orbit_SOAPCalls.UpdateReceive(receiveDate	, pReceivingID	, 'Failed', oLogin)								
																			,Bair.Orbit_SOAPCalls.UpdateReceive( receiveDate	, pReceivingID	, 'Loaded' , oLogin)
																			 );
																		 
changeStatus             := MAP (currentBuildStatus = 'BuildInProgress' => SeqFromBuiltORInProgress,
                                 currentBuildStatus = 'Built' 					=> SeqFromBuiltORInProgress,																 
                                 currentBuildStatus = 'Failed' 			 	=> SeqFromFailedQA,
																 currentBuildStatus = 'BuildOnHold' 		=> SeqFromBuildOnHold);

Return changeStatus;
 
END;

EXPORT SetOrbitForPrepBatch(String BatchVersion, string ManifestName, String BuildStatus)	:= FUNCTION

STRING36  oLogin				:= Bair.Orbit_SOAPCalls.login.creds		: INDEPENDENT	;
STRING		pServerIP			:= Bair._Constant.bair_batchlz;
rgxVersion 							:= '\\_([0-9]{8})\\_([0-9]{9})\\.';
rgxverfilter 						:= '([0-9]{8}[_][0-9]{9})';
rgxAgency								:='\\_([a-zA-Z]+)\\_([0-9]+)\\_';	
// rgxName		 							:= '([a-zA-Z]+)\\_([0-9]+)\\_([0-9]{8})\\_([0-9]{9}).';	
// rgxName									:='\\_([*_a-zA-Z]+)\\_([0-9]+)\\_';
rgxName									:='EVENT|CFS|CRASH|OFFENDER|LPR';
rgxLandingZone 					:= 'data\\/([a-zA-Z]+)\\/ready';	
BatchBuildName					:= 'batchimports_input_prep';
BatchMasterBuild				:= 'mb_batchimports_input_prep';

pStatus 								:= 	STD.Str.ToTitleCase(BuildStatus);										 
											 
receiveDate 						:= Std.Date.ConvertDateFormat(ut.GetDate, '%Y%m%d', '%Y-%m-%d'):INDEPENDENT;

ManifestFile	:= '~'+ManifestName;
manifest := dataset(ManifestFile,{string filename},csv);

sCandidates := RECORD
  STRING fileVersion;
  STRING buildName;
	STRING FileName;
	STRING FileType;
	STRING Agency;
	STRING masterBuild;
	STRING member_id :='' ;
	STRING filesource_id :='';
	STRING receivingID;
	STRING prepFabBuildStatus:='';
	STRING isItemOnHold:='';
END;

sCandidates tCandidates(manifest L) := TRANSFORM
			SELF.fileVersion  	:= regexfind(rgxVersion, L.FileName,1)+ '_'+ regexfind(rgxVersion, L.FileName,2);
      SELF.buildName    	:= '';
			// SELF.FileType				:= REGEXFIND(rgxName,L.FileName,1);
			SELF.FileType				:= REGEXFIND(rgxName,L.FileName,0);
			SELF.Agency					:= regexfind(rgxAgency,L.FileName,2);
      SELF.masterBuild  	:= '';
			SELF.member_id 			:= REGEXFIND('_m([\\S\\s]+)_', L.FileName , 1)[1..4];
	    SELF.filesource_id 	:= REGEXFIND('_m([\\S\\s]+)_', L.FileName , 1)[5];
			SELF.ReceivingId		:= REGEXFIND('_i([0-9]+)_',L.FileName,1);
      SELF := L;
END;
rFilesVersions      			:= PROJECT(manifest, tCandidates(LEFT));
sortedFilesVersions 			:= SORT(rFilesVersions,buildName,fileVersion):INDEPENDENT;

fCandidates := Bair.Orbit_SOAPCalls.GetCandidates('allagencies_input_prep', 'candidates', oLogin  ).BuildsComponents.BuildData.CandidatesR.OutDs(ReceivingStatus='Loaded' and (Integer)receivingid >360047);

GetBuildName	:= Join(sortedFilesVersions,fCandidates,left.ReceivingId=right.ReceivingId,
											transform(sCandidates
											,self.buildname 	:=STD.STR.SplitWords(right.BatchR3LandingZone,'/')[2] +'_'+left.FileType+'_input_prep'
											,self.masterBuild :='mb_'+STD.Str.ToLowerCase(STD.STR.SplitWords(right.BatchR3LandingZone,'/')[2]) +'_prep'
											,self:=left));		

sCandidates tBuilds(sCandidates L) := TRANSFORM
		SELF.prepFabBuildStatus := STD.Str.ToLowerCase(Bair.Orbit_SOAPCalls.GetBuildInstance(L.buildName, L.fileVersion, oLogin).Builds.BuildIBR.BuildStatus);	
		SELf.isItemOnHold 			:= Bair.Orbit_SOAPCalls.GetContributionData(L.filesource_id, L.member_id, oLogin).Items.ContributionItem.IsItemOnHold;
   	SELF := L;
END;
rFabBuild := PROJECT(GetBuildName, tBuilds(LEFT));
rFabBuildPrep	:= dedup(rFabBuild,buildname,fileversion,all);

rFabReceivePrep	:= dedup(rFabBuild,buildname,fileversion,ReceivingId,all);

BuildSucess	:= sequential(APPLY(rFabBuildPrep , Sequential(
																Bair.Orbit_SOAPCalls.CreateBuild(BuildName,'BuildInProgress',fileVersion,'WU', masterBuild,oLogin)
																,Bair.Orbit_SOAPCalls.UpdateBuildStatus(BuildName,'Quarantine',fileVersion,'',oLogin)
																,Bair.Orbit_SOAPCalls.UpdateBuildStatus(BuildName,'BuildAvailableForUse',fileVersion,'',oLogin)))
													,Bair.Orbit_SOAPCalls.CreateBuild(BatchBuildName,'BuildInProgress',BatchVersion,'WU', BatchMasterBuild,oLogin)
													,APPLY(rFabBuildPrep , Sequential(
																 Bair.Orbit_SOAPCalls.AddABuildToAConsolidateBuild(BatchBuildName,BatchVersion,BuildName, fileVersion,oLogin).OrbitStatus.OrbitStatusDescription
																,Bair.Orbit_SOAPCalls.UpdateBuildStatus(BuildName,'Built',fileVersion,'',oLogin)))
													,Bair.Orbit_SOAPCalls.UpdateBuildStatus(BatchBuildName,'Built',BatchVersion,'',oLogin)
													,Bair.Orbit_SOAPCalls.UpdateBuildStatus(BatchBuildName,'PassedQA',BatchVersion,'',oLogin)
													);
													
ReceiveSucess	:= APPLY(rFabReceivePrep , sequential(
									Bair.Orbit_SOAPCalls.UpdateReceive(ReceiveDate,receivingid,'Sprayed',	oLogin)
									,Bair.Orbit_SOAPCalls.UpdateReceive(ReceiveDate,receivingid,'Reformatted',	oLogin)
									,Bair.Orbit_SOAPCalls.AddComponentsToABuild (BuildName, fileVersion,ReceivingId, oLogin).OrbitStatus.OrbitStatusDescription
											)); 
							
BuildFailed	:= sequential(APPLY(rFabBuildPrep , sequential(
																	Bair.Orbit_SOAPCalls.CreateBuild(BuildName,'BuildInProgress',fileVersion,'WU', masterBuild,oLogin)
																	,Bair.Orbit_SOAPCalls.UpdateBuildStatus(BuildName,'Failed',fileVersion,'Build Failed',oLogin)
																))
													,Bair.Orbit_SOAPCalls.CreateBuild(BatchBuildName,'BuildInProgress',BatchVersion,'WU', BatchMasterBuild,oLogin)
													,Bair.Orbit_SOAPCalls.UpdateBuildStatus(BatchBuildName,'Failed',BatchVersion,'Build Failed',oLogin)); 
							
ReceiveFailed	:= APPLY(rFabReceivePrep , sequential(
									Bair.Orbit_SOAPCalls.UpdateReceive(ReceiveDate,receivingid,'Failed',	oLogin)
											)); 		


UpdBatch		:= MAP(pStatus = 'Built' =>Sequential(BuildSucess,ReceiveSucess)
									,pStatus = 'Failed' =>Parallel(BuildFailed,ReceiveFailed)
									);
Return 	UpdBatch;							
END;

END;

