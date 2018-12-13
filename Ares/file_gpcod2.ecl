Import Ares;

rcodes := file_routingcodes_flat;

w_location_layout := record(recordof(rcodes))
	string location_id;
End;

w_location_layout xform_w_location(rcodes l, file_office_flat r) := transform
	self.location_id := r.tfpuid;
	self := l;
end;
w_location := join(rcodes , file_office_flat, left.primaryOfficeID = right.id, xform_w_location(left, right));

w_department_layout := record(recordof(w_location))
	string department_type;
end;

w_department_layout xform_w_dep(w_location l, files.ds_department r) := transform
	self.department_type := if(count(r.summary.types) > 0, r.summary.types[1].type, '');
	self := l;
end;

w_department := join(w_location, files.ds_department, left.department = right.id, xform_w_dep(left, right), left outer, keep(1));

w_dep_type_layout := record(recordof(w_department))
	string dep_type;
end;

dep_func_lookups := Ares.Files.ds_lookup(fid ='DEPARTMENT_TYPE').lookupBody;

w_dep_type_layout xform_add_dep_type(w_department l, dep_func_lookups r) := transform
	self.dep_type := r.tfpid;
	self := l;
end;

w_dep_type := join(w_department, dep_func_lookups, left.department_type = right.id, xform_add_dep_type(left, right),left outer, keep(1));

w_prim_city_layout := record(recordof(w_dep_type))
	string prim_city;
end;

w_prim_city_layout xform_w_prim_city(w_dep_type l, ares.file_office_flat r) := transform
	self.prim_city := r.primary_physical_city_id;
	self := l;
end;

w_prim_city := join(w_dep_type, ares.file_office_flat, left.primaryOfficeID = right.id, xform_w_prim_city(left, right), keep(1), left outer);

w_fed_dstcode_layout := record(recordof(w_prim_city))
	string fed_dstcode;
end;

w_fed_dstcode_layout xform_fed_dstcode(w_prim_city l, Ares.files.ds_city r) := transform
	fed_dstcode1 := r.alternativeRegions.alternativeRegions(type='Federal Reserve District')[1].value;
	self.fed_dstcode := fed_dstcode1 + r.alternativeRegions.alternativeRegions(type='Federal Reserve Sub District')[1].value;
	self := l;
end;

w_fed_dstcode := join(w_prim_city, Ares.files.ds_city, left.prim_city = right.id, xform_fed_dstcode(left,right), keep(1), left outer);

rc_lookups := Ares.Files.ds_lookup(lookupname ='Routing Code Type').lookupBody;

w_rc_lookups_layout := record(recordof(w_fed_dstcode))
	string rc_mask := '';
end;
w_rc_lookups_layout xform_rc_lookup(w_fed_dstcode l, rc_lookups r) := transform
	self.rc_mask := regexreplace('[%@]', r.tfpformat, '#') ;
	self := l;
end;

w_rc_lookups := join(w_fed_dstcode, rc_lookups, left.codeType = right.id, xform_rc_lookup(left,right), keep(1), left outer);
/////////////////////////////////////////////////////////////////////
layout_gpcod2 xform_final(w_rc_lookups l, integer c) := Transform
	self.Primary_Key := intformat(c, 8, 1);
	self.Rank := l.rank;
	self.Routing_Type := l.codeType;
	self.Accuity_Location_ID := l.location_id;
	self.Department_Function :=  if(l.codeType = 'ABA',  l.dep_type, 'MAIN');
	self.Routing_Code_Alternate_Presentation := l.routing_raw;
	self.Routing_Code := MAP(self.Routing_Type = 'SWIFT' => Ares.str_functions.pad(l.routing_raw,'<','X',11),
													 self.Routing_Type = 'BIC' => Ares.str_functions.pad(l.routing_raw,'<','X',11),
													 l.routingnumber_alt != '' => 	l.routingnumber_alt, 
													 l.rc_mask != '' => Ares.str_functions.mask(l.routing_raw, l.rc_mask),
													 l.routing_raw );
	self := l;
End;

final := Project(w_rc_lookups, xform_final(left, counter));

EXPORT file_gpcod2 := final : persist('persist::ares::routingcodes');