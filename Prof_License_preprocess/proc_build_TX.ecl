//Notes :
//Please view below in detail about parameter ftype
//License type format to be provided in inline dataset
// TXInput := dataset([{'nurse','20150910'},{'medical','20150912'}],{string ftype,string fdate});

//Prof_License_preprocess.proc_build_TX(TXInput).prepall;

EXPORT proc_build_TX (dataset({string ftype,string fdate})infile) := module

export  prepall :=  Sequential ( Spray_TX(infile).dospray,
                                  Map_TX(infile).buildprep
																	);		
											
																
end;