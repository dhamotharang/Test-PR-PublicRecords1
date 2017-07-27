
import doc, ut;

abinitio_In_DOC_Offenses
 := dataset(ut.foreign_prod+'~thor_data400::in::crim_offenses_' + Version_In_DOC_Offenses,
			Layout_In_DOC_Offenses.previous,
			flat
		   );
		   
export file_in_doc_offenses := 
abinitio_in_doc_offenses 
/*+ doc.map_doc_co_offenses
+ doc.map_doc_wv_offenses
+ doc.map_doc_fl_offenses
+ doc.map_doc_ri_offenses
+ doc.map_doc_nv_offenses*/
;



