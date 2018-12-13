import Scrubs_EBR, EBR, Data_Services, Tools;

dl_or_prod := if(Tools._Constants.IsDataland, data_services.foreign_prod, '~'); 

EXPORT Base_2000_In_EBR := dataset(dl_or_prod + 'thor_data400::base::ebr_2000_trade', EBR.layout_2000_trade_base,thor);
