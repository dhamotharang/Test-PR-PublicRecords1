
layout_ac317 := record
string cellPhone;
string Name;
string Address;
string City;
string State;
string Zip;
string Timezone;
string Default_Latitude;
string Default_Longitude;
string Line_Type;
string Ported_Flag;
string Country;
string County;
string County_Population;
string Default_OCN;
string Default_Carier;
end;
ds_ac317 := dataset('~thor200::in::ac317_file',layout_ac317,csv(heading(1),terminator('\n'), separator(',')));


cellphone.mac_evaluateCellFile(ds_ac317,cellPhone,my_outfile);

sequential(my_outfile);

