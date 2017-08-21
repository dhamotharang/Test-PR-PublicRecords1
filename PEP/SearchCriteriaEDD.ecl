EXPORT SearchCriteriaEDD := MODULE

/*Search Criteria Top Level	group id
Country	1
Regional Level	2
Adverse Media	3
Associated Entity	4
Company of Interest	5
End-Use Controls	6
Enforcement	7
Excluded Party	8
Government Corp	9
Govt Linked Corp	10
Influential Person	11
Investigation	12
Sanction List	13
*/

//Adverse Media	
export dsAdverseMedia := DATASET([
{'No Value or N/A',	99},
{'Aircraft Hijacking',	1},
{'AntiTrust violations',	2},
{'Arms Trafficking',	3},
{'Asset Freeze',	4},
{'Associate',	5},
{'Attorney',	6},
{'Bank Fraud',	7},
{'Bribery',	8},
{'Burglary',	9},
{'Conspiracy',	10},
{'Corruption',	11},
{'Counterfeiting',	12},
{'Crime Agnst Humanity',	14},
{'Debarred',	15},
{'Diplomat',	16},
{'Disciplined',	17},
{'Disqualified',	18},
{'Drug Trafficking',	19},
{'Embezzlement',	20},
{'Environmental Crimes',	21},
{'Espionage',	22},
{'Explosives',	23},
{'Extort-Rack-Threats',	24},
{'Family Member',	25},
{'Financial Crimes',	26},
{'Forgery',	27},
{'Former PEP',	28},
{'Fraud',	29},
{'Fugitive',	30},
{'Gambling Operations',	31},
{'Govt Branch Member',	32},
{'Healthcare Fraud',	33},
{'Human Rights Abuse',	35},
{'Human Trafficking',	36},
{'Insider Trading',	37},
{'Interstate Commerce',	38},
{'Investigation',	39},
{'Kidnapping',	40},
{'Labor Violations',	41},
{'Mgmt Govt Corp',	42},
{'Money Laundering',	44},
{'Mortgage Fraud',	45},
{'Most Wanted',	46},
{'Murder',	47},
{'Organized Crime',	49},
{'Peonage',	50},
{'Pharma Trafficking',	51},
{'Piracy',	52},
{'Political Candidate',	53},
{'Pollution',	54},
{'Pornography',	55},
{'Price Manipulation',	56},
{'RICO',	58},
{'Securities Fraud',	59},
{'Senior Party Member',	60},
{'Smuggling',	61},
{'Stolen Property',	62},
{'Tax Evasion',	63},
{'Terrorism',	64},
{'Unauthorized',	65},
{'War Crimes',	67},
{'WMD',	68}
],rCriteria);

//Associated Entity	
export dsAssociatedEntity := DATASET([
{'No Value or N/A',	99},
{'Arms Trafficking',	3},
{'Associate',	5},
{'Attorney',	6},
{'Bribery',	8},
{'Debarred',	15},
{'Drug Trafficking',	19},
{'Embezzlement',	20},
{'Espionage',	22},
{'Family Member',	25},
{'Former PEP',	28},
{'Fraud',	29},
{'Govt Branch Member',	32},
{'Human Trafficking',	36},
{'Interstate Commerce',	38},
{'Investigation',	39},
{'Mgmt Govt Corp',	42},
{'Money Laundering',	44},
{'Most Wanted',	46},
{'Murder',	47},
{'Securities Fraud',	59},
{'Terrorism',	64},
{'Unauthorized',	65}
],rCriteria);

//Company of Interest	
export dsCompanyofInterest := DATASET([
{'No Value or N/A',	99},
{'Associate',	5},
{'Drug Trafficking',	19},
{'Fraud',	29},
{'Investigation',	39},
{'Terrorism',	64},
{'Unauthorized',	65}
],rCriteria);

