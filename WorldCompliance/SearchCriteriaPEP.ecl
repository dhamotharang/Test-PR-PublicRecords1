EXPORT SearchCriteriaPEP := MODULE

/*Search Criteria Top Level	group id
Country	1
Regional Level	2
PEP Sub Category	3
*/


// PEP Sub Category
export dsPepSubcategories := DATASET([
{'No Value or N/A',	99},
{'Arms Trafficking',	3},
{'Associate',	5},
{'Attorney',	6},
{'Bank Fraud',	7},
{'Bribery',	8},
{'Burglary',	9},
{'Conspiracy',	10},
{'Corruption',	11},
{'Counterfeiting',	12},
{'Courts',	13},
{'Debarred',	15},
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
{'Fugitive',	30},
{'Gambling Operations',	31},
{'Govt Branch Member',	32},
{'Healthcare Fraud',	33},
{'Honorary Consul',	34},
{'Insider Trading',	37},
{'Interstate Commerce',	38},
{'Investigation',	39},
{'Kidnapping',	40},
{'Mgmt Govt Corp',	42},
{'Military',	43},
{'Money Laundering',	44},
{'Most Wanted',	46},
{'Murder',	47},
{'Organized Crime',	49},
{'Peonage',	50},
{'Pharma Trafficking',	51},
{'Political Candidate',	53},
{'Pornography',	55},
{'RICO',	58},
{'Senior Party Member',	60},
{'Stolen Property',	62},
{'Tax Evasion',	63},
{'Terrorism',	64},
{'Unauthorized',	65},
{'Union leadership',	66},
{'War Crimes',	67}
],rCriteria);

export GetSearchCriteria := 
		MakeGroupHeader(SORT(dsCountryCodes,name), 1, 'Country')
		+MakeGroupHeader(dsRegion, 2, 'Regional Level')
		+MakeGroupHeader(dsPepSubcategories, 3, 'PEP Sub Category')
		+MakeGroupHeader(dsDeceased, 4, 'Deceased State');


END;