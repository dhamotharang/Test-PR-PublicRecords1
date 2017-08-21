export Query_Sources_Population_Stats := 
sequential(
	 busreg.Query_Population_Stats
	,BBB2.Query_Population_Stats
	,govdata.Query_Population_Stats
	,DNB.Query_DNB_Fein_Population_Stats
	,DCA.Query_Population_Stats
	,FCC.Query_FCC_Licenses_population_stats
	,FBN_new.Query_Population_Stats
	,InfoUSA.Query_Deadco_population_stats
	,InfoUSA.Query_Idexec_population_stats
	,InfoUSA.Query_ABIUS_Population_stats
	,IRS5500.Query_Population_Stats
	,Lobbyists.Query_Population_Stats
	,BusData.Query_population_stats
	,Vickers.Query_population_stats
	,YellowPages.Query_population_stats
	,Wither_and_Die.Query_population_stats
);


/*
Sales Tax Registrations (CA, IA) also TX which has not been migrated yet 
D&B FEIN 
DCA 
Employee Directories 
FDIC 
FCC 
InfoUSA DBAs 
InfoUSA DEADCO 
InfoUSA IDEXEC 
InfoUSA USABIZ 
IRS Form 5500 
IRS Non-Profit Charitable Organizations 
Lobbyists 
Workers Compensation  MS / OR 
National Credit Union Charter Numbers 
SEC Broker Dealer 
SKA 
Vickers Insider Trading 
Wither & Die Sources  include a flag for sources that are now updating (DR can assist) 
Yellow Pages 
*/