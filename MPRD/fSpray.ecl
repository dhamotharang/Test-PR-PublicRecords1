import lib_fileservices,_Control,lib_stringlib,Versioncontrol;
string landing_zone := _Control.IPAddress.bctlpedata10;
export fSpray(string version, boolean pUseProd = false)	:=	DATASET([
 	{landing_zone	                    //SourceIP			 Remote Server's IP address									
 	,'/data/enclarity/MPRD/infiles/'+version
	//+'/'            //SourceDirectory	 Absolute path of directory on Remote Server where files are located                
 	,'t_basc_name.txt'                                    //directory_filter   Regular expression filter for files to be sprayed, default = '*'                          
 	,0                                                  //record_size	     record length of files to be sprayed(for fixed length files only)      
 	,_Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Name +'::individual'+'::@version@'       //Thor_filename_template	-- template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
 	,[{_Dataset(pUseProd).thor_cluster_Files+'in::' + _Dataset().Name+'::individual'}]            //dSuperfilenames			-- dataset of superfiles to add the sprayed files to.
 	,'thor400_44'                                       //Thor Group name, ex. 'thor_data400' = dataland400, 'thor_dell400' = prod400(default)
	,version                                                 //FileDate				-- version of all of the sprayed files(overrides the next field, dateregex). Default = ''
 	,'[0-9]{8}'                                                //date_regex				-- regular expression to get the date from the remote filenames.  Default = '[0-9]{8}'
	,'VARIABLE'                                         //file_type				-- Type of file format.  Possible types are 'FIXED', 'VARIABLE', OR 'XML'.  Default = 'FIXED'
 	},
		
	{landing_zone	                    //SourceIP			 Remote Server's IP address									
 	,'/data/enclarity/MPRD/infiles/'+version
	//+'/'            //SourceDirectory	 Absolute path of directory on Remote Server where files are located                
 	,'taxonomy_full_lu.txt'                                    //directory_filter   Regular expression filter for files to be sprayed, default = '*'                          
 	,0                                                  //record_size	     record length of files to be sprayed(for fixed length files only)      
 	,_Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Name +'::taxonomy_full_lu'+ '::@version@'       //Thor_filename_template	-- template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
 	,[{_Dataset(pUseProd).thor_cluster_Files+'in::' + _Dataset().Name +'::taxonomy_full_lu'}]            //dSuperfilenames			-- dataset of superfiles to add the sprayed files to.
 	,'thor400_44'                                       //Thor Group name, ex. 'thor_data400' = dataland400, 'thor_dell400' = prod400(default)
	,version                                                 //FileDate				-- version of all of the sprayed files(overrides the next field, dateregex). Default = ''
 	,'[0-9]{8}'                                                //date_regex				-- regular expression to get the date from the remote filenames.  Default = '[0-9]{8}'
	,'VARIABLE'                                         //file_type				-- Type of file format.  Possible types are 'FIXED', 'VARIABLE', OR 'XML'.  Default = 'FIXED'
 	}
	
], VersionControl.Layout_Sprays.Info);

