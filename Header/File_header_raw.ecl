boolean var1 := true : stored('production');
import ut,dx_header,data_services;
export File_header_raw := dataset(data_services.foreign_prod+'thor_data400::base::header_raw' + if(var1,'_Prod',''),dx_header.Layout_Header, flat);