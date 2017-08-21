IMPORT Health_Provider_Test;
EXPORT Clean_Suffix_Name (DATASET (HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header) Infile) := FUNCTION

  snameSet := ['SR', 'JR', '1', '2', '3', '4', '5', '6', '7', '8'];
	optionalSnameSet := ['JR JR', 'I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII'];
	
	HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header cleanSuffixName (HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header L) := TRANSFORM
		sname := TRIM(L.SNAME);
		SELF.SNAME			 := map(sname not in snameSet and sname not in optionalSnameSet => '', 
														sname = 'JR JR' => 'JR',
														sname = 'I' => 		'1',
														sname = 'II' => 	'2',
														sname = 'III' => 	'3',
														sname = 'IV' => 	'4',
														sname = 'V' => 	  '5',
														sname = 'VI' => 	'6',
														sname = 'VII' => 	'7',
														sname = 'VIII' => '8',
														sname);
		self := l;
		self := [];
	end;
	
	Norm_Suffix_DS := PROJECT (Infile, cleanSuffixName(LEFT));
	
	RETURN Norm_Suffix_DS;
end;
