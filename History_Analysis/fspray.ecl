Import STD, _control, dops, History_Analysis;

Export fspray( string pVersion, string datasetname, string location, string cluster, string fromdate, string todate ) :=  Module

// processed datatset in processed_dops file
Shared standalonedops := History_Analysis.Process_Dops(pVersion, datasetname, location, cluster, fromdate, todate ).processed_dops;
Shared processed_dops := History_Analysis.Process_Dops(pVersion, datasetname, location, cluster, fromdate, todate ).appendRawdata;
Shared orbit_new_file := History_Analysis.Filenames(pVersion).OrbitinputTemplate;
Shared master_build_file := History_Analysis.Filenames(pVersion).MasterBuildTemplate;

Export build_1 := STD.File.SprayDelimited('10.121.149.194',
                                '/data/data_build_4/tris_lnssi/dops_release_history/Master_Build_Frequency_Report_20200221.csv',
                                ,,,,
                                'thor400_dev01', // destination group
                                master_build_file, // logical name
                                -1,allowoverwrite:=true,compress:=true);

// file from 2 year history 
Export build_2 := STD.File.SprayDelimited('10.121.149.194',
                                   '/data/temp/venkatan/a.txt',
                                   ,,,,
                                   'thor400_dev01', // destination group
                                   '~thor_data400::history_analysis::in::dops_keysizedhistory', // Logical name
                                   -1, allowoverwrite:=true, compress:=true);  

// appended service from dops
Export build_3 := ordered(processed_dops, History_Analysis.Filenames(pVersion).DopsInputRawdata );

// dops for standalone reports
Export build_4 := ordered(standalonedops, History_Analysis.Filenames(pVersion).dopsServiceData );


Export build_5 := STD.File.SprayDelimited('10.121.149.194',
                                   '/data/data_build_4/tris_lnssi/dops_release_history/orbit_BuildInstance_20200220_0830.csv',
                                   ,,,,
                                   'thor400_dev01', // destination group
                                   orbit_new_file, // logical name
                                   -1, allowoverwrite:=true, compress:=true);

////////////////////// Only include the files you want to spray, otherwise erased build from parallel//////////////////////// 
Export build_all := ordered(processed_dops, // update data from dops
                            build_1, // master build frequency 
                            build_2, // dops two year history 
                            build_3, // dops service 
                            build_5  // orbits
                            );

End;