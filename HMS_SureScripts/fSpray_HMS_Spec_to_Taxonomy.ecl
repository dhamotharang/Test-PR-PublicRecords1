﻿import lib_fileservices,tools,_control,lib_stringlib,Versioncontrol;

export fSpray_HMS_Spec_to_Taxonomy(string version, boolean pUseProd = false)	:=	DATASET([
 	{'_control.IPAddress.bctlpedata10'	                    //SourceIP			 Remote Server's IP address									
 	,'/data/hds_180/SureScripts/HMS_Spec_to_Taxonomy/'+version[..8]+'/'         //SourceDirectory	 Absolute path of directory on Remote Server where files are located                
 	,'*.tab' // Note the casing of the file name                                 //directory_filter   Regular expression filter for files to be sprayed, default = '*'                          
 	,0                                               //record_size	     record length of files to be sprayed(for fixed length files only)      
 	,_Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().HMS_Spec_to_Taxonomy + '::' + 'HMS_Spec_to_Taxonomy'      //Thor_filename_template	-- template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
 	,[{_Dataset(pUseProd).thor_cluster_Files+'in::' + _Dataset().HMS_Spec_to_Taxonomy  }]            //dSuperfilenames			-- dataset of superfiles to add the sprayed files to.
 	,IF((tools._Constants.IsDataland),'thor400_dev01','thor400_44')    //Thor Group name, ex. 'thor_data400' = dataland400, 'thor_dell400' = prod400(default)
	,version                                          //FileDate				-- version of all of the sprayed files(overrides the next field, dateregex). Default = ''
 	,'[0-9]{8}'                                       //date_regex				-- regular expression to get the date from the remote filenames.  Default = '[0-9]{8}'
	,'VARIABLE'                                       //file_type				-- Type of file format.  Possible types are 'FIXED', 'VARIABLE', OR 'XML'.  Default = 'FIXED'
	// ,''
	// ,8192
	// ,'\\t'
	}	                                                            
], VersionControl.Layout_Sprays.Info);

