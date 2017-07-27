
import doc, ut;

abinitio_In_DOC_Punishment
 := dataset(ut.foreign_prod+'~thor_data400::in::crim_punishment_' + Version_In_DOC_Punishment,
			Layout_In_DOC_Punishment.previous,
			flat
		   );
		   
export File_In_DOC_punishment := 
abinitio_in_doc_punishment
/*+ doc.map_doc_co_punishment
+ doc.map_doc_wv_punishment
+ doc.map_doc_fl_punishment
+ doc.map_doc_ri_punishment
+ doc.map_doc_nv_punishment*/
;
