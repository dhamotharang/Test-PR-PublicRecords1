import RoxieKeybuild;

//Build the base files and keys
export proc_build_all(string filename,string filedate) := function
//update dops


build_all := sequential(fSpraycourtfiles(filename,filedate),
                        proc_build_base,
						proc_build_keys(filedate));

return build_all;
end;
