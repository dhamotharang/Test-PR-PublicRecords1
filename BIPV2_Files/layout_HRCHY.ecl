import bipv2_proxid;
EXPORT layout_HRCHY := record
	unsigned6 parent_proxid; 
	unsigned6 ultimate_proxid;
	boolean has_LGID;
	BIPV2_ProxID.Layouts.dot_base;
end;