IMPORT idops, orbit, _control, InsuranceHeader_xLink,InsuranceHeader_Ingest,std, IDL_header, InsuranceHeader_Incremental;

EXPORT proc_xlink_promote_update_idops(STRING version) := MODULE
    
		#workunit('name','Prod xIDL Lab Build');
		SHARED wu := thorlib.wuid();
		SHARED ingestDate       := version ; 
		SHARED promote2QA       := InsuranceHeader_xLink.SuperFiles(InsuranceHeader_xLink.KeyInfix).promoteFullQA ;
		SHARED update_idopsV2	  := idops.UpdateBuildVersion('IHeaderLABKeys',trim(ingestDate,left,right),mod_email.emailList,,'N');
		SHARED update_orbitV2 	:= orbit.CreateBuild('IHeaderLAB','IHeaderLAB',ingestDate,'Production NonFCRA',orbit.GetToken());
		EXPORT run_xIDLV2	      := SEQUENTIAL(promote2QA, update_idopsV2);
		
		SHARED headerBase    := IDL_Header.files.ds_idl_policy_header_base;
		SHARED headerBase_LF := InsuranceHeader_Incremental.Filenames.Prefix_dsBase+ingestDate+'_'+wu;
		EXPORT op_base       := OUTPUT(headerBase,,headerBase_LF,compressed);
		EXPORT updateIncBase := STD.file.PromoteSuperfileList([InsuranceHeader_Incremental.Filenames.dsBase_SF.current],headerBase_LF,TRUE);
		
		SHARED bocaIngestDate := InsuranceHeader_Incremental.Build_Date.BocaRaw;
		
		SHARED ds_date      := DATASET([{'FULL',bocaIngestDate,ingestDate}],InsuranceHeader_Incremental.Layout_Date) + InsuranceHeader_Incremental.Files.BuildDate_Current_DS;
		SHARED buildDate_LF := InsuranceHeader_Incremental.Filenames.BuildDate_LF(ingestDate,wu);
		EXPORT op_date      := OUTPUT(ds_date,,buildDate_LF,compressed);
		EXPORT updateBuildDate := InsuranceHeader_Incremental.Superfiles.updateSF(buildDate_LF,InsuranceHeader_Incremental.Filenames.BuildDate_SF);
		
		EXPORT runxLink	 	:= IF(_Control.ThisEnvironment.Name = 'Prod',
													SEQUENTIAL(run_xIDLV2,
													op_base,
													updateIncBase,
													op_date,
													updateBuildDate,
													IF (update_orbitV2[1].retcode = 'Success', 
																fileservices.sendemail(
																		'Anantha.Venkatachalam@lexisnexis.com,' + InsuranceHeader.mod_email.emailList,
																		'Alpharetta InsuranceHeader xLink OrbitI Create Build:'+ingestDate+':SUCCESS',
																		'OrbitI Create build successful: ' + ingestDate),
																fileservices.sendemail(
																		'Anantha.Venkatachalam@lexisnexis.com,' + InsuranceHeader.mod_email.emailList,
																		'Alpharetta InsuranceHeader xLink OrbitI Create Build:'+ingestDate+':FAILED',
																		'OrbitI Create build failed. Reason: ' + update_orbitV2[1].retDesc)
															)
													 ),
									SEQUENTIAL(OUTPUT('Not a prod environment'))
									);
END; 
