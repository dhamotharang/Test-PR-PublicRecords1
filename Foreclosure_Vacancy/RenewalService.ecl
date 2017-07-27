/*--SOAP--
<message name="RenewalRequest">
	<!-- XML INPUT -->
	<part name="ForeclosureVacanciesRenewalRequest" 		type="tns:XmlDataSet" cols="80" rows="30" />
	<part name="InsuranceContext" 											type="tns:XmlDataSet" cols="80" rows="15" />
	<part name="_TransactionId" 												type="xsd:string"/>
</message>
*/
/*--HELP--
Renewal Request XML:
<pre>
&lt;Dataset&gt;
&lt;Row&gt;
   &lt;searchby&gt;
      &lt;uniqueid&gt;&lt;/uniqueid&gt;
      &lt;name&gt;
	 &lt;first&gt;&lt;/first&gt;
	 &lt;middle&gt;&lt;/middle&gt;
	 &lt;last&gt;&lt;/last&gt;
      &lt;/name&gt;
      &lt;address&gt;
	 &lt;streetaddress1&gt;&lt;/streetaddress1&gt;
	 &lt;streetaddress2&gt;&lt;/streetaddress2&gt;
	 &lt;city&gt;&lt;/city&gt;
	 &lt;state&gt;&lt;/state&gt;
	 &lt;zip5&gt;&lt;/zip5&gt;
	 &lt;zip4&gt;&lt;/zip4&gt;
      &lt;/address&gt;
   &lt;/searchby&gt;
&lt;/Row&gt;
&lt;/Dataset&gt;
</pre>
*/
import Foreclosure_Vacancy, iesp,InsuranceLog_iesp, InsuranceContext_iesp, Seed_Files, ut;

export RenewalService := MACRO

	//Get XML input 
	ds_xml_in 			:= DATASET ([], iesp.Foreclosure_Vacancies_Order.t_ForeclosureVacanciesRenewalRequest)		: STORED ('ForeclosureVacanciesRenewalRequest', FEW);
	ds_xml_options 	:= DATASET ([], InsuranceContext_iesp.insurance_risk_context.t_ForeclosureVacancyContext)	: STORED ('InsuranceContext', FEW);

	string    trans_id := ''                   : stored('_TransactionId');
	boolean		Return_Renewal_Report := TRUE;
	
	Foreclosure_Vacancy.layouts.in_data fromESDL(ds_xml_in l) := TRANSFORM
		self.UniqueID       := l.SearchBy.UniqueID;
		self.last_name      := l.SearchBy.Name.last;
		self.middle_initial := l.SearchBy.Name.middle;
		self.first_name     := l.SearchBy.Name.first;
		self.street_address := l.SearchBy.Address.StreetAddress1;
		self.apt            := l.SearchBy.Address.UnitNumber;
		self.city           := l.SearchBy.Address.city;
		self.state          := l.SearchBy.Address.state;
		self.zip            := l.SearchBy.Address.zip5;
		self.zip4           := l.SearchBy.Address.zip4;
		self.acctno				  := trans_id;
	end;
	
	Foreclosure_Vacancy.layouts.in_data invalidTransaction(ds_xml_in l) := TRANSFORM
		self.acctno				  := trans_id;
		//blank input values for unauthorized transactions
		self.UniqueID       := '';
		self.last_name      := '';
		self.middle_initial := '';
		self.first_name     := '';
		self.street_address := '';
		self.apt            := '';
		self.city           := '';
		self.state          := '';
		self.zip            := '';
		self.zip4           := '';
	end;
	
	//Check account status and authorization
	boolean isAuthorized 				:= ds_xml_options[1].Products.FOVInfo.Authorized;
	boolean isValidAccount 			:= ds_xml_options[1].Account.Status = 'A';
	boolean isValidTransaction 	:= isAuthorized and isValidAccount;

	data_in := if(isValidTransaction, PROJECT(ds_xml_in, fromESDL(Left)), PROJECT(ds_xml_in, invalidTransaction(Left))) ;
	
	//Error code text
	isAuthorizedMessage := if(isAuthorized, 	'', 'This account is not authorized to use the ForeclosureVacancy query.');
	isAuthorizedCode 		:= if(isAuthorized, 	'', '1');
	isAccountMessage		:= if(isValidAccount, '', 'This is not a valid account.');
	isAccountCode				:= if(isValidAccount, '', '2'); 
	
	wsExceptions0	:= dataset([{'','','','',}], iesp.share.t_WsException);
	wsExceptions1 := dataset([{'',isAccountCode,'',isAccountMessage}], iesp.share.t_WsException); 
	wsExceptions2 := dataset([{'',isAuthorizedCode,'',isAuthorizedMessage}], iesp.share.t_WsException); 

	wsFinal := if(isValidTransaction, wsExceptions0, if(~isAuthorized, wsExceptions1, wsExceptions2));
	
	//Get data
	mod_getData := Foreclosure_Vacancy.getData(data_in, isRenewal:=true);
	renewal_output := mod_getData.getRenewal(); 
	
