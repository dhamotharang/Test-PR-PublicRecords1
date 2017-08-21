//Header by ITIN W20071120-101432

output(table(header_quick.file_header_quick,{ssn[1],ssn[4],count(group)},ssn[1],ssn[4]),all);

//ITIN means: ssn[1]=9 and (ssn[4]=7 or ssn[4]=8)