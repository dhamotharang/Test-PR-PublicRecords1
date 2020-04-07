import versioncontrol, data_services;

export _Dataset(boolean pUseProd = false) := module
	export thor_cluster_Files			:= 	data_services.data_location.prefix('CFPB')+'thor::';
end;