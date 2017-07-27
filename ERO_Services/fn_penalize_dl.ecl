import DriversV2,ERO_Services, ut;
EXPORT fn_penalize_dl(ERO_Services.Layouts.layout_extra_penalty input_rec, integer penalty2use = ERO_Services.Constants.Defaults.DLPENALTY) := FUNCTION
  	//look up all DL for DID in match_rec and compare with DL in input rec, state doesn't have to match if blank.
		//if none match return penalty increase amount
		dlFound := exists(DriversV2.Key_DL_DID(keyed(did = input_rec.did) and 
		                                      ut.NBEQ(dl_number,input_rec.dl_number) and
																					ut.NNEQ(orig_state,input_rec.dl_state)));
    penalty := if (dlFound, 0, penalty2use);													   
		return penalty;																			
end;													