import ut, nid;

orig := dataset('~thor_data400::in::ln_propertyv2::fares_search', LN_PropertyV2.layout_deed_mortgage_property_search, flat);

	layout_deed_mortgage_property_search_mod fixOrig(orig l):= transform
		self.nid 						:= 0;
		self.ln_entity_type := '';
		self 								:= l;
	end;

	orig_fix 	:= project(orig, fixOrig(left));
	convert 	:= project(
											dataset('~thor_data400::in::ln_propertyv2::fares_search_converted'
															, layout_deed_mortgage_property_search_mod-ln_entity_type, flat)
											,transform(
																	layout_deed_mortgage_property_search_mod,
																	self.ln_entity_type := '';
																	self 								:= LEFT;
																)
											);

export	File_Fares_Search_in	:=	orig_fix + convert;
