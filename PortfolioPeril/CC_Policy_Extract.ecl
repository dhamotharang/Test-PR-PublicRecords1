import CarrierDiscovery, ut, Insurance, _Control, CurrentCarrierServices, lib_ThorLib, lib_StringLib;

EXPORT CC_Policy_Extract (string8 build_date) := Function
					#CONSTANT('CurrentCarrierEnv', 'Y');
					ambest_insurance_category := 'PC';
					PolicyDS        					:= CarrierDiscovery.Files.DS_FBASE_POLICY;
					PropertyDS      					:= CarrierDiscovery.Files.DS_FBASE_PROPERTY;

	string	lRawFileName							:= ''	:	STORED('CC_Extract_InputFileName');
					MBSi_ParmDS								:= DATASET(lRawFileName, PortfolioPeril.MBSi_PPR_Layouts.tdsRec,csv(terminator(['\r\n','\n']), separator('\t'), quote('/"'),maxlength(200), notrim));
					MBSi_Parms 								:= PortfolioPeril.MBSi_PPR_Parms(MBSi_ParmDS);

					lMBSi_ParmDS_Count 				:= COUNT(MBSi_ParmDS);
					lInsurance_Type						:= 'PP';

					customer_to_bill					:= MBSi_Parms.custno_bill;
					return_node 							:= MBSi_Parms.SrcNode;
					acct_to_bill							:= MBSi_Parms.acct;
					customer_to_xtract				:= MBSi_Parms.custno_ext;
					ambest_to_xtract					:= MBSi_Parms.ambests;
					ambest_to_xclude					:= MBSi_Parms.xambests;
					Report_Type								:= MBSi_Parms.rpttype;
					Report_Use								:= MBSi_Parms.produse;
					state_to_xtract						:= MBSi_Parms.states;
					ambestlist2 							:= SET(ambest_to_xtract,fld);
					StateList 								:= SET(state_to_xtract,fld);
					XAmbestList 							:= SET(ambest_to_xclude,fld);

					Ambest_byCustomer 	:= CurrentCarrierServices.getAmbest.byCustomer(ambest_insurance_category,customer_to_xtract);
					AmbestList 					:= SET(Ambest_byCustomer,ambest);
					GroupName_List 			:= SET(Ambest_byCustomer,group_name);
					lCustomerName				:= GroupName_List[1];
	BOOLEAN	IsError							:= Report_Type not in ['A','S','Z']
															or Report_Use not in ['Z','G']
															or lMBSi_ParmDS_Count<>10;

					Include_ambest			:=	IF (EXISTS(ambestlist2), ambestlist2,AmbestList);

					dActive_Policy			:= PolicyDS(Insurance_Type = Constants().Insurance_Type_PP and 
			                                ambest IN  Include_ambest and  
																			IF (EXISTS(XAmbestList),ambest Not IN XAmbestList,true));// and
																			// IF (EXISTS(StateList),state IN StateList,true)); 
      
					dActive_Property		:= PropertyDS(Insurance_Type = Constants().Insurance_Type_PP and 
																				ambest IN  Include_ambest and
																				IF (EXISTS(XAmbestList),ambest Not IN XAmbestList,true) and
																				IF (EXISTS(StateList),rst IN StateList,true) and
																				coverage_end_date >= (UNSIGNED4) build_date); 

					Active_Policy_Count 	:= COUNT(dActive_Policy);
					Active_Property_Count := COUNT(dActive_Property);

					Policy_Dist						:=	IF(_control.ThisEnvironment.Name!='Prod',
																			DISTRIBUTE(dActive_Policy,HASH64(Ambest, Policy_Number, Insurance_Type)),
																			dActive_Policy);

					Property_Dist					:=	IF(_control.ThisEnvironment.Name!='Prod',
																				DISTRIBUTE(dActive_Property,HASH64(Ambest, Policy_Number, Insurance_Type)),
																				dActive_Property);


				CC_Extract_Layout := RECORD
									Insurance.Layout_key_policy;
									CarrierDiscovery.LoadLayouts.POLICY_INFO.policy_endorsement_date;
									CarrierDiscovery.LoadLayouts.POLICY_INFO.state;
									CarrierDiscovery.LoadLayouts.POLICY_INFO.period_end_date;
									CarrierDiscovery.LoadLayouts.PROPERTY_INFO.Property_Number;
									CarrierDiscovery.LoadLayouts.PROPERTY_INFO.Coverage_End_Date;
									CarrierDiscovery.LoadLayouts.PROPERTY_INFO.Property_Cancellation_Date;
									Insurance.Layout_Address;
				END;
			
