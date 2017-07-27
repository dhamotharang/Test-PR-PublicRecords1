import doxie_crs, doxie, business_header, dnb;


export ID_Number_records_base(dataset(doxie_cbrs.layout_references) bdids) :=
MODULE

doxie_cbrs.mac_Selection_Declare()	
shared raw_stateIDs := sort(dedup(doxie_cbrs.Corp_IDs_raw(bdids)(Include_CompanyIDnumbers_val),corp_orig_sos_charter_nbr,corp_state_origin,ALL),corp_state_origin);
doxie_cbrs.mac_Selection_Declare()	
shared raw_stateIDs_v2 := sort(dedup(doxie_cbrs.Corp_IDs_raw_v2(bdids)(Include_CompanyIDnumbersv2_val),corp_orig_sos_charter_nbr,corp_state_origin,ALL),corp_state_origin);
doxie_cbrs.mac_Selection_Declare()	
shared raw_FEINS := sort(dedup(doxie_cbrs.fn_getBaseRecs(bdids,false)(fein <> '' and Include_CompanyIDnumbers_val),fein,ALL),fein);
doxie_cbrs.mac_Selection_Declare()	
// shared raw_duns := sort(dedup(doxie_cbrs.DNB_records(Include_CompanyIDnumbers_val),duns_number,ALL),duns_number);
shared raw_duns := dataset([],DNB.Layout_DNB_Base);

doxie_cbrs.mac_Selection_Declare()	
stateIDs := choosen(raw_stateIDs,Max_CompanyIDnumbers_val);
stateIDs_v2 := choosen(raw_stateIDs_v2,Max_CompanyIDnumbers_val);
FEINS := choosen(raw_FEINS,Max_CompanyIDnumbers_val);
duns := choosen(raw_duns,Max_CompanyIDnumbers_val);

FEIN_rec := RECORD
	FEINS.fein;
	FEINS.fein_source_id;
END;

FEIN_rec fein_slim(FEINS l) := TRANSFORM
	SELF := l;
END;

FEIN_recs := project(FEINS,fein_slim(left));

DUNS_rec := RECORD
	duns.duns_number;
END;

DUNS_rec duns_slim(duns l) := TRANSFORM
	SELF := l;
END;

DUNS_recs := project(duns,duns_slim(left));

STATE_rec := RECORD
	stateIDs.corp_orig_sos_charter_nbr;
	stateIDs.corp_state_origin;
END;

STATE_rec state_slim(stateIDs l) := TRANSFORM
	SELF := l;
END;

STATE_recs := project(stateIDs,state_slim(left));

STATE_rec_v2 := RECORD
	stateIDs_v2.corp_orig_sos_charter_nbr;
	stateIDs_v2.corp_state_origin;
END;

STATE_rec_v2 state_slim_v2(stateIDs_v2 l) := TRANSFORM
	SELF := l;
END;

STATE_recs_v2 := project(stateIDs_v2,state_slim_v2(left));

recDunsNumbers := recordof(DUNS_recs);
recStateIDs := recordof(STATE_recs);
recStateIDs_v2 := recordof(STATE_recs_v2);
recFEINs := recordof(FEIN_recs); 

idrecs := record, maxlength(doxie_crs.maxlength_report)
	dataset(recDunsNumbers) duns_numbers;
	dataset(recFEINs) feins;
	dataset(recStateIDs) state_ids;
	dataset(recStateIDs_v2) state_ids_v2;
end;

//***** PROJECT THEM IN
nada := dataset([0], {unsigned1 a});

idrecs getall(nada l) := transform
	self.duns_numbers := global(DUNS_recs);	
	self.feins := global(FEIN_recs);
	self.state_ids := global(STATE_recs);
	self.state_ids_v2 := global(STATE_recs_v2);
end;

export records := project(nada, getall(left));
export records_count := count(raw_stateIDs) + count(raw_stateIDs_v2) + count(raw_FEINS) + count(raw_duns);
END;