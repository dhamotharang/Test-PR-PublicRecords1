IMPORT prte2_ebr, ebr;


EXPORT Files := MODULE
  EXPORT IN_0010_Header_Boca						:= dataset(Constants.in_prefix_name + '0010_header', Layouts.In_0010_Header, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
	EXPORT IN_0010_Header_Ins							:= dataset(Constants.in_prefix_name + '0010_header_ins', Layouts.In_0010_Header, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
  Export IN_0010_Header:= IN_0010_Header_Boca + IN_0010_Header_Ins;
	
	EXPORT IN_5600_Demographic_Data_Boca		:= dataset(Constants.in_prefix_name + '5600_demographic_data', Layouts.In_5600_Demographic, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
  EXPORT IN_5600_Demographic_Data_Ins		:= dataset(Constants.in_prefix_name + '5600_demographic_data_ins', Layouts.In_5600_Demographic, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));	
  Export IN_5600_Demographic_Data:= IN_5600_Demographic_Data_Boca + IN_5600_Demographic_Data_Ins;
	 
	 
	EXPORT IN_5610_Demographic_Data_Boca		:= dataset(Constants.in_prefix_name + '5610_demographic_data', Layouts.In_5610_Demographic, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
	EXPORT IN_5610_Demographic_Data_Ins		:= dataset(Constants.in_prefix_name + '5610_demographic_data_ins', Layouts.In_5610_Demographic, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
  Export IN_5610_Demographic_Data:=IN_5610_Demographic_Data_Boca+IN_5610_Demographic_Data_Ins;	
  
	EXPORT IN_1000_Executive_Summary_Boca		:= dataset(Constants.in_prefix_name + 'execsummary', Layouts.Executive_In, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
  EXPORT IN_1000_Executive_Summary_Ins		:= dataset(Constants.in_prefix_name + 'execsummaryins', Layouts.Executive_In, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
  Export IN_1000_Executive_Summary:=	IN_1000_Executive_Summary_Boca	+ IN_1000_Executive_Summary_Ins;
	
  EXPORT IN_Trade_Pay_Tot_Boca		:= dataset(Constants.in_prefix_name + 'tradepmttot', Layouts.Trade_Pay_Tot_In, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));	
	EXPORT IN_Trade_Pay_Tot_Ins		:= dataset(Constants.in_prefix_name + 'tradepmttotins', Layouts.Trade_Pay_Tot_In, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));	
  EXPORT IN_Trade_Pay_Tot:=	IN_Trade_Pay_Tot_Boca+IN_Trade_Pay_Tot_Ins;
	
	EXPORT BASE_0010_Header						:= dataset(Constants.base_prefix_name + '0010_header', Layouts.File_0010_Header, thor); 
	EXPORT BASE_0010_Header_linkids:=project(BASE_0010_Header,EBR.Layout_0010_Header_Base_AID); 
	
	EXPORT BASE_5600_Demographic			:= dataset(Constants.base_prefix_name + '5600_demographic_data', Layouts.File_5600_Demographic, thor);
	Export Base_5600_Demographic_LinkIds:=Project(BASE_5600_Demographic,EBR.Layout_5600_Demographic_Data_Base);
	
	EXPORT BASE_5610_Demographic			:= dataset(Constants.base_prefix_name + '5610_demographic_data', Layouts.File_5610_Demographic, thor);
	Export BASE_5610_Demographic_linkIds:=project(BASE_5610_Demographic,EBR.Layout_5610_demographic_data_Base);
	
	EXPORT BASE_1000_Executive_Summary				:= dataset(Constants.base_prefix_name + 'executive_summary_data', Layouts.File_1000_Executive_Summary, thor);
				
	EXPORT BASE_2000_Trade										:= dataset([], Layouts.File_2000_Trade);
	
  EXPORT BASE_2015_Trade_Payment_Totals			:= dataset(Constants.base_prefix_name + 'trade_payment_tot_data', Layouts.File_2015_Trade_Payment_Totals, thor);
		
	EXPORT BASE_2020_Trade_Payment_Trends			:= dataset([], Layouts.File_2020_Trade_Payment_Trends);
	EXPORT BASE_2025_Trade_Quarterly_Averages	:= dataset([], Layouts.File_2025_Trade_Quarterly_Averages);
	EXPORT BASE_4010_Bankruptcy								:= dataset([], Layouts.File_4010_Bankruptcy);
	EXPORT BASE_4020_Tax_Liens								:= dataset([], Layouts.File_4020_Tax_Liens);
	EXPORT BASE_4030_Judgement								:= dataset([], Layouts.File_4030_Judgment);
	EXPORT BASE_4500_Collateral_Acct					:= dataset([], Layouts.File_4500_Collateral_Accounts);
	EXPORT BASE_4510_UCC_Filings							:= dataset([], Layouts.File_4510_UCC_Filings);
	EXPORT BASE_5000_Bank_Details							:= dataset([], Layouts.File_5000_Bank_Details);
	EXPORT BASE_6000_Inquiries								:= dataset([], Layouts.File_6000_Inquires);
	EXPORT BASE_6500_Government_Trade					:= dataset([], Layouts.File_6500_Government_Trade);
	EXPORT BASE_6510_Government_Debarred			:= dataset([], Layouts.File_6510_Government_Debarred_Contractor);
	EXPORT BASE_7010_SNP_Data									:= dataset([], Layouts.File_7010_SNP_DATA);
	
	EXPORT ds_0010_Header_Base							:= project(BASE_0010_Header, transform(Layouts.Slim_0010_Header_Base, 
																																										self.prim_range		:=	left.clean_Address.prim_range;
																																										self.predir				:=	left.clean_Address.predir;
																																										self.prim_name		:=	left.clean_Address.prim_name;
																																										self.addr_suffix	:=	left.clean_Address.addr_suffix;
																																										self.postdir			:=	left.clean_Address.postdir;
																																										self.unit_desig		:=	left.clean_Address.unit_desig;
																																										self.sec_range		:=	left.clean_Address.sec_range;
																																										self.p_city_name	:=	left.clean_Address.p_city_name;
																																										self.v_city_name	:=	left.clean_Address.v_city_name;
																																										self.st						:=	left.clean_Address.st;
																																										self.zip					:=	left.clean_Address.zip;
																																										self.zip4					:=	left.clean_Address.zip4;
																																										self.cart					:=	left.clean_Address.cart;
																																										self.cr_sort_sz		:=	left.clean_Address.cr_sort_sz;
																																										self.lot					:=	left.clean_Address.lot;
																																										self.lot_order		:=	left.clean_Address.lot_order;
																																										self.dbpc					:=	left.clean_Address.dbpc;
																																										self.chk_digit		:=	left.clean_Address.chk_digit;
																																										self.rec_type			:=	left.clean_Address.rec_type;
																																										self.county				:=	left.clean_Address.county;
																																										self.geo_lat			:=	left.clean_Address.geo_lat;
																																										self.geo_long			:=	left.clean_Address.geo_long;
																																										self.msa					:=	left.clean_Address.msa;
																																										self.geo_blk			:=	left.clean_Address.geo_blk;
																																										self.geo_match		:=	left.clean_Address.geo_match;
																																										self.err_stat			:=	left.clean_Address.err_stat;
																																										self 							:=  left;
																																										self							:=	[];
																																										));
END;

