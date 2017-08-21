
import crim_cp_ln;

export file_vendor_stats_father_doc := 
if(fileservices.GetSuperFileSubCount('~thor_data400::base::crim_vendor_stats_doc_father')=1,
				dataset('~thor_data400::base::crim_vendor_stats_doc_father',layout_vendor_stats_doc,thor),
			dataset([],layout_vendor_stats_doc));
