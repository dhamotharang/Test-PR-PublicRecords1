import GlobalWatchLists_Preprocess, std, address, bo_address, ut;

EXPORT ProcessInnovativeSystemsUNS := FUNCTION

	GlobalWatchLists_Preprocess.IntermediaryLayoutInnovativeSystems.TempLayoutUNS NormUNSanctionedTerroristsAliases1TO20(GlobalWatchLists_Preprocess.Layouts.rInnovativeSystems L, INTEGER C) := TRANSFORM
			self.Original_Primary_Name 	:= case(C, 1 => L.Original_Alias_01
																					,2 => L.Original_Alias_02
																					,3 => L.Original_Alias_03
																					,4 => L.Original_Alias_04
																					,5 => L.Original_Alias_05
																					,6 => L.Original_Alias_06
																					,7 => L.Original_Alias_07
																					,8 => L.Original_Alias_08
																					,9 => L.Original_Alias_09
																					,10 => L.Original_Alias_10
																					,11 => L.Original_Alias_11
																					,12 => L.Original_Alias_12
																					,13 => L.Original_Alias_13
																					,14 => L.Original_Alias_14
																					,15 => L.Original_Alias_15
																					,16 => L.Original_Alias_16
																					,17 => L.Original_Alias_17
																					,18 => L.Original_Alias_18
																					,19 => L.Original_Alias_19
																					,20 => L.Original_Alias_20
																					,'');
		self.Cleaned_First_Name 		:= '';
		self.Cleaned_Last_Name 			:= '';
		self.Primary_Record 				:= case(C, 1 => L.Original_Alias_Code_01
																					,2 => L.Original_Alias_Code_02
																					,3 => L.Original_Alias_Code_03
																					,4 => L.Original_Alias_Code_04
																					,5 => L.Original_Alias_Code_05
																					,6 => L.Original_Alias_Code_06
																					,7 => L.Original_Alias_Code_07
																					,8 => L.Original_Alias_Code_08
																					,9 => L.Original_Alias_Code_09
																					,10 => L.Original_Alias_Code_10
																					,11 => L.Original_Alias_Code_11
																					,12 => L.Original_Alias_Code_12
																					,13 => L.Original_Alias_Code_13
																					,14 => L.Original_Alias_Code_14
																					,15 => L.Original_Alias_Code_15
																					,16 => L.Original_Alias_Code_16
																					,17 => L.Original_Alias_Code_17
																					,18 => L.Original_Alias_Code_18
																					,19 => L.Original_Alias_Code_19
																					,20 => L.Original_Alias_Code_20
																					,'');
		self.Original_Add_01_Line_01	:= L.line_data_2;
		self.Original_Add_01_Line_02	:= L.line_data_3;
		self.Original_Add_01_Line_03	:= L.line_data_4;
		self.Original_Add_01_Line_04	:= L.line_data_5;
		self.Original_Add_02_Line_01	:= If(STD.Uni.ToUppercase(trim(L.Original_Add_02_Line_01,left,right))[1..10] = trim(self.Original_Add_01_Line_01,left,right)[1..10],'',
																				L.Original_Add_02_Line_01);
		self 												:= L;
		self.orig_raw_name					:= L.line_data_1;
	END;
	
	NormalizedUNSanctionedTerroristsAliases1TO20	:= NORMALIZE(GlobalWatchLists_Preprocess.Files.dsInnovativeSystemsUNS, 20, NormUNSanctionedTerroristsAliases1TO20(LEFT,COUNTER));
	
	GlobalWatchLists_Preprocess.IntermediaryLayoutInnovativeSystems.TempLayoutUNS NormUNSanctionedTerroristsAliases21TO25Plus(GlobalWatchLists_Preprocess.Layouts.rInnovativeSystems L, INTEGER C) := TRANSFORM
		self.Original_Primary_Name 	:= case(C, 1 => L.Original_Alias_21
																					,2 => L.Original_Alias_22
																					,3 => L.Original_Alias_23
																					,4 => L.Original_Alias_24
																					,5 => L.Original_Alias_25
																					,6 => STD.Uni.CleanSpaces(L.line_data_1)
																					,'');
		self.Cleaned_First_Name 		:= case(C, 1 => ''
																					,2 => ''
																					,3 => ''
																					,4 => ''
																					,5 => ''
																					,L.Cleaned_First_Name);
		self.Cleaned_Last_Name 			:= case(C, 1 => ''
																					,2 => ''
																					,3 => ''
																					,4 => ''
																					,5 => ''
																					,L.Cleaned_Last_Name);
		self.Primary_Record 				:= case(C, 1 => L.Original_Alias_Code_21
																					,2 => L.Original_Alias_Code_22
																					,3 => L.Original_Alias_Code_23
																					,4 => L.Original_Alias_Code_24
																					,5 => L.Original_Alias_Code_25
																					,6 => 'Y'
																					,'');
		self.Original_Add_01_Line_01	:= L.line_data_2;
		self.Original_Add_01_Line_02	:= L.line_data_3;
		self.Original_Add_01_Line_03	:= L.line_data_4;
		self.Original_Add_01_Line_04	:= L.line_data_5;
		self.Original_Add_02_Line_01	:= If(STD.Uni.ToUppercase(trim(L.Original_Add_02_Line_01,left,right))[1..10] = trim(self.Original_Add_01_Line_01,left,right)[1..10],'',
																				L.Original_Add_02_Line_01);
		self 												:= L;
		self.orig_raw_name					:= L.line_data_1;
	END;
	
	NormalizedUNSanctionedTerroristsAliases21TO20Plus	:= NORMALIZE(GlobalWatchLists_Preprocess.Files.dsInnovativeSystemsUNS, 6, NormUNSanctionedTerroristsAliases21TO25Plus(LEFT,COUNTER));
	
	NormalizedUNS 				:= NormalizedUNSanctionedTerroristsAliases1TO20 + NormalizedUNSanctionedTerroristsAliases21TO20Plus;
	NotNullNormalizedUNS 	:= DEDUP(SORT(NormalizedUNS(TRIM(Original_Primary_Name, left, right) <> ''),serial_number,original_primary_name),ALL);
	
	GlobalWatchLists_Preprocess.IntermediaryLayoutInnovativeSystems.TempLayoutUNS1 NormUNSAddress(GlobalWatchLists_Preprocess.IntermediaryLayoutInnovativeSystems.TempLayoutUNS L, INTEGER C) := TRANSFORM
		self.Original_Address_01 	:= CHOOSE(C,TRIM(L.Original_Add_01_Line_01)
																				,TRIM(L.Original_Add_02_Line_01)
																				,TRIM(L.Original_Add_03_Line_01)
																				,TRIM(L.Original_Add_04_Line_01)
																				,TRIM(L.Original_Add_05_Line_01)
																				,TRIM(L.Original_Add_06_Line_01)
																				,TRIM(L.Original_Add_07_Line_01)
																				,TRIM(L.Original_Add_08_Line_01)
																				,TRIM(L.Original_Add_09_Line_01)
																				,TRIM(L.Original_Add_10_Line_01)
																				);
		self.Original_Address_02 	:= CHOOSE(C,TRIM(L.Original_Add_01_Line_02)
																				,TRIM(L.Original_Add_02_Line_02)
																				,TRIM(L.Original_Add_03_Line_02)
																				,TRIM(L.Original_Add_04_Line_02)
																				,TRIM(L.Original_Add_05_Line_02)
																				,TRIM(L.Original_Add_06_Line_02)
																				,TRIM(L.Original_Add_07_Line_02)
																				,TRIM(L.Original_Add_08_Line_02)
																				,TRIM(L.Original_Add_09_Line_02)
																				,TRIM(L.Original_Add_10_Line_02)
																				);
		self.Original_Address_03 	:= CHOOSE(C,TRIM(L.Original_Add_01_Line_03)
																				,TRIM(L.Original_Add_02_Line_03)
																				,TRIM(L.Original_Add_03_Line_03)
																				,TRIM(L.Original_Add_04_Line_03)
																				,TRIM(L.Original_Add_05_Line_03)
																				,TRIM(L.Original_Add_06_Line_03)
																				,TRIM(L.Original_Add_07_Line_03)
																				,TRIM(L.Original_Add_08_Line_03)
																				,TRIM(L.Original_Add_09_Line_03)
																				,TRIM(L.Original_Add_10_Line_03)
																				);
		self.Original_Address_04 	:= CHOOSE(C,TRIM(L.Original_Add_01_Line_04)
																				,TRIM(L.Original_Add_02_Line_04)
																				,TRIM(L.Original_Add_03_Line_04)
																				,TRIM(L.Original_Add_04_Line_04)
																				,TRIM(L.Original_Add_05_Line_04)
																				,TRIM(L.Original_Add_06_Line_04)
																				,TRIM(L.Original_Add_07_Line_04)
																				,TRIM(L.Original_Add_08_Line_04)
																				,TRIM(L.Original_Add_09_Line_04)
																				,TRIM(L.Original_Add_10_Line_04)
																				);
		self.AKA_Flag 						:= L.Primary_Record;
		self											:= L;
	END;
	
	NormalizedUNSAddress					:= NORMALIZE(NotNullNormalizedUNS, map(left.Original_Add_10_Line_01 <> '' => 10,
																																				left.Original_Add_09_Line_01 <> '' => 9,
																																				left.Original_Add_08_Line_01 <> '' => 8,
																																				left.Original_Add_07_Line_01 <> '' => 7,
																																				left.Original_Add_06_Line_01 <> '' => 6,
																																				left.Original_Add_05_Line_01 <> '' => 5,
																																				left.Original_Add_04_Line_01 <> '' => 4,
																																				left.Original_Add_03_Line_01 <> '' => 3,
																																				left.Original_Add_02_Line_01 <> '' => 2,1), NormUNSAddress(LEFT,COUNTER));
	NotNullNormalizedUNSAddress 	:= DEDUP(SORT(NormalizedUNSAddress(TRIM(Original_Primary_Name, left, right) <> ''),serial_number,Original_Primary_Name),ALL);

 	GlobalWatchLists_Preprocess.IntermediaryLayoutInnovativeSystems.TempLayoutUNS1 ReformatOctalUTF8(GlobalWatchLists_Preprocess.IntermediaryLayoutInnovativeSystems.TempLayoutUNS1 L) := TRANSFORM
		self.Original_Primary_Name := 
		if(STD.Uni.Find(L.Original_Primary_Name, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Primary_Name, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Primary_Name, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Primary_Name, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Primary_Name, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Primary_Name, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Primary_Name, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Primary_Name, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Primary_Name, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Primary_Name, u'Ã¢\200\235', u'"'),
		L.Original_Primary_Name)))));

		self.Cleaned_First_Name := 
		if(STD.Uni.Find(L.Cleaned_First_Name, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Cleaned_First_Name, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Cleaned_First_Name, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Cleaned_First_Name, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Cleaned_First_Name, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Cleaned_First_Name, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Cleaned_First_Name, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Cleaned_First_Name, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Cleaned_First_Name, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Cleaned_First_Name, u'Ã¢\200\235', u'"'),
		L.Cleaned_First_Name)))));

		self.Cleaned_Last_Name := 
		if(STD.Uni.Find(L.Cleaned_Last_Name, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Cleaned_Last_Name, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Cleaned_Last_Name, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Cleaned_Last_Name, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Cleaned_Last_Name, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Cleaned_Last_Name, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Cleaned_Last_Name, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Cleaned_Last_Name, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Cleaned_Last_Name, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Cleaned_Last_Name, u'Ã¢\200\235', u'"'),
		L.Cleaned_Last_Name)))));

		self.Original_Title_01 := 
		if(STD.Uni.Find(L.Original_Title_01, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_01, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Title_01, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_01, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Title_01, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_01, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Title_01, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_01, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Title_01, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_01, u'Ã¢\200\235', u'"'),
		L.Original_Title_01)))));

		self.Original_Title_02 := 
		if(STD.Uni.Find(L.Original_Title_02, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_02, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Title_02, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_02, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Title_02, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_02, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Title_02, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_02, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Title_02, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_02, u'Ã¢\200\235', u'"'),
		L.Original_Title_02)))));

		self.Original_Title_03 := 
		if(STD.Uni.Find(L.Original_Title_03, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_03, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Title_03, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_03, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Title_03, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_03, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Title_03, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_03, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Title_03, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_03, u'Ã¢\200\235', u'"'),
		L.Original_Title_03)))));

		self.Original_Title_04 := 
		if(STD.Uni.Find(L.Original_Title_04, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_04, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Title_04, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_04, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Title_04, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_04, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Title_04, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_04, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Title_04, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_04, u'Ã¢\200\235', u'"'),
		L.Original_Title_04)))));

		self.Original_Title_05 := 
		if(STD.Uni.Find(L.Original_Title_05, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_05, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Title_05, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_05, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Title_05, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_05, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Title_05, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_05, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Title_05, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_05, u'Ã¢\200\235', u'"'),
		L.Original_Title_05)))));

		self.Original_Title_06 := 
		if(STD.Uni.Find(L.Original_Title_06, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_06, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Title_06, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_06, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Title_06, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_06, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Title_06, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_06, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Title_06, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_06, u'Ã¢\200\235', u'"'),
		L.Original_Title_06)))));

		self.Original_Title_07 := 
		if(STD.Uni.Find(L.Original_Title_07, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_07, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Title_07, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_07, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Title_07, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_07, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Title_07, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_07, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Title_07, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_07, u'Ã¢\200\235', u'"'),
		L.Original_Title_07)))));

		self.Original_Title_08 := 
		if(STD.Uni.Find(L.Original_Title_08, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_08, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Title_08, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_08, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Title_08, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_08, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Title_08, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_08, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Title_08, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_08, u'Ã¢\200\235', u'"'),
		L.Original_Title_08)))));

		self.Original_Title_09 := 
		if(STD.Uni.Find(L.Original_Title_09, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_09, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Title_09, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_09, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Title_09, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_09, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Title_09, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_09, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Title_09, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_09, u'Ã¢\200\235', u'"'),
		L.Original_Title_09)))));

		self.Original_Title_10 := 
		if(STD.Uni.Find(L.Original_Title_10, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_10, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Title_10, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_10, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Title_10, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_10, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Title_10, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_10, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Title_10, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_10, u'Ã¢\200\235', u'"'),
		L.Original_Title_10)))));

		self.Original_Designation_01 := 
		if(STD.Uni.Find(L.Original_Designation_01, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_01, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Designation_01, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_01, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Designation_01, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_01, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Designation_01, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_01, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Designation_01, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_01, u'Ã¢\200\235', u'"'),
		L.Original_Designation_01)))));

		self.Original_Designation_02 := 
		if(STD.Uni.Find(L.Original_Designation_02, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_02, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Designation_02, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_02, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Designation_02, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_02, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Designation_02, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_02, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Designation_02, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_02, u'Ã¢\200\235', u'"'),
		L.Original_Designation_02)))));

		self.Original_Designation_03 := 
		if(STD.Uni.Find(L.Original_Designation_03, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_03, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Designation_03, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_03, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Designation_03, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_03, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Designation_03, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_03, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Designation_03, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_03, u'Ã¢\200\235', u'"'),
		L.Original_Designation_03)))));

		self.Original_Designation_04 := 
		if(STD.Uni.Find(L.Original_Designation_04, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_04, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Designation_04, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_04, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Designation_04, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_04, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Designation_04, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_04, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Designation_04, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_04, u'Ã¢\200\235', u'"'),
		L.Original_Designation_04)))));

		self.Original_Designation_05 := 
		if(STD.Uni.Find(L.Original_Designation_05, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_05, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Designation_05, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_05, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Designation_05, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_05, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Designation_05, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_05, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Designation_05, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_05, u'Ã¢\200\235', u'"'),
		L.Original_Designation_05)))));

		self.Original_Designation_06 := 
		if(STD.Uni.Find(L.Original_Designation_06, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_06, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Designation_06, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_06, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Designation_06, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_06, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Designation_06, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_06, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Designation_06, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_06, u'Ã¢\200\235', u'"'),
		L.Original_Designation_06)))));

		self.Original_Designation_07 := 
		if(STD.Uni.Find(L.Original_Designation_07, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_07, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Designation_07, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_07, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Designation_07, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_07, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Designation_07, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_07, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Designation_07, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_07, u'Ã¢\200\235', u'"'),
		L.Original_Designation_07)))));

		self.Original_Designation_08 := 
		if(STD.Uni.Find(L.Original_Designation_08, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_08, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Designation_08, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_08, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Designation_08, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_08, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Designation_08, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_08, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Designation_08, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_08, u'Ã¢\200\235', u'"'),
		L.Original_Designation_08)))));

		self.Original_Designation_09 := 
		if(STD.Uni.Find(L.Original_Designation_09, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_09, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Designation_09, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_09, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Designation_09, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_09, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Designation_09, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_09, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Designation_09, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_09, u'Ã¢\200\235', u'"'),
		L.Original_Designation_09)))));

		self.Original_Designation_10 := 
		if(STD.Uni.Find(L.Original_Designation_10, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_10, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Designation_10, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_10, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Designation_10, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_10, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Designation_10, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_10, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Designation_10, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_10, u'Ã¢\200\235', u'"'),
		L.Original_Designation_10)))));

		self.Original_Natl_ID_01 := 
		(string)if(STD.Uni.Find(L.Original_Natl_ID_01, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_01, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Natl_ID_01, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_01, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Natl_ID_01, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_01, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Natl_ID_01, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_01, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Natl_ID_01, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_01, u'Ã¢\200\235', u'"'),
		L.Original_Natl_ID_01)))));

		self.Original_Natl_ID_02 := 
		(string)if(STD.Uni.Find(L.Original_Natl_ID_02, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_02, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Natl_ID_02, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_02, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Natl_ID_02, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_02, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Natl_ID_02, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_02, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Natl_ID_02, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_02, u'Ã¢\200\235', u'"'),
		L.Original_Natl_ID_02)))));

		self.Original_Natl_ID_03 := 
		(string)if(STD.Uni.Find(L.Original_Natl_ID_03, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_03, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Natl_ID_03, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_03, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Natl_ID_03, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_03, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Natl_ID_03, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_03, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Natl_ID_03, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_03, u'Ã¢\200\235', u'"'),
		L.Original_Natl_ID_03)))));

		self.Original_Natl_ID_04 := 
		(string)if(STD.Uni.Find(L.Original_Natl_ID_04, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_04, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Natl_ID_04, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_04, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Natl_ID_04, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_04, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Natl_ID_04, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_04, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Natl_ID_04, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_04, u'Ã¢\200\235', u'"'),
		L.Original_Natl_ID_04)))));

		self.Original_Natl_ID_05 := 
		(string)if(STD.Uni.Find(L.Original_Natl_ID_05, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_05, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Natl_ID_05, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_05, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Natl_ID_05, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_05, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Natl_ID_05, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_05, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Natl_ID_05, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_05, u'Ã¢\200\235', u'"'),
		L.Original_Natl_ID_05)))));

		self.Original_Natl_ID_06 := 
		(string)if(STD.Uni.Find(L.Original_Natl_ID_06, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_06, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Natl_ID_06, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_06, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Natl_ID_06, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_06, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Natl_ID_06, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_06, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Natl_ID_06, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_06, u'Ã¢\200\235', u'"'),
		L.Original_Natl_ID_06)))));

		self.Original_Natl_ID_07 := 
		(string)if(STD.Uni.Find(L.Original_Natl_ID_07, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_07, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Natl_ID_07, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_07, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Natl_ID_07, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_07, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Natl_ID_07, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_07, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Natl_ID_07, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_07, u'Ã¢\200\235', u'"'),
		L.Original_Natl_ID_07)))));

		self.Original_Natl_ID_08 := 
		(string)if(STD.Uni.Find(L.Original_Natl_ID_08, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_08, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Natl_ID_08, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_08, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Natl_ID_08, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_08, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Natl_ID_08, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_08, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Natl_ID_08, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_08, u'Ã¢\200\235', u'"'),
		L.Original_Natl_ID_08)))));

		self.Original_Natl_ID_09 := 
		(string)if(STD.Uni.Find(L.Original_Natl_ID_09, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_09, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Natl_ID_09, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_09, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Natl_ID_09, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_09, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Natl_ID_09, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_09, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Natl_ID_09, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_09, u'Ã¢\200\235', u'"'),
		L.Original_Natl_ID_09)))));

		self.Original_Natl_ID_10 := 
		(string)if(STD.Uni.Find(L.Original_Natl_ID_10, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_10, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Natl_ID_10, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_10, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Natl_ID_10, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_10, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Natl_ID_10, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_10, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Natl_ID_10, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_10, u'Ã¢\200\235', u'"'),
		L.Original_Natl_ID_10)))));

		self.Original_Address_01 := 
		if(STD.Uni.Find(L.Original_Address_01, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Address_01, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Address_01, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Address_01, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Address_01, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Address_01, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Address_01, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Address_01, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Address_01, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Address_01, u'Ã¢\200\235', u'"'),
		L.Original_Address_01)))));

		self.Original_Address_02 := 
		if(STD.Uni.Find(L.Original_Address_02, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Address_02, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Address_02, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Address_02, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Address_02, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Address_02, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Address_02, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Address_02, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Address_02, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Address_02, u'Ã¢\200\235', u'"'),
		L.Original_Address_02)))));

		self.Original_Address_03 := 
		if(STD.Uni.Find(L.Original_Address_03, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Address_03, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Address_03, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Address_03, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Address_03, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Address_03, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Address_03, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Address_03, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Address_03, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Address_03, u'Ã¢\200\235', u'"'),
		L.Original_Address_03)))));

		self.Original_Address_04 := 
		if(STD.Uni.Find(L.Original_Address_04, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Address_04, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Address_04, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Address_04, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Address_04, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Address_04, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Address_04, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Address_04, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Address_04, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Address_04, u'Ã¢\200\235', u'"'),
		L.Original_Address_04)))));

		self.Original_Country_01 := 
		if(STD.Uni.Find(L.Original_Country_01, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_01, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Country_01, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_01, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Country_01, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_01, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Country_01, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_01, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Country_01, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_01, u'Ã¢\200\235', u'"'),
		L.Original_Country_01)))));

		self.Original_Country_02 := 
		if(STD.Uni.Find(L.Original_Country_02, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_02, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Country_02, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_02, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Country_02, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_02, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Country_02, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_02, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Country_02, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_02, u'Ã¢\200\235', u'"'),
		L.Original_Country_02)))));

		self.Original_Country_03 := 
		if(STD.Uni.Find(L.Original_Country_03, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_03, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Country_03, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_03, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Country_03, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_03, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Country_03, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_03, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Country_03, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_03, u'Ã¢\200\235', u'"'),
		L.Original_Country_03)))));

		self.Original_Country_04 := 
		if(STD.Uni.Find(L.Original_Country_04, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_04, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Country_04, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_04, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Country_04, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_04, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Country_04, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_04, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Country_04, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_04, u'Ã¢\200\235', u'"'),
		L.Original_Country_04)))));

		self.Original_Country_05 := 
		if(STD.Uni.Find(L.Original_Country_05, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_05, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Country_05, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_05, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Country_05, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_05, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Country_05, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_05, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Country_05, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_05, u'Ã¢\200\235', u'"'),
		L.Original_Country_05)))));

		self.Original_Country_06 := 
		if(STD.Uni.Find(L.Original_Country_06, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_06, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Country_06, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_06, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Country_06, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_06, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Country_06, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_06, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Country_06, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_06, u'Ã¢\200\235', u'"'),
		L.Original_Country_06)))));

		self.Original_Country_07 := 
		if(STD.Uni.Find(L.Original_Country_07, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_07, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Country_07, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_07, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Country_07, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_07, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Country_07, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_07, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Country_07, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_07, u'Ã¢\200\235', u'"'),
		L.Original_Country_07)))));

		self.Original_Country_08 := 
		if(STD.Uni.Find(L.Original_Country_08, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_08, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Country_08, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_08, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Country_08, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_08, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Country_08, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_08, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Country_08, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_08, u'Ã¢\200\235', u'"'),
		L.Original_Country_08)))));

		self.Original_Country_09 := 
		if(STD.Uni.Find(L.Original_Country_09, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_09, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Country_09, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_09, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Country_09, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_09, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Country_09, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_09, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Country_09, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_09, u'Ã¢\200\235', u'"'),
		L.Original_Country_09)))));

		self.Original_Country_10 := 
		if(STD.Uni.Find(L.Original_Country_10, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_10, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Country_10, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_10, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Country_10, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_10, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Country_10, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_10, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Country_10, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_10, u'Ã¢\200\235', u'"'),
		L.Original_Country_10)))));

		self.Original_DOB_01 := 
		(string)if(STD.Uni.Find(L.Original_DOB_01, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_01, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_DOB_01, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_01, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_DOB_01, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_01, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_DOB_01, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_01, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_DOB_01, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_01, u'Ã¢\200\235', u'"'),
		L.Original_DOB_01)))));

		self.Original_DOB_02 := 
		(string)if(STD.Uni.Find(L.Original_DOB_02, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_02, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_DOB_02, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_02, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_DOB_02, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_02, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_DOB_02, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_02, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_DOB_02, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_02, u'Ã¢\200\235', u'"'),
		L.Original_DOB_02)))));

		self.Original_DOB_03 := 
		(string)if(STD.Uni.Find(L.Original_DOB_03, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_03, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_DOB_03, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_03, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_DOB_03, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_03, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_DOB_03, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_03, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_DOB_03, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_03, u'Ã¢\200\235', u'"'),
		L.Original_DOB_03)))));

		self.Original_DOB_04 := 
		(string)if(STD.Uni.Find(L.Original_DOB_04, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_04, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_DOB_04, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_04, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_DOB_04, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_04, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_DOB_04, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_04, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_DOB_04, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_04, u'Ã¢\200\235', u'"'),
		L.Original_DOB_04)))));

		self.Original_DOB_05 := 
		(string)if(STD.Uni.Find(L.Original_DOB_05, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_05, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_DOB_05, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_05, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_DOB_05, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_05, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_DOB_05, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_05, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_DOB_05, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_05, u'Ã¢\200\235', u'"'),
		L.Original_DOB_05)))));

		self.Original_DOB_06 := 
		(string)if(STD.Uni.Find(L.Original_DOB_06, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_06, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_DOB_06, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_06, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_DOB_06, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_06, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_DOB_06, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_06, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_DOB_06, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_06, u'Ã¢\200\235', u'"'),
		L.Original_DOB_06)))));

		self.Original_DOB_07 := 
		(string)if(STD.Uni.Find(L.Original_DOB_07, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_07, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_DOB_07, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_07, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_DOB_07, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_07, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_DOB_07, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_07, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_DOB_07, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_07, u'Ã¢\200\235', u'"'),
		L.Original_DOB_07)))));

		self.Original_DOB_08 := 
		(string)if(STD.Uni.Find(L.Original_DOB_08, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_08, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_DOB_08, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_08, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_DOB_08, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_08, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_DOB_08, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_08, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_DOB_08, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_08, u'Ã¢\200\235', u'"'),
		L.Original_DOB_08)))));

		self.Original_DOB_09 :=
		(string)if(STD.Uni.Find(L.Original_DOB_09, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_09, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_DOB_09, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_09, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_DOB_09, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_09, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_DOB_09, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_09, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_DOB_09, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_09, u'Ã¢\200\235', u'"'),
		L.Original_DOB_09)))));

		self.Original_DOB_10 :=
		(string)if(STD.Uni.Find(L.Original_DOB_10, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_10, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_DOB_10, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_10, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_DOB_10, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_10, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_DOB_10, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_10, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_DOB_10, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_10, u'Ã¢\200\235', u'"'),
		L.Original_DOB_10)))));

		self.Original_POB_01 :=
		if(STD.Uni.Find(L.Original_POB_01, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_01, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_POB_01, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_01, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_POB_01, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_01, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_POB_01, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_01, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_POB_01, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_01, u'Ã¢\200\235', u'"'),
		L.Original_POB_01)))));

		self.Original_POB_02 :=
		if(STD.Uni.Find(L.Original_POB_02, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_02, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_POB_02, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_02, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_POB_02, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_02, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_POB_02, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_02, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_POB_02, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_02, u'Ã¢\200\235', u'"'),
		L.Original_POB_02)))));

		self.Original_POB_03 :=
		if(STD.Uni.Find(L.Original_POB_03, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_03, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_POB_03, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_03, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_POB_03, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_03, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_POB_03, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_03, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_POB_03, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_03, u'Ã¢\200\235', u'"'),
		L.Original_POB_03)))));

		self.Original_POB_04 :=
		if(STD.Uni.Find(L.Original_POB_04, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_04, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_POB_04, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_04, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_POB_04, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_04, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_POB_04, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_04, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_POB_04, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_04, u'Ã¢\200\235', u'"'),
		L.Original_POB_04)))));

		self.Original_POB_05 :=
		if(STD.Uni.Find(L.Original_POB_05, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_05, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_POB_05, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_05, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_POB_05, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_05, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_POB_05, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_05, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_POB_05, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_05, u'Ã¢\200\235', u'"'),
		L.Original_POB_05)))));

		self.Original_POB_06 :=
		if(STD.Uni.Find(L.Original_POB_06, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_06, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_POB_06, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_06, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_POB_06, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_06, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_POB_06, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_06, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_POB_06, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_06, u'Ã¢\200\235', u'"'),
		L.Original_POB_06)))));

		self.Original_POB_07 :=
		if(STD.Uni.Find(L.Original_POB_07, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_07, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_POB_07, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_07, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_POB_07, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_07, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_POB_07, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_07, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_POB_07, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_07, u'Ã¢\200\235', u'"'),
		L.Original_POB_07)))));

		self.Original_POB_08 :=
		if(STD.Uni.Find(L.Original_POB_08, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_08, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_POB_08, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_08, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_POB_08, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_08, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_POB_08, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_08, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_POB_08, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_08, u'Ã¢\200\235', u'"'),
		L.Original_POB_08)))));

		self.Original_POB_09 :=
		if(STD.Uni.Find(L.Original_POB_09, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_09, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_POB_09, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_09, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_POB_09, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_09, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_POB_09, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_09, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_POB_09, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_09, u'Ã¢\200\235', u'"'),
		L.Original_POB_09)))));

		self.Original_POB_10 :=
		if(STD.Uni.Find(L.Original_POB_10, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_10, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_POB_10, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_10, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_POB_10, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_10, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_POB_10, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_10, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_POB_10, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_10, u'Ã¢\200\235', u'"'),
		L.Original_POB_10)))));

		self.Original_Additional_Info :=
		if(STD.Uni.Find(L.Original_Additional_Info, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Additional_Info, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Additional_Info, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Additional_Info, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Additional_Info, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Additional_Info, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Additional_Info, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Additional_Info, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Additional_Info, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Additional_Info, u'Ã¢\200\235', u'"'),
		L.Original_Additional_Info)))));
		
		self := L;

	END;
	
	GlobalWatchLists_Preprocess.IntermediaryLayoutInnovativeSystems.TempLayoutUNS1 ReformatOctalUTF8_1(GlobalWatchLists_Preprocess.IntermediaryLayoutInnovativeSystems.TempLayoutUNS1 L) := TRANSFORM
	
		self.Original_Primary_Name :=
		if(STD.Uni.Find(L.Original_Primary_Name, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Primary_Name, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Primary_Name, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Primary_Name, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Primary_Name, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Primary_Name, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Primary_Name, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Primary_Name, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Primary_Name, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Primary_Name, u'Ã¢\200\235', u'"'),
		L.Original_Primary_Name)))));

		self.Cleaned_First_Name :=
		if(STD.Uni.Find(L.Cleaned_First_Name, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Cleaned_First_Name, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Cleaned_First_Name, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Cleaned_First_Name, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Cleaned_First_Name, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Cleaned_First_Name, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Cleaned_First_Name, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Cleaned_First_Name, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Cleaned_First_Name, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Cleaned_First_Name, u'Ã¢\200\235', u'"'),
		L.Cleaned_First_Name)))));

		self.Cleaned_Last_Name :=
		if(STD.Uni.Find(L.Cleaned_Last_Name, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Cleaned_Last_Name, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Cleaned_Last_Name, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Cleaned_Last_Name, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Cleaned_Last_Name, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Cleaned_Last_Name, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Cleaned_Last_Name, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Cleaned_Last_Name, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Cleaned_Last_Name, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Cleaned_Last_Name, u'Ã¢\200\235', u'"'),
		L.Cleaned_Last_Name)))));

		self.Original_Title_01 :=
		if(STD.Uni.Find(L.Original_Title_01, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_01, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Title_01, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_01, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Title_01, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_01, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Title_01, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_01, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Title_01, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_01, u'Ã¢\200\235', u'"'),
		L.Original_Title_01)))));

		self.Original_Title_02 :=
		if(STD.Uni.Find(L.Original_Title_02, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_02, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Title_02, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_02, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Title_02, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_02, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Title_02, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_02, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Title_02, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_02, u'Ã¢\200\235', u'"'),
		L.Original_Title_02)))));

		self.Original_Title_03 :=
		if(STD.Uni.Find(L.Original_Title_03, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_03, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Title_03, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_03, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Title_03, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_03, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Title_03, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_03, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Title_03, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_03, u'Ã¢\200\235', u'"'),
		L.Original_Title_03)))));

		self.Original_Title_04 :=
		if(STD.Uni.Find(L.Original_Title_04, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_04, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Title_04, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_04, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Title_04, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_04, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Title_04, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_04, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Title_04, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_04, u'Ã¢\200\235', u'"'),
		L.Original_Title_04)))));

		self.Original_Title_05 :=
		if(STD.Uni.Find(L.Original_Title_05, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_05, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Title_05, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_05, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Title_05, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_05, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Title_05, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_05, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Title_05, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_05, u'Ã¢\200\235', u'"'),
		L.Original_Title_05)))));

		self.Original_Title_06 :=
		if(STD.Uni.Find(L.Original_Title_06, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_06, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Title_06, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_06, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Title_06, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_06, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Title_06, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_06, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Title_06, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_06, u'Ã¢\200\235', u'"'),
		L.Original_Title_06)))));

		self.Original_Title_07 :=
		if(STD.Uni.Find(L.Original_Title_07, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_07, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Title_07, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_07, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Title_07, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_07, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Title_07, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_07, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Title_07, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_07, u'Ã¢\200\235', u'"'),
		L.Original_Title_07)))));

		self.Original_Title_08 :=
		if(STD.Uni.Find(L.Original_Title_08, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_08, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Title_08, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_08, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Title_08, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_08, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Title_08, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_08, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Title_08, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_08, u'Ã¢\200\235', u'"'),
		L.Original_Title_08)))));

		self.Original_Title_09 :=
		if(STD.Uni.Find(L.Original_Title_09, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_09, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Title_09, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_09, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Title_09, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_09, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Title_09, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_09, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Title_09, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_09, u'Ã¢\200\235', u'"'),
		L.Original_Title_09)))));

		self.Original_Title_10 :=
		if(STD.Uni.Find(L.Original_Title_10, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_10, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Title_10, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_10, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Title_10, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_10, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Title_10, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_10, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Title_10, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_10, u'Ã¢\200\235', u'"'),
		L.Original_Title_10)))));

		self.Original_Designation_01 :=
		if(STD.Uni.Find(L.Original_Designation_01, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_01, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Designation_01, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_01, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Designation_01, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_01, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Designation_01, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_01, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Designation_01, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_01, u'Ã¢\200\235', u'"'),
		L.Original_Designation_01)))));

		self.Original_Designation_02 :=
		if(STD.Uni.Find(L.Original_Designation_02, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_02, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Designation_02, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_02, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Designation_02, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_02, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Designation_02, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_02, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Designation_02, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_02, u'Ã¢\200\235', u'"'),
		L.Original_Designation_02)))));

		self.Original_Designation_03 :=
		if(STD.Uni.Find(L.Original_Designation_03, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_03, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Designation_03, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_03, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Designation_03, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_03, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Designation_03, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_03, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Designation_03, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_03, u'Ã¢\200\235', u'"'),
		L.Original_Designation_03)))));

		self.Original_Designation_04 :=
		if(STD.Uni.Find(L.Original_Designation_04, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_04, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Designation_04, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_04, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Designation_04, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_04, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Designation_04, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_04, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Designation_04, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_04, u'Ã¢\200\235', u'"'),
		L.Original_Designation_04)))));

		self.Original_Designation_05 :=
		if(STD.Uni.Find(L.Original_Designation_05, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_05, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Designation_05, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_05, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Designation_05, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_05, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Designation_05, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_05, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Designation_05, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_05, u'Ã¢\200\235', u'"'),
		L.Original_Designation_05)))));

		self.Original_Designation_06 :=
		if(STD.Uni.Find(L.Original_Designation_06, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_06, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Designation_06, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_06, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Designation_06, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_06, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Designation_06, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_06, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Designation_06, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_06, u'Ã¢\200\235', u'"'),
		L.Original_Designation_06)))));

		self.Original_Designation_07 :=
		if(STD.Uni.Find(L.Original_Designation_07, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_07, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Designation_07, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_07, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Designation_07, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_07, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Designation_07, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_07, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Designation_07, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_07, u'Ã¢\200\235', u'"'),
		L.Original_Designation_07)))));

		self.Original_Designation_08 :=
		if(STD.Uni.Find(L.Original_Designation_08, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_08, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Designation_08, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_08, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Designation_08, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_08, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Designation_08, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_08, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Designation_08, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_08, u'Ã¢\200\235', u'"'),
		L.Original_Designation_08)))));

		self.Original_Designation_09 :=
		if(STD.Uni.Find(L.Original_Designation_09, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_09, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Designation_09, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_09, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Designation_09, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_09, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Designation_09, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_09, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Designation_09, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_09, u'Ã¢\200\235', u'"'),
		L.Original_Designation_09)))));

		self.Original_Designation_10 :=
		if(STD.Uni.Find(L.Original_Designation_10, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_10, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Designation_10, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_10, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Designation_10, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_10, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Designation_10, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_10, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Designation_10, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_10, u'Ã¢\200\235', u'"'),
		L.Original_Designation_10)))));

		self.Original_Natl_ID_01 :=
		(string)if(STD.Uni.Find(L.Original_Natl_ID_01, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_01, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Natl_ID_01, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_01, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Natl_ID_01, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_01, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Natl_ID_01, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_01, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Natl_ID_01, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_01, u'Ã¢\200\235', u'"'),
		L.Original_Natl_ID_01)))));

		self.Original_Natl_ID_02 :=
		(string)if(STD.Uni.Find(L.Original_Natl_ID_02, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_02, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Natl_ID_02, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_02, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Natl_ID_02, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_02, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Natl_ID_02, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_02, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Natl_ID_02, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_02, u'Ã¢\200\235', u'"'),
		L.Original_Natl_ID_02)))));

		self.Original_Natl_ID_03 :=
		(string)if(STD.Uni.Find(L.Original_Natl_ID_03, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_03, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Natl_ID_03, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_03, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Natl_ID_03, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_03, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Natl_ID_03, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_03, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Natl_ID_03, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_03, u'Ã¢\200\235', u'"'),
		L.Original_Natl_ID_03)))));

		self.Original_Natl_ID_04 :=
		(string)if(STD.Uni.Find(L.Original_Natl_ID_04, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_04, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Natl_ID_04, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_04, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Natl_ID_04, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_04, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Natl_ID_04, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_04, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Natl_ID_04, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_04, u'Ã¢\200\235', u'"'),
		L.Original_Natl_ID_04)))));

		self.Original_Natl_ID_05 :=
		(string)if(STD.Uni.Find(L.Original_Natl_ID_05, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_05, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Natl_ID_05, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_05, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Natl_ID_05, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_05, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Natl_ID_05, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_05, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Natl_ID_05, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_05, u'Ã¢\200\235', u'"'),
		L.Original_Natl_ID_05)))));

		self.Original_Natl_ID_06 :=
		(string)if(STD.Uni.Find(L.Original_Natl_ID_06, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_06, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Natl_ID_06, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_06, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Natl_ID_06, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_06, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Natl_ID_06, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_06, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Natl_ID_06, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_06, u'Ã¢\200\235', u'"'),
		L.Original_Natl_ID_06)))));

		self.Original_Natl_ID_07 :=
		(string)if(STD.Uni.Find(L.Original_Natl_ID_07, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_07, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Natl_ID_07, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_07, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Natl_ID_07, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_07, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Natl_ID_07, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_07, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Natl_ID_07, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_07, u'Ã¢\200\235', u'"'),
		L.Original_Natl_ID_07)))));

		self.Original_Natl_ID_08 :=
		(string)if(STD.Uni.Find(L.Original_Natl_ID_08, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_08, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Natl_ID_08, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_08, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Natl_ID_08, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_08, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Natl_ID_08, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_08, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Natl_ID_08, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_08, u'Ã¢\200\235', u'"'),
		L.Original_Natl_ID_08)))));

		self.Original_Natl_ID_09 :=
		(string)if(STD.Uni.Find(L.Original_Natl_ID_09, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_09, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Natl_ID_09, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_09, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Natl_ID_09, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_09, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Natl_ID_09, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_09, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Natl_ID_09, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_09, u'Ã¢\200\235', u'"'),
		L.Original_Natl_ID_09)))));

		self.Original_Natl_ID_10 :=
		(string)if(STD.Uni.Find(L.Original_Natl_ID_10, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_10, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Natl_ID_10, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_10, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Natl_ID_10, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_10, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Natl_ID_10, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_10, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Natl_ID_10, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_10, u'Ã¢\200\235', u'"'),
		L.Original_Natl_ID_10)))));

		self.Original_Address_01 :=
		if(STD.Uni.Find(L.Original_Address_01, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Address_01, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Address_01, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Address_01, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Address_01, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Address_01, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Address_01, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Address_01, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Address_01, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Address_01, u'Ã¢\200\235', u'"'),
		L.Original_Address_01)))));

		self.Original_Address_02 :=
		if(STD.Uni.Find(L.Original_Address_02, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Address_02, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Address_02, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Address_02, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Address_02, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Address_02, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Address_02, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Address_02, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Address_02, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Address_02, u'Ã¢\200\235', u'"'),
		L.Original_Address_02)))));

		self.Original_Address_03 :=
		if(STD.Uni.Find(L.Original_Address_03, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Address_03, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Address_03, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Address_03, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Address_03, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Address_03, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Address_03, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Address_03, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Address_03, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Address_03, u'Ã¢\200\235', u'"'),
		L.Original_Address_03)))));

		self.Original_Address_04 :=
		if(STD.Uni.Find(L.Original_Address_04, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Address_04, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Address_04, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Address_04, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Address_04, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Address_04, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Address_04, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Address_04, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Address_04, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Address_04, u'Ã¢\200\235', u'"'),
		L.Original_Address_04)))));

		self.Original_Country_01 :=
		if(STD.Uni.Find(L.Original_Country_01, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_01, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Country_01, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_01, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Country_01, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_01, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Country_01, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_01, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Country_01, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_01, u'Ã¢\200\235', u'"'),
		L.Original_Country_01)))));

		self.Original_Country_02 :=
		if(STD.Uni.Find(L.Original_Country_02, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_02, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Country_02, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_02, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Country_02, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_02, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Country_02, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_02, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Country_02, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_02, u'Ã¢\200\235', u'"'),
		L.Original_Country_02)))));

		self.Original_Country_03 :=
		if(STD.Uni.Find(L.Original_Country_03, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_03, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Country_03, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_03, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Country_03, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_03, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Country_03, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_03, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Country_03, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_03, u'Ã¢\200\235', u'"'),
		L.Original_Country_03)))));

		self.Original_Country_04 :=
		if(STD.Uni.Find(L.Original_Country_04, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_04, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Country_04, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_04, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Country_04, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_04, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Country_04, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_04, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Country_04, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_04, u'Ã¢\200\235', u'"'),
		L.Original_Country_04)))));

		self.Original_Country_05 :=
		if(STD.Uni.Find(L.Original_Country_05, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_05, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Country_05, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_05, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Country_05, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_05, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Country_05, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_05, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Country_05, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_05, u'Ã¢\200\235', u'"'),
		L.Original_Country_05)))));

		self.Original_Country_06 :=
		if(STD.Uni.Find(L.Original_Country_06, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_06, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Country_06, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_06, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Country_06, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_06, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Country_06, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_06, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Country_06, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_06, u'Ã¢\200\235', u'"'),
		L.Original_Country_06)))));

		self.Original_Country_07 :=
		if(STD.Uni.Find(L.Original_Country_07, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_07, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Country_07, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_07, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Country_07, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_07, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Country_07, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_07, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Country_07, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_07, u'Ã¢\200\235', u'"'),
		L.Original_Country_07)))));

		self.Original_Country_08 :=
		if(STD.Uni.Find(L.Original_Country_08, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_08, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Country_08, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_08, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Country_08, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_08, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Country_08, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_08, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Country_08, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_08, u'Ã¢\200\235', u'"'),
		L.Original_Country_08)))));

		self.Original_Country_09 :=
		if(STD.Uni.Find(L.Original_Country_09, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_09, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Country_09, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_09, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Country_09, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_09, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Country_09, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_09, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Country_09, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_09, u'Ã¢\200\235', u'"'),
		L.Original_Country_09)))));

		self.Original_Country_10 :=
		if(STD.Uni.Find(L.Original_Country_10, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_10, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Country_10, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_10, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Country_10, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_10, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Country_10, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_10, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Country_10, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_10, u'Ã¢\200\235', u'"'),
		L.Original_Country_10)))));

		self.Original_DOB_01 :=
		(string)if(STD.Uni.Find(L.Original_DOB_01, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_01, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_DOB_01, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_01, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_DOB_01, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_01, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_DOB_01, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_01, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_DOB_01, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_01, u'Ã¢\200\235', u'"'),
		L.Original_DOB_01)))));

		self.Original_DOB_02 :=
		(string)if(STD.Uni.Find(L.Original_DOB_02, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_02, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_DOB_02, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_02, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_DOB_02, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_02, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_DOB_02, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_02, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_DOB_02, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_02, u'Ã¢\200\235', u'"'),
		L.Original_DOB_02)))));

		self.Original_DOB_03 :=
		(string)if(STD.Uni.Find(L.Original_DOB_03, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_03, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_DOB_03, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_03, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_DOB_03, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_03, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_DOB_03, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_03, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_DOB_03, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_03, u'Ã¢\200\235', u'"'),
		L.Original_DOB_03)))));

		self.Original_DOB_04 :=
		(string)if(STD.Uni.Find(L.Original_DOB_04, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_04, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_DOB_04, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_04, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_DOB_04, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_04, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_DOB_04, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_04, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_DOB_04, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_04, u'Ã¢\200\235', u'"'),
		L.Original_DOB_04)))));

		self.Original_DOB_05 :=
		(string)if(STD.Uni.Find(L.Original_DOB_05, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_05, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_DOB_05, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_05, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_DOB_05, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_05, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_DOB_05, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_05, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_DOB_05, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_05, u'Ã¢\200\235', u'"'),
		L.Original_DOB_05)))));

		self.Original_DOB_06 :=
		(string)if(STD.Uni.Find(L.Original_DOB_06, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_06, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_DOB_06, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_06, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_DOB_06, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_06, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_DOB_06, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_06, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_DOB_06, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_06, u'Ã¢\200\235', u'"'),
		L.Original_DOB_06)))));

		self.Original_DOB_07 :=
		(string)if(STD.Uni.Find(L.Original_DOB_07, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_07, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_DOB_07, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_07, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_DOB_07, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_07, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_DOB_07, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_07, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_DOB_07, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_07, u'Ã¢\200\235', u'"'),
		L.Original_DOB_07)))));

		self.Original_DOB_08 :=
		(string)if(STD.Uni.Find(L.Original_DOB_08, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_08, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_DOB_08, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_08, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_DOB_08, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_08, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_DOB_08, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_08, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_DOB_08, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_08, u'Ã¢\200\235', u'"'),
		L.Original_DOB_08)))));

		self.Original_DOB_09 :=
		(string)if(STD.Uni.Find(L.Original_DOB_09, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_09, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_DOB_09, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_09, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_DOB_09, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_09, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_DOB_09, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_09, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_DOB_09, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_09, u'Ã¢\200\235', u'"'),
		L.Original_DOB_09)))));

		self.Original_DOB_10 :=
		(string)if(STD.Uni.Find(L.Original_DOB_10, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_10, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_DOB_10, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_10, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_DOB_10, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_10, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_DOB_10, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_10, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_DOB_10, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_10, u'Ã¢\200\235', u'"'),
		L.Original_DOB_10)))));

		self.Original_POB_01 :=
		if(STD.Uni.Find(L.Original_POB_01, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_01, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_POB_01, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_01, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_POB_01, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_01, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_POB_01, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_01, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_POB_01, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_01, u'Ã¢\200\235', u'"'),
		L.Original_POB_01)))));

		self.Original_POB_02 :=
		if(STD.Uni.Find(L.Original_POB_02, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_02, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_POB_02, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_02, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_POB_02, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_02, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_POB_02, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_02, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_POB_02, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_02, u'Ã¢\200\235', u'"'),
		L.Original_POB_02)))));

		self.Original_POB_03 :=
		if(STD.Uni.Find(L.Original_POB_03, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_03, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_POB_03, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_03, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_POB_03, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_03, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_POB_03, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_03, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_POB_03, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_03, u'Ã¢\200\235', u'"'),
		L.Original_POB_03)))));

		self.Original_POB_04 :=
		if(STD.Uni.Find(L.Original_POB_04, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_04, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_POB_04, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_04, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_POB_04, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_04, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_POB_04, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_04, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_POB_04, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_04, u'Ã¢\200\235', u'"'),
		L.Original_POB_04)))));

		self.Original_POB_05 :=
		if(STD.Uni.Find(L.Original_POB_05, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_05, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_POB_05, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_05, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_POB_05, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_05, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_POB_05, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_05, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_POB_05, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_05, u'Ã¢\200\235', u'"'),
		L.Original_POB_05)))));

		self.Original_POB_06 :=
		if(STD.Uni.Find(L.Original_POB_06, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_06, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_POB_06, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_06, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_POB_06, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_06, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_POB_06, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_06, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_POB_06, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_06, u'Ã¢\200\235', u'"'),
		L.Original_POB_06)))));

		self.Original_POB_07 :=
		if(STD.Uni.Find(L.Original_POB_07, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_07, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_POB_07, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_07, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_POB_07, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_07, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_POB_07, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_07, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_POB_07, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_07, u'Ã¢\200\235', u'"'),
		L.Original_POB_07)))));

		self.Original_POB_08 :=
		if(STD.Uni.Find(L.Original_POB_08, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_08, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_POB_08, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_08, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_POB_08, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_08, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_POB_08, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_08, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_POB_08, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_08, u'Ã¢\200\235', u'"'),
		L.Original_POB_08)))));

		self.Original_POB_09 :=
		if(STD.Uni.Find(L.Original_POB_09, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_09, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_POB_09, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_09, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_POB_09, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_09, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_POB_09, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_09, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_POB_09, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_09, u'Ã¢\200\235', u'"'),
		L.Original_POB_09)))));

		self.Original_POB_10 :=
		if(STD.Uni.Find(L.Original_POB_10, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_10, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_POB_10, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_10, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_POB_10, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_10, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_POB_10, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_10, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_POB_10, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_10, u'Ã¢\200\235', u'"'),
		L.Original_POB_10)))));

		self.Original_Additional_Info :=
		if(STD.Uni.Find(L.Original_Additional_Info, u'Ã¢\200\223', 1) <> 0, STD.Uni.FindReplace(L.Original_Additional_Info, u'Ã¢\200\223', u'â€“'),
		if(STD.Uni.Find(L.Original_Additional_Info, u'Ã¢\200\230', 1) <> 0, STD.Uni.FindReplace(L.Original_Additional_Info, u'Ã¢\200\230', u'â€˜'),
		if(STD.Uni.Find(L.Original_Additional_Info, u'Ã¢\200\231', 1) <> 0, STD.Uni.FindReplace(L.Original_Additional_Info, u'Ã¢\200\231', u'â€™'), 
		if(STD.Uni.Find(L.Original_Additional_Info, u'Ã¢\200\234', 1) <> 0, STD.Uni.FindReplace(L.Original_Additional_Info, u'Ã¢\200\234', u'"'),
		if(STD.Uni.Find(L.Original_Additional_Info, u'Ã¢\200\235', 1) <> 0, STD.Uni.FindReplace(L.Original_Additional_Info, u'Ã¢\200\235', u'"'),
		L.Original_Additional_Info)))));
		
		self := L;

	END;
	
	GlobalWatchLists_Preprocess.IntermediaryLayoutInnovativeSystems.TempLayoutUNS1 Reformat(GlobalWatchLists_Preprocess.IntermediaryLayoutInnovativeSystems.TempLayoutUNS1 L) := TRANSFORM
	
		self.Original_Primary_Name :=
		if(STD.Uni.Find(L.Original_Primary_Name, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_Primary_Name, u'Ã¢', u''),
		L.Original_Primary_Name);

		self.Cleaned_First_Name :=
		if(STD.Uni.Find(L.Cleaned_First_Name, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Cleaned_First_Name, u'Ã¢', u''),
		L.Cleaned_First_Name);

		self.Cleaned_Last_Name :=
		if(STD.Uni.Find(L.Cleaned_Last_Name, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Cleaned_Last_Name, u'Ã¢', u''),
		L.Cleaned_Last_Name);

		self.Original_Title_01 :=
		if(STD.Uni.Find(L.Original_Title_01, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_01, u'Ã¢', u''),
		L.Original_Title_01);

		self.Original_Title_02 :=
		if(STD.Uni.Find(L.Original_Title_02, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_02, u'Ã¢', u''),
		L.Original_Title_02);

		self.Original_Title_03 :=
		if(STD.Uni.Find(L.Original_Title_03, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_03, u'Ã¢', u''),
		L.Original_Title_03);

		self.Original_Title_04 :=
		if(STD.Uni.Find(L.Original_Title_04, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_04, u'Ã¢', u''),
		L.Original_Title_04);

		self.Original_Title_05 :=
		if(STD.Uni.Find(L.Original_Title_05, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_05, u'Ã¢', u''),
		L.Original_Title_05);

		self.Original_Title_06 :=
		if(STD.Uni.Find(L.Original_Title_06, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_06, u'Ã¢', u''),
		L.Original_Title_06);

		self.Original_Title_07 :=
		if(STD.Uni.Find(L.Original_Title_07, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_07, u'Ã¢', u''),
		L.Original_Title_07);

		self.Original_Title_08 :=
		if(STD.Uni.Find(L.Original_Title_08, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_08, u'Ã¢', u''),
		L.Original_Title_08);

		self.Original_Title_09 :=
		if(STD.Uni.Find(L.Original_Title_09, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_09, u'Ã¢', u''),
		L.Original_Title_09);

		self.Original_Title_10 :=
		if(STD.Uni.Find(L.Original_Title_10, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_Title_10, u'Ã¢', u''),
		L.Original_Title_10);

		self.Original_Designation_01 :=
		if(STD.Uni.Find(L.Original_Designation_01, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_01, u'Ã¢', u''),
		L.Original_Designation_01);

		self.Original_Designation_02 :=
		if(STD.Uni.Find(L.Original_Designation_02, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_02, u'Ã¢', u''),
		L.Original_Designation_02);

		self.Original_Designation_03 :=
		if(STD.Uni.Find(L.Original_Designation_03, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_03, u'Ã¢', u''),
		L.Original_Designation_03);

		self.Original_Designation_04 :=
		if(STD.Uni.Find(L.Original_Designation_04, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_04, u'Ã¢', u''),
		L.Original_Designation_04);

		self.Original_Designation_05 :=
		if(STD.Uni.Find(L.Original_Designation_05, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_05, u'Ã¢', u''),
		L.Original_Designation_05);

		self.Original_Designation_06 :=
		if(STD.Uni.Find(L.Original_Designation_06, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_06, u'Ã¢', u''),
		L.Original_Designation_06);

		self.Original_Designation_07 :=
		if(STD.Uni.Find(L.Original_Designation_07, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_07, u'Ã¢', u''),
		L.Original_Designation_07);

		self.Original_Designation_08 :=
		if(STD.Uni.Find(L.Original_Designation_08, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_08, u'Ã¢', u''),
		L.Original_Designation_08);

		self.Original_Designation_09 :=
		if(STD.Uni.Find(L.Original_Designation_09, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_09, u'Ã¢', u''),
		L.Original_Designation_09);

		self.Original_Designation_10 :=
		if(STD.Uni.Find(L.Original_Designation_10, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_Designation_10, u'Ã¢', u''),
		L.Original_Designation_10);

		self.Original_Natl_ID_01 :=
		(string)if(STD.Uni.Find(L.Original_Natl_ID_01, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_01, u'Ã¢', u''),
		L.Original_Natl_ID_01);

		self.Original_Natl_ID_02 :=
		(string)if(STD.Uni.Find(L.Original_Natl_ID_02, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_02, u'Ã¢', u''),
		L.Original_Natl_ID_02);

		self.Original_Natl_ID_03 :=
		(string)if(STD.Uni.Find(L.Original_Natl_ID_03, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_03, u'Ã¢', u''),
		L.Original_Natl_ID_03);

		self.Original_Natl_ID_04 :=
		(string)if(STD.Uni.Find(L.Original_Natl_ID_04, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_04, u'Ã¢', u''),
		L.Original_Natl_ID_04);

		self.Original_Natl_ID_05 :=
		(string)if(STD.Uni.Find(L.Original_Natl_ID_05, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_05, u'Ã¢', u''),
		L.Original_Natl_ID_05);

		self.Original_Natl_ID_06 :=
		(string)if(STD.Uni.Find(L.Original_Natl_ID_06, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_06, u'Ã¢', u''),
		L.Original_Natl_ID_06);

		self.Original_Natl_ID_07 :=
		(string)if(STD.Uni.Find(L.Original_Natl_ID_07, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_07, u'Ã¢', u''),
		L.Original_Natl_ID_07);

		self.Original_Natl_ID_08 :=
		(string)if(STD.Uni.Find(L.Original_Natl_ID_08, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_08, u'Ã¢', u''),
		L.Original_Natl_ID_08);

		self.Original_Natl_ID_09 :=
		(string)if(STD.Uni.Find(L.Original_Natl_ID_09, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_09, u'Ã¢', u''),
		L.Original_Natl_ID_09);

		self.Original_Natl_ID_10 :=
		(string)if(STD.Uni.Find(L.Original_Natl_ID_10, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_Natl_ID_10, u'Ã¢', u''),
		L.Original_Natl_ID_10);

		self.Original_Address_01 :=
		if(STD.Uni.Find(L.Original_Address_01, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_Address_01, u'Ã¢', u''),
		L.Original_Address_01);

		self.Original_Address_02 :=
		if(STD.Uni.Find(L.Original_Address_02, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_Address_02, u'Ã¢', u''),
		L.Original_Address_02);

		self.Original_Address_03 :=
		if(STD.Uni.Find(L.Original_Address_03, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_Address_03, u'Ã¢', u''),
		L.Original_Address_03);

		self.Original_Address_04 :=
		if(STD.Uni.Find(L.Original_Address_04, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_Address_04, u'Ã¢', u''),
		L.Original_Address_04);

		self.Original_Country_01 :=
		if(STD.Uni.Find(L.Original_Country_01, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_01, u'Ã¢', u''),
		L.Original_Country_01);

		self.Original_Country_02 :=
		if(STD.Uni.Find(L.Original_Country_02, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_02, u'Ã¢', u''),
		L.Original_Country_02);

		self.Original_Country_03 :=
		if(STD.Uni.Find(L.Original_Country_03, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_03, u'Ã¢', u''),
		L.Original_Country_03);

		self.Original_Country_04 :=
		if(STD.Uni.Find(L.Original_Country_04, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_04, u'Ã¢', u''),
		L.Original_Country_04);

		self.Original_Country_05 :=
		if(STD.Uni.Find(L.Original_Country_05, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_05, u'Ã¢', u''),
		L.Original_Country_05);

		self.Original_Country_06 :=
		if(STD.Uni.Find(L.Original_Country_06, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_06, u'Ã¢', u''),
		L.Original_Country_06);

		self.Original_Country_07 :=
		if(STD.Uni.Find(L.Original_Country_07, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_07, u'Ã¢', u''),
		L.Original_Country_07);

		self.Original_Country_08 :=
		if(STD.Uni.Find(L.Original_Country_08, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_08, u'Ã¢', u''),
		L.Original_Country_08);

		self.Original_Country_09 :=
		if(STD.Uni.Find(L.Original_Country_09, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_09, u'Ã¢', u''),
		L.Original_Country_09);

		self.Original_Country_10 :=
		if(STD.Uni.Find(L.Original_Country_10, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_Country_10, u'Ã¢', u''),
		L.Original_Country_10);

		self.Original_DOB_01 :=
		(string)if(STD.Uni.Find(L.Original_DOB_01, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_01, u'Ã¢', u''),
		L.Original_DOB_01);

		self.Original_DOB_02 :=
		(string)if(STD.Uni.Find(L.Original_DOB_02, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_02, u'Ã¢', u''),
		L.Original_DOB_02);

		self.Original_DOB_03 :=
		(string)if(STD.Uni.Find(L.Original_DOB_03, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_03, u'Ã¢', u''),
		L.Original_DOB_03);

		self.Original_DOB_04 :=
		(string)if(STD.Uni.Find(L.Original_DOB_04, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_04, u'Ã¢', u''),
		L.Original_DOB_04);

		self.Original_DOB_05 :=
		(string)if(STD.Uni.Find(L.Original_DOB_05, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_05, u'Ã¢', u''),
		L.Original_DOB_05);

		self.Original_DOB_06 :=
		(string)if(STD.Uni.Find(L.Original_DOB_06, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_06, u'Ã¢', u''),
		L.Original_DOB_06);

		self.Original_DOB_07 :=
		(string)if(STD.Uni.Find(L.Original_DOB_07, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_07, u'Ã¢', u''),
		L.Original_DOB_07);

		self.Original_DOB_08 :=
		(string)if(STD.Uni.Find(L.Original_DOB_08, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_08, u'Ã¢', u''),
		L.Original_DOB_08);

		self.Original_DOB_09 :=
		(string)if(STD.Uni.Find(L.Original_DOB_09, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_09, u'Ã¢', u''),
		L.Original_DOB_09);

		self.Original_DOB_10 :=
		(string)if(STD.Uni.Find(L.Original_DOB_10, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_DOB_10, u'Ã¢', u''),
		L.Original_DOB_10);

		self.Original_POB_01 :=
		if(STD.Uni.Find(L.Original_POB_01, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_01, u'Ã¢', u''),
		L.Original_POB_01);

		self.Original_POB_02 :=
		if(STD.Uni.Find(L.Original_POB_02, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_02, u'Ã¢', u''),
		L.Original_POB_02);

		self.Original_POB_03 :=
		if(STD.Uni.Find(L.Original_POB_03, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_03, u'Ã¢', u''),
		L.Original_POB_03);

		self.Original_POB_04 :=
		if(STD.Uni.Find(L.Original_POB_04, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_04, u'Ã¢', u''),
		L.Original_POB_04);

		self.Original_POB_05 :=
		if(STD.Uni.Find(L.Original_POB_05, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_05, u'Ã¢', u''),
		L.Original_POB_05);

		self.Original_POB_06 :=
		if(STD.Uni.Find(L.Original_POB_06, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_06, u'Ã¢', u''),
		L.Original_POB_06);

		self.Original_POB_07 :=
		if(STD.Uni.Find(L.Original_POB_07, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_07, u'Ã¢', u''),
		L.Original_POB_07);

		self.Original_POB_08 :=
		if(STD.Uni.Find(L.Original_POB_08, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_08, u'Ã¢', u''),
		L.Original_POB_08);

		self.Original_POB_09 :=
		if(STD.Uni.Find(L.Original_POB_09, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_09, u'Ã¢', u''),
		L.Original_POB_09);

		self.Original_POB_10 :=
		if(STD.Uni.Find(L.Original_POB_10, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_POB_10, u'Ã¢', u''),
		L.Original_POB_10);

		self.Original_Additional_Info :=
		if(STD.Uni.Find(L.Original_Additional_Info, u'Ã¢', 1) <> 0, STD.Uni.FindReplace(L.Original_Additional_Info, u'Ã¢', u''),
		L.Original_Additional_Info);
		
		self := L;
		
	END;
	
	UNS := PROJECT(PROJECT(NotNullNormalizedUNSAddress, ReformatOctalUTF8(left)), ReformatOctalUTF8_1(left));
		
	GlobalWatchLists_Preprocess.rOutlayout ReformatUNS(GlobalWatchLists_Preprocess.IntermediaryLayoutInnovativeSystems.TempLayoutUNS1 L) := TRANSFORM
		
		unicode100 temp_orig_name 			:= if(STD.Uni.Find(L.Original_Primary_Name, ', born', 1) > 0
																				,STD.Uni.FindReplace(
																					STD.Uni.FindReplace(
																						STD.Uni.FindReplace(
																							STD.Uni.FindReplace(
																								STD.Uni.FindReplace(L.Original_Primary_Name[1..STD.Uni.Find(L.Original_Primary_Name, ', born', 1)-1]
																								,u'-',u'-')
																							,u'â€',u'"')
																						,u'â€œ','"')
																					,u'â€˜','\'')
																				,u'â€™','\'')
																				,STD.Uni.FindReplace(
																					STD.Uni.FindReplace(
																						STD.Uni.FindReplace(
																							STD.Uni.FindReplace(
																								STD.Uni.FindReplace(L.Original_Primary_Name, '-', '-')
																							,u'â€œ','"')
																						,u'â€','"')
																					,u'â€˜','\'')
																				,u'â€™','\''));

		unicode25 temp_id_01 		 				:= if(STD.Uni.Find(L.Original_ID_Type_01, u'NI', 1) > 0
																					and regexfind(u'^SSN', L.Original_Natl_ID_01) = true
																				,regexreplace(u'....$', TRIM(L.Original_Natl_ID_01), u'xxxx')
																				,L.Original_Natl_ID_01);
		unicode25 temp_id_02 						:= if(STD.Uni.Find(L.Original_ID_Type_02, u'NI', 1) > 0
																					and	regexfind(u'^SSN', L.Original_Natl_ID_02) = true
																				,regexreplace(u'....$', TRIM(L.Original_Natl_ID_02), u'xxxx')
																				,L.Original_Natl_ID_02);
		v_serial_no 										:= regexfind(u'(^[0]*)(\\d+)', regexfind(u'\\d+', L.Serial_Number, 0), 2);
		self.pty_key 										:= (string)STD.Uni.ToUpperCase(TRIM(L.Location) + TRIM(v_serial_no));
		self.source 										:= 'United Nations Named Terrorists';
		self.orig_pty_name 							:= ut.fn_KeepPrintableChars((string)TRIM(STD.Uni.ToUpperCase(temp_orig_name),LEFT,RIGHT));
		self.orig_vessel_name 					:= '';
		self.name_type 									:= if(L.AKA_Flag = 'G'
																				,'Good AKA'
																				,if(L.AKA_Flag = 'L'
																					,'Low AKA'
																					,if(L.AKA_Flag = 'A'
																						,'AKA'
																						,if(L.AKA_Flag = 'F'
																							,'FKA'
																							,''))));
		self.addr_1 										:= (string)STD.Uni.ToUpperCase(STD.Uni.FindReplace(TRIM(L.Original_Address_01, left, right), u'â€™', u'\''));
		self.addr_2 										:= (string)STD.Uni.ToUpperCase(STD.Uni.FindReplace(TRIM(L.Original_Address_02, left, right), u'â€™', u'\''));              
		self.addr_3 										:= (string)STD.Uni.ToUpperCase(STD.Uni.FindReplace(TRIM(L.Original_Address_03, left, right)
																				+ ' '
																				+ TRIM(L.Original_Address_04, left, right)
																				,u'â€™', u'\''));
		self.remarks_1 									:= (string)STD.Uni.ToUpperCase(STD.Uni.FindReplace(
																				if(TRIM(L.Original_Title_01) <> ''
																					,'Titles: '
																						+ TRIM(L.Original_Title_01)
																						+ if(TRIM(L.Original_Title_02) <> '', '; ' + TRIM(L.Original_Title_02), '')
																						+ if(TRIM(L.Original_Title_03) <> '', '; ' + TRIM(L.Original_Title_03), '')
																					,'')
																				,'"', ''));
		self.remarks_2 									:= (string)STD.Uni.ToUpperCase(STD.Uni.FindReplace(
																				if(TRIM(L.Original_Designation_01) <> ''
																					,'Designations: '
																						+ TRIM(L.Original_Designation_01)
																						+ if(TRIM(L.Original_Designation_02) <> '', '; ' + TRIM(L.Original_Designation_02), '')
																						+ if(TRIM(L.Original_Designation_03) <> '', '; ' + TRIM(L.Original_Designation_03), '')																																			
																					,'')
																				,'"', ''));
		self.remarks_3 									:= (string)STD.Uni.ToUpperCase(STD.Uni.FindReplace(
																				STD.Uni.FindReplace(
																					if(TRIM(L.Original_Natl_ID_01) <> ''
																							or TRIM(L.Original_Natl_ID_02) <> ''
																						,'Identifications: '
																							+ if(TRIM(L.Original_ID_Type_01) = 'PP'
																									,'Passport '
																									,if(TRIM(L.Original_ID_Type_01) = 'NI'
																										,'National ID '
																										,''))
																							+ TRIM(temp_id_01)
																							+ if(TRIM(L.Original_Natl_ID_02) <> ''
																									,if(TRIM(L.Original_ID_Type_02) = 'PP'
																																	,'; Passport '
																																	,if(TRIM(L.Original_ID_Type_02) = 'NI'
																																		,'; National ID '
																																		,'')) + TRIM(temp_id_02)																														
																									,'')																																	
																						,'')
																				,u'â€œ', u'')
																			 ,' ; ', ' '));
		self.remarks_4 									:= (string)if(TRIM(L.Original_DOB_01) <> ''
																					or TRIM(L.Original_DOB_02) <> ''
																					or TRIM(L.Original_DOB_03) <> ''
																					or TRIM(L.Original_DOB_04) <> ''
																					or TRIM(L.Original_DOB_05) <> ''
																					or TRIM(L.Original_DOB_06) <> ''
																					or TRIM(L.Original_DOB_07) <> ''
																					or TRIM(L.Original_DOB_08) <> ''
																					or TRIM(L.Original_DOB_09) <> ''
																					or TRIM(L.Original_DOB_10) <> ''
																				,'DATES OF BIRTH: '
																					+ (if(TRIM(L.Original_DOB_01) <> '', TRIM(L.Original_DOB_01), '')
																					+ if(TRIM(L.Original_DOB_02) <> '', '; ' + TRIM(L.Original_DOB_02), '')
																					+ if(TRIM(L.Original_DOB_03) <> '', '; ' + TRIM(L.Original_DOB_03), '')
																					+ if(TRIM(L.Original_DOB_04) <> '', '; ' + TRIM(L.Original_DOB_04), '')
																					+ if(TRIM(L.Original_DOB_05) <> '', '; ' + TRIM(L.Original_DOB_05), '')
																					+ if(TRIM(L.Original_DOB_06) <> '', '; ' + TRIM(L.Original_DOB_06), '')
																					+ if(TRIM(L.Original_DOB_07) <> '', '; ' + TRIM(L.Original_DOB_07), '')
																					+ if(TRIM(L.Original_DOB_08) <> '', '; ' + TRIM(L.Original_DOB_08), '')
																					+ if(TRIM(L.Original_DOB_09) <> '', '; ' + TRIM(L.Original_DOB_09), '')
																					+ if(TRIM(L.Original_DOB_10) <> '', '; ' + TRIM(L.Original_DOB_10), ''))
																				,'');
		self.remarks_5 									:= (string)STD.Uni.ToUpperCase(if(TRIM(L.Original_POB_01) <> ''
																					or TRIM(L.Original_POB_02) <> ''
																					or TRIM(L.Original_POB_03) <> ''
																					or TRIM(L.Original_POB_04) <> ''
																					or TRIM(L.Original_POB_05) <> ''
																					or TRIM(L.Original_POB_06) <> ''
																					or TRIM(L.Original_POB_07) <> ''
																					or TRIM(L.Original_POB_08) <> ''
																					or TRIM(L.Original_POB_09) <> ''
																					or TRIM(L.Original_POB_10) <> ''
																				,'PLACES OF BIRTH: '
																					+ (if(TRIM(L.Original_POB_01) <> '', TRIM(L.Original_POB_01), '')
																					+ if(TRIM(L.Original_POB_02) <> '', '; ' + TRIM(L.Original_POB_02), '')
																					+ if(TRIM(L.Original_POB_03) <> '', '; ' + TRIM(L.Original_POB_03), '')
																					+ if(TRIM(L.Original_POB_04) <> '', '; ' + TRIM(L.Original_POB_04), '')
																					+ if(TRIM(L.Original_POB_05) <> '', '; ' + TRIM(L.Original_POB_05), '')
																					+ if(TRIM(L.Original_POB_06) <> '', '; ' + TRIM(L.Original_POB_06), '')
																					+ if(TRIM(L.Original_POB_07) <> '', '; ' + TRIM(L.Original_POB_07), '')
																					+ if(TRIM(L.Original_POB_08) <> '', '; ' + TRIM(L.Original_POB_08), '')
																					+ if(TRIM(L.Original_POB_09) <> '', '; ' + TRIM(L.Original_POB_09), '')
																					+ if(TRIM(L.Original_POB_10) <> '', '; ' + TRIM(L.Original_POB_10), ''))
																				,''));
		self.remarks_6 									:= (string)STD.Uni.ToUpperCase(if(STD.Uni.Find(L.Original_Primary_Name, ', BORN', 1) > 0
																																								,'AKA ' + L.Original_Primary_Name																					 
																																								[STD.Uni.Find(L.Original_Primary_Name, 'BORN', 1)
																																								..50 + STD.Uni.Find(L.Original_Primary_Name, 'BORN', 1) - 1]
																																			,''));
		self.remarks_7 									:= (string)STD.Uni.ToUpperCase(if(TRIM(L.Original_Date_Added_To_List) <> ''
																				,'Date Added to List: ' + TRIM(L.Original_Date_Added_To_List)
																				,''));
		self.remarks_8 									:= (string)STD.Uni.ToUpperCase(if(TRIM(L.Original_Country_01) <> ''
																					or TRIM(L.Original_Country_02) <> ''
																					or TRIM(L.Original_Country_03) <> ''
																					or TRIM(L.Original_Country_04) <> ''
																					or TRIM(L.Original_Country_05) <> ''
																					or TRIM(L.Original_Country_06) <> ''
																					or TRIM(L.Original_Country_07) <> ''
																					or TRIM(L.Original_Country_08) <> ''
																					or TRIM(L.Original_Country_09) <> ''
																					or TRIM(L.Original_Country_10) <> ''
																				,'Nationalities: '
																					+ (if(TRIM(L.Original_Country_01) <> '', TRIM(L.Original_Country_01), '')
																					+ if(TRIM(L.Original_Country_02) <> '', '; ' + TRIM(L.Original_Country_02), '')
																					+ if(TRIM(L.Original_Country_03) <> '', '; ' + TRIM(L.Original_Country_03), '')
																					+ if(TRIM(L.Original_Country_04) <> '', '; ' + TRIM(L.Original_Country_04), '')
																					+ if(TRIM(L.Original_Country_05) <> '', '; ' + TRIM(L.Original_Country_05), '')
																					+ if(TRIM(L.Original_Country_06) <> '', '; ' + TRIM(L.Original_Country_06), '')
																					+ if(TRIM(L.Original_Country_07) <> '', '; ' + TRIM(L.Original_Country_07), '')
																					+ if(TRIM(L.Original_Country_08) <> '', '; ' + TRIM(L.Original_Country_08), '')
																					+ if(TRIM(L.Original_Country_09) <> '', '; ' + TRIM(L.Original_Country_09), '')
																					+ if(TRIM(L.Original_Country_10) <> '', '; ' + TRIM(L.Original_Country_10), ''))
																				,''));
		self.remarks_9 									:= (string)STD.Uni.ToUpperCase(if(TRIM(STD.Uni.FindReplace(L.Original_Additional_Info, 'Â ', '')) <> ''
																																															,u'Additional Information: '
																																															+ STD.Uni.FindReplace(
																																																	STD.Uni.FindReplace(
																																																		STD.Uni.FindReplace(TRIM(L.Original_Additional_Info), u'â€˜', u'\'')
																																																			,u'â€™', u'\'')																																																																							 
																																																		,u'â€“', u'-')																																																								  
																																																	,u''));
		self.cname_clean 								:= (string)if(TRIM(L.Location) = u'TALO'
																					or TRIM(L.Location) = u'AQO'
																				,self.orig_pty_name
																				,u'');
		self.pname_clean 								:= if(TRIM(L.Location) = u'TALI'
																					or TRIM(L.Location) = u'AQI'
																					and (L.AKA_Flag = 'G'
																						or L.AKA_Flag = 'L'
																						or L.AKA_Flag = 'A'
																						or L.AKA_Flag = 'F')
																					and STD.Uni.Find(L.Original_Primary_Name, ',', 1) = 0
																					and self.orig_pty_name <> ''
																								,Address.CleanPersonFML73(REGEXREPLACE('\\(PROMINENTLY KNOWN AS\\)',self.orig_pty_name,'',NOCASE))
																								,if(TRIM(L.Location) = 'TALI'
																										or TRIM(L.Location) = 'AQI'
																										and (L.AKA_Flag = 'G'
																											or L.AKA_Flag = 'L'
																											or L.AKA_Flag = 'A'
																											or L.AKA_Flag = 'F')
																										and STD.Uni.Find(L.Original_Primary_Name, ',', 1) > 0 and TRIM(temp_orig_name) <> ''
																													,Address.CleanPersonLFM73(self.orig_pty_name)
																													,Address.CleanPersonLFM73((string)(L.Cleaned_Last_Name + ' ' + L.Cleaned_First_Name))));//lname_scored(L.Cleaned_Last_Name + ' ' + L.Cleaned_First_Name))));
		TempAddrClean 								:= bo_address.CleanAddress182(REGEXREPLACE('(\\([A-Za-z]+(.*)\\))',(string)TRIM(L.Original_Address_01,left,right),'')
																															,STD.Str.CleanSpaces((string)TRIM(L.Original_Address_02,left,right) + ' ' 
																															+ IF(~REGEXFIND('^AS AT',(string)TRIM(L.Original_Address_03,left,right),NOCASE),(string)TRIM(L.Original_Address_03,left,right),'')+ ' '
																															+ (string)TRIM(L.Original_Address_04,left,right)));
		self.addr_clean									:= if(TempAddrClean[179..180] <> 'E5' 
																					and TempAddrClean[179..182] <> 'E213'
																					and TempAddrClean[179..182] <> 'E101'
																					,TempAddrClean
																					,'');
		self.date_first_seen 						:= GlobalWatchLists_Preprocess.Versions.InnovativeUNS_Version;
		self.date_last_seen 						:= GlobalWatchLists_Preprocess.Versions.InnovativeUNS_Version;
		self.date_vendor_first_reported := GlobalWatchLists_Preprocess.Versions.InnovativeUNS_Version;
		self.date_vendor_last_reported 	:= GlobalWatchLists_Preprocess.Versions.InnovativeUNS_Version;
		self.orig_entity_id 						:= (string)STD.Uni.ToUpperCase(TRIM(L.Location) + L.Serial_Number);
		self.orig_first_name 						:=	IF(trim(L.Cleaned_First_Name) = '', self.pname_clean[6..25], (string)STD.Uni.ToUppercase(L.Cleaned_First_Name));
		self.orig_last_name 						:=	IF(trim(L.Cleaned_Last_Name) = '', self.pname_clean[46..65], (string)STD.Uni.ToUppercase(L.Cleaned_Last_Name));
		self.orig_title_1 							:= (string)STD.Uni.ToUpperCase(TRIM(L.Original_Title_01));
		self.orig_title_2 							:= (string)STD.Uni.ToUpperCase(TRIM(L.Original_Title_02));
		self.orig_title_3 							:= (string)STD.Uni.ToUpperCase(TRIM(L.Original_Title_03));
		self.orig_title_4 							:= (string)STD.Uni.ToUpperCase(TRIM(L.Original_Title_04));
		self.orig_title_5 							:= (string)STD.Uni.ToUpperCase(TRIM(L.Original_Title_05));
		self.orig_title_6 							:= (string)STD.Uni.ToUpperCase(TRIM(L.Original_Title_06));
		self.orig_title_7 							:= (string)STD.Uni.ToUpperCase(TRIM(L.Original_Title_07));
		self.orig_title_8 							:= (string)STD.Uni.ToUpperCase(TRIM(L.Original_Title_08));
		self.orig_title_9 							:= (string)STD.Uni.ToUpperCase(TRIM(L.Original_Title_09));
		self.orig_title_10 							:= (string)STD.Uni.ToUpperCase(TRIM(L.Original_Title_10));
		self.orig_aka_id 								:= '';
		self.orig_aka_type 							:= if(L.AKA_Flag = 'G' or L.AKA_Flag = 'L' or L.AKA_Flag = 'A'
																				,'AKA'
																				,if(L.AKA_Flag = 'F', 'FKA', ''));
		self.orig_aka_category 					:= if(L.AKA_Flag = 'G', 'GOOD AKA', if(L.AKA_Flag = 'L', 'LOW AKA', ''));
		self.orig_giv_designator 				:= if(TRIM(L.Location) = 'TALO' or TRIM(L.Location) = 'AQO'
																				,'G'
																				,if(TRIM(L.Location) = 'TALI' or TRIM(L.Location) = 'AQI', 'I', ''));
		self.orig_address_id 						:= '';
		self.orig_address_line_1 				:= (string)STD.Uni.ToUpperCase(TRIM(STD.Uni.FindReplace(L.Original_Address_01, u'â€“', u'-')));
		self.orig_remarks 							:= (string)STD.Uni.ToUpperCase(STD.Uni.FindReplace(STD.Uni.FindReplace(TRIM(L.Original_Additional_Info), u'â€™', u'\''), u'â€“', u'-'));
		self.orig_id_type_1 						:= if(TRIM(L.Original_ID_Type_01) = 'PP'
																				,'PASSPORT'
																				,if(TRIM(L.Original_ID_Type_01) = 'NI', 'NATIONAL ID', ''));
		self.orig_id_number_1 					:= (string)STD.Uni.FindReplace(TRIM(L.Original_Natl_ID_01), u'â€œ', u'');								
		self.orig_id_type_2 						:= if(TRIM(L.Original_ID_Type_02) = 'PP'
																				,'PASSPORT'
																				,if(TRIM(L.Original_ID_Type_02) = 'NI'
																					,'NATIONAL ID'
																					,''));
		self.orig_id_number_2 					:= (string)STD.Uni.FindReplace(TRIM(L.Original_Natl_ID_02), u'â€œ', u'');								
		self.orig_id_type_3 						:= if(TRIM(L.Original_ID_Type_03) = 'PP'
																				,'PASSPORT'
																				,if(TRIM(L.Original_ID_Type_03) = 'NI'
																					,'NATIONAL ID'
																					,''));
		self.orig_id_number_3 					:= (string)STD.Uni.FindReplace(TRIM(L.Original_Natl_ID_03), u'â€œ', '');								
		self.orig_id_type_4 						:= if(TRIM(L.Original_ID_Type_04) = 'PP'
																				,'PASSPORT'
																				,if(TRIM(L.Original_ID_Type_04) = 'NI', 'NATIONAL ID', ''));
		self.orig_id_number_4 					:= (string)STD.Uni.FindReplace(TRIM(L.Original_Natl_ID_04), u'â€œ', '');								
		self.orig_id_type_5 						:= if(TRIM(L.Original_ID_Type_05) = 'PP'
																				,'PASSPORT'
																				,if(TRIM(L.Original_ID_Type_05) = 'NI'
																					,'NATIONAL ID'
																					,''));
		self.orig_id_number_5 					:= (string)STD.Uni.FindReplace(TRIM(L.Original_Natl_ID_05), u'â€œ', '');								
		self.orig_id_type_6 						:= if(TRIM(L.Original_ID_Type_06) = 'PP'
																				,'PASSPORT'
																				,if(TRIM(L.Original_ID_Type_06) = 'NI'
																					,'NATIONAL ID'
																					,''));
		self.orig_id_number_6 					:= (string)STD.Uni.FindReplace(TRIM(L.Original_Natl_ID_06), u'â€œ', '');								
		self.orig_id_type_7 						:= if(TRIM(L.Original_ID_Type_07) = 'PP'
																				,'PASSPORT'
																				,if(TRIM(L.Original_ID_Type_07) = 'NI', 'NATIONAL ID', ''));
		self.orig_id_number_7 					:= (string)STD.Uni.FindReplace(TRIM(L.Original_Natl_ID_07), u'â€œ', '');								
		self.orig_id_type_8 						:= if(TRIM(L.Original_ID_Type_08) = 'PP'
																				,'PASSPORT'
																				,if(TRIM(L.Original_ID_Type_08) = 'NI', 'NATIONAL ID', ''));
		self.orig_id_number_8 					:= (string)STD.Uni.FindReplace(TRIM(L.Original_Natl_ID_08), u'â€œ', '');								
		self.orig_id_type_9 						:= if(TRIM(L.Original_ID_Type_09) = 'PP'
																				,'PASSPORT'
																				,if(TRIM(L.Original_ID_Type_09) = 'NI', 'NATIONAL ID', ''));																					
		self.orig_id_number_9 					:= (string)STD.Uni.FindReplace(TRIM(L.Original_Natl_ID_09), u'â€œ', '');								
		self.orig_id_type_10 						:= if(TRIM(L.Original_ID_Type_10) = 'PP'
																				,'PASSPORT'
																				,if(TRIM(L.Original_ID_Type_10) = 'NI', 'NATIONAL ID', ''));
		self.orig_id_number_10 					:= (string)STD.Uni.FindReplace(TRIM(L.Original_Natl_ID_10), u'â€œ', '');								
		self.orig_nationality_1 				:= (string)STD.Uni.ToUpperCase(TRIM(L.Original_Country_01));
		self.orig_nationality_2 				:= (string)STD.Uni.ToUpperCase(TRIM(L.Original_Country_02));
		self.orig_nationality_3 				:= (string)STD.Uni.ToUpperCase(TRIM(L.Original_Country_03));
		self.orig_nationality_4 				:= (string)STD.Uni.ToUpperCase(TRIM(L.Original_Country_04));
		self.orig_nationality_5 				:= (string)STD.Uni.ToUpperCase(TRIM(L.Original_Country_05));
		self.orig_nationality_6 				:= (string)STD.Uni.ToUpperCase(TRIM(L.Original_Country_06));
		self.orig_nationality_7 				:= (string)STD.Uni.ToUpperCase(TRIM(L.Original_Country_07));
		self.orig_nationality_8 				:= (string)STD.Uni.ToUpperCase(TRIM(L.Original_Country_08));
		self.orig_nationality_9 				:= (string)STD.Uni.ToUpperCase(TRIM(L.Original_Country_09));
		self.orig_nationality_10 				:= (string)STD.Uni.ToUpperCase(TRIM(L.Original_Country_10));
		self.orig_dob_1 								:= (string)if(TRIM(L.Original_DOB_01) <> ''
																				,TRIM(L.Original_DOB_01)
																				,if(STD.Uni.Find(L.Original_Primary_Name, ', born', 1) > 0
																						and STD.Uni.Find(L.Original_Primary_Name, ' in ', 1) = 0
																					,L.Original_Primary_Name
																							[STD.Uni.Find(L.Original_Primary_Name, ', born', 1)+7																																 
																							..20+STD.Uni.Find(L.Original_Primary_Name, ', born', 1)+7-1]
																					,if(STD.Uni.Find(L.Original_Primary_Name,', born', 1) > 0
																							and	STD.Uni.Find(L.Original_Primary_Name,' in ', 1) > 0
																						,L.Original_Primary_Name
																							 [STD.Uni.Find(L.Original_Primary_Name, ', born', 1)+7																																							
																							 ..20+STD.Uni.Find(L.Original_Primary_Name, ', born', 1)+7-1]
																										 [1
																										 ..STD.Uni.Find(L.Original_Primary_Name
																																			 [STD.Uni.Find(L.Original_Primary_Name, ', born', 1)+7																																										
																																			 ..20+STD.Uni.Find(L.Original_Primary_Name, ', born', 1)+7-1], ' in ', 1)-1
																										 ]
																						,'')))[1..8];
		self.orig_dob_2 								:= (string)if(TRIM(L.Original_DOB_02) <> ''
																				,TRIM(L.Original_DOB_02)
																				,if(STD.Uni.Find(L.Original_Primary_Name, ', born', 1) > 0
																						and TRIM(L.Original_DOB_01) <> ''
																						and STD.Uni.Find(L.Original_Primary_Name, ' in ', 1) = 0
																					,L.Original_Primary_Name
																							[STD.Uni.Find(L.Original_Primary_Name, ', born', 1)+7																													 
																							..20+STD.Uni.Find(L.Original_Primary_Name, ', born', 1)+7-1]
																					,if(STD.Uni.Find(L.Original_Primary_Name, ', born', 1) > 0
																							and TRIM(L.Original_DOB_01) <> ''
																							and STD.Uni.Find(L.Original_Primary_Name, ' in ', 1) > 0
																						,L.Original_Primary_Name
																							 [STD.Uni.Find(L.Original_Primary_Name, ', born', 1)+7																																							
																							 ..20+STD.Uni.Find(L.Original_Primary_Name, ', born', 1)+7-1]
																										 [1
																										 ..STD.Uni.Find(L.Original_Primary_Name
																																			 [STD.Uni.Find(L.Original_Primary_Name, ', born', 1)+7																																																			
																																			 ..20+STD.Uni.Find(L.Original_Primary_Name, ', born', 1)+7-1], ' in ', 1)-1
																										 ]
																						,'')))[1..8];
		self.orig_dob_3 								:= (string)if(TRIM(L.Original_DOB_03) <> ''
																				,TRIM(L.Original_DOB_03)
																				,if(STD.Uni.Find(L.Original_Primary_Name,', born', 1) > 0
																						and TRIM(L.Original_DOB_02) <> ''
																						and STD.Uni.Find(L.Original_Primary_Name,' in ', 1) = 0
																					,L.Original_Primary_Name
																							[STD.Uni.Find(L.Original_Primary_Name, ', born', 1)+7																										 
																							..20+STD.Uni.Find(L.Original_Primary_Name, ', born', 1)+7-1]
																					,if(STD.Uni.Find(L.Original_Primary_Name, ', born', 1) > 0
																							and TRIM(L.Original_DOB_02) <> ''
																							and STD.Uni.Find(L.Original_Primary_Name, ' in ', 1) > 0
																						,L.Original_Primary_Name
																							 [STD.Uni.Find(L.Original_Primary_Name, ', born', 1)+7
																							 ..20+STD.Uni.Find(L.Original_Primary_Name, ', born', 1)+7-1]
																										 [1
																										 ..STD.Uni.Find(L.Original_Primary_Name
																																			 [STD.Uni.Find(L.Original_Primary_Name, ', born', 1)+7
																																			 ..20+STD.Uni.Find(L.Original_Primary_Name, ', born', 1)+7-1], ' in ', 1)-1
																										 ]
																						,'')))[1..8];
		self.orig_dob_4 								:= (string)if(TRIM(L.Original_DOB_04) <> ''
																				,TRIM(L.Original_DOB_04)
																				,if(STD.Uni.Find(L.Original_Primary_Name,', born', 1) > 0
																						and	TRIM(L.Original_DOB_03) <> ''
																						and STD.Uni.Find(L.Original_Primary_Name, ' in ', 1) = 0
																					,L.Original_Primary_Name
																							[STD.Uni.Find(L.Original_Primary_Name, ', born', 1)+7
																							..20+STD.Uni.Find(L.Original_Primary_Name, ', born', 1)+7-1]
																					,if(STD.Uni.Find(L.Original_Primary_Name,', born', 1) > 0
																							and TRIM(L.Original_DOB_03) <> ''
																							and STD.Uni.Find(L.Original_Primary_Name, ' in ', 1) > 0
																						,L.Original_Primary_Name
																							 [STD.Uni.Find(L.Original_Primary_Name, ', born', 1)+7
																							 ..20+STD.Uni.Find(L.Original_Primary_Name, ', born', 1)+7-1]
																										 [1
																										 ..STD.Uni.Find(L.Original_Primary_Name
																																			 [STD.Uni.Find(L.Original_Primary_Name, ', born', 1)+7
																																			 ..20+STD.Uni.Find(L.Original_Primary_Name, ', born', 1)+7-1], ' in ', 1)-1
																										 ]
																						,'')))[1..8];
		self.orig_dob_5 								:= (string)if(TRIM(L.Original_DOB_05) <> ''
																				,TRIM(L.Original_DOB_05)
																				,if(STD.Uni.Find(L.Original_Primary_Name, ', born', 1) > 0
																						and TRIM(L.Original_DOB_04) <> ''
																						and STD.Uni.Find(L.Original_Primary_Name, ' in ', 1) = 0
																					,L.Original_Primary_Name
																							[STD.Uni.Find(L.Original_Primary_Name, ', born', 1)+7
																							..20+STD.Uni.Find(L.Original_Primary_Name, ', born', 1)+7-1]
																					,if(STD.Uni.Find(L.Original_Primary_Name, ', born', 1) > 0
																							and TRIM(L.Original_DOB_04) <> ''
																							and STD.Uni.Find(L.Original_Primary_Name, ' in ', 1) > 0
																						,L.Original_Primary_Name
																							 [STD.Uni.Find(L.Original_Primary_Name, ', born', 1)+7
																							 ..20+STD.Uni.Find(L.Original_Primary_Name, ', born', 1)+7-1]
																										 [1
																										 ..STD.Uni.Find(L.Original_Primary_Name
																																			 [STD.Uni.Find(L.Original_Primary_Name, ', born', 1)+7
																																			 ..20+STD.Uni.Find(L.Original_Primary_Name, ', born', 1)+7-1], ' in ', 1)-1
																										 ]
																						,'')))[1..8];
		self.orig_dob_6 								:= (string)if(TRIM(L.Original_DOB_06) <> ''
																				,TRIM(L.Original_DOB_06)
																				,if(STD.Uni.Find(L.Original_Primary_Name,', born', 1) > 0
																						and TRIM(L.Original_DOB_05) <> ''
																						and STD.Uni.Find(L.Original_Primary_Name, ' in ', 1) = 0
																					,L.Original_Primary_Name
																							[STD.Uni.Find(L.Original_Primary_Name, ', born', 1)+7
																							..20+STD.Uni.Find(L.Original_Primary_Name, ', born', 1)+7-1]
																					,if(STD.Uni.Find(L.Original_Primary_Name,', born', 1) > 0
																							and TRIM(L.Original_DOB_05) <> ''
																							and STD.Uni.Find(L.Original_Primary_Name, ' in ', 1) > 0
																						,L.Original_Primary_Name
																							 [STD.Uni.Find(L.Original_Primary_Name, ', born', 1)+7
																							 ..20+STD.Uni.Find(L.Original_Primary_Name, ', born', 1)+7-1]
																										 [1
																										 ..STD.Uni.Find(L.Original_Primary_Name
																																			 [STD.Uni.Find(L.Original_Primary_Name,', born', 1)+7
																																			 ..20+STD.Uni.Find(L.Original_Primary_Name, ', born', 1)+7-1], ' in ', 1)-1
																										 ]
																						,'')))[1..8];
		self.orig_dob_7 								:= (string)if(TRIM(L.Original_DOB_07) <> ''
																				,TRIM(L.Original_DOB_07)
																				,if(STD.Uni.Find(L.Original_Primary_Name, ', born', 1) > 0
																						and TRIM(L.Original_DOB_06) <> ''
																					,L.Original_Primary_Name[STD.Uni.Find(L.Original_Primary_Name, ', born', 1)+7..20+STD.Uni.Find(L.Original_Primary_Name, ', born', 1)+7-1]
																					,''))[1..8];
		self.orig_dob_8 								:= (string)if(TRIM(L.Original_DOB_08) <> ''
																				,TRIM(L.Original_DOB_08)
																				,if(STD.Uni.Find(L.Original_Primary_Name, ', born', 1) > 0
																						and TRIM(L.Original_DOB_07) <> ''
																					,L.Original_Primary_Name[STD.Uni.Find(L.Original_Primary_Name, ', born', 1)+7..20+STD.Uni.Find(L.Original_Primary_Name, ', born', 1)+7-1]
																					,''))[1..8];
		self.orig_dob_9 								:= (string)if(TRIM(L.Original_DOB_09) <> ''
																				,TRIM(L.Original_DOB_09)
																				,if(STD.Uni.Find(L.Original_Primary_Name, ', born', 1) > 0
																						and TRIM(L.Original_DOB_08) <> ''
																					,L.Original_Primary_Name[STD.Uni.Find(L.Original_Primary_Name, ', born', 1)+7..20+STD.Uni.Find(L.Original_Primary_Name, ', born', 1)+7-1]
																					,''))[1..8];
		self.orig_dob_10 								:= (string)if(TRIM(L.Original_DOB_10) <> ''
																				,TRIM(L.Original_DOB_10)
																				,if(STD.Uni.Find(L.Original_Primary_Name, ', born', 1) > 0
																						and TRIM(L.Original_DOB_09) <> ''
																					,L.Original_Primary_Name[STD.Uni.Find(L.Original_Primary_Name, ', born', 1)+7..20+STD.Uni.Find(L.Original_Primary_Name, ', born', 1)+7-1]
																					,''))[1..8];
		self.orig_pob_1 								:= (string)STD.Uni.ToUpperCase(if(TRIM(L.Original_POB_01) <> ''
																				,TRIM(L.Original_POB_01)
																				,if(STD.Uni.Find(L.Original_Primary_Name, ', born', 1) > 0
																						and STD.Uni.Find(L.Original_Primary_Name, ' in ', 1) > 0
																					,L.Original_Primary_Name[STD.Uni.Find(L.Original_Primary_Name, ' in ', 1)+4..80+STD.Uni.Find(L.Original_Primary_Name, ' in ', 1)+4-1]
																					,'')));
		self.orig_pob_2 								:= (string)STD.Uni.ToUpperCase(if(TRIM(L.Original_POB_02) <> ''
																				,TRIM(L.Original_POB_02)
																				,if(STD.Uni.Find(L.Original_Primary_Name, ', born', 1) > 0
																						and STD.Uni.Find(L.Original_Primary_Name, ' in ', 1) > 0
																						and TRIM(L.Original_POB_01) <> ''
																					,L.Original_Primary_Name[STD.Uni.Find(L.Original_Primary_Name, ' in ', 1)+4..80+STD.Uni.Find(L.Original_Primary_Name, ' in ', 1)+4-1]
																					,'')));
		self.orig_pob_3 								:= (string)STD.Uni.ToUpperCase(if(TRIM(L.Original_POB_03) <> ''
																				,TRIM(L.Original_POB_03)
																				,if(STD.Uni.Find(L.Original_Primary_Name, ', born', 1) > 0
																						and STD.Uni.Find(L.Original_Primary_Name, ' in ', 1) > 0
																						and TRIM(L.Original_POB_02) <> ''
																					,L.Original_Primary_Name[STD.Uni.Find(L.Original_Primary_Name, ' in ', 1)+4..80+STD.Uni.Find(L.Original_Primary_Name, ' in ', 1)+4-1]
																					,'')));
		self.orig_pob_4 								:= (string)STD.Uni.ToUpperCase(if(TRIM(L.Original_POB_04) <> ''
																				,TRIM(L.Original_POB_04)
																				,if(STD.Uni.Find(L.Original_Primary_Name, ', born', 1) > 0
																						and STD.Uni.Find(L.Original_Primary_Name, ' in ', 1) > 0
																						and TRIM(L.Original_POB_03) <> ''
																					,L.Original_Primary_Name[STD.Uni.Find(L.Original_Primary_Name, ' in ', 1)+4..80+STD.Uni.Find(L.Original_Primary_Name, ' in ', 1)+4-1]
																					,'')));
		self.orig_pob_5 								:= (string)STD.Uni.ToUpperCase(if(TRIM(L.Original_POB_05) <> ''
																				,TRIM(L.Original_POB_05)
																				,if(STD.Uni.Find(L.Original_Primary_Name, ', born', 1) > 0
																						and STD.Uni.Find(L.Original_Primary_Name, ' in ', 1) > 0
																						and TRIM(L.Original_POB_04) <> ''
																					,L.Original_Primary_Name[STD.Uni.Find(L.Original_Primary_Name, ' in ', 1)+4..80+STD.Uni.Find(L.Original_Primary_Name, ' in ', 1)+4-1]
																					,'')));
		self.orig_pob_6 								:= (string)STD.Uni.ToUpperCase(if(TRIM(L.Original_POB_06) <> ''
																				,TRIM(L.Original_POB_06)
																				,if(STD.Uni.Find(L.Original_Primary_Name, ', born', 1) > 0
																						and STD.Uni.Find(L.Original_Primary_Name, ' in ', 1) > 0
																						and TRIM(L.Original_POB_05) <> ''
																					,L.Original_Primary_Name[STD.Uni.Find(L.Original_Primary_Name, ' in ', 1)+4..80+STD.Uni.Find(L.Original_Primary_Name, ' in ', 1)+4-1]
																					,'')));
		self.orig_pob_7 								:= (string)STD.Uni.ToUpperCase(if(TRIM(L.Original_POB_07) <> ''
																				,TRIM(L.Original_POB_07)
																				,if(STD.Uni.Find(L.Original_Primary_Name, ', born', 1) > 0
																						and STD.Uni.Find(L.Original_Primary_Name, ' in ', 1) > 0
																						and TRIM(L.Original_POB_06) <> ''
																					,L.Original_Primary_Name[STD.Uni.Find(L.Original_Primary_Name, ' in ', 1)+4..80+STD.Uni.Find(L.Original_Primary_Name, ' in ', 1)+4-1]
																					,'')));
		self.orig_pob_8 								:= (string)STD.Uni.ToUpperCase(if(TRIM(L.Original_POB_08) <> ''
																				,TRIM(L.Original_POB_08)
																				,if(STD.Uni.Find(L.Original_Primary_Name, ', born', 1) > 0
																						and STD.Uni.Find(L.Original_Primary_Name, ' in ', 1) > 0
																						and TRIM(L.Original_POB_07) <> ''
																					,L.Original_Primary_Name[STD.Uni.Find(L.Original_Primary_Name, ' in ', 1)+4..80+STD.Uni.Find(L.Original_Primary_Name, ' in ', 1)+4-1]
																					,'')));
		self.orig_pob_9 								:= (string)STD.Uni.ToUpperCase(if(TRIM(L.Original_POB_09) <> ''
																				,TRIM(L.Original_POB_09)
																				,if(STD.Uni.Find(L.Original_Primary_Name, ', born', 1) > 0
																						and	STD.Uni.Find(L.Original_Primary_Name, ' in ', 1) > 0
																						and TRIM(L.Original_POB_08) <> ''
																					,L.Original_Primary_Name[STD.Uni.Find(L.Original_Primary_Name, ' in ', 1)+4..80+STD.Uni.Find(L.Original_Primary_Name, ' in ', 1)+4-1]
																					,'')));
		self.orig_pob_10 								:= (string)STD.Uni.ToUpperCase(if(TRIM(L.Original_POB_10) <> ''
																				,TRIM(L.Original_POB_10)
																				,if(STD.Uni.Find(L.Original_Primary_Name, ', born', 1) > 0
																						and STD.Uni.Find(L.Original_Primary_Name, ' in ', 1) > 0
																						and TRIM(L.Original_POB_09) <> ''
																					,L.Original_Primary_Name[STD.Uni.Find(L.Original_Primary_Name, ' in ', 1)+4..80+STD.Uni.Find(L.Original_Primary_Name, ' in ', 1)+4-1]
																					,'')));
		self.orig_membership_1 					:= if(TRIM(L.Location) = 'TALO' or TRIM(L.Location) = 'TALI'
																				,'TALIBAN'
																				,if(TRIM(L.Location) = 'AQO' or TRIM(L.Location) = 'AQI'
																					,'AL QAIDA'
																					,''));
		self.orig_position_1 						:= (string)STD.Uni.ToUpperCase(TRIM(L.Original_Designation_01));
		self.orig_position_2 						:= (string)STD.Uni.ToUpperCase(TRIM(L.Original_Designation_02));
		self.orig_position_3 						:= (string)STD.Uni.ToUpperCase(TRIM(L.Original_Designation_03));
		self.orig_position_4 						:= (string)STD.Uni.ToUpperCase(TRIM(L.Original_Designation_04));
		self.orig_position_5 						:= (string)STD.Uni.ToUpperCase(TRIM(L.Original_Designation_05));
		self.orig_position_6 						:= (string)STD.Uni.ToUpperCase(TRIM(L.Original_Designation_06));
		self.orig_position_7 						:= (string)STD.Uni.ToUpperCase(TRIM(L.Original_Designation_07));
		self.orig_position_8 						:= (string)STD.Uni.ToUpperCase(TRIM(L.Original_Designation_08));
		self.orig_position_9 						:= (string)STD.Uni.ToUpperCase(TRIM(L.Original_Designation_09));
		self.orig_position_10 					:= (string)STD.Uni.ToUpperCase(TRIM(L.Original_Designation_10));
		self.orig_date_added_to_list 		:= (string)STD.Uni.ToUpperCase(L.Original_Date_Added_To_List);
		self.orig_raw_name							:= (string)STD.Uni.ToUpperCase(TRIM(L.orig_raw_name));
	END;
	
	return CleanDOB(PROJECT(PROJECT(UNS, Reformat(LEFT)), ReformatUNS(LEFT)))(orig_pty_name <> '');

END;