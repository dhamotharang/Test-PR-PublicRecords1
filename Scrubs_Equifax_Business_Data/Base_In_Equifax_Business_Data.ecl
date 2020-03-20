import Scrubs_Equifax_Business_Data, Equifax_Business_Data, Data_Services;

EXPORT Base_In_Equifax_Business_Data := Equifax_Business_Data.Files().Base.built;
// EXPORT Base_In_Equifax_Business_Data := DATASET('~thor_data400::persist::equifax_business_data::standardize_nameaddr',Scrubs_Equifax_Business_Data.Base_Layout_Equifax_Business_Data,THOR);