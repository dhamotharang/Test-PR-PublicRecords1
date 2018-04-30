import images, hygenics_images, OKC_Sexual_Offenders,prte2_doc_images,prte2_sexoffender;

EXPORT Layouts := module

 export raw_image																:= prte2_doc_images.Layouts.raw_image;
	export Common 																		:= images.Layout_Common;
	export Common_v2																:= prte2_doc_images.Layouts.Common_v2;
	export Sex_Offender_Pics_Lookup := OKC_Sexual_Offenders.Layout_OKC_Pics_Lookup;
 export matrix_images 											:= prte2_doc_images.layouts.matrix_images;
 export matrix_images_v2 								:= prte2_doc_images.layouts.matrix_images_v2;
 export matrix_images_reformat 		:= prte2_doc_images.layouts.matrix_images_reformat;
	export key_did																		:= prte2_doc_images.layouts.key_did;
	export key_id																			:= prte2_doc_images.layouts.key_id;
	export key_did_v2															:= prte2_doc_images.layouts.key_did_v2;
	export Key_id_v2																:= prte2_doc_images.layouts.key_id_v2;
	
	export lookup_raw := RECORD, MAXLENGTH(100000000)
		string column_1;
		string column_2;
		string	column_3;
	END;
	
	export IMG_CommonInfo := record
			string state_origin;
			string filename;
			recordof(prte2_sexOffender.Files.SexOffender_base);
		END;	
	
END;	

