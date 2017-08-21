export fCompileInputFiles(

	  boolean 	pIsTesting				= true
	 ,string 		pFilenamePattern	= '^.*in::liensv2::.*::hgn::okclien$'
	 ,unsigned	pStartDate				= _Flags.MaxDtVendorLastReported					
	
) :=
function

	dlist := fileservices.logicalfilelist();
	modified_date := (unsigned)(dlist.modified[1..4] + dlist.modified[6..7] + dlist.modified[9..10]);

	dlist_filt := dlist(regexfind(pFilenamePattern,name,nocase),modified_date > pStartDate);

	add_to_super := nothor(apply(dlist_filt	,fileservices.addsuperfile(filenames().input.sprayed, '~' + name)));
	
	returnstuff := if(pIsTesting = true
											,output(dlist_filt)
											,sequential(
												 fileservices.startsuperfiletransaction()
												,fileservices.clearsuperfile(filenames().input.sprayed)
												,add_to_super
												,fileservices.finishsuperfiletransaction()
											)
									);
	
	return returnstuff;

end;