//****************Function to append flags/indicators when matching to Tercodia and other auxiliary files***************
import Phonesplus, Yellowpages, ut, Gong, Cellphone, Risk_Indicators;

export Fn_Append_Phone_Data(dataset(recordof(Layout_In_Phonesplus.layout_in_common)) phplus_in) := function

telcodia_tmp  := dedup(sort(distribute(phonesplus_v2.File_Telcordia_TMP.File_Telcordia_TMP_Out, hash(npa+nxx+block_id)), npa+nxx+block_id,-eff_last_change[5..6], -eff_last_change[..2],-eff_last_change[3..4],  local), npa+nxx+block_id, local);

telcordia_tds := dedup(sort(distribute(phonesplus.File_telecordia_tds_base, hash(npa+nxx+tb)), npa+nxx+tb, COCType, SSC, local), npa+nxx+tb, local);

//reformat file before passing through YellowPages.NPA_PhoneType because it doesn't accept fields with name cellphone
tem_layout := record
	Layout_In_Phonesplus.layout_in_common and not [cellphone],
	string10 phone;
end;

temp_phplus_in := project(phplus_in, transform(tem_layout, self.phone := left.cellphone, self := left));

YellowPages.NPA_PhoneType(temp_phplus_in,orig_phone,Phone_Type,pplus_sources_phone_type, true);

new_temp_layout := record
	Layout_In_Phonesplus.layout_in_common,
	string phone_type
end;

pplus_sources_phone_type_ref := project(pplus_sources_phone_type, transform(new_temp_layout, self.cellphone := left.phone, self := left));

recordof(phplus_in) t_append_telcordia_tmp(pplus_sources_phone_type_ref le, telcodia_tmp ri) := transform
	self.append_npa_effective_dt		:= ut.Date_MMDDYY_I2(ri.eff_date_assign);
	self.append_npa_last_change_dt		:= ut.Date_MMDDYY_I2(ri.eff_last_change);
	self.append_dialable_ind			:= ri.dialable_ind;
	self.append_place_name				:= ri.place_name;
	self.append_portability_indicator	:= ri.portability;
	self.append_ocn						:= ri.co_name;
	self.append_time_zone				:= ri.tz;
	self.append_nxx_type				:= ri.nxx_type;
	self.append_phone_type				:= le.phone_type;
	self.append_company_type			:= ri.company_type;
	self := le;
	self := ri;
end;

App_Phone_Data_tmp := join(distribute(pplus_sources_phone_type_ref, hash(orig_phone[..7])),
					   telcodia_tmp,
						 left.orig_phone[..7] = right .npa+right.nxx+right.block_id,
						 t_append_telcordia_tmp(left, right),
						 lookup,
						 left outer,
						 local);
						 
						 
						 
recordof(phplus_in) t_append_telcordia_tds(App_Phone_Data_tmp le, telcordia_tds ri) := transform
	self.append_COCType					:= ri.COCType;
	self.append_SCC					    := ri.SSC;
	self := le;
end;

App_Phone_Data_tds := join(distribute(App_Phone_Data_tmp, hash(orig_phone[..7])),
					   telcordia_tds,
						 left.orig_phone[..7] = right .npa+right.nxx+right.tb,
						 t_append_telcordia_tds(left, right),
						 lookup,
						 left outer,
						 local);
						 
						 
return App_Phone_Data_tds;
end;