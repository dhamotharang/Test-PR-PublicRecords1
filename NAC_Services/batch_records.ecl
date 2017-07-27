IMPORT NAC_Services;
EXPORT batch_records(dataset(NAC_Services.Layouts.nac_batch_in) ds_batch_in,
										 NAC_Services.IParam.options in_batch_param) := FUNCTION
	
	//1. Project to standard layout	
	ds_batch_in_standard 		:= NAC_Services.Functions.getStandardInputLayoutForBatch(ds_batch_in, in_batch_param);		
	
	//2. Get records
	ds_batch_res						:= NAC_Services.Records(ds_batch_in_standard, in_batch_param);

	//3. Project to final output
	NAC_Services.Layouts.nac_batch_out xformFinal(NAC_Services.Layouts.nac_raw_rec L) := transform
		self.acctno 												:= L.acctno;
		self.contact_name										:= L.state_contact_name;
		self.contact_phone									:= L.state_contact_phone;
		self.contact_phone_extension				:= L.state_contact_phone_extension;
		self.contact_email									:= L.state_contact_email;
		self																:= L;
	end;
	ds_batch_final 					:= project(ds_batch_res, xformFinal(left));
	
	RETURN ds_batch_final;
END;

