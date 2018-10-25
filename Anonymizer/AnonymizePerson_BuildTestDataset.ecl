d1 := DATASET([{'ANDREW','JACKSON', 'M', '591977682', 19681203},{'MARTHA','JACKSON','F', '582828431', 19720602},{'JANET','JONES', 'F', '921922341', 19680701}], {string fname, string lname, string gender, string ssn, INTEGER dob});

output(d1,, '~qa::anonymizer::anonymizeperson::input');
