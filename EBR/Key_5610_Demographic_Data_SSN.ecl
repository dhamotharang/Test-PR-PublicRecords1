import doxie;
f := File_5610_Demographic_Data_Base_bdid(ssn <> 0);
export Key_5610_Demographic_Data_SSN := index(f,{ssn},{f},KeyName_5610_Demographic_Data_SSN + '_' + doxie.Version_SuperKey);
