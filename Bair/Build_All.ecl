import bair_boolean,Bair_composite, _Control, ut, std, bair_importer,wk_ut;

export Build_all(string buildName, string version, boolean pUseProd = false, boolean pDelta = false, boolean pRecover = false) := function
	
	buildtime := (string8)std.date.today() + '_' + ut.getTime() : INDEPENDENT;
	
	dummy:='';
	noGo:=sequential(dummy);
	
	wunameCF := 'Bair COMPOSITE Delta Build and Deploy*?';
	valid_state := ['blocked','running','wait','submitted','compiling','compiled'];

	d := count(nothor(WorkunitServices.WorkunitList('',NAMED jobname:=wunameCF))(wuid <> thorlib.wuid() and state in valid_state));
	
	nightly := if(STD.Str.ToUpperCase(buildName[1..4]) = 'BAIR', true, false);
	BldChkPt	:= dataset(Bair.Superfile_List(pDelta).BldChkPt, {unsigned1 pos}, flat, opt);
	ChkPtPos	:= BldChkPt[1].pos;
	
	ECL_OrbitUpdate := 
				'#WORKUNIT(\'name\', \'Bair Orbit Update\');\n'
			+'oupdate := bair.fUpdateORBIT(\'bair_input_candidate\',\''+ version[1..8]+'\', pFromStatus:=\'Sprayed\', pToSatatus:=\'Reformatted\');\n'
			+'oupdate;\n';
				
	built := 	sequential(
							 if(ChkPtPos > 0 and pRecover, noGo, Bair.UpdateCheckPt(0, pDelta))
							 //Saves the current build version and build name in a logical file for Boolean and Composite Build to pull the version and buildname.
							,if(not pRecover, Bair.post_BuiltVers(version, buildName, buildtime, false, pDelta).Builds)
							//Base processing and building unit.
							,if(ChkPtPos > 10 and pRecover
								,noGo 
								,sequential(
									Bair.proc_Bases(buildName ,version ,pUseProd ,pDelta, pRecover, ChkPtPos).bld_all
								 ,Bair.UpdateCheckPt(10, pDelta)  //Building of Bases completed.
								 )
							 )
							//Key processing and building unit.
							,if(ChkPtPos > 11 and pRecover
								,noGo
								,sequential(
									Bair.proc_Keys(version, pUseProd,pDelta).bld_all
								 ,Bair.UpdateCheckPt(11, pDelta)  //Building of Keys completed.
								 )
							 )
							,if(pDelta and Bair.Superfile_List().BuiltVers_FlushRecs[1].flushed = false
								,sequential(
									 Bair.post_BuiltVers(Bair.BuildInfo.LastFull[1].ver, Bair.BuildInfo.LastFull[1].buildname, Bair.BuildInfo.LastFull[1].buildtime, true, false).Builds
									,Bair.post_BuiltVers(version, '', '', true).FlushBuiltVers
									)
								)
							,Bair.UpdateCheckPt(12, pDelta)  //Delta Cycle completed.
							// ,if(pDelta and nightly, sequential(wk_ut.CreateWuid(ECL_OrbitUpdate,'hthor',Bair._ESP)))
							,if(not pDelta, parallel(
																Bair.HeaderInfo.Post
															 ,Bair.Mod_Report_LexID(version, pDelta).sendLexid
															 ,Bair.Mod_Report_LexID(version, pDelta).sendPayload
															 )
								)
							,if(pDelta, notify('bld_and_deploy_booleankeys_delta','*'), notify('bld_and_deploy_booleankeys_full','*'))							
							,if(d > 0 and pDelta, noGo, if(pDelta, notify('bld_and_deploy_compositekeys_delta','*')))
							)
							: success(Send_Email(version,pUseProd,pDelta).BuildSuccess)
							, failure(send_email(version,pUseProd,pDelta).BuildFailure)
							;
	
	return built;
	
end;