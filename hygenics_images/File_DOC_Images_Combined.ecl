import data_services, images;

export File_DOC_Images_Combined := module

	//Use following code for Production:
	export ar_doc 			  := Common_IMG_DC('AR', data_services.foreign_prod+'images::in::ar_doc') 			  : persist('images::base::ar_doc');
	export co_doc 			  := Common_IMG_DC('CO', data_services.foreign_prod+'images::in::co_doc') 			  : persist('images::base::co_doc');
	export fl_doc 			  := Common_IMG_DC('FL', data_services.foreign_prod+'images::in::fl_doc') 			  : persist('images::base::fl_doc');
	export ga_doc_parole	:= Common_IMG_DC('GA', data_services.foreign_prod+'images::in::ga_doc_parole') 	: persist('images::base::ga_doc_parole');
	export ga_doc_website	:= Common_IMG_DC('GA', data_services.foreign_prod+'images::in::ga_doc_website') : persist('images::base::ga_doc_website');
	export ks_doc 			  := Common_IMG_DC('KS', data_services.foreign_prod+'images::in::ks_doc') 			  : persist('images::base::ks_doc');
	export ms_doc_website := Common_IMG_DC('MS', data_services.foreign_prod+'images::in::ms_doc_website') : persist('images::base::ms_doc_website');
	export mt_doc 			  := Common_IMG_DC('MT', data_services.foreign_prod+'images::in::mt_doc') 			  : persist('images::base::mt_doc');
	export nc_doc_website := Common_IMG_DC('NC', data_services.foreign_prod+'images::in::nc_doc_website') : persist('images::base::nc_doc_website');
	export nd_doc 			  := Common_IMG_DC('ND', data_services.foreign_prod+'images::in::nd_doc') 			  : persist('images::base::nd_doc');
	export nj_doc 			  := Common_IMG_DC('NJ', data_services.foreign_prod+'images::in::nj_doc') 			  : persist('images::base::nj_doc');
	export nm_doc 			  := Common_IMG_DC('NM', data_services.foreign_prod+'images::in::nm_doc') 			  : persist('images::base::nm_doc');
	export oh_doc_website := Common_IMG_DC('OH', data_services.foreign_prod+'images::in::oh_doc_website') : persist('images::base::oh_doc_website');
	export ok_doc 			  := Common_IMG_DC('OK', data_services.foreign_prod+'images::in::ok_doc') 			  : persist('images::base::ok_doc');
	export sc_doc 			  := Common_IMG_DC('SC', data_services.foreign_prod+'images::in::sc_doc') 			  : persist('images::base::sc_doc');
	export ut_doc 			  := Common_IMG_DC('UT', data_services.foreign_prod+'images::in::ut_doc') 			  : persist('images::base::ut_doc');
	export wv_doc 			  := Common_IMG_DC('WV', data_services.foreign_prod+'images::in::wv_doc') 			  : persist('images::base::wv_doc');
	export wv_doc_alt 		:= Common_IMG_DC('WV', data_services.foreign_prod+'images::in::wv_doc_alt') 		: persist('images::base::wv_doc_alt');
	
	export ky_doc_website	:= Common_IMG_DC('KY', data_services.foreign_prod+'images::in::ky_doc_website') : persist('images::base::ky_doc_website');
  export ok_doc_vor 	  := Common_IMG_DC('OK', data_services.foreign_prod+'images::in::ok_doc_vor') 		: persist('images::base::ok_doc_vor');
	export ms_DOC_Par     := Common_IMG_DC('MS', data_services.foreign_prod+'images::in::ms_doc_parole') 	: persist('images::base::ms_doc_parole');
	export mi_doc_website := Common_IMG_DC('MI', data_services.foreign_prod+'images::in::mi_doc_website') : persist('images::base::mi_doc_website');
	
	export DOC_Concat_All	:= ar_doc + 
								co_doc + 
								fl_doc + 
								ga_doc_parole + 
								//ga_doc_website + VC 20130823
								ks_doc + 
								ms_doc_website +  
								mt_doc + 
								nc_doc_website + 
								nd_doc +
								nj_doc +
								nm_doc +
								oh_doc_website + 
								ok_doc + 
								sc_doc + 
								ut_doc + 
								wv_doc + 
								wv_doc_alt+
								ky_doc_website+
								ok_doc_vor+
								ms_DOC_Par+
								mi_doc_website:persist('~thor400::persist::doc_concat_all');
 
end;