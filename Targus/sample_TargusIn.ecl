d := Targus.File_Consumer_in;

dsample := sample(d,14384,1);

csample := choosen(dsample,10000);
	
export sample_TargusIn := output(csample,,'~thor_data400::out::targus_OrigDatasample',overwrite);