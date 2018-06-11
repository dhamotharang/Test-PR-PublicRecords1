EXPORT fGetTitle(string TitleIn)	:= function
setValidTitle:=['MR','MS'];
return		map(	TitleIn in setValidTitle => TitleIn,'');
END;
