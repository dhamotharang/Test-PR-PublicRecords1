//Notes :
//Please view below in detail about parameter ftype
//License type format to be provided in inline dataset
// MIInput := dataset([{'TradeLic','20150910'},{'Health','20150912'}],{string ftype,string fdate});

//Prof_License_preprocess.proc_build_MI(MIInput).prepall;
EXPORT proc_build_MI(dataset({string ftype,string fdate})infile) := module

export  prepall :=  Sequential ( Spray_MI(infile).out,
                                  Map_MI(infile).buildprep
																	);									
											
																
end;