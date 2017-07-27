// This macro uses the SSN portion of Suppress.MAC_Mask to mask SSNs within child datasets.

export MAC_Mask_dsSSN(
	inf, outf, ds_field, ssn_field,
	useUnmasked=false, unmasked_field='ssn_unmasked', maskVal='ssn_mask_value'
) := macro

	// create a flattened list of SSNs
	#uniquename(l_ssn)
	#uniquename(normed)
	%l_ssn% := {typeof(inf.ds_field.ssn_field) ssn, typeof(inf.ds_field.ssn_field) ssn_unmasked};
	%normed% := dedup(
		sort(
			normalize(inf, left.ds_field, transform(%l_ssn%, self.ssn:=right.ssn_field, self:=[])),
			record
		),
		record
	);

	// mask them
	#uniquename(masked)
	Suppress.MAC_Mask(%normed%, %masked%, ssn, blank, true, false, /*batch*/, true, /*unmasked_field*/, maskVal);

	// and merge the masked SSNs back into the original structure
	#uniquename(mask_child)
	#uniquename(mask_rec)
	recordof(inf.ds_field) %mask_child%(recordof(inf.ds_field) L) := transform
		self.ssn_field := %masked%(ssn_unmasked=L.ssn_field)[1].ssn;
		#if(useUnmasked)
			self.unmasked_field := L.ssn_field;
		#end
		self := L;
	end;
	inf %mask_rec%(inf L) := transform
		self.ds_field := project(L.ds_field, %mask_child%(left));
		self := L;
	end;
	outf := project(inf, %mask_rec%(left));
	
endmacro;