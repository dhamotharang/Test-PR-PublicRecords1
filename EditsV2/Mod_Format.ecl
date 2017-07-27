IMPORT CompId_Services, iesp, ut;

/* Parser: Translates the CompId result into specific layouts viz RI, PI, AL, DL, etc of edit response */
EXPORT Mod_Format := MODULE
	
	// General layouts
	SHARED Layout_StrArrayItem := iesp.share.t_StringArrayItem;
	SHARED Layout_Order := EditsV2.Layouts_Order.order;
	SHARED Layout_CompIdResult := CompId_Services.Layouts.Layout_CompId_Result;
	SHARED Layout_CompId_Address := CompId_Services.Layouts.Layout_Address;
	SHARED Layout_Response := EditsV2.Layouts_Response.response;
	
	// Specific layouts
	SHARED Layout_RI51 := EditsV2.Layouts_Response.RI51_V2;
	SHARED Layout_PI51 := EditsV2.Layouts_Response.PI51_V2;
	SHARED Layout_AL51 := EditsV2.Layouts_Response.AL51_V2;
	SHARED Layout_DL51 := EditsV2.Layouts_Response.DL51_V2;
	SHARED Layout_SH51 := EditsV2.Layouts_Response.SH51_V2;
	SHARED Layout_RC51 := EditsV2.Layouts_Response.RC51_V2;
	SHARED Layout_RP51 := EditsV2.Layouts_Response.RP51_V2;
	SHARED Layout_RI52 := EditsV2.Layouts_Response.RI52_V2;
	
	EXPORT Layout_Response_Temp := RECORD	
		INTEGER1 seq := 1;
		STRING230 rec; 
	END;
	
	SHARED ConvertDate(STRING inpDate) := inpDate[5..6]
												+	inpDate[7..8]
												+ inpDate[1..4];
	
	/* ********************** RI01Input *************************************** */
	/*--------------------------------------------------------------------------*/
	/* Construct RI51 Layout from Original Order and CompId Result Record       */
	/*--------------------------------------------------------------------------*/
	SHARED DATASET(Layout_RI51) GenerateRI51Recs (DATASET(Layout_Order) order, 
																								DATASET(Layout_CompIdResult) compIdResultDS) := FUNCTION

		// Create RI51 using Order 
		Layout_RI51 xformOrder(Layout_Order L) := TRANSFORM
			self.UnitNum 								:= if(count(L.RI01_Recs) > 0, L.RI01_Recs[1].UnitNum, Constants.UNIT_NUM_DEFAULT);
			self.seqnum 								:= Constants.SEQ_NUM_DEFAULT;
			self.RecCode 								:= Constants.RI51_IND;
			self.OccrNum								:= Constants.OCCR_NUM_DEFAULT;
			self.SecOccrNum							:= Constants.SEC_OCCR_NUM_DEFAULT;
			
			self.QuotebackText 					:= L.RI01_Recs[1].QuotebackText;
			self.ReportCode 						:= L.RI01_Recs[1].ReportCode;
			self.ReportVercode 					:= L.RI01_Recs[1].ReportVerCode;
			self.AcctNum 								:= L.RI01_Recs[1].AcctNum;
			self.AcctSufNum 						:= L.RI01_Recs[1].AcctSufNum;
			self.CustBillIdText 				:= L.RI01_Recs[1].CustBillIdText;
			
			// Fix date format. Defect Id: 2255
			self.OrderDate 							:= ConvertDate(ut.GetDate); // today's date
			self.OrderRecdDate 					:= IF (LENGTH(TRIM(L.RI01_Recs[1].ReportOrderDate)) > 0, L.RI01_Recs[1].ReportOrderDate, ConvertDate(ut.GetDate));
			self.CompleteDate						:= ConvertDate(ut.GetDate);
			
			self.ReportStatusCode 			:= ''; // 1-no hit, 2-hit
			
			self.ReportUseCode 					:= L.RI01_Recs[1].ReportUseCode;
			self.ReportTime 						:= ut.getTime()[1..4]; 						// current time: hhmm
			
			//self.ProdCode 							:= L.RI01_Recs[1].ProdLineCode;
			self.ProdCode 							:= ''; // Do not send the Permissible Purpose back. DefectId: 2246
			self.RecVerNum							:= L.RI01_Recs[1].RecVerNum;
			self := [];
		END;
		RI51WithoutStatusCode := project(order, xformOrder(left));
		
		// Add status code
		Layout_RI51 addStatusCode(Layout_RI51 L) := TRANSFORM
			self.ReportStatusCode 			:= (String)if(compIdResultDS[1].score = 0, Constants.NO_HIT_IND, Constants.HIT_IND); // 1-No Hit, 2-Hit
			self := L;
		END;
		RI51 := project(RI51WithoutStatusCode, addStatusCode(left));
		// output(RI51, named('RI51'));
		return RI51;
	END;
	
	/* ********************** PIInput, PIOutput ******************************* */
	/*--------------------------------------------------------------------------*/	
	/* Construct Input PI51 Layout from Original Order and CompId Result Record */
	/*--------------------------------------------------------------------------*/	
	EXPORT DATASET(Layout_PI51) GenerateInputPI51Recs (DATASET(Layout_Order) order) := FUNCTION
		// Create PI51 using Order 
		Layout_PI51 xformOrder(Layout_Order L) := TRANSFORM
			self.RecCode 				:= Constants.PI51_IND;
			self.SeqNum					:= Constants.SEQ_NUM_DEFAULT;
			self.OccrNum				:= Constants.OCCR_NUM_DEFAULT;
			self.SecOccrNum			:= Constants.SEC_OCCR_NUM_DEFAULT;
			self 								:= L.PI01_Recs[1];
			self 								:= [];
		END;
		PI51Order := project(order(count(order.PI01_Recs)>0), xformOrder(left));
		// output(PI51Order, named('PI51Order'));
		return PI51Order;
	END;
	
	/*--------------------------------------------------------------------------*/	
	/* Construct PI51 Layout from Original Order and CompId Result Record       */
	/*--------------------------------------------------------------------------*/	
	SHARED DATASET(Layout_PI51) GeneratePI51Recs (DATASET(Layout_Order) order, 
																								DATASET(Layout_CompIdResult) compIdResultDS) := FUNCTION
		// temp layout for PI51
		Layout_PI51_Temp :=RECORD
			Layout_PI51;
			String2 id;
		END;
		
		// Create PI51 using Order 
		Layout_PI51_Temp xformOrder(Layout_Order L) := TRANSFORM
			self.UnitNum 				:= Constants.UNIT_NUM_DEFAULT;
			self.SeqNum					:= Constants.SEQ_NUM_DEFAULT;
			self.OccrNum				:= Constants.OCCR_NUM_DEFAULT;
			self.SecOccrNum			:= Constants.SEC_OCCR_NUM_DEFAULT;
			self.RecCode 				:= Constants.PI51_IND;
			self.ClassCode			:= 'RS';
			self.id 						:= '1';
			self 								:= [];
		END;
		PI51Order := project(order, xformOrder(left));
		
		// Create PI51 using CompId 
		Layout_PI51_Temp xformCompId(Layout_CompIdResult L) := TRANSFORM
			self.LastName			:= L.name_last;
			self.FirstName		:= L.name_first;
			self.MidName			:= L.name_middle;
			self.SufName			:= L.name_suffix;
			self.BirthDate		:= INTFORMAT(L.DOB, 8, 1);
			self.SexCode			:= L.Gender;
			self.SsnNum				:= L.SSN;
			self.RelDesc			:= L.remarks;
			self.id 					:= '1';
			self 							:= [];
		END;
		PI51CompId := project(compIdResultDS(score!=0), xformCompId(left));
		
		// Combine CompId and Order
		Layout_PI51_Temp denormThem(Layout_PI51_Temp L, Layout_PI51_Temp R) := TRANSFORM
			self.LastName			:= L.LastName;
			self.FirstName		:= L.FirstName;
			self.MidName			:= L.MidName;
			self.SufName			:= L.SufName;
			self.BirthDate		:= L.BirthDate;
			self.SexCode			:= L.SexCode;
			self.SsnNum				:= L.SsnNum;
			self.RelDesc			:= L.RelDesc;
			self 							:= R;
		END;
		DenormPI51 := denormalize(PI51CompId, PI51Order,	left.id = right.id AND length(trim(left.RelDesc)) > 0,	denormThem(LEFT,RIGHT));		
		
		// Project PI51_Temp to PI51 layout.
		PI51 := project(DenormPI51, Layout_PI51);
		return PI51;

	END;
	
	/* ********************** ALInput, ALOutput ******************************* */
	/*--------------------------------------------------------------------------*/	
	/* Construct Input AL51 Layout from Original Order and CompId Result Record */
	/*--------------------------------------------------------------------------*/	
	EXPORT DATASET(Layout_AL51) GenerateInputAL51Recs (DATASET(Layout_Order) order) := FUNCTION
		// Create AL51 using Order 
		Layout_AL51 xformOrder(Layout_Order L) := TRANSFORM
			self.RecCode 				:= Constants.AL51_IND;
			self.SeqNum					:= Constants.SEQ_NUM_DEFAULT;
			self.OccrNum				:= Constants.OCCR_NUM_DEFAULT;
			self.SecOccrNum			:= Constants.SEC_OCCR_NUM_DEFAULT;
			self 								:= L.AL01_Recs[1];
			self 								:= [];
		END;
		AL51Order := project(order(count(order.AL01_Recs)>0), xformOrder(left));
		// output(AL51Order, named('AL51Order'));
		return AL51Order;

	END;	
	
	/*------------------------------------------------------------------------*/	
	/* Construct AL Layout from Original Edits Record *//*DATASET(Layout_AL51)*/
	/*------------------------------------------------------------------------*/	
	export DATASET(Layout_AL51) GenerateAL51Recs (DATASET(Layout_Order) order, 
																								DATASET(Layout_CompIdResult) compIdResultDS) := FUNCTION
																								
		// Create an address dataset using comp-id result. 
		Layout_CompId_Address NormThem(Layout_CompIdResult L, INTEGER C) := TRANSFORM
				 self := MAP(C=1 => L.CurrentAddress, C=2 => L.PriorAddress1,
									C=3 => L.PriorAddress2, L.PriorAddress3);
		END;
		allAddressRecs := NORMALIZE(compIdResultDS, 4, NormThem(LEFT,COUNTER));
		addressRecs := allAddressRecs(addr <> '' AND city <> '' AND zip <> '');
		
		// temp layout for AL51
		Layout_AL51_Temp :=RECORD
			Layout_AL51;
			String2 id;
		END;
		
		// Transform Address DS to AL51 format
		Layout_AL51_Temp xformAddress(Layout_CompId_Address L, Integer C) := TRANSFORM
			self.ClassCode			:= if(C=1, Constants.CURRENT_ADDR, Constants.PRIOR_ADDR);
			self.HouseNum 			:= L.prim_range;
			self.StrName  			:= L.addr;
			self.AptNum   			:= L.unit;
			self.CityName 			:= L.city;
			self.StateCode			:= L.state;
			self.ZipNum   			:= L.zip;
			self.ZipSufNum			:= L.zip4;
			self.startDate			:= (String)L.dt_first_seen;
			self.endDate				:= (String)L.dt_max_seen;
			self.id 						:= '1';	
			self 								:= [];
		END;
		AL51Adr := project(addressRecs, xformAddress(left, counter));
		
		// Transform Order DS to AL51 format
		Layout_AL51_Temp xformOrder(Layout_Order L) := TRANSFORM
			self.UnitNum 				:= Constants.UNIT_NUM_DEFAULT;
			self.RecCode 				:= Constants.AL51_IND;
			self.id 						:= '1';
			self 								:= [];
		END;
		AL51Order := project(order, xformOrder(left));

		// Combine Address and Order
		Layout_AL51_Temp populateOrderFields(Layout_AL51_Temp L, Layout_AL51_Temp R) := TRANSFORM
			self.UnitNum				:= R.UnitNum;
			self.RecCode				:= R.RecCode;
			self.SeqNum					:= Constants.SEQ_NUM_DEFAULT;
			self.OccrNum				:= Constants.OCCR_NUM_DEFAULT;
			self.SecOccrNum			:= Constants.SEC_OCCR_NUM_DEFAULT;
			self := L;
		END;
		AL51_Denorm_Adr_Order := denormalize(AL51Adr, AL51Order,	left.id = right.id,	populateOrderFields(LEFT,RIGHT));		
		
		// Project AL51_Temp to Al51 layout.
		AL51 := project(AL51_Denorm_Adr_Order, Layout_AL51);
		// output(AL51, named('AL51'));
		return AL51;
	END;
	
	/* ********************** DLInput, DLOutput ******************************* */
	/*--------------------------------------------------------------------------*/	
	/* Construct Input DL51 Layout from Original Order and CompId Result Record */
	/*--------------------------------------------------------------------------*/	
	EXPORT DATASET(Layout_DL51) GenerateInputDL51Recs (DATASET(Layout_Order) order) := FUNCTION
		// Create DL51 using Order 
		Layout_DL51 xformOrder(Layout_Order L) := TRANSFORM
			self.RecCode 				:= Constants.DL51_IND;
			self.SeqNum					:= Constants.SEQ_NUM_DEFAULT;
			self.OccrNum				:= Constants.OCCR_NUM_DEFAULT;
			self.SecOccrNum			:= Constants.SEC_OCCR_NUM_DEFAULT;
			self 								:= L.DL01_Recs[1];
			self 								:= [];
		END;
		DL51Order := project(order(count(order.DL01_Recs)>0), xformOrder(left));
		// output(DL51Order, named('DL51Order'));
		return DL51Order;
	END;	
	
	/*--------------------------------------------------------------------------*/	
	/* Construct DL Layout from Original Edits Record                           */
	/*--------------------------------------------------------------------------*/	
	SHARED DATASET(Layout_DL51) GenerateDL51Recs (DATASET(Layout_Order) order, 
																								DATASET(Layout_CompIdResult) compIdResultDS) := FUNCTION
		// temp layout for DL51
		Layout_DL51_Temp :=RECORD
			Layout_DL51;
			String2 id;
		END;
		
		// Create DL51 using Order 
		Layout_DL51_Temp xformOrder(Layout_Order L) := TRANSFORM
			self.UnitNum 				:= Constants.UNIT_NUM_DEFAULT;
			self.SeqNum					:= Constants.SEQ_NUM_DEFAULT;
			self.OccrNum				:= Constants.OCCR_NUM_DEFAULT;
			self.SecOccrNum			:= Constants.SEC_OCCR_NUM_DEFAULT;
			self.RecCode 				:= Constants.DL51_IND;
			self.ClassCode			:= 'CP';
			self.id 						:= '1';
			self 								:= [];
		END;
		DL51Order := project(order, xformOrder(left));
		
		// Create DL51 using CompId 
		Layout_DL51_Temp xformCompId(Layout_CompIdResult L) := TRANSFORM
			self.LicNum									:= L.CurrentDL.dl_number;
			self.StateCode							:= L.CurrentDL.dlState;
			self.DriverRestrictText			:= L.CurrentDL.restrictions;
			self.LicIssueDate						:= INTFORMAT(L.CurrentDL.lic_issue_date, 8, 1);
			self.LicExprDate						:= INTFORMAT(L.CurrentDL.expiration_date, 8, 1);
			self.id 										:= '1';
			self 												:= [];
		END;
		// Include DL51 record only if you've valid DL in the CompId Result
		DL51CompId := project(compIdResultDS(TRIM(CurrentDL.dl_number) <> '' AND TRIM(CurrentDL.dlState) <> ''), xformCompId(left));

		// Combine CompId and Order
		Layout_DL51_Temp denormThem(Layout_DL51_Temp L, Layout_DL51_Temp R) := TRANSFORM
			self.LicNum									:= L.LicNum;
			self.StateCode							:= L.StateCode;
			self.DriverRestrictText			:= L.DriverRestrictText;
			self.LicIssueDate						:= L.LicIssueDate;
			self.LicExprDate						:= L.LicExprDate;
			self 												:= R;
		END;
		DenormDL51 := denormalize(DL51CompId, DL51Order,	(LEFT.id = RIGHT.id AND TRIM(LEFT.licnum) <> ''),	denormThem(LEFT, RIGHT));		
		
		// Project DL51_Temp to DL51 layout.
		DL51 := project(DenormDL51, Layout_DL51);
		// output(DL51, named('DL51'));
		return DL51;
	END;
	
	
	/* ********************** SHInput, SHOutput ******************************* */
	/*--------------------------------------------------------------------------*/	
	/* Construct Input SH51 Layout from Original Order 													*/
	/*--------------------------------------------------------------------------*/	
	EXPORT DATASET(Layout_SH51) GenerateInputSH51Recs (DATASET(Layout_Order) order) := FUNCTION
		// Create SH51 using Order 
		Layout_SH51 xformOrder(Layout_Order L) := TRANSFORM
			self.UnitNum 				:= Constants.UNIT_NUM_DEFAULT;
			self.SeqNum					:= Constants.SEQ_NUM_DEFAULT;
			self.RecCode				:= Constants.SH51_IND;
			self.OccrNum				:= Constants.OCCR_NUM_DEFAULT;
			self.SecOccrNum			:= Constants.SEC_OCCR_NUM_DEFAULT;
			self.SectCode				:= Constants.INQUIRY;
			self 								:= [];
		END;
		SH51Order := project(order, xformOrder(left));
		// output(SH51Order, named('SH51Order'));
		return SH51Order;
	END;	
	
	/*--------------------------------------------------------------------------*/	
	/* Construct Output SH51 Layout from Original Order 										  	*/
	/*--------------------------------------------------------------------------*/	
	EXPORT DATASET(Layout_SH51) GenerateSH51Recs (DATASET(Layout_CompIdResult) compIdResultDS) := FUNCTION
		// Create SH51 using Order 
		Layout_SH51 xformOrder(Layout_CompIdResult L) := TRANSFORM
			self.UnitNum 				:= Constants.UNIT_NUM_DEFAULT;
			self.SeqNum					:= Constants.SEQ_NUM_DEFAULT;
			self.RecCode				:= Constants.SH51_IND;
			self.OccrNum				:= Constants.OCCR_NUM_DEFAULT;
			self.SecOccrNum			:= Constants.SEC_OCCR_NUM_DEFAULT;
			self.SectCode				:= Constants.SUBJECT;
			self 								:= [];
		END;
		// Generate SH51 only for hit (Bug: 2252)
		SH51 := project(compIdResultDS(score != 0), xformOrder(left));
		// output(SH51, named('SH51'));
		return SH51;
	END;	

	/* ********************** RCOutput **************************************** */
	/*--------------------------------------------------------------------------*/	
	/* Construct Input RC51 Layout from Original Order 												  */
	/*--------------------------------------------------------------------------*/	
	SHARED DATASET(Layout_RC51) GenerateInputRC51Recs (DATASET(Layout_Order) order, 
																								DATASET(Layout_CompIdResult) compIdResultDS) := FUNCTION
		// Create RC51 using Order 
		Layout_RC51 xformOrder(Layout_Order L) := TRANSFORM
			self.UnitNum 				:= Constants.UNIT_NUM_DEFAULT;
			self.SeqNum					:= Constants.SEQ_NUM_DEFAULT;
			self.RecCode				:= Constants.RC51_IND;
			self.OccrANum				:= Constants.OCCR_NUM_DEFAULT;
			self.OccrBNum				:= Constants.SEC_OCCR_NUM_DEFAULT;
			self.SpcFtnClassCD	:= 'IN';
			self.SpcFtn1TypeCD	:= 'IR';
			self 								:= [];
		END;
		RC51WithoutScore := project(order, xformOrder(left));
		
		// Add number of PI records in the result (1 for hit, 0 for nohit)
		Layout_RC51 addScore(Layout_RC51 L) := TRANSFORM
			self.SpcFtn1TypeCT 			:= INTFORMAT((INTEGER)(if(compIdResultDS[1].score = 0, 0, 1)), 7, 1); // Pad Zeroes
			self := L;
		END;
		RC51 := project(RC51WithoutScore, addScore(left));
		
		// output(RC51, named('RC51'));
		return RC51;
	END;
	
	/*--------------------------------------------------------------------------*/	
	/* Construct Output RC51 Layout from Original Order 												*/
	/*--------------------------------------------------------------------------*/	
	SHARED DATASET(Layout_RC51) GenerateRC51Recs (DATASET(Layout_Order) order, 
																								DATASET(Layout_CompIdResult) compIdResultDS) := FUNCTION
		// Create RC51 using Order 
		Layout_RC51 xformOrder(Layout_CompIdResult L) := TRANSFORM
			self.UnitNum 				:= Constants.UNIT_NUM_DEFAULT;
			self.SeqNum					:= Constants.SEQ_NUM_DEFAULT;
			self.RecCode				:= Constants.RC51_IND;
			self.OccrANum				:= Constants.OCCR_NUM_DEFAULT;
			self.OccrBNum				:= Constants.SEC_OCCR_NUM_DEFAULT;
			self.SpcFtnClassCD	:= 'ST';
			self 								:= [];
		END;
		// Generate RC51 only for hit (Bug: 2252)
		RC51WithoutScore := project(compIdResultDS(score != 0), xformOrder(left));
		
		// Add score
		Layout_RC51 addScore(Layout_RC51 L) := TRANSFORM
			self.SpcFtn1TypeCT 			:= INTFORMAT((INTEGER)(if(compIdResultDS[1].score = 0, 0, 25)), 7, 1); // Pad Zeroes
			self := L;
		END;
		RC51 := project(RC51WithoutScore, addScore(left));
		
		// output(RC51, named('RC51'));
		return RC51;
	END;	
	
	/* ********************** RPOutput **************************************** */
	/*--------------------------------------------------------------------------*/	
	/* Construct Output RP51 Layout from Original Order 												*/
	/*--------------------------------------------------------------------------*/	
	EXPORT DATASET(Layout_RP51) GenerateRP51Recs (DATASET(Layout_Order) order) := FUNCTION
		// Create RP51 using Order 
		Layout_RP51 xformOrder(Layout_Order L) := TRANSFORM
			self.UnitNum 				:= Constants.UNIT_NUM_DEFAULT;
			self.SeqNum					:= Constants.SEQ_NUM_DEFAULT;
			self.RecCode				:= Constants.RP51_IND;
			self.FirstOccrNum		:= Constants.OCCR_NUM_DEFAULT;
			self.SecOccrNum			:= Constants.SEC_OCCR_NUM_DEFAULT;
			self.RQStrName   		:= L.RP01_Recs[1].RptRqstrName;
			self 								:= [];
		END;
		RP51 := project(order(count(order.RP01_Recs)>0), xformOrder(left));
		// output(RP51, named('RP51'));
		return RP51;
	END;	

	/* ********************** RI52Output ************************************** */
	/*--------------------------------------------------------------------------*/	
	/* Construct Output RI52 Layout from Original Order 												*/
	/*--------------------------------------------------------------------------*/	
	EXPORT DATASET(Layout_RI52) GenerateRI52Recs (DATASET(Layout_Order) order) := FUNCTION
		// Create RI52 using Order 
		Layout_RI52 xformOrder(Layout_Order L) := TRANSFORM
			self.UnitNum 				:= Constants.UNIT_NUM_DEFAULT;
			self.SeqNum					:= Constants.SEQ_NUM_DEFAULT;
			self.RecCode				:= Constants.RI52_IND;
			self.OccrNum				:= Constants.OCCR_NUM_DEFAULT;
			self.SecOccrNum			:= Constants.SEC_OCCR_NUM_DEFAULT;
			
			self.OrgCode 				:= L.RI02_Recs[1].CustOrgLvl1Code;
			self.Org2Code 			:= L.RI02_Recs[1].CustOrgLvl2Code;
			self.Org3Code 			:= L.RI02_Recs[1].CustOrgLvl3Code;
			self.Org4Code 			:= L.RI02_Recs[1].CustOrgLvl4Code;

			self.SplIdDesc 			:= L.RI02_Recs[1].RptSplFldId1Desc;
			self.SplId2Desc 		:= L.RI02_Recs[1].RptSplFldId2Desc;
			self.SplId3Desc 		:= L.RI02_Recs[1].RptSplFldId3Desc;
			self.SplId4Desc 		:= L.RI02_Recs[1].RptSplFldIdADesc;
			self.SplId5Desc 		:= L.RI02_Recs[1].RptSplFldIdBDesc;
			self.SplId6Desc 		:= L.RI02_Recs[1].RptSplFldIdCDesc;
			self.SpecNumField 	:= L.RI02_Recs[1].RptSpecFldId1Num;

			self 								:= [];
		END;
		RI52 := project(order(count(order.RI02_Recs)>0), xformOrder(left));
		// output(RI52,  named('RI52'));
		return RI52;
	END;	
	
	
	/*--------------------------------------------------------------------------*/	
	/* Format the Edits response V1                                             */
	/*--------------------------------------------------------------------------*/	
	EXPORT DATASET(Layout_Response) FormatResponse(DATASET(Layout_Order) order, 
																								  DATASET(Layout_CompIdResult) compIdResultDS) := FUNCTION
		
		// Project orignial edits orders onto the order layout
		Layout_Response xfromResponse(Layout_Order L) := TRANSFORM
			self.RI51_Recs := GenerateRI51Recs(order, compIdResultDS);
			self.RI52_Recs := GenerateRI52Recs(order);
			self.RP51_Recs := GenerateRP51Recs(order);
			self.RC51_Inq_Recs := GenerateInputRC51Recs(order, compIdResultDS);
			
			// Inquiry Records
			self.SH51_Inq_Recs := GenerateInputSH51Recs(order);
			self.PI51_Inq_Recs := GenerateInputPI51Recs(order);
			self.AL51_Inq_Recs := GenerateInputAL51Recs(order);
			self.DL51_Inq_Recs := GenerateInputDL51Recs(order);
			
			// Output Records		
			self.SH51_Recs := GenerateSH51Recs(compIdResultDS);
			self.RC51_Recs := GenerateRC51Recs(order, compIdResultDS);
			self.PI51_Recs := GeneratePI51Recs(order, compIdResultDS);
			self.AL51_Recs := GenerateAL51Recs(order, compIdResultDS);
			self.DL51_Recs := GenerateDL51Recs(order, compIdResultDS);
			self := [];
		END;
		response := project(order,	xfromResponse(left));		
		//output(response, named('Order_Response'));		
		return response;
	END;
	
	/*--------------------------------------------------------------------------*/	
	/* Format the Edits response V2                                             */
	/*--------------------------------------------------------------------------*/	
	
	/*---------- Personal Response ----------*/
	EXPORT buildPersonalResponse(DATASET(Layout_PI51) recs) := FUNCTION
		return PROJECT(recs, 
										TRANSFORM(Layout_Response_Temp, SELF.rec := TRANSFER(LEFT, STRING230)));
	END;
	
	/*---------- Address Response ----------*/	
	EXPORT buildAddressResponse(DATASET(Layout_AL51) recs) := FUNCTION
		return PROJECT(recs, 
										TRANSFORM(Layout_Response_Temp, SELF.rec := TRANSFER(LEFT, STRING230)));
	END;
	
	/*---------- Driver Response ----------*/	
	EXPORT buildDriverResponse(DATASET(Layout_DL51) recs) := FUNCTION
		return PROJECT(recs, 
										TRANSFORM(Layout_Response_Temp, SELF.rec := TRANSFER(LEFT, STRING230)));
	END;
	
	/*---------- Header Records ----------*/	
	EXPORT getHeaderRecords(DATASET(Layout_Response) response) := FUNCTION
	
		ri51					:= PROJECT(response.RI51_Recs, 
															TRANSFORM(Layout_Response_Temp, SELF.rec := TRANSFER(LEFT, STRING230)));

		ri52					:= PROJECT(response.RI52_Recs, 
															TRANSFORM(Layout_Response_Temp, SELF.rec := TRANSFER(LEFT, STRING230)));
															
		rpRec					:= PROJECT(response.RP51_Recs, 
															TRANSFORM(Layout_Response_Temp, SELF.rec := TRANSFER(LEFT, STRING230)));

		rcRec					:= PROJECT(response.RC51_Inq_Recs, 
															TRANSFORM(Layout_Response_Temp, SELF.rec := TRANSFER(LEFT, STRING230)));

		headerRecs 		:= ri51 & ri52 & rpRec & rcRec;
		return headerRecs;
	END;
	
	/*---------- Inquiry Records ----------*/		
	EXPORT getInquiryRecords(DATASET(Layout_Response) response) := FUNCTION
		shRecInq			:= PROJECT(response.SH51_Inq_Recs, 
															TRANSFORM(Layout_Response_Temp, SELF.rec := TRANSFER(LEFT, STRING230)));

		personalInq 	:= buildPersonalResponse(response.PI51_Inq_Recs);
		driverInq 		:= buildDriverResponse(response.DL51_Inq_Recs);
		addressInq 		:= buildAddressResponse(response.AL51_Inq_Recs);

		inquiryRecs 	:= shRecInq & personalInq & driverInq & addressInq;
		return inquiryRecs;
	END;
	
	/*---------- Subject Records ----------*/		
	EXPORT getSubjectRecords(DATASET(Layout_Response) response) := FUNCTION
		shRec					:= PROJECT(response.SH51_Recs, 
															TRANSFORM(Layout_Response_Temp, SELF.rec := TRANSFER(LEFT, STRING230)));

		rcRec					:= PROJECT(response.RC51_Recs, 
															TRANSFORM(Layout_Response_Temp, SELF.rec := TRANSFER(LEFT, STRING230)));

		personal 			:= buildPersonalResponse(response.PI51_Recs);
		driver 				:= buildDriverResponse(response.DL51_Recs);
		address 			:= buildAddressResponse(response.AL51_Recs);

		subjectRecs 	:= shRec & rcRec & personal & driver & address;
		return subjectRecs;
	END;
	
	/*---------- Final Edits Response ----------*/	
	EXPORT FormatEditResponse(DATASET(Layout_Response) response) := FUNCTION
		
		// Header
		headerRecs 		:= getHeaderRecords(response);
		// Inquiry 
		inquiryRecs 	:= getInquiryRecords(response);
		// Subject
		subjectRecs 	:= getSubjectRecords(response);

		// Generate Response
		iesp.cp_internal.t_EditsOutputSet createESPRecord(Layout_Response_Temp L, DATASET(Layout_Response_Temp) R) := TRANSFORM
			SELF.EditsOutputRecords := PROJECT(R, TRANSFORM(iesp.share.t_StringArrayItem, 
																											SELF.value := LEFT.rec, 
																											SELF := [];));
			SELF := [];
		END;
		
		hitResponse   := ROLLUP(GROUP(headerRecs & inquiryRecs & subjectRecs, seq), 
														GROUP, 
														createESPRecord(left,rows(left)));
														
		nohitResponse := ROLLUP(GROUP(headerRecs & inquiryRecs, seq),
														GROUP, 
														createESPRecord(left,rows(left)));
		
    editsResponse := if(response.RC51_Recs[1].SpcFtn1TypeCT = (String)0, noHitResponse, hitResponse);											 
		// output(headerRecs, named('headerRecs'));
		// output(inquiryRecs, named('inquiryRecs'));
		// output(subjectRecs, named('subjectRecs'));
		return editsResponse;
	END;
	
END;
