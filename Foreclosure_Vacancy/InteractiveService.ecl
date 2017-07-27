/*--SOAP--
<message name="InteractiveRequest">
	<!-- XML INPUT -->
	<part name="ForeclosureVacanciesInteractiveRequest" type="tns:XmlDataSet" cols="80" rows="30" />
	<part name="InsuranceContext" type="tns:XmlDataSet" cols="80" rows="15" />
	<part name="_TransactionId" type="xsd:string"/>
</message>
*/
/*--HELP--
Interactive Request XML:
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
import Foreclosure_Vacancy, iesp, InsuranceLog_iesp, InsuranceContext_iesp, Seed_Files, ut;

export InteractiveService := MACRO

//Get XML input 
	ds_xml_in 			:= DATASET ([], iesp.Foreclosure_Vacancies_Order.t_ForeclosureVacanciesInteractiveRequest): STORED ('ForeclosureVacanciesInteractiveRequest', FEW);
	ds_xml_options 	:= DATASET ([], InsuranceContext_iesp.insurance_risk_context.t_ForeclosureVacancyContext)	: STORED ('InsuranceContext', FEW);

	string    trans_id := '' : stored('_TransactionId');
	boolean   Return_Renewal_Report := FALSE;
	
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
	isAuthorizedMessage := if(isAuthorized, '', 'This account is not authorized to use the ForeclosureVacancy query.');
	isAuthorizedCode 		:= if(isAuthorized, '', '1');
	isAccountMessage		:= if(isValidAccount, '', 'This is not a valid account.');
	isAccountCode				:= if(isValidAccount, '', '2'); 
	
	wsExceptions0	:= dataset([{'','','','',}], iesp.share.t_WsException);
	wsExceptions1 := dataset([{'',isAccountCode,'',isAccountMessage}], iesp.share.t_WsException); 
	wsExceptions2 := dataset([{'',isAuthorizedCode,'',isAuthorizedMessage}], iesp.share.t_WsException); 
	
	wsFinal := if(isValidTransaction, wsExceptions0, if(~isAuthorized, wsExceptions1, wsExceptions2));
	
//Get data
	mod_getData := Foreclosure_Vacancy.getData(data_in, isRenewal:=false);
	interactive_output := mod_getData.getInteractive(); 
	
//Get Seed Data
	seed_file	:= Seed_Files.key_FOVInteractive;
	//create input hash
	hash_first 	:= data_in[1].first_name;
	hash_last 	:= data_in[1].last_name;
	hash_addr		:= data_in[1].street_address;
	hash_zip		:= data_in[1].zip;
	input_hash := foreclosure_vacancy.functions.Hash_FOV((string20)hash_first, (string20)hash_last, (string60)hash_addr, (string5)hash_zip);
	
	//compare input hash to seed data hash
	seed_result := choosen(seed_file(hashvalue = input_hash, dataset_name = ds_xml_options[1].Products.FOVInfo.TestDataTableName),1);
	
//Transform output to iesp
	//Production Data Transform
	iesp.foreclosure_vacancies_report.t_ForeclosureVacanciesInteractiveResponse toESDL(interactive_output l, ds_xml_in r) := TRANSFORM
		//Header
		self._Header.Exceptions																			:= wsFinal;
		self._Header.TransactionID																	:= trans_id;
		//Echo
		self.InputCleaned.InputEcho.UniqueId                        := l.UniqueID_in;
		self.InputCleaned.InputEcho.NameId                        	:= r.SearchBy.NameId;
		self.InputCleaned.InputEcho.AddressId                       := r.SearchBy.AddressID;
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

		//Interactive payload
		self.Interactive.ForeclosureTwelveMonth                     := (integer)l.foreclosure_12mo;
		self.Interactive.ForeclosureType                            := l.foreclosure_type;
		self.Interactive.ForeclosureTypeDescription                 := l.foreclosure_type_description;
		self.Interactive.ForeclosureDate.Year                       := (integer)l.foreclosure_date[1..4];
		self.Interactive.ForeclosureDate.Month                      := (integer)l.foreclosure_date[5..6];
		self.Interactive.ForeclosureDate.Day                        := (integer)l.foreclosure_date[7..8];
		self.Interactive.ForeclosureCountTwelveMonth                := (integer)l.foreclosure_count_12mo;

		self.Interactive.PotentiallyVacant                          := l.Potentially_Vacant;
		self.Interactive.VacancyFirstSeen.Year                      := (integer)l.Vacancy_First_Seen[1..4];
		self.Interactive.VacancyFirstSeen.Month                     := (integer)l.Vacancy_First_Seen[5..6];
		self.Interactive.VacancyFirstSeen.Day                       := (integer)l.Vacancy_First_Seen[7..8];
		self.Interactive.VacancyCount                               := (integer)l.Vacancy_count;
		self.Interactive.VacancyCurrentDuration.Days                := (integer)l.Vacancy_current_duration;
		self.Interactive.VacancyMaxDuration.Days                    := (integer)l.Vacancy_max_duration;

		self := [];
	end;
		
	response := join(interactive_output, ds_xml_in,
		left.UniqueID_in !='' and right.SearchBy.UniqueID !='' and
		left.UniqueID_in = right.SearchBy.UniqueID,
		toESDL(left, right),Left Outer,
			keep(1));		
	
	//Seed Data Transform
	iesp.foreclosure_vacancies_report.t_ForeclosureVacanciesInteractiveResponse toESDLSeed(seed_result l) := TRANSFORM
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

		//Interactive payload
		self.Interactive.ForeclosureTwelveMonth                     := (integer)l.foreclosure_12mo;
		self.Interactive.ForeclosureType                            := l.foreclosure_type;
		self.Interactive.ForeclosureTypeDescription                 := l.foreclosure_type_description;
		self.Interactive.ForeclosureDate.Year                       := (integer)l.foreclosure_date[1..4];
		self.Interactive.ForeclosureDate.Month                      := (integer)l.foreclosure_date[5..6];
		self.Interactive.ForeclosureDate.Day                        := (integer)l.foreclosure_date[7..8];
		self.Interactive.ForeclosureCountTwelveMonth                := (integer)l.foreclosure_count_12mo;

		self.Interactive.PotentiallyVacant                          := l.Potentially_Vacant;
		self.Interactive.VacancyFirstSeen.Year                      := (integer)l.Vacancy_First_Seen[1..4];
		self.Interactive.VacancyFirstSeen.Month                     := (integer)l.Vacancy_First_Seen[5..6];
		self.Interactive.VacancyFirstSeen.Day                       := (integer)l.Vacancy_First_Seen[7..8];
		self.Interactive.VacancyCount                               := (integer)l.Vacancy_count;
		self.Interactive.VacancyCurrentDuration.Days                := (integer)l.Vacancy_current_duration;
		self.Interactive.VacancyMaxDuration.Days                    := (integer)l.Vacancy_max_duration;

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
// InteractiveService();
