import BIPV2,LN_PropertyV2,Data_Services;
PreProcess_Search_Layout_mod := 
 LN_PropertyV2.Layouts.PreProcess_Search_Layout - BIPV2.IDlayouts.l_xlink_ids - source_rec_id;
ds := dataset(Data_Services.foreign_prod+'thor_data400::in::ln_propertyv2::irs.search', 
	PreProcess_Search_Layout_mod,
	flat);

	LN_PropertyV2.Layout_DID_Out searchCmTran(PreProcess_Search_Layout_mod l) := transform
		self.ln_party_status := '';
		self.ln_percentage_ownership := '';
		self.ln_entity_type := '';
		self.ln_estate_trust_date := '';
		self.ln_goverment_type := '';
		self.nid := 0;
		self.xadl2_weight := 0;
		self := l;
	end;
	
export irs_dummy_recs_search := project(ds, searchCmTran(left));
