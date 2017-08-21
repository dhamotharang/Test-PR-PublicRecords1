//Notes :
//Please view below in detail about parameter ftype
//License type format to be provided in inline dataset
// MNInput := dataset([{'available','20150910'},{'physician','20150912'}],{string ftype,string fdate});

//Prof_License_preprocess.proc_build_MN(MNInput).prepall;

EXPORT proc_build_MN(dataset({string ftype,string fdate})infile) := module

export  prepall :=   Sequential ( Spray_MN(infile).out,
                                  Map_MN(infile).buildprep
																	);																									
											
																
end;