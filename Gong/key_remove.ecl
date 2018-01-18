import gong, address, doxie, data_services;

dels_rec := record
	gong.Layout_gong_deletion,
	unsigned8 __fpos { virtual (fileposition)},
end;

dels_plus := dataset('~thor_data400::base::gong_daily_deletions_building',
                     dels_rec,flat,OPT);

layout_remove := record
	string10 phone10,	
	unsigned8 __fpos,
end;

layout_remove get_phone10(dels_plus l) := transform
	self.phone10 := l.area_code + l.phone7;
	self := l;	
end;

file_remove := project(dels_plus(phone7[4..7]<>'XXXX'), get_phone10(left));

export key_remove := index(file_remove(phone10!=''),
                           {l_phone10 := phone10, __fpos}, 
				       data_services.data_location.prefix() + 'thor_data400::key::gong_remove_'+ doxie.Version_SuperKey,OPT);