IMPORT CompId_Services, iesp, ut;

/* Parser: Translates the ADD result into specific layouts viz RI, PI, AL, DL, etc of edit response */
EXPORT Mod_Format_ADD := MODULE
	
	SHARED ModFormat		  		 				:= EditsV2.Mod_Format;

	// General layouts	
	SHARED Layout_StrArrayItem 				:= iesp.share.t_StringArrayItem;
	SHARED Layout_Order 							:= EditsV2.Layouts_Order.order;
	SHARED Layout_CompId_Address 			:= CompId_Services.Layouts.Layout_Address;
	SHARED Layout_PersonalID_ADD			:= CompId_Services.Layouts.Layout_Add_PersonalID;
	SHARED Layout_CompIdResult_ADD	 	:= CompId_Services.Layouts.Layout_Add_Result;
	SHARED Layout_Response 						:= EditsV2.Layouts_Response.response;
	
	// Specific layouts
	SHARED Layout_RI51 := EditsV2.Layouts_Response.RI51_V2;
	SHARED Layout_PI51 := EditsV2.Layouts_Response.PI51_V2;
	SHARED Layout_AL51 := EditsV2.Layouts_Response.AL51_V2;
	SHARED Layout_DL51 := EditsV2.Layouts_Response.DL51_V2;
	SHARED Layout_SH51 := EditsV2.Layouts_Response.SH51_V2;
	SHARED Layout_RC51 := EditsV2.Layouts_Response.RC51_V2;
	SHARED Layout_RP51 := EditsV2.Layouts_Response.RP51_V2;
	SHARED Layout_RI52 := EditsV2.Layouts_Response.RI52_V2;
	
	SHARED Layout_Response_Temp := Mod_Format.Layout_Response_Temp;
	SHARED Layout_Response_Temp2 := record	String rec;	integer id;	end;		
	
	SHARED ConvertDate(STRING inpDate) := inpDate[5..6]
												+	inpDate[7..8]
												+ inpDate[1..4];
	
	/*--------------------------------------------------------------------------*/
	/* Construct RI51 Layout from Original Order and ADD Result Record       */
	/*--------------------------------------------------------------------------*/
	SHARED DATASET(Layout_RI51) GenerateRI51Recs (DATASET(Layout_Order) order, 
																								DATASET(Layout_CompIdResult_ADD) addResultDS) := FUNCTION

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
			// self.ProdCode 							:= L.RI01_Recs[1].ProdLineCode;
			self.ProdCode 							:= ''; // Do not send the Permissible Purpose back. DefectId: 2246
			self.RecVerNum							:= L.RI01_Recs[1].RecVerNum;
			self := [];
		END;
		RI51WithoutStatusCode := project(order, xformOrder(left));
		
		// Add status code
		Layout_RI51 addStatusCode(Layout_RI51 L) := TRANSFORM
			self.ReportStatusCode 			:= (String)if(addResultDS[1].score = 0, Constants.NO_HIT_IND, Constants.HIT_IND); // 1-No Hit, 2-Hit
			self := L;
		END;
		RI51 := project(RI51WithoutStatusCode, addStatusCode(left));
		// output(RI51, named('RI51_ADD'));
		return RI51;
	END;
	
	/*--------------------------------------------------------------------------*/	
	/* Construct Output RC51 Layout from Original Order 												*/
	/*--------------------------------------------------------------------------*/	
	SHARED DATASET(Layout_RC51) GenerateRC51Recs (DATASET(Layout_Order) order, 
																								DATASET(Layout_CompIdResult_ADD) addResultDS) := FUNCTION
		// Create RC51 using Order 
		Layout_RC51 xformOrder(Layout_Order L) := TRANSFORM
			self.UnitNum 				:= Constants.UNIT_NUM_DEFAULT;
			self.SeqNum					:= Constants.SEQ_NUM_DEFAULT;
			self.RecCode				:= Constants.RC51_IND;
			self.OccrANum				:= Constants.OCCR_NUM_DEFAULT;
			self.OccrBNum				:= Constants.SEC_OCCR_NUM_DEFAULT;
			self.SpcFtnClassCD	:= 'ST';
			self 								:= [];
		END;
		RC51WithoutScore := project(order, xformOrder(left));
		
		// Add score
		Layout_RC51 addScore(Layout_RC51 L) := TRANSFORM
			self.SpcFtn1TypeCT 			:= INTFORMAT((INTEGER)(if(addResultDS[1].score = 0, 0, 25)), 7, 1); // Pad Zeroes
			self := L;
		END;
		RC51 := project(RC51WithoutScore, addScore(left));
		// output(RC51, named('RC51_ADD'));
		return RC51;
	END;	
	
	/*--------------------------------------------------------------------------*/	
	/* Construct PI51 Layout from Original Order and ADD Result Record       */
	/*--------------------------------------------------------------------------*/	
	SHARED DATASET(Layout_PI51) GeneratePI51Recs (DATASET(Layout_Order) order, 
																								DATASET(Layout_CompIdResult_ADD) addResultDS) := FUNCTION
		// temp layout for PI51
		Layout_PI51_v1 :=RECORD
			Layout_PI51;
			String2 id;
		END;
		
		// Create PI51 using Order 
		Layout_PI51_v1 xformOrder(Layout_Order L) := TRANSFORM
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
		Layout_PI51_v1 xformCompId(Layout_PersonalID_ADD L) := TRANSFORM
			self.LastName			:= L.name_last;
			self.FirstName		:= L.name_first;
			self.MidName			:= L.name_middle;
			self.SufName			:= L.name_suffix;
			self.BirthDate		:= INTFORMAT(L.DOB, 8, 1);
			self.SexCode			:= L.Gender;
			self.SsnNum				:= L.SSN;
			self.RelDesc			:= (STRING)L.DID;
			self.id 					:= '1';
			self 							:= [];
		END;
		PI51CompId := project(addResultDS.namesList, xformCompId(left));

		// Combine CompId and Order
		Layout_PI51_v1 joinThem(Layout_PI51_v1 L, Layout_PI51_v1 R) := TRANSFORM
			self.LastName			:= R.LastName;
			self.FirstName		:= R.FirstName;
			self.MidName			:= R.MidName;
			self.SufName			:= R.SufName;
			self.BirthDate		:= R.BirthDate;
			self.SexCode			:= R.SexCode;
			self.SsnNum				:= R.SsnNum;
			self.RelDesc			:= R.RelDesc;
			self 							:= L;
		END;
		
		joinPI51 := join(PI51Order, PI51CompId, left.id = right.id, joinThem(left, right), LEFT OUTER);
		// Project PI51_V1 to PI51 layout.
		PI51 := project(joinPI51, Layout_PI51);
		// output(PI51, named('PI51_ADD'));
		return PI51;

	END;
	
	/*------------------------------------------------------------------------*/	
	/* Construct AL Layout from Original Edits Record *//*DATASET(Layout_AL51)*/
	/*------------------------------------------------------------------------*/	
	export DATASET(Layout_AL51) GenerateAL51Recs (DATASET(Layout_Order) order, 
																								DATASET(Layout_CompIdResult_ADD) addResultDS) := FUNCTION
																								
		// temp layout for AL51
		Layout_AL51_v1 :=RECORD
			Layout_AL51;
			String2 id;
		END;
		
		// Transform Address DS to AL51 format
		Layout_AL51_v1 xformAddress(Layout_CompIdResult_ADD L) := TRANSFORM
			self.ClassCode			:= '';		// Updated
			self.HouseNum 			:= L.currentAddress.prim_range;
			self.StrName  			:= L.currentAddress.addr;
			self.AptNum   			:= L.currentAddress.unit;
			self.CityName 			:= L.currentAddress.city;
			self.StateCode			:= L.currentAddress.state;
			self.ZipNum   			:= L.currentAddress.zip;
			self.ZipSufNum			:= L.currentAddress.zip4;
			self.startDate			:= (String)L.currentAddress.dt_first_seen;
			self.endDate				:= (String)L.currentAddress.dt_max_seen;
			self.id 						:= '1';	
			self 								:= [];
		END;
		AL51Adr := project(addResultDS, xformAddress(left));
		
		// Transform Order DS to AL51 format
		Layout_AL51_v1 xformOrder(Layout_Order L) := TRANSFORM
			self.UnitNum 				:= Constants.UNIT_NUM_DEFAULT;
			self.RecCode 				:= Constants.AL51_IND;
			self.ClassCode			:= Constants.CURRENT_ADDR;
			self.id 						:= '1';
			self 								:= [];
		END;
		AL51Order := project(order, xformOrder(left));

		// Combine Address and Order
		Layout_AL51_v1 populateOrderFields(Layout_AL51_v1 L, Layout_AL51_v1 R) := TRANSFORM
			self.UnitNum				:= R.UnitNum;
			self.RecCode				:= R.RecCode;
			self.ClassCode			:= R.ClassCode;
			self.SeqNum					:= Constants.SEQ_NUM_DEFAULT;
			self.OccrNum				:= Constants.OCCR_NUM_DEFAULT;
			self.SecOccrNum			:= Constants.SEC_OCCR_NUM_DEFAULT;
			self := L;
		END;
    AL51_Denorm_Adr_Order := denormalize(AL51Adr, AL51Order,	left.id = right.id,	populateOrderFields(LEFT,RIGHT));		

		// Project AL51_V1 to Al51 layout.
		AL51 := project(AL51_Denorm_Adr_Order, Layout_AL51);
		// output(AL51, named('AL51_ADD'));
		return AL51;
	END;
	
	/*--------------------------------------------------------------------------*/	
	/* Construct DL Layout from Original Edits Record                           */
	/*--------------------------------------------------------------------------*/	
	SHARED DATASET(Layout_DL51) GenerateDL51Recs (DATASET(Layout_Order) order, 
																								DATASET(Layout_CompIdResult_ADD) addResultDS) := FUNCTION
		// temp layout for DL51
		Layout_DL51_v1 :=RECORD
			Layout_DL51;
			String2 id;
		END;
		
		// Create DL51 using Order 
		Layout_DL51_v1 xformOrder(Layout_Order L) := TRANSFORM
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
		Layout_DL51_v1 xformCompId(Layout_PersonalID_ADD L) := TRANSFORM
			self.LicNum									:= L.CurrentDL.dl_number;
			self.StateCode							:= L.CurrentDL.dlState;
			self.DriverRestrictText			:= L.CurrentDL.restrictions;
			self.LicIssueDate						:= INTFORMAT(L.CurrentDL.lic_issue_date, 8, 1);
			self.LicExprDate						:= INTFORMAT(L.CurrentDL.expiration_date, 8, 1);
			self.id 										:= '1';
			self 												:= [];
		END;
		// Include DL51 record only if you've valid DL in the CompId Result
		DL51CompId := project(addResultDS.namesList, xformCompId(left));

		// Combine CompId and Order
		Layout_DL51_v1 joinThem(Layout_DL51_v1 L, Layout_DL51_v1 R) := TRANSFORM
			self.LicNum									:= L.LicNum;
			self.StateCode							:= L.StateCode;
			self.DriverRestrictText			:= L.DriverRestrictText;
			self.LicIssueDate						:= L.LicIssueDate;
			self.LicExprDate						:= L.LicExprDate;
			self 												:= R;
		END;
		joinDL51 := join(DL51CompId, DL51Order, LEFT.id = RIGHT.id, joinThem(left, right), LEFT OUTER);
		
		// Project DL51_V1 to DL51 layout.
		DL51 := project(joinDL51, Layout_DL51);
		// output(DL51, named('DL51_ADD'));
		return DL51;
	END;
	
	/*--------------------------------------------------------------------------*/	
	/* Construct Input RC51 Layout from Original Order 												  */
	/*--------------------------------------------------------------------------*/	
	SHARED DATASET(Layout_RC51) GenerateInputRC51Recs (DATASET(Layout_Order) order, 
																										 DATASET(Layout_CompIdResult_ADD) addResultDS) := FUNCTION
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
		
		// Add number of PI records in the result (hardcoding to 1)
		Layout_RC51 addScore(Layout_RC51 L) := TRANSFORM
			self.SpcFtn1TypeCT 			:= INTFORMAT(count(addResultDS[1].namesList(name_first <> '' and name_last <> '')), 7, 1); // Pad Zeroes
			self := L;
		END;
		
		// RC Output
		RC51 := project(RC51WithoutScore, addScore(left));
		// output(RC51, named('RC51_ADD'));
		return RC51;
	END;
	
	/*--------------------------------------------------------------------------*/	
	/* Construct Output SH51 Layout from Original Order 										  	*/
	/*--------------------------------------------------------------------------*/	
	EXPORT DATASET(Layout_SH51) GenerateSH51Recs (DATASET(Layout_CompIdResult_ADD) addResultDS) := FUNCTION
		// Create SH51 using Order 
		Layout_SH51 xformOrder(Layout_CompIdResult_ADD L) := TRANSFORM
			self.UnitNum 				:= Constants.UNIT_NUM_DEFAULT;
			self.SeqNum					:= Constants.SEQ_NUM_DEFAULT;
			self.RecCode				:= Constants.SH51_IND;
			self.OccrNum				:= Constants.OCCR_NUM_DEFAULT;
			self.SecOccrNum			:= Constants.SEC_OCCR_NUM_DEFAULT;
			self.SectCode				:= Constants.SUBJECT;
			self 								:= [];
		END;
		SH51 := project(addResultDS(score != 0), xformOrder(left));
		// output(SH51, named('SH51'));
		return SH51;
	END;
	
	/*--------------------------------------------------------------------------*/	
	/* Format the Edits response V1                                             */
	/*--------------------------------------------------------------------------*/	
	EXPORT /*DATASET(Layout_Response)*/ FormatADDResponse(DATASET(Layout_Order) order, 
																								  DATASET(Layout_CompIdResult_ADD) addResultDS) := FUNCTION
		
		// Project orignial edits orders onto the order layout
		RI51_Recs := GenerateRI51Recs(order, addResultDS);
		Layout_Response xfromResponse(Layout_Order L) := TRANSFORM
			self.RI51_Recs 			:= GenerateRI51Recs(order, addResultDS);
			self.RI52_Recs 			:= ModFormat.GenerateRI52Recs(order);
			self.RP51_Recs 			:= ModFormat.GenerateRP51Recs(order);
			
			// Inquiry Records
			self.RC51_Inq_Recs 	:= GenerateInputRC51Recs(order, addResultDS);
			self.SH51_Inq_Recs 	:= ModFormat.GenerateInputSH51Recs(order);
			self.PI51_Inq_Recs 	:= ModFormat.GenerateInputPI51Recs(order);
			self.AL51_Inq_Recs 	:= ModFormat.GenerateInputAL51Recs(order);
			self.DL51_Inq_Recs 	:= ModFormat.GenerateInputDL51Recs(order);
			
			// Output Records		
			self.SH51_Recs := GenerateSH51Recs(addResultDS);
			self.RC51_Recs := GenerateRC51Recs(order, addResultDS);
			self.PI51_Recs := GeneratePI51Recs(order, addResultDS);
			self.AL51_Recs := GenerateAL51Recs(order, addResultDS);
			self.DL51_Recs := GenerateDL51Recs(order, addResultDS);
			self := [];
		END;
		response := project(order,	xfromResponse(left));		
		// output(response, named('Order_Response_ADD'));		
		return response;
	END;
	
	/*--------------------------------------------------------------------------*/	
	/* Format ADD Edits response V2                                             */
	/*--------------------------------------------------------------------------*/	
	/*---------- Final Edit Response ----------*/	
	EXPORT FormatADDEditResponse(DATASET(Layout_Response) response) := FUNCTION
		
		// Header
		headerRecs 		:= ModFormat.getHeaderRecords(response);
		// Inquiry 
		inquiryRecs 	:= ModFormat.getInquiryRecords(response);
		// Subject Records
		shRec					:= PROJECT(response.SH51_Recs, 
															TRANSFORM(Layout_Response_Temp, SELF.rec := TRANSFER(LEFT, STRING230)));

		rcRec					:= PROJECT(response.RC51_Recs, 
															TRANSFORM(Layout_Response_Temp, SELF.rec := TRANSFER(LEFT, STRING230)));

		/***///Build person and driver record.
		Layout_Response_Temp2 assignId(Layout_Response_Temp L, integer C) := transform
			self.rec  := L.rec;
			self.id   := C;
		end;
		personRec := PROJECT(ModFormat.buildPersonalResponse(response.PI51_Recs), assignId(left, counter));
		driverRec := PROJECT(ModFormat.buildDriverResponse(response.DL51_Recs), assignId(left, counter));
		validDriverRec 						:= driverRec(trim(rec[17..41]) <>'' AND trim(rec[42..43])<>'');
		personAndDriverRecWithId 	:= sort(personRec + validDriverRec, id);
		personAndDriverRec 				:= project(personAndDriverRecWithId, Layout_Response_Temp);
		/***/
		address 			:= ModFormat.buildAddressResponse(response.AL51_Recs);
		subjectRecs 	:= shRec & rcRec & personAndDriverRec & address;

		// Generate Response
		iesp.cp_internal.t_EditsOutputSet createESPRecord(Layout_Response_Temp L,dataset(Layout_Response_Temp) R) := TRANSFORM
			SELF.EditsOutputRecords := PROJECT(R, TRANSFORM(iesp.share.t_StringArrayItem, 
																											SELF.value := LEFT.rec, 
																											SELF := [];));
			SELF := [];
		END;
		
		hitResponse   := ROLLUP(GROUP(headerRecs & inquiryRecs & subjectRecs, seq), 
														group, 
														createESPRecord(left,rows(left)));
		nohitResponse := ROLLUP(GROUP(headerRecs & inquiryRecs, seq), 
														group, 
														createESPRecord(left,rows(left)));
											 
    editResponse := if(response.RC51_Recs[1].SpcFtn1TypeCT = (String)0, noHitResponse, hitResponse);											 
		// output(personRec, named('personRec_ADD'));
		// output(driverRec, named('driverRec_ADD'));
		// output(validDriverRec, named('validDriverRec_ADD'));
		// output(response, named('FormatEditResponse_ADD'));
		return editResponse;
	END;
	
END;
