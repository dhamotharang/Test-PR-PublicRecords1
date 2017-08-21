import ut;

export File_CT_DPS := module

fPerson := dataset('~thor_data400::in::crim_court::ct_dps_person',Crim.Layout_CT_DPS_Person.csvin,CSV(SEPARATOR([]),TERMINATOR(['\n']), QUOTE([])));
export trPerson := project(fPerson, transform(Crim.Layout_CT_DPS_Person.parsed, SELF := TRANSFER(left.line, Crim.Layout_CT_DPS_Person.parsed)));

Arrest := dataset('~thor_data400::in::crim_court::ct_dps_arrest',Crim.Layout_CT_DPS_Person.csvin,CSV(SEPARATOR([]),TERMINATOR(['\n']), QUOTE([])));
export trArrest := project(Arrest, transform(Crim.Layout_CT_DPS_Arrest, SELF := TRANSFER(left.line, Crim.Layout_CT_DPS_Arrest)));

Offense := dataset('~thor_data400::in::crim_court::ct_dps_offense',Crim.Layout_CT_DPS_Person.csvin,CSV(SEPARATOR([]),TERMINATOR(['\n']), QUOTE([])));
export trOffense := project(Offense, transform(Crim.Layout_CT_DPS_Offense, SELF := TRANSFER(left.line, Crim.Layout_CT_DPS_Offense)));

DDCHARST := dataset('~thor_data400::in::crim_court::ct_dps_ddcharst',Crim.Layout_CT_DPS_Person.csvin,CSV(SEPARATOR([]),TERMINATOR(['\n']), QUOTE([])));
export trddcharst := project(DDCHARST, transform(CRIM.Layout_CT_DPS_DDCHARST, SELF := TRANSFER(left.line, CRIM.Layout_CT_DPS_DDCHARST)));

DDCHCHRG := dataset('~thor_data400::in::crim_court::ct_dps_ddchchrg',Crim.Layout_CT_DPS_Person.csvin,CSV(SEPARATOR([]),TERMINATOR(['\n']), QUOTE([])));
export trddchchrg := project(DDCHCHRG , transform(CRIM.Layout_CT_DPS_DDCHCHRG, SELF := TRANSFER(left.line, CRIM.Layout_CT_DPS_DDCHCHRG)));

end;

                    