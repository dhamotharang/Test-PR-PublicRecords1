Import Data_Services, LN_PropertyV2,doxie, census_data, ut,fcra;

export key_county_fid(boolean IsFCRA = false) := function

KeyName 			:= 'thor_data400::key::ln_propertyv2::';
KeyName_fcra  := 'thor_data400::key::ln_propertyv2::fcra::';

d := LN_PropertyV2.file_search_building((unsigned)did > 0);

fat_rec := record
 d;
 string18 county_name := '';
 source_code_2 := d.source_code[2];
end;

with_field := table(d, fat_rec);

census_data.MAC_Fips2County
	(with_field,st,county[3..5],county_name,with_all_dups)
	
// make two fields
krec := record
	with_all_dups.ln_fares_id;
	string18 o_county_name;
	string18 p_county_name;
end;

krec splitc(with_all_dups l) := transform
	self.ln_fares_id := l.ln_fares_id;
	self.o_county_name := if(l.source_code[2] = 'O', l.county_name, '');
	self.p_county_name := if(l.source_code[2] = 'P', l.county_name, '');
end;

wad_dist  := distribute(with_all_dups(county_name <> ''), hash(ln_fares_id));
needsroll := sort(project(wad_dist, splitc(left)), ln_fares_id, local);
	
krec rollem(krec l, krec r) := transform
	self.o_county_name := if(l.o_county_name = '', r.o_county_name, l.o_county_name);
	self.p_county_name := if(l.p_county_name = '', r.p_county_name, l.p_county_name);
	self := l;
end;

with_all     := rollup(needsroll, left.ln_fares_id = right.ln_fares_id, rollem(left, right), local);

// filtering by [ln_fares_id[1] != 'R'] produces FCRA compliant data
base_file := if(IsFCRA,with_all(ln_fares_id[1] !='R'),with_all);

key_name := Data_services.Data_location.Prefix('Property') + if(isFCRA, KeyName_fcra, KeyName) + doxie.Version_SuperKey + '::search.fid_county';
									
return_file		:= INDEX(base_file,{ln_fares_id},{p_county_name, o_county_name},key_name);
													
return(return_file);		

END;				   



