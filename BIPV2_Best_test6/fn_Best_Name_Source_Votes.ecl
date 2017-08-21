import MDR;
export fn_Best_Name_Source_Votes(STRING source,INTEGER Dups) :=
/*MAP( 	trim(source[..2], all) in ['DN'] 																			=> Dups * 2.0, 
						Dups ); // Treat as normal
*/

MAP(
				MDR.sourceTools.SourceIsCorpV2																(trim(source[..2], all)) => 6.0 * dups
	, 	  MDR.sourceTools.SourceIsBankruptcy														(trim(source[..2], all)) => 5.9 * dups
	,			MDR.sourceTools.SourceIsDCA																		(trim(source[..2], all)) => 5.8 * dups
	,			MDR.sourceTools.SourceIsDunn_Bradstreet												(trim(source[..2], all)) => 5.7 * dups
	,			MDR.sourceTools.SourceIsSDA																		(trim(source[..2], all)) => 5.6 * dups
	,			MDR.sourceTools.SourceIsSDAA																	(trim(source[..2], all)) => 5.5 * dups
	,   	MDR.sourceTools.SourceIsMartinDale_Hubbell										(trim(source[..2], all)) => 5.4 * dups
	,     MDR.sourceTools.SourceIsEBR																		(trim(source[..2], all)) => 5.3 * dups
	,			MDR.sourceTools.SourceIsIRS_5500															(trim(source[..2], all))  => 5.2 * dups
	,			MDR.sourceTools.SourceIsFDIC																	(trim(source[..2], all))  => 5.1 * dups
	,			MDR.sourceTools.SourceIsIRS_Non_Profit												(trim(source[..2], all))  => 5.0 * dups
	,			MDR.sourceTools.SourceIsWorkers_Compensation									(trim(source[..2], all))  => 4.9 * dups
	,			MDR.sourceTools.SourceIsBusiness_Registration	(trim(source[..2], all))  => 4.8 * dups
	,			MDR.sourceTools.SourceIsDunn_Bradstreet_Fein	(trim(source[..2], all))  => 4.7 * dups
	,				(trim(source[..2], all)) = MDR.sourceTools.src_Frandx																	=> 4.6 * dups
	,			MDR.sourceTools.SourceIsLiens_and_Judgments		(trim(source[..2], all))  => 4.5 * dups
	,			MDR.sourceTools.SourceIsUCCS									(trim(source[..2], all))  => 4.4 * dups
	,			MDR.sourceTools.sourceisVehicle								(trim(source[..2], all))  => 4.3 * dups
	,			MDR.sourceTools.SourceIsExperianVehicle 			(trim(source[..2], all))  => 4.2 * dups
	,			MDR.sourceTools.SourceIsGong_Business 				(trim(source[..2], all))  => 4.1 * dups
	,			MDR.sourceTools.sourceIsGong_Government 			(trim(source[..2], all))  => 4.0 * dups
	,			MDR.sourceTools.SourceIsWhois_domains 				(trim(source[..2], all))  => 3.9 * dups
	,			MDR.sourceTools.SourceIsYellow_Pages  				(trim(source[..2], all))  => 3.8 * dups
	,			MDR.sourceTools.SourceIsTargus_White_pages  	(trim(source[..2], all))  => 3.7 * dups
	,			MDR.sourceTools.SourceIsProperty  						(trim(source[..2], all))  => 3.6 * dups
	,			MDR.sourceTools.SourceIsFBNV2  								(trim(source[..2], all))  => 3.5 * dups
,			MDR.sourceTools.SourceIsDiversity_Cert  				(trim(source[..2], all))  => 3.4 * dups
,			MDR.sourceTools.SourceIsProfessional_License  	(trim(source[..2], all))  => 3.3 * dups
,			MDR.sourceTools.SourceIsOSHAIR  								(trim(source[..2], all))  => 3.2 * dups
,			MDR.sourceTools.SourceIsBBB  										(trim(source[..2], all))  => 3.1 * dups
,			MDR.sourceTools.SourceIsSheila_Greco 						(trim(source[..2], all))  => 3.0 * dups
,			MDR.sourceTools.SourceIsSpoke 									(trim(source[..2], all))  => 3.9 * dups
,			MDR.sourceTools.SourceIsJigsaw 									(trim(source[..2], all))  => 3.8 * dups
,			MDR.sourceTools.SourceIsZOOM 										(trim(source[..2], all))  => 3.7 * dups
, dups);

			
						
						
/*						
State Incorporation Record - SourceIsCorpV2
Bankruptcy - src_Bankruptcy SourceIsBankruptcy
3.	LNCA -  src_DCA
4.	D&B DMI* - src_Dunn_Bradstreet 
5.	SDA - src_SDA
6.	SDAA - src_SDAA
7.	MARHUB - src_MartinDale_Hubbell
8.	Experian Business Report (EBR) - src_EBR
9.	IRS 5500 - src_IRS_5500
10.	FDIC  - src_FDIC
11.	IRS Not-for-Profit file - src_IRS_Non_Profit
12.	Workers Comp sources - src_Workers_Compensation
13.	Business state & local tax registrations - SourceIsBusiness_Registration
14.	D&B FEIN - src_Dunn_Bradstreet_Fein
15.	Franchise source - src_Frandx
16.	Judgment/lien  - src_Liens_and_Judgments 
17.	UCC - src_UCC
18.	MVR/other prop - set_Experian_vehicles set_Vehicles
19.	EDA - SourceIsGong_Business sourceIsGong_Government
20.	LSSI - sourceIsGong_Government ourceIsGong_Government
21.	Phones+  - set_Phonesplus
22.	Internet domain regs - SourceIsWhois_domains
23.	Targus Pure Business Internet Yellow Pages - src_Yellow_Pages
24.	Targus White Pages - src_Targus_White_pages
25.	Canadian White Pages - Not found
26.	Real Prop - set_LnPropertyV2
27.	FBNs - set_Fbnv2
28.	Other Govt Sources - 
a.	Diversity/MWOB - src_Diversity_Cert
b.	Docket - 
c.	Pro Licenses -src_Professional_License 
d.	Gaming - src_NJ_Gaming_Licenses
e.	OSHA - src_OSHAIR
29.	Credit Header - set_Header
30.	Better Business Bureau - set_BBB 
31.	Sheila Greco - src_Sheila_Greco
32.	Spoke  - src_Spoke
33.	Jigsaw - 'JI'
34.	Zoom - src_ZOOM
*/