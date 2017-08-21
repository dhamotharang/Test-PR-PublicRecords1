//License type format to be provided in inline dataset
// ARInput := dataset([{'dentists','20150910'},{'optometry','20150912'},{'pharmacy','20150905'}],{string ftype,string fdate});

//Prof_License_preprocess.proc_build_AR(ARInput).prepall;

import lib_StringLib;
EXPORT proc_build_AR(dataset({string ftype,string fdate})infile) := module

  export  prepall :=   Sequential ( Spray_AR(infile).dospray,
                             Map_AR(infile).buildprep
													  ) :  success(Send_Email('AR').buildsuccess), failure(Send_Email('AR').buildfailure);;
							
																
end;