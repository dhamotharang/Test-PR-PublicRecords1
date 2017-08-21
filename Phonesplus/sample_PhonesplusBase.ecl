 
d := Phonesplus.file_phonesplus_base;

dsample := sample(d,100000,1);

export sample_PhonesplusBase := output(choosen(dsample,1000));