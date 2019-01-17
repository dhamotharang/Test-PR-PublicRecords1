import data_services,doxie, dx_Header;

export data_key_DMV_restricted(string filedate='') := function

ds:=header.fn_DMV_restricted(filedate);

RETURN PROJECT (ds, dx_Header.layouts.i_DMV_restricted);
//DMV_restricted :=	index(ds,{ds.rid},{ds}-s_did
//			,data_services.Data_location.person_header +'thor_data400::key::header::DMV_restricted_'+Doxie.Version_SuperKey);
//return DMV_restricted;

end;