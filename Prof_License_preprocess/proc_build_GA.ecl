//Notes :
//Please view below in detail about parameter ftype
//License type format to be provided in inline dataset
// GAInput := dataset([{'medical','20150910'},{'available','20150912'},{'nurse','20150905'}],{string ftype,string fdate});

//Prof_License_preprocess.proc_build_GA(GAInput).prepall;

EXPORT proc_build_GA(dataset({string ftype,string fdate})infilenew) := module

export  prepall :=  Sequential ( Spray_GA(infilenew).dospray,
                                   Map_GA(infilenew).dGAout
																	 
																	);
											
																
end;
