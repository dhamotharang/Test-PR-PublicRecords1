import lib_fileservices, _control, lib_stringlib, Versioncontrol;

export fSpray(string version, boolean pUseProd=false)	:=	
DATASET
(
    [
        {
            _control.IPAddress.bctlpedata10,       //SourceIP - Remote Server's IP address
            '/data/inquiry_data_01/spray_ready/',  //SourceDirectory - Absolute path of directory on Remote Server where files are located
            '*.csv',                               //directory_filter - Regular expression filter for files to be sprayed, default = '*'                          
            0,                                     //record_size - record length of files to be sprayed(for fixed length files only)      
            
            _Dataset(pUseProd).thor_cluster_Files+ 'in::' + _Dataset().Name + '::@version@',
                                                   //Thor_filename_template - template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
                                                   
            [{_Dataset(pUseProd).thor_cluster_Files+'in::' + _Dataset().Name  }],
                                                   //dSuperfilenames - dataset of superfiles to add the sprayed files to.
                                                   
            'thor100_21',                          //Thor Group name, ex. 'thor_data400' = dataland400, 'thor_dell400' = prod400(default)
            version,                               //FileDate - version of all of the sprayed files(overrides the next field, dateregex). Default = ''
            '[0-9]{8}',                            //date_regex - regular expression to get the date from the remote filenames.  Default = '[0-9]{8}'
            'VARIABLE'                             //file_type - Type of file format.  Possible types are 'FIXED', 'VARIABLE', OR 'XML'.  Default = 'FIXED'
        }	                                                            
    ], 
    VersionControl.Layout_Sprays.Info
);