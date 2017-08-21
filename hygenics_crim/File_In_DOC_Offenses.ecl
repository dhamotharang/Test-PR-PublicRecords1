
import doc, data_services,crim_common;

abinitio_In_DOC_Offenses
 := dataset(data_services.foreign_prod+'thor_data400::in::crim_offenses_' + crim_common.Version_In_DOC_Offenses,
			crim_common.Layout_In_DOC_Offenses.previous,
			flat
		   );
		   
export file_in_doc_offenses := abinitio_in_doc_offenses (vendor in ['NC','OR','WA'])

/*+ doc.map_doc_co_offenses
+ doc.map_doc_wv_offenses
+ doc.map_doc_fl_offenses
+ doc.map_doc_ri_offenses
+ doc.map_doc_nv_offenses*/
;



