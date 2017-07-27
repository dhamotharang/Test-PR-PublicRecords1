IMPORT Seed_Files, Risk_Indicators;

EXPORT HealthCare_Attributes_TestSeed_Function(
	DATASET(Risk_Indicators.Layout_Input) inData,
	STRING20 TestDataTableName
	) := FUNCTION
	Test_Data_Table_Name := StringLib.StringToUpperCase(TestDataTableName);
	
rAttributes := record
	integer 		seq;
	string12		did;
	Models.layouts.Layout_HealthCare_Attributes;
end;	
	
	rAttributes create_output(inData le, Seed_Files.Key_HealthCareAttributes ri) := TRANSFORM
		SELF.seq 										:= le.seq;
		self.EstimatedHHSize				:= (DECIMAL8_2)ri.EstimatedHHSize;
		self.HHOccupantDescription	:= ri.HHOccupantDescription;
		self.CensusAveHHSize				:= (DECIMAL8_2)ri.CensusAveHHSize;
		self.EstimatedHHIncome			:= (integer)ri.EstimatedHHIncome;		
		self.did 										:= [];
	END;
	
	HealthCare_Attr_rec := JOIN(inData, Seed_Files.Key_HealthCareAttributes, 
		KEYED(RIGHT.dataset_name = Test_Data_Table_Name)
		and KEYED(RIGHT.hashvalue = Seed_Files.Hash_InstantID((STRING20)LEFT.fname, (STRING20)LEFT.lname,
			(STRING9)LEFT.ssn, '', (STRING5)LEFT.in_zipCode, (STRING10)LEFT.phone10, '')),
		create_output(LEFT,RIGHT), LEFT OUTER, ATMOST(100),KEEP(1));
	RETURN HealthCare_Attr_rec;
END;