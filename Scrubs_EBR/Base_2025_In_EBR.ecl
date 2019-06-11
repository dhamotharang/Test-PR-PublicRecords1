import Scrubs_EBR, EBR, Data_Services, Tools;

dl_or_prod := if(Tools._Constants.IsDataland, data_services.foreign_prod, '~'); 

EXPORT Base_2025_In_EBR := dataset(dl_or_prod + 'thor_data400::base::ebr_2025_Trade_Quarterly_Averages', EBR.layout_2025_Trade_Quarterly_Averages_base,thor);
