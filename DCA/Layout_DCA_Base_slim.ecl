import DCAV2;

//** Modified layout to use the same layout defined in DCAV2 module to avoid the confusion in future.
//** Jira# CCPA-12
export Layout_DCA_Base_slim := record
	DCAV2.Layouts.base.keybuild;
end;