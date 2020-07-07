import AutoStandardI, doxie, Doxie_Raw;

doxie.MAC_Header_Field_Declare() // only to take dateVal

export corp_affiliations_records(dataset(doxie.layout_references) in_dids) := function

global_mod := AutoStandardI.GlobalModule();
mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (global_mod);

j1 := Doxie_Raw.CorpAffil_Raw(in_dids, dateVal);

j1 rollem(j1 l, j1 r) := transform
	self := l;
end;

allelse(recordof(j1) l) := 
	(string)l.did+l.bdid+l.state_origin+l.charter_number+l.corporation_name+l.corporation_status+l.filing_date+
	l.contact_name+l.affiliation+l.title+l.fname+l.mname+l.lname+l.name_suffix;
	
wholeaddr(recordof(j1) l) := 
	l.address_type+l.predir+l.prim_name+l.suffix+l.postdir+l.unit_desig+l.sec_range+l.city_name+l.st+l.zip+l.zip4;

s := sort(j1, allelse(j1), -wholeaddr(j1));
r := rollup(s, allelse(left) = allelse(right) and trim(wholeaddr(right)) = '', rollem(left, right));


//***** PICK UP SOME GONG PHONES BY ADDRESS
forphone := project(r, transform(doxie.layout_AppendGongByAddr_input,
																 self := left,
																 self := []));

gphones := Doxie.fn_AppendGongByAddr(forphone,mod_access);


//***** DEDUP THE PHONES
max_phonesPerAddr := 10;
gphonesb := 
	dedup(
		sort(
			gphones(business_flag),
			prim_range,
			prim_name,
			zip,
			sec_range,
			record
		),
		prim_range,
		prim_name,
		zip,
		sec_range,
		keep(max_phonesPerAddr)
	);


//***** PATCH THE PHONES IN
r addphones(r l) := transform
	self.phones := choosen(dedup(project(gphonesb(
																							 l.prim_range = prim_range and
																							 l.prim_name = prim_name and
																							 l.zip = zip and
																							 l.sec_range = sec_range /*and
																							 ut.CompanySimilar100(l.corporation_name, listing_name) <= 50)*/), //company match seems to lose all the records
																			 {doxie.layout_AppendGongByAddr_input.phone,doxie.layout_AppendGongByAddr_input.timezone}), 
															 all),
												 max_phonesPerAddr);
	self := l;
end;

wphones := project(r, addphones(left));

return wphones;

end;