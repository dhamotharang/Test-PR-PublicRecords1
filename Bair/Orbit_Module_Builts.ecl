	import BAIR, ut;
	EXPORT Orbit_Module_Builts := MODULE
		export Build_Agency(String pAgencyName, String pBuildName, String pVersion,UNSIGNED4	pFilesCount) := function
				//  CONNECT TO ORBIT
				STRING36  	oLogin			:= Bair.Bair_Orbit.login.creds		: INDEPENDENT	;			
				
				ComponentsAddedToABuild := Bair.Orbit_Module_Candidates.fn_addComponentsToABuild(pBuildName,pVersion,'',oLogin);
				
				//  IF THE NUMBER OF FILES READY MATCH WHAT THE AGENCY IS EXPECTING THE BUILD ALL FILES.
				result := IF(ComponentsAddedToABuild = pFilesCount, 
				//  BUILD ALL FILES FOR THIS AGENCY PAGENCYNAME
											bair.Build_All_Mockup(pBuildName, pVersion, FALSE, FALSE),
											'No Files'
										 );			
				
				return(result);
		end;
		
		export Build_All(String pVersion) := FUNCTION

				vlayout_ := record
					Bair.Layouts.Orbit_Agencies_Layout;
					STRING message;
				end;
				vlayout_ t2(Bair.Layouts.Orbit_Agencies_Layout L) := TRANSFORM
					//  BUILD THIS AGENCY L.AGENCY, L.BUILDNAME, L.NUMFILES
					SELF.message := Build_Agency(L.AgencyName, L.BuildName, pVersion, L.FilesCount);
					SELF := L;
				END;
				
				Orbit_Build_All:= PROJECT(Bair.Files().Orbit_Agencies, t2(LEFT));
				return(Orbit_Build_All);
		END;
END;		