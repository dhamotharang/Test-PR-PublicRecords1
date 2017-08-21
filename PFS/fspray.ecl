import lib_fileservices,_control,lib_stringlib,Versioncontrol, tools;

// Note: the Source IP is equivalent to: _control.IPAddress.edata12
// See Tools.Layout_sprays for the full description - the set below is a subset of the full set with
// defaults in place - the "shouldoverwrite" flag is defaulted to false by default.
export fSpray(string pversion, boolean pUseProd = false)	:=	DATASET([
    {'edata12-bld.br.seisint.com'                     //SourceIP - Remote Server's IP address									
    ,'/danny_temp2/CMS/'                              //SourceDirectory - Absolute path of directory on Remote Server where files are located                
    ,'PFS_CodesComposite.csv'                         //directory_filter - Regular expression filter for files to be sprayed, default = '*'                          
    ,0                                                //record_size - record length of files to be sprayed (for fixed length files only)      
    ,_Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Name +'::cptcodes'+'::@version@' //Thor_filename_template	-- template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
    ,[{_Dataset(pUseProd).thor_cluster_Files+'in::' + _Dataset().Name+'::cptcodes'}]             //dSuperfilenames			-- dataset of superfiles to add the sprayed files to.
    ,if((tools._Constants.IsDataland),'thor40_241','thor400_30')    //Thor Group name, ex. 'thor_data400' = dataland400, 'thor_dell400' = prod400(default)
	,pversion                                         //FileDate -- version of all of the sprayed files(overrides the next field, dateregex). Default = ''
    ,'[0-9]{8}'                                       //date_regex -- regular expression to get the date from the remote filenames.  Default = '[0-9]{8}'
	,'VARIABLE'                                       //file_type -- Type of file format.  Possible types are 'FIXED', 'VARIABLE', OR 'XML'.  Default = 'FIXED'
    }
], VersionControl.Layout_Sprays.Info);
