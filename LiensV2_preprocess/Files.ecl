// Used in LiensV2.file_liens_main
Import LiensV2_preprocess, STD, ut;

EXPORT Files := MODULE

	//CA Federal - Single input, multiple record types
	EXPORT CA_raw	:= Dataset(root+'caf',LiensV2_preprocess.Layouts_CA_Federal.Input,CSV(HEADING(0),SEPARATOR(''),TERMINATOR(['\n', '\r\n'])));
	
	//Filing
	LiensV2_preprocess.Layouts_CA_Federal.Filing xfrmFiling(CA_Raw pInput) := TRANSFORM
		self.Record_Code						:= pInput.row_data[1..1];
		self.Initial_Filing_Number	:= pInput.row_data[2..15];
		self.static_value						:= pInput.row_data[16..27];
		self.Initial_Filing_type		:= pInput.row_data[28..32];
		self.Filing_date						:= pInput.row_data[33..40];
		self.Filing_time						:= pInput.row_data[41..44];
		self.Filing_Status					:= pInput.row_data[45..45];
		self.lapse_date							:= pInput.row_data[46..53];
		self.page_count							:= pInput.row_data[54..57];
		self.Internal_doc_number		:= pInput.row_data[58..77];
	END;
	
	EXPORT CA_Filing	:= sort(project(CA_raw(row_data[1] = '1'), xfrmFiling(left)),Initial_Filing_Number);
	
	//Business Debtor
	LiensV2_preprocess.Layouts_CA_Federal.BusDebtor xfrmBusDebt(CA_Raw pInput) := TRANSFORM
		self.Record_Code						:= pInput.row_data[1..1];
		self.Initial_Filing_Number	:= pInput.row_data[2..15];
		self.static_value						:= pInput.row_data[16..27];
		self.Business_Debtor_Name		:= pInput.row_data[28..327];
		self.Business_Debtor_Street_Address	:= pInput.row_data[328..437];
		self.Business_Debtor_City		:= pInput.row_data[438..501];
		self.Business_Debtor_State	:= pInput.row_data[502..533];
		self.Business_Debtor_Zip_Code	:= pInput.row_data[534..548];
		self.Business_Debtor_ZipCode_Extension	:= pInput.row_data[549..554];
		self.Business_Debtor_Country_Code	:= pInput.row_data[555..557];
	END;
	
	EXPORT CA_BusDebt	:= sort(project(CA_raw(row_data[1] = '2'), xfrmBusDebt(left)),Initial_Filing_Number);
	
	//Individual Debtor
	LiensV2_preprocess.Layouts_CA_Federal.PersDebtor xfrmPersDebt(CA_Raw pInput) := TRANSFORM
		self.Record_Code						:= pInput.row_data[1..1];
		self.Initial_Filing_Number	:= pInput.row_data[2..15];
		self.static									:= pInput.row_data[16..27];
		self.Personal_Debtor_Last_Name	:= pInput.row_data[28..77];
		self.Personal_Debtor_First_Name	:= pInput.row_data[78..127];
		self.Personal_Debtor_Middle_Name	:= pInput.row_data[128..177];
		self.Personal_Debtor_Suffix				:= pInput.row_data[178..183];
		self.Personal_Debtor_Street_Address	:= pInput.row_data[184..293];
		self.Personal_Debtor_City			:= pInput.row_data[294..357];
		self.Personal_Debtor_State		:= pInput.row_data[358..389];
		self.Personal_Debtor_Zip_Code	:= pInput.row_data[390..404];
		self.Personal_Debtor_Zip_Code_Extension	:= pInput.row_data[405..410];
		self.Personal_Debtor_Country_Code	:= pInput.row_data[411..413];
	END;
	
	EXPORT CA_PersDebt	:= sort(project(CA_raw(row_data[1] = '3'), xfrmPersDebt(left)),Initial_Filing_Number);
	
	//Business Secure Party
	LiensV2_preprocess.Layouts_CA_Federal.BusSecureParty xfrmBusSecParty(CA_Raw pInput) := TRANSFORM
		self.Record_Code						:= pInput.row_data[1..1];
		self.Initial_Filing_Number	:= pInput.row_data[2..15];
		self.static_value						:= pInput.row_data[16..27];
		self.Business_Secured_Party_Name		:= pInput.row_data[28..327];
		self.Business_Secured_Party_Street_Address	:= pInput.row_data[328..437];;
		self.Business_Secured_Party_City		:= pInput.row_data[438..501];
		self.Business_Secured_Party_State		:= pInput.row_data[502..533];
		self.Business_Secured_Party_Zip_Code	:= pInput.row_data[534..548];
		self.Business_Secured_Party_Zip_Code_Extension	:= pInput.row_data[549..554];
		self.Business_Secured_Party_Country_Code		:= pInput.row_data[555..557];
	END;
	
	EXPORT CA_BusSecParty	:= sort(project(CA_raw(row_data[1] = '4'), xfrmBusSecParty(left)),Initial_Filing_Number);
	
	//Person Secure Party
	LiensV2_preprocess.Layouts_CA_Federal.PersSecureParty xfrmPersSecParty(CA_Raw pInput) := TRANSFORM
		self.Record_Code						:= pInput.row_data[1..1];
		self.Initial_Filing_Number	:= pInput.row_data[2..15];
		self.static_value						:= pInput.row_data[16..27];
		self.Personal_Secured_Party_Last_Name		:= pInput.row_data[28..78];;
		self.Personal_Secured_Party_First_Name	:= pInput.row_data[78..127];
		self.Personal_Secured_Party_Middle_Name	:= pInput.row_data[128..177];
		self.Personal_Secured_Party_Suffix			:= pInput.row_data[178..183];;
		self.Personal_Secured_Party_Street_Address	:= pInput.row_data[184..293];
		self.Personal_Secured_Party_City				:= pInput.row_data[294..357];
		self.Personal_Secured_Party_State				:= pInput.row_data[358..389];
		self.Personal_Secured_Party_Zip_Code		:= pInput.row_data[390..404];
		self.Personal_Secured_Party_Zip_Code_Extension	:= pInput.row_data[405..410];
		self.Personal_Secured_Party_Country_Code	:= pInput.row_data[411..413];
	END;
	
	EXPORT CA_PersSecParty	:= sort(project(CA_raw(row_data[1] = '5'), xfrmPersSecParty(left)),Initial_Filing_Number);
		
	//Change Filing
	LiensV2_preprocess.Layouts_CA_Federal.ChangeFiling xfrmChngFiling(CA_Raw pInput) := TRANSFORM
		self.Record_Code							:= pInput.row_data[1..1];
		self.Initial_Filing_Number		:= pInput.row_data[2..15];
		self.Change_Filing_Number			:= pInput.row_data[16..27]; 
		self.Change_Filing_Type				:= pInput.row_data[28..32];
		self.Change_Filing_Date				:= pInput.row_data[33..40];
		self.Change_Filing_Time				:= pInput.row_data[41..44];
		self.change_page_count				:= pInput.row_data[45..48];
		self.Internal_Document_Number	:= pInput.row_data[49..69];
	END;
	
	EXPORT CA_ChngFiling	:= sort(project(CA_raw(row_data[1] = '6'), xfrmChngFiling(left)),Initial_Filing_Number);
	
	//Collateral
	LiensV2_preprocess.Layouts_CA_Federal.Collateral xfrmCollateral(CA_Raw pInput) := TRANSFORM
		self.Record_Code						:= pInput.row_data[1..1];
		self.Initial_Filing_Number	:= pInput.row_data[2..15];
		self.static_value						:= pInput.row_data[16..27];
		self.Filing_Number_of_UCC_3_Filing	:= pInput.row_data[28..37];
		self.Numeric_Collateral_Line_Sequence_Number	:= pInput.row_data[38..43];
		self.Collateral_Description					:= pInput.row_data[44..124];
	END;
	
	EXPORT CA_Collateral	:= sort(project(CA_raw(row_data[1] = '7'), xfrmCollateral(left)),Initial_Filing_Number);
	
	EXPORT Hogan	:= dataset(root+'hgn', LiensV2_preprocess.Layouts_Hogan.raw_in, CSV(HEADING(0), SEPARATOR(','), QUOTE('"'), TERMINATOR('\r\n'), MAXLENGTH(100000)));
	
END;
		