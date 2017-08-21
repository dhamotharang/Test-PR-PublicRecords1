export Function_CombineCityStateZip(string pCity, string pState, string pZip5, string pZip4) :=
	trim(pCity,left,right) +
    if((trim(pState,left,right)!='' OR trim(pZip5,left,right)!='') AND trim(pCity,left,right)!='',', ','') +
	trim(pState) +
	if(trim(pZip5,left,right)!='',' ','') +
	trim(pZip5) +
	if((integer)pZip4<>0,'-'+trim(pZip4),'');