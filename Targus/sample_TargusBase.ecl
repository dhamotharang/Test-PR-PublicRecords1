d := Targus.File_consumer_base;

dsample := sample(d,100000,1);

export sample_TargusBase := output(choosen(dsample,1000),named('PostProcessDataSample'));

