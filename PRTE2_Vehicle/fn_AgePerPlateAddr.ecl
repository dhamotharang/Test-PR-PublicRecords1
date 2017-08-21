import prte2_vehicle, std, ut, NID;

EXPORT fn_AgePerPlateAddr(dataset(recordof(layouts.party_sequence)) dsCleanSeq) := function

/*Function used to identify minor per license/addr.  Also, use metaphone data to populate 
// Dedup all fields except state_type because since its sorted by state_type (sorted by record
// but this sort should put state_type in ascending order),the records that have
// the same state origin as the other state fields will keep 'A' in this field and thus we will know
// to keep this record in the moxie search,since the moxie search wants to keep only records where the
// state_origin matches the input state origin.
*/

Layouts.slim_rec tnormalizeplate(dsCleanSeq L, integer cnt) := transform
self.license_plate 					:= trim(choose(cnt, L.reg_true_license_plate, L.Reg_License_Plate, l.Reg_Previous_License_Plate),all);
self.reverse_license_plate 	:= STD.Str.Reverse(trim(choose(cnt, L.reg_true_license_plate, L.Reg_License_Plate, l.Reg_Previous_License_Plate)));

// set to C for previous registered state
self.state_type := if(cnt=3,'C','');
self.state 			:= if(cnt=3,l.reg_previous_license_state, '');
self.st 				:= l.append_clean_address.st;
self 						:= l.append_clean_name;
self 						:= l.append_clean_address;
self := L;
end;

party_plate_norm  := normalize(dsCleanSeq(reg_true_license_plate != '' or Reg_License_Plate != '' or Reg_Previous_License_Plate != ''),3, tnormalizeplate(left, counter));

layouts.slim_rec tnormalizestate(party_plate_norm L, integer cnt) := transform
self.state := choose(cnt, l.reg_previous_license_state,l.state_origin, L.st, l.Reg_License_State);
self := L;
end;

party_norm  := normalize(party_plate_norm(reg_previous_license_state != '' or state_origin != '' or st != '' or Reg_License_State != ''),	4, tnormalizestate(left, counter));

party_norm_all := party_norm + party_plate_norm(state_type='C');		

layouts.lic_plate_rec 	tformat(party_norm_all L) := transform
self.state_origin := L.state;
self.is_current 	:= l.orig_name_type in ['4','5'] and l.history='';

age := ut.Age((UNSIGNED) l.orig_dob);
self.is_minor 		:= if(age=0 or age>=18,FALSE,TRUE);
self.date 				:=(unsigned4) map(l.Reg_Latest_Effective_Date<>''=>l.Reg_Latest_Effective_Date,
																		l.Reg_Latest_Expiration_Date<>''=>l.Reg_Latest_Expiration_Date,
																		l.Ttl_Latest_Issue_Date);
self.use_ssn 			:= if(l.orig_ssn<>'',l.orig_ssn,l.append_ssn);		
self.dph_lname 		:=	metaphonelib.DMetaPhone1(l.lname);			
self.pfname 			:=	NID.PreferredFirstVersionedStr(l.fname, NID.version);	
self := L;
end;

party_grp := group(sort(project(party_norm_all, tformat(left)),
												vehicle_key,iteration_key,sequence_key,if(is_current,0,1),-date),
										vehicle_key,iteration_key,sequence_key);

layouts.lic_plate_rec 	trickle_current_date(party_grp l, party_grp r,integer C):=transform
self.is_current := if(C=1,r.is_current,l.is_current);
self.date := if(C=1,r.date,l.date);	self := r;
end;
	
party_iter := iterate(party_grp, trickle_current_date(left,right,counter));
party_ungroup := ungroup(dedup(sort(party_iter(license_plate <> '', reverse_license_plate <> '', state_origin <> ''), record),record,except state_type));

return party_ungroup;
end;