IMPORT Seed_Files, Risk_Indicators,iesp;

EXPORT TestSeed_Function(
	DATASET(Risk_Indicators.Layout_Input) inData,
	STRING20 TestDataTableName,
	BOOLEAN  IncludeModel = false,
	BOOLEAN  IncludeReport = false
	
	) := FUNCTION
	Test_Data_Table_Name := StringLib.StringToUpperCase(TestDataTableName);
	
	VerificationOfOccupancy.Layouts.Layout_VOOBatchOut create_output(inData le, Seed_Files.Key_VerificationOfOccupancy ri) := TRANSFORM
		SELF.AcctNo 																								:= [];
		SELF.seq 																										:= le.seq;
		SELF.LexID 																									:= [];
		self.attributes.version1.AddressReportingSourceIndex				:= ri.AddressReportingSourceIndex;
		self.attributes.version1.AddressReportingHistoryIndex				:= ri.AddressReportingHistoryIndex;
		self.attributes.version1.AddressSearchHistoryIndex					:= ri.AddressSearchHistoryIndex;
		self.attributes.version1.AddressUtilityHistoryIndex					:= ri.AddressUtilityHistoryIndex;
		self.attributes.version1.AddressOwnershipHistoryIndex				:= ri.AddressOwnershipHistoryIndex;
		self.attributes.version1.AddressPropertyTypeIndex						:= ri.AddressPropertyTypeIndex;
		self.attributes.version1.AddressValidityIndex								:= ri.AddressValidityIndex;
		self.attributes.version1.RelativesConfirmingAddressIndex		:= ri.RelativesConfirmingAddressIndex;
		self.attributes.version1.AddressOwnerMailingAddressIndex		:= ri.AddressOwnerMailingAddressIndex;
		self.attributes.version1.PriorAddressMoveIndex							:= ri.PriorAddressMoveIndex;
		self.attributes.version1.PriorResidentMoveIndex							:= ri.PriorResidentMoveIndex;
		self.attributes.version1.AddressDateFirstSeen								:= ri.AddressDateFirstSeen;
		self.attributes.version1.AddressDateLastSeen								:= ri.AddressDateLastSeen;
		self.attributes.version1.OccupancyOverride									:= ri.OccupancyOverride;
		self.attributes.version1.InferredOwnershipTypeIndex					:= if(IncludeModel, ri.InferredOwnershipTypeIndex, '');
		self.attributes.version1.OtherOwnedPropertyProximity				:= ri.OtherOwnedPropertyProximity;
		self.attributes.version1.VerificationOfOccupancyScore				:= if(IncludeModel, ri.VerificationOfOccupancyScore, '');
	END;
	
	VerificationOfOccupancy_rec := JOIN(inData, Seed_Files.Key_VerificationOfOccupancy, 
		KEYED(RIGHT.dataset_name = Test_Data_Table_Name)
		and KEYED(RIGHT.hashvalue = Seed_Files.Hash_InstantID((STRING20)LEFT.fname, (STRING20)LEFT.lname,
			(STRING9)LEFT.ssn, '', (STRING5)LEFT.in_zipCode, (STRING10)LEFT.phone10, '')),
		create_output(LEFT,RIGHT), LEFT OUTER, ATMOST(100),KEEP(1));
		
		report_in := project(inData, transform(Seed_Files.VerificationOfOccupancy_report_layouts.in_key,
																							self.Seq   :=  left.seq ;
																							self.fname :=  trim(left.fname);
																							self.lname :=  trim(left.lname);
																							self.zip   :=  trim(left.in_zipCode);
																							self.in_ssn:=  trim(left.ssn);
																							self.hphone:=  trim(left.phone10);
																							self := [];
																							));
		
	report_results := if(IncludeReport, VerificationOfOccupancy.Report_TestSeed_Function (report_in, Test_Data_Table_Name), dataset([], Seed_Files.VerificationOfOccupancy_report_layouts.VOOReportOutLayout));

	FinalSeed := Join(VerificationOfOccupancy_rec, report_results, left.seq=right.seq, transform(VerificationOfOccupancy.Layouts.Layout_VOOBatchOutReport, self.Report:=right.Report, self:=left), LEFT OUTER, KEEP(1), ATMOST(100));
		
		
	RETURN FinalSeed;
END;