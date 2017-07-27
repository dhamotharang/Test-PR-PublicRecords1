
import Transunion_PTrak, lib_fileservices;


DeletePersistfiles(string filename) := if(fileservices.FileExists(filename), fileservices.DeleteLogicalFile(filename), output('No persist file needs to be deleted'));

delete01 := DeletePersistfiles('~thor_data400::persist::transunionptrak_clean_names');
delete02 := DeletePersistfiles('~thor_data400::persist::transunionptrak_clean_normalized');
delete03 := DeletePersistfiles('~thor_data400::persist::transunionptrak_normalized_names');
delete04 := DeletePersistfiles('~thor_data400::persist::transunionptrak_normalized_names_update');

export Delete_persist_files := parallel( delete01, delete02, delete03, delete04
										);
																				