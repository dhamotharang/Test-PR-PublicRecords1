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
 	,'t_basc_facility.txt'                                    //directory_filter   Regular expression filter for files to be sprayed, default = '*'                          
 	,0                                                  //record_size	     record length of files to be sprayed(for fixed length files only)      
 	,_Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Name +'::facility'+ '::@version@'       //Thor_filename_template	-- template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
 	,[{_Dataset(pUseProd).thor_cluster_Files+'in::' + _Dataset().Name +'::facility'}]            //dSuperfilenames			-- dataset of superfiles to add the sprayed files to.
 	,'thor400_44'                                       //Thor Group name, ex. 'thor_data400' = dataland400, 'thor_dell400' = prod400(default)
	,version                                                 //FileDate				-- version of all of the sprayed files(overrides the next field, dateregex). Default = ''
 	,'[0-9]{8}'                                                //date_regex				-- regular expression to get the date from the remote filenames.  Default = '[0-9]{8}'
	,'VARIABLE'                                         //file_type				-- Type of file format.  Possible types are 'FIXED', 'VARIABLE', OR 'XML'.  Default = 'FIXED'
 	},

  {landing_zone	                    //SourceIP			 Remote Server's IP address									
  ,'/data/enclarity/MPRD/infiles/'+version
  //+'/'            //SourceDirectory	 Absolute path of directory on Remote Server where files are located                
  ,'t_basc_cp.txt'                                    //directory_filter   Regular expression filter for files to be sprayed, default = '*'                          
  ,0                                                  //record_size	     record length of files to be sprayed(for fixed length files only)      
  ,_Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Name +'::basc_cp'+ '::@version@'       //Thor_filename_template	-- template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
  ,[{_Dataset(pUseProd).thor_cluster_Files+'in::' + _Dataset().Name +'::basc_cp'}]            //dSuperfilenames			-- dataset of superfiles to add the sprayed files to.
  ,'thor400_44'                                       //Thor Group name, ex. 'thor_data400' = dataland400, 'thor_dell400' = prod400(default)
  ,version                                                 //FileDate				-- version of all of the sprayed files(overrides the next field, dateregex). Default = ''
  ,'[0-9]{8}'                                                //date_regex				-- regular expression to get the date from the remote filenames.  Default = '[0-9]{8}'
  ,'VARIABLE'                                         //file_type				-- Type of file format.  Possible types are 'FIXED', 'VARIABLE', OR 'XML'.  Default = 'FIXED'
  },
   
	{landing_zone	                    //SourceIP			 Remote Server's IP address									
 	,'/data/enclarity/MPRD/infiles/'+version
	//+'/'            //SourceDirectory	 Absolute path of directory on Remote Server where files are located                
 	,'t_basc_claim.txt'                                    //directory_filter   Regular expression filter for files to be sprayed, default = '*'                          
 	,0                                                  //record_size	     record length of files to be sprayed(for fixed length files only)      
 	,_Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Name +'::basc_claims'+ '::@version@'       //Thor_filename_template	-- template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
 	,[{_Dataset(pUseProd).thor_cluster_Files+'in::' + _Dataset().Name +'::basc_claims'}]            //dSuperfilenames			-- dataset of superfiles to add the sprayed files to.
 	,'thor400_44'                                       //Thor Group name, ex. 'thor_data400' = dataland400, 'thor_dell400' = prod400(default)
	,version                                                 //FileDate				-- version of all of the sprayed files(overrides the next field, dateregex). Default = ''
 	,'[0-9]{8}'                                                //date_regex				-- regular expression to get the date from the remote filenames.  Default = '[0-9]{8}'
	,'VARIABLE'                                         //file_type				-- Type of file format.  Possible types are 'FIXED', 'VARIABLE', OR 'XML'.  Default = 'FIXED'
 	},
	
	{landing_zone	                    //SourceIP			 Remote Server's IP address									
 	,'/data/enclarity/MPRD/infiles/'+version
	//+'/'            //SourceDirectory	 Absolute path of directory on Remote Server where files are located                
 	,'t_npi_extension.txt'                                    //directory_filter   Regular expression filter for files to be sprayed, default = '*'                          
 	,0                                                  //record_size	     record length of files to be sprayed(for fixed length files only)      
 	,_Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Name +'::npi_extension'+ '::@version@'       //Thor_filename_template	-- template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
 	,[{_Dataset(pUseProd).thor_cluster_Files+'in::' + _Dataset().Name +'::npi_extension'}]            //dSuperfilenames			-- dataset of superfiles to add the sprayed files to.
 	,'thor400_44'                                       //Thor Group name, ex. 'thor_data400' = dataland400, 'thor_dell400' = prod400(default)
	,version                                                 //FileDate				-- version of all of the sprayed files(overrides the next field, dateregex). Default = ''
 	,'[0-9]{8}'                                                //date_regex				-- regular expression to get the date from the remote filenames.  Default = '[0-9]{8}'
	,'VARIABLE'                                         //file_type				-- Type of file format.  Possible types are 'FIXED', 'VARIABLE', OR 'XML'.  Default = 'FIXED'
 	},
	
	{landing_zone	                    //SourceIP			 Remote Server's IP address									
 	,'/data/enclarity/MPRD/infiles/'	+version
	//+'/'            //SourceDirectory	 Absolute path of directory on Remote Server where files are located                
 	,'t_npi_extension_facility.txt'                                    //directory_filter   Regular expression filter for files to be sprayed, default = '*'                          
 	,0                                                  //record_size	     record length of files to be sprayed(for fixed length files only)      
 	,_Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Name +'::npi_extension_facility'+ '::@version@'       //Thor_filename_template	-- template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
 	,[{_Dataset(pUseProd).thor_cluster_Files+'in::' + _Dataset().Name +'::npi_extension_facility'}]            //dSuperfilenames			-- dataset of superfiles to add the sprayed files to.
 	,'thor400_44'                                       //Thor Group name, ex. 'thor_data400' = dataland400, 'thor_dell400' = prod400(default)
	,version                                                 //FileDate				-- version of all of the sprayed files(overrides the next field, dateregex). Default = ''
 	,'[0-9]{8}'                                                //date_regex				-- regular expression to get the date from the remote filenames.  Default = '[0-9]{8}'
	,'VARIABLE'                                         //file_type				-- Type of file format.  Possible types are 'FIXED', 'VARIABLE', OR 'XML'.  Default = 'FIXED'
 	},

	{landing_zone	                    //SourceIP			 Remote Server's IP address									
 	,'/data/enclarity/MPRD/infiles/'	+version
	//+'/'            //SourceDirectory	 Absolute path of directory on Remote Server where files are located                
 	,'t_claims_addr_master.txt'                                    //directory_filter   Regular expression filter for files to be sprayed, default = '*'                          
 	,0                                                  //record_size	     record length of files to be sprayed(for fixed length files only)      
 	,_Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Name +'::claims_addr_master'+ '::@version@'       //Thor_filename_template	-- template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
 	,[{_Dataset(pUseProd).thor_cluster_Files+'in::' + _Dataset().Name +'::claims_addr_master'}]            //dSuperfilenames			-- dataset of superfiles to add the sprayed files to.
 	,'thor400_44'                                       //Thor Group name, ex. 'thor_data400' = dataland400, 'thor_dell400' = prod400(default)
	,version                                                 //FileDate				-- version of all of the sprayed files(overrides the next field, dateregex). Default = ''
 	,'[0-9]{8}'                                                //date_regex				-- regular expression to get the date from the remote filenames.  Default = '[0-9]{8}'
	,'VARIABLE'                                         //file_type				-- Type of file format.  Possible types are 'FIXED', 'VARIABLE', OR 'XML'.  Default = 'FIXED'
 	},
	
	{landing_zone	                    //SourceIP			 Remote Server's IP address									
 	,'/data/enclarity/MPRD/infiles/'+version
	//+'/'            //SourceDirectory	 Absolute path of directory on Remote Server where files are located                
 	,'t_claims_by_month.txt'                                    //directory_filter   Regular expression filter for files to be sprayed, default = '*'                          
 	,0                                                  //record_size	     record length of files to be sprayed(for fixed length files only)      
 	,_Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Name +'::claims_by_month'+ '::@version@'       //Thor_filename_template	-- template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
 	,[{_Dataset(pUseProd).thor_cluster_Files+'in::' + _Dataset().Name +'::claims_by_month'}]            //dSuperfilenames			-- dataset of superfiles to add the sprayed files to.
 	,'thor400_44'                                       //Thor Group name, ex. 'thor_data400' = dataland400, 'thor_dell400' = prod400(default)
	,version                                                 //FileDate				-- version of all of the sprayed files(overrides the next field, dateregex). Default = ''
 	,'[0-9]{8}'                                                //date_regex				-- regular expression to get the date from the remote filenames.  Default = '[0-9]{8}'
	,'VARIABLE'                                         //file_type				-- Type of file format.  Possible types are 'FIXED', 'VARIABLE', OR 'XML'.  Default = 'FIXED'
 	},

	{landing_zone	                    //SourceIP			 Remote Server's IP address									
 	,'/data/enclarity/MPRD/infiles/'+version
	//+'/'            //SourceDirectory	 Absolute path of directory on Remote Server where files are located                
 	,'t_npi_tin_xref.txt'                                    //directory_filter   Regular expression filter for files to be sprayed, default = '*'                          
 	,0                                                  //record_size	     record length of files to be sprayed(for fixed length files only)      
 	,_Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Name +'::npi_tin_xref'+ '::@version@'       //Thor_filename_template	-- template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
 	,[{_Dataset(pUseProd).thor_cluster_Files+'in::' + _Dataset().Name +'::npi_tin_xref'}]            //dSuperfilenames			-- dataset of superfiles to add the sprayed files to.
 	,'thor400_44'                                       //Thor Group name, ex. 'thor_data400' = dataland400, 'thor_dell400' = prod400(default)
	,version                                                 //FileDate				-- version of all of the sprayed files(overrides the next field, dateregex). Default = ''
 	,'[0-9]{8}'                                                //date_regex				-- regular expression to get the date from the remote filenames.  Default = '[0-9]{8}'
	,'VARIABLE'                                         //file_type				-- Type of file format.  Possible types are 'FIXED', 'VARIABLE', OR 'XML'.  Default = 'FIXED'
 	},
	
	{landing_zone	                    //SourceIP			 Remote Server's IP address									
 	,'/data/enclarity/MPRD/infiles/'+version
	//+'/'            //SourceDirectory	 Absolute path of directory on Remote Server where files are located                
 	,'t_taxonomy_equiv.txt'                                    //directory_filter   Regular expression filter for files to be sprayed, default = '*'                          
 	,0                                                  //record_size	     record length of files to be sprayed(for fixed length files only)      
 	,_Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Name +'::taxonomy_equiv'+ '::@version@'       //Thor_filename_template	-- template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
 	,[{_Dataset(pUseProd).thor_cluster_Files+'in::' + _Dataset().Name +'::taxonomy_equiv'}]            //dSuperfilenames			-- dataset of superfiles to add the sprayed files to.
 	,'thor400_44'                                       //Thor Group name, ex. 'thor_data400' = dataland400, 'thor_dell400' = prod400(default)
	,version                                                 //FileDate				-- version of all of the sprayed files(overrides the next field, dateregex). Default = ''
 	,'[0-9]{8}'                                                //date_regex				-- regular expression to get the date from the remote filenames.  Default = '[0-9]{8}'
	,'VARIABLE'                                         //file_type				-- Type of file format.  Possible types are 'FIXED', 'VARIABLE', OR 'XML'.  Default = 'FIXED'
 	},
	
	{landing_zone	                    //SourceIP			 Remote Server's IP address									
 	,'/data/enclarity/MPRD/infiles/'+version
	//+'/'            //SourceDirectory	 Absolute path of directory on Remote Server where files are located                
 	,'t_basc_deceased.txt'                                    //directory_filter   Regular expression filter for files to be sprayed, default = '*'                          
 	,0                                                  //record_size	     record length of files to be sprayed(for fixed length files only)      
 	,_Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Name +'::basc_deceased'+ '::@version@'       //Thor_filename_template	-- template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
 	,[{_Dataset(pUseProd).thor_cluster_Files+'in::' + _Dataset().Name +'::basc_deceased'}]            //dSuperfilenames			-- dataset of superfiles to add the sprayed files to.
 	,'thor400_44'                                       //Thor Group name, ex. 'thor_data400' = dataland400, 'thor_dell400' = prod400(default)
	,version                                                 //FileDate				-- version of all of the sprayed files(overrides the next field, dateregex). Default = ''
 	,'[0-9]{8}'                                                //date_regex				-- regular expression to get the date from the remote filenames.  Default = '[0-9]{8}'
	,'VARIABLE'                                         //file_type				-- Type of file format.  Possible types are 'FIXED', 'VARIABLE', OR 'XML'.  Default = 'FIXED'
 	},
	
	{landing_zone	                    //SourceIP			 Remote Server's IP address									
 	,'/data/enclarity/MPRD/infiles/'+version
	//+'/'            //SourceDirectory	 Absolute path of directory on Remote Server where files are located                
 	,'t_basc_addr.txt'                                    //directory_filter   Regular expression filter for files to be sprayed, default = '*'                          
 	,0                                                  //record_size	     record length of files to be sprayed(for fixed length files only)      
 	,_Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Name +'::basc_addr'+ '::@version@'       //Thor_filename_template	-- template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
 	,[{_Dataset(pUseProd).thor_cluster_Files+'in::' + _Dataset().Name +'::basc_addr'}]            //dSuperfilenames			-- dataset of superfiles to add the sprayed files to.
 	,'thor400_44'                                       //Thor Group name, ex. 'thor_data400' = dataland400, 'thor_dell400' = prod400(default)
	,version                                                 //FileDate				-- version of all of the sprayed files(overrides the next field, dateregex). Default = ''
 	,'[0-9]{8}'                                                //date_regex				-- regular expression to get the date from the remote filenames.  Default = '[0-9]{8}'
	,'VARIABLE'                                         //file_type				-- Type of file format.  Possible types are 'FIXED', 'VARIABLE', OR 'XML'.  Default = 'FIXED'
 	},	
	
	{landing_zone	                    //SourceIP			 Remote Server's IP address									
 	,'/data/enclarity/MPRD/infiles/'+version
	//+'/'            //SourceDirectory	 Absolute path of directory on Remote Server where files are located                
 	,'t_client_data.txt'                                    //directory_filter   Regular expression filter for files to be sprayed, default = '*'                          
 	,0                                                  //record_size	     record length of files to be sprayed(for fixed length files only)      
 	,_Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Name +'::client_data'+ '::@version@'       //Thor_filename_template	-- template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
 	,[{_Dataset(pUseProd).thor_cluster_Files+'in::' + _Dataset().Name +'::client_data'}]            //dSuperfilenames			-- dataset of superfiles to add the sprayed files to.
 	,'thor400_44'                                       //Thor Group name, ex. 'thor_data400' = dataland400, 'thor_dell400' = prod400(default)
	,version                                                 //FileDate				-- version of all of the sprayed files(overrides the next field, dateregex). Default = ''
 	,'[0-9]{8}'                                                //date_regex				-- regular expression to get the date from the remote filenames.  Default = '[0-9]{8}'
	,'VARIABLE'                                         //file_type				-- Type of file format.  Possible types are 'FIXED', 'VARIABLE', OR 'XML'.  Default = 'FIXED'
 	},	
	
	{landing_zone	                    //SourceIP			 Remote Server's IP address									
 	,'/data/enclarity/MPRD/infiles/'+version
	//+'/'            //SourceDirectory	 Absolute path of directory on Remote Server where files are located                
 	,'t_office_attributes.txt'                                    //directory_filter   Regular expression filter for files to be sprayed, default = '*'                          
 	,0                                                  //record_size	     record length of files to be sprayed(for fixed length files only)      
 	,_Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Name +'::office_attributes'+ '::@version@'       //Thor_filename_template	-- template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
 	,[{_Dataset(pUseProd).thor_cluster_Files+'in::' + _Dataset().Name +'::office_attributes'}]            //dSuperfilenames			-- dataset of superfiles to add the sprayed files to.
 	,'thor400_44'                                       //Thor Group name, ex. 'thor_data400' = dataland400, 'thor_dell400' = prod400(default)
	,version                                                 //FileDate				-- version of all of the sprayed files(overrides the next field, dateregex). Default = ''
 	,'[0-9]{8}'                                                //date_regex				-- regular expression to get the date from the remote filenames.  Default = '[0-9]{8}'
	,'VARIABLE'                                         //file_type				-- Type of file format.  Possible types are 'FIXED', 'VARIABLE', OR 'XML'.  Default = 'FIXED'
 	},	
	
	{landing_zone	                    //SourceIP			 Remote Server's IP address									
 	,'/data/enclarity/MPRD/infiles/'+version
	//+'/'            //SourceDirectory	 Absolute path of directory on Remote Server where files are located                
 	,'t_office_attributes_facility.txt'                                    //directory_filter   Regular expression filter for files to be sprayed, default = '*'                          
 	,0                                                  //record_size	     record length of files to be sprayed(for fixed length files only)      
 	,_Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Name +'::office_attributes_facility'+ '::@version@'       //Thor_filename_template	-- template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
 	,[{_Dataset(pUseProd).thor_cluster_Files+'in::' + _Dataset().Name +'::office_attributes_facility'}]            //dSuperfilenames			-- dataset of superfiles to add the sprayed files to.
 	,'thor400_44'                                       //Thor Group name, ex. 'thor_data400' = dataland400, 'thor_dell400' = prod400(default)
	,version                                                 //FileDate				-- version of all of the sprayed files(overrides the next field, dateregex). Default = ''
 	,'[0-9]{8}'                                                //date_regex				-- regular expression to get the date from the remote filenames.  Default = '[0-9]{8}'
	,'VARIABLE'                                         //file_type				-- Type of file format.  Possible types are 'FIXED', 'VARIABLE', OR 'XML'.  Default = 'FIXED'
 	},	

	{landing_zone	                    //SourceIP			 Remote Server's IP address									
 	,'/data/enclarity/MPRD/infiles/'+version
	//+'/'            //SourceDirectory	 Absolute path of directory on Remote Server where files are located                
 	,'t_std_terms_lu.txt'                                    //directory_filter   Regular expression filter for files to be sprayed, default = '*'                          
 	,0                                                  //record_size	     record length of files to be sprayed(for fixed length files only)      
 	,_Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Name +'::std_terms_lu'+ '::@version@'       //Thor_filename_template	-- template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
 	,[{_Dataset(pUseProd).thor_cluster_Files+'in::' + _Dataset().Name +'::std_terms_lu'}]            //dSuperfilenames			-- dataset of superfiles to add the sprayed files to.
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
 	},	

	{landing_zone	                    //SourceIP			 Remote Server's IP address									
 	,'/data/enclarity/MPRD/infiles/'+version
	//+'/'            //SourceDirectory	 Absolute path of directory on Remote Server where files are located                
 	,'t_dir_confidence_2010_lu.txt'                                    //directory_filter   Regular expression filter for files to be sprayed, default = '*'                          
 	,0                                                  //record_size	     record length of files to be sprayed(for fixed length files only)      
 	,_Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Name +'::dir_confidence_2010_lu '+ '::@version@'       //Thor_filename_template	-- template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
 	,[{_Dataset(pUseProd).thor_cluster_Files+'in::' + _Dataset().Name +'::dir_confidence_2010_lu '}]            //dSuperfilenames			-- dataset of superfiles to add the sprayed files to.
 	,'thor400_44'                                       //Thor Group name, ex. 'thor_data400' = dataland400, 'thor_dell400' = prod400(default)
	,version                                                 //FileDate				-- version of all of the sprayed files(overrides the next field, dateregex). Default = ''
 	,'[0-9]{8}'                                                //date_regex				-- regular expression to get the date from the remote filenames.  Default = '[0-9]{8}'
	,'VARIABLE'                                         //file_type				-- Type of file format.  Possible types are 'FIXED', 'VARIABLE', OR 'XML'.  Default = 'FIXED'
 	},	
	
	{landing_zone	                    //SourceIP			 Remote Server's IP address									
 	,'/data/enclarity/MPRD/infiles/'+version
	//+'/'            //SourceDirectory	 Absolute path of directory on Remote Server where files are located                
 	,'t_specialty_lu.txt'                                    //directory_filter   Regular expression filter for files to be sprayed, default = '*'                          
 	,0                                                  //record_size	     record length of files to be sprayed(for fixed length files only)      
 	,_Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Name +'::specialty_lu'+ '::@version@'       //Thor_filename_template	-- template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
 	,[{_Dataset(pUseProd).thor_cluster_Files+'in::' + _Dataset().Name +'::specialty_lu'}]            //dSuperfilenames			-- dataset of superfiles to add the sprayed files to.
 	,'thor400_44'                                       //Thor Group name, ex. 'thor_data400' = dataland400, 'thor_dell400' = prod400(default)
	,version                                                 //FileDate				-- version of all of the sprayed files(overrides the next field, dateregex). Default = ''
 	,'[0-9]{8}'                                                //date_regex				-- regular expression to get the date from the remote filenames.  Default = '[0-9]{8}'
	,'VARIABLE'                                         //file_type				-- Type of file format.  Possible types are 'FIXED', 'VARIABLE', OR 'XML'.  Default = 'FIXED'
 	},
	
  {landing_zone	                    //SourceIP			 Remote Server's IP address									
 	,'/data/enclarity/MPRD/infiles/'+version
	//+'/'            //SourceDirectory	 Absolute path of directory on Remote Server where files are located                
 	,'t_group_lu.txt'                                    //directory_filter   Regular expression filter for files to be sprayed, default = '*'                          
 	,0                                                  //record_size	     record length of files to be sprayed(for fixed length files only)      
 	,_Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Name +'::group_lu'+ '::@version@'       //Thor_filename_template	-- template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
 	,[{_Dataset(pUseProd).thor_cluster_Files+'in::' + _Dataset().Name +'::group_lu'}]            //dSuperfilenames			-- dataset of superfiles to add the sprayed files to.
 	,'thor400_44'                                       //Thor Group name, ex. 'thor_data400' = dataland400, 'thor_dell400' = prod400(default)
	,version                                                 //FileDate				-- version of all of the sprayed files(overrides the next field, dateregex). Default = ''
 	,'[0-9]{8}'                                                //date_regex				-- regular expression to get the date from the remote filenames.  Default = '[0-9]{8}'
	,'VARIABLE'                                         //file_type				-- Type of file format.  Possible types are 'FIXED', 'VARIABLE', OR 'XML'.  Default = 'FIXED'
 	},
	
	{landing_zone	                    //SourceIP			 Remote Server's IP address									
 	,'/data/enclarity/MPRD/infiles/'+version
	//+'/'            //SourceDirectory	 Absolute path of directory on Remote Server where files are located                
 	,'t_hospital_lu.txt'                                    //directory_filter   Regular expression filter for files to be sprayed, default = '*'                          
 	,0                                                  //record_size	     record length of files to be sprayed(for fixed length files only)      
 	,_Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Name +'::hospital_lu'+ '::@version@'       //Thor_filename_template	-- template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
 	,[{_Dataset(pUseProd).thor_cluster_Files+'in::' + _Dataset().Name +'::hospital_lu'}]            //dSuperfilenames			-- dataset of superfiles to add the sprayed files to.
 	,'thor400_44'                                       //Thor Group name, ex. 'thor_data400' = dataland400, 'thor_dell400' = prod400(default)
	,version                                                 //FileDate				-- version of all of the sprayed files(overrides the next field, dateregex). Default = ''
 	,'[0-9]{8}'                                                //date_regex				-- regular expression to get the date from the remote filenames.  Default = '[0-9]{8}'
	,'VARIABLE'                                         //file_type				-- Type of file format.  Possible types are 'FIXED', 'VARIABLE', OR 'XML'.  Default = 'FIXED'
 	},	
	
	{landing_zone	                    //SourceIP			 Remote Server's IP address									
 	,'/data/enclarity/MPRD/infiles/'+version
	//+'/'            //SourceDirectory	 Absolute path of directory on Remote Server where files are located                
 	,'t_dea_xref.txt'                                    //directory_filter   Regular expression filter for files to be sprayed, default = '*'                          
 	,0                                                  //record_size	     record length of files to be sprayed(for fixed length files only)      
 	,_Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Name +'::dea_xref'+ '::@version@'       //Thor_filename_template	-- template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
 	,[{_Dataset(pUseProd).thor_cluster_Files+'in::' + _Dataset().Name +'::dea_xref'}]            //dSuperfilenames			-- dataset of superfiles to add the sprayed files to.
 	,'thor400_44'                                       //Thor Group name, ex. 'thor_data400' = dataland400, 'thor_dell400' = prod400(default)
	,version                                                 //FileDate				-- version of all of the sprayed files(overrides the next field, dateregex). Default = ''
 	,'[0-9]{8}'                                                //date_regex				-- regular expression to get the date from the remote filenames.  Default = '[0-9]{8}'
	,'VARIABLE'                                         //file_type				-- Type of file format.  Possible types are 'FIXED', 'VARIABLE', OR 'XML'.  Default = 'FIXED'
 	},	
	
  {landing_zone	                    //SourceIP			 Remote Server's IP address									
 	,'/data/enclarity/MPRD/infiles/'+version
	//+'/'            //SourceDirectory	 Absolute path of directory on Remote Server where files are located                
 	,'t_lic_xref.txt'                                    //directory_filter   Regular expression filter for files to be sprayed, default = '*'                          
 	,0                                                  //record_size	     record length of files to be sprayed(for fixed length files only)      
 	,_Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Name +'::lic_xref'+ '::@version@'       //Thor_filename_template	-- template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
 	,[{_Dataset(pUseProd).thor_cluster_Files+'in::' + _Dataset().Name +'::lic_xref'}]            //dSuperfilenames			-- dataset of superfiles to add the sprayed files to.
 	,'thor400_44'                                       //Thor Group name, ex. 'thor_data400' = dataland400, 'thor_dell400' = prod400(default)
	,version                                                 //FileDate				-- version of all of the sprayed files(overrides the next field, dateregex). Default = ''
 	,'[0-9]{8}'                                                //date_regex				-- regular expression to get the date from the remote filenames.  Default = '[0-9]{8}'
	,'VARIABLE'                                         //file_type				-- Type of file format.  Possible types are 'FIXED', 'VARIABLE', OR 'XML'.  Default = 'FIXED'
 	},	
	
	{landing_zone	                    //SourceIP			 Remote Server's IP address									
 	,'/data/enclarity/MPRD/infiles/'+version
	//+'/'            //SourceDirectory	 Absolute path of directory on Remote Server where files are located                
 	,'t_facility_name_xref.txt'                                    //directory_filter   Regular expression filter for files to be sprayed, default = '*'                          
 	,0                                                  //record_size	     record length of files to be sprayed(for fixed length files only)      
 	,_Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Name +'::facility_name_xref'+ '::@version@'       //Thor_filename_template	-- template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
 	,[{_Dataset(pUseProd).thor_cluster_Files+'in::' + _Dataset().Name +'::facility_name_xref'}]            //dSuperfilenames			-- dataset of superfiles to add the sprayed files to.
 	,'thor400_44'                                       //Thor Group name, ex. 'thor_data400' = dataland400, 'thor_dell400' = prod400(default)
	,version                                                 //FileDate				-- version of all of the sprayed files(overrides the next field, dateregex). Default = ''
 	,'[0-9]{8}'                                                //date_regex				-- regular expression to get the date from the remote filenames.  Default = '[0-9]{8}'
	,'VARIABLE'                                         //file_type				-- Type of file format.  Possible types are 'FIXED', 'VARIABLE', OR 'XML'.  Default = 'FIXED'
 	},	
	
	{landing_zone	                    //SourceIP			 Remote Server's IP address									
 	,'/data/enclarity/MPRD/infiles/'+version
	//+'/'            //SourceDirectory	 Absolute path of directory on Remote Server where files are located                
 	,'t_addr_name_xref.txt'                                    //directory_filter   Regular expression filter for files to be sprayed, default = '*'                          
 	,0                                                  //record_size	     record length of files to be sprayed(for fixed length files only)      
 	,_Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Name +'::addr_name_xref'+ '::@version@'       //Thor_filename_template	-- template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
 	,[{_Dataset(pUseProd).thor_cluster_Files+'in::' + _Dataset().Name +'::addr_name_xref'}]            //dSuperfilenames			-- dataset of superfiles to add the sprayed files to.
 	,'thor400_44'                                       //Thor Group name, ex. 'thor_data400' = dataland400, 'thor_dell400' = prod400(default)
	,version                                                 //FileDate				-- version of all of the sprayed files(overrides the next field, dateregex). Default = ''
 	,'[0-9]{8}'                                                //date_regex				-- regular expression to get the date from the remote filenames.  Default = '[0-9]{8}'
	,'VARIABLE'                                         //file_type				-- Type of file format.  Possible types are 'FIXED', 'VARIABLE', OR 'XML'.  Default = 'FIXED'
 	},	
	
	{landing_zone	                    //SourceIP			 Remote Server's IP address									
 	,'/data/enclarity/MPRD/infiles/'+version
	//+'/'            //SourceDirectory	 Absolute path of directory on Remote Server where files are located                
 	,'t_basc_facility_mme.txt'                                    //directory_filter   Regular expression filter for files to be sprayed, default = '*'                          
 	,0                                                  //record_size	     record length of files to be sprayed(for fixed length files only)      
 	,_Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Name +'::basc_facility_mme'+ '::@version@'       //Thor_filename_template	-- template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
 	,[{_Dataset(pUseProd).thor_cluster_Files+'in::' + _Dataset().Name +'::basc_facility_mme'}]            //dSuperfilenames			-- dataset of superfiles to add the sprayed files to.
 	,'thor400_44'                                       //Thor Group name, ex. 'thor_data400' = dataland400, 'thor_dell400' = prod400(default)
	,version                                                 //FileDate				-- version of all of the sprayed files(overrides the next field, dateregex). Default = ''
 	,'[0-9]{8}'                                                //date_regex				-- regular expression to get the date from the remote filenames.  Default = '[0-9]{8}'
	,'VARIABLE'                                         //file_type				-- Type of file format.  Possible types are 'FIXED', 'VARIABLE', OR 'XML'.  Default = 'FIXED'
 	},	
	
	{landing_zone	                    //SourceIP			 Remote Server's IP address									
 	,'/data/enclarity/MPRD/infiles/'+version
	//+'/'            //SourceDirectory	 Absolute path of directory on Remote Server where files are located                
 	,'t_lic_filedate.txt'                                    //directory_filter   Regular expression filter for files to be sprayed, default = '*'                          
 	,0                                                  //record_size	     record length of files to be sprayed(for fixed length files only)      
 	,_Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Name +'::lic_filedate'+ '::@version@'       //Thor_filename_template	-- template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
 	,[{_Dataset(pUseProd).thor_cluster_Files+'in::' + _Dataset().Name +'::lic_filedate'}]            //dSuperfilenames			-- dataset of superfiles to add the sprayed files to.
 	,'thor400_44'                                       //Thor Group name, ex. 'thor_data400' = dataland400, 'thor_dell400' = prod400(default)
	,version                                                 //FileDate				-- version of all of the sprayed files(overrides the next field, dateregex). Default = ''
 	,'[0-9]{8}'                                                //date_regex				-- regular expression to get the date from the remote filenames.  Default = '[0-9]{8}'
	,'VARIABLE'                                         //file_type				-- Type of file format.  Possible types are 'FIXED', 'VARIABLE', OR 'XML'.  Default = 'FIXED'
 	},	
	
	{landing_zone	                    //SourceIP			 Remote Server's IP address									
 	,'/data/enclarity/MPRD/infiles/'+version
	//+'/'            //SourceDirectory	 Absolute path of directory on Remote Server where files are located                
 	,'t_nanpa.txt'                                    //directory_filter   Regular expression filter for files to be sprayed, default = '*'                          
 	,0                                                  //record_size	     record length of files to be sprayed(for fixed length files only)      
 	,_Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Name +'::nanpa'+ '::@version@'       //Thor_filename_template	-- template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
 	,[{_Dataset(pUseProd).thor_cluster_Files+'in::' + _Dataset().Name +'::nanpa'}]            //dSuperfilenames			-- dataset of superfiles to add the sprayed files to.
 	,'thor400_44'                                       //Thor Group name, ex. 'thor_data400' = dataland400, 'thor_dell400' = prod400(default)
	,version                                                 //FileDate				-- version of all of the sprayed files(overrides the next field, dateregex). Default = ''
 	,'[0-9]{8}'                                                //date_regex				-- regular expression to get the date from the remote filenames.  Default = '[0-9]{8}'
	,'VARIABLE'                                         //file_type				-- Type of file format.  Possible types are 'FIXED', 'VARIABLE', OR 'XML'.  Default = 'FIXED'
 	},	
	
	{landing_zone	                    //SourceIP			 Remote Server's IP address									
 	,'/data/enclarity/MPRD/infiles/'+version
	//+'/'            //SourceDirectory	 Absolute path of directory on Remote Server where files are located                
 	,'t_best_hospital.txt'                                    //directory_filter   Regular expression filter for files to be sprayed, default = '*'                          
 	,0                                                  //record_size	     record length of files to be sprayed(for fixed length files only)      
 	,_Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Name +'::best_hospital'+ '::@version@'       //Thor_filename_template	-- template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
 	,[{_Dataset(pUseProd).thor_cluster_Files+'in::' + _Dataset().Name +'::best_hospital'}]            //dSuperfilenames			-- dataset of superfiles to add the sprayed files to.
 	,'thor400_44'                                       //Thor Group name, ex. 'thor_data400' = dataland400, 'thor_dell400' = prod400(default)
	,version                                                 //FileDate				-- version of all of the sprayed files(overrides the next field, dateregex). Default = ''
 	,'[0-9]{8}'                                                //date_regex				-- regular expression to get the date from the remote filenames.  Default = '[0-9]{8}'
	,'VARIABLE'                                         //file_type				-- Type of file format.  Possible types are 'FIXED', 'VARIABLE', OR 'XML'.  Default = 'FIXED'
 	},	
	
	{landing_zone	                    //SourceIP			 Remote Server's IP address									
 	,'/data/enclarity/MPRD/infiles/'+version
	//+'/'            //SourceDirectory	 Absolute path of directory on Remote Server where files are located                
 	,'t_last_name_stats.txt'                                    //directory_filter   Regular expression filter for files to be sprayed, default = '*'                          
 	,0                                                  //record_size	     record length of files to be sprayed(for fixed length files only)      
 	,_Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Name +'::last_name_stats'+ '::@version@'       //Thor_filename_template	-- template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
 	,[{_Dataset(pUseProd).thor_cluster_Files+'in::' + _Dataset().Name +'::last_name_stats'}]            //dSuperfilenames			-- dataset of superfiles to add the sprayed files to.
 	,'thor400_44'                                       //Thor Group name, ex. 'thor_data400' = dataland400, 'thor_dell400' = prod400(default)
	,version                                                 //FileDate				-- version of all of the sprayed files(overrides the next field, dateregex). Default = ''
 	,'[0-9]{8}'                                                //date_regex				-- regular expression to get the date from the remote filenames.  Default = '[0-9]{8}'
	,'VARIABLE'                                         //file_type				-- Type of file format.  Possible types are 'FIXED', 'VARIABLE', OR 'XML'.  Default = 'FIXED'
 	},	
	
	{landing_zone	                    //SourceIP			 Remote Server's IP address									
 	,'/data/enclarity/MPRD/infiles/'+version
	//+'/'            //SourceDirectory	 Absolute path of directory on Remote Server where files are located                
 	,'t_source_confidence_lu.txt'                                    //directory_filter   Regular expression filter for files to be sprayed, default = '*'                          
 	,0                                                  //record_size	     record length of files to be sprayed(for fixed length files only)      
 	,_Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Name +'::source_confidence_lu'+ '::@version@'       //Thor_filename_template	-- template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
 	,[{_Dataset(pUseProd).thor_cluster_Files+'in::' + _Dataset().Name +'::source_confidence_lu'}]            //dSuperfilenames			-- dataset of superfiles to add the sprayed files to.
 	,'thor400_44'                                       //Thor Group name, ex. 'thor_data400' = dataland400, 'thor_dell400' = prod400(default)
	,version                                                 //FileDate				-- version of all of the sprayed files(overrides the next field, dateregex). Default = ''
 	,'[0-9]{8}'                                                //date_regex				-- regular expression to get the date from the remote filenames.  Default = '[0-9]{8}'
	,'VARIABLE'                                         //file_type				-- Type of file format.  Possible types are 'FIXED', 'VARIABLE', OR 'XML'.  Default = 'FIXED'
 	},	
	
	{landing_zone	                    //SourceIP			 Remote Server's IP address									
 	,'/data/enclarity/MPRD/infiles/'+version
	//+'/'            //SourceDirectory	 Absolute path of directory on Remote Server where files are located                
 	,'t_ignore_terms_lu.txt'                                    //directory_filter   Regular expression filter for files to be sprayed, default = '*'                          
 	,0                                                  //record_size	     record length of files to be sprayed(for fixed length files only)      
 	,_Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Name +'::ignore_terms_lu'+ '::@version@'       //Thor_filename_template	-- template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
 	,[{_Dataset(pUseProd).thor_cluster_Files+'in::' + _Dataset().Name +'::ignore_terms_lu'}]            //dSuperfilenames			-- dataset of superfiles to add the sprayed files to.
 	,'thor400_44'                                       //Thor Group name, ex. 'thor_data400' = dataland400, 'thor_dell400' = prod400(default)
	,version                                                 //FileDate				-- version of all of the sprayed files(overrides the next field, dateregex). Default = ''
 	,'[0-9]{8}'                                                //date_regex				-- regular expression to get the date from the remote filenames.  Default = '[0-9]{8}'
	,'VARIABLE'                                         //file_type				-- Type of file format.  Possible types are 'FIXED', 'VARIABLE', OR 'XML'.  Default = 'FIXED'
 	},	
	
	{landing_zone	                    //SourceIP			 Remote Server's IP address									
 	,'/data/enclarity/MPRD/infiles/'+version
	//+'/'            //SourceDirectory	 Absolute path of directory on Remote Server where files are located                
 	,'t_taxon_lu.txt'                                    //directory_filter   Regular expression filter for files to be sprayed, default = '*'                          
 	,0                                                  //record_size	     record length of files to be sprayed(for fixed length files only)      
 	,_Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Name +'::taxon_lu'+ '::@version@'       //Thor_filename_template	-- template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
 	,[{_Dataset(pUseProd).thor_cluster_Files+'in::' + _Dataset().Name +'::taxon_lu'}]            //dSuperfilenames			-- dataset of superfiles to add the sprayed files to.
 	,'thor400_44'                                       //Thor Group name, ex. 'thor_data400' = dataland400, 'thor_dell400' = prod400(default)
	,version                                                 //FileDate				-- version of all of the sprayed files(overrides the next field, dateregex). Default = ''
 	,'[0-9]{8}'                                                //date_regex				-- regular expression to get the date from the remote filenames.  Default = '[0-9]{8}'
	,'VARIABLE'                                         //file_type				-- Type of file format.  Possible types are 'FIXED', 'VARIABLE', OR 'XML'.  Default = 'FIXED'
 	},	
	
	{landing_zone	                    //SourceIP			 Remote Server's IP address									
 	,'/data/enclarity/MPRD/infiles/'+version
	//+'/'            //SourceDirectory	 Absolute path of directory on Remote Server where files are located                
 	,'t_abbr_lu.txt'                                    //directory_filter   Regular expression filter for files to be sprayed, default = '*'                          
 	,0                                                  //record_size	     record length of files to be sprayed(for fixed length files only)      
 	,_Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Name +'::abbr_lu'+ '::@version@'       //Thor_filename_template	-- template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
 	,[{_Dataset(pUseProd).thor_cluster_Files+'in::' + _Dataset().Name +'::abbr_lu'}]            //dSuperfilenames			-- dataset of superfiles to add the sprayed files to.
 	,'thor400_44'                                       //Thor Group name, ex. 'thor_data400' = dataland400, 'thor_dell400' = prod400(default)
	,version                                                 //FileDate				-- version of all of the sprayed files(overrides the next field, dateregex). Default = ''
 	,'[0-9]{8}'                                                //date_regex				-- regular expression to get the date from the remote filenames.  Default = '[0-9]{8}'
	,'VARIABLE'                                         //file_type				-- Type of file format.  Possible types are 'FIXED', 'VARIABLE', OR 'XML'.  Default = 'FIXED'
 	},	
	
	{landing_zone	                    //SourceIP			 Remote Server's IP address									
 	,'/data/enclarity/MPRD/infiles/'+version
	//+'/'            //SourceDirectory	 Absolute path of directory on Remote Server where files are located                
 	,'call_queue_bad.txt'                                    //directory_filter   Regular expression filter for files to be sprayed, default = '*'                          
 	,0                                                  //record_size	     record length of files to be sprayed(for fixed length files only)      
 	,_Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Name +'::call_queue_bad'+ '::@version@'       //Thor_filename_template	-- template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
 	,[{_Dataset(pUseProd).thor_cluster_Files+'in::' + _Dataset().Name +'::call_queue_bad'}]            //dSuperfilenames			-- dataset of superfiles to add the sprayed files to.
 	,'thor400_44'                                       //Thor Group name, ex. 'thor_data400' = dataland400, 'thor_dell400' = prod400(default)
	,version                                                 //FileDate				-- version of all of the sprayed files(overrides the next field, dateregex). Default = ''
 	,'[0-9]{8}'                                                //date_regex				-- regular expression to get the date from the remote filenames.  Default = '[0-9]{8}'
	,'VARIABLE'                                         //file_type				-- Type of file format.  Possible types are 'FIXED', 'VARIABLE', OR 'XML'.  Default = 'FIXED'
 	},
	
	{landing_zone
	,'/data/enclarity/MPRD/infiles/'+ version
	//+ '/'
	,'t_group_practice.txt'
	,0
	,_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::group_practice::@version@'
	,[{_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::group_practice'}]
	,'thor400_44'
	,version
	,'[0-9](8)'
	,'VARIABLE'
	},

	{landing_zone
	,'/data/enclarity/MPRD/infiles/'+ version
	//+ '/'
	,'t_ACI_schedule.txt'
	,0
	,_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::aci_schedule::@version@'
	,[{_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::aci_schedule'}]
	,'thor400_44'
	,version
	,'[0-9](8)'
	,'VARIABLE'
	},
	
	{landing_zone
	,'/data/enclarity/MPRD/infiles/' + version
	//+ '/'
	,'t_business_activities_lu.txt'
	,0
	,_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::business_activities_lu::@version@'
	,[{_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::business_activities_lu'}]
	,'thor400_44'
	,version
	,'[0-9](8)'
	,'VARIABLE'
	},
	
	{landing_zone
	,'/data/enclarity/MPRD/infiles/' + version
	//+ '/'
	,'t_cms_ecp.txt'
	,0
	,_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::cms_ecp::@version@'
	,[{_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::cms_ecp'}]
	,'thor400_44'
	,version
	,'[0-9](8)'
	,'VARIABLE'
	},
	
	{landing_zone
	,'/data/enclarity/MPRD/infiles/' + version
	//+ '/'
	,'t_opi.txt'
	,0
	,_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::opi::@version@'
	,[{_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::opi'}]
	,'thor400_44'
	,version
	,'[0-9](8)'
	,'VARIABLE'
	},
	
	{landing_zone
	,'/data/enclarity/MPRD/infiles/' + version
	//+ '/'
	,'t_opi_facility.txt'
	,0
	,_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::opi_facility::@version@'
	,[{_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::opi_facility'}]
	,'thor400_44'
	,version
	,'[0-9](8)'
	,'VARIABLE'
	},
	
	{landing_zone
	,'/data/enclarity/MPRD/infiles/' + version
	//+ '/'
	,'t_abms_cert_lu.txt'
	,0
	,_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::abms_cert_lu::@version@'
	,[{_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::abms_cert_lu'}]
	,'thor400_44'
	,version
	,'[0-9](8)'
	,'VARIABLE'
	},
	
	{landing_zone
	,'/data/enclarity/MPRD/infiles/' + version
	//+ '/'
	,'t_abms_cooked.txt'
	,0
	,_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::abms_cooked::@version@'
	,[{_Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::abms_cooked'}]
	,'thor400_44'
	,version
	,'[0-9](8)'
	,'VARIABLE'
	}


], VersionControl.Layout_Sprays.Info);

