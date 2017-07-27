import lib_fileservices, Data_Services;

EXPORT fn_promote_GLB5 := function

ds := nothor(FileServices.SuperFileContents ( Data_Services.foreign_logs+'thor_data400::in::fdn::sprayed::glb5'));

ds2 := dataset('~thor_data400::in::fdn::glb5_fupdate',{string name},thor,opt);

ds2set := Set(ds2,name);

ds3 := ds ( name not in ds2set);



ds4 := ds2 + ds3 ;

return Sequential ( Output(ds4,,'~thor_data400::in::fdn::glb5_fupdate_temp',overwrite,thor),
                  FileServices.Deletelogicalfile ( '~thor_data400::in::fdn::glb5_fupdate'),
									FileServices.RenameLogicalfile ( '~thor_data400::in::fdn::glb5_fupdate_temp','~thor_data400::in::fdn::glb5_fupdate')
									);
end;



										             
													 
										
		