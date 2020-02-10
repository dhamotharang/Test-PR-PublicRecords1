import	NAC, lib_FileServices, lib_StringLib, lib_ThorLib, Ut;

// ------------------------------------------------------------------------------------------------
string		gLandingZoneServer		:=	NAC.Constants.LandingZoneServer				:	stored('LandingZoneServer');
string		gLandingZonePathBase	:=	NAC.Constants.LandingZonePathBase			:	stored('LandingZonePathBase');
string		gLandingZonePathIn		:=	gLandingZonePathBase + '/j1in'		:	stored('LandingZonePathIn');
string		gLandingZonePathDone	:=	gLandingZonePathIn + '/done';
string		gLandingZonePathOut		:=	gLandingZonePathBase + '/j1out'		:	stored('LandingZonePathOut');
string		gJ1FileMask						:=	'XX_J1A_*_*.dat'; 

string		fPreserveRemoteFilenameCase(string pRemoteFileName)	:=	regexreplace('([A-Z])',pRemoteFileName,'^\\1');
string		fRemoteFilenameAsThorName(string pRemoteFileName)		:=	'~file::' + gLandingZoneServer + regexreplace('/', gLandingZonePathIn + '/' + fPreserveRemoteFilenameCase(pRemoteFileName), '::');
string		fRemoteFilenameDoneSource(string pRemoteFileName)		:=	gLandingZonePathIn + '/' + pRemoteFileName;
string		fRemoteFilenameDoneTarget(string pRemoteFileName)		:=	gLandingZonePathDone + '/' + pRemoteFileName;
string		fThorOutFilename(string pRemoteFileName)						:=	'~nac::out::' + pRemoteFileName;

// ------------------------------------------------------------------------------------------------
					fMoveFileToDone(string pRemoteFileName)			:=	lib_FileServices.FileServices.MoveExternalFile(gLandingZoneServer, fRemoteFilenameDoneSource(pRemoteFileName), fRemoteFilenameDoneTarget(pRemoteFileName));
					fDesprayOutputToOut(string pRemoteFileName)	:=	lib_FileServices.FileServices.Despray(fThorOutFilename(pRemoteFileName), gLandingZoneServer, gLandingZonePathOut + '/' + pRemoteFileName);

// ------------------------------------------------------------------------------------------------
fOutputJ1Intermediate(string pRemoteFileName) :=
function
	rJ1A	:=
	record
		unsigned8		ID;
		string			Request{maxlength(100000)};
		string			Response{maxlength(500000)};
		string			RequestSource;
		string			Processed;
		string			CreateDateTime;
		string			UpdateDateTime;
	end;

	dJ1A	:=	dataset(fRemoteFilenameAsThorName(pRemoteFileName), rJ1A, csv(separator('\t'), quote([]), terminator('\r\n')));

	fDropOuterBraces(string pString)	:=	regexreplace('\\{(.*)\\}', pString, '\\1');
	fExtractStructure(string pStructure, string pString)	:=	regexfind('"' + pStructure + '":\\{([^\\}]+)\\}', pString, 1);

	string	fPair(string pTag, string pStructure)		:=	regexfind('("' + pTag + '" *: *("[^"]*"|[0-9]+|true|false|null))', pStructure, 1);
	string	fValue(string pTag, string pStructure)	:=	regexfind('"[^"]+" *: *"*([^"]*|[0-9]+|true|false|null)"*', fPair(pTag, pStructure), 1);

	rJ1A_SearchStructures	:=
	record
		rJ1A;
		string		Request_Options;
		string		Request_DrupalUser;
		string		Request_EndUser;
		string		Request_SearchBy;
		string		Request_Identity;
		string		Request_Address1;
		string		Request_Address2;
		string		Request_InvestigativeFields;
	end;

	rJ1A_SearchStructures	tJ1A_SearchStructures(dJ1A pInput)	:=
	transform
		string		lRequest								:=	pInput.Request;
		string		lAddress2								:=	fExtractStructure('Address2', lRequest);
		string		lRequest2								:=	lib_StringLib.StringLib.StringFindReplace(lRequest, '"Address2":{' + lAddress2 + '}', '');
		string		lAddress1								:=	fExtractStructure('Address1', lRequest2);
		string		lRequest3								:=	lib_StringLib.StringLib.StringFindReplace(lRequest2, '"Address1":{' + lAddress1 + '}', '');
		string		lIdentity								:=	fExtractStructure('Identity', lRequest3);
		string		lRequest4								:=	lib_StringLib.StringLib.StringFindReplace(lRequest3, '"Identity":{' + lIdentity + '}', '');
		string		lInvestigativeFields		:=	fExtractStructure('InvestigativeFields', lRequest4);
		string		lRequest5								:=	lib_StringLib.StringLib.StringFindReplace(lRequest4, '"InvestigativeFields":{' + lInvestigativeFields + '}', '');

		self.Request_Options							:=	fExtractStructure('Options', pInput.Request);
		self.Request_DrupalUser						:=	fExtractStructure('DrupalUser', pInput.Request);
		self.Request_EndUser							:=	fExtractStructure('EndUser', pInput.Request);
		self.Request_SearchBy							:=	fExtractStructure('SearchBy', lRequest5);
		self.Request_Identity							:=	lIdentity;
		self.Request_Address1							:=	lAddress1;
		self.Request_Address2							:=	lAddress2;
		self.Request_InvestigativeFields	:=	lInvestigativeFields;
		self.Request											:=	pInput.Request;
		self															:=	pInput;
	end;

	dJ1A_SearchStructures	:=	project(dJ1A, tJ1A_SearchStructures(left));

	rSearchOptions	:=
	record
		string1		InvestigativePurpose;
		string1		Include12MonthHistory;
	end;

	rSearchDrupalUser	:=
	record
		string1		ActivityType;
		string20	LoginId;
		string15	IP;
	end;

	rSearchEndUser	:=
	record
		string20	UserName;
		string15	IP;
	end;

	rSearchAddress	:=
	record
		string70		StreetAddress1;
		string70		StreetAddress2;
		string30		City;
		string2			State;
		string9			Zip;
	end;

	rSearchIdentity	:=
	record
		string20				CaseId;
		string20				ClientId;
		string60				FullName;
		string30				LastName;
		string25				FirstName;
		string25				MiddleName;
		string5					Suffix;
		string9					SSN;
		string8					DOB;
		string1					BenefitType;
		string6					BenefitMonth;
		rSearchAddress	Address1;
		rSearchAddress	Address2;
	end;

	rSearchInvestigativeFields	:=
	record
		string2			BenefitState;
		string6			BenefitMonthStart;
		string6			BenefitMonthEnd;
		string1			EligibilityStatus;
	end;

	rSearchBy	:=
	record
		string16										DrupalTransactionId;
		rSearchIdentity							Identity;
		rSearchInvestigativeFields	InvestigativeFields;
	end;

	rSearch	:=
	record
		rJ1A;
		rSearchOptions			Search_Options;
		rSearchDrupalUser		Search_DrupalUser;
		rSearchEndUser			Search_EndUser;
		rSearchBy						Search_SearchBy;
	end;

	rSearch		tSearch(dJ1A_SearchStructures pInput)	:=
	transform
		self.Search_Options.InvestigativePurpose									:=	fValue('InvestigativePurpose', pInput.Request_Options);
		self.Search_Options.Include12MonthHistory									:=	fValue('Include12MonthHistory', pInput.Request_Options);
		self.Search_DrupalUser.ActivityType												:=	fValue('ActivityType', pInput.Request_DrupalUser);
		self.Search_DrupalUser.LoginId														:=	fValue('LoginId', pInput.Request_DrupalUser);
		self.Search_DrupalUser.IP																	:=	fValue('IP', pInput.Request_DrupalUser);
		self.Search_EndUser.UserName															:=	fValue('UserName', pInput.Request_EndUser);
		self.Search_EndUser.IP																		:=	fValue('IP', pInput.Request_EndUser);
		self.Search_SearchBy.DrupalTransactionId									:=	fValue('DrupalTransactionId', pInput.Request_SearchBy);
		self.Search_SearchBy.Identity.CaseId											:=	fValue('CaseId', pInput.Request_Identity);
		self.Search_SearchBy.Identity.ClientId										:=	fValue('ClientId', pInput.Request_Identity);
		self.Search_SearchBy.Identity.FullName										:=	fValue('FullName', pInput.Request_Identity);
		self.Search_SearchBy.Identity.LastName										:=	fValue('LastName', pInput.Request_Identity);
		self.Search_SearchBy.Identity.FirstName										:=	fValue('FirstName', pInput.Request_Identity);
		self.Search_SearchBy.Identity.MiddleName									:=	fValue('MiddleName', pInput.Request_Identity);
		self.Search_SearchBy.Identity.Suffix											:=	fValue('Suffix', pInput.Request_Identity);
		self.Search_SearchBy.Identity.SSN													:=	fValue('SSN', pInput.Request_Identity);
		self.Search_SearchBy.Identity.DOB													:=	fValue('DOB', pInput.Request_Identity);
		self.Search_SearchBy.Identity.BenefitType									:=	fValue('BenefitType', pInput.Request_Identity);
		self.Search_SearchBy.Identity.BenefitMonth								:=	fValue('BenefitMonth', pInput.Request_Identity);
		self.Search_SearchBy.Identity.Address1.StreetAddress1			:=	fValue('StreetAddress1', pInput.Request_Address1);
		self.Search_SearchBy.Identity.Address1.StreetAddress2			:=	fValue('StreetAddress2', pInput.Request_Address1);
		self.Search_SearchBy.Identity.Address1.City								:=	fValue('City', pInput.Request_Address1);
		self.Search_SearchBy.Identity.Address1.State							:=	fValue('State', pInput.Request_Address1);
		self.Search_SearchBy.Identity.Address1.Zip								:=	fValue('Zip', pInput.Request_Address1);
		self.Search_SearchBy.Identity.Address2.StreetAddress1			:=	fValue('StreetAddress1', pInput.Request_Address2);
		self.Search_SearchBy.Identity.Address2.StreetAddress2			:=	fValue('StreetAddress2', pInput.Request_Address2);
		self.Search_SearchBy.Identity.Address2.City								:=	fValue('City', pInput.Request_Address2);
		self.Search_SearchBy.Identity.Address2.State							:=	fValue('State', pInput.Request_Address2);
		self.Search_SearchBy.Identity.Address2.Zip								:=	fValue('Zip', pInput.Request_Address2);
		self.Search_SearchBy.InvestigativeFields.BenefitState			:=	fValue('BenefitState', pInput.Request_InvestigativeFields);
		self.Search_SearchBy.InvestigativeFields.BenefitMonthStart:=	fValue('BenefitMonthStart', pInput.Request_InvestigativeFields);
		self.Search_SearchBy.InvestigativeFields.BenefitMonthEnd	:=	fValue('BenefitMonthEnd', pInput.Request_InvestigativeFields);
		self.Search_SearchBy.InvestigativeFields.EligibilityStatus:=	fValue('EligibilityStatus', pInput.Request_InvestigativeFields);
		self	:=	pInput;
	end;

	dSearch	:=	project(dJ1A_SearchStructures, tSearch(left));

	rSearch_ResponseNormalized	:=
	record
		rSearch;
		string		Response_Item;
		string		Response_Exceptions;
		string		Response_Header;
		string		Response_Record;
		string		Response_PhysicalAddress;
		string		Response_MailingAddress;
		string		Response_Case;
		string		Response_Client;
		string		Response_Contact;
		string		Response_Cleared;
	end;

	rSearch_ResponseNormalized	tSearch_ResponseNormalized(dSearch pInput, integer pCounter)	:=
	transform
		unsigned2	lRecordsCount						:=	max((unsigned2)regexfind('\\}\\,"RecordCount"\\:([0-9]+)\\,', pInput.Response, 1), 1);
		string		lResponse								:=	pInput.Response;
		string		lItem										:=	fExtractStructure('Item', lResponse);
		string		lResponse2							:=	lib_StringLib.StringLib.StringFindReplace(lResponse, '"Item":{' + lItem + '}', '');
		string		lExceptions							:=	fExtractStructure('Exceptions', lResponse2);
		string		lResponse3							:=	lib_StringLib.StringLib.StringFindReplace(lResponse2, '"Exceptions":{' + lExceptions + '}', '');
		string		lHeader									:=	fExtractStructure('Header', lResponse3);
		string		lResponse4							:=	lib_StringLib.StringLib.StringFindReplace(lResponse3, '"Header":{' + lHeader + '}', '');
		unsigned8	lRecordsStartPos				:=	if(lRecordsCount <> 0, lib_StringLib.StringLib.StringFind(lResponse4, '"Records":{"Record"', 1), 0);
		string		lFullRecords						:=	if(lRecordsStartPos <> 0, lResponse4[lRecordsStartPos..length(lResponse4)], '');
		unsigned8	lRecordStartPos					:=	lib_StringLib.StringLib.StringFind(lFullRecords, '{"NACRecord":{', pCounter);
		unsigned8	lRecordEndPos						:=	if(pCounter < lRecordsCount,
																						 lib_StringLib.StringLib.StringFind(lFullRecords, '{"NACRecord":{', pCounter + 1) - 2,
																						 lib_StringLib.StringLib.StringFind(lFullRecords, '"DrupalUserState":', 1) - if(lRecordsCount > 1, 4, 3)
																						);
		string		lThisRecordRough				:=	if(lRecordsCount <> 0,
																						 lFullRecords[lRecordStartPos..lRecordendPos],
																						 ''
																						);
		string		lContact								:=	fExtractStructure('Contact', lThisRecordRough);
		string		lRecord1								:=	lib_StringLib.StringLib.StringFindReplace(lThisRecordRough, '"Contact":{' + lContact + '}', '');
		string		lClient									:=	fExtractStructure('Client', lRecord1);
		string		lRecord2								:=	lib_StringLib.StringLib.StringFindReplace(lRecord1, '"Client":{' + lClient + '}', '');
		string		lPhysicalAddress				:=	fExtractStructure('PhysicalAddress', lRecord2);
		string		lRecord3								:=	lib_StringLib.StringLib.StringFindReplace(lRecord2, '"PhysicalAddress":{' + lPhysicalAddress + '}', '');
		string		lMailingAddress					:=	fExtractStructure('MailingAddress', lRecord3);
		string		lRecord4								:=	lib_StringLib.StringLib.StringFindReplace(lRecord3, '"MailingAddress":{' + lMailingAddress + '}', '');
		string		lCase										:=	fExtractStructure('Case', lRecord4);
		string		lRecord5								:=	lib_StringLib.StringLib.StringFindReplace(lRecord4, '"Case":{' + lCase + '}', '');

		self.Response_Contact							:=	lContact;
		self.Response_Client							:=	lClient;
		self.Response_PhysicalAddress			:=	lPhysicalAddress;
		self.Response_MailingAddress			:=	lMailingAddress;
		self.Response_Case								:=	lCase;
		self.Response_Item								:=	lItem;
		self.Response_Exceptions					:=	lExceptions;
		self.Response_Header							:=	lHeader;
		string		lResponse5							:=	if(lRecordsStartPos <> 0,
																						 lResponse4[1..lRecordsStartPos-1] + lResponse4[lib_StringLib.StringLib.StringFind(lResponse4, '"DrupalUserState":', 1)..length(lResponse4)],
																						 lResponse4
																						);
		self.Response_Record							:=	lRecord5;
		self.Response_Cleared							:=	lResponse5;
		self															:=	pInput;
	end;

	dSearch_ResponseNormalized	:=	normalize(dSearch, max((unsigned2)regexfind('\\}\\,"RecordCount"\\:([0-9]+)\\,', left.Response, 1), 1), tSearch_ResponseNormalized(left, counter));

	rResponseCase	:=
	record
		string2					State;
		string1					BenefitType;
		string6					BenefitMonth;
		string20				CaseId;
		string30				LastName;
		string25				FirstName;
		string25				MiddleName;
		string10				Phone1;
		string10				Phone2;
		string256				Email;
		rSearchAddress	PhysicalAddress;
		rSearchAddress	MailingAddress;
		string3					CountyParishCode;
		string25				CountyParishName;
	end;

	rResponseClient	:=
	record
		string20			ClientId;
		string30			LastName;
		string25			FirstName;
		string25			MiddleName;
		string1				Gender;
		string1				Race;
		string1				Ethnicity;
		string9				SSN;
		string1				SSNType;
		string8				DOB;
		string1				DOBType;
		string1				EligibilityStatus;
		string8				EligibilityStatusDate;
		string10			Phone;
		string256			Email;
	end;

	rResponseContact	:=
	record
		string50			Name;
		string10			Phone;
		string10			PhoneExtension;
		string256			Email;
	end;

	rNACRecord	:=
	record
		unsigned8					RecordCount;
		rResponseCase			ResponseCase;
		rResponseClient		ResponseClient;
		rResponseContact	ResponseContact;
	end;

	rExceptionsItem	:=
	record
		string4						Code;
		string20					Source;
		string20					Location;
		string70					Message;
	end;

	rResponseHeader	:=
	record
		string4						Status;
		string70					Message;
		string16					TransactionId;
		rExceptionsItem		ExceptionsItem;
	end;

	rResponse	:=
	record
		rResponseHeader		ResponseHeader;
		rNACRecord				NACRecord;
		string3						LexIdScore;
		string10					MatchCodes;
		string84					TwelveMonthHistory;
		string4						Sequencenumber;
		string2						RecordCount;
		string16					DrupalTransactionId;
		string2						DrupalUserState;
	end;

	rJ1_ForBatch	:=
	record
		string1			InvestigativePurpose;
		string1			IncludeTwelveMonthHistory;
		string1			ActivityType;
		string20		DrupalUserLoginId;
		string15		DrupalUserIP;
		string20		EndUserName;
		string15		EndUserIP;
		string16		DrupalTransactionId;
		string20		SearchCaseId;
		string20		SearchClientId;
		string60		SearchFullName;
		string30		SearchLastName;
		string25		SearchFirstName;
		string25		SearchMiddleName;
		string9			SearchSSN;
		string8			SearchDOB;
		string1			SearchBenefitType;
		string6			SearchBenefitMonth;
		string5			SearchSuffix;
		string70		SearchAddress1StreetAddress1;
		string70		SearchAddress1StreetAddress2;
		string30		SearchAddress1City;
		string2			SearchAddress1State;
		string9			SearchAddress1Zip;
		string70		SearchAddress2StreetAddress1;
		string70		SearchAddress2StreetAddress2;
		string30		SearchAddress2City;
		string2			SearchAddress2State;
		string9			SearchAddress2Zip;
		string2			SearchBenefitState;
		string6			SearchBenefitMonthStart;
		string6			SearchBenefitMonthEnd;
		string1			SearchEligibilityStatus;
		string2			CaseState;
		string1			CaseBenefitType;
		string6			CaseBenefitMonth;
		string20		CaseCaseId;
		string30		CaseLastName;
		string25		CaseFirstName;
		string25		CaseMiddleName;
		string10		CasePhone1;
		string10		CasePhone2;
		string256		CaseEmail;
		string70		CasePhysicalAddressStreetAddress1;
		string70		CasePhysicalAddressStreetAddress2;
		string30		CasePhysicalAddressCity;
		string2			CasePhysicalAddressState;
		string9			CasePhysicalAddressZip;
		string70		CaseMailingAddressStreetAddress1;
		string70		CaseMailingAddressStreetAddress2;
		string30		CaseMailingAddressCity;
		string2			CaseMailingAddressState;
		string9			CaseMailingAddressZip;
		string3			CaseCountyParishCode;
		string25		CaseCountyParishName;
		string20		ClientClientId;
		string30		ClientLastName;
		string25		ClientFirstName;
		string25		ClientMiddleName;
		string1			ClientGender;
		string1			ClientRace;
		string1			ClientEthnicity;
		string9			ClientSSN;
		string1			ClientSSNType;
		string8			ClientDOB;
		string1			ClientDOBType;
		string1			ClientEligibilityStatus;
		string8			ClientEligibilityStatusDate;
		string10		ClientPhone;
		string256		ClientEmail;
		string50		ContactName;
		string10		ContactPhone;
		string10		ContactPhoneExtension;
		string256		ContactEmail;
		string3			LexIdScore;
		string10		MatchCode;
		string84		TwelveMonthHistory;
		string4			SequenceNumber;
		string16		ESPTransactionId;
		string2			DrupalUserState;
		string4			QueryStatus;
		string70		QueryMessage;
		string12		ID;
		string10		RequestSource;
		string1			Processed;
		string23		CreateDateTime;
		string23		UpdateDateTime;
		string12		RecordCount;
		string2			CRLF;
	end;

	rJ1_PrepForBatch	:=
	record
		rSearch_ResponseNormalized;
		rJ1_ForBatch			J1_ForBatch;
	end;

	rJ1_PrepForBatch	tJ1_PrepForBatch(dSearch_ResponseNormalized pInput)	:=
	transform
		self.J1_ForBatch.ActivityType												:=	pInput.Search_DrupalUser.ActivityType;//fValue('ActivityType', pInput.Search_DrupalUser.ActivityType);
		self.J1_ForBatch.CaseBenefitMonth										:=	fValue('BenefitMonth', pInput.Response_Case);
		self.J1_ForBatch.CaseBenefitType										:=	fValue('BenefitType', pInput.Response_Case);
		self.J1_ForBatch.CaseCountyParishCode								:=	fValue('CountyParishCode', pInput.Response_Case);
		self.J1_ForBatch.CaseCountyParishName								:=	fValue('CountyParishName', pInput.Response_Case);
		self.J1_ForBatch.CaseEmail													:=	fValue('Email', pInput.Response_Case);
		self.J1_ForBatch.CaseFirstName											:=	fValue('FirstName', pInput.Response_Case);
		self.J1_ForBatch.CaseCaseId													:=	fValue('CaseId', pInput.Response_Case);
		self.J1_ForBatch.CaseLastName												:=	fValue('LastName', pInput.Response_Case);
		self.J1_ForBatch.CaseMailingAddressCity							:=	fValue('City', pInput.Response_MailingAddress);
		self.J1_ForBatch.CaseMailingAddressState						:=	fValue('State', pInput.Response_MailingAddress);
		self.J1_ForBatch.CaseMailingAddressStreetAddress1		:=	fValue('StreetAddress1', pInput.Response_MailingAddress);
		self.J1_ForBatch.CaseMailingAddressStreetAddress2		:=	fValue('StreetAddress2', pInput.Response_MailingAddress);
		self.J1_ForBatch.CaseMailingAddressZip							:=	fValue('Zip', pInput.Response_MailingAddress);
		self.J1_ForBatch.CaseMiddleName											:=	fValue('MiddleName', pInput.Response_Case);
		self.J1_ForBatch.CasePhone1													:=	fValue('Phone1', pInput.Response_Case);
		self.J1_ForBatch.CasePhone2													:=	fValue('Phone2', pInput.Response_Case);
		self.J1_ForBatch.CasePhysicalAddressCity						:=	fValue('City', pInput.Response_PhysicalAddress);
		self.J1_ForBatch.CasePhysicalAddressState						:=	fValue('State', pInput.Response_PhysicalAddress);
		self.J1_ForBatch.CasePhysicalAddressStreetAddress1	:=	fValue('StreetAddress1', pInput.Response_PhysicalAddress);
		self.J1_ForBatch.CasePhysicalAddressStreetAddress2	:=	fValue('StreetAddress2', pInput.Response_PhysicalAddress);
		self.J1_ForBatch.CasePhysicalAddressZip							:=	fValue('Zip', pInput.Response_PhysicalAddress);
		self.J1_ForBatch.CaseState													:=	fValue('State', pInput.Response_Case);
		self.J1_ForBatch.ClientDOB													:=	fValue('DOB', pInput.Response_Client);
		self.J1_ForBatch.ClientDOBType											:=	fValue('DOBType', pInput.Response_Client);
		self.J1_ForBatch.ClientEligibilityStatusDate				:=	fValue('EligibleStatusDate', pInput.Response_Client);
		self.J1_ForBatch.ClientEligibilityStatus						:=	fValue('EligibleIndicator', pInput.Response_Client);
		self.J1_ForBatch.ClientEmail												:=	fValue('Email', pInput.Response_Client);
		self.J1_ForBatch.ClientEthnicity										:=	fValue('Ethnicity', pInput.Response_Client);
		self.J1_ForBatch.ClientFirstName										:=	fValue('FirstName', pInput.Response_Client);
		self.J1_ForBatch.ClientGender												:=	fValue('Gender', pInput.Response_Client);
		self.J1_ForBatch.ClientClientId											:=	fValue('ClientId', pInput.Response_Client);
		self.J1_ForBatch.ClientLastName											:=	fValue('LastName', pInput.Response_Client);
		self.J1_ForBatch.ClientMiddleName										:=	fValue('MiddleName', pInput.Response_Client);
		self.J1_ForBatch.ClientPhone												:=	fValue('PhoneNumber', pInput.Response_Client);
		self.J1_ForBatch.ClientRace													:=	fValue('Race', pInput.Response_Client);
		self.J1_ForBatch.ClientSSN													:=	fValue('SSN', pInput.Response_Client);
		self.J1_ForBatch.ClientSSNType											:=	fValue('SSNType', pInput.Response_Client);

		self.J1_ForBatch.DrupalTransactionId								:=	fValue('DrupalTransactionId', pInput.Response_Cleared);
		self.J1_ForBatch.DrupalUserIP												:=	if(pInput.Search_DrupalUser.IP <> 'null', pInput.Search_DrupalUser.IP, '');
		self.J1_ForBatch.DrupalUserLoginId									:=	pInput.Search_DrupalUser.LoginId;
		self.J1_ForBatch.ESPTransactionId										:=	fValue('TransactionId', pInput.Response_Header) ;
		self.J1_ForBatch.EndUserIP													:=	if(pInput.Search_EndUser.IP <> 'null', pInput.Search_EndUser.IP, '');
		self.J1_ForBatch.EndUserName												:=	pInput.Search_EndUser.UserName;
		self.J1_ForBatch.IncludeTwelveMonthHistory					:=	pInput.Search_Options.Include12MonthHistory;
		self.J1_ForBatch.InvestigativePurpose								:=	pInput.Search_Options.InvestigativePurpose;
		self.J1_ForBatch.LexIdScore													:=	fValue('LexIdScore', pInput.Response_Record);
		self.J1_ForBatch.DrupalUserState										:=	fValue('DrupalUserState', pInput.Response_Cleared);
		self.J1_ForBatch.MatchCode													:=	fValue('MatchCode', pInput.Response_Record);
		self.J1_ForBatch.QueryStatus												:=	if(fValue('Status', pInput.Response_Header) <> '0', fValue('Status', pInput.Response_Header), fValue('Code', pInput.Response_Item));
		self.J1_ForBatch.QueryMessage												:=	if(fValue('Message', pInput.Response_Header) <> '', fValue('Message', pInput.Response_Header), fValue('Message', pInput.Response_Item));

		self.J1_ForBatch.SearchAddress1City									:=	pInput.Search_SearchBy.Identity.Address1.City;
		self.J1_ForBatch.SearchAddress1State								:=	pInput.Search_SearchBy.Identity.Address1.State;
		self.J1_ForBatch.SearchAddress1StreetAddress1				:=	pInput.Search_SearchBy.Identity.Address1.StreetAddress1;
		self.J1_ForBatch.SearchAddress1StreetAddress2				:=	pInput.Search_SearchBy.Identity.Address1.StreetAddress2;
		self.J1_ForBatch.SearchAddress1Zip									:=	pInput.Search_SearchBy.Identity.Address1.Zip;
		self.J1_ForBatch.SearchAddress2City									:=	pInput.Search_SearchBy.Identity.Address2.City;
		self.J1_ForBatch.SearchAddress2State								:=	pInput.Search_SearchBy.Identity.Address2.State;
		self.J1_ForBatch.SearchAddress2StreetAddress1				:=	pInput.Search_SearchBy.Identity.Address2.StreetAddress1;
		self.J1_ForBatch.SearchAddress2StreetAddress2				:=	pInput.Search_SearchBy.Identity.Address2.StreetAddress2;
		self.J1_ForBatch.SearchAddress2Zip									:=	pInput.Search_SearchBy.Identity.Address2.Zip;
		self.J1_ForBatch.SearchBenefitMonth									:=	pInput.Search_SearchBy.Identity.BenefitMonth;
		self.J1_ForBatch.SearchBenefitMonthEnd							:=	pInput.Search_SearchBy.InvestigativeFields.BenefitMonthEnd;
		self.J1_ForBatch.SearchBenefitMonthStart						:=	pInput.Search_SearchBy.InvestigativeFields.BenefitMonthStart;
		self.J1_ForBatch.SearchBenefitState									:=	pInput.Search_SearchBy.InvestigativeFields.BenefitState;
		self.J1_ForBatch.SearchBenefitType									:=	pInput.Search_SearchBy.Identity.BenefitType;
		self.J1_ForBatch.SearchCaseId												:=	pInput.Search_SearchBy.Identity.CaseId;
		self.J1_ForBatch.SearchClientId											:=	pInput.Search_SearchBy.Identity.ClientId;
		self.J1_ForBatch.SearchDOB													:=	pInput.Search_SearchBy.Identity.DOB;
		self.J1_ForBatch.SearchEligibilityStatus						:=	pInput.Search_SearchBy.InvestigativeFields.EligibilityStatus;
		self.J1_ForBatch.SearchFirstName										:=	pInput.Search_SearchBy.Identity.FirstName;
		self.J1_ForBatch.SearchFullName											:=	pInput.Search_SearchBy.Identity.FullName;
		self.J1_ForBatch.SearchLastName											:=	pInput.Search_SearchBy.Identity.LastName;
		self.J1_ForBatch.SearchMiddleName										:=	pInput.Search_SearchBy.Identity.MiddleName;
		self.J1_ForBatch.SearchSSN													:=	pInput.Search_SearchBy.Identity.SSN;
		self.J1_ForBatch.SearchSuffix												:=	pInput.Search_SearchBy.Identity.Suffix;

		self.J1_ForBatch.SequenceNumber											:=	fValue('SequenceNumber', pInput.Response_Record);
		self.J1_ForBatch.ContactEmail												:=	fValue('Email', pInput.Response_Contact);
		self.J1_ForBatch.ContactName												:=	fValue('Name', pInput.Response_Contact);
		self.J1_ForBatch.ContactPhone												:=	fValue('Phone', pInput.Response_Contact);
		self.J1_ForBatch.ContactPhoneExtension							:=	fValue('PhoneExtension', pInput.Response_Contact);
		self.J1_ForBatch.TwelveMonthHistory									:=	fValue('TwelveMonthHistory', pInput.Response_Record);

		self.J1_ForBatch.ID																	:=	intformat(pInput.ID, 12, 1);
		self.J1_ForBatch.RequestSource											:=	pInput.RequestSource;
		self.J1_ForBatch.Processed													:=	pInput.Processed;
		self.J1_ForBatch.CreateDateTime											:=	pInput.CreateDateTime;
		self.J1_ForBatch.UpdateDateTime											:=	pInput.UpdateDateTime;
		self.J1_ForBatch.RecordCount												:=	intformat((unsigned8)fValue('RecordCount', pInput.Response_Cleared), 12, 1);
		self.J1_ForBatch.CRLF																:=	'\r\n';

		self	:=	pInput;
	end;

	dJ1_PrepForBatch	:=	project(dSearch_ResponseNormalized, tJ1_PrepForBatch(left));

	rJ1_ForBatch	tJ1_ForBatch(dJ1_PrepForBatch pInput)	:=
	transform
		self	:=	pInput.J1_ForBatch;
	end;

	dJ1_ForBatch	:=	project(dJ1_PrepForBatch, tJ1_ForBatch(left));

	return	output(sort(dJ1_ForBatch, ESPTransactionID), , '~nac::out::' + regexreplace('_J1A_', pRemoteFileName, '_J1B_'), compressed);
end;

dJ1InFiles	:=	global(nothor(lib_FileServices.FileServices.RemoteDirectory(gLandingZoneServer, gLandingZonePathIn, gJ1FileMask)), few);

iff(exists(dJ1InFiles),
		sequential(
									fOutputJ1Intermediate(dJ1InFiles[1].Name),
									fDesprayOutputToOut(regexreplace('_J1A_', dJ1InFiles[1].Name, '_J1B_')),
									fMoveFileToDone(dJ1InFiles[1].Name)
								),
		output('No files to analyze as of ' + ut.GetTimeDate())
	 ) : when(cron('0-59/5 * * * *')), failure(lib_FileServices.FileServices.SendEmail('tony.kirk@lexisnexis.com', 'J1 Intermediate Failed', 'J1 Intermediate Failed'));
