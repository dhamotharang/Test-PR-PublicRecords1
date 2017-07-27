boolean var1 := true : stored('production');
import ut,header,Data_Services;
export File_header_raw_syncd := dataset(  Data_Services.Data_location.Prefix('Header')
																					+'thor_data400::base::header_raw_syncd' + if(var1,'_Prod',''),header.Layout_Header, flat);