import	patriot,ut;

dEntity	:=	distribute(Globalwatchlists.File_GlobalWatchLists_V4.In.Entity,random());

GlobalWatchLists.Layouts.Temp.EntityRecordID	tAppendRecID(dEntity	pInput,integer	cnt)	:=
transform
	string	vListID :=	MAP(	unicodelib.unicodefind(GlobalWatchLists.Functions.unicodeClean2Upper(pInput.WatchlistName),'AUSTRALIA DEPT OF FOREIGN AFFAIRS AND TRADE',1)			<>	0	=>	Patriot.Constants.wlADFA,
														unicodelib.unicodefind(GlobalWatchLists.Functions.unicodeClean2Upper(pInput.WatchlistName),'BANK OF ENGLAND CONSOLIDATED LIST',1)								<>	0 =>	Patriot.Constants.wlBES,
														unicodelib.unicodefind(GlobalWatchLists.Functions.unicodeClean2Upper(pInput.WatchlistName),'BUREAU OF INDUSTRY AND SECURITY',1)									<>	0 =>	Patriot.Constants.wlBIS,
														unicodelib.unicodefind(GlobalWatchLists.Functions.unicodeClean2Upper(pInput.WatchlistName),'CHIEF OF STATE AND FOREIGN CABINET MEMBERS',1)			<>	0 =>	Patriot.Constants.wlPEP,
														unicodelib.unicodefind(GlobalWatchLists.Functions.unicodeClean2Upper(pInput.WatchlistName),'CHIEFS OF STATE AND FOREIGN CABINET MEMBERS',1)			<>	0 =>	Patriot.Constants.wlPEP, 
														unicodelib.unicodefind(GlobalWatchLists.Functions.unicodeClean2Upper(pInput.WatchlistName),'COMMODITY FUTURES TRADING COMMISSION SANCTIONS',1)	<>	0 =>	Patriot.Constants.wlCFTC,
														unicodelib.unicodefind(GlobalWatchLists.Functions.unicodeClean2Upper(pInput.WatchlistName),'DTC DEBARRED PARTIES',1)														<>	0 =>	Patriot.Constants.wlDTC,
														unicodelib.unicodefind(GlobalWatchLists.Functions.unicodeClean2Upper(pInput.WatchlistName),'EPLS',1)																						<>	0 =>	Patriot.Constants.wlEPLS,
														unicodelib.unicodefind(GlobalWatchLists.Functions.unicodeClean2Upper(pInput.WatchlistName),'EU CONSOLIDATED LIST',1)														<>	0	=>	Patriot.Constants.wlEUDT,
														unicodelib.unicodefind(GlobalWatchLists.Functions.unicodeClean2Upper(pInput.WatchlistName),'FATF FINANCIAL TASK FORCE',1)												<>	0 =>	Patriot.Constants.wlFATF,
														unicodelib.unicodefind(GlobalWatchLists.Functions.unicodeClean2Upper(pInput.WatchlistName),'FBI HIJACK SUSPECTS',1)															<>	0	=>	Patriot.Constants.wlFBIH,
														unicodelib.unicodefind(GlobalWatchLists.Functions.unicodeClean2Upper(pInput.WatchlistName),'FBI MOST WANTED',1)																	<>	0 =>	Patriot.Constants.wlFBIW,
														unicodelib.unicodefind(GlobalWatchLists.Functions.unicodeClean2Upper(pInput.WatchlistName),'FBI MOST WANTED TERRORISTS',1)											<>	0 =>	Patriot.Constants.wlFBIT,
														unicodelib.unicodefind(GlobalWatchLists.Functions.unicodeClean2Upper(pInput.WatchlistName),'FBI SEEKING INFORMATION',1)													<>	0 =>	Patriot.Constants.wlFBIS,
														unicodelib.unicodefind(GlobalWatchLists.Functions.unicodeClean2Upper(pInput.WatchlistName),'FBI TOP TEN MOST WANTED',1)													<>	0 =>	Patriot.Constants.wlFBIM,
														unicodelib.unicodefind(GlobalWatchLists.Functions.unicodeClean2Upper(pInput.WatchlistName),'FOREIGN AGENT REGISTRATIONS' ,1)										<>	0 =>	Patriot.Constants.wlFAR,
														unicodelib.unicodefind(GlobalWatchLists.Functions.unicodeClean2Upper(pInput.WatchlistName),'FOREIGN AGENTS REGISTRATIONS',1)										<>	0 =>	Patriot.Constants.wlFAR,
														unicodelib.unicodefind(GlobalWatchLists.Functions.unicodeClean2Upper(pInput.WatchlistName),'HM TREASURY INVESTMENT BAN LIST',1)									<>	0 =>	Patriot.Constants.wlHMTB,
														unicodelib.unicodefind(GlobalWatchLists.Functions.unicodeClean2Upper(pInput.WatchlistName),'HM TREASURY SANCTIONS',1)														<>	0 =>	Patriot.Constants.wlHMTS,
														unicodelib.unicodefind(GlobalWatchLists.Functions.unicodeClean2Upper(pInput.WatchlistName),'HONG KONG MONETARY AUTHORITY',1)										<>	0 =>	Patriot.Constants.wlHKMA,
														unicodelib.unicodefind(GlobalWatchLists.Functions.unicodeClean2Upper(pInput.WatchlistName),'HUD LDP',1)																					<>	0	=>	Patriot.Constants.wlHLDP,
														unicodelib.unicodefind(GlobalWatchLists.Functions.unicodeClean2Upper(pInput.WatchlistName),'INTERPOL MOST WANTED',1)														<>	0 =>	Patriot.Constants.wlIMW,
														unicodelib.unicodefind(GlobalWatchLists.Functions.unicodeClean2Upper(pInput.WatchlistName),'IRELAND FINANCIAL REGULATOR UNAUTHORIZED FIRMS',1)	<>	0 =>	Patriot.Constants.wlIFUF,
														unicodelib.unicodefind(GlobalWatchLists.Functions.unicodeClean2Upper(pInput.WatchlistName),'JAPAN FSA',1)																				<>	0 =>	Patriot.Constants.wlJFSA,
														unicodelib.unicodefind(GlobalWatchLists.Functions.unicodeClean2Upper(pInput.WatchlistName),'JAPAN MOF SANCTIONS',1)															<>	0 =>	Patriot.Constants.wlJMOF,
														unicodelib.unicodefind(GlobalWatchLists.Functions.unicodeClean2Upper(pInput.WatchlistName),'JAPAN METI-WMD PROLIFERATORS',1)										<>	0 =>	Patriot.Constants.wlJWMD,
														unicodelib.unicodefind(GlobalWatchLists.Functions.unicodeClean2Upper(pInput.WatchlistName),'MONETARY AUTHORITY OF SINGAPORE',1)									<>	0 =>	Patriot.Constants.wlMASI,
														unicodelib.unicodefind(GlobalWatchLists.Functions.unicodeClean2Upper(pInput.WatchlistName),'NONPROLIFERATION SANCTIONS',1)											<>	0 =>	Patriot.Constants.wlNPRS,
														unicodelib.unicodefind(GlobalWatchLists.Functions.unicodeClean2Upper(pInput.WatchlistName),'OFAC NON-SDN ENTITIES',1)														<>	0 =>	Patriot.Constants.wlOFAC,
														unicodelib.unicodefind(GlobalWatchLists.Functions.unicodeClean2Upper(pInput.WatchlistName),'OFAC SANCTIONS',1)																	<>	0 =>	Patriot.Constants.wlOSC,
														unicodelib.unicodefind(GlobalWatchLists.Functions.unicodeClean2Upper(pInput.WatchlistName),'OFAC SDN',1)																				<>	0 =>	Patriot.Constants.wlOFAC,
														unicodelib.unicodefind(GlobalWatchLists.Functions.unicodeClean2Upper(pInput.WatchlistName),'OFFSHORE FINANCIAL CENTERS',1)											<>	0	=>	Patriot.Constants.wlOFFC,
														unicodelib.unicodefind(GlobalWatchLists.Functions.unicodeClean2Upper(pInput.WatchlistName),'OIG EXCLUSIONS',1)																	<>	0 =>	Patriot.Constants.wlOIGE,
														unicodelib.unicodefind(GlobalWatchLists.Functions.unicodeClean2Upper(pInput.WatchlistName),'OSFI CONSOLIDATED LIST',1)													<>	0 =>	Patriot.Constants.wlOSFIL,
														unicodelib.unicodefind(GlobalWatchLists.Functions.unicodeClean2Upper(pInput.WatchlistName),'OSFI COUNTRY',1)																		<>	0 =>	Patriot.Constants.wlOSFIC,
														unicodelib.unicodefind(GlobalWatchLists.Functions.unicodeClean2Upper(pInput.WatchlistName),'PEOPLES BANK OF CHINA',1)														<>	0 =>	Patriot.Constants.wlPBC,
														unicodelib.unicodefind(GlobalWatchLists.Functions.unicodeClean2Upper(pInput.WatchlistName),'PRIMARY MONEY LAUNDERING CONCERN',1)								<>	0 =>	Patriot.Constants.wlPMLC,
														unicodelib.unicodefind(GlobalWatchLists.Functions.unicodeClean2Upper(pInput.WatchlistName),'PRIMARY MONEY LAUNDERING CONCERN - JURIS',1)				<>	0 =>	Patriot.Constants.wlPMLJ,
														unicodelib.unicodefind(GlobalWatchLists.Functions.unicodeClean2Upper(pInput.WatchlistName),'REGISTERED MONEY SERVICES BUSINESSES',1)						<>	0 =>	Patriot.Constants.wlRMSB,
														unicodelib.unicodefind(GlobalWatchLists.Functions.unicodeClean2Upper(pInput.WatchlistName),'RESERVE BANK OF AUSTRALIA',1)												<>	0 =>	Patriot.Constants.wlRBAU,						
														unicodelib.unicodefind(GlobalWatchLists.Functions.unicodeClean2Upper(pInput.WatchlistName),'TERRORIST EXCLUSION LIST',1)												<>	0 =>	Patriot.Constants.wlSDT,
														unicodelib.unicodefind(GlobalWatchLists.Functions.unicodeClean2Upper(pInput.WatchlistName),'UK FSA',1)																					<>	0 =>	Patriot.Constants.wlUKFSA,
														unicodelib.unicodefind(GlobalWatchLists.Functions.unicodeClean2Upper(pInput.WatchlistName),'UN CONSOLIDATED LIST',1)														<>	0	=>	Patriot.Constants.wlUNNT,
														unicodelib.unicodefind(GlobalWatchLists.Functions.unicodeClean2Upper(pInput.WatchlistName),'UNAUTHORIZED BANKS',1)															<>	0 =>	Patriot.Constants.wlOCC,
														unicodelib.unicodefind(GlobalWatchLists.Functions.unicodeClean2Upper(pInput.WatchlistName),'WORLD BANK INELIGIBLE FIRMS',1)											<>	0	=>	Patriot.Constants.wlWBIF,
														trim(GlobalWatchLists.Functions.ustrClean2Upper(pInput.WatchlistName),all)[1..3]
													);
	self.ListID		:=	ut.fnTrim2Upper(vListID);
	self.RecordID	:=		ut.fnTrim2Upper(vListID)
										+	hash32(regexreplace(u'!|@|#|$|%|-|\'|~',GlobalWatchLists.Functions.unicodeClean2Upper(pInput.FullName),''))
										+	'-'
										+	(string)(cnt%10000);
	self 					:=  pInput;
end;

dEntityRecordID			:=	project(dEntity,tAppendRecID(left,counter));
dEntityRecordIDSort	:=	sort(dEntityRecordID,WatchlistName,FullName,Comments,-DateListed)	:	persist('~thor_200::persist::globalwatchlists::recordid');

export	Generate_RecordID	:=	dEntityRecordIDSort;