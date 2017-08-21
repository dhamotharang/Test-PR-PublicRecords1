export SF_MaintBuildingnew(string bname) := 
	//sequential(
		//fileservices.startsuperfiletransaction(),
		if (fileservices.getsuperfilesubcount(bname + '_BUILDING') > 0,
			  Sequential(fileservices.clearsuperfile(bname + '_BUILDING'),
			  fileservices.addsuperfile(bname + '_BUILDING',bname,0,true)),
				fileservices.addsuperfile(bname + '_BUILDING',bname,0,true));//,
		//fileservices.finishsuperfiletransaction()
	//);