import Scrubs_EBR, EBR, Data_Services, Tools;

dl_or_prod := if(Tools._Constants.IsDataland, data_services.foreign_prod, '~');

EXPORT Base_4020_In_EBR := dataset(dl_or_prod + 'thor_data400::base::ebr_4020_Tax_Liens', EBR.layout_4020_Tax_Liens_base,thor);
