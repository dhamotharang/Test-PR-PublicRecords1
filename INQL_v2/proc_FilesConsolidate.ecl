import data_services,std,wk_ut,inql_V2; 

EXPORT proc_FilesConsolidate(boolean isfcra=false):= module 

sfcra := if(isfcra,'fcra','nonfcra');

input_files_ecl(string source):= function

suffix       := trim(map(source='accurint' 	=> '::accurint_acclogs',
							           source='custom '  	=> '::custom_acclog',
							           source='riskwise'  => '::riskwise_acclog',
							           source='sba'  			=> '::sba_acclogs',
							           source='idm'  			=> '::idm_bls_acclog',
							           source='batch'  		=> '::batch_acclog',
						       	     source='batchr3'  	=> '_prod::batchr3',
						            'Filename'));
						
transaction_id   := map(source='batch'    => 'orig_job_id',
							          source='sba'  	   => 'transaction_id',
				                'orig_transaction_id');
										
separators       := map(source='batch'    => '\'|\'',
							          source='idm'      => '\',\'',
				                '\'~~\'');
																					
layoutin 			   :=  IF(source='batch', 'INQL_V2.layouts.r'+ source +'_in,csv(SEPARATOR('+separators+'),quote(\'"\'),TERMINATOR([\'\\n\', \'\\r\\n\']), heading(2)),opt)\n',
                     IF(source='idm','INQL_V2.layouts.r'+ source +'_in,csv(SEPARATOR('+separators+'),TERMINATOR([\'\\n\', \'\\r\\n\']), heading(2)),opt)\n',
									   IF(source='batchr3','INQL_V2.layouts.r'+ source +'_in,thor,opt)\n',
										 'INQL_V2.layouts.r'+ source +'_in,csv(separator('+separators+'),TERMINATOR([\'\\n\', \'\\r\\n\'])), opt)\n')));
										 

indexedFileName     :=NOTHOR(STD.File.GetSuperFileSubName('~thor_data::key::inql::'+sfcra+'::consolidate::'+source, 1));																	
lastConsolidateFile :=(unsigned8)std.str.splitwords(indexedFileName,'::')[5][1..8];
																														
																														
name                := 'thor100_21::in::*'+trim(suffix);	                                                                            	
rawFilesinThor      := NOTHOR(STD.File.LogicalFileList(name,true,false,false,'10.173.50.45'));

rawFilesToConsolidate := rawFilesinThor((unsigned8)(std.str.splitwords(name,'::')[3][1..8])>lastConsolidateFile);

eclRecord:= record
   string name;
   string ecltxt:='';
end;
tr_rawFilesToConsolidate := project(rawFilesToConsolidate,transform(eclRecord,self:=left;));
																	 
eclRecord CreateECL(eclRecord L, eclRecord R) := TRANSFORM
    SELF.ecltxt := L.ecltxt + 'dataset(\'~'+R.name+'\','+ layoutin +' +';
		SELF := R;
END;
iECL := ITERATE(tr_rawFilesToConsolidate,CreateECL(LEFT,RIGHT));
rawFilesToConsolidate_ECL  := 'rawFilesToConsolidate'+source+':='+ STD.STr.RemoveSuffix(iECL[COUNT(iECL)].ecltxt,'+') + ';\n';
lastRawFileToConsolidate   := Max(tr_rawFilesToConsolidate,(unsigned8)std.str.splitwords(name,'::')[3][1..8]);


PULL_INDEX_ECL        := 'fileConsolidated'+source+':= PULL(INDEX({INQL_v2.layouts.rConsolidate.filedate,INQL_v2.layouts.rConsolidate.orig_transaction_id},{INQL_v2.layouts.rConsolidate},' +
													'\'~thor_data::key::inql::'+sfcra+'::consolidate::'+ source+'\',opt));\n';
													
APPEND_FIELDS_ECL   	:= 'INQL_V2.Mac_Append_Fields(rawFilesToConsolidate'+source+',filestoConsolidate'+source+','+separators+',,INQL_v2.layouts.rConsolidate,'+transaction_id+');\n';

ECL := rawFilesToConsolidate_ECL + 
       APPEND_FIELDS_ECL + 
			 PULL_INDEX_ECL +
			 'DS'+source+':= filestoConsolidate'+source+' + fileConsolidated'+source+';\n' +
			 '//@*@'+ lastRawFileToConsolidate;
			 
