import data_services,doxie;

export Key_DMV_restricted(string filedate='', boolean isFCRA=false) := function

ds:=header.fn_DMV_restricted(filedate);

DMV_restricted :=
		index(ds,{ds.rid},{ds}-s_did
			,data_services.Data_location.person_header +'thor_data400::key::header::DMV_restricted_'+Doxie.Version_SuperKey);

return DMV_restricted;

end;