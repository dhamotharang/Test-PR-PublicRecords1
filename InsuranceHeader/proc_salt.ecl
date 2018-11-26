import InsuranceHeader_Salt_T46, insuranceheader_preprocess, idl_heaDER, InsuranceHeader_PostProcess;
import InsuranceHeader_Strata,InsuranceHeader_Alerts;


// Preprocess
export proc_salt(string iter) := module
		shared String8 strataVersion := thorlib.wuid()[2..9];
			
		// Salt Iteration
		shared saltMod 					  	:= InsuranceHeader_salt_T46.Proc_Iterate(iter,IDL_Header.Files.DS_IDL_SALT_ITER_BASE);
		shared linking							:= saltmod.DoAll;
		
		/* =----------------------SALT output with Policy data--------------------------------*/
		shared saltOutput_file     	:= idl_header.files.FILE_IDL_SALT_ITER + 'SALT_OUTPUT';
		shared saltOutput_ds				:= dataset(saltOutput_file, idl_header.Layout_Header_Link, flat);
		
		shared salt_iter_file				:= idl_header.files.FILE_IDL_SALT_ITER + iter;
		shared salt_iter_ds	 				:= output(saltOutput_ds, , salt_iter_file , COMPRESSED, overwrite);
		
		/* ----------------------UpdateSuperFile --------------------------------*/
		export addToSuperFile		   	:= InsuranceHeader_PreProcess.SuperFiles.updateSALTOutputSuperFiles(salt_iter_file);		

		// Archive Link Records
		export archiveLinkRecords    := InsuranceHeader_PostProcess.archiveLinkRecords(iter).doAll;

		// Archive Deleted Records
		export archiveDeletedRecords := InsuranceHeader_PostProcess.archiveDeletedRecords(iter).doAll;		

		/* =----------------------Generate Cleave Stats --------------------------------*/
		shared cleaveMod					:= InsuranceHeader_PostProcess.mod_generateCleaveStats;
		//export CleaveStats 				:= output(cleaveMod.stats, named('CleaveStats'));
		export CleaveStats1				:= cleaveMod.stats;
		export CleaveStats				:= output(CleaveStats1,,'~thor::headerStats::cleave::current',OVERWRITE);
		shared cleaveInput				:= InsuranceHeader_PostProcess.mod_loadCleaveRecords.UpdateInputSF(cleaveMod.cleaveInput);
		shared cleaveOutput				:= InsuranceHeader_PostProcess.mod_loadCleaveRecords.UpdateOutputSF(cleaveMod.cleaveOutput);

		//generate InsuranceHeader-data-Cleave-stats
		export t1 := InsuranceHeader_Strata.Cleave(CleaveStats1, strataVersion);
		
		//generate InsuranceHeader-data-LexIDBySource-stats
		bocahdr := IDL_Header.Files.DS_BOCA_HEADER_BASE;
		didDist0 := InsuranceHeader_PostProcess.mod_didcount(saltOutput_ds, bocahdr).allCount;
		strata_didDist0 := project(didDist0, InsuranceHeader_Strata.layouts.layout_LexIDBySource);
		export t2 := InsuranceHeader_Strata.LexIDBySource(strata_didDist0, strataVersion);
		
		//generate rid tracking stats
		ridTracking := JOIN(IDL_Header.Files.DS_SALT_ITER_OUTPUT,IDL_Header.Files.DS_IDL_POLICY_HEADER_BASE,LEFT.rid = RIGHT.rid,TRANSFORM({unsigned rid,string didChange},SELF.didChange := IF(LEFT.did = RIGHT.did,'SAME',IF(RIGHT.did > 0,'CHANGED','NEW'));SELF :=LEFT),LEFT OUTER,HASH);
		ridTracking_tab := TABLE(ridTracking,{ridTracking.didChange;unsigned cnt := COUNT(GROUP)},didChange,FEW);
		export t3 := OUTPUT(ridTracking_tab,,'~thor::headerStats::ridTracking::current',OVERWRITE);
		
		/*Can use logic below to only calculate some stats on final iteration*/
		mtchCnt := DATASET('~thor_data400::base::InsuranceHeader::' + InsuranceHeader_Salt_T46.Config.Infix + '::linkStats',{string stat,unsigned countgroup},THOR)(stat = 'matchesPerformed')[1].countgroup;
		t0 := IF(mtchCnt > proc_constants.stopcondition, SEQUENTIAL(t1),PARALLEL(t1,t2,t3));
		
	export runIter := sequential(linking, salt_iter_ds, addToSuperFile, archiveLinkRecords, archiveDeletedRecords, cleaveStats, t0, cleaveInput, cleaveOutput,InsuranceHeader_Alerts.procLink.run)
							  : SUCCESS(InsuranceHeader.mod_email.SendSuccessEmail(,'InsuranceHeader', , 'SALT')), 
								FAILURE(InsuranceHeader.mod_email.SendFailureEmail(,'InsuranceHeader', failmessage, 'SALT'));

end;