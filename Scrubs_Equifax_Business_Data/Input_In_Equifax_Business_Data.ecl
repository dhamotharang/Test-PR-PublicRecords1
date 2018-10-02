import Scrubs_Equifax_Business_Data, Equifax_Business_Data, Data_Services;

EXPORT Input_In_Equifax_Business_Data := DATASET('~thor_data400::persist::equifax_business_data::standardize_input'
                                         ,Equifax_Business_Data.Layouts.Base
																				 ,THOR);