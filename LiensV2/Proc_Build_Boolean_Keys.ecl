export Proc_Build_Boolean_Keys (string filedate) := function
/*sequential(Liensv2.BWR_Build_Segment_Metadata(filedate),
												Liensv2.BWR_Build_Liensv2_OPT(filedate));*/
												
mdata := Liensv2.BWR_Build_Segment_Metadata(filedate) : success(output('Boolean Metadata complete'));

boolean_build := Liensv2.BWR_Build_Liensv2_OPT(filedate) : success(output('Boolean Key build complete'));

retval := sequential(mdata,boolean_build,
												if(~fileservices.fileexists('~thor::dops::liensv2'),
								fileservices.createsuperfile('~thor::dops::liensv2')),
								fileservices.RemoveSuperFile('~thor::dops::liensv2','~thor::dops::liensv2::booleankeys'),
								output(dataset([{filedate}],{string processdate}),,'~thor::dops::liensv2::booleankeys',overwrite),
								fileservices.addsuperfile('~thor::dops::liensv2','~thor::dops::liensv2::booleankeys')/*,
								fileservices.deletelogicalfile('~thor_data400::persist::liensv2::boolean')*/
								);

return retval;

end;
