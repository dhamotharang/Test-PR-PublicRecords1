import BIPV2, BIPV2_Files,  DCAV2, DNB_DMI, Frandx, mdr ,BIPV2_Field_Suppression;


EXPORT mod_Build(
	dataset(BIPV2_Files.layout_proxid) 							head , 
	dataset(DCAV2.layouts.Base.companies) 					lncad = BIPV2_Files.files_hrchy.lnca,							
	dataset(recordof(BIPV2_Files.files_hrchy.duns)) dunsd = BIPV2_Files.files_hrchy.duns,							
	dataset(Frandx.layouts.Base)										frand = BIPV2_Files.files_hrchy.fran
) :=
MODULE	


//***** PICK UP PROXIDS AND GET INTO COMMON LAYOUT
lj := BIPv2_HRCHY.PrepSources.LNCA(head, lncad);
fj := BIPv2_HRCHY.PrepSources.FRAN(head, frand);
dj := BIPv2_HRCHY.PrepSources.DUNS(head, dunsd);
aj := project(dedup(lj + dj + fj, all),transform({unsigned rid,recordof(left)},self.rid := counter,self := left)) : persist('~thor_data400::BIPv2_HRCHY::mod_Build.aj');

// -- suppress hierarchy
ds_suppress := BIPV2_Field_Suppression.mac_Suppress_Hierarchy(aj) : persist('~persist::BIPv2_HRCHY::mod_Build.ds_suppress');

//***** IDENTIFY COMMON HRCHY TYPES THAT CAN BE PATCHED
d2 := BIPv2_HRCHY.PrepSources.Patch(project(ds_suppress,recordof(dj)));

//***** HANDLE OVERLAPPING SOURCES
d3 := BIPv2_HRCHY.PrepSources.HandleDups(d2) : persist('~thor_data400::BIPv2_HRCHY::mod_Build.d3' );


//***** CALL THE FUNCTIONS THAT ASSIGN ORGID/ULTID AND CREATE LGID TABLE
shared rc := Functions.RemoveConflict(project(d3, BIPv2_HRCHY.Layouts.inrec)) : persist('~thor_data400::cemtemp::rc' );

shared wpc := Functions.WithParentsChildren(rc) : persist('~thor_data400::BIPv2_HRCHY::mod_Build.wpc' );

export LGIDTable := Functions.LgidTable(wpc) 
	#IF(Debug)
	: persist('~thor_data400::BIPv2_HRCHY::mod_Build.lt' )
	#END	
	;

export wi :=  Functions.WithIds(wpc,LGIDTable) 
	#IF(Debug)
		: persist('~thor_data400::BIPv2_HRCHY::mod_Build.wi' )
	#END	
	;	

//***** PATCH THE IDS and indicators ONTO THE HEADER
export PatchedFile := Functions.PatchHeader(head, wi);


export headrec2 := BIPV2.CommonBase.Layout : DEPRECATED('Use BIPV2.CommonBase.Layout instead.');

END;

/*
// some debug code
ajr := RECORD
  unsigned6 proxid;
  unsigned6 id;
  unsigned6 parent_id;
  unsigned6 ultimate_id;
  boolean is_sele_level;
  string20 name;
  string1 src;
  string3 biz_type;
  unsigned6 derived_ultid;
  unsigned6 derived_orgid;
  unsigned6 derived_seleid;
  integer8 derived_levels_above;
  integer8 derived_levels_below;
  integer8 derived_levels_from_top;
  string2 hrchy_type;
  unsigned6 hq_id;
 END;

fr := RECORD
  unsigned6 proxid;
  unsigned6 id;
  unsigned6 parent_id;
  unsigned6 ultimate_id;
  boolean is_sele_level;
  string20 name;
  string1 src;
  string3 biz_type;
  unsigned6 derived_ultid;
  unsigned6 derived_orgid;
  unsigned6 derived_seleid;
  integer8 derived_levels_above;
  integer8 derived_levels_below;
  integer8 derived_levels_from_top;
  string2 hrchy_type;
  unsigned6 hq_id;
 END;


 inrec := RECORD
   unsigned6 proxid;
   unsigned6 id;
   unsigned6 parent_id;
   unsigned6 ultimate_id;
   boolean is_sele_level;
   string20 name;
   string1 src;
   string3 biz_type;
   unsigned6 derived_ultid;
   unsigned6 derived_orgid;
   unsigned6 derived_seleid;
   integer8 derived_levels_above;
   integer8 derived_levels_below;
   integer8 derived_levels_from_top;
  END;

wpcr := RECORD
  unsigned6 proxid;
  unsigned6 id;
  unsigned6 parent_id;
  unsigned6 ultimate_id;
  boolean is_sele_level;
  string20 name;
  string1 src;
  string3 biz_type;
  unsigned6 derived_ultid;
  unsigned6 derived_orgid;
  unsigned6 derived_seleid;
  integer8 derived_levels_above;
  integer8 derived_levels_below;
  integer8 derived_levels_from_top;
  DATASET(inrec) parents;
  DATASET(inrec) children;
 END;



f := dataset('~thor_data400::BIPv2_HRCHY::mod_Build.f', fr, thor);
aj := dataset('~thor_data400::BIPv2_HRCHY::mod_Build.aj', ajr, thor);
wpc := dataset('~thor_data400::BIPv2_HRCHY::mod_Build.wpc', wpcr, thor);
*/