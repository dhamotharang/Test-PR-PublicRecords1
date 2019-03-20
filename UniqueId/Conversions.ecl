﻿IMPORT STD;
EXPORT Conversions := MODULE

export string SourceCodeToName(string ListName) := 
					TRIM(ListName, LEFT, RIGHT);

export string SourceCodetoDescr(string ListName) := CASE(STD.Str.ToUpperCase(ListName),
'AUSTRALIA DEPT OF FOREIGN AFFAIRS AND TRADE' =>	'Australia enacted a charter in response to a UN Resolution following the 11 Sep 2001 terrorist attacks on the United States. Australia\'s charter includes entities listed in the UN Consolidated list, plus unique entities designated by Australia\'s Minister for Foreign Affairs. The Consolidated List of entities is maintained by Australia\'s Department of Foreign Affairs and Trade (DFAT), which is active in Asia-Pacific and other world-wide efforts to counter terrorism. Australia passed legislation that makes it a criminal offense to deal with entities on this list.',
'BANK OF ENGLAND CONSOLIDATED LIST'	 => 'The HM Treasury (formerly known as Bank of England) is the central bank of the United Kingdom. The Bank works to ensure that the UK financial system provides effective support to the rest of the UK economy. In doing so, the HM Treasury provides a consolidated list of targets that have been listed by the UN, EU and UK under legislation relating to Al-Qaida &amp; Taliban, Burma/Myanmar, Ivory Coast, Democratic Republic of the Congo, Federal Republic of Yugoslavia &amp; Serbia, Iraq, Terrorism and Zimbabwe. The list also includes the Financial Sanctions, Ukraine (Sovereignty and Territorial Integrity), which identifies restrictive measures (not subject to asset freeze) in view of Russia\'s actions destabilizing the situation in Ukraine.',
'BUREAU OF INDUSTRY AND SECURITY'  =>	'The Bureau of Industry and Security (BIS) administers export controls on dual-use items. BIS also coordinates Commerce Department homeland security activities, leads the federal government\'s outreach to the private sector regarding critical infrastructure protection and cyber security, and assists U.S. industry in complying with the Chemical Weapons Convention and other international arms agreements. BIS publishes and maintains watchlists of businesses to use in verifying that transactions are not being conducted with, or on-behalf of denied or suspect parties, including the Denied Persons list, the Entity list, and the Unverified List.',
'CHIEFS OF STATE AND FOREIGN CABINET MEMBERS' =>'The Chiefs of State and Foreign Cabinet Members list comes from the similarly-titled CIA publication, Chiefs of State and Cabinet Members of Foreign Governments. The list includes current and some past political figures. However, family members and close associates are not included, since they are not part of the CIA document. The government does not publish a consolidated list of PEPs or of senior foreign political figures (SFPFs) as defined in Section 312 of the USA PATRIOT Act.',
'COMMODITY FUTURES TRADING COMMISSION SANCTIONS' =>	'The CFTC regulates commodity futures and option markets in the United States. LexisNexis\' CFTC list contains the disciplinary records for entities that have violated CTFC rules or broken laws. The disciplinary history available includes Reparations Sanctions in Effect (from 1984) and Administrative Sanctions in Effect.',
'DTC DEBARRED PARTIES' =>	'Control of arms sales to foreign parties is an integral part of the U.S. ability to safeguard national security and further foreign policy objectives. The Defense Trade Controls (DTC) office controls the export and temporary import of defense articles and defense services covered by the United States Munitions List. The DTC handles matters relating to defense trade compliance and enforcement, including applications for licenses to export defense articles and services.  The DTC publishes a list of entities barred from trade transactions because they are believed to have been acting in a way detrimental to United States global security interests.',
'EPLS' =>	'The EPLS is a list that identifies those parties excluded from receiving federal contracts, certain subcontracts, and certain types of federal financial and non-financial assistance and benefits.',
'EU CONSOLIDATED LIST' =>	'A consolidated list of entities subject to European Union (EU) financial sanctions was developed and is maintained for the European Commission by the European Banking Federation, the European Savings Banks Groups, the European Association of Co-operative Banks, and the European Association of Public Banks. All persons and entities doing business in the EU, including non-EU citizens and businesses established in the EU but doing business outside the EU, are required to freeze all funds and economic resources of entities on the list, and are prohibited from making funds or economic resources available.',
'FBI HIJACK SUSPECTS' =>	'The Federal Bureau of Investigations releases watchlists for public use: Most Wanted, Top Ten Most Wanted, Seeking Information, Most Wanted Terrorists, and Hijacking Suspects from September 11, 2001. Companies are advised to contact their district FBI office for compliance requirements and follow-up.',
'FBI MOST WANTED' =>	'The Federal Bureau of Investigations releases watchlists for public use: Most Wanted, Top Ten Most Wanted, Seeking Information, Most Wanted Terrorists, and Hijacking Suspects from September 11, 2001. Companies are advised to contact their district FBI office for compliance requirements and follow-up.',
'FBI MOST WANTED TERRORISTS' =>	'The Federal Bureau of Investigations releases watchlists for public use: Most Wanted, Top Ten Most Wanted, Seeking Information, Most Wanted Terrorists, and Hijacking Suspects from September 11, 2001. Companies are advised to contact their district FBI office for compliance requirements and follow-up.',
'FBI SEEKING INFORMATION' =>	'The Federal Bureau of Investigations releases watchlists for public use: Most Wanted, Top Ten Most Wanted, Seeking Information, Most Wanted Terrorists, and Hijacking Suspects from September 11, 2001. Companies are advised to contact their district FBI office for compliance requirements and follow-up.',
'FBI TOP TEN MOST WANTED' =>	'The Federal Bureau of Investigations releases watchlists for public use: Most Wanted, Top Ten Most Wanted, Seeking Information, Most Wanted Terrorists, and Hijacking Suspects from September 11, 2001. Companies are advised to contact their district FBI office for compliance requirements and follow-up.',
'FINANCIAL SANCTIONS' =>	'Firms and individuals that have been sanctioned or have been recipients of disciplinary action from a variety of organizations providing oversight of financial activities.',
'FOREIGN AGENTS REGISTRATIONS' =>	'The Foreign Agents Registration Act (FARA) requires entities to register with the Department of Justice when they act on behalf of foreign governments to influence United States\' policy and laws. LexisNexis\' Foreign Agents Registrations list contains currently registered Active Registrants and Foreign Principals.',
'HM TREASURY INVESTMENT BAN LIST' => 'The Bank of England is the central bank of the United Kingdom. The Bank works to ensure that the UK financial system provides effective support to the rest of the UK economy. In doing so, the Bank of England provides a consolidated list of targets that have been listed by the UN, EU and UK under legislation relating to Al-Qaida &amp; Taliban, Burma/Myanmar, Cote d\'Ivoire, Democratic Republic of the Congo, Federal Republic of Yugoslavia &amp; Serbia, Iraq, Terrorism and Zimbabwe.',
'HONG KONG MONETARY AUTHORITY' =>	'Banks subject to the authority of Hong Kong Monetary Authority (HKMA) should check the names on this list against their records and report any transactions or relationships you have or have had with the named individuals or entities to the Hong Kong Joint Financial Intelligence Unit and the HKMA.',
'HUD LDP' =>	'Limited Denial of Participation, HUD Funding Disqualifications',
'INTERPOL MOST WANTED' =>	'Interpol exists to help create a safer world. Their goal is to provide a unique range of essential services for the law enforcement community to optimize the international effort to combat crime. Interpol maintains a small proportion of their \'Most Wanted Fugitives\' list for public dissemination.',
'IRELAND FINANCIAL REGULATOR UNAUTHORIZED FIRMS' =>	'The Financial Regulator in Ireland publishes warning notices for firms that operate as investment firms that have not been properly authorized to operate within Ireland as such a business. These notices are used to make the LexisNexis watchlist.',
'JAPAN FSA' =>	'LexisNexis\' watchlist contains entities that are neither registered with nor authorized by the FSA as legitimate entities to conduct financial/securities-related business.',
'JAPAN METI-WMD PROLIFERATORS' =>	'METI is comprised of many bureaus and government agencies. The agency responsible for trade controls is Trade and Economic Cooperation Bureau\'s Trade Control Department and specifically the Security Export Control Policy Division. This division creates the WMD foreign end user list that restricts trade with the listed entities.',
'JAPAN MOF SANCTIONS' =>	'MOF\'s International Bureau generates the sanction list comprised of UN and Japanese sanctions programs that restrict transactions with entities on the list.',
'MONETARY AUTHORITY OF SINGAPORE' =>	'Financial institutions subject to regulation by the Monetary Authority of Singapore (MAS) should block the assets of individuals and entities on the list; inform the MAS; and provide such further information relating to the funds, financial assets, economic resources, transaction or proposed transaction as MAS may require.',
'MORTGAGE SANCTIONS' =>	'Firms and individuals that have been sanctioned or have been recipients of disciplinary action from a variety of organizations providing oversight of mortgage activities.',
'NONPROLIFERATION SANCTIONS' =>	'The United States imposes sanctions under various legal authorities against foreign individuals, private entities, and governments that engage in proliferation activities. The Bureau of International Security and Nonproliferation (ISN), which is within the U.S. Department of State, is responsible for managing a broad range of nonproliferation and arms control functions, including nonproliferation sanctions lists. These lists are compiled into a single Nonproliferation watchlist.',
'OFAC NON-SDN ENTITIES' =>	'The OFAC NON-SDN ENTITIES list contains OFAC designations that have designations other than SDN or are not solely SDN designations. It currently consists of the Non-SDN Palestinian Legislative Council (NS-PLC) list, the CAPTA List, the Non-SDN Iran Sanctions (NS-ISA) list, the Foreign Sanctions Evaders (FSE) list and the Sectoral Sanctions Identifications (SSI) list. This list also contains the Parastatal Entities of Iraq and the E.O. 13808 entities of Venezuela. In addition, this list contains the Cuba Restricted List pursuant to the Cuban Assets Control Regulations posted in OFAC\'s Cuba Sanctions program 31 C.F.R. part 515.',
'OFAC SDN' =>	'The Office of Foreign Assets Control (OFAC) administers a series of laws that impose economic sanctions against hostile targets to further U.S. foreign policy and national security objectives. This listing contains the names and descriptor information on entities identified by the United States to pose a threat to the interests and security of the United States.  This data file also includes narcotics traffickers, terrorists, and business and organizations supporting threatening activities.',
'OFAC SDN ADDITIONS AND MODIFICATIONS' =>	'The OFAC SDN Additions and Modifications file contains information found within the most recent action taken by OFAC to update their list of Specially Designated Nationals (SDNs). The information in this supplementary data file represents the SDN additions and modifications only. This is NOT a complete OFAC SDN watch list. Two types of updates comprise the OFAC SDN Additions and Modifications file:  1) Changes to data within an existing SDN entity, and 2) Additions to the SDN list as new records. This file does not include entities to be removed from the SDN watch list. When deciding whether to use this incremental file, clients should carefully evaluate their risk of missing or omitting a change event since this would result in an incomplete or inaccurate OFAC SDN watch list.',
'OIG EXCLUSIONS' =>	'The OIG Exclusions watchlist contains the names of individuals and businesses excluded from participating in federally-funded health care programs, including Medicare and Medicaid.',
'OSFI CONSOLIDATED LIST' =>	'The Canada Office of the Superintendent of Financial Institutions (OSFI) supervises all federally regulated financial institutions in Canada, including deposit-taking institutions, insurance companies and pension plans.  OSFI is responsible for overseeing the overall safety and soundness of these institutions and plans.  OSFI personnel examine and monitor the financial condition of the institutions and the effectiveness of their oversight and control.  The also monitor the effectiveness of financial institutions\' anti-money laundering and anti-terrorist financial procedures.  OSFI-Canada publishes a consolidated list of entities that are subject to financial sanctions due to Canadian legislation and UN anti-terrorism measures.',
'PEOPLES BANK OF CHINA (PBC)' =>	'The People\'s Bank of China (PBC) regulates financial systems and ensures the stability of financial activities. PBC issues financial sanctions in three areas: Terrorism, Non-Proliferation, and Other areas that include UN Security Council Resolutions.',
'PRIMARY MONEY LAUNDERING CONCERN' =>	'Section 311 of the USA PATRIOT Act grants the Secretary of the Treasury the authority to designate certain entities as being of primary money laundering concern (PMLC). Bridger Insight presents PMLC designees in two data files. The first is PMLCJ.cdf which contains the names of designated jurisdictions (countries and territories). The second is PMLC.bdf which contains the names of designated institutions. Once designated, financial institutions subject to the USA PATRIOT Act are required to take any of five special measures, up to and including a restriction against related correspondent accounts or payable-through accounts.',
'REGISTERED MONEY SERVICES BUSINESSES' =>	'With few exceptions, Money Services Businesses (MSBs) are required to register with FinCEN. ChoicePoints MSB watch list contains those MSBs who have registered with FinCEN. Criminals sometimes target MSBs because they provide money orders, travelers checks, money transfers, check cashing, currency exchange, and stored value services, all of which can be attractive when attempting to hide or disguise the origin of funds derived from illegal activity. Because of this, many institutions apply enhanced due diligence to business relationships or transactions involving MSBs.',
'RESERVE BANK OF AUSTRALIA' => 'The Reserve Bank of Australia (RBA) watchlist is a consolidated list of individuals and entities subject to bilateral financial sanctions administered by RBA. Information is obtained from RBA, who administers sanctions programs such as those relating to North Korea, Zimbabwe and the former government of Yugoslavia.',
'TERRORIST EXCLUSION LIST' =>	'The Terrorist Exclusion List (TEL) was created within section 411 of the USA PATRIOT Act and authorizes the Secretary of State to designate terrorist organizations for immigration purposes. Foreign persons who provide support or are otherwise associated with a TEL organization may be refused entry into the US, or if already here, may be deported, thus they are Excluded from U.S. soil. Financial institutions may consider scanning against the TEL because it contains terrorist organizations who may, under the guise of charitable contributions, launder money and obtain donations through US financial institutions.',
'UK FSA' =>	'The Financial Conduct Authority (FCA) is a non-governmental and independent body that regulates the financial services industry in the United Kingdom. The industries regulated include banks and building societies, mortgage and insurance brokers and advisers. FCA publishes lists of unauthorized firms and individuals that are currently targeting UK investors.',
'UN CONSOLIDATED LIST' =>	'The United Nations (UN) mandates that member countries participate in sanctions programs that are passed to counter very serious and immediate international threats.  For example, the UN mandates that all member countries participate in blocking and freezing the assets of named terrorists.  Other programs include Central African Republic, Democratic Republic of the Congo, the former regime in Iraq, Democratic People\'s Republic of Korea, Iran, Libya, Mali, South Sudan, Sudan, Somalia and Eritrea and Yemen. The sanctions programs are compiled into our UN Consolidated List.',
'UNAUTHORIZED BANKS' =>	'Bank regulating agencies frequently issue an alert pertaining to entities that may be conducting banking operations without authorization. Any proposed transactions involving these entities should be viewed with extreme caution, and the proper authorities must be notified of any attempt to conduct business. This watchlist is recommended for all organizations involved in transactions with financial institutions.',
'WORLD BANK INELIGIBLE FIRMS' =>	'Firms and individuals listed are ineligible to be awarded a World Bank-financed contract because they were found to have violated the fraud and corruption provisions of the Procurement Guidelines or the Consultants Guidelines. The designation lasts a specific period of time as determined by World Bank following an investigation and administrative process. In the case of a debarred firm, ineligibility extends to any firm or individual which controls the debarred firm, or any firm which the debarred firm controls. In the case of a debarred individual, ineligibility extends to any firm which the debarred individual controls.',
// COUNTRIES
'FATF FINANCIAL ACTION TASK FORCE' => 'The Financial Action Task Force (FATF) identified jurisdictions that have strategic deficiencies in combating money laundering and/or terrorist financing.',
'HM TREASURY SANCTIONS' => 'HM Treasury Sanctions watchlist contains jurisdictions subject to financial sanctions or economic measures administered by Her Majesty\'s Treasury in the United Kingdom. In addition to restrictions targeting specific individuals and entities in Iran, the UK enacted sanctions programs to control or restrict certain activities to and from other Iranian persons, entities or bodies.',
'OFAC SANCTIONS' =>	'The Office of Foreign Assets Control (OFAC) administers and enforces sanctions programs based on US foreign policy and national security goals. The sanctions programs are targeted against foreign countries, terrorists, international narcotics traffickers, and those engaged in activities related to the proliferation of weapons of mass destruction. OFAC regulations impose controls on financial transactions, including requirements to freeze specific foreign assets under US jurisdiction. The sanctions programs may also control import / export, and travel. Many of the sanctions are based on United Nations mandates and are multilateral in scope. Thus many involve close cooperation with allied governments.',
'OFFSHORE FINANCIAL CENTERS' =>	'The Offshore Financial Centers (OFC) watchlist contains the names of jurisdictions monitored as OFCs by the International Monetary Fund (IMF). Transactions involving OFCs may have the potential for high risk. OFCs sometimes provide low or zero taxation; limited financial regulation; and banking secrecy or anonymity, including the ability to form legal entities where the true beneficial owners remain concealed. OFCs typically have relatively large numbers of financial institutions with little or no physical presence in the OFC and often engage primarily in business with non-residents.',
'OSFI COUNTRY' =>	'The OSFI Country watchlist contains certain jurisdictions subject to financial sanctions or economic measures administered by the Office of the Superintendent of Financial Institutions (OSFI) in Canada. The information for this watchlist comes directly from OSFI.',
'PRIMARY MONEY LAUNDERING CONCERN - JURISDICTIONS' =>	'Section 311 of the USA PATRIOT Act grants the Secretary of the Treasury the authority to designate certain entities as being of primary money laundering concern (PMLC). Bridger Insight presents PMLC designees in two data files. The first is PMLCJ.cdf which contains the names of designated jurisdictions (countries and territories). The second is PMLC.bdf which contains the names of designated institutions. Once designated, financial institutions subject to the USA PATRIOT Act are required to take any of five special measures, up to and including a restriction against related correspondent accounts or payable-through accounts.',
				TRIM(ListName, LEFT, RIGHT));
					
