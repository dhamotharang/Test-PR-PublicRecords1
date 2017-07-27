boolean var1 := true : stored('production');
import ut,header;
export File_header_raw := dataset('~thor_data400::base::header_raw' + if(var1,'_Prod',''),header.Layout_Header, flat);