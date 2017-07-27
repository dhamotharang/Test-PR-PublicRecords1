
import doc, ut;

Abinitio_In_DOC_Offender
 := dataset(ut.foreign_prod+'~thor_data400::in::crim_offender_clean_' + Version_In_DOC_Offender,
			Layout_In_DOC_Offender.previous,
			flat
		   );
		   
		  
export File_In_DOC_Offender := 
abinitio_in_doc_offender
+ doc.map_doc_co_offender
+ doc.map_doc_wv_offender
+ doc.map_doc_fl_offender
+ doc.map_doc_ri_offender
+ doc.map_doc_nv_offender
;
