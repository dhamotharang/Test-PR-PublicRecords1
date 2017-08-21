import ln_property;

ds := ln_property.File_Deed_Addl_Names;

ln_propertyv2.layout_addl_names t_norm(ds le, integer c) := transform
 self.ln_fares_id        := le.ln_fares_id;
 self.apnt_or_pin_number := le.apnt_or_pin_number;
 self.buyer_or_seller := choose(c,'O','O','O','O','O','O','O','O','O','O','O','O','O','O',
                                  'S','S','S','S','S','S','S','S','S','S','S','S','S','S'
							   );
 self.name_seq := choose(c,'3','4','5','6','7','8','9','10','11','12','13','14','15','16',
                           '3','4','5','6','7','8','9','10','11','12','13','14','15','16'
						);
 self.name := choose(c,le.buyer3,  le.buyer4,  le.buyer5,  le.buyer6,  le.buyer7,  le.buyer8,  le.buyer9,
                       le.buyer10, le.buyer11, le.buyer12, le.buyer13, le.buyer14, le.buyer15, le.buyer16,
					   le.seller3, le.seller4, le.seller5, le.seller6, le.seller7, le.seller8, le.seller9,
                       le.seller10,le.seller11,le.seller12,le.seller13,le.seller14,le.seller15,le.seller16
					);
 self.id_code := choose(c,le.buyer3_id_code,  le.buyer4_id_code,  le.buyer5_id_code,  le.buyer6_id_code,  le.buyer7_id_code,  le.buyer8_id_code,  le.buyer9_id_code,
                          le.buyer10_id_code, le.buyer11_id_code, le.buyer12_id_code, le.buyer13_id_code, le.buyer14_id_code, le.buyer15_id_code, le.buyer16_id_code,
					      le.seller3_id_code, le.seller4_id_code, le.seller5_id_code, le.seller6_id_code, le.seller7_id_code, le.seller8_id_code, le.seller9_id_code,
                          le.seller10_id_code,le.seller11_id_code,le.seller12_id_code,le.seller13_id_code,le.seller14_id_code,le.seller15_id_code,le.seller16_id_code
					   );
end;

p_norm := normalize(ds,28,t_norm(left,counter))(name<>'');					  

write_to_file := output(p_norm,,'~thor_dell400_2::out::ln_propertyv2::v1_to_v2_addl_names',__compressed__,overwrite);

export v1_to_v2_addl_names := write_to_file;