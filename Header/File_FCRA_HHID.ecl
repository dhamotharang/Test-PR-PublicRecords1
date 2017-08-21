boolean var1 := true : stored('production');
import ut,data_services,header;
export File_FCRA_HHID := 
dataset(data_services.Data_location.prefix('') +'thor_data400::base::FCRA_HHID' + if(var1,'_Prod',''),layout_hhid, flat);