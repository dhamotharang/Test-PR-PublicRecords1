import lib_fileservices;
export clear_super := function

sup_all := parallel(Fileservices.ClearSuperfile('~thor_data400::sprayed::flcrash0'),
Fileservices.ClearSuperfile('~thor_data400::sprayed::flcrash1'),
Fileservices.ClearSuperfile('~thor_data400::sprayed::flcrash2v'),
Fileservices.ClearSuperfile('~thor_data400::sprayed::flcrash3v'),
Fileservices.ClearSuperfile('~thor_data400::sprayed::flcrash4'),
Fileservices.ClearSuperfile('~thor_data400::sprayed::flcrash5'),
Fileservices.ClearSuperfile('~thor_data400::sprayed::flcrash6'),
Fileservices.ClearSuperfile('~thor_data400::sprayed::flcrash7'),
Fileservices.ClearSuperfile('~thor_data400::sprayed::flcrash8'));

return sup_all;
end;