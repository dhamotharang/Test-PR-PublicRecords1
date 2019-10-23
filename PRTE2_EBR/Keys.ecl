Import Data_Services, doxie, ut, mdr, standard, PRTE2_EBR, autokey, AutoKeyB, BIPV2, Doxie,AutoStandardI;

EXPORT Keys := module

//0010_Header
export Key_0010_Header_BDID 									:= index(Files.ds_0010_Header_Base(bdid <> 0),{bdid},{Files.ds_0010_Header_Base}, Constants.key_prefix + doxie.Version_SuperKey + '::0010_header::bdid');
export Key_0010_Header_FILE_NUMBER 						:= index(Files.ds_0010_Header_Base(file_number <> ''),{file_number},{Files.ds_0010_Header_Base},Constants.key_prefix + doxie.Version_SuperKey + '::0010_header::file_number');

//1000_Executive_Summary
shared File_1000_Executive_Summary	:= project(Files.BASE_1000_Executive_Summary, Layouts.Slim_1000_executive_summary_base);
export Key_1000_Executive_Summary_BDID 			  := index(File_1000_Executive_Summary(bdid <> 0),{bdid},{File_1000_Executive_Summary},Constants.key_prefix + doxie.Version_SuperKey + '::1000_executive_summary::bdid');
export Key_1000_Executive_Summary_FILE_NUMBER := index(File_1000_Executive_Summary(file_number <> ''),{FILE_NUMBER},{File_1000_Executive_Summary},Constants.key_prefix + doxie.Version_SuperKey + '::1000_executive_summary::file_number');

//2000 Trade
shared File_2000_Trade	:= project(Files.BASE_2000_Trade, Layouts.Slim_2000_Trade_Base);
export Key_2000_Trade_FILE_NUMBER 										:= index(File_2000_Trade(file_number <> ''),{FILE_NUMBER},{File_2000_Trade},Constants.key_prefix + doxie.Version_SuperKey + '::2000_Trade::file_number');

//2015_Trade_Payment_Totals
File_2015_Trade_Payment_Totals	:= project(Files.BASE_2015_Trade_Payment_Totals, Layouts.Slim_2015_Trade_Payment_Totals_Base);
export Key_2015_Trade_Payment_Totals_FILE_NUMBER 			:= index(File_2015_Trade_Payment_Totals(file_number <> ''),{FILE_NUMBER},{File_2015_Trade_Payment_Totals},Constants.key_prefix + doxie.Version_SuperKey + '::2015_Trade_Payment_Totals::file_number');

//2020_Trade_Payment_Trends
File_2020_Trade_Payment_Trends	:= project(Files.BASE_2020_Trade_Payment_Trends, Layouts.Slim_2020_Trade_Payment_Trends_Base);
export Key_2020_Trade_Payment_Trends_FILE_NUMBER 			:= index(File_2020_Trade_Payment_Trends(file_number <> ''),{FILE_NUMBER},{File_2020_Trade_Payment_Trends},Constants.key_prefix + doxie.Version_SuperKey + '::2020_Trade_Payment_Trends::file_number');

//2025_Trade_Quarterly_Averages
File_2025_Trade_Quarterly_Averages	:= project(Files.BASE_2025_Trade_Quarterly_Averages, Layouts.Slim_2025_Trade_Quarterly_Averages_Base);
export Key_2025_Trade_Quarterly_Averages_FILE_NUMBER 	:= index(File_2025_Trade_Quarterly_Averages(file_number <> ''),{FILE_NUMBER},{File_2025_Trade_Quarterly_Averages},Constants.key_prefix + doxie.Version_SuperKey+' ::2025_Trade_Quarterly_Averages::file_number');

//4010_Bankruptcy
File_4010_Bankruptcy	:= project(Files.BASE_4010_Bankruptcy, Layouts.Slim_4010_Bankruptcy_Base);
export Key_4010_Bankruptcy_FILE_NUMBER 								:= index(File_4010_Bankruptcy(file_number <> ''),{FILE_NUMBER},{File_4010_Bankruptcy},Constants.key_prefix + doxie.Version_SuperKey + '::4010_Bankruptcy::file_number');

