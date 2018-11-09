import std;

EXPORT Manage_Builds := MODULE
				
				SHARED pServerIP				:= Bair._Constant.bair_batchlz;
				SHARED preppedSFSet := 	SET(Bair._Constant.prepSF, supername);	

				EXPORT BairBuildReadyToGo() := FUNCTION 

					readytogo := FileServices.RemoteDirectory(pServerIP, '/data/bair/ready/', 'readytogo');
					nightly 		:= FileServices.RemoteDirectory(pServerIP, '/data/bair/ready/', '*.utf8');
										
					buildName 					:='bair_input_update';
					rgxBairVersion	:= '\\.([0-9]+)\\.([0-9]+)\\.';
					buildVersion 		:= regexfind(rgxBairVersion, nightly[1].name,1) + '_' + regexfind(rgxBairVersion, nightly[1].name,2);
					
					bairBuild   			:= IF (count(readytogo) > 0, 'bair_input_update ' + buildVersion, '');

					return bairBuild;

				END;
				
				EXPORT GetCurrentPreppedSuperFiles() := FUNCTION

					preppedFiles 		:= STD.File.LogicalFileSuperSubList()(supername in preppedSFSet and subname!='');
					return preppedFiles;

			END;
			
			SHARED preppedFiles := GetCurrentPreppedSuperFiles();;
			
			EXPORT GetPreppedAgencyBuildVersion() := FUNCTION		
				
				preppedCurrentFilesCnt  := Count(STD.STR.SplitWords(preppedFiles[1].subname,'::'));
				buildVersion  	 								:= STD.STR.SplitWords(preppedFiles[1].subname,'::')[preppedCurrentFilesCnt];

				Return buildVersion;

			END;

			EXPORT AgencyBuildReadyToGo() := FUNCTION
			
				buildVersion := GetPreppedAgencyBuildVersion();				
				agencyBuild  := if(COUNT(preppedFiles) > 0, 'agencies_input_update ' + buildVersion,'');

				Return agencyBuild;

			END;
			
			
			EXPORT BuildManifest(
																STRING pBuildName,
															 STRING pVersion, 
															 STRING pStatusRequested, 
															 STRING pComment=' '
															) := FUNCTION

				segment      		:= STD.Str.toLowerCase(pComment);//'COMPOSITE';																	 
				pStatus			 				:= STD.Str.ToTitleCase(pStatusRequested);  
				buildName     	:= std.str.SplitWords(pBuildName,' ')[1]; 
				buildName2    	:= std.str.SplitWords(pBuildName,' ')[2];
				preppedComment := if(buildName2!='', 'Contains *in::prepped::*::' + buildName2 + ' files\n Updated by the ' + segment + ' segment','');

				pushLastVersionFile := Bair.Orbit_Update.pushLastBuildManifest(buildName, buildName2, pVersion): INDEPENDENT;

				completeBuild       := pushLastVersionFile;
					
				Return completeBuild;

			END;
			
END;