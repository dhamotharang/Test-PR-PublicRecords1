/*2005-04-27T00:50:37Z (t kirk)
2005-04-27T00:49:11Z, Copied with AMT from Attribute Modified by Tony Kirk
*/

/*
	Can we rewrite this without the macro?  Sure, but it's a simpler change to leave calling attribute as is...
	tkirk - 20050426
*/

export MAC_Join_Vehreg_VIN(pInFile, pOutFile)
 :=
  macro

// the vin_matches attribute references an already distributed and deduped dataset, persisted
dInFileDist	:=	distribute(pInFile,hash((string25)orig_vin));


// change to join on vin_input in VINA file, since that is the value in the vehicle file that is searched in VINA app.
pOutFile	:=	join(dInFileDist, VehLic.Vin_Matches,
					 left.orig_vin = right.vin_input,
					 vehlic.tra_make_veh_vin(left, right, left.orig_vin, false, true),
					 left outer,
					 local
					);

  endmacro
 ;