//End-Use Controls	
export dsEndUseControls := DATASET([
{'No Value or N/A',	99},
{'Bribery',	8},
{'Disqualified',	18},
{'Drug Trafficking',	19},
{'Embezzlement',	20},
{'Family Member',	25},
{'Investigation',	39},
{'Most Wanted',	46},
{'Organized Crime',	49},
{'RICO',	58},
{'Unauthorized',	65}
],rCriteria);

//Enforcement	
export dsEnforcement := DATASET([
{'No Value or N/A',	99},
{'Aircraft Hijacking',	1},
{'AntiTrust violations',	2},
{'Arms Trafficking',	3},
{'Asset Freeze',	4},
{'Associate',	5},
{'Bank Fraud',	7},
{'Bribery',	8},
{'Burglary',	9},
{'Conspiracy',	10},
{'Corruption',	11},
{'Counterfeiting',	12},
{'Courts',	13},
{'Crime Agnst Humanity',	14},
{'Debarred',	15},
{'Diplomat',	16},
{'Disciplined',	17},
{'Disqualified',	18},
{'Drug Trafficking',	19},
{'Embezzlement',	20},
{'Environmental Crimes',	21},
{'Espionage',	22},
{'Explosives',	23},
{'Extort-Rack-Threats',	24},
{'Family Member',	25},
{'Financial Crimes',	26},
{'Forgery',	27},
{'Former PEP',	28},
{'Fraud',	29},
{'Fugitive',	30},
{'Gambling Operations',	31},
{'Govt Branch Member',	32},
{'Healthcare Fraud',	33},
{'Human Rights Abuse',	35},
{'Human Trafficking',	36},
{'Insider Trading',	37},
{'Interstate Commerce',	38},
{'Investigation',	39},
{'Kidnapping',	40},
{'Labor Violations',	41},
{'Mgmt Govt Corp',	42},
{'Money Laundering',	44},
{'Mortgage Fraud',	45},
{'Most Wanted',	46},
{'Murder',	47},
{'Organized Crime',	49},
{'Peonage',	50},
{'Pharma Trafficking',	51},
{'Piracy',	52},
{'Political Candidate',	53},
{'Pollution',	54},
{'Pornography',	55},
{'Price Manipulation',	56},
{'Proscribed',	57},
{'RICO',	58},
{'Securities Fraud',	59},
{'Smuggling',	61},
{'Stolen Property',	62},
{'Tax Evasion',	63},
{'Terrorism',	64},
{'Unauthorized',	65},
{'War Crimes',	67},
{'WMD',	68}
],rCriteria);

//Excluded Party	
export dsExcludedParty := DATASET([
{'No Value or N/A',	99},
{'Arms Trafficking',	3},
{'Bank Fraud',	7},
{'Bribery',	8},
{'Burglary',	9},
{'Conspiracy',	10},
{'Corruption',	11},
{'Debarred',	15},
{'Disqualified',	18},
{'Drug Trafficking',	19},
{'Embezzlement',	20},
{'Environmental Crimes',	21},
{'Extort-Rack-Threats',	24},
{'Fraud',	29},
{'Healthcare Fraud',	33},
{'Human Trafficking',	36},
{'Money Laundering',	44},
{'Mortgage Fraud',	45},
{'Most Wanted',	46},
{'Murder',	47},
{'N/A',	48},
{'Organized Crime',	49},
{'RICO',	58},
{'Securities Fraud',	59},
{'Smuggling',	61},
{'Stolen Property',	62},
{'Tax Evasion',	63},
{'Terrorism',	64},
{'Unauthorized',	65},
{'WMD',	68}
],rCriteria);

//Government Corp	
export dsGovernmentCorp := DATASET([
{'No Value or N/A',	99},
{'Associate',	5},
{'Bribery',	8},
{'Diplomat',	16},
{'Family Member',	25},
{'Fraud',	29},
{'Gambling Operations',	31},
{'Govt Branch Member',	32},
{'Insider Trading',	37},
{'Investigation',	39},
{'Mgmt Govt Corp',	42},
{'Money Laundering',	44},
{'N/A',	48},
{'Political Candidate',	53},
{'Unauthorized',	65},
{'WMD',	68}
],rCriteria);

