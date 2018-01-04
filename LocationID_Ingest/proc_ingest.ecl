import AID;
import LocationID_Ingest;
import LocationID_Build;
import wk_ut;

export proc_ingest := module	

 export f_ingest_in	 := LocationID_Ingest.files_ingest.FILE_IN  + '_' + LocationID_Build.KeySuffix; 
 export f_ingest_out	:= LocationID_Ingest.files_ingest.FILE_OUT + '_' + LocationID_Build.KeySuffix;
 export ds_ingested  := project(Ingest().AllRecords, Layout_Base);
 
	export prepIngest() := function
	
		eclsample	 := '#workunit(\'name\',\'LocationID @version@\');\n'
								      + '#OPTION(\'multiplePersistInstances\',FALSE);\n' 
								      + 'evaluate(LocationID_Ingest.proc_ingest.fn_prepIngest())';
								

					 
		kickBuild	  := wk_ut.mac_ChainWuids(
			 eclsample,1,1,LocationID_Build.KeySuffix,
			,LocationID_Build.Constants.BuildServer
			,pOutputEcl        := false
			,pUniqueOutput     := 'LocationID_PrepIngest'
			,pNotifyEmails     := LocationID_Build.email_list
			,pOutputFilename   := LocationID_Build.Constants.HistoryFileNamePrefix + 'LocationID_PrepIngest'
			,pOutputSuperfile  := LocationID_Build.Constants.HistoryFileNameSFName
		);
		

		return kickBuild;
	end;

	export runIngest() := function
		
		eclsample	 := '#workunit(\'name\',\'LocationID @version@\');\n'
								      + '#OPTION(\'multiplePersistInstances\',FALSE);\n' 
								      + 'evaluate(LocationID_Ingest.proc_ingest.fn_runIngest())';
								

					 
		kickBuild	  := wk_ut.mac_ChainWuids(
			 eclsample,1,1,LocationID_Build.KeySuffix,
			,LocationID_Build.Constants.BuildServer
			,pOutputEcl        := false
			,pUniqueOutput     := 'LocationID_RunIngest'
			,pNotifyEmails     := LocationID_Build.email_list
			,pOutputFilename   := LocationID_Build.Constants.HistoryFileNamePrefix + 'LocationID_RunIngest'
			,pOutputSuperfile  := LocationID_Build.Constants.HistoryFileNameSFName
		);
		

		return kickBuild;
	end;
	
	export fn_prepIngest(dataset(AID.Layouts.rACECache) ds_as_linking = AID.Files.ACECacheProd ) := function	
		ds_ingest := project(ds_as_linking,
												 transform(Layout_Base,
									              self                  := left,
										             self.rid              := 0,
										             self.locid            := 0,
																					  self.source           := 'AP';
																	      self.source_record_id := left.aid;
																				   self.cntprimname      := 0;
															     ));
																	 
		getPrimNameCount := table(ds_ingest,{zip5,prim_name,unsigned8 cntprimname := count(group)}, zip5,prim_name);
		
		addPrimNameCount := join(ds_ingest, getPrimNameCount,
		                         left.zip5      = right.zip5 and
														             left.prim_name = right.prim_name,
																				       transform(Layout_Base,
		                                   self := right,
																			                  self := left), keep(1), hash);
																			                  
				go := sequential(
					output(distribute(addPrimNameCount, hash32(source_record_id)),, f_ingest_in, compressed, overwrite)
				,LocationID_Ingest.files_ingest.updateBuilding(f_ingest_in)
				);
	 
				return go;
				
		end;
		
		export fn_runIngest() := function
			go := sequential(
				output(ds_ingested,, f_ingest_out, compressed, overwrite)
			,LocationID_Ingest.files_ingest.updateSuperFiles(f_ingest_out)
		 );
	 
			return go;
		end;
	end;