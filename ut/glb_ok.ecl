
export glb_ok(unsigned1 glb_purpose, boolean RNA=false) := 
    ut.PermissionTools.glb.ok(glb_purpose) and 
		not 
		(ut.PermissionTools.glb.restrictRNA(glb_purpose) and RNA);