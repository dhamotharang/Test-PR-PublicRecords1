export SF_MaintBuilt(string bname) := 
	sequential(
		fileservices.startsuperfiletransaction(),
			fileservices.clearsuperfile(bname + '_BUILT'),
			fileservices.addsuperfile(bname + '_BUILT',bname + '_BUILDING',0,true),
		fileservices.finishsuperfiletransaction(),
		fileservices.clearsuperfile(bname + '_BUILDING') //bug 10378 workaround
	);