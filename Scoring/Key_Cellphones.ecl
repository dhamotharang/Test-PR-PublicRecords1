import phonesplus;

f := Phonesplus.file_phonesplus_base;

temp := record
	string10 		CellPhone := '';
	unsigned2			ConfidenceScore := 0; 
	unsigned3     	DateFirstSeen := 0;
	unsigned3     	DateLastSeen := 0;	
	unsigned6 		did := 0;
  string3 			did_score := '';
	string5        	title := '';
  string20       	fname := '';
  string20       	mname := '';
  string20       	lname := '';
  string5        	name_suffix := '';
  string3        	name_score := '';
	string10       	prim_range := '';
  string2        	predir := '';
  string28       	prim_name := '';
  string4        	addr_suffix := '';
  string2        	postdir := '';
  string10       	unit_desig := '';
  string8        	sec_range := '';
  string25       	p_city_name := '';
  string25       	v_city_name := '';
  string2        	state := '';
  string5        	zip5 := '';
  string4        	zip4 := '';
  string4        	cart := '';
  string1        	cr_sort_sz := '';
  string10       	geo_lat := '';
  string11       	geo_long := '';
  string4        	msa := '';
  string7        	geo_blk := '';	
end;

// t := project(f(confidencescore>11), transform(temp, self := left));
t := project(f, transform(temp, self := left));

export Key_Cellphones := index(t,{cellphone},{t},'~thor_data400::key::cellphones_test');