import _control,Versioncontrol,tris_lnssi_build;

IPAddress          := IF(_control.ThisEnvironment.Name='Prod_Thor',
																	_Control.IPAddress.bctlpedata12,  // Use if in prod
																	_Control.IPAddress.bctlpedata12); // Use if in dataland

export fSpray(string version, boolean pUseProd = false)   :=   DATASET([

    {IPAddress																			                       //SourceIP          Remote Server's IP address
    ,'/data/data_build_4/tris_lnssi'                    //SourceDirectory    Absolute path of directory on Remote Server where files are located
    ,'*.csv'                                            //directory_filter   Regular expression filter for files to be sprayed, default = '*'
    ,0                                                  //record_size        record length of files to be sprayed(for fixed length files only)
    ,tris_lnssi_build._Dataset(pUseProd).thor_cluster_Files+ 'in::' + tris_lnssi_build._Dataset().Name + '::@version@' //Thor_filename_template   -- template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
    ,[{tris_lnssi_build._Dataset(pUseProd).thor_cluster_Files+'in::' + tris_lnssi_build._Dataset().Name  }]            //dSuperfilenames         -- dataset of superfiles to add the sprayed files to.
    ,tris_lnssi_build._Dataset(pUseProd).groupname() //Thor Group name, ex. 'thor_data400' = dataland400, 'thor_dell400' = prod400(default)
    ,version                                            //FileDate            -- version of all of the sprayed files(overrides the next field, dateregex). Default = ''
    ,'[0-9]{8}'                                         //date_regex            -- regular expression to get the date from the remote filenames.  Default = '[0-9]{8}'
    ,'VARIABLE'                                         //file_type            -- Type of file format.  Possible types are 'FIXED', 'VARIABLE', OR 'XML'.  Default = 'FIXED'
    }
], VersionControl.Layout_Sprays.Info);

