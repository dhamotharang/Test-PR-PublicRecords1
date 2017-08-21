import _control,address_attributes,ut;
EXPORT file_address_businesses := function
	busad := dedup(index(			{ unsigned6 bdid},
																			Layouts.bdid_pl_layout,
																			Constants.Key_BDID_PL)(bdid<>0),
																bdid,prim_range,prim_name,sec_range,zip,all);
											
	b1 := project(dedup(busad,  prim_range,prim_name,sec_range,zip,all),
															transform(Layouts.layout_parent_address,
																									self.zip := intformat(left.zip,5,0),
																									self := left
															)
							)(prim_range<>'',prim_name<>'', zip<>'');
	
	
	Layouts.layout_parent_address DeNormThem1(b1 L, DATASET(Layouts.layout_child_bdid_address) R) := TRANSFORM
			SELF.BDID_cnt := COUNT(R);
			SELF.Businesses_bdid := dedup(project(R, Layouts.slim_child_bdid_address),all, bdid, company_name);
			SELF := L;
	END;
	DeNormedRecs1 := DENORMALIZE(b1, 
																														project( busad, 
																																							transform(Layouts.layout_child_bdid_address,
																																												self.zip := intformat(left.zip,5,0),
																																												self.zip4 := intformat(left.zip4,4,0),
																																												self := left
																																							)	
																														),
																														left.prim_range = right.prim_range and left.prim_name = right.prim_name and
																																left.sec_range = right.sec_range and left.zip = right.zip,
																													 GROUP,
																													 DeNormThem1(LEFT,ROWS(RIGHT)));

	buslinks := dedup(
																			index({unsigned6 ultid, unsigned6 orgid, unsigned6 seleid, unsigned6 proxid, unsigned6 powid, unsigned6 empid, unsigned6 dotid},
																				Layouts.bipv2_header_layout,
																				Constants.Key_Linkids),
																			ultid, orgid, seleid, prim_range,prim_name,sec_range,zip,all);
	
	b2 := project(dedup(buslinks,  prim_range,prim_name,sec_range,zip,all),Layouts.layout_parent_address)(prim_range<>'',prim_name<>'', zip<>'');
	
	Layouts.layout_parent_address DeNormThem2(b2 L, DATASET(Layouts.layout_child_seleid_address) R) := TRANSFORM
			SELF.seleid_cnt := COUNT(R);
			SELF.Businesses_seleid := dedup(project(R, Layouts.slim_child_seleid_address), all, seleid, company_name);
			SELF := L;
	END;
	
	DeNormedRecs2 := DENORMALIZE(b2, 
																														project(	buslinks, 
																																							transform(Layouts.layout_child_seleid_address,
																																												self.city := left.p_city_name,
																																												self.bdid := left.company_bdid,
																																												self.state := left.st,
																																												self.phone := (integer)left.company_phone,
																																												self.fein := (integer)left.company_fein,
																																												self := left
																																							)
																														),
																														left.prim_range = right.prim_range and left.prim_name = right.prim_name and
																														left.sec_range = right.sec_range and left.zip = right.zip,
																													 GROUP,
																													 DeNormThem2(LEFT,ROWS(RIGHT)));
	
		f_preroll := 	project(DeNormedRecs1, transform(Layouts.layout_parent_address, self := left, self := [])) +
									project(DeNormedRecs2, transform(Layouts.layout_parent_address, self := left, self := []));
		Layouts.layout_parent_address joinxform(f_preroll L, f_preroll R) := TRANSFORM
			SELF.Businesses_bdid := 	dedup(sort(L.Businesses_bdid + R.Businesses_bdid, bdid, ut.CleanSpacesAndUpper(company_name)),ALL, bdid, ut.CleanSpacesAndUpper(company_name));
			SELF.Businesses_seleid := dedup(sort(R.Businesses_seleid + L.Businesses_seleid, seleid, ut.CleanSpacesAndUpper(company_name)),ALL, seleid, ut.CleanSpacesAndUpper(company_name));
			SELF.BDID_cnt := COUNT(	dedup(sort(L.Businesses_bdid + R.Businesses_bdid, bdid, ut.CleanSpacesAndUpper(company_name)),ALL, bdid));
			SELF.seleid_cnt := COUNT(dedup(sort(R.Businesses_seleid + L.Businesses_seleid, seleid, ut.CleanSpacesAndUpper(company_name)),ALL, seleid));
			SELF.prim_range := if (l.prim_range = '', r.prim_range, l.prim_range);
			SELF.prim_name  := if (l.prim_name  = '', r.prim_name , l.prim_name);
			SELF.sec_range  := if (l.sec_range  = '', r.sec_range , l.sec_range);
			SELF.zip				:= if (l.zip				= '', r.zip				, l.zip);
			SELF := L;
			SELF := R;
	END;								 
		final := rollup(sort(f_preroll,prim_range, prim_name, sec_range, zip), 
										joinxform(left, right),
										prim_range, prim_name, sec_range, zip);
						
	return final;
end;
