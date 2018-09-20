import ut, doxie;

export Comp_Subject_Addresses(dataset(Doxie.layout_references) dids,
															boolean include_gong = true,
															unsigned1 dial_contactprecision_value = 4,
                              unsigned2 address_limit = 1000,
                              doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) :=
MODULE

//include_dailies := ~ut.IndustryClass.is_knowx;
include_dailies := ~mod_access.isConsumer ();

head_all := doxie.mod_header_records(
	false, //DoSearch
	include_dailies, 					
	false, //allow_wildcard
	include_gong,
  ,,,,,mod_access
  ).results(project(dids, doxie.layout_references_hh));

head_for_append := head_all(doxie.needAppends(src, listed_name));
head_skip 			:= head_all(~doxie.needAppends(src, listed_name));
head_gd1 := doxie.Append_Gong(head_for_append, DATASET([], doxie.layout_relative_dids_v3), dial_contactprecision_value);
head_gd := 
	project(head_gd1, doxie.layout_presentation) +
	project(head_skip, doxie.layout_presentation);

shared Mainfat := IF(include_gong, head_gd, head_all);
export raw := Mainfat;
Main := project(Mainfat,transform(Layout_Comp_Addresses, self := left, self.hri_address := []));
MAC_Address_Rollup(Main,address_limit,Main_Dn, mod_access.isConsumer())

Layout_Comp_Addresses tra(Main_Dn lef,Main_Dn ref) := transform
  self.address_seq_no := if(lef.address_seq_no <=0,1,lef.address_seq_no +1);  	
	self := ref;		
  end;

// transform to switch the dates in case the search is knowx.	
Layout_Comp_Addresses traConsumer(Main_Dn lef,Main_Dn ref) := transform
  self.address_seq_no := if(lef.address_seq_no <=0,1,lef.address_seq_no +1);  
	self.dt_last_seen := ref.dt_vendor_last_reported;
	self.dt_first_seen := ref.dt_vendor_first_reported;
	self.dt_vendor_first_reported := ref.dt_first_seen;
	self.dt_vendor_last_reported := ref.dt_last_seen;
	self := ref;		
  end;
	
//****** Push infile through transform above
Main_Dn_U := iterate(Main_Dn, tra(left, right));
Main_Dn_C := iterate(Main_Dn, traConsumer(left, right));
Mainseq := if(mod_access.isConsumer (), Main_Dn_C, Main_Dn_U);
export Addresses := Mainseq;

shared doxie.layout_NameDID name_tra(doxie.layout_NameDID l,doxie.layout_NameDID r) := transform
	self.name_occurences := 
		if(l.did = r.did and l.name_suffix = r.name_suffix and l.fname = r.fname and l.lname = r.lname,
			1+l.name_occurences, 1);
	self := r;
end;

export Names := 
	dedup(
		sort(
			iterate(sort(project(Mainfat, doxie.layout_NameDID), name_suffix, did, fname, lname), name_tra(left, right)),
		name_suffix, did, fname, lname,-name_occurences),
			name_suffix, did, fname, lname);

END;