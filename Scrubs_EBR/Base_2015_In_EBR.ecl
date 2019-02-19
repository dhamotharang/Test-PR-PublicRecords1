import Scrubs_EBR, EBR, Data_Services, Tools;

dl_or_prod := if(Tools._Constants.IsDataland, data_services.foreign_prod, '~'); 

EXPORT Base_2015_In_EBR := dataset(dl_or_prod + 'thor_data400::base::ebr_2015_Trade_Payment_Totals', EBR.layout_2015_Trade_Payment_Totals_base,thor);
