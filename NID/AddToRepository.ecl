import STD;

//superfile := NID.Common.filename_NameRepository_Cache;	
superfile := NID.Common.filename_NameRepository;
 
export AddToRepository(string filename, boolean legacy = false) := 
						Std.File.AddSuperFile(
							if(legacy, Nid.Common.filename_NameRepository_Legacy, superfile),
							filename);