//Get Seed Data
	seed_file	:= Seed_Files.key_FOVRenewal;
	//create input hash
	hash_first 	:= data_in[1].first_name;
	hash_last 	:= data_in[1].last_name;
	hash_addr		:= data_in[1].street_address;
	hash_zip		:= data_in[1].zip;
	input_hash := foreclosure_vacancy.functions.Hash_FOV((string20)hash_first, (string20)hash_last, (string60)hash_addr, (string5)hash_zip);
	
	//compare input hash to seed data has
	seed_result := choosen(seed_file(hashvalue = input_hash, dataset_name = ds_xml_options[1].Products.FOVInfo.TestDataTableName),1);
	
//Transform output to iesp
	//Production Data Transform
	iesp.foreclosure_vacancies_report.t_ForeclosureVacanciesRenewalResponse toESDL(renewal_output l) := TRANSFORM
		// Header
		self._Header.Exceptions																			:= wsFinal;
		self._Header.TransactionID																	:= trans_id;
		// Echo
		self.InputCleaned.InputEcho.UniqueId                        := l.UniqueID_in;
		self.InputCleaned.InputEcho.Name.First                      := l.first_name_in;
		self.InputCleaned.InputEcho.Name.Middle                     := l.middle_initial_in;
		self.InputCleaned.InputEcho.Name.Last                       := l.last_name_in;
		self.InputCleaned.InputEcho.Address.StreetAddress1          := l.street_address_in;
		self.InputCleaned.InputEcho.Address.UnitNumber		          := l.apt_in;
		self.InputCleaned.InputEcho.Address.City                    := l.city_in;
		self.InputCleaned.InputEcho.Address.State                   := l.state_in;
		self.InputCleaned.InputEcho.Address.Zip5                    := l.zip_in;
		self.InputCleaned.InputEcho.Address.Zip4                    := l.zip4_in;

		// Input Cleaned
		self.InputCleaned.InputCleanedAddress.StreetNumber          := l.prim_range;
		self.InputCleaned.InputCleanedAddress.StreetPreDirection    := l.predir;
		self.InputCleaned.InputCleanedAddress.StreetName            := l.prim_name;
		self.InputCleaned.InputCleanedAddress.StreetSuffix          := l.suffix;
		self.InputCleaned.InputCleanedAddress.StreetPostDirection   := l.postdir;
		self.InputCleaned.InputCleanedAddress.UnitNumber            := l.sec_range;
		self.InputCleaned.InputCleanedAddress.City                  := l.p_city_name;
		self.InputCleaned.InputCleanedAddress.State                 := l.St;
		self.InputCleaned.InputCleanedAddress.Zip5                  := l.zip;
		self.InputCleaned.InputCleanedAddress.Zip4                  := l.zip4;
				
		// Renewal payload	
		self.Renewal.VacancyInd 											:= l.VACANCY_IND;
		self.Renewal.VacancyBeginDate.Year 						:= (integer)l.VAC_BEGDT[1..4];
		self.Renewal.VacancyBeginDate.Month  					:= (integer)l.VAC_BEGDT[5..6];
		self.Renewal.VacancyBeginDate.Day  						:= (integer)l.VAC_BEGDT[7..8];
		self.Renewal.ForeclosureUniqueId 							:= l.fc_unique_ID;
		self.Renewal.ForeclosureInd 									:= l.FC_IND;
		self.Renewal.ForeclosureAddrInd  							:= l.FC_ADDR_IND;
		self.Renewal.OwnerType  											:= l.OWNER_TYPE;
		self.Renewal.CpDataDate.Year  								:= (integer)l.CP_DATA_DATE[1..4];
		self.Renewal.CpDataDate.Month  								:= (integer)l.CP_DATA_DATE[5..6];
		self.Renewal.CpDataDate.Day		 								:= (integer)l.CP_DATA_DATE[7..8];
		self.Renewal.ForeclosureStage  								:= l.FORECLOSURE_STAGE;
		self.Renewal.DeedEventTypeCd  								:= l.DEED_EVENT_TYPE_CD;
		self.Renewal.DeedEventTypeDesc  							:= l.DEED_EVENT_TYPE_DESC;
		self.Renewal.DocumentTypeCd  									:= l.DOC_TYPE_CD;
		self.Renewal.DocumentTypeDesc  								:= l.DOC_TYPE_DESC;
		self.Renewal.CpSaleAmount  										:= l.CP_SALE_AMT;
		self.Renewal.CpDefaultAmount  								:= l.CP_DFLT_AMT;
		self.Renewal.CpDefaultDate.Year  							:= (integer)l.CP_DFLT_DT[1..4];
		self.Renewal.CpDefaultDate.Month  						:= (integer)l.CP_DFLT_DT[5..6];
		self.Renewal.CpDefaultDate.Day								:= (integer)l.CP_DFLT_DT[7..8];
		self.Renewal.CpAuctionDate.Year  							:= (integer)l.CP_AUCTION_DT[1..4];
		self.Renewal.CpAuctionDate.Month  						:= (integer)l.CP_AUCTION_DT[5..6];
		self.Renewal.CpAuctionDate.Day								:= (integer)l.CP_AUCTION_DT[7..8];
		self.Renewal.LenderCompanyName  							:= l.LNDR_CMPNY_NAME;
		self.Renewal.PropertyTypeCd  									:= l.PROPERTY_TYPE_CD;
		self.Renewal.PropertyTypeDesc  								:= l.PROPERTY_TYPE_DESC;
		self.Renewal.Owner1.First  										:= l.OWNR_1_FIRST_NAME;
		self.Renewal.Owner1.Last  										:= l.OWNR_1_LAST_NAME;
		self.Renewal.Owner2.First  										:= l.OWNR_2_FIRST_NAME;
		self.Renewal.Owner2.Last  										:= l.OWNR_2_LAST_NAME;
		self.Renewal.Owner3.First  										:= l.OWNR_3_FIRST_NAME;
		self.Renewal.Owner3.Last  										:= l.OWNR_3_LAST_NAME;
		self.Renewal.Owner4.First  										:= l.OWNR_4_FIRST_NAME;
		self.Renewal.Owner4.Last  										:= l.OWNR_4_LAST_NAME;
		self.Renewal.CpFilingDate.Year  							:= (integer)l.CP_DFLT_DT[1..4];
		self.Renewal.CpFilingDate.Month  							:= (integer)l.CP_DFLT_DT[5..6];
		self.Renewal.CpFilingDate.Day									:= (integer)l.CP_DFLT_DT[7..8];
		self.Renewal.CpRecordingDate.Year  						:= (integer)l.CP_DFLT_DT[1..4];
		self.Renewal.CpRecordingDate.Month  					:= (integer)l.CP_DFLT_DT[5..6];
		self.Renewal.CpRecordingDate.Day							:= (integer)l.CP_DFLT_DT[7..8];
		self.Renewal.SubdivisionName  								:= l.SUBDV_NAME;
		self.Renewal.CourtCaseNumber  								:= l.COURT_CASE_NBR;
		self.Renewal.Plaintiff1.Full  								:= l.PLNTFF1_NAME;
		self.Renewal.Plaintiff2.Full  								:= l.PLNTFF2_NAME;
		self.Renewal.Trustee.Full											:= l.TRUSTEE_NAME;
		self.Renewal.TrusteeAddress.StreetAddress1		:= l.TRUSTEE_ADDR;
		self.Renewal.TrusteeAddress.City  						:= l.TRUSTEE_CITY;
		self.Renewal.TrusteeAddress.State  						:= l.TRUSTEE_STATE;
		self.Renewal.TrusteeAddress.Zip5							:= l.TRUSTEE_ZIPCD;
		self.Renewal.TrusteePhoneNumber  							:= l.TRUSTEE_PHONE_NBR;
		self.Renewal.OriginalLoanDate.Year  					:= (integer)l.CP_DFLT_DT[1..4];
		self.Renewal.OriginalLoanDate.Month  					:= (integer)l.CP_DFLT_DT[5..6];
		self.Renewal.OriginalLoanDate.Day							:= (integer)l.CP_DFLT_DT[7..8];
		self.Renewal.OriginalLoanRecordingDate.Year 	:= (integer)l.CP_DFLT_DT[1..4];
		self.Renewal.OriginalLoanRecordingDate.Month	:= (integer)l.CP_DFLT_DT[5..6];
		self.Renewal.OriginalLoanRecordingDate.Day		:= (integer)l.CP_DFLT_DT[7..8];
		self.Renewal.LastFullSaleTransferDate.Year  	:= (integer)l.CP_DFLT_DT[1..4];
		self.Renewal.LastFullSaleTransferDate.Month 	:= (integer)l.CP_DFLT_DT[5..6];
		self.Renewal.LastFullSaleTransferDate.Day			:= (integer)l.CP_DFLT_DT[7..8];
		self.Renewal.LegalDesc1  											:= l.EXPAND_LEGAL_DESC;
		self.Renewal.LegalDesc2  											:= l.LEGAL_DESC_2;
		self.Renewal.LegalDesc3  											:= l.LEGAL_DESC_3;
		self.Renewal.LegalDesc4  											:= l.LEGAL_DESC_4;
		self := [];
	end;
		
	response := PROJECT(renewal_output, toESDL(left));
	
	//Seed Data Transform
	iesp.foreclosure_vacancies_report.t_ForeclosureVacanciesRenewalResponse toESDLSeed(seed_result l) := TRANSFORM
		//Header
		self._Header.Exceptions																			:= wsFinal;
		self._Header.TransactionID																	:= trans_id;
		//Echo
		self.InputCleaned.InputEcho.UniqueId                        := l.UniqueID_in;
		self.InputCleaned.InputEcho.Name.First                      := l.first_name_in;
		self.InputCleaned.InputEcho.Name.Middle                     := l.middle_initial_in;
		self.InputCleaned.InputEcho.Name.Last                       := l.last_name_in;
		self.InputCleaned.InputEcho.Address.StreetAddress1          := l.street_address_in;
		self.InputCleaned.InputEcho.Address.UnitNumber		          := l.apt_in;
		self.InputCleaned.InputEcho.Address.City                    := l.city_in;
		self.InputCleaned.InputEcho.Address.State                   := l.state_in;
		self.InputCleaned.InputEcho.Address.Zip5                    := l.zip_in;
		self.InputCleaned.InputEcho.Address.Zip4                    := l.zip4_in;

		//Input Cleaned
		self.InputCleaned.InputCleanedAddress.StreetNumber          := l.prim_range;
		self.InputCleaned.InputCleanedAddress.StreetPreDirection    := l.predir;
		self.InputCleaned.InputCleanedAddress.StreetName            := l.prim_name;
		self.InputCleaned.InputCleanedAddress.StreetSuffix          := l.suffix;
		self.InputCleaned.InputCleanedAddress.StreetPostDirection   := l.postdir;
		self.InputCleaned.InputCleanedAddress.UnitNumber            := l.sec_range;
		self.InputCleaned.InputCleanedAddress.City                  := l.p_city_name;
		self.InputCleaned.InputCleanedAddress.State                 := l.St;
		self.InputCleaned.InputCleanedAddress.Zip5                  := l.zip;
		self.InputCleaned.InputCleanedAddress.Zip4                  := l.zip4;
				
		//Renewal payload	
		self.Renewal.VacancyInd 											:= l.VACANCY_IND;
		self.Renewal.VacancyBeginDate.Year 						:= (integer)l.VAC_BEGDT[1..4];
		self.Renewal.VacancyBeginDate.Month  					:= (integer)l.VAC_BEGDT[5..6];
		self.Renewal.VacancyBeginDate.Day  						:= (integer)l.VAC_BEGDT[7..8];
		self.Renewal.ForeclosureUniqueId 							:= l.fc_unique_ID;
		self.Renewal.ForeclosureInd 									:= l.FC_IND;
		self.Renewal.ForeclosureAddrInd  							:= l.FC_ADDR_IND;
		self.Renewal.OwnerType  											:= l.OWNER_TYPE;
		self.Renewal.CpDataDate.Year  								:= (integer)l.CP_DATA_DATE[1..4];
		self.Renewal.CpDataDate.Month  								:= (integer)l.CP_DATA_DATE[5..6];
		self.Renewal.CpDataDate.Day		 								:= (integer)l.CP_DATA_DATE[7..8];
		self.Renewal.ForeclosureStage  								:= l.FORECLOSURE_STAGE;
		self.Renewal.DeedEventTypeCd  								:= l.DEED_EVENT_TYPE_CD;
		self.Renewal.DeedEventTypeDesc  							:= l.DEED_EVENT_TYPE_DESC;
		self.Renewal.DocumentTypeCd  									:= l.DOC_TYPE_CD;
		self.Renewal.DocumentTypeDesc  								:= l.DOC_TYPE_DESC;
		self.Renewal.CpSaleAmount  										:= l.CP_SALE_AMT;
		self.Renewal.CpDefaultAmount  								:= l.CP_DFLT_AMT;
		self.Renewal.CpDefaultDate.Year  							:= (integer)l.CP_DFLT_DT[1..4];
		self.Renewal.CpDefaultDate.Month  						:= (integer)l.CP_DFLT_DT[5..6];
		self.Renewal.CpDefaultDate.Day								:= (integer)l.CP_DFLT_DT[7..8];
		self.Renewal.CpAuctionDate.Year  							:= (integer)l.CP_AUCTION_DT[1..4];
		self.Renewal.CpAuctionDate.Month  						:= (integer)l.CP_AUCTION_DT[5..6];
		self.Renewal.CpAuctionDate.Day								:= (integer)l.CP_AUCTION_DT[7..8];
		self.Renewal.LenderCompanyName  							:= l.LNDR_CMPNY_NAME;
		self.Renewal.PropertyTypeCd  									:= l.PROPERTY_TYPE_CD;
		self.Renewal.PropertyTypeDesc  								:= l.PROPERTY_TYPE_DESC;
		self.Renewal.Owner1.First  										:= l.OWNR_1_FIRST_NAME;
		self.Renewal.Owner1.Last  										:= l.OWNR_1_LAST_NAME;
		self.Renewal.Owner2.First  										:= l.OWNR_2_FIRST_NAME;
		self.Renewal.Owner2.Last  										:= l.OWNR_2_LAST_NAME;
		self.Renewal.Owner3.First  										:= l.OWNR_3_FIRST_NAME;
		self.Renewal.Owner3.Last  										:= l.OWNR_3_LAST_NAME;
		self.Renewal.Owner4.First  										:= l.OWNR_4_FIRST_NAME;
		self.Renewal.Owner4.Last  										:= l.OWNR_4_LAST_NAME;
		self.Renewal.CpFilingDate.Year  							:= (integer)l.CP_DFLT_DT[1..4];
		self.Renewal.CpFilingDate.Month  							:= (integer)l.CP_DFLT_DT[5..6];
		self.Renewal.CpFilingDate.Day									:= (integer)l.CP_DFLT_DT[7..8];
		self.Renewal.CpRecordingDate.Year  						:= (integer)l.CP_DFLT_DT[1..4];
		self.Renewal.CpRecordingDate.Month  					:= (integer)l.CP_DFLT_DT[5..6];
		self.Renewal.CpRecordingDate.Day							:= (integer)l.CP_DFLT_DT[7..8];
		self.Renewal.SubdivisionName  								:= l.SUBDV_NAME;
		self.Renewal.CourtCaseNumber  								:= l.COURT_CASE_NBR;
		self.Renewal.Plaintiff1.Full  								:= l.PLNTFF1_NAME;
		self.Renewal.Plaintiff2.Full  								:= l.PLNTFF2_NAME;
		self.Renewal.Trustee.Full											:= l.TRUSTEE_NAME;
		self.Renewal.TrusteeAddress.StreetAddress1		:= l.TRUSTEE_ADDR;
		self.Renewal.TrusteeAddress.City  						:= l.TRUSTEE_CITY;
		self.Renewal.TrusteeAddress.State  						:= l.TRUSTEE_STATE;
		self.Renewal.TrusteeAddress.Zip5							:= l.TRUSTEE_ZIPCD;
		self.Renewal.TrusteePhoneNumber  							:= l.TRUSTEE_PHONE_NBR;
		self.Renewal.OriginalLoanDate.Year  					:= (integer)l.CP_DFLT_DT[1..4];
		self.Renewal.OriginalLoanDate.Month  					:= (integer)l.CP_DFLT_DT[5..6];
		self.Renewal.OriginalLoanDate.Day							:= (integer)l.CP_DFLT_DT[7..8];
		self.Renewal.OriginalLoanRecordingDate.Year 	:= (integer)l.CP_DFLT_DT[1..4];
		self.Renewal.OriginalLoanRecordingDate.Month	:= (integer)l.CP_DFLT_DT[5..6];
		self.Renewal.OriginalLoanRecordingDate.Day		:= (integer)l.CP_DFLT_DT[7..8];
		self.Renewal.LastFullSaleTransferDate.Year  	:= (integer)l.CP_DFLT_DT[1..4];
		self.Renewal.LastFullSaleTransferDate.Month 	:= (integer)l.CP_DFLT_DT[5..6];
		self.Renewal.LastFullSaleTransferDate.Day			:= (integer)l.CP_DFLT_DT[7..8];
		self.Renewal.LegalDesc1  											:= l.EXPAND_LEGAL_DESC;
		self.Renewal.LegalDesc2  											:= l.LEGAL_DESC_2;
		self.Renewal.LegalDesc3  											:= l.LEGAL_DESC_3;
		self.Renewal.LegalDesc4  											:= l.LEGAL_DESC_4;
		self := [];
	end;
		
	seed_response := PROJECT(seed_result, toESDLSeed(left));

