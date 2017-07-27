import Identifier2,iesp;
export IndividualInstantID_Records() := module
	shared rawData := Identifier2.Identifier2Records;
	output_layout := iesp.instantid.t_InstantIDResult;
	shared formattedData := project(rawData,transform(output_layout, self := left, self := []));
	export dsIndividualID := formattedData[1];
end;
