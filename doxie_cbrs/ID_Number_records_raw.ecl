import doxie_crs, business_header;
doxie_cbrs.mac_Selection_Declare()
	
//inputs
stateIDs := doxie_cbrs.Corp_records_raw(Include_CompanyIDnumbers_val);
FEINS := doxie_cbrs.getBaseRecs(fein <> '' and Include_CompanyIDnumbers_val);
duns := doxie_cbrs.DNB_records(Include_CompanyIDnumbers_val);

recDunsNumbers := recordof(duns);
recStateIDs := recordof(stateIDs);
recFEINs := recordof(FEINs); 

idrecs := record, maxlength(doxie_crs.maxlength_report)
	dataset(recDunsNumbers) duns_numbers;
	dataset(recFEINs) feins;
	dataset(recStateIDs) state_ids;
end;

//***** PROJECT THEM IN
nada := dataset([0], {unsigned1 a});

idrecs getall(nada l) := transform
	self.duns_numbers := global(duns);	
	self.feins := global(FEINs);
	self.state_ids := global(stateIDs);
end;

export ID_Number_records_raw := project(nada, getall(left));

