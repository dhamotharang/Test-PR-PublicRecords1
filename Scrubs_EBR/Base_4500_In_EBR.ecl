import Scrubs_EBR, EBR, Data_Services, Tools;

dl_or_prod := if(Tools._Constants.IsDataland, data_services.foreign_prod, '~');

EXPORT Base_4500_In_EBR := dataset(dl_or_prod + 'thor_data400::base::ebr_4500_Collateral_Accounts', EBR.layout_4500_Collateral_Accounts_base,thor);
