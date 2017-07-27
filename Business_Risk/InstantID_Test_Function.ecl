/*2012-09-20T20:13:33Z (Ken Hill)
111402 -- BIID return seed risk indicators in new array for output
*/
/*2012-09-17T19:11:28Z (Ken Hill)
111402 -- BIID return all risk indicators
*/
import Seed_Files,Models, risk_indicators;

// put account_value into account number fields rather than account number in test seed
export InstantID_Test_Function(string20 TestDataTableName,string30 fname_val,string30 lname_val,string9 FEIN,
				string5 zip_value,string10 phone_value,string30 company_name, string30 Account_Value) := 
				FUNCTION
				
				
	r := RECORD
		business_risk.Layout_Final_Denorm;
		DATASET(Models.Layout_Model) models;		
	end;
	
	Rep_Attributes := RECORD
		STRING32 Name := '';
		STRING128 Value := '';
	END;		

	r Make_BInstantID_rec(Seed_files.Key_BInstantID L)	:=Transform
	  self.account := Account_Value;
		
		self.PRI_seq_1 := if(L.pri_1 = '', '', '1');
		self.PRI_seq_2 := if(L.pri_2 = '', '', '2');
		self.PRI_seq_3 := if(L.pri_3 = '', '', '3');
		self.PRI_seq_4 := if(L.pri_4 = '', '', '4');
		self.PRI_seq_5 := if(L.pri_5 = '', '', '5');
		self.PRI_seq_6 := if(L.pri_6 = '', '', '6');
		self.PRI_seq_7 := if(L.pri_7 = '', '', '7');
		self.PRI_seq_8 := if(L.pri_8 = '', '', '8');
		self.Rep_PRI_seq_1 := if (L.rep_pri_1 = '', '' , '1');
		self.Rep_PRI_seq_2 := if (L.rep_pri_2 = '', '' , '2');
		self.Rep_PRI_seq_3 := if (L.rep_pri_3 = '', '' , '3');
		self.Rep_PRI_seq_4 := if (L.rep_pri_4 = '', '' , '4');
		self.Rep_PRI_seq_5 := if (L.rep_pri_5 = '', '' , '5');
		self.Rep_PRI_seq_6 := if (L.rep_pri_6 = '', '' , '6');
		
		bri := DATASET([
			{L.pri_1, L.pri_desc_1},
			{L.pri_2, L.pri_desc_2},
			{L.pri_3, L.pri_desc_3},
			{L.pri_4, L.pri_desc_4},
			{L.pri_5, L.pri_desc_5},
			{L.pri_6, L.pri_desc_6},
			{L.pri_7, L.pri_desc_7},
			{L.pri_8, L.pri_desc_8}
			],risk_indicators.Layout_Desc)(hri!='');
			
		risk_indicators.mac_add_sequence(bri, bri_with_seq);
		self.BusRiskIndicators := bri_with_seq;
		
		rbri := DATASET([
			{L.rep_pri_1, L.rep_pri_desc_1},
			{L.rep_pri_2, L.rep_pri_desc_2},
			{L.rep_pri_3, L.rep_pri_desc_3},
			{L.rep_pri_4, L.rep_pri_desc_4},
			{L.rep_pri_5, L.rep_pri_desc_5},
			{L.rep_pri_6, L.rep_pri_desc_6}
			],risk_indicators.Layout_Desc)(hri!='');
			
		risk_indicators.mac_add_sequence(rbri, rbri_with_seq);
		self.RepRiskIndicators := rbri_with_seq;

		self.Watchlist_seq_1 := if(l.watchlist_table='', '', '1');
		self.Watchlist_seq_2 := if(l.watchlist_table_2='', '', '2');
		self.Watchlist_seq_3 := if(l.watchlist_table_3='', '', '3');
		self.Watchlist_seq_4 := if(l.watchlist_table_4='', '', '4');
		self.Watchlist_seq_5 := if(l.watchlist_table_5='', '', '5');
		self.Watchlist_seq_6 := if(l.watchlist_table_6='', '', '6');
		self.Watchlist_seq_7 := if(l.watchlist_table_7='', '', '7');
		self.RepWatchlist_seq_1 := if(l.repwatchlist_table='', '', '1');
		self.RepWatchlist_seq_2 := if(l.repwatchlist_table_2='', '', '2');
		self.RepWatchlist_seq_3 := if(l.repwatchlist_table_3='', '', '3');
		self.RepWatchlist_seq_4 := if(l.repwatchlist_table_4='', '', '4');
		self.RepWatchlist_seq_5 := if(l.repwatchlist_table_5='', '', '5');
		self.RepWatchlist_seq_6 := if(l.repwatchlist_table_6='', '', '6');
		self.RepWatchlist_seq_7 := if(l.repwatchlist_table_7='', '', '7');
	
		Rep_Lien_Unrel_Lvl := L.Rep_Lien_Unrel_Lvl;
		Rep_Prop_Owner := L.Rep_Prop_Owner;
		Rep_Prof_License_Category := L.Rep_Prof_License_Category;
		Rep_Accident_Count := L.Rep_Accident_Count;
		Rep_Paydayloan_Flag := L.Rep_Paydayloan_Flag;
		Rep_Age_Lvl := L.Rep_Age_Lvl;
		Rep_Bankruptcy_Count := L.Rep_Bankruptcy_Count;
		Rep_Ssns_Per_Adl := L.Rep_Ssns_Per_Adl;
		Rep_Past_Arrest := L.Rep_Past_Arrest;
		Rep_Add1_Lres_Lvl := L.Rep_Add1_Lres_Lvl;
		Rep_Criminal_Assoc_Lvl := L.Rep_Criminal_Assoc_Lvl;
		Rep_Felony_Count := L.Rep_Felony_Count;
		
		fullSet := DATASET([
												{'Rep_Lien_Unrel_Lvl', Rep_Lien_Unrel_Lvl},
												{'Rep_Prop_Owner', Rep_Prop_Owner},
												{'Rep_Prof_License_Category', Rep_Prof_License_Category},
												{'Rep_Accident_Count', Rep_Accident_Count},
												{'Rep_Paydayloan_Flag', Rep_Paydayloan_Flag},
												{'Rep_Age_Lvl', Rep_Age_Lvl},
												{'Rep_Bankruptcy_Count', Rep_Bankruptcy_Count},
												{'Rep_Ssns_Per_Adl', Rep_Ssns_Per_Adl},
												{'Rep_Past_Arrest', Rep_Past_Arrest},
												{'Rep_Add1_Lres_Lvl', Rep_Add1_Lres_Lvl},
												{'Rep_Criminal_Assoc_Lvl', Rep_Criminal_Assoc_Lvl},
												{'Rep_Felony_Count', Rep_Felony_Count}
											], Rep_Attributes);
	
		SELF.Attributes := fullSet;
		
		self := l;	
		self.models := [];
	END;
	
	fname_value :=stringlib.stringtouppercase(fname_val);
	lname_value :=stringlib.stringtouppercase(lname_val);
	cname_value :=stringlib.stringtouppercase(company_name);
	Test_Data_Table_Name :=stringlib.stringtouppercase(TestDataTableName);

	hash_from_input :=Seed_Files.Hash_InstantID((string20)fname_value,(string20)lname_value,Risk_Indicators.nullstring,
													(string9) FEIN, (string5)zip_value,(string10)phone_value,(string30)cname_value);
	
	SeedFile_rec := Choosen(Seed_Files.Key_BInstantID(keyed(dataset_name=Test_Data_Table_Name), keyed(hashvalue = hash_from_input)),1);
	
	BInstantID_rec :=project(SeedFile_rec,Make_BInstantID_rec(left));
	
	return BInstantID_rec;


END;
