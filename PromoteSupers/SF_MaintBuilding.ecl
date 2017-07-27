export SF_MaintBuilding(string bname) := 
	//sequential(
		//fileservices.startsuperfiletransaction(),
		if (fileservices.getsuperfilesubcount(bname + '_BUILDING') > 0,
			  output('Nothing added to ' + bname + '_BUILDING Superfile'),
			  fileservices.addsuperfile(bname + '_BUILDING',bname,0,true));//,
		//fileservices.finishsuperfiletransaction()
	//);