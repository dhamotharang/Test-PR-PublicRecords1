base_births := Births.BaseFile_births;

export Key_Births_DID := index(	base_births
								,{did}
								,{base_births}
								,'~thor_data400::key::births::qa::did');