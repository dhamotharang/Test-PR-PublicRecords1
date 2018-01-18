import data_services;

df1 := ssnissue2.File_SSNIssue2(ssn5!= '');

string_rec := record
ssn := df1.ssn5 + df1.end_serial;
df1;
end;

df := table(df1,string_rec);

export key_ssnissue2 := index(df,{ssn},{df},data_services.data_location.prefix() + 'thor_data400::key::ssnissue2::qa::ssn');