//4020_Tax_Liens
File_4020_Tax_Liens		:= project(Files.BASE_4020_Tax_Liens, Layouts.Slim_4020_Tax_Liens_Base);
export Key_4020_Tax_Liens_FILE_NUMBER 								:= index(File_4020_Tax_Liens(file_number <> ''),{FILE_NUMBER},{File_4020_Tax_Liens},Constants.key_prefix + doxie.Version_SuperKey + '::4020_Tax_Liens::file_number');

//4030_Judgement
File_4030_Judgement		:= project(Files.BASE_4030_Judgement, Layouts.Slim_4030_Judgement_Base);
export Key_4030_Judgement_FILE_NUMBER 								:= index(File_4030_Judgement(file_number <> ''),{FILE_NUMBER},{File_4030_Judgement},Constants.key_prefix + doxie.Version_SuperKey + '::4030_Judgement::file_number');

//4500_Collateral_Accounts
File_4500_Collateral_Accounts	:= project(Files.BASE_4500_Collateral_Acct, Layouts.Slim_4500_Collateral_Accounts_Base);
export Key_4500_Collateral_Accounts_FILE_NUMBER 			:= index(File_4500_Collateral_Accounts(file_number <> ''),{FILE_NUMBER},{File_4500_Collateral_Accounts},Constants.key_prefix + doxie.Version_SuperKey + '::4500_Collateral_Accounts::file_number');

//4510_UCC_Filings
File_4510_UCC_Filings_Base	:= project(Files.BASE_4510_UCC_Filings, Layouts.Slim_4510_UCC_Filings_Base);
export Key_4510_UCC_Filings_FILE_NUMBER 							:= index(File_4510_UCC_Filings_Base(file_number <> ''),{FILE_NUMBER},{File_4510_UCC_Filings_Base},Constants.key_prefix + doxie.Version_SuperKey + '::4510_UCC_Filings::file_number');

//5000_Bank_Details
File_5000_Bank_Details	:= project(Files.BASE_5000_Bank_Details, Layouts.Slim_5000_Bank_Details_Base);
export Key_5000_Bank_Details_FILE_NUMBER 							:= index(File_5000_Bank_Details,{FILE_NUMBER},{File_5000_Bank_Details},Constants.key_prefix + doxie.Version_SuperKey + '::5000_Bank_Details::file_number');

//5600_Demographic_Data
shared File_5600_demographic_data	:= project(Files.BASE_5600_Demographic, Layouts.Slim_5600_demographic_data_Base);
export Key_5600_Demographic_Data_BDID 				:= index(File_5600_demographic_data(bdid <> 0),{bdid},{File_5600_demographic_data},Constants.key_prefix + doxie.Version_SuperKey + '::5600_Demographic_data::bdid');
export Key_5600_Demographic_Data_FILE_NUMBER 	:= index(File_5600_demographic_data(file_number <> ''),{FILE_NUMBER},{File_5600_demographic_data},Constants.key_prefix + doxie.Version_SuperKey + '::5600_Demographic_data::file_number');

//5610_Demographic_Data
File_5610_Demographic_Data	:= project(Files.BASE_5610_Demographic, Layouts.Slim_5610_Demographic_Data_Base);
export Key_5610_Demographic_Data_FILE_NUMBER 	:= index(File_5610_Demographic_Data(file_number <> ''),{FILE_NUMBER},{File_5610_Demographic_Data},Constants.key_prefix + doxie.Version_SuperKey + '::5610_Demographic_data::file_number');

//6000_Inquiries
File_6000_Inquiries	:= project(Files.BASE_6000_Inquiries, Layouts.Slim_6000_Inquiries_Base);
export Key_6000_Inquiries_FILE_NUMBER 											:= index(File_6000_Inquiries(file_number <> ''),{FILE_NUMBER},{File_6000_Inquiries},Constants.key_prefix + doxie.Version_SuperKey + '::6000_Inquiries::file_number');

