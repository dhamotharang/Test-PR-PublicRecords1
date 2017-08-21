//License type format to be provided in inline dataset
// COInput := dataset([{'medical','20150910'},{'available','20150912'}],{string ftype,string fdate});

//Prof_License_preprocess.proc_build_CO(COInput).prepall;

import lib_StringLib;
EXPORT proc_build_CO(dataset({string ftype,string fdate})infile) := module

export  prepall :=   Sequential ( Spray_CO(infile).dospray,
                                  Map_CO(infile).buildprep
																	);
							
																
end;