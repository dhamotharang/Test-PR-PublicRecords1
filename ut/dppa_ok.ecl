
export dppa_ok(unsigned1 dppa_purpose,boolean RNA=false) := 
    ut.PermissionTools.dppa.ok(dppa_purpose) and 
		not 
		(ut.PermissionTools.dppa.restrictRNA(dppa_purpose) and RNA);