//6500_Government_Trade
FILE_6500_Government_Trade_Base		:= project(Files.BASE_6500_Government_Trade, Layouts.Slim_6500_Government_Trade_Base);
export Key_6500_Government_Trade_FILE_NUMBER 								:= index(FILE_6500_Government_Trade_Base(file_number <> ''),{FILE_NUMBER},{FILE_6500_Government_Trade_Base},Constants.key_prefix + doxie.Version_SuperKey + '::6500_Government_Trade::file_number');

//6510_Government_Debarred_Contractor
File_6510_Government_Debarred_Contractor		:= project(Files.BASE_6510_Government_Debarred, Layouts.Slim_6510_Government_Debarred_Contractor_Base);
export Key_6510_Government_Debarred_Contractor_FILE_NUMBER 	:= index(File_6510_Government_Debarred_Contractor(file_number <> ''),{FILE_NUMBER},{File_6510_Government_Debarred_Contractor},Constants.key_prefix + doxie.Version_SuperKey + '::6510_Government_Debarred_contractor::file_number');

//7010_SNP_Data
File_7010_SNP_Data		:= project(Files.BASE_7010_SNP_Data, Layouts.Slim_7010_SNP_Data_Base);
export Key_7010_SNP_Data_FILE_NUMBER 												:= index(File_7010_SNP_Data(file_number <> ''),{FILE_NUMBER},{File_7010_SNP_Data},Constants.key_prefix + doxie.Version_SuperKey + '::7010_SNP_Data::file_number');

EXPORT Key_0010_Header_linkids := MODULE

// DEFINE THE INDEX
shared superfile_name	:=  Constants.key_prefix + doxie.Version_SuperKey + '::0010_header::linkids';
//BIPV2.IDmacros.mac_IndexWithXLinkIDs(Files.BASE_0010_Header, k, superfile_name);
BIPV2.IDmacros.mac_IndexWithXLinkIDs(Files.BASE_0010_Header_linkids, k, superfile_name);
export Key := k;

//DEFINE THE INDEX ACCESS
	export kFetch2(
		dataset(BIPV2.IDlayouts.l_xlink_ids2) inputs, 
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0,								//Applied at lowest leve of ID
		BIPV2.mod_sources.iParams in_mod=PROJECT(AutoStandardI.GlobalModule(),BIPV2.mod_sources.iParams,opt),
		joinLimit = 25000,
		unsigned1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin
		) := 	FUNCTION

		BIPV2.IDmacros.mac_IndexFetch2(inputs, Key, out, Level, joinLimit, JoinType);
		ds_restricted := out(BIPV2.mod_sources.isPermitted(in_mod).bySource(MDR.sourceTools.src_EBR,''));
		return ds_restricted;		

	END;
		
END;


EXPORT Key_5600_Demographic_Data_linkids := MODULE

  // DEFINE THE INDEX
	shared superfile_name := Constants.key_prefix + doxie.Version_SuperKey + '::5600_Demographic_data::linkids';
	//BIPV2.IDmacros.mac_IndexWithXLinkIDs(Files.BASE_5600_Demographic, k, superfile_name)
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(Files.BASE_5600_Demographic_linkids, k, superfile_name)
	export Key := k;


	//DEFINE THE INDEX ACCESS
	export kFetch2(
		dataset(BIPV2.IDlayouts.l_xlink_ids2) inputs, 
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0,								//Applied at lowest leve of ID
		BIPV2.mod_sources.iParams in_mod=PROJECT(AutoStandardI.GlobalModule(),BIPV2.mod_sources.iParams,opt),
		joinLimit = 25000,
		unsigned1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin
		) := 	FUNCTION
												
		BIPV2.IDmacros.mac_IndexFetch2(inputs, Key, out, Level, joinLimit, JoinType);
		ds_restricted := out(BIPV2.mod_sources.isPermitted(in_mod).bySource(MDR.sourceTools.src_EBR,''));
		return ds_restricted;		

	END;
	
END;

END;