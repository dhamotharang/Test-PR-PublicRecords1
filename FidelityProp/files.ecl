import ut;
export files := 
MODULE

export wbothseq := 
	// dataset('~thor_data400::cemtemp::wbothseq', FidelityProp.layouts.from_prop_fid, thor);
	dataset('~thor_data400::cemtemp::wbothseq_withfares20090319', FidelityProp.layouts.from_prop_fid, thor);
	
export wbothseq_forstat := dataset('~thor_data400::cemtemp::wbothseq_withfares20090423', FidelityProp.layouts.from_prop_fid, thor);	
export wbothseq_forstat_nofares := dataset('~thor_data400::cemtemp::wbothseq_nofares20090428', FidelityProp.layouts.from_prop_fid, thor);	
export result_previous := dataset(
// '~thor_data400::cemtemp::j'
'~thor400_88_staging::thor_data400::cemtemp::j_withfares20090326_all'
, FidelityProp.layouts.out, thor);
export result := dataset(
// '~thor_data400::cemtemp::j'
// '~thor400_88_staging::thor_data400::cemtemp::j_withfares20090326_all'
// ut.foreign_prod + 'thor_data400::cemtemp::j_nofares_and_justfares20090625'
'~thor400_88_staging::thor_data400::cemtemp::j_nofares_and_justfares20090625'//i just moved it over from prod via W20090625-173504 
, FidelityProp.layouts.out, thor);
export result_csv :=
dataset(
		// '~thor_data400::out::FidelityProp',
		ut.foreign_prod + 'thor_data400::out::fidelityprop_nofares_and_justfares20090625',
		FidelityProp.layouts.out,
		csv(
			heading(1),
			separator(','), 
			terminator('\n'), 
			quote('"')
		)
	);
	
mac(i,ds) := macro
ds :=
dataset(	
	'~thor_data400::out::FidelityPropSlice400staging::' + trim((string)i),
	FidelityProp.layouts.out,
		csv(
			heading(1),
			separator(','), 
			terminator('\n'), 
			quote('"')
		)
	);
endmacro;

mac(1,m1)
mac(2,m2)
mac(3,m3)
mac(4,m4)
mac(5,m5)
mac(6,m6)
mac(7,m7)
mac(8,m8)
mac(9,m9)
mac(10,m10)
mac(11,m11)
mac(12,m12)
mac(13,m13)
mac(14,m14)
mac(15,m15)
mac(16,m16)
mac(17,m17)
mac(18,m18)
mac(19,m19)
mac(20,m20)

export result_csv_chuncks := 
m1 +
m2 +
m3 +
m4 +
m5 +
m6 +
m7 +
m8 +
m9 +
m10 +
m11 +
m12 +
m13 +
m14 +
m15 +
m16 +
m17 +
m18 +
m19 +
m20;



END;