// Join active policy with property risk address into common record:

		CC_Extract_Layout tExtractCCAddress(CarrierDiscovery.LoadLayouts.Filtered_Policy_Info L, CarrierDiscovery.LoadLayouts.Filtered_Property_Info R) := TRANSFORM
			SELF.Ambest											:= L.Ambest;
			SELF.Policy_Number							:= L.Policy_Number;
			SELF.Insurance_Type							:= L.Insurance_Type;
			SELF.Policy_Endorsement_Date		:= L.Policy_Endorsement_Date;
			SELF.Period_End_Date						:= L.period_end_date;
			SELF.State											:= L.State;
			SELF.Property_Number						:= R.Property_Number;
			SELF.Coverage_End_Date					:= R.Coverage_End_Date;
			SELF.Property_Cancellation_Date	:= R.Property_Cancellation_Date;
			SELF.HOUSE_NUM									:= lib_StringLib.StringLib.StringFilter(r.house_num, Constants().ValidHouseNumberCharacters);
			SELF.APT_NUM										:= R.APT_NUM;
			SELF.STREET_NAME								:= R.STREET_NAME;
			SELF.RCITY											:= R.RCITY;
			SELF.RST												:= R.RST;
			SELF.RZIP												:= R.RZIP;
			SELF.RZIP4											:= R.RZIP4;
		END;

		dCCAddrExtract 		:= JOIN(Policy_Dist,Property_Dist,LEFT.Ambest 									= RIGHT.Ambest
																										and LEFT.Policy_Number 						= RIGHT.Policy_Number
																										and LEFT.Insurance_Type 					= RIGHT.Insurance_Type,
																										tExtractCCAddress(LEFT,RIGHT),LOCAL);
			
		dAddr_Dedup 			:=	MAP(report_type = 'A' => DEDUP(SORT(Distribute(dCCAddrExtract,Hash64(house_num,street_name,rcity,rst,rzip)),house_num,street_name,rcity,rst,rzip,LOCAL),house_num,street_name,rcity,rst,rzip,LOCAL)
														 ,report_type = 'S' => DEDUP(SORT(Distribute(dCCAddrExtract,HASH64(rst)),rst,LOCAL),rst,LOCAL)
														 ,report_type = 'Z' => DEDUP(SORT(Distribute(dCCAddrExtract,HASH64(rzip)),rzip,LOCAL),rzip,LOCAL));
		
			Layouts.layout_cc_ppr_request tPopulateRequest(dAddr_Dedup L) := TRANSFORM
				SELF.reporttype  					:= report_type;
				SELF.reportusage  				:= report_use;
				SELF.accountnumber				:= acct_to_bill;
				SELF.orderdate  					:= build_date;
				SELF.streetaddress 				:= IF (report_type = 'A',TRIM(L.house_num,right) + ' ' + L.street_name,'');
				SELF.city			  					:= IF (report_type = 'A',L.rcity,'');
				SELF.state			  				:= IF (report_type IN ['A','S'],L.rst,'');
				SELF.zip5			  					:= IF (report_type IN ['A','Z'],L.rzip,'');
				SELF.censustract			  	:= [];
				SELF.quoteback			  		:= [];
			END;

				dFileOut    						:= PROJECT (dAddr_Dedup, tPopulateRequest(LEFT),LOCAL);

			Layouts.layout_cc_ppr_columns initCol() := TRANSFORM
				SELF.col_reporttype				:= 'reporttype';
				SELF.col_reportusage			:= 'reportusage';
				SELF.col_accountnumber		:= 'accountnumber';
				SELF.col_orderdate				:= 'orderdate';
				SELF.col_streetaddress		:= 'streetaddress';
				SELF.col_city							:= 'city',
				SELF.col_state						:= 'state';
				SELF.col_zip5							:= 'zip5';
				SELF.col_censustract      := 'censustract';
				SELF.col_quoteback        := 'quoteback';
			END;

				ColRecord        	:= ROW(initCol());

				colRec        		:= PROJECT(COLRecord,TRANSFORM(Layouts.layout_cc_ppr_request,SELF.reporttype 		:= LEFT.col_reporttype;
																																										   SELF.reportusage 	:= LEFT.col_reportusage; 
																																											 SELF.accountnumber := LEFT.col_accountnumber;
																																											 SELF.orderdate 		:= LEFT.col_orderdate;
																																											 SELF.streetaddress := LEFT.col_streetaddress;
																																											 SELF.city 					:= LEFT.col_city;
																																											 SELF.state 				:= LEFT.col_state;
																																											 SELF.zip5 					:= LEFT.col_zip5;
																																											 SELF.censustract 	:= LEFT.col_censustract;
																																											 SELF.quoteback 		:= LEFT.col_quoteback;));
	

				dFileSort		 	:=	MAP(report_type = 'A' => SORT(dFileOut,zip5,streetaddress)
														 ,report_type = 'S' => SORT(dFileOut,State)
														 ,report_type = 'Z' => SORT(dFileOut,zip5)
														 );

				dFileCol			:=	colRec & dFileSort;
				dFileOut_cnt	:=	COUNT(dFileCol);
				
				layout_cc_ppr_request2 			:= {UNSIGNED seqno; Layouts.layout_cc_ppr_request;};
				return_node_len							:=	LENGTH(return_node);
				ipDate 											:= ut.GetDate;
		
			Layouts.SIDEX_SAC initSAC() 		:= TRANSFORM
				SELF.SIDEX_CONSTANT						:= '##!!';
				SELF.RECORD_CODE							:= 'SAC#';
				Julian_Day										:= ut.DayofYear((integer)ipdate [1..4],(integer)ipdate [5..6],(integer)ipdate[7..8]);
				Julian_Date										:= ipdate[3..4] + INTFORMAT(Julian_Day,3,1);
				SELF.TRANSMISSION_DATE				:= Julian_Date;
				SELF.TRANSMISSION_TIME				:= ut.getTime()[1..4];
				SELF.APPLICATION_ID						:= 'PPRV';
				SELF.CUSTOMER_NAME						:= lCustomerName;
				SELF.SOURCE_ID								:= return_node;
				SELF.DESTINATION_ID						:= 'E11904000';
				SELF.DESTINATION_FILE_NAME		:= 'PPR_INPUT';    //Need to confirm destination file name
				SELF.ALTERNATE_DATE           := ipDate;
				SELF.DUMMY      							:= '1';
				SELF												  := [];
			END;
				SACRecord        							:= ROW(initSAC());


	
	Layouts.SIDEX_SAT initSAT() 		:= TRANSFORM
		SELF.SIDEX_CONSTANT						:= '##!!';
		SELF.RECORD_CODE							:= 'SAT#';
		Julian_Day										:= ut.DayofYear((integer)ipdate [1..4],(integer)ipdate [5..6],(integer)ipdate[7..8]);
		Julian_Date										:= ipdate[3..4] + INTFORMAT(Julian_Day,3,1);
		SELF.TRANSMISSION_DATE				:= Julian_Date;
		SELF.TRANSMISSION_TIME				:= ut.getTime()[1..4];
		SELF.APPLICATION_ID						:= 'PPRV';
		SELF.SOURCE_ID								:= return_node;
		SELF.TOTAL_NUMBER_OF_RECORDS	:= IF (dFileOut_cnt > 999999, '999999', INTFORMAT(dFileOut_cnt,6,1));
		SELF.TOTAL_NUMBER_OF_BLOCKS		:= IF (dFileOut_cnt > 999999, INTFORMAT(dFileOut_cnt,8,1), '');
		SELF.ALTERNATE_DATE           := ipDate;
		// SELF.APPLICATION_AREA         := INTFORMAT(dFileOut_cnt,150,0);
		SELF.APPLICATION_AREA         := INTFORMAT(dFileOut_cnt,141,0);
		SELF													:= [];
	END;
	
	SATRecord := ROW(initSAT());
	
				sacRec        		:= PROJECT(SACRecord,transform(layout_cc_ppr_request2,self.seqno := 0,self.reporttype:=Left.SIDEX_CONSTANT + Left.RECORD_CODE + Left.TRANSMISSION_DATE + Left.TRANSMISSION_TIME + Left.APPLICATION_ID + 
                             Left.SECONDARY_PASSWORD + Left.SOURCE_ID + Left.DESTINATION_ID + Left.CUSTOMER_NAME + Left.RECORD_FORMAT + 
													   Left.PRINT_IMAGE_CONTROL_OPTION + Left.MAXIMUM_RECORD_LENGTH + Left.RESTART_REQUEST_LEVEL + Left.RESTART_BLOCK_NUMBER +
														 Left.TRANSACTION_FORMAT +  Left.FILE_SIZE + Left.FILE_SIZE_UNITS + Left.ALTERNATE_DATE + Left.DESTINATION_FILE_NAME + 
														 Left.REPORTINGPERIODBEGINDATE + Left.REPORTINGPERIODENDDATE + Left.LINEOFBUSINESS + Left.LNID + Left.UNUSED1 + 
                             Left.DESTINATIONPATHNAME + Left.DUMMY;self := []));
				satRec        		:= PROJECT(SATRecord,transform(layout_cc_ppr_request2,self.seqno := dFileOut_cnt + 1,self.reporttype:=Left.SIDEX_CONSTANT + Left.RECORD_CODE + Left.TRANSMISSION_DATE + Left.TRANSMISSION_TIME + Left.APPLICATION_ID + 
														Left.FILLER1 + Left.SOURCE_ID + Left.TOTAL_NUMBER_OF_RECORDS + Left.TOTAL_NUMBER_OF_BLOCKS + Left.TOTAL_NUMBER_OF_BYTES + Left.ALTERNATE_DATE +
														Left.FILLER2 + Left.APPLICATION_AREA; Self := []));

		
				dfile					:= PROJECT (dFileCol, TRANSFORM(layout_cc_ppr_request2,self.seqno := counter,self := Left));
				dFileCSV1			:= SORT(sacRec & dfile & satRec,seqno);
				
				dFileCSV			:= PROJECT (dFileCSV1, layouts.layout_cc_ppr_request);
	
			OUTPUT(lMBSi_ParmDS_Count,named('MBSiRecords'));

			OUTPUT(Active_Policy_Count);
			OUTPUT(Active_Property_Count);
			OUTPUT(Report_Type,named('Report_Type'));
			OUTPUT(Report_Use,named('Report_Use'));
			OUTPUT(customer_to_bill,named('Customer_Bill_Out'));
			OUTPUT(customer_to_xtract,named('Customer_to_Xtr'));
			OUTPUT(return_node,named('Return_Node_Id'));
			OUTPUT(acct_to_bill,named('Acct_to_Bill'));
			OUTPUT(ambestlist2,named('ambesttoextract'));
			OUTPUT(XAmbestList,named('ambesttoexclude'));
			OUTPUT(Ambest_byCustomer,named('ambestbycustomer'));
			OUTPUT(StateList,named('StateList'));

			OUTPUT(dCCAddrExtract,,'~thor::ppr::cc::addrextract::' + Constants().WorkUnit_Reformat,__COMPRESSED__,OVERWRITE);
			OUTPUT(dAddr_Dedup,,'~thor::ppr::cc::addrdeduped::' + Constants().WorkUnit_Reformat,__COMPRESSED__,OVERWRITE);
			OUTPUT(dFileCSV,, Files.CC_Addr_Extract_FileName + customer_to_xtract + '::' + Constants().WorkUnit_Reformat,csv,__COMPRESSED__,OVERWRITE);

			lDesprayFileName	:=	Files.BatchR3_FilePath + 'ppr_cc_' + customer_to_xtract + '_addr_' + Constants().WorkUnit_Reformat + '.txt';
		
			DesprayAddr		:= FileServices.DeSpray (Files.CC_Addr_Extract_FileName + customer_to_xtract + '::' + Constants().WorkUnit_Reformat,
																		Constants().landingzone,
																		lDesprayFileName,-1,
																		Constants().devespserverIPport,,TRUE);


			// SendEmail									:=	MAP(lMBSi_ParmDS_Count <> 10	=> Fileservices.Sendemail(Constants().QC_email_target,
			SendEmail									:=	MAP(IsError	=> Fileservices.Sendemail(Constants().QC_email_target,
																			' PPR CC Extract '+ build_date +': POSSIBLE ERROR - ' + _control.ThisEnvironment.Name,
																			'PPR CC MBSi File does not contain 10 records or has an invalid report type. Please look at, as no data has been digested. File: ' + lRawFileName
																			+ ' WUID: ' + workunit),
																			Fileservices.Sendemail(Constants().QC_email_target,
																			' PPR CC Extract ' + build_date + ': Successful - ' + _control.ThisEnvironment.Name,
																			'PPR CC MBSi File contains 10 records and a valid report type. File: ' + lRawFileName + ' WUID: ' + workunit)
																			);

			SendFailedEmail						:=	Fileservices.Sendemail(Constants().QC_email_target, 'PPR CC Extract '+ build_date + ': Failed - ' + _control.ThisEnvironment.Name,
																				'Please look at, as no data has been digested. File: ' + lRawFileName + ' WUID: ' + workunit);


			Results1 		:= IF (IsError, SendEmail, SEQUENTIAL (SendEmail,output(CHOOSEN(dFileCSV,2000)),DesprayAddr)):FAILURE(SendFailedEmail);
		
	RETURN Results1;
	
END;