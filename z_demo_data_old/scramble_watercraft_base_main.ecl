//export scramble_watercraft_base_search := 'todo';

import watercraft;

file_in:= dataset('~thor::base::demo_data_file_watercraft_base_main_prodcopy', watercraft.Layout_Watercraft_main_Base,flat);

recordof(file_in) reformat(file_in L):= TRANSFORM
self.watercraft_id := demo_data_scrambler.fn_scramblePII('NUMBER',l.watercraft_id);
self.hull_number := demo_data_scrambler.fn_scramblePII('CHARS',l.hull_number);
self.watercraft_name := if(l.watercraft_name<>'','HOME AWAY FROM HOME','');
self.lien_2_indicator := '';
self.lien_2_name:= '';
self.lien_2_date:= '';
self.lien_2_address_1:= '';
self.lien_2_address_2:= '';
self.lien_2_city:= '';
self.lien_2_state:= '';
self.lien_2_zip:= '';
self.lien_1_name := 'Boaters Banker';
self.lien_1_date := demo_data_scrambler.fn_scramblePII('DOB',l.lien_1_date);
self.lien_1_address_1 := '12345 Lienholders Way';
self.lien_1_address_2 := '';
self.coast_guard_number := demo_data_scrambler.fn_scramblePII('CHARS',l.coast_guard_number);
self.decal_number := demo_data_scrambler.fn_scramblePII('CHARS',l.decal_number);
self.title_number := demo_data_scrambler.fn_scramblePII('CHARS',l.title_number);
self.registration_number := demo_data_scrambler.fn_scramblePII('CHARS',l.registration_number);
self.registration_date := demo_data_scrambler.fn_scramblePII('DOB',l.registration_date);
self.registration_expiration_date := demo_data_scrambler.fn_scramblePII('DOB',l.registration_expiration_date);
self.registration_status_date := '';
self.registration_renewal_date := '';
self.purchase_date := '';
self.title_issue_date := demo_data_scrambler.fn_scramblePII('DOB',l.title_issue_date);
//
self:=l;
END;

scrambled1 := project(file_in,reformat(LEFT));

export scramble_watercraft_base_main  := dedup(sort(scrambled1,record),all);

