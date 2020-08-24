IMPORT Data_Services, doxie;   

finalagency :=  dataset(Data_Services.foreign_prod+'thor_data400::base::agency_cmbnd', FLAccidents_Ecrash.Layout_Infiles_Fixed.agency_cmbnd, THOR); 


EXPORT key_EcrashV2_agency := INDEX(finalagency
                                            ,{Agency_State_Abbr,Agency_Name,Agency_ori}
								                            ,{Mbsi_Agency_ID, Cru_Agency_ID, Cru_State_Number, Source_ID, Append_Overwrite_Flag}
								                            ,Data_Services.Data_location.Prefix('ecrash')+'thor_data400::key::ecrashV2_agency_' + doxie.Version_SuperKey);														