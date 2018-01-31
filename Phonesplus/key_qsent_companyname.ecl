import Data_Services;

f := dataset([],{string80 company, unsigned integer6 fdid});

export key_qsent_companyname := index(f,{company},{fdid},
                                      Data_Services.Data_location.Prefix()+'thor_data400::key::qsent_companyname_qa');