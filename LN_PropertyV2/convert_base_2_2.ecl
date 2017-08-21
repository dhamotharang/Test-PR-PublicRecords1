export convert_base_2_2(dataset(recordof(LN_PropertyV2.layout_property_common_model_base_plus)) Assess,
												dataset(recordof(LN_PropertyV2.layout_addl_fares_tax_plus)) fares_tax,
												dataset(recordof(LN_PropertyV2.layout_addl_fares_deed_plus)) fares_deed) :=
module

	string20 fn_condo_bldg_name(string20 condo_project_or_building_name, string1 ind) := function
		unsigned2 position := stringlib.stringfind(condo_project_or_building_name,';',1);
		string20 condo_name := if(regexfind('^[;]',trim(condo_project_or_building_name,left,right)),
								  '',
								  trim(condo_project_or_building_name[1..position-1],left,right));
		string20 bldg_name 	:= if(regexfind('[;]$',trim(condo_project_or_building_name,left,right)),
								  '',
								  trim(condo_project_or_building_name[position+1..],left,right));
		string20 return_val := if(ind = 'B',bldg_name,condo_name);
		
		return return_val;
	end;

	ln_propertyv2.layout_property_common_model_base reformat(assess l) := transform
		self.amenities1_code 	:= l.amenities1_code1;
		self.amenities2_code 	:= l.amenities1_code2;
		self.amenities3_code 	:= l.amenities1_code3;
		self.amenities4_code 	:= l.amenities1_code4;
		self.amenities5_code 	:= l.amenities1_code5;
		self.condo_project_name := fn_condo_bldg_name(l.condo_project_or_building_name,'C');
		self.building_name		:= fn_condo_bldg_name(l.condo_project_or_building_name,'B');
		self					:= l;
	end;

	assess_2_2 := project(assess,reformat(left));
	
	export convert_assessor := assess_2_2;
	
	fares_tax_dist := distribute(fares_tax, hash(ln_fares_id));
	assess_dist := distribute(assess, hash(ln_fares_id));
	
	ln_propertyv2.layout_addl_fares_tax reformat(fares_tax_dist l, assess_dist r) := transform
		self.fares_water 			:= r.water_code;
		self.fares_sewer 			:= r.sewer_code;
		self.fares_condition	:= r.building_condition_code;
		self := l;
	end;
	
	fares_tax_2_2 := join(fares_tax_dist,
												assess_dist,
												left.ln_fares_id = right.ln_fares_id,
												reformat(left,right),
												left outer,
												local
												);
												
	export convert_fares_tax := fares_tax_2_2;
	
	ln_propertyv2.layout_addl_fares_deed reformat(fares_deed l) := transform
		self := l;
	end;
	
	fares_deeds_2_2 := project(fares_deed,reformat(left));
	
	export convert_fares_deed := fares_deeds_2_2;

end;