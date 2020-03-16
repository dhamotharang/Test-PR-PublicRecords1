Import STD, _control, VersionControl;

Export fn_sprayfiles := Module


Export build_1 := STD.File.SprayDelimited('10.121.149.194',
                                '/data/data_build_4/tris_lnssi/dops_release_history/Master_Build_Frequency_Report_20200221.csv',
                                ,,,,
                                'thor400_dev01', // destination group
                                '~thor_data400::in::master_build_frequency::20200221::dops_extract01', // logical name
                                -1,allowoverwrite:=true,compress:=true);

Export build_2 := STD.File.SprayDelimited('10.121.149.194',
                                   '/data/data_build_4/tris_lnssi/dops_release_history/dops_keysizehistory_20200220.txt',
                                   ,,,,
                                   'thor400_dev01', // destination group
                                   '~thor_data400::in::dops_keysizedhistory::20200220::dops_extract02', // Logical name
                                   -1, allowoverwrite:=true, compress:=true);  

Export build_3 := STD.File.SprayDelimited('10.121.149.194',
                                   '/data/data_build_4/tris_lnssi/dops_release_history/orbit_BuildInstance_20200220_0830.csv',
                                   ,,,,
                                   'thor400_dev01', // destination group
                                   '~thor_data400::in::orbit_buildinstance::20200220::dops_extract03', // logical name
                                   -1, allowoverwrite:=true, compress:=true);

Export build_all := Sequential( build_1, build_2, build_3 );

End;