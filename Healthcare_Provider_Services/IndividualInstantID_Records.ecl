import Identifier2,iesp;
export IndividualInstantID_Records(boolean skipExecution=false) := module
	shared rawData := iesp.transform_identifier2(Identifier2.Identifier2Records);
	output_layout := iesp.instantid.t_InstantIDResult;
	shared formattedData := project(rawData,transform(output_layout, self := left, self := []));
	export dsIndividualID := if(skipExecution,dataset([],iesp.instantid.t_InstantIDResult)[1],formattedData[1]);
end;
