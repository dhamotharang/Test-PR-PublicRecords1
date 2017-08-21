export MAC_Phone_Spray(sourceIP,sourceFile,filedate,recordsize='38',group_name ='\'thor400_30\'') := macro
#workunit('name','Phone Suppress Spray')
#uniquename(spray_file)
#uniquename(clear_super)
#uniquename(move2father)
#uniquename(add_super)
#uniquename(e_mail_success)
#uniquename(e_mail_fail)

%spray_file% := fileservices.sprayfixed(sourceIP,sourcefile,recordsize,group_name,'~thor_data400::in::blackphonelist_'+filedate ,-1,,,true,true);
%move2father% := fileservices.AddSuperFile('~thor_data400::in::blackphonelist_Father','~thor_data400::in::blackphonelist',,true);
%clear_super% := fileservices.clearsuperfile('~thor_data400::in::blackphonelist');
%add_super% := fileservices.addsuperfile('~thor_data400::in::blackphonelist','~thor_data400::in::blackphonelist_'+filedate);

%e_mail_success% := fileservices.sendemail(
													'roxiedeployment@seisint.com',
													'BlackPhoneList Roxie Build Succeeded ' + filedate,
													'keys: 1) thor400_92::key::blackphonelist_qa(thor400_92::key::blackphonelist::'+filedate+'::blackphonelist),\n' + 
													'      have been built and ready to be deployed to QA.');
							
%e_mail_fail% := fileservices.sendemail(
													//'CPettola@seisint.com;avenkatachalam@seisint.com',
													'avenkatachalam@seisint.com',
													'BlackPhoneList Roxie Build FAILED',
													failmessage);

sequential(%spray_file%,%move2father%,%clear_super%,%add_super%,suppress.proc_build_keys(filedate),suppress.Proc_AcceptSK_toQA) 
		: success(%e_mail_success%),
		  failure(%e_mail_fail%);
		
endmacro;