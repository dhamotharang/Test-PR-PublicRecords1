import ut;
export Files_CP := module

export entity_current := dataset('~thor_data400::in::utility_cp_entity_current', utilfile.Layout_util_cp.entity,   csv(SEPARATOR(x'1e'), quote(''),TERMINATOR('\n'),maxlength(20000)));
export entity_history := dataset('~thor_data400::in::utility_cp_entity_history', utilfile.Layout_util_cp.entity,   csv(SEPARATOR(x'1e'), quote(''),TERMINATOR('\n'),maxlength(20000)));

export addr_history := dataset('~thor_data400::in::utility_cp_SVCADDR_history', utilfile.Layout_util_cp.svcaddr,   csv(SEPARATOR(x'1e'), quote(''), TERMINATOR('\n'),maxlength(20000)));
export addr_current := dataset('~thor_data400::in::utility_cp_SVCADDR_current', utilfile.Layout_util_cp.svcaddr,   csv(SEPARATOR(x'1e'), quote(''), TERMINATOR('\n'),maxlength(20000)));

export name_history := dataset('~thor_data400::in::utility_cp_name_history', utilfile.Layout_util_cp.name,   csv(SEPARATOR(x'1e'), quote(''), TERMINATOR('\n'),maxlength(20000)));
export name_current := dataset('~thor_data400::in::utility_cp_name_current', utilfile.Layout_util_cp.name,   csv(SEPARATOR(x'1e'), quote(''), TERMINATOR('\n'),maxlength(20000)));


end;