return  ECL;
end;		 
			 
accurintFilesECL := input_files_ecl('accurint');
accurintFilesVersion := std.str.splitwords(accurintFilesECL,'//@*@')[2];
customFilesECL := input_files_ecl('custom');
customFilesVersion := std.str.splitwords(customFilesECL,'//@*@')[2];
riskwiseFilesECL := input_files_ecl('riskwise');
riskwiseFilesVersion := std.str.splitwords(riskwiseFilesECL,'//@*@')[2];
sbaFilesECL := input_files_ecl('sba');
sbaFilesVersion := std.str.splitwords(sbaFilesECL,'//@*@')[2];
idmFilesECL := input_files_ecl('idm');
idmFilesVersion := std.str.splitwords(idmFilesECL,'//@*@')[2];
batchFilesECL := input_files_ecl('batch');
batchFilesVersion := std.str.splitwords(batchFilesECL,'//@*@')[2];
batchr3FilesECL := input_files_ecl('batchr3');
batchr3FilesVersion := std.str.splitwords(batchr3FilesECL,'//@*@')[2];

SOURCES_FILES_ECL:= IF(accurintFilesVersion<>'0', accurintFilesECL, '')+'\n' +
                    IF(customFilesVersion<>'0', customFilesECL,     '')+'\n' +
                    IF(riskwiseFilesVersion<>'0', riskwiseFilesECL, '')+'\n' +
								   	IF(sbaFilesVersion<>'0', sbaFilesECL,           '')+'\n' +
								    IF(idmFilesVersion<>'0', idmFilesECL,           '')+'\n' +
					        	IF(batchFilesVersion<>'0', batchFilesECL,       '')+'\n' +
					        	IF(batchr3FilesVersion<>'0', batchr3FilesECL,   '')+'\n' 
										;

BUILD_CONS_ECL(string source, string version)   	:= 'BUILD(DS'+source+',{DS'+source+'.filedate,DS'+source+'.orig_transaction_id},{DS'+source+'},\'~thor_data::key::inql::'+sfcra+'::'+version+'::consolidate::' + source + '\',OVERWRITE);\n' +
                                                     'STD.File.PromoteSuperFileList([\'~thor_data::key::inql::'+sfcra+'::consolidate::'+ source+'\'],\'~thor_data::key::inql::'+sfcra+'::'+version+'::consolidate::' + source + '\',TRUE);\n' ;				 
												
BUILD_CONS_VERSION_ECL := 'do:=SEQUENTIAL('+ IF(accurintFilesVersion<>'0',BUILD_CONS_ECL('accurint',accurintFilesVersion), 'output(\'NO NEW FILES FOR ACCURINT\');')+'\n'+
                                             IF(customFilesVersion<>'0'  ,BUILD_CONS_ECL('custom'  ,customFilesVersion  ), 'output(\'NO NEW FILES FOR CUSTOM\');')+'\n'+
																						 IF(riskwiseFilesVersion<>'0',BUILD_CONS_ECL('riskwise',riskwiseFilesVersion), 'output(\'NO NEW FILES FOR RISKWISE\');')+'\n'+
																						 IF(sbaFilesVersion<>'0'     ,BUILD_CONS_ECL('sba'     ,sbaFilesVersion     ), 'output(\'NO NEW FILES FOR SBA\');')+'\n'+
 																						 IF(idmFilesVersion<>'0'     ,BUILD_CONS_ECL('idm'     ,idmFilesVersion     ), 'output(\'NO NEW FILES FOR IDM\');')+'\n'+
 																						 IF(batchFilesVersion<>'0'   ,BUILD_CONS_ECL('batch'   ,batchFilesVersion   ), 'output(\'NO NEW FILES FOR BATCH\');')+'\n'+
 																						 IF(batchr3FilesVersion<>'0' ,BUILD_CONS_ECL('batchr3' ,batchr3FilesVersion ), 'output(\'NO NEW FILES FOR BATCHR3\');')+'\n'+
    																				 ');\n';

export ECL:= SOURCES_FILES_ECL + BUILD_CONS_VERSION_ECL;

end;