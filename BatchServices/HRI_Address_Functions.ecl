import risk_indicators, BatchServices;

layout_slim	:= BatchServices.HRI_Address_Layout.output_slim;
layout_key	:= Risk_Indicators.Key_Address_To_Sic_Full_HRI;
Sic_Code_key :=Risk_Indicators.Key_Sic_Description; 

export HRI_Address_Functions := Module 
		
		export unsigned2 get_rank(string8 sic_code) := function
			
			ranking := map(sic_code[1..4] = '9711' =>99,
											sic_code[1..4] = '8351' =>98,
											sic_code[1..4] = '8211' =>97,
											sic_code[1..4] = '8299' =>96,
											sic_code[1..4] = '8249' =>95,
											sic_code[1..4] = '8222' =>94,
											sic_code[1..4] = '8243' =>93,
											sic_code[1..4] = '8244' =>92,
											sic_code[1..4] = '8221' =>91,
											sic_code[1..4] = '8231' =>90,
											sic_code[1..4] = '8322' =>89,
											sic_code[1..4] = '8399' =>88,
											sic_code[1..4] = '8361' =>87,
											sic_code[1..4] = '8412' =>86,
											sic_code[1..4] = '4311' =>85,
											sic_code[1..4] = '5961' =>84,
											sic_code[1..4] = '8111' =>83,
											sic_code[1..4] = '9222' =>82,
											sic_code[1..4] = '9223' =>81,
											sic_code[1..4] = '5541' =>80,
											sic_code[1..4] = '5999' =>79,
											sic_code[1..4] = '9411' =>78,
											sic_code[1..4] = '9431' =>77,
											sic_code[1..4] = '9441' =>76,
											sic_code[1..4] = '9451' =>75,
											sic_code[1..4] = '9531' =>74,
											sic_code[1..4] = '9532' =>73,
											0);
			return ranking;
		end;
		
		sic_desc := record
			string80 desc;
		end;
		
		export string80 getSic_Code_Desc(string8 val) := function
			input_sic := trim(val,left,right);
			match_full_sic :=(Risk_Indicators.Key_Sic_Description(sic_code=input_sic)[1].sic_description);
			match_six_sic :=(Risk_Indicators.Key_Sic_Description(sic_code[1..6]=input_sic[1..6])[1].sic_description);
			match_four_sic :=(Risk_Indicators.Key_Sic_Description(sic_code[1..4]=input_sic[1..4])[1].sic_description);
			
			description := map(match_full_sic <> '' => match_full_sic, 
												 match_six_sic <> '' => match_six_sic,
												 match_four_sic <> '' => match_four_sic,
													'');
										
			return description;
		end;
		
end;