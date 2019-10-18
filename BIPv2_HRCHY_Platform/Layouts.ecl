/*2013-08-07T20:31:45Z (vern_p bentley)
for BIPV2 Sprint 1
*/
IMPORT BIPV2,BIPV2_Files,DCAV2,DNB_DMI,Frandx;

EXPORT Layouts := MODULE

export lncar := record
	string50 name; 
	string9 enterprise_num; 
	string9 parent_enterprise_number; 
	string9 ultimate_enterprise_number; 
	string3 level; 
	string30 company_type; 
	DCAV2.layouts.Base.companies.date_last_seen;
end;

export dunsr := record
	string50 business_name; 
	string9 duns_number; 
	string9 parent_duns_number; 
	string9 ultimate_duns_number; 
	string9 headquarters_duns_number; 
	string3 hierarchy_code; 
	string3 type_of_establishment; 
	DNB_DMI.Layouts.Base.companies.date_last_seen; 
	DNB_DMI.Layouts.Base.companies.clean_address.prim_range; 
	DNB_DMI.Layouts.Base.companies.clean_address.prim_name; 
	DNB_DMI.Layouts.Base.companies.clean_address.sec_range; 
	DNB_DMI.Layouts.Base.companies.clean_address.zip
end;

export franr := record
	Frandx.layouts.Base.franchisee_id; 
	Frandx.layouts.Base.brand_name; 
	Frandx.layouts.Base.company_name; 
	Frandx.layouts.Base.unit_flag; 
	Frandx.layouts.Base.dt_last_seen
end;

export InRec := record

	unsigned6 proxid;
  unsigned6 id;
  unsigned6 parent_id;
  unsigned6 ultimate_id;
	boolean is_SELE_level := false;
	string20 name;
	string1 src := '';	
	string3 biz_type ;//:= '';

	unsigned6 derived_ultid;
	unsigned6 derived_orgid;	
	unsigned6 derived_SELEid;	
	
	// unsigned6 derived_ult_proxid;
	// unsigned6 derived_org_proxid;	
	// unsigned6 derived_SELE_proxid;		
	
	integer derived_levels_above;
	integer derived_levels_below;
	integer derived_levels_from_top;

end;

export prep_r2 := record
	Inrec; 
	string2 hrchy_type; 
	unsigned6 hq_id; 
	unsigned4 dt_last_seen; 
	boolean isLegalNameInHeader;
end;

export r1 := record
	InRec;
	dataset(InRec) parents;
end;

export 	r2 := record
		r1;
		dataset(InRec) children;
end;
	
export lgidr := record
		unsigned6 lgid;
		unsigned3 lgid_level;
		unsigned3 nodes_below;
		unsigned6 proxid;
		unsigned3 proxid_level_within_lgid;
		unsigned6 parent_proxid;
		unsigned6 SELE_proxid;
		unsigned6 Org_proxid;
		unsigned6 ultimate_proxid;
		boolean proxid_is_SELE_level;
		// boolean lgid_is_SELE_level := false;		
		// boolean proxid_is_org_level;
		// boolean lgid_is_org_level := false;
		string1 src;
		string3 biz_type;
end;

export r4 := record
	r2.proxid;
	r2.derived_ultid;	
	r2.derived_orgid;	
	r2.derived_SELEid;		
  lgidr.ultimate_proxid;//odd name
	lgidr.org_proxid;	
	lgidr.SELE_proxid;	
	lgidr.parent_proxid;	
	lgidr.nodes_below;	
	lgidr.src;	
	unsigned3 nodes_total;	
	boolean is_Ult_level := false;
	boolean is_Org_level := false;
	r2.is_SELE_level;
end;

export rWithIDs := record
	r4;
	r2 and not [proxid, is_SELE_level, src, derived_ultid, derived_orgid, derived_SELEid];
end;

export HrchyBase := BIPV2.CommonBase.Layout : DEPRECATED('Use BIPV2.CommonBase.Layout instead.');
export HrchyBase_Static := BIPV2.CommonBase.Layout_Static;

END;