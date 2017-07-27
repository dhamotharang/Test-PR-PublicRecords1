export Layouts_Accident := module

	shared max_size := _Dataset().max_record_size;

	export Input := record,maxlength(max_size)
			string Dart_Id;		
			string Mine_Id;					
			string Contractor_Id;
			string Sub_Unit;						
			string Sub_Unit_Description;							
			string Accident_Date;						
			string Degree_of_Injury;						
			string Accident_Classification_Description;						
			string Occupation_Code_Description;					
			string Miner_Activity;					
			string Total_Experience;	
			string Mine_Experience;
			string Job_Experience;
			string Accident_Narrative;
	end;

	export Base := record
			string5 		Dart_Id;		
			string7 		Mine_Id;					
			string7 		Mine_Id_Cleaned;	
			string7 		Contractor_Id;
			string7 		Contractor_Id_Cleaned;			
			string2 		Sub_Unit;
			string2 		Sub_Unit_Cleaned;		
			string50 		Sub_Unit_Description;							
			string8 		Accident_Date;						
			string40 		Degree_of_Injury;						
			string50 		Accident_Classification_Description;						
			string50 		Occupation_Code_Description;					
			string40    Miner_Activity;					
			udecimal4_2	Total_Experience;
			udecimal4_2 Mine_Experience;	
			udecimal4_2 Job_Experience;		
			string1000  Accident_Narrative;
	end;

end;