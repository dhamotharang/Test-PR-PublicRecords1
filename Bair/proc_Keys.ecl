EXPORT proc_Keys(string version = '', boolean pUseProd = false, boolean pDelta = false) := module

	EXPORT bld_all
			:= if(pDelta
						,sequential(
							Bair.Build_Updates(version,pUseProd).delta_key,
							Bair.Build_Updates(version,pUseProd).promote_deltas,
							Bair.Patch_GeoHashFull(version, pUseProd).gh,
							// Bair.Patch_GeoHashFull_LPR(version, pUseProd).gh
							)
						,sequential(
							Bair.Build_Updates(version,pUseProd).full_key,
							Bair.Build_Updates(version,pUseProd).promote_full
							)
						);
End;