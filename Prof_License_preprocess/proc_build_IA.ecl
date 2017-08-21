//Notes :
//Please view below in detail about parameter ftype
//License type format to be provided in inline dataset
// IAInput := dataset([{'dentist','20150910'},{'medical','20150912'}],{string ftype,string fdate});

//Prof_License_preprocess.proc_build_IA(IAInput).prepall;

EXPORT proc_build_IA (dataset({string ftype,string fdate})infile) := module

export  prepall :=  Sequential ( Spray_IA(infile).dospray,
                                  Map_IA(infile).buildprep
																	);		
											
																
end;