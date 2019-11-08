import ut,inql_ffd;
EXPORT In_File :=  dataset(INQL_FFD.Filenames(true,true).Input, INQL_FFD.layouts.Input, csv(separator('|\t|'),quote(''),terminator('|\n')), opt);

