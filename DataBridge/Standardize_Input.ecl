IMPORT  ut, _Validate, std, mdr;

EXPORT Standardize_Input := MODULE

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	//////////////////////////////////////////////////////////////////////////////////////
	EXPORT fPreProcess(DATASET(DataBridge.Layouts.Sprayed_Input) pRawInput, STRING pversion) := FUNCTION
		
		DataBridge.Layouts.Base tPreProcess(DataBridge.Layouts.Sprayed_Input L) := TRANSFORM,SKIP(ut.CleanSpacesAndUpper(l.Company) in ['','NONE'])
		  
 		 	SELF.process_date                 := STD.Date.CurrentDate(TRUE);
			trans_date_with_day               := TRIM(l.Transaction_date,LEFT,RIGHT) + '01';
			SELF.dt_first_seen								:= IF(_validate.date.fIsValid(trans_date_with_day) and _validate.date.fIsValid(trans_date_with_day,_validate.date.rules.DateInPast), (UNSIGNED4)trans_date_with_day, 0);
			SELF.dt_last_seen									:= IF(_validate.date.fIsValid(trans_date_with_day) and _validate.date.fIsValid(trans_date_with_day,_validate.date.rules.DateInPast), (UNSIGNED4)trans_date_with_day, 0);
			SELF.dt_vendor_first_reported			:= IF(_validate.date.fIsValid(pversion[1..8]) and _validate.date.fIsValid(pversion[1..8],_validate.date.rules.DateInPast), (UNSIGNED4)pversion[1..8], 0);
			SELF.dt_vendor_last_reported			:= IF(_validate.date.fIsValid(pversion[1..8]) and _validate.date.fIsValid(pversion[1..8],_validate.date.rules.DateInPast), (UNSIGNED4)pversion[1..8], 0);
			SELF.record_type            			:= 'C';
			SELF.source 											:= MDR.sourceTools.src_databridge;

			//Populate the raw input fields
			SELF.Name													:= ut.CleanSpacesAndUpper(l.Name);
			SELF.Company  										:= ut.CleanSpacesAndUpper(l.Company);
			SELF.Address											:= ut.CleanSpacesAndUpper(l.Address);
			SELF.Address2											:= ut.CleanSpacesAndUpper(l.Address2);
			SELF.City     										:= ut.CleanSpacesAndUpper(l.City);
			SELF.State												:= ut.CleanSpacesAndUpper(l.State);
			SELF.SCF						        			:= ut.CleanSpacesAndUpper(l.SCF);
			SELF.Zip_Code5										:= ut.CleanSpacesAndUpper(l.Zip_Code5);
			SELF.Zip_Code4 										:= ut.CleanSpacesAndUpper(l.Zip_Code4);
			SELF.Mail_Score   								:= ut.CleanSpacesAndUpper(l.Mail_Score);
			SELF.Area_Code										:= ut.CleanSpacesAndUpper(l.Area_Code);
			SELF.Telephone_Number							:= ut.CleanSpacesAndUpper(l.Telephone_Number);
			SELF.Name_Gender									:= ut.CleanSpacesAndUpper(l.Name_Gender);
			SELF.Name_Prefix									:= ut.CleanSpacesAndUpper(l.Name_Prefix);
			SELF.Name_First	  								:= ut.CleanSpacesAndUpper(l.Name_First);
			SELF.Name_Middle_Initial					:= ut.CleanSpacesAndUpper(l.Name_Middle_Initial);
			SELF.Name_Last										:= ut.CleanSpacesAndUpper(l.Name_Last);
			SELF.Suffix		      				  		:= ut.CleanSpacesAndUpper(l.Suffix);
			SELF.Title_Code_1								  := ut.CleanSpacesAndUpper(l.Title_Code_1);
			SELF.Title_Code_2									:= ut.CleanSpacesAndUpper(l.Title_Code_2);
			SELF.Title_Code_3									:= ut.CleanSpacesAndUpper(l.Title_Code_3);
			SELF.Title_Code_4									:= ut.CleanSpacesAndUpper(l.Title_Code_4);
			SELF.Web_Address									:= ut.CleanSpacesAndUpper(l.Web_Address);
			SELF.SIC8_1										    := ut.CleanSpacesAndUpper(l.SIC8_1);
			SELF.SIC8_2											  := ut.CleanSpacesAndUpper(l.SIC8_2);
			SELF.SIC8_3											  := ut.CleanSpacesAndUpper(l.SIC8_3);
			SELF.SIC8_4												:= ut.CleanSpacesAndUpper(l.SIC8_4);
			SELF.SIC6_1												:= ut.CleanSpacesAndUpper(l.SIC6_1);
			SELF.SIC6_2												:= ut.CleanSpacesAndUpper(l.SIC6_2);
			SELF.SIC6_3												:= ut.CleanSpacesAndUpper(l.SIC6_3);
			SELF.SIC6_4												:= ut.CleanSpacesAndUpper(l.SIC6_4);
			SELF.SIC6_5												:= ut.CleanSpacesAndUpper(l.SIC6_5);
			SELF.Transaction_date             := ut.CleanSpacesAndUpper(l.Transaction_date);
			SELF.Database_Site_ID							:= ut.CleanSpacesAndUpper(l.Database_Site_ID);
			SELF.Database_Individual_ID				:= ut.CleanSpacesAndUpper(l.Database_Individual_ID);
			SELF.Email												:= ut.CleanSpacesAndUpper(l.Email);
			SELF.Email_Present_Flag						:= ut.CleanSpacesAndUpper(l.Email_Present_Flag);
			SELF.Site_Source1									:= ut.CleanSpacesAndUpper(l.Site_Source1);
			SELF.Site_Source2									:= ut.CleanSpacesAndUpper(l.Site_Source2);
			SELF.Site_Source3									:= ut.CleanSpacesAndUpper(l.Site_Source3);
			SELF.Site_Source4									:= ut.CleanSpacesAndUpper(l.Site_Source4);
			SELF.Site_Source5									:= ut.CleanSpacesAndUpper(l.Site_Source5);
			SELF.Site_Source6									:= ut.CleanSpacesAndUpper(l.Site_Source6);
			SELF.Site_Source7									:= ut.CleanSpacesAndUpper(l.Site_Source7);
			SELF.Site_Source8									:= ut.CleanSpacesAndUpper(l.Site_Source8);
			SELF.Site_Source9									:= ut.CleanSpacesAndUpper(l.Site_Source9);
			SELF.Site_Source10								:= ut.CleanSpacesAndUpper(l.Site_Source10);
			SELF.Individual_Source1						:= ut.CleanSpacesAndUpper(l.Individual_Source1);
			SELF.Individual_Source2						:= ut.CleanSpacesAndUpper(l.Individual_Source2);
			SELF.Individual_Source3						:= ut.CleanSpacesAndUpper(l.Individual_Source3);
			SELF.Individual_Source4						:= ut.CleanSpacesAndUpper(l.Individual_Source4);
			SELF.Individual_Source5						:= ut.CleanSpacesAndUpper(l.Individual_Source5);
			SELF.Individual_Source6						:= ut.CleanSpacesAndUpper(l.Individual_Source6);
			SELF.Individual_Source7						:= ut.CleanSpacesAndUpper(l.Individual_Source7);
			SELF.Individual_Source8						:= ut.CleanSpacesAndUpper(l.Individual_Source8);
			SELF.Individual_Source9						:= ut.CleanSpacesAndUpper(l.Individual_Source9);
			SELF.Individual_Source10					:= ut.CleanSpacesAndUpper(l.Individual_Source10);
			SELF.Email_Status									:= ut.CleanSpacesAndUpper(l.Email_Status);
			//************ EXPLODED VALUES
			SELF.Mail_Score_Desc              := MAP(TRIM(l.Mail_Score,LEFT,RIGHT) IN ['1','2','3','4'] => 'DELIVERABLE',
																							 TRIM(l.Mail_Score,LEFT,RIGHT) = '5'                => 'QUESTIONABLE',
																							 TRIM(l.Mail_Score,LEFT,RIGHT) IN ['6','7','8']     => 'UNDELIVERABLE',
																							 ''
																							 );
			SELF.Name_Gender_Desc             := MAP(ut.CleanSpacesAndUpper(l.Name_Gender) in ['0','UNDEFINED'] => 'UNDEFINED',
																							 TRIM(l.Name_Gender,LEFT,RIGHT) = '1'                       => 'MALE',
																							 TRIM(l.Name_Gender,LEFT,RIGHT) = '2'                       => 'FEMALE',
																							 TRIM(l.Name_Gender,LEFT,RIGHT) = '3'                       => 'UNKNOWN',
																							 TRIM(l.Name_Gender,LEFT,RIGHT) = '4'                       => 'AMBIGUOUS',
																							 ''
																							 );
			SELF.Title_Desc_1                 := DataBridge.Functions.fGetTitleDesc(l.Title_Code_1);
			SELF.Title_Desc_2                 := DataBridge.Functions.fGetTitleDesc(l.Title_Code_2);
			SELF.Title_Desc_3                 := DataBridge.Functions.fGetTitleDesc(l.Title_Code_3);              
			SELF.Title_Desc_4                 := DataBridge.Functions.fGetTitleDesc(l.Title_Code_4);
			SELF.Web_Address1                 := DataBridge.Functions.fParseString(l.Web_Address,1);
			SELF.Web_Address2                 := DataBridge.Functions.fParseString(l.Web_Address,2);
			SELF.Web_Address3                 := DataBridge.Functions.fParseString(l.Web_Address,3);
			SELF.SIC8_Desc_1                  := DataBridge.Functions.fGetSICDesc(l.SIC8_1);
			SELF.SIC8_Desc_2                  := DataBridge.Functions.fGetSICDesc(l.SIC8_2);
			SELF.SIC8_Desc_3                  := DataBridge.Functions.fGetSICDesc(l.SIC8_3);
			SELF.SIC8_Desc_4                  := DataBridge.Functions.fGetSICDesc(l.SIC8_4);
			SELF.SIC6_Desc_1                  := DataBridge.Functions.fGetSICDesc(l.SIC6_1);
			SELF.SIC6_Desc_2                  := DataBridge.Functions.fGetSICDesc(l.SIC6_2);
			SELF.SIC6_Desc_3                  := DataBridge.Functions.fGetSICDesc(l.SIC6_3);
			SELF.SIC6_Desc_4                  := DataBridge.Functions.fGetSICDesc(l.SIC6_4);
			SELF.SIC6_Desc_5                  := DataBridge.Functions.fGetSICDesc(l.SIC6_5);
			SELF.Email1                       := if(self.email_status = 'VALID',DataBridge.Functions.fParseString(l.Email,1),'');
			SELF.Email2                       := if(self.email_status = 'VALID',DataBridge.Functions.fParseString(l.Email,2),'');
			SELF.Email3                       := if(self.email_status = 'VALID',DataBridge.Functions.fParseString(l.Email,3),'');
			SELF 															:= L;
			SELF 															:= [];
		END;
		
		dPreProcess := PROJECT(pRawInput,tPreProcess(LEFT));

    dPreProcess_dedup  := DEDUP( SORT( DISTRIBUTE(dPreProcess, HASH(Database_Individual_ID) ), RECORD, LOCAL ), RECORD, LOCAL );	
	
		RETURN dPreProcess_dedup;

	END;  //End fPreProcess
	
	//////////////////////////////////////////////////////////////////////////////////////
	// -- FUNCTION: fAll
	//////////////////////////////////////////////////////////////////////////////////////
	EXPORT fAll( DATASET(DataBridge.Layouts.Sprayed_Input) pRawInput
							,STRING  pversion
							,STRING  pPersistname = DataBridge.Persistnames().StandardizeInput
	           ) := FUNCTION
	
		dPreprocess	:= fPreProcess(pRawInput,pversion	) : PERSIST(pPersistname);

		RETURN dPreprocess;
	
	END;

END;