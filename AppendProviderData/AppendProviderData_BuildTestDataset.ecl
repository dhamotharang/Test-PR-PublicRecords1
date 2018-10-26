//TODO: ECL to generate test dataset
dstest:=DATASET([],{STRING field1});
OUTPUT(dstest,,'~qa::appendproviderdata::appendproviderdata::input',OVERWRITE);