//Govt Linked Corp	
export dsGovtLinkedCorp := DATASET([
{'No Value or N/A',	99},
{'Diplomat',	16},
{'Mgmt Govt Corp',	42},
{'Unauthorized',	65}
],rCriteria);

//Influential Person	
export dsInfluentialPerson := DATASET([
{'No Value or N/A',	99},
{'Arms Trafficking',	3},
{'Associate',	5},
{'Diplomat',	16},
{'Drug Trafficking',	19},
{'Embezzlement',	20},
{'Extort-Rack-Threats',	24},
{'Family Member',	25},
{'Former PEP',	28},
{'Fraud',	29},
{'Govt Branch Member',	32},
{'Insider Trading',	37},
{'Investigation',	39},
{'Mgmt Govt Corp',	42},
{'Money Laundering',	44},
{'Most Wanted',	46},
{'Murder',	47},
{'Senior Party Member',	60}
],rCriteria);

//Investigation	
export dsInvestigation := DATASET([
{'No Value or N/A',	99},
{'Arms Trafficking',	3},
{'Associate',	5},
{'Bank Fraud',	7},
{'Bribery',	8},
{'Burglary',	9},
{'Conspiracy',	10},
{'Corruption',	11},
{'Courts',	13},
{'Diplomat',	16},
{'Disqualified',	18},
{'Drug Trafficking',	19},
{'Embezzlement',	20},
{'Environmental Crimes',	21},
{'Espionage',	22},
{'Explosives',	23},
{'Extort-Rack-Threats',	24},
{'Family Member',	25},
{'Financial Crimes',	26},
{'Forgery',	27},
{'Former PEP',	28},
{'Fraud',	29},
{'Gambling Operations',	31},
{'Govt Branch Member',	32},
{'Healthcare Fraud',	33},
{'Human Trafficking',	36},
{'Insider Trading',	37},
{'Investigation',	39},
{'Kidnapping',	40},
{'Mgmt Govt Corp',	42},
{'Money Laundering',	44},
{'Most Wanted',	46},
{'Murder',	47},
{'Organized Crime',	49},
{'Piracy',	52},
{'Political Candidate',	53},
{'Pornography',	55},
{'Price Manipulation',	56},
{'RICO',	58},
{'Securities Fraud',	59},
{'Senior Party Member',	60},
{'Smuggling',	61},
{'Stolen Property',	62},
{'Tax Evasion',	63},
{'Terrorism',	64},
{'Unauthorized',	65},
{'War Crimes',	67}
],rCriteria);

//Sanction List	
export dsSanctionList := DATASET([
{'No Value or N/A',	99},
{'Drug Trafficking',	19},
{'Family Member',	25},
{'Fraud',	29},
{'Money Laundering',	44},
{'Most Wanted',	46},
{'Murder',	47},
{'Organized Crime',	49},
{'Terrorism',	64}
],rCriteria);

export GetSearchCriteria := 
		MakeGroupHeader(CountryCodes.dsCountryValues, 1, 'Country')
		+MakeGroupHeader(dsRegion, 2, 'Regional Level')
		+MakeGroupHeader(dsAdverseMedia, 3, 'Adverse Media')
		+MakeGroupHeader(dsAssociatedEntity, 4, 'Associated Entity')
		+MakeGroupHeader(dsCompanyofInterest, 5, 'Company of Interest')
		+MakeGroupHeader(dsEndUseControls, 6, 'End-Use Controls')
		+MakeGroupHeader(dsEnforcement, 7, 'Enforcement')
		+MakeGroupHeader(dsExcludedParty, 8, 'Excluded Party')
		+MakeGroupHeader(dsGovernmentCorp, 9, 'Government Corp')
		+MakeGroupHeader(dsGovtLinkedCorp, 10, 'Govt Linked Corp')
		+MakeGroupHeader(dsInfluentialPerson, 11, 'Influential Person')
		+MakeGroupHeader(dsInvestigation, 12, 'Investigation')
		+MakeGroupHeader(dsSanctionList, 13, 'Sanction List');

END;