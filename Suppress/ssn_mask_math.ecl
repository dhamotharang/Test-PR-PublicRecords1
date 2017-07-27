// Useful for SSN Mask rollups.  For example, a transform might include:
//
// self.ssn_mask_value := Suppress.ssn_mask_math.add(L.ssn_mask_value,R.ssn_mask_value);

export ssn_mask_math := module

	shared unsigned1 mask2bits(string mask) := case(
		mask,
		'NONE'		=> 0,
		'FIRST5'	=> 1,
		'LAST4'		=> 2,
		'ALL'			=> 3,
		0
	);
	
	shared string bits2mask(unsigned1 bits) := case(
		bits,
		0 => 'NONE',
		1 => 'FIRST5',
		2 => 'LAST4',
		3 => 'ALL',
		''
	);
	
	export string add(string L, string R) := function
		return bits2mask( mask2bits(L) | mask2bits(R) );
	end;
	
end;