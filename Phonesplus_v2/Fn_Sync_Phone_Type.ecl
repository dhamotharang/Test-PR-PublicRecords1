//****************Function to assign the same phonetype to multiple recs with the same phone10********************

export Fn_Sync_Phone_Type(dataset(recordof(Layout_In_Phonesplus.layout_in_common)) phplus_in) := function
//-------Sort by orig_phone_type desc to give priority to vendor phone type
phone_type := dedup(sort(distribute(phplus_in, hash(npa+phone7)),npa+phone7, if(append_phone_type[..3] in ['CEL', 'LND'], 1, 2), local),npa+phone7, local);

recordof(phplus_in) t_sync_phone_type (phplus_in le, phone_type ri) := transform
	self.append_phone_type := ri.append_phone_type;
	self.cellphone := le.npa + le.phone7;
	self := le;
end;

sync_phone_type := join(distribute(phplus_in, hash(npa+phone7)), 
				        phone_type,
						left.npa + left.phone7 = right.npa + right.phone7,
						t_sync_phone_type (left, right),
						left outer,
						local);

return sync_phone_type;
end;