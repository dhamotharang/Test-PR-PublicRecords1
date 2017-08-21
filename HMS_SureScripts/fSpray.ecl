import lib_fileservices,tools,_control,lib_stringlib,Versioncontrol;

export fSpray(string version, boolean pUseProd = false)	:=	DATASET([
 	{'bctlpedata10.risk.regn.net'	                    //SourceIP			 Remote Server's IP address									
 	,'/data/hds_180/SureScripts/build/'+version[..8]+'/'         //SourceDirectory	 Absolute path of directory on Remote Server where files are located                
 	,'*.txt'                                    			//directory_filter   Regular expression filter for files to be sprayed, default = '*'                          
 	,1418                                               //record_size	     record length of files to be sprayed(for fixed length files only)      
 	,_Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Name + '::' + version      //Thor_filename_template	-- template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
 	,[{_Dataset(pUseProd).thor_cluster_Files+'in::' + _Dataset().Name  }]            //dSuperfilenames			-- dataset of superfiles to add the sprayed files to.
 	,IF((tools._Constants.IsDataland),'thor400_dev01','thor400_44')    //Thor Group name, ex. 'thor_data400' = dataland400, 'thor_dell400' = prod400(default)
	,version                                          //FileDate				-- version of all of the sprayed files(overrides the next field, dateregex). Default = ''
 	,'[0-9]{8}'                                       //date_regex				-- regular expression to get the date from the remote filenames.  Default = '[0-9]{8}'
	,'FIXED'                                          //file_type				-- Type of file format.  Possible types are 'FIXED', 'VARIABLE', OR 'XML'.  Default = 'FIXED'
 	}	                                                            
], VersionControl.Layout_Sprays.Info);

