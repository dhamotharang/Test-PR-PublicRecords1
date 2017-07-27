export Mac_Update_SuperFiles(wu) := macro
	#uniquename(foo)
	boolean %foo% := true;
	
	sequential(
	fileservices.clearsuperfile('~thor_data400::base::corp_base_father'),
	fileservices.addsuperfile('~thor_data400::base::corp_base_father','~thor_data400::base::corp_base',0,true),
	fileservices.clearsuperfile('~thor_data400::base::corp_base'),
	fileservices.addsuperfile('~thor_data400::base::corp_base','~thor_data400::base::corp_base' + wu));
	
	sequential(fileservices.clearsuperfile('~thor_data400::base::corp_cont_base_father'),
	fileservices.addsuperfile('~thor_data400::base::corp_cont_base_father','~thor_data400::base::corp_cont_base',0,true),
	fileservices.clearsuperfile('~thor_data400::base::corp_cont_base'),
	fileservices.addsuperfile('~thor_data400::base::corp_cont_base','~thor_data400::base::corp_cont_base' + wu));
	
	sequential(fileservices.clearsuperfile('~thor_data400::base::corp_event_base_father'),
	fileservices.addsuperfile('~thor_data400::base::corp_event_base_father','~thor_data400::base::corp_event_base',0,true),
	fileservices.clearsuperfile('~thor_data400::base::corp_event_base'),
	fileservices.addsuperfile('~thor_data400::base::corp_event_base','~thor_data400::base::corp_event_base' + wu));
	
	sequential(fileservices.clearsuperfile('~thor_data400::base::corp_supp_base_father'),
	fileservices.addsuperfile('~thor_data400::base::corp_supp_base_father','~thor_data400::base::corp_supp_base',0,true),
	fileservices.clearsuperfile('~thor_data400::base::corp_supp_base'),
	fileservices.addsuperfile('~thor_data400::base::corp_supp_base','~thor_data400::base::corp_supp_base' + wu));
	
endmacro;