//Final Outputs
	final_response := if(ds_xml_options[1].Products.FOVInfo.TestDataEnabled, seed_response, response);

//////////////////////////
//Customter support output
	input_echo := mod_getData.Cleaned;
	base_advo  := mod_getData.base_ADVO_Full;
	fc_byAddr  := mod_getData.Find_Foreclosure_By_Addr;

	Input_Echo_support := toxml(input_echo[1]);
	input_CS := dataset([{'INPUT_ECHO','1',Input_Echo_support,trans_id,'21','1','','',trans_id}], iesp.intermediate_log.t_IntermediateLogRecord);
	
	Vacancy_support := toxml(base_advo[1]);
	ADVO_CS := dataset([{'VACANCY_DATA','1',Vacancy_support,trans_id,'21','2','','',trans_id}], iesp.intermediate_log.t_IntermediateLogRecord);
	
	mal_layout := RECORD
		dataset(foreclosure_vacancy.layouts.Foreclosure) foreclosures {maxCount(10)};
	END;
	
	Foreclosure_support := toxml(ROW({choosen(fc_byAddr,10)}, mal_layout));
	foreclosure_CS := dataset([{'FORECLOSURE_DATA','1',Foreclosure_support,trans_id,'21','2','','',trans_id}], iesp.intermediate_log.t_IntermediateLogRecord);

	cust_support := input_CS + ADVO_CS + foreclosure_CS;

	iesp.intermediate_log.t_IntermediateLogRecords final_support(cust_support l) := transform
		self.records := l;
	end;

	final_cust_support := project(cust_support, final_support(left));

	output(final_cust_support, named('LOG_log__mbsi_intermediate__log'));
	output(final_response, named('Results'));

ENDMACRO;

//**************************************************************

// RenewalService();

