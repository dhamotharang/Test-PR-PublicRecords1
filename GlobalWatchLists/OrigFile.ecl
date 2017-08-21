import	address,ut;

dEntityRecordID	:=	Globalwatchlists.Generate_RecordID;

Globalwatchlists.Layouts.Temp.EntityMain	tMain(dEntityRecordID	pInput)	:=
transform
	// Remove unprintable characters
	string	vCleanLname 		:=	regexreplace('[^ -~]+',(string)pInput.lastname,'');
	string	vCleanFname 		:=	regexreplace('[^ -~]+',(string)pInput.firstname,'');
	string	vCleanMname 		:=	regexreplace('[^ -~]+',(string)pInput.middlename,'');
	string	vCleanFullname	:=	regexreplace('[^ -~]+',(string)pInput.fullname,'');
	
	string73	vCleanName		:=	map(	GlobalWatchLists.Functions.ustrClean2Upper(pInput.nametype)	=	'INDIVIDUAL'	and	vCleanLname	<>	''	and	vCleanFname	<>	''	and	vCleanMname			<>	''	=>	address.CleanPersonLFM73(vCleanLname	+	' '	+	vCleanFname	+	' '	+	vCleanMname),
																		GlobalWatchLists.Functions.ustrClean2Upper(pInput.nametype)	=	'INDIVIDUAL'	and	vCleanLname	<>	''	and	vCleanFname	<>	''	and vCleanMname			=		''	=>	address.CleanPersonLFM73(vCleanLname	+	' '	+	vCleanFname),
																		GlobalWatchLists.Functions.ustrClean2Upper(pInput.nametype)	=	'INDIVIDUAL'	and	vCleanLname	=		''	and	vCleanFname	=		''	and	vCleanFullname	<>	''	=>	address.CleanPersonFML73(vCleanFullname),
																		''
																	);
	
	string	vTitle					:=	GlobalWatchLists.Functions.ustrClean(pInput.title);
	string	vComments2Upper	:=	GlobalWatchLists.Functions.ustrClean2Upper(pInput.comments);
	string	vCleanComments	:=	GlobalWatchLists.Functions.ustrClean(pInput.comments);
	
	self.NameType				:=	GlobalWatchLists.Functions.ustrClean2Upper(pInput.NameType);
	self.WatchListName	:=	GlobalWatchLists.Functions.ustrClean2Upper(pInput.WatchListName);
	self.WatchListDate	:=	GlobalWatchLists.Functions.ustrClean2Upper(pInput.WatchListDate);
	self.Gender					:=	GlobalWatchLists.Functions.ustrClean2Upper(pInput.Gender);
	self.DateListed			:=	GlobalWatchLists.Functions.ustrClean2Upper(pInput.DateListed);
	self.AddedBy				:=	GlobalWatchLists.Functions.ustrClean2Upper(pInput.AddedBy);
	self.ReferenceID		:=	GlobalWatchLists.Functions.ustrClean2Upper(pInput.ReferenceID);
	self.Generation			:=	(string)pInput.Generation;
	self.ReasonListed		:=	(string)pInput.ReasonListed;
	
	self.title_1				:=	map(	regexfind('Vice Senior General; Vice-Chairman of the State Peace and Development Council; Deputy Commander-in-Chief,Myanmar Defense Services (Tatmadaw); Commander-in-Chief,Myanmar Army',vTitle,nocase)													=>	regexreplace('Vice Senior General; Vice-Chairman of the State Peace and Development Council; Deputy Commander-in-Chief,Myanmar Defense Services (Tatmadaw); Commander-in-Chief,Myanmar Army',vTitle,'Vice Sr. General;Vice-Chairman of the St. Peace & Dev. Council;Dpty Cmdr-in-Chief,Myanmar Defense Services (Tatmadaw);Cmdr-in-Chief,Myanmar Army',nocase),
																regexfind('Brigadier General,Commanding Officer of the Iranian Islamic Revolutionary Guard Corps-Qods Force Ramazan Corps; Deputy Commander of the Ramazan Headquarters; Chief of Staff of the Iraq Crisis Staff',vTitle,nocase)	=>	regexreplace('Brigadier General,Commanding Officer of the Iranian Islamic Revolutionary Guard Corps-Qods Force Ramazan Corps; Deputy Commander of the Ramazan Headquarters; Chief of Staff of the Iraq Crisis Staff',vTitle,'Brigadier Gen,Cmdg Officer of Iranian Islamic Revolutionary Guard Corps-Qods Force Ramazan Corps;Dpty Cmdr of Ramazan HQ;Chief of Staff of Iraq Crisis',nocase),
																(string)pInput.title
															);
	self.first_name			:=	(string)pInput.firstname;
	self.middle_name		:=	(string)pInput.middlename;
	self.last_name			:=	(string)pInput.lastname;
	self.fullname				:=	(string)pInput.fullname;
	
	self.title2      		:=	vCleanName[1..5];
	self.fname       		:=	vCleanName[6..25];
	self.mname       		:=	vCleanName[26..45];
	self.lname       		:=	vCleanName[46..65];
	self.name_suffix 		:=	vCleanName[66..70];
	self.name_score  		:=	vCleanName[71..73];
	self.pname_clean 		:=	vCleanName;
	self.cname 					:=	if(	GlobalWatchLists.Functions.ustrClean2Upper(pInput.nametype) = 'BUSINESS',
															(string)pInput.fullname,
															''
														);
	self.giv_designator	:=	case(	GlobalWatchLists.Functions.ustrClean2Upper(pInput.nametype),
																'INDIVIDUAL'	=>	'I',
																'BUSINESS'		=>	'G',
																'VESSEL'			=>	'V',
																''
															);
	self.AddrComments		:=	if(	pInput.recordid[1..3]	=	'BES'	and	StringLib.StringFind(vComments2Upper,'OTHER INFORMATION:',1)	<>	0,
															GlobalWatchLists.Functions.strClean(regexreplace('OTHER INFORMATION:',vCleanComments[StringLib.StringFind(vComments2Upper,'OTHER INFORMATION:',1)	+	StringLib.StringFind(vComments2Upper,'|',2)],'',nocase)),
															''
														);
	self.Comments				:=	(string)pInput.Comments;
	self								:=	pInput;
end;

dEntityCleanName	:=	project(dEntityRecordID,tMain(left));

export	OrigFile	:=	dEntityCleanName; 