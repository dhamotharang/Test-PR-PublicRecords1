export MAC_Mask(
	inf, outf, ssn_field, dl_field, isassn, isadl,
	batch=false, useUnmasked=false, unmasked_field='ssn_unmasked', maskVal='ssn_mask_value'
) := MACRO

// SSN mask function
#uniquename(ssn_mask)
%ssn_mask%(string i, string mask_type) := function
  clean_mask := StringLIb.StringToUpperCase (mask_type);
	original	:= stringlib.stringfilter(i,'0123456789xX');
	pad_len		:= 9 - length(original);
	complete	:= '000000000'[1..pad_len] + original;
	masked := case(clean_mask,
		'ALL'			=>	'xxxxxxxxx',
		'LAST4'		=>	complete[1..5] + 'xxxx',
		'FIRST5'	=>	'xxxxx' + complete[6..9],
		complete
	);
	return masked[(pad_len+1)..9];
end;

// But with no SSN suppression key, it's all a single transform...
#uniquename(ezMasker)
typeof(inf) %ezMasker%(inf L) := transform

	#if(isassn)
		authMask :=
			#if(batch)
				L.ssn_mask_value
			#else
				maskVal
			#end
			;
		self.ssn_field := %ssn_mask%(L.ssn_field, authMask);
	#end
	
	#if(useUnmasked)
		self.unmasked_field := L.ssn_field;
	#end
	
	#if(isadl)
		self.dl_field := if(
			trim(L.dl_field)='',
			'', 
			if(dl_mask_value, 'xxxxxxxxxxxxxx', L.dl_field)
		);
	#end
	
	self := L;
end;
outf := project(inf, %ezMasker%(left));

ENDMACRO;