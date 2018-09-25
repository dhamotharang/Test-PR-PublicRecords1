IMPORT Equifax_Business_Data;

EXPORT in_file := DATASET('~thor_data400::persist::equifax_business_data::standardize_input'	
													,Equifax_Business_Data.Layouts.Base, thor);