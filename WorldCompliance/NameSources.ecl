EXPORT	NameSources := MODULE

rSourceInfo := RECORD
	string		source;			// identifier
	set of string		NameSources;	// World Compliance name source
	integer		listId;			// Accuity list id
	unicode		name;				// list name
	string		guid;			// list guid
	unicode		desc;	//description
END;

EXPORT dsNameSources := DATASET([
// total build
{'ALL',[],0,'WorldCompliance - Full','1DE1ECFB-13EE-4263-903F-73D3193E5CB4',
'Full WorldCompliance data set'},
// standard builds
{'AM',[],0,'WorldCompliance - Adverse Media','6AB3729F-36FD-475E-8F83-487C05B7B51F',
'WorldCompliance profiles sourced from open-source news media about persons or companies that may pose a regulatory, commercial or reputation risk'},
{'ENF',[],0,'WorldCompliance - Enforcement','6FE2FD16-7B0C-4801-85F6-780C53B22AD9',
'WorldCompliance coverage of warnings and enforcements from around the world'},
{'EDD',[],0,'WorldCompliance - Expanded Due Diligence','D92E87BF-B610-469D-B780-A3E828074269',
'WorldCompliance coverage of global Persons and their associates and/or family members'},
{'SOE',[],0,'WorldCompliance - State Owned Entities','BF607088-EDBB-427E-8ACB-6EBE195AFBD7',
'WorldCompliance profiles about government owned companies or organizations and their officials'},
{'PEP',[],0,'WorldCompliance - Politically Exposed Persons','90A1422B-0367-4687-8D2D-558625C8A438',
'WorldCompliance coverage of global Politically Exposed Persons (PEPs) and their associates and/or family members'},
{'SAE',[],0,'WorldCompliance - Sanctions and Enforcements','A3315680-5313-45A2-AD86-7C72CE2882E3',
'WorldCompliance coverage of sanctions, warnings, law enforcement and other lists from around the world'},
{'SAN',[],0,'WorldCompliance - Sanctions','A1B4E186-B386-4E09-BC95-DCF91651D654',
'WorldCompliance coverage of sanctions from around the world'},
{'CNT',[],0,'WorldCompliance - Countries','08B8D210-ECD4-49D9-8B41-9380AAB618BC',
'Includes Countries from all WorldCompliance Categories that need additional due diligence'},
{'REG',[],0,'WorldCompliance - Registrations','1C0C4602-9835-4E45-B398-D21858CF43C7',
U'US IRS FATCA – Foreign Financial Institutions; Marijuana Registered Businesses (MRB); IHS (FATF High-Risk Country) Vessels; US Money Services Businesses (MSBs); UAE Money Services Businesses (MSBs)'},

// accuity replacements
{'BCW',['CBOB'],1074,'Central Bank of Bahamas Cumulative Warnings','21DE3441-F3DD-401F-A046-7EF662422BB9',
'Individuals and companies that may be operating in breach of the Banks and Trust Companies Regulations Act, 2000, or other laws of the Bahamas'},
{'BEL',['EUList'],1008,'Belgium Financial Sector Federation','6E9526E7-A4D0-4AF3-8E47-A017273590F5',
'Entities in the French EU Official Journal regulations and  decisions posted by the Service Public Federal des Finances'},
{'CBI',['IN-CBI'],1054,'CBI India','BEFB7F8F-2002-4C1E-A3F9-9020951D5785',
'Entities in the Central Bureau of Investigation Wanted List and Interpol Red Notices reposted by CBI'},
{'CSL',['CA-SPMEBU','CA-SPMEIR','CA-SPMEZW','CA-SEM','CA-SYRIA','UN-SC-1518'],1080,'Canada DFAIT Economic UN Sanctions','B556567B-3D37-470E-8FB6-51F01141E200',
'Entities subject to Canadian Economic Sanctions implemented under the UN Act, SEMA, and FACFOA'},
{'CSSF',['Lux-CSSF'],1114,'Luxembourg CSSF','B53DD88F-CCD2-482F-B91F-1B26CE8F39F2',
'Individuals and companies not granted authorization to offer financial services in Luxembourg or other areas'},
{'CWL',['OSFI'],32,'OSFI Cumulative Warnings','19740E5A-C374-4783-BBBE-D4B4799DF48E',
'Banks and companies not authorized to operate as banks in Canada by the OSFI'},
{'DB',['DE-BUNDESB'],1088,'Germany Federal Bank','664EC531-0D58-41E3-889F-9249CE66D4A7',
'Entities designated under UN, EU, and German national sanctions'},
{'DNB',['NL-DNB'],1090,'Netherlands Bank','9A7C935C-7FB2-4E5D-9EAB-397905D59305',
'Individuals, companies, and organizations sanctioned by the Dutch government for supporting terrorism'},
{'ECO',['UK BIS'],1144,'UK Export Control Organisation-Iran','922E16C8-EB37-4AB3-843D-5D21752A6D46',
'Entities and organizations in Iran that present a potential concern on WMD End-Use Control grounds, based on previous licensing decisions'},
{'ES',['EUList'],1014,'Spain Ministry of Finance and Administration','0DD1F6D8-37DF-4DF4-B6C3-DC58698A909B',
'Entities sanctioned under EU regulations implemented by Spain\'s Ministerio de Economia'},
{'ESE',['EG-FSA'],1158,'Egypt Financial Supervisory Authority','8710DD38-83AB-4965-BDCC-2A805D732124',
'Persons, groups, and entities subject to an assets freeze'},
{'FMU',['UA-SFMS'],1126,'Ukraine Financial Monitoring','5B409771-F615-49D0-80E2-418AC07A1F5E',
'Entities related to terrorist activity or persons subject to international sanctions derived from UN'},
{'FR',['FR-MINEFE'],1010,'France Ministry of Economy','42954D03-BB16-49CE-84AB-262C59DC5670',
'Entities subject to French national and EU financial sanctions as posted in the French EU Official Journal'},
{'IND',['IN-MHA'],1048,'India Ministry of Home Affairs','7FDD87E4-CEDF-41A2-8196-C1D6F814BCF9',
'Organizations declared as terrorists under the Unlawful Activities (Prevention) Act, 1967. Recommend scanning in conjunction with UN list.'},
{'ISA',['US-ISA'],1164,'Iran Sanctions Act','5064F825-1DC9-4895-8217-B257EDD31072',
'Companies sanctioned under the Iran Sanction Act, as amended by the Comprehensive Iran Sanctions, Accountability, and Divestment Act'},
{'ITL',['IL-MODTL'],1078,'Israel Ministry of Defense Terrorists','25CCA6DA-7E23-48F7-B000-C15FDA653B2C',
'Entities declared unlawful by the Ministry of Defense and subject to seizure of funds. Recommend scanning in conjunction with UN list.'},
{'MEX',['MX-CNBV'],1038,'Mexico Administrative Sanctions','6667BE28-3C62-407B-88A3-48A960D435A0',
'Entities, companies, and individuals who have violated Mexico\'s securities and investments laws'},
{'MFR',['MU-MAUFSC'],1068,'Mauritius FSC Revocations','FDE39736-0521-4A9D-8E33-BFCC49AEECD2',
'Businesses with revoked licenses due to involvement in illegal, dishonorable, and improper practices, market abuse, or financial fraud'},
{'NZ',['NZ-POLICE'],1140,'New Zealand Police','A86F5033-10F9-4BB4-A777-B68DF4B5A479',
'Companies, individuals, and organizations designated by the New Zealand Police under the Terrorism Suppression Act. Recommend scanning in conjunction with UN list.'},
{'RPL',['ROSFINMON'],1176,'Russian Rosfinmonitoring Public','80DCAF0A-466B-4783-967D-3BB7C27B146C',
'Organizations and individuals the Russian Federation government recognizes as involved in terrorism or related activities. Recommend scanning in conjunction with UN list.'},
{'SAP',['ZA-SAPS'],1056,'South Africa Police','78EB65FC-BDD4-4599-A2E2-AC2BC1804878',
'All individuals listed on the South African Police Wanted Persons list'},
{'SAR',['SaudInfo'],1032,'Saudi Arabia Most Wanted','0AE318D8-D530-4088-9478-8225CF6B38A3',
'Individuals listed on the Saudi Arabia Wanted Terrorists lists issued by the Ministry of Interior'},
{'SECO',['SECO'],42,'Switzerland SECO','75DFF111-309D-4613-BE9C-9ED39FD725C1',
'Entities sanctioned SECO and Swiss Confederation and derived from the EU and UN lists'},
{'UK',['UK-PROTER', 'UK-HOME'],1046,'UK Home Office','E7B08E71-FC3B-4180-AEC8-89BADF913545',
'Terrorist groups and organizations banned under UK law'},
{'USM',['US Marsh'],45,'US Marshals','5FBFAB06-9E20-4C01-B8EC-0DF7AD62F8C6','15 Most Wanted fugitives by the US Marshals'}
],rSourceInfo);

shared dictName := DICTIONARY(dsNameSources, {source => name});
export CodeToName(string code) := dictName[code].name;

shared dictGuid := DICTIONARY(dsNameSources, {source => guid});
export CodeToGuid(string code) := dictGuid[code].guid;

shared dictDesc := DICTIONARY(dsNameSources, {source => desc});
export CodeToDesc(string code) := dictDesc[code].desc;

shared dictSources := DICTIONARY(dsNameSources, {source => NameSources});
export CodeToSources(string code) := dictSources[code].NameSources;


END;