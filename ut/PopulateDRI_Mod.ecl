//this function populates the in parameters into the AutoStandardI / DataRestrictionI
// interfaces to prevent hitting the global module when calling the AutoStandardI functions
EXPORT PopulateDRI_Mod(in_mod) := FUNCTIONMACRO
	IMPORT AutoStandardI;
// this includes AutoStandardI.PermissionI_Tools.params,
	tempMod := MODULE(AutoStandardI.DataRestrictionI.params) 
		EXPORT BOOLEAN AllowAll           := FALSE;
	  EXPORT BOOLEAN AllowGLB           := FALSE;
	  EXPORT BOOLEAN AllowDPPA          := FALSE;
		EXPORT BOOLEAN ignoreFares        := FALSE;
		EXPORT BOOLEAN ignoreFidelity     := FALSE;
		EXPORT UNSIGNED1 GLBPurpose       := in_mod.GLBPurpose;
    EXPORT UNSIGNED1 DPPAPurpose      := in_mod.DPPAPurpose;
		EXPORT BOOLEAN IncludeMinors      := in_mod.IncludeMinors;
		EXPORT STRING DataRestrictionMask := in_mod.DataRestrictionMask;
		EXPORT BOOLEAN restrictPreGLB     := in_mod.DataRestrictionMask[23] = '1';
	END;

	RETURN tempMod;
ENDMACRO;

// now you can call the functions in AutoStandardI.PermissionI_Tools or
// AutoStandardI.DataRestrictionI without hitting the global module:
// EX: AutoStandardI.PermissionI_Tools.val(ut.PopulateDRI_Mod(in_mod)).glb.ok(in_mod.GLBPurpose);
