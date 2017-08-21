
import doc, data_services,crim_common;

abinitio_In_DOC_Punishment
 := dataset(data_services.foreign_prod+'thor_data400::in::crim_punishment_' + crim_common.Version_In_DOC_Punishment,
			crim_common.Layout_In_DOC_Punishment.previous,
			flat
		   );
		   
export File_In_DOC_punishment := abinitio_in_doc_punishment(vendor in ['NC','OR','WA'])
/*+ doc.map_doc_co_punishment
+ doc.map_doc_wv_punishment
+ doc.map_doc_fl_punishment
+ doc.map_doc_ri_punishment
+ doc.map_doc_nv_punishment*/
;
