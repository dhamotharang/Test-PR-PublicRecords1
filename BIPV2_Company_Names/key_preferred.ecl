import BIPV2_Company_Names,Data_Services, doxie;

infile := BIPV2_Company_Names.file_preferred;

layout_lookup := record
	string clean_name;
	string preferred_name;
end;

p := project(infile, layout_lookup);

EXPORT key_preferred := index(p, {string160 cname := clean_name}, {p},  
Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::BIPV2::' + doxie.Version_SuperKey + '::biz_preferred');