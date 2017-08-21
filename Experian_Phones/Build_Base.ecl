import ut,ExperianCred, models;
EXPORT Build_Base(STRING version, boolean incr_update) := FUNCTION
Layouts.base t_norm(Experian_Phones.Files.input le, c) := transform
self.phone_pos := c;
self.Phone_digits := map(c =1 => le.Phone_1_digits,
											c =2 => le.Phone_2_digits,
											le.Phone_3_digits);
self.Phone_type := map(c =1 => le.Phone_1_type,
											c =2 => le.Phone_2_type,
											le.Phone_3_type);
self.Phone_Source := map(c =1 => le.Phone_1_Source,
											c =2 => le.Phone_2_Source,
											le.Phone_3_Source);
self.Phone_Last_Updt := map(c =1 => le.Phone_1_Last_Updt[5..] + le.Phone_1_Last_Updt[1..2] + le.Phone_1_Last_Updt[3..4] ,
											c =2 => le.Phone_2_Last_Updt[5..] + le.Phone_2_Last_Updt[1..2] + le.Phone_2_Last_Updt[3..4],
											le.Phone_3_Last_Updt[5..] + le.Phone_3_Last_Updt[1..2] + le.Phone_3_Last_Updt[3..4]);
											
self.date_first_seen 		   	:= (unsigned)self.Phone_Last_Updt;
self.date_last_seen 			   	:= (unsigned)self.Phone_Last_Updt;
self.date_vendor_first_reported 	:= (unsigned)version;
self.date_vendor_last_reported  	:= (unsigned)version;
self.is_current    := true;
self.score := 0;
self := le;
self := [];
end;

norm := normalize(Experian_Phones.Files.input,3,t_norm(left,  counter))(Phone_digits <>'');

Mac_Update_Base(norm, incr_update, base_out);
BaseWithFullPhone := Experian_Phones.fn_AppendFullPhone(base_out);
max_update_date   := (string)ut.date_add('1 DAY', (string)max(base_out, Phone_Last_Updt)); 

assign_score := project(BaseWithFullPhone, transform(Layouts.base, 
																				self.score := Experian_Phones.fn_score(left.phone_type, left.phone_source, left.Phone_Last_Updt, max_update_date);
																				self := left));
									
return assign_score;
end;
