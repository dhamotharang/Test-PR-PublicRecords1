import lib_fileservices,tools,_control,lib_stringlib,Versioncontrol, HMS_Medicaid_Common;
Medicaid_State := 'NY';
EXPORT SpraySheet (String ThisSheet,string version, boolean pUseProd = false):= 	 DATASET([
		{'edata12-bld.br.seisint.com'	                    //SourceIP			 Remote Server's IP address									
		,'/hds_180/Medicaid/'+Medicaid_State+'/'+ version[..8]+'/'         //SourceDirectory	 Absolute path of directory on Remote Server where files are located                
		,ThisSheet +  '.txt'
		,0                                               //record_size	     record length of files to be sprayed(for fixed length files only)      
		,HMS_Medicaid_Common._Dataset(Medicaid_State,pUseProd).thor_cluster_Files+ 'in::' + 
					HMS_Medicaid_Common._Dataset(Medicaid_State,pUseProd).Name + '::' + version + '::' + Thissheet      //Thor_filename_template	-- template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
		,[{HMS_Medicaid_Common._Dataset(Medicaid_State,pUseProd).thor_cluster_Files+'in::' + 
				HMS_Medicaid_Common._Dataset(Medicaid_State,pUseProd).Name + '::' + version  }]            //dSuperfilenames			-- dataset of superfiles to add the sprayed files to.
		,IF((tools._Constants.IsDataland),'thor400_dev01','thor400_20')    //Thor Group name, ex. 'thor_data400' = dataland400, 'thor_dell400' = prod400(default)
		,version                                          //FileDate				-- version of all of the sprayed files(overrides the next field, dateregex). Default = ''
		,'[0-9]{8}'                                       //date_regex				-- regular expression to get the date from the remote filenames.  Default = '[0-9]{8}'
		,'VARIABLE'                                          //file_type				-- Type of file format.  Possible types are 'FIXED', 'VARIABLE', OR 'XML'.  Default = 'FIXED'
		}	                                                            
	], VersionControl.Layout_Sprays.Info);
