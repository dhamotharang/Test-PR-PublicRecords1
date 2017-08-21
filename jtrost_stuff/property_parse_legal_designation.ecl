EXPORT property_parse_legal_designation(dataset(recordof(jtrost_stuff.layout_property_field_names_expanded)) in_ds) := function

layout_property_field_names_expanded xform_identify_legal_desig(layout_property_field_names_expanded le) := transform

 boolean ends_in_inc                  := regexfind(' INC$',le.name_standard_clean);
 boolean ends_in_n_a                  := regexfind(' N A$',le.name_standard_clean);
 boolean ends_in_na                   := regexfind(' NA$',le.name_standard_clean);
 boolean ends_in_national_association := regexfind(' NATIONAL ASSOCIATION$',le.name_standard_clean);
 boolean ends_in_corporation          := regexfind(' CORPORATION$',le.name_standard_clean);
 boolean ends_in_co                   := regexfind(' CO$',le.name_standard_clean);
 boolean ends_in_lp                   := regexfind(' LP$',le.name_standard_clean);
 boolean ends_in_l_p                  := regexfind(' L P$',le.name_standard_clean);
 boolean ends_in_llc                  := regexfind(' LLC$',le.name_standard_clean);
 boolean ends_in_l_l_c                := regexfind(' L L C$',le.name_standard_clean);
 boolean ends_in_lllp                 := regexfind(' LLLP$',le.name_standard_clean);
 boolean ends_in_ltd_lp               := regexfind(' LTD LP$',le.name_standard_clean);
 boolean ends_in_ltd                  := regexfind(' LTD$',le.name_standard_clean);

 self.legal_desig := map(ends_in_inc                  => 'INC',
                         ends_in_n_a                  => 'NA',
												 ends_in_na                   => 'NA',
												 ends_in_national_association => 'NA',
												 ends_in_corporation          => 'CORPORATION',
												 ends_in_co                   => 'CO',
												 ends_in_lp                   => 'LP',
												 ends_in_l_p                  => 'LP',
												 ends_in_llc                  => 'LLC',
												 ends_in_l_l_c                => 'LLC',
												 ends_in_lllp                 => 'LLLP',
												 ends_in_ltd_lp               => 'LTD LP',
												 ends_in_ltd                  => 'LTD',
												 '');
 
 self.name_standard_clean := map(ends_in_inc                  => le.name_standard_clean[1..length(le.name_standard_clean)-4],
                           ends_in_n_a                  => le.name_standard_clean[1..length(le.name_standard_clean)-4],
												   ends_in_na                   => le.name_standard_clean[1..length(le.name_standard_clean)-3],
												   ends_in_national_association => le.name_standard_clean[1..length(le.name_standard_clean)-21],
												   ends_in_corporation          => le.name_standard_clean[1..length(le.name_standard_clean)-12],
												   ends_in_co                   => le.name_standard_clean[1..length(le.name_standard_clean)-3],
												   ends_in_lp                   => le.name_standard_clean[1..length(le.name_standard_clean)-3],
												   ends_in_l_p                  => le.name_standard_clean[1..length(le.name_standard_clean)-4],
												   ends_in_llc                  => le.name_standard_clean[1..length(le.name_standard_clean)-4],
												   ends_in_l_l_c                => le.name_standard_clean[1..length(le.name_standard_clean)-6],
												   ends_in_lllp                 => le.name_standard_clean[1..length(le.name_standard_clean)-5],
												   ends_in_ltd_lp               => le.name_standard_clean[1..length(le.name_standard_clean)-7],
												   ends_in_ltd                  => le.name_standard_clean[1..length(le.name_standard_clean)-4],
												   le.name_standard_clean);
 
 self := le;
end;

p1 := project(in_ds,xform_identify_legal_desig(left)) : persist('persist::property_parse_legal_desig');

return p1;

end;