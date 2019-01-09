import Versioncontrol, _Control;

export Spray_Input(string filedate) := module

export Attorney_file := DATASET([
 	{'_Control.IPAddress.bctlpedata10'	                    //SourceIP			 Remote Server's IP address									
 	,'/data/hds_180/bankruptcy_attorney_trustee/data/'+filedate            //SourceDirectory	 Absolute path of directory on Remote Server where files are located                
 	,'Attorneys_*.txt'                                    //directory_filter   Regular expression filter for files to be sprayed, default = '*'                          
 	,0                                                  //record_size	     record length of files to be sprayed(for fixed length files only)      
 	,'~thor_data400::in::bat::@version@::attorneys'       //Thor_filename_template	-- template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
 	,[{'~thor_data400::in::bat::attorneys'}]            //dSuperfilenames			-- dataset of superfiles to add the sprayed files to.
 	,'thor400_44'                                       //Thor Group name, ex. 'thor_data400' = dataland400, 'thor_dell400' = prod400(default)
	,''                                                 //FileDate				-- version of all of the sprayed files(overrides the next field, dateregex). Default = ''
 	,'[0-9]{8}'                                                 //date_regex				-- regular expression to get the date from the remote filenames.  Default = '[0-9]{8}'
	,'VARIABLE'                                         //file_type				-- Type of file format.  Possible types are 'FIXED', 'VARIABLE', OR 'XML'.  Default = 'FIXED'
 	}
	
 		                                                            
], VersionControl.Layout_Sprays.Info);


export  Trustee_file := DATASET([
 	{'_Control.IPAddress.bctlpedata10'	                    //SourceIP			 Remote Server's IP address									
 	,'/data/hds_180/bankruptcy_attorney_trustee/data/'+filedate            //SourceDirectory	 Absolute path of directory on Remote Server where files are located                
 	,'Trustees_*.txt'                                    //directory_filter   Regular expression filter for files to be sprayed, default = '*'                          
 	,0                                                  //record_size	     record length of files to be sprayed(for fixed length files only)      
 	,'~thor_data400::in::bat::@version@::trustees'       //Thor_filename_template	-- template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
 	,[{'~thor_data400::in::bat::trustees'}]            //dSuperfilenames			-- dataset of superfiles to add the sprayed files to.
 	,'thor400_44'                                       //Thor Group name, ex. 'thor_data400' = dataland400, 'thor_dell400' = prod400(default)
	,''                                                 //FileDate				-- version of all of the sprayed files(overrides the next field, dateregex). Default = ''
 	,'[0-9]{8}'                                                //date_regex				-- regular expression to get the date from the remote filenames.  Default = '[0-9]{8}'
	,'VARIABLE'                                         //file_type				-- Type of file format.  Possible types are 'FIXED', 'VARIABLE', OR 'XML'.  Default = 'FIXED'
 }
	
 		                                                            
], VersionControl.Layout_Sprays.Info);

end;

