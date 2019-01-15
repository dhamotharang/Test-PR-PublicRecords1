import Versioncontrol;

export fSpray(string version, boolean pUseProd = false)	:=	DATASET([
 	{_Constants.ServerIP   //SourceIP
 	,_Constants.LandingDir + 'spraying/'             //SourceDirectory
 	,'*.csv'                           //directory_filter
 	,0                                 //record_size	     record length of files to be sprayed(for fixed length files only)      
 	,_Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Name + '::@version@'
 	,[{_Dataset(pUseProd).thor_cluster_Files+'in::' + _Dataset().Name  }]
 	,'thor400_44'
	,version          //FileDate -- version of all of the sprayed files(overrides the next field, dateregex). Default = ''
 	,'[0-9]{8}'       //date_regex -- regular expression to get the date from the remote filenames.  Default = '[0-9]{8}'
	,'VARIABLE'       //Possible types are 'FIXED', 'VARIABLE', OR 'XML'.  Default = 'FIXED'
    ,''
    ,10000000
    ,'\\,'
    ,'\\n,\\r\\n'
    ,'"'
    ,true //compress
 	}	                                                            
], VersionControl.Layout_Sprays.Info);

