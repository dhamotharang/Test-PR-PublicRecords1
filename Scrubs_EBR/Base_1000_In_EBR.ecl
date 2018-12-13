import Scrubs_EBR, EBR, Data_Services, Tools;

dl_or_prod := if(Tools._Constants.IsDataland, data_services.foreign_prod, '~'); 

EXPORT Base_1000_In_EBR := dataset(dl_or_prod + 'thor_data400::base::ebr_1000_executive_summary', EBR.layout_1000_executive_summary_base,thor);


		