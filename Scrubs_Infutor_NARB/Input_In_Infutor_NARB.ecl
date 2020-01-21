import Scrubs_Infutor_NARB, Infutor_NARB, Data_Services;

EXPORT Input_In_Infutor_NARB := DATASET('~thor_data400::persist::infutor_narb::standardize_input'
																								,Infutor_NARB.Layouts.Base
																								,THOR);