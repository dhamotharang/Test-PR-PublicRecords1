import Std, iESP;
export	ESP_Logs_Helpers :=
module

	//////////////////////////////////////////////////////////////////
	shared	string	fChangeBackslashNToSpace(string pField, string pRequiredFailFieldname = '')	:=
	function
		boolean		lIsFieldNull	:=	pField = '\\N';
		boolean		lIsRequired		:=	pRequiredFailFieldname <> '';
		return		if(lIsFieldNull,
								 if(lIsRequired,
										fail(string, 'Missing ' + pRequiredFailFieldname),
										''
									 ),
								 pField
								);
	end;

	//////////////////////////////////////////////////////////////////
	shared	ESP_Logs_Layouts.TransactionLogFixed	tLogDelimitedToFixed(ESP_Logs_Layouts.TransactionLogDelimited pInput)	:=
	transform
// Until ESP logging is fixed to include ESP-direct MBS values
		boolean lIsEmptyLA01							:=	(pInput.UserID = 'hshahxml@nac' or pInput.UserID = 'hshahxml' or pInput.UserID = 'ladcfsxmlid@nac' or pInput.UserID = 'ladcfsxmlid')
																			and (fChangeBackslashNToSpace(pInput.SourceState) = '' or fChangeBackslashNToSpace(pInput.ProgramsAllowedSearch) = '' or fChangeBackslashNToSpace(pInput.ProgramsAllowedReturn) = '' or fChangeBackslashNToSpace(pInput.NACGroupID) = '');
		self.TransactionID								:=	fChangeBackslashNToSpace(pInput.TransactionID, 'ESP TransactionID');
		self.DateAdded										:=	fChangeBackslashNToSpace(pInput.DateAdded, 'DateAdded');
		self.UserID												:=	fChangeBackslashNToSpace(pInput.UserID, 'Missing UserID');
		self.UserIP												:=	fChangeBackslashNToSpace(pInput.UserIP, 'Missing UserIP');
		self.SearchSSN										:=	fChangeBackslashNToSpace(pInput.SearchSSN);
		self.SearchDOB										:=	fChangeBackslashNToSpace(pInput.SearchDOB);
		self.SearchProgramCode						:=	Std.Str.ToUpperCase(fChangeBackslashNToSpace(pInput.SearchProgramCode));
		self.SearchEligibilityRangeType		:=	Std.Str.ToUpperCase(fChangeBackslashNToSpace(pInput.SearchEligibilityRangeType));
		self.SearchEligibilityStart				:=	fChangeBackslashNToSpace(pInput.SearchEligibilityStart);
		self.SearchEligibilityEnd					:=	fChangeBackslashNToSpace(pInput.SearchEligibilityEnd);
		self.SearchCaseID									:=	fChangeBackslashNToSpace(pInput.SearchCaseID);
		self.SearchClientID								:=	fChangeBackslashNToSpace(pInput.SearchClientID);
		self.SearchProgramState						:=	fChangeBackslashNToSpace(pInput.SearchProgramState);
		self.SearchEligibilityStatus			:=	fChangeBackslashNToSpace(pInput.SearchEligibilityStatus);
		// Options -----------------------------------
		self.InvestigativePurpose					:=	fChangeBackslashNToSpace(pInput.InvestigativePurpose, 'InvestigativePurpose') = '1';
		self.IncludeEligibilityHistory		:=	fChangeBackslashNToSpace(pInput.IncludeEligibilityHistory) = '1';
		self.IncludeInterstateAll					:=	fChangeBackslashNToSpace(pInput.IncludeInterstateAll, 'Missing IncludeInterstateAll') = '1';
		// Internal ----------------------------------
		self.IsOnline											:=	fChangeBackslashNToSpace(pInput.IsOnline) = '1';
		// Set from MBS ------------------------------
		#warning('Removed some values from fail list, perhaps should be returned');
// Until ESP logging is fixed to include ESP-direct MBS values
		self.SourceState									:=	if(lIsEmptyLA01, 'LA', fChangeBackslashNToSpace(pInput.SourceState));//, 'Missing SourceState');
// Until ESP logging is fixed to include ESP-direct MBS values
		self.ProgramsAllowedSearch				:=	if(lIsEmptyLA01, '11000000000000000000', fChangeBackslashNToSpace(pInput.ProgramsAllowedSearch));//, 'Missing ProgramsAllowedSearch');
// Until ESP logging is fixed to include ESP-direct MBS values
		self.ProgramsAllowedReturn				:=	if(lIsEmptyLA01, '11000000000000000000', fChangeBackslashNToSpace(pInput.ProgramsAllowedReturn));//, 'Missing ProgramsAllowedReturn');
// Until ESP logging is fixed to include ESP-direct MBS values
		self.NACGroupID										:=	if(lIsEmptyLA01, 'LA01', fChangeBackslashNToSpace(pInput.NACGroupID));//, 'Missing NACGroupID');
		// End user ----------------------------------
		self.EndUserLoginID								:=	fChangeBackslashNToSpace(pInput.EndUserLoginID);
		self.EndUserIP										:=	fChangeBackslashNToSpace(pInput.EndUserIP);
		self.EndUserUserName							:=	fChangeBackslashNToSpace(pInput.EndUserUserName);
		// ESP stuff ---------------------------------
		self.ResponseTime									:=	(decimal5_2)fChangeBackslashNToSpace(pInput.ResponseTime, 'Missing ResponseTime');
		self.ReferenceCode								:=	fChangeBackslashNToSpace(pInput.ReferenceCode);
		self._LogicalFileName							:=	pInput._LogicalFileName;
	end;
	export	fTransactionLogFixed(dataset(ESP_Logs_Layouts.TransactionLogDelimited) pLogDelimited)	:=	project(pLogDelimited, tLogDelimitedToFixed(left));

	//////////////////////////////////////////////////////////////////
	ESP_Logs_Layouts.TransactionLogOnlineParsed	tLogXMLParsed(ESP_Logs_Layouts.TransactionLogOnlineRaw pInput)	:=
	transform
		self.NAC2SearchRequest	:=	fromxml(ESP_Logs_Layouts.t_NAC2SearchRequest, Std.Str.FindReplace(pInput.RequestBlob, '<NonSubjectSuppression>0</NonSubjectSuppression><NonSubjectSuppression>0</NonSubjectSuppression>', '<NonSubjectSuppression>0</NonSubjectSuppression>'));
		self.NAC2SearchResponse	:=	fromxml(ESP_Logs_Layouts.t_NAC2SearchResponseEx, pInput.ResponseBlob);
		self										:=	pInput;
	end;
	export	fTransactionLogOnlineParsed(dataset(ESP_Logs_Layouts.TransactionLogOnlineRaw) pLogOnlineRaw)	:=	project(pLogOnlineRaw, tLogXMLParsed(left));

	//////////////////////////////////////////////////////////////////
	ESP_Logs_Layouts.TransactionLogsCombined	tLogsCombined(ESP_Logs_Layouts.TransactionLogFixed pLogFixed, ESP_Logs_Layouts.TransactionLogOnlineParsed pLogOnlineParsed)	:=
	transform
		boolean lIsEmptyLA01	:=	(pLogFixed.UserID = 'hshahxml@nac' or pLogFixed.UserID = 'hshahxml' or pLogFixed.UserID = 'ladcfsxmlid@nac' or pLogFixed.UserID = 'ladcfsxmlid')
													and (pLogOnlineParsed.NAC2SearchRequest.SearchBy._SourceState = '' or pLogOnlineParsed.NAC2SearchRequest.SearchBy._ProgramsAllowedSearch = '' or pLogOnlineParsed.NAC2SearchRequest.SearchBy._ProgramsAllowedReturned = '' or pLogOnlineParsed.NAC2SearchRequest.SearchBy._NACGroupID = '');
		self.LogOnlineParsed.NAC2SearchRequest.SearchBy._SourceState 							:= if(lIsEmptyLA01, pLogFixed.SourceState, pLogOnlineParsed.NAC2SearchRequest.SearchBy._SourceState);
		self.LogOnlineParsed.NAC2SearchRequest.SearchBy._ProgramsAllowedSearch		:= if(lIsEmptyLA01, pLogFixed.ProgramsAllowedSearch, pLogOnlineParsed.NAC2SearchRequest.SearchBy._ProgramsAllowedSearch);
		self.LogOnlineParsed.NAC2SearchRequest.SearchBy._ProgramsAllowedReturned	:= if(lIsEmptyLA01, pLogFixed.ProgramsAllowedReturn, pLogOnlineParsed.NAC2SearchRequest.SearchBy._ProgramsAllowedReturned);
		self.LogOnlineParsed.NAC2SearchRequest.SearchBy._NACGroupID 							:= if(lIsEmptyLA01, pLogFixed.NACGroupID, pLogOnlineParsed.NAC2SearchRequest.SearchBy._NACGroupID);
		self.LogFixed					:=	pLogFixed;
		self.LogOnlineParsed	:=	pLogOnlineParsed;
	end;
	export	fLogsCombined(dataset(ESP_Logs_Layouts.TransactionLogFixed) pLogFixed, dataset(ESP_Logs_Layouts.TransactionLogOnlineParsed) pLogOnlineParsed)	:=
												join(pLogFixed, pLogOnlineParsed,
														 left.TransactionID = right.TransactionID,
														 tLogsCombined(left, right)
														);

	//////////////////////////////////////////////////////////////////
	export	fTransactionLogsCombinedFiltered(dataset(ESP_Logs_Layouts.TransactionLogsCombined) pLogsCombined,
																					 boolean pExcludeLNGroups = true,
																					 boolean pExcludeInvestigative = true,
																					 boolean pExcludeBlankGroups = true,
																					 boolean pExcludeProdDataTestMode = true,
																					 boolean pExcludeTestDataEnabled = true
																					)	:=
	function
		dExcludeLNGroups			:=	if(pExcludeLNGroups, 
																 pLogsCombined(Std.Str.ToUpperCase(LogFixed.NACGroupID[1..2]) <> 'LN'),
																 pLogsCombined
																);
		dExcludeInvestigative	:=	if(pExcludeInvestigative,
																 dExcludeLNGroups(not LogFixed.InvestigativePurpose),
																 dExcludeLNGroups
																);
		dExcludeBlankGroups		:=	if(pExcludeBlankGroups,
																 dExcludeInvestigative(LogFixed.NACGroupID <> ''),
																 dExcludeInvestigative
																);
		dExcludeProdDataTestMode	:=	if(pExcludeProdDataTestMode,
																		 dExcludeBlankGroups(not LogOnlineParsed.NAC2SearchRequest.Options._ProdDataTestMode),
																		 dExcludeBlankGroups
																		);
		dExcludeTestDataEnabled	:=	if(pExcludeTestDataEnabled,
																	 dExcludeProdDataTestMode(not LogOnlineParsed.NAC2SearchRequest.User._TestDataEnabled),
																	 dExcludeProdDataTestMode
																	);
		return	dExcludeTestDataEnabled;
	end;
		
end;