export string SourceCodeToFileName(string ListName) := 'HPCC-UID-' +
					TRIM(STD.Str.ToTitleCase(TRIM(ListName, LEFT, RIGHT)), ALL) + '.xml';



export string SourceCodetoBridgerSourceID(string ListName) := 
case(STD.Str.ToUpperCase(ListName),
'AUSTRALIA DEPT OF FOREIGN AFFAIRS AND TRADE' => 'D3D7D162-4CCB-4A3C-8E31-62A4EC84C677',
'BANK OF ENGLAND CONSOLIDATED LIST' => '5D3711C2-CDEA-4484-A663-721E1CB67A23',
'BUREAU OF INDUSTRY AND SECURITY' => 'DEBC63F5-5CAF-40FF-AB84-CB98FD28B4DF',
'CHIEFS OF STATE AND FOREIGN CABINET MEMBERS' => '099A5216-C559-4742-BB40-DF33F9E731C9',
'COMMODITY FUTURES TRADING COMMISSION SANCTIONS' => '5647E38A-EB42-450A-91FD-DDAE0FC36D16',
'DTC DEBARRED PARTIES' => '4072CD6C-0A30-481B-A083-88908CC67E28',
'EPLS' => 'BE3BDFE4-01D6-43FC-9FA5-A462E8A76F14',
'EU CONSOLIDATED LIST' => '5BC3DA15-3680-4D17-8924-BCA63BEE746A',
'FBI HIJACK SUSPECTS' => 'F3C56CC4-D256-41D5-B956-86580146EE58',
'FBI MOST WANTED' => '9D525AD5-AA83-4969-8FD1-D769A6966CEA',
'FBI MOST WANTED TERRORISTS' => '5B9E980E-3253-425C-9842-1BC0FB7BA68B',
'FBI SEEKING INFORMATION' => '1ABFD267-E593-4B12-8C30-06846B991146',
'FBI TOP TEN MOST WANTED' => 'DBCBCE26-BEC9-4B8E-987E-28731FDB0AD0',
'FINANCIAL SANCTIONS' => '197A8AA4-3881-40fc-A791-5D1EEF5623FD',
'FOREIGN AGENTS REGISTRATIONS' => '5FD42F5B-CDA6-4DC5-BF23-9080FADBFBBA',
'HM TREASURY INVESTMENT BAN LIST' => '15531CCC-FA6C-4B78-8B9B-AE0DAFBD0F45',
'HONG KONG MONETARY AUTHORITY' => 'B077B613-CE86-4A73-B3DF-263BF1C3D334',
'HUD LDP' => 'D95CF847-2042-4799-8787-C8183C85ABC9',
'INTERPOL MOST WANTED' => '1FB823A4-626C-4341-847F-CFB02DAA5C55',
'IRELAND FINANCIAL REGULATOR UNAUTHORIZED FIRMS' => '0C9A1A39-B6B5-4179-B891-A17B46706D05',
'JAPAN FSA' => 'B4FEB1B6-A508-4822-AB99-F4F359452B62',
'JAPAN METI-WMD PROLIFERATORS' => '59E9D879-E4BE-42E5-9776-7C23A175D2FF',
'JAPAN MOF SANCTIONS' => '6E6CDAE9-D2B5-4F1A-9F52-CFEC31DC5F31',
'MONETARY AUTHORITY OF SINGAPORE' => 'EDF6FFDE-1187-4F29-8E79-7E71C77F408D',
'MORTGAGE SANCTIONS' => '73D21CBD-56A1-4b31-A2F6-23C7B405E767',
'NONPROLIFERATION SANCTIONS' => '849DE5D9-EA9E-4B49-936A-4672AAE4C39A',
'OFAC NON-SDN ENTITIES' => '3C9D0D76-EBC9-4354-B539-7835B88B8A56',
'OFAC SDN' => 'EB56436C-CD56-4845-83C4-3B40D0169DAC',
'OFAC SDN ADDITIONS AND MODIFICATIONS' => 'F77B3885-7785-4CED-A723-DE820E5C62E8',
'OIG EXCLUSIONS' => 'E2CDD451-9C79-4226-9A4C-C4DFC60EFE88',
'OSFI CONSOLIDATED LIST' => 'D3DA6AA5-4905-4F5F-98C8-EBFCF60D1FCA',
'PEOPLES BANK OF CHINA (PBC)' => 'ED64158C-D484-42C6-85F0-D3DE9774D74E',
'PRIMARY MONEY LAUNDERING CONCERN' => '98CFF092-94B6-4A38-94C4-83CADEE82BEA',
'REGISTERED MONEY SERVICES BUSINESSES' => 'EF9CEF6F-7F02-4AEE-ACEB-C2124AFF6CB4',
'RESERVE BANK OF AUSTRALIA' => '8E406576-1435-459E-9C9C-1550463E5365',
'TERRORIST EXCLUSION LIST' => '4959EAE9-76B8-49CE-889A-813894EEDA8B',
'UK FSA' => 'EE9FC97D-8C12-49C3-B1E3-CC2D249936BF',
'UN CONSOLIDATED LIST' => '743C12E2-D6AC-4A77-9EBE-AC32BC8A4338',
'UNAUTHORIZED BANKS' => 'A1601AF5-4A42-4C36-9585-ADAC5CD57FCB',
'WORLD BANK INELIGIBLE FIRMS' => '830201E1-F6FE-488B-8DC0-14C33DF9B7F7',
// COUNTRIES
'FATF FINANCIAL ACTION TASK FORCE' => '02744985-BA79-4755-B9CC-8E2FE822C3BC',
'HM TREASURY SANCTIONS' => 'A6C98695-D413-4B43-8F3A-2B55168324B9',
'OFAC SANCTIONS' => 'EE1319B1-B81B-468D-A8B5-C749FC8E8A9B',
'OFFSHORE FINANCIAL CENTERS' => '9AE64629-AB92-4B6F-8994-77D17D9160BD',
'OSFI COUNTRY' => 'EC29B602-3384-48E1-B32A-4EB9469501EB',
'PRIMARY MONEY LAUNDERING CONCERN - JURISDICTIONS' => '284EC40F-D88D-41DB-99E9-2B43342DFB3E',	
// 
FAIL(string, 'Unsupported Watchlist: ' + ListName)			//		 '00000000-0000-0000-0000-000000000000'
	);





END;