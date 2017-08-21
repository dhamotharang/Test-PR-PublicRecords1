
d := Phonesplus.file_qsent_base;

dsample := sample(d,100000,1);

export sample_QsentBase := output(choosen(dsample,1000));