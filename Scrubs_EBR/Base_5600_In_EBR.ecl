import Scrubs_EBR, EBR, Data_Services, Tools;

dl_or_prod := if(Tools._Constants.IsDataland, data_services.foreign_prod, '~'); 

EXPORT Base_5600_In_EBR := dataset(dl_or_prod + 'thor_data400::base::ebr_5600_Demographic_Data', EBR.layout_5600_Demographic_Data_base,thor);
