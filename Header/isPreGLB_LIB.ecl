// This function is used by libary modules.  It accepts DataRestrictionMask as a parameter
// instead of trying to read the value from Stored.  The header.isPreGLB function uses GlobalMod, 
// which reads from Stored.  Library modules can't read from Stored (or write to #Stored).

import AutoStandardI;

export IsPreGLB_LIB(unsigned3 nonglb_last_seen, 
										unsigned3 first_seen, 
										string2 src, 
										string DataRestrictionMask) := function

	tempmod:= module(AutoStandardI.PermissionI_Tools.params)
				export boolean AllowAll := false;
				export boolean AllowGLB := false;
				export boolean AllowDPPA := false;
				export unsigned1 DPPAPurpose := 0; // not needed to check HeaderIsPreGLB
				export unsigned1 GLBPurpose := 0; // not needed to check HeaderIsPreGLB
				export boolean IncludeMinors := false;
				export boolean restrictPreGLB := DataRestrictionMask[23] = '1';
	end;

	return(AutoStandardI.PermissionI_Tools.val(tempmod).GLB.HeaderIsPreGLB(nonglb_last_seen, 
																																				 first_seen, 
																																				 src));

end;