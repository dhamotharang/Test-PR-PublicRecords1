//export scramble_watercraft_base_search := 'todo';

import watercraft;

file_in:= dataset('~thor::base::demo_data_file_watercraft_base_coastguard_prodcopy', watercraft.Layout_Watercraft_Coastguard_Base,flat);

recordof(file_in) reformat(file_in L):= TRANSFORM
self.vessel_id := demo_data_scrambler.fn_scramblePII('NUMBER',l.vessel_id);
//	string10	vessel_database_key;
self.name_of_vessel := if(l.name_of_vessel<>'','HOME AWAY FROM HOME','');
self.call_sign := demo_data_scrambler.fn_scramblePII('CHARS',l.party_identification_number);
self.official_number := demo_data_scrambler.fn_scramblePII('CHARS',l.official_number);
self.imo_number := demo_data_scrambler.fn_scramblePII('CHARS',l.imo_number);
self.hull_number := demo_data_scrambler.fn_scramblePII('CHARS',l.hull_number);
self.hull_identification_number := '';
self.home_port_name := if(l.home_port_name<>'', 'HOME PORT','');
self.hailing_port := if(l.hailing_port<>'', 'HAILING PORT','');
self.party_identification_number := demo_data_scrambler.fn_scramblePII('NUMBER',l.party_identification_number);
self:=l;
END;

scrambled1 := project(file_in,reformat(LEFT));

export scramble_watercraft_base_coastguard  := dedup(sort(scrambled1,record),all);
