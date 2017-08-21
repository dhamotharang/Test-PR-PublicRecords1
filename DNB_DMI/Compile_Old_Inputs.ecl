/*2011-05-25T14:18:57Z (Vern Bentley)

*/
export Compile_Old_Inputs(

	  boolean 	pIsTesting							= false
	 ,string 		pCompanyFilenamePattern	= '^.*?in::dnb::[0-9]{8}[a-z]?::base.*$'
	 ,string 		pContactFilenamePattern	= '^.*?in::dnb::[0-9]{8}[a-z]?::names.*$'
	
) :=
function

	dlist := fileservices.logicalfilelist();

	dlist_comp_filt := dlist(regexfind(pCompanyFilenamePattern,name,nocase));
	dlist_cont_filt := dlist(regexfind(pContactFilenamePattern,name,nocase));

	add_comp_to_super := nothor(apply(dlist_comp_filt	,fileservices.addsuperfile(filenames().input.oldcompanies.sprayed	, '~' + name)));
	add_cont_to_super := nothor(apply(dlist_cont_filt	,fileservices.addsuperfile(filenames().input.oldcontacts.sprayed	, '~' + name)));
	
	returnstuff := if(pIsTesting = true
											,sequential(
												 output(dlist_comp_filt	,named('dlist_comp_filt'))
												,output(dlist_cont_filt	,named('dlist_cont_filt'))
											)
											,sequential(
												 fileservices.startsuperfiletransaction()
												,fileservices.clearsuperfile(filenames().input.oldcompanies.sprayed	)
												,fileservices.clearsuperfile(filenames().input.oldcontacts.sprayed	)
												,add_comp_to_super
												,add_cont_to_super
												,fileservices.finishsuperfiletransaction()
											)
									);
	
	return returnstuff;

end;