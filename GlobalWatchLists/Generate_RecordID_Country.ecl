import	patriot;

dCountry	:=	Globalwatchlists.File_GlobalWatchLists_V4.In.Country;

GlobalWatchLists.Layouts.Temp.CountryRecordID	tAppendRecordID(dCountry	pInput,integer	cnt)	:=
transform
	self.ListID		:=	MAP(	regexfind(u'FATF FINANCIAL ACTION TASK FORCE',pInput.WatchListName,nocase)									=> Patriot.Constants.wlFATF,
													regexfind(u'OFAC SANCTIONS',pInput.WatchListName,nocase)																		=> Patriot.Constants.wlOSC,  
													regexfind(u'OFFSHORE FINANCIAL CENTERS',pInput.WatchListName,nocase)												=> Patriot.Constants.wlOFFC,
													regexfind(u'OSFI COUNTRY',pInput.WatchListName,nocase)																			=> Patriot.Constants.wlOSFIC,
													regexfind(u'PRIMARY MONEY LAUNDERING CONCERN - JURISDICTIONS',pInput.WatchListName,nocase)	=> Patriot.Constants.wlPMLJ,				
													GlobalWatchLists.Functions.ustrClean2Upper(trim((string)pInput.WatchListName,all))[1..3]
												);
	self.RecordID	:=		GlobalWatchLists.Functions.strClean2Upper(self.ListID)
										+	hash32(regexreplace(u'!|@|#|$|%|-|\'|~',GlobalWatchLists.Functions.unicodeClean2Upper(pInput.countryName),''))
										+	'-'
										+	(string)(cnt%10000);
	self					:=	pInput;
end;

dAppendRecordID	:=	project(dCountry,tAppendRecordID(left,counter))	:	persist('~thor_200::persist::globalwatchlists::country_recordid');

export	Generate_RecordID_Country	:= 	dAppendRecordID;