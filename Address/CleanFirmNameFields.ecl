EXPORT CleanFirmNameFields(string390 pName) :=
module

	export string120 firmname1				:=	pName[1..120];
	export string120 firmname2				:=	pName[121..240];


	export string5  title1				:=	pName[241..245];
	export string20 fname1				:=	pName[246..265];
	export string20 mname1				:=	pName[266..285];
	export string20 lname1				:=	pName[286..305];
	export string5  name_suffix1	:=	pName[306..310];

	export string5  title2				:=	pName[311..315];
	export string20 fname2				:=	pName[316..335];
	export string20 mname2				:=	pName[336..355];
	export string20 lname2				:=	pName[356..375];
	export string5  name_suffix2	:=	pName[376..380];

	export string390 full_name		:=	pName;
	
	export CleanNameRecord := dataset([
		
		{
			 firmname1
			,firmname2
			,title1
			,fname1
			,mname1
			,lname1
			,name_suffix1
			,''
			,title2
			,fname2
			,mname2
			,lname2
			,name_suffix2
			,''
		}
	], {string120 firmname1, string120 firmname2, Address.Layout_clean_Name name1, Address.Layout_clean_Name name2})[1];


end;