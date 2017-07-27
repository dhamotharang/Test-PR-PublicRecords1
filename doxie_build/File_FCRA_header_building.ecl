boolean var1 := true : stored('production');
import ut,header;
export File_FCRA_header_building := dataset('~thor_data400::base::file_fcra_header_building' + if(var1,'_Prod',''),header.Layout_Header, flat);