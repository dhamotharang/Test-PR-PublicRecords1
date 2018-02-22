import versioncontrol, ut, std, bair_boolean,Bair_importer,wk_ut;

EXPORT proc_Bases(string buildName, string version, boolean pUseProd = false, boolean pDelta = false, boolean pRecover = false, unsigned1 ChkPtPos) := module
	
	pDate 				:= (string8)std.date.today():INDEPENDENT;
  pTime 				:= ut.GetTimeStamp():INDEPENDENT;
  fVersion 			:= 'f'+ pDate + '_' + pTime;
	
	spray_list 	:= Bair.fSpray(version,pUseProd);
	spray_  	 	:= VersionControl.fSprayInputFiles(spray_list, pIsTesting:= false);
	
	dummy:='';
	noGo:=sequential(dummy);
	
	ECL_OrbitUpdate := 
					'#WORKUNIT(\'name\', \'Bair Orbit Update\');\n'
				+'oupdate := bair.fUpdateORBIT(\'bair_input_candidate\',\''+ version[1..8]+'\', pFromStatus:=\'Loaded\', pToSatatus:=\'Sprayed\');\n'
				+'oupdate;\n';
		
	EXPORT bld_all 
			:= if(pDelta
						//Building Block for DELTA.
						,sequential(
								if(Bair.BuildInfo.DeltaToBeFlushed
									//If Last FULL pkg is live on ROXIE, do following:
									//1) Sets last FULL version to deployed.
									//2) Drop records present in INTERMEDIARY DELTA from DELTA(BUILT) based on TIMESTAMP and create a new DELTA BUILT.
									//3) Promote GEOHASH FULL in INTERMEDIARY(created during last FULL build) to BUILT.
									//4) Flush out all INTERMEDIARY super files.
									 ,sequential(
													Bair.post_BuiltVers(version+'_false', '', '', false).FlushBuiltVers
												 ,if(ChkPtPos > 1 and pRecover
													 ,noGo
													 ,sequential(
														 Bair.Update_Deltas_After_Full_Live_OnRoxie(version, pUseProd)										 
														,Bair.UpdateCheckPt(1, pDelta)
														)
												  )
												 ,if(ChkPtPos > 2 and pRecover
													 ,noGo
													 ,sequential(
														 Bair.util(version, pUseProd).PromoteIntermediaryGeoHashFullToBuilt									 
														,Bair.UpdateCheckPt(2, pDelta)
														)
													)
												 ,if(ChkPtPos > 3 and pRecover
													 ,noGo
													 ,sequential(
														 Bair.util(version, pUseProd).RemoveIntermediaryDeltas
														,Bair.UpdateCheckPt(3, pDelta)
														)
													)
												 ,if(ChkPtPos > 4 and pRecover
													 ,noGo
													 ,sequential(
														 Bair.util(version, pUseProd).Comp_Delta_Clear
														,Bair.UpdateCheckPt(4, pDelta)
														)
													)
										)
									 ,if(ChkPtPos > 4 and pRecover
										 ,noGo
										 ,Bair.UpdateCheckPt(4, pDelta)
										 )
								)
							//Continue to build DELTAS with previous base DELTAS and feed files from NIGHTLY and/or PREPPED.
							//Move out all the last processed NIGHTLY files to history.
							,if(ChkPtPos > 5 and pRecover
								,noGo
								,sequential(
									 Bair.util(version, pUseProd).MoveNightlyInputFilesToHistory
									,Bair.UpdateCheckPt(5, pDelta)
									)
								)
							//Move out all the last processed PREPPED files to history.
							,if(ChkPtPos > 6 and pRecover
								,noGo
								,sequential(
									 Bair.util(version, pUseProd).MovePreppedInputFilesToHistory
									,Bair.UpdateCheckPt(6, pDelta)
									)
								)
							//Move in all the current PREPPED files to Input to process.
							,if(ChkPtPos > 7 and pRecover
								,noGo
								,sequential(
									 Bair.util(version, pUseProd).MovePreppedToInSuperFiles
									,Bair.UpdateCheckPt(7, pDelta)
									)
								)
							//Turn On the SENTINEL flag to be Available to the IMPORTER.
							,Bair_importer.Sentinel_Flag.fn_SetBairSentinelFlag(FALSE, fVersion,TRUE)
							//Checks if the feed is NIGHTLY or PREPPED. 
							,if(STD.Str.ToUpperCase(buildName[1..4]) = 'BAIR'
								//If the feed is NIGHTLY, do following:
								//1) Move the feed files to SPRAYING from READY in LZ.
								//2) Spray 31 files.
								,sequential(
											if(ChkPtPos > 8 and pRecover
												,noGo
												,sequential(
													 Bair.fFileMoves(version).MoveReadyToSpraying
													,Bair.UpdateCheckPt(8, pDelta)
													)
											)
										 ,if(ChkPtPos > 9 and pRecover
												,noGo
												,sequential(
													 spray_
													,Bair.fFileMoves(version).MoveSprayingToDone
													,Bair.UpdateCheckPt(9, pDelta)
													)
											)
										 ,Bair.Mod_BadDate_Reports(version, true).send
										 // ,bair.fUpdateORBIT('bair_input_candidate', version[1..8], pFromStatus:='Loaded', pToSatatus:='Sprayed')
										 // ,wk_ut.CreateWuid(ECL_OrbitUpdate,'hthor',Bair._ESP)
								 )
								,sequential(
									 if(ChkPtPos > 9 and pRecover
										 ,noGo
										 ,Bair.UpdateCheckPt(9, pDelta)
										 )
									,Bair.Mod_BadDate_Reports(version, false).send
								)
							 )
							 //Initiates the base building process for DELTAS.
							 ,Bair.Build_Updates(version,pUseProd).delta_base
						 )
						 //Building Block for FULL.
						,sequential(
							//Flush out all INTERMEDIARY super files. 
						  if(ChkPtPos > 1 and pRecover
								 ,noGo
								 ,sequential(
									 Bair.util(version, pUseProd).RemoveIntermediaryDeltas
									,Bair.UpdateCheckPt(1, pDelta)
									)
								)
							//Copy contents of the DELTA built to INTERMEDIARY super files.
							,if(ChkPtPos > 2 and pRecover
								 ,noGo
								 ,sequential(
									 Bair.util(version, pUseProd).SaveDeltaBuiltBasesToIntermediary
									,Bair.UpdateCheckPt(2, pDelta)
									)
								)
						 ,if(ChkPtPos > 3 and pRecover
								 ,noGo
								 ,sequential(
									 Bair.util(version, pUseProd).Comp_Temp_Clear
									,Bair.UpdateCheckPt(3, pDelta)
									)
								)
						 ,if(ChkPtPos > 4 and pRecover
								 ,noGo
								 ,sequential(
									 Bair.util(version, pUseProd).Comp_Temp_Set
									,Bair.UpdateCheckPt(4, pDelta)
									)
								)
						 //Initiates the base building process for FULL.
						 ,Bair.Build_Updates(version,pUseProd).full_base						 
						 )
					);
End;