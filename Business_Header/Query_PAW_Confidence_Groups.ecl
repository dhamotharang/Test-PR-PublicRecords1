//
//7-49 is low
//50-99 is medium
//100+ is high


emp := Business_Header.File_Employment_Out;

low_confidence	:= emp((integer)score > 6 and (integer)score < 50);
med_confidence	:= emp((integer)score > 49 and (integer)score < 100);
high_confidence	:= emp((integer)score > 99);

low_confidence_count := count(low_confidence);
med_confidence_count := count(med_confidence);
high_confidence_count := count(high_confidence);

low_confidence_sample := enth(low_confidence, 1000);
med_confidence_sample := enth(med_confidence, 1000);
high_confidence_sample := enth(high_confidence, 1000);


out_total_low	:= output(low_confidence_count, named('TotalPawLowConfidenceRecords'));
out_total_med	:= output(med_confidence_count, named('TotalPawMediumConfidenceRecords'));
out_total_high	:= output(high_confidence_count, named('TotalPawHighConfidenceRecords'));

out_sample_low	:= output(low_confidence_sample, named('SamplePawLowConfidenceRecords'), all);
out_sample_med	:= output(med_confidence_sample, named('SamplePawMediumConfidenceRecords'), all);
out_sample_high	:= output(high_confidence_sample, named('SamplePawHighConfidenceRecords'), all);

export Query_PAW_Confidence_Groups := 
parallel(
	 out_total_low	
	,out_total_med	
	,out_total_high	
	,out_sample_low	
	,out_sample_med	
	,out_sample_high	
);
