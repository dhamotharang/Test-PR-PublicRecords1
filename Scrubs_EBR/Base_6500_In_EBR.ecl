import Scrubs_EBR, EBR, Data_Services, Tools;

dl_or_prod := if(Tools._Constants.IsDataland, data_services.foreign_prod, '~');  

EXPORT Base_6500_In_EBR := dataset(dl_or_prod + 'thor_data400::base::ebr_6500_Government_Trade', EBR.layout_6500_Government_Trade_base,thor);
