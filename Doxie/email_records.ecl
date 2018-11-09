import EmailService,Suppress;

export email_records(Dataset(doxie.layout_references) dids,
 string6 ssn_mask = '', string32 appType = Suppress.Constants.ApplicationTypes.DEFAULT,
 boolean multipleRoyalties = false, string5 industry_class = '') := FUNCTION

	mac_input() := MACRO
		self.seq := 1;
		self.ssn_mask_value := in_mod.ssnmask;
	ENDMACRO;

	
	EmailService.Assorted_Layouts.did_w_input get_input(doxie.layout_references l) :=transform
		self.seq := 1;
		self.ssn_mask_value := ssn_mask;
		self.did := l.did;
		self :=[];
END;
	
	//*** Creat dataset to pass into EmailSearchService_Records
	
	ids := group(project(dids,get_input(left)),seq,did);
	
	
	res0:= EmailService.EmailSearchService_Records.recs(ids, false, appType, multipleRoyalties, industry_class);
	
	res := project(res0,EmailService.Assorted_Layouts.layout_report_rollup);
	
return res;

END;