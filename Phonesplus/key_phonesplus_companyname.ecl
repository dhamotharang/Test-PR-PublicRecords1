f_phonesplus_company := dataset([], {string80 company, unsigned6 fdid});

export key_phonesplus_companyname := index(f_phonesplus_company,{company},{fdid},
                                           '~thor_data400::key::phonesplus_companyname_qa');