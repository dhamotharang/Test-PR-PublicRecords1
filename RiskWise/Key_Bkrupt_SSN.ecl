import doxie, bankrupt;

f := Bankrupt.File_BK_Search;

export Key_Bkrupt_SSN := INDEX(f,{debtor_ssn},{f},'~thor_data400::key::bkrupt_ssn_'+doxie.Version_SuperKey);