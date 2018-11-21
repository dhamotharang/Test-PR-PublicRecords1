import Scrubs_EBR, EBR, Data_Services, Tools;

dl_or_prod := if(Tools._Constants.IsDataland, data_services.foreign_prod, '~'); 

EXPORT Base_2020_In_EBR := dataset(dl_or_prod + 'thor_data400::base::ebr_2020_Trade_Payment_Trends', EBR.layout_2020_Trade_Payment_Trends_base,thor);
