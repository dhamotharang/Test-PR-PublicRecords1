
import doc, data_services,crim_common;

Abinitio_In_DOC_Offender
 := dataset(data_services.foreign_prod+'thor_data400::in::crim_offender_clean_' + crim_common.Version_In_DOC_Offender,
			crim_common.Layout_In_DOC_Offender.previous,
			flat
		   );
		   
		  
export File_In_DOC_Offender := abinitio_in_doc_offender(vendor in ['NC','OR','WA'])

;
