import Bair,ut;

EXPORT Orbit_Module_Candidates := MODULE
	//  ADD COMPONENENTS TO A BUILD
	EXPORT fn_addComponentsToABuild(  String pBuildName, 
																		String pVersion, 
																		String pItemName = '', // IF EMPTY THEN PROCESS ALL
																		String oLogin) := FUNCTION
		
		CandidatesTBL := Bair.Bair_Orbit.GetCandidates(	pBuildName	, pVersion, oLogin  ).BuildsComponents.BuildData.CandidatesR.outDS;
		
		CandidatesRS := IF(  pItemName='', // IF EMPTY THEN PROCESS ALL
												 CandidatesTBL,
												 CandidatesTBL(ItemName = pItemName)
											);
		
		c_layout_ := record
			String AddComponent;
		end;
		
		c_layout_ candidatesT(CandidatesRS L) := TRANSFORM
			//  ADD A COMPONENT TO THE BUILD
			SELF.AddComponent := Bair.Bair_Orbit.AddComponentsToABuild ( pBuildName, pVersion , L.ReceivingID , oLogin	).BuildsResponse.InstanceToAdd.MasterBuildId ;
		END;

		AddComponentsToABuildResponse:= PROJECT(CandidatesRS, candidatesT(LEFT));
		return(Count(AddComponentsToABuildResponse));
	END;

	//  UPDATE THE STATUS OF THE FILES
 	EXPORT fn_updateDailyFileStatus(  String pBuildName, 
   	                                  String pVersion, 
   																		String pItemName = '',  // IF EMPTY THEN PROCESS ALL
   																		String pNewStatus, 
   																		String oLogin) := FUNCTION
   		
   		CandidatesTBL := Bair.Bair_Orbit.GetCandidates(	pBuildName	, pVersion, oLogin  ).BuildsComponents.BuildData.CandidatesR.outDS;
   		
   		CandidatesRS := IF(  pItemName='', // IF EMPTY THEN PROCESS ALL
   												 CandidatesTBL,
   												 CandidatesTBL(ItemName = pItemName)
   											);
   		
   		c_layout_ := record
   			STRING UpdateStatus;
   		end;
   		c_layout_ candidatesT(CandidatesRS L) := TRANSFORM
   			//  TODO: UPDATE THE STATUS OF A DAILY FILE
   			SELF.UpdateStatus := Bair.Bair_Orbit.UpdateDailyFilesStatus ( pVersion , L.ReceivingID , pNewStatus	) ;
   		END;
   
   		updateDailyFileStatusResponse:= PROJECT(CandidatesRS, candidatesT(LEFT));
   		
   		return(updateDailyFileStatusResponse);
   	END;

	

END;