/***
Filter client records from base1 if there is a corresponding record in base2
***/
// key = clientid, state, program code
EXPORT fn_filterBase1(Dataset($.Layouts.Base) b1, DATASET($.Layout_Base2) b2) := FUNCTION

	j := JOIN(DISTRIBUTE(b1, hash32(client_identifier)),
						DISTRIBUTE(b2, hash32(ClientId)),
						left.client_identifier = right.ClientId and
						left.Case_State_Abbreviation = right.ProgramState and left.Case_Benefit_Type = right.ProgramCode
						and (integer)(left.Case_Benefit_Month+'02') BETWEEN right.startdate and right.enddate,
						TRANSFORM($.Layouts.Base, self := left),
						LEFT ONLY, LOCAL);

	return j;
END;