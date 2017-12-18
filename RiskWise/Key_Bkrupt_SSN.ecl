import doxie, bankrupt,data_services;

f := Bankrupt.File_BK_Search;

export Key_Bkrupt_SSN := INDEX(f,{debtor_ssn},{f}, data_services.data_location.prefix() + 'thor_data400::key::bkrupt_ssn_'+doxie.Version_SuperKey);