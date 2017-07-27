import ut, images;

export File_DOC_Images_Combined := module

	//Use following code for Production:
	export ar_doc 			:= Common_IMG_DC('AR', '~images::in::ar_doc') 			: persist('images::base::ar_doc');
	export co_doc 			:= Common_IMG_DC('CO', '~images::in::co_doc') 			: persist('images::base::co_doc');
	export fl_doc 			:= Common_IMG_DC('FL', '~images::in::fl_doc') 			: persist('images::base::fl_doc');
	export ga_doc_parole	:= Common_IMG_DC('GA', '~images::in::ga_doc_parole') 	: persist('images::base::ga_doc_parole');
	export ks_doc 			:= Common_IMG_DC('KS', '~images::in::ks_doc') 			: persist('images::base::ks_doc');
	export ms_doc_website 	:= Common_IMG_DC('MS', '~images::in::ms_doc_website') 	: persist('images::base::ms_doc_website');
	export mt_doc 			:= Common_IMG_DC('MT', '~images::in::mt_doc') 			: persist('images::base::mt_doc');
	export nc_doc_website 	:= Common_IMG_DC('NC', '~images::in::nc_doc_website') 	: persist('images::base::nc_doc_website');
	export nd_doc 			:= Common_IMG_DC('ND', '~images::in::nd_doc') 			: persist('images::base::nd_doc');
	export nj_doc 			:= Common_IMG_DC('NJ', '~images::in::nj_doc') 			: persist('images::base::nj_doc');
	export nm_doc 			:= Common_IMG_DC('NM', '~images::in::nm_doc') 			: persist('images::base::nm_doc');
	export oh_doc_website 	:= Common_IMG_DC('OH', '~images::in::oh_doc_website') 	: persist('images::base::oh_doc_website');
	export ok_doc 			:= Common_IMG_DC('OK', '~images::in::ok_doc') 			: persist('images::base::ok_doc');
	export sc_doc 			:= Common_IMG_DC('SC', '~images::in::sc_doc') 			: persist('images::base::sc_doc');
	export ut_doc 			:= Common_IMG_DC('UT', '~images::in::ut_doc') 			: persist('images::base::ut_doc');
	export wv_doc 			:= Common_IMG_DC('WV', '~images::in::wv_doc') 			: persist('images::base::wv_doc');
	export wv_doc_alt 		:= Common_IMG_DC('WV', '~images::in::wv_doc_alt') 		: persist('images::base::wv_doc_alt');
	
	export DOC_Concat_All	:= ar_doc + 
								co_doc + 
								fl_doc + 
								ga_doc_parole + 
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
								wv_doc_alt;
 
end;