import NationalAccident_Services;

export BatchService_Records(dataset(NationalAccident_Services.Layouts.inBatchNationalAccident) data_in,
	unsigned2 MaxResultsPerAcct, boolean EnableExtraAccidents) := function
	recs := PROJECT(data_in, NationalAccident_Services.Transforms.BatchProcessing(LEFT,MaxResultsPerAcct,EnableExtraAccidents));
	recs_out := normalize(recs,left.accidents,NationalAccident_Services.Transforms.xformFlatten(left,counter));
	RETURN recs_out;
end;
