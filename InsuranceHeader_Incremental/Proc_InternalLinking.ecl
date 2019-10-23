IMPORT STD, InsuranceHeader_salt_T46, InsuranceHeader;
EXPORT Proc_InternalLinking(STRING iter, STRING versionIn) := MODULE
		
		SHARED saltOutput_file	:= Filenames.SALT_Output_LF(versionIn,WORKUNIT,iter);
		SHARED statsILink_file  := Filenames.StatsILink_LF(versionIn,WORKUNIT,iter);
		SHARED saltInput_file  := Filenames.SALT_Input_LF(versionIn,WORKUNIT,iter);
		
	// Salt Iteration
		SHARED saltMod					:= InsuranceHeader_salt_T46.Proc_Iterate(iter,
																																		 Files.SALT_Input_Current_DS,,,
																																		 TRUE,
																																		 saltOutput_file,
																																		 FileNames.IlinkStatsFileTemp);
		SHARED linking					:= saltmod.DoAll;
		
		SHARED salt_output			:= DATASET(saltOutput_file,Layout_Header,THOR);
		SHARED salt_input 			:= OUTPUT(salt_output,,saltInput_file,COMPRESSED);
		
		timestampUse := CurrentDateTimeStamp : INDEPENDENT;
		transformNewStats := PROJECT(DATASET(FileNames.IlinkStatsFileTemp, {STRING stat,UNSIGNED countgroup}, THOR),
																				 TRANSFORM(Layout_stats,
																									 SELF.wuid := WORKUNIT,
																									 SELF.version := versionIn,
																									 SELF.iteration := (UNSIGNED2)iter,
																									 SELF.timeStamp := timestampUse,
																									 SELF.src := '',
																									 SELF.statName := LEFT.stat,
																									 SELF.statValue := (REAL8)LEFT.countgroup,
																									 SELF.ignore := FALSE));
		allStats := transformNewStats & Files.StatsILink_Current_DS;
		SHARED outStats := OUTPUT(allStats,, statsILink_file, COMPRESSED);
		
		
		/* ----------------------UpdateSuperFile --------------------------------*/
		SHARED addToOutputSF 		:= SEQUENTIAL(InsuranceHeader.mod_Superfiles.mac_makeFiles(Filenames.SALT_Output_SF),
																					Superfiles.updateSF(saltOutput_file,Filenames.SALT_Output_SF));
		
		SHARED addToInputSF 		:= SEQUENTIAL(InsuranceHeader.mod_Superfiles.mac_makeFiles(Filenames.SALT_Input_SF),
																					Superfiles.updateSF(saltInput_file,Filenames.SALT_Input_SF));
																					
		SHARED addtoStatsSF     := SEQUENTIAL(InsuranceHeader.mod_Superfiles.mac_makeFiles(Filenames.StatsILink_SF),
																					Superfiles.updateSF(statsILink_file,Filenames.StatsILink_SF));
		
		EXPORT addToSuperFile		:= SEQUENTIAL(STD.File.StartSuperfileTransaction(),
																					PARALLEL(addToOutputSF,addToInputSF,addToStatsSF),
																					STD.File.FinishSuperfileTransaction());				
		EXPORT runIter 					:= SEQUENTIAL(linking,salt_input,outStats,addToSuperFile);
END;
