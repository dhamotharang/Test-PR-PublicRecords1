boolean var1 := true : stored('production');
import ut;
export File_FCRA_Headers := dataset('~thor_data400::base::fcra_header' + if(var1,'_Prod',''),header.Layout_Header, flat);