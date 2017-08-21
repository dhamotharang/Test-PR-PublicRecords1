//Notes :
//Please view below in detail about parameter ftype
//License type format to be provided in inline dataset
// SCInput := dataset([{'medical','20150910'},{'social_worker','20150912'},{'psychology','20150912'}],{string ftype,string fdate});

//Prof_License_preprocess.proc_build_SC(SCInput).prepall;


EXPORT proc_build_SC (dataset({string ftype,string fdate})infile) := module

export  prepall :=    Sequential (      Spray_SC(infile).dospray,
                                     Map_SC(infile).buildprep
																	);																													
											
																
end;