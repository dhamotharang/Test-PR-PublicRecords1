import header;
gg := dataset('~thor_data400::in::ssnissue',header.layout_ssn_map,flat);

export Key_Prep_SSN_Map := INDEX(gg, 
{ ssn5,
start_date,
end_date,
state_name,
status_code,
__filepos
}, '~thor_data400::key::ssn_map' + thorlib.WUID());