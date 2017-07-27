//this program project the records from flcrash2v,4,5,6,7 to standard format,
//add accident date from flcrash0, and write them into a file
import flaccidents, ut;

base_file0 := flaccidents.BaseFile_FLCrash0;
base_file2 := flaccidents.BaseFile_FLCrash2v;
base_file4 := flaccidents.BaseFile_FLCrash4;
base_file5 := flaccidents.BaseFile_FLCrash5;
base_file6 := flaccidents.BaseFile_FLCrash6;
base_file7 := flaccidents.BaseFile_FLCrash7;

flaccidents.layout_flcrash_search convert_file2(base_file2 l) := transform
     self.accident_date := '',
	self.name_suffix := l.suffix,
	self.record_type := 'Vehicle Owner',
	self.vin := stringlib.stringcleanspaces25(l.vehicle_id_nbr),
	self.driver_license_nbr := stringlib.stringcleanspaces25(l.vehicle_owner_dl_nbr),
	self.tag_nbr := stringlib.stringcleanspaces25(l.vehicle_tag_nbr),
	self := l,
end; 

search_file2 := project(base_file2, convert_file2(left));

flaccidents.layout_flcrash_search convert_file4(base_file4 l) := transform
     self.accident_date := '',
	self.name_suffix := l.suffix,
	self.record_type := 'Vehicle Driver',
	self.vin := '',
	self.driver_license_nbr := stringlib.stringcleanspaces25(l.driver_dl_nbr),
	self.tag_nbr := '',
	self := l,
end; 

search_file4 := project(base_file4, convert_file4(left));

flaccidents.layout_flcrash_search convert_file5(base_file5 l) := transform
     self.accident_date := '',
	self.name_suffix := l.suffix,
	self.record_type := 'Passenger',
	self.vin := '',
	self.driver_license_nbr := '',
	self.tag_nbr := '',
	self := l,
end; 

search_file5 := project(base_file5, convert_file5(left));

flaccidents.layout_flcrash_search convert_file6(base_file6 l) := transform
     self.accident_date := '',
	self.name_suffix := l.suffix,
	self.record_type := 'Pedestrian',
	self.vin := '',
	self.driver_license_nbr := '',
	self.tag_nbr := '',
	self := l,
end; 

search_file6 := project(base_file6, convert_file6(left));

flaccidents.layout_flcrash_search convert_file7(base_file7 l) := transform
     self.accident_date := '',
	self.name_suffix := l.suffix,
	self.record_type := 'Property Owner',
	self.vin := '',
	self.driver_license_nbr := '',
	self.tag_nbr := '',
	self := l,
end; 

search_file7 := project(base_file7, convert_file7(left));

flc_search_file := search_file2 + 
                   search_file4 +
			    search_file5 +
			    search_file6 +
			    search_file7;

dst_base_file0 := distribute(base_file0, hash(accident_nbr, accident_date));
srt_base_file0 := sort(dst_base_file0, accident_nbr, -(unsigned4)accident_date,local);	
dep_base_file0 := dedup(srt_base_file0, accident_nbr,local);							
								
flaccidents.layout_flcrash_search get_acc_date(flc_search_file l, dep_base_file0 r) := transform
	self.accident_date := r.accident_date;
	self := l;
end;				 
				 
flc_search_out := join(flc_search_file, dep_base_file0, 
                       left.accident_nbr = right.accident_nbr,
				   get_acc_date(left,right), left outer, hash);

ut.MAC_SF_BuildProcess(flc_search_out, 'base::flcrash_did', build_flcrash_did, 2);
				  
export bwr_flcrash_builddidfile := build_flcrash_did;