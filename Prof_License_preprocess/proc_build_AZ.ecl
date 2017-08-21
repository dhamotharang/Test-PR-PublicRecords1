//License type format to be provided in inline dataset
// AZInput := dataset([{'acupunturist','20150910'},{'ostepoath','20150912'},{'pharmacy','20150905'},{'nurse','20150905'}],{string ftype,string fdate});

//Prof_License_preprocess.proc_build_AZ(AZInput).prepall;

import lib_StringLib;
EXPORT proc_build_AZ(dataset({string ftype,string fdate})infile) := module

export  prepall :=   Sequential ( Spray_AZ(infile).dospray,
                                  Map_AZ(infile).buildprep
																	):  success(Send_Email('AZ').buildsuccess), failure(Send_Email('AZ').buildfailure);
							
																
end;