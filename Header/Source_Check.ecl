import drivers, vehiclev2, mdr;

old := header.Source_Counts_prev;
new := header.Source_Counts_new;
dlc := drivers.Source_Counts;
veh := vehiclev2.Source_Counts;

rec := header.layout_Source_Check;

rec tra_on(old o, new n) := transform
	self.src := if(o.src <> '', o.src, n.src);
	self.translation := header.translateSource(self.src);
	self.src_group := mdr.Source_Group(self.src);
	self.is_ddpa := mdr.Source_is_DPPA(self.src);
	self.is_on_probation := mdr.Source_is_on_Probation(self.src);
	self.old_count := o.counted;
	self.new_count := n.counted;
	self.alert := trim(if(self.old_count = 0, (string40)' *APPEAR* ', (string40)'') + 
				  if(self.new_count = 0, (string40)' *DISAPPEAR* ', (string40)''));
end;

//****** Old to New
on := join(old, new, left.src = right.src, tra_on(left, right),
		   full outer, local);

//****** DL
rec tra_ondl(on o, dlc d) := transform
	self.src := if(o.src <> '', o.src, d.src);
	self.translation := header.translateSource(self.src);
	self.src_group := mdr.Source_Group(self.src);
	self.is_ddpa := mdr.Source_is_DPPA(self.src);
	self.is_on_probation := mdr.Source_is_on_Probation(self.src);
	self.external_count := d.counted;
	self.external_state := d.orig_state;
	self.alert := trim(o.alert) + trim(
				  if(d.orig_state > '' and self.src = '', 
					 (string40)' * IN DL, NOT IN HEADER *', 
					 (string40)'') + 
				  if(d.orig_state > '' and self.is_ddpa = false, 
					 (string40)' * IN DL, NOT DPPA *', 
					 (string40)''));

	self := o;
end;

ondl := join(on, dlc, left.src = right.src and right.src <> '', tra_ondl(left, right),
		   full outer, local);

//****** Veh
rec tra_ondlve(ondl o, veh v) := transform
	self.src := if(o.src <> '', o.src, v.src);
	self.translation := header.translateSource(self.src);
	self.src_group := mdr.Source_Group(self.src);
	self.is_ddpa := mdr.Source_is_DPPA(self.src);
	self.is_on_probation := mdr.Source_is_on_Probation(self.src);
	self.external_count := if(o.external_count > 0, o.external_count, v.counted);
	self.external_state := if(o.external_state > '', o.external_state, v.state_origin);
	self.alert := trim(o.alert) + trim(
				  if(v.state_origin > '' and self.src = '', 
					 (string40)' * IN VEH, NOT IN HEADER *', 
					 (string40)'') +
				  if(v.state_origin > '' and self.is_ddpa = false, 
					 (string40)' * IN VEH, NOT DPPA *', 
					 (string40)''));
	self := o;
end;

ondlve := join(ondl, veh, left.src = right.src and right.src <> '', tra_ondlve(left, right),
		   full outer, local);

rec lastcheck(rec l) := transform
	self.alert := trim(l.alert) + trim(if(l.old_count = 0 and l.is_on_probation = false, 
									   (string40)' * NEW FILE NOT ON PROBATION * ',
									   (string40)''));
	self.is_utility := mdr.Source_is_Utility(l.src);
	self.not4_despray := mdr.Source_not4_Despray(l.src);
	self := l;
end;



export source_check := 
	   project(ondlve, lastcheck(left)) : persist('headerbuild_source_check');