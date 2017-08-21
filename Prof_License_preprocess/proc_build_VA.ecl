//Notes :
//Please view below in detail about parameter ftype
//License type format to be provided in inline dataset
// VAInput := dataset([{'available','20150910'},{'medical','20150912'}],{string ftype,string fdate});

//Prof_License_preprocess.proc_build_VA(VAInput).prepall;

EXPORT proc_build_VA(dataset({string ftype,string fdate})infile) := module

export  prepall :=   Sequential ( Spray_VA(infile).out,
                                  Map_VA(infile).buildprep
																	);																									
											
																
end;