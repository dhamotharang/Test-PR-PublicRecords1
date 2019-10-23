export fn_sprayInputfiles(sourceIP,sourcefile,filedate,st,cty,oftype,group_name='\'thor400_44\'',email_target='\' \'') := 
macro
#uniquename(spray_of)
#uniquename(superfile_transaction)
#uniquename(map_cty)
#uniquename(run_map_all)
#uniquename(state)
#uniquename(county)
#uniquename(fdate)

#workunit('name','Official Records  '+st+' '+cty+' '+filedate+' spray');

//%run_map_all% := 'official_records.mapping_'+st+'_'+cty(filedate) ;

%spray_of% := map( cty = 'volusia' and oftype = '' => lib_fileservices.FileServices.SprayXML(sourceIP,sourcefile,,'Instrument','UTF8',group_name,'~thor_200::in::official_records::'+st+'::'+cty+'_'+filedate,-1,,,true,true,true),
                  // cty = 'orange' and oftype = '' => FileServices.SprayVariable(sourceIP,sourcefile,,'|',,'', group_name,'~thor_200::in::official_records_'+st+'_'+cty+'_'+filedate,-1,,,true,true,true),
                  cty <> 'volusia' and oftype = ''=> FileServices.SprayVariable(sourceIP,sourcefile,,,,, group_name,'~thor_200::in::official_records::'+st+'::'+cty+'_'+filedate,-1,,,true,true,true),
									
                              FileServices.SprayVariable(sourceIP,sourcefile,,,,, group_name,'~thor_200::in::official_records::'+st+'::'+cty+'_'+oftype+'_'+filedate,-1,,,true,true,true));

%superfile_transaction% := if( oftype = '',sequential(FileServices.StartSuperFileTransaction(),
                                        if ( FileServices.FileExists('~thor_200::in::official_records::'+st+'::'+cty) = false,FileServices.CreateSuperFile('~thor_200::in::official_records::'+st+'::'+cty)),
                                           FileServices.ClearSuperFile('~thor_200::in::official_records::'+st+'::'+cty),
				                           FileServices.AddSuperFile('~thor_200::in::official_records::'+st+'::'+cty,'~thor_200::in::official_records::'+st+'::'+cty+'_'+filedate),
				                           FileServices.FinishSuperFileTransaction()),
				                              sequential(FileServices.StartSuperFileTransaction(),
																	if ( FileServices.FileExists('~thor_200::in::official_records::'+st+'::'+cty+'_'+oftype) = false,FileServices.CreateSuperFile('~thor_200::in::official_records::'+st+'::'+cty+'_'+oftype)),

                                           FileServices.ClearSuperFile('~thor_200::in::official_records::'+st+'::'+cty+'_'+oftype),
				                           FileServices.AddSuperFile('~thor_200::in::official_records::'+st+'::'+cty+'_'+oftype,'~thor_200::in::official_records::'+st+'::'+cty+'_'+oftype+'_'+filedate),
				                           FileServices.FinishSuperFileTransaction()) )     ;

sequential(%spray_of%,%superfile_transaction%/*,%run_map_all%*/);

endmacro;