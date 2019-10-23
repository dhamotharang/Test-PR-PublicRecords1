import driversv2, header, atf, faa, prof_licensev2, 
       business_header, bankrupt, doxie_files, doxie_build, SexOffender, watercraft, ut,
       ln_propertyv2, vehicleV2, paw, PRTE2_Header;
			 
v := vehiclev2.file_vehicleV2_party(history='' and append_did <> 0);

v_dedup := dedup(v, vehicle_key,append_did, all); 

r := record
  unsigned6 did;
  unsigned2 veh_cnt := 0;
  unsigned2 dl_cnt := 0;
  unsigned2 head_cnt := 0;
  unsigned2 crim_cnt := 0;
  unsigned2 sex_cnt := 0;
  unsigned2 ccw_cnt := 0;
  unsigned2 rel_count := 0;
  unsigned2 fire_count := 0;
  unsigned2 faa_count := 0;
  unsigned2 prof_count := 0;
  unsigned2 vess_count := 0;
  unsigned2 bus_count := 0;
  unsigned2 paw_count := 0;	// new for hfss
  unsigned2 bc_count := 0;	// new for hfss
  unsigned2 prop_count := 0;
  unsigned2 prop_asses_count := 0;	// new for hfss
  unsigned2 prop_deeds_count := 0;	// new for hfss
  unsigned2 bk_count := 0;
  end;

pr := ln_propertyv2.File_Search_DID;

r from_prop(pr le) := transform
  self.did := (unsigned6)le.did;
  self.prop_count := 1;
  self.prop_asses_count := IF(le.ln_fares_id[2] = 'A', 1, 0);
  self.prop_deeds_count := IF(le.ln_fares_id[2] = 'D', 1, 0);
  end;
  
ps := project(pr,from_prop(left));  
  
b := business_header.File_Business_Contacts_Plus;

r from_b(b le) := transform
  self.did := le.did;
  self.bus_count := 1;
  end;
  
bs := project(b,from_b(left));

r from_bc(recordof(business_header.Files().Out.Contacts.qa) le) :=
TRANSFORM
  self.did := (unsigned6)le.did;
  self.bc_count := 1;
END;

bc := project(business_header.Files().Out.Contacts.qa((unsigned)did<>0),from_bc(LEFT));

r from_paw(recordof(paw.files().base.built) le) :=
TRANSFORM
  self.did := (unsigned6)le.did;
  self.paw_count := 1;
END;

d_paw := project(paw.files().base.built(score>'003' and (unsigned)did<>0),from_paw(LEFT));

m := dedup(sort( 
		distribute(watercraft.file_base_search_prod((unsigned6)did<>0),hash(watercraft_key,state_origin)),
		watercraft_key,state_origin,did,local),watercraft_key,state_origin,did,local);
		
r from_m(m le) := transform
  self.did := (unsigned6) le.did;
  self.vess_count := 1;
  end;

ms := project(m,from_m(left));

pl := prof_licensev2.File_ProfLic_Base;

r from_pl(pl le) := transform
  self.did := (unsigned6)le.did;
  self.prof_count := 1;
  end;
  
pls := project(pl,from_pl(left));  

faaf := faa.file_airmen_data_out;

r from_faa(faaf le) := transform
  self.did := (unsigned6)le.did_out;
  self.faa_count := 1;
  end;

fas := project(faaf,from_faa(left));

fire := atf.file_firearms_explosives_base;

r from_fi(fire le) := transform
  self.did := (unsigned6)le.did_out;
  self.fire_count := 1;
  end;
  
fis := project(fire,from_fi(left));  

rel := header.File_Relatives_v3;

r from_r(rel le, unsigned1 cnt) := transform
  self.did := if(cnt=1,le.person1,le.person2);
  self.rel_count := 1;
  end;
  
rs := normalize(rel,2,from_r(left,counter));
  
r from_v(v_dedup le) := transform
  self.did := le.append_did;
  self.veh_cnt := 1;				   
  end;

vs := project(v_dedup,from_v(left));

d := driversv2.File_DL(source_code<>'CY');

r from_d(d le) := transform
  self.did := le.did;
  self.dl_cnt := 1;
  end;  
  
ds := project(d,from_d(left));

h := doxie_build.file_header_building; 

r from_h(h le) := transform
  self.head_cnt := 1;
  self.did := le.did;
  end;
  
hs := project(h,from_h(left));

c := doxie_files.File_Offenders;

r from_c(c le) := transform
  self.did := (unsigned6)le.did;
  self.crim_cnt := 1;
  end;

cs := project(c,from_c(left));

s := SexOffender.file_Main;

r from_s(s le) := transform
  self.did := (unsigned6)le.did;
  self.sex_cnt := 1;
  end;

ss := project(s,from_s(left));

e := doxie_files.File_CCW_KeyBase;

r from_e(e le) := transform
  self.did := (unsigned6)le.did_out;
  self.ccw_cnt := 1;
  end;

es := project(e,from_e(left));

bk := bankrupt.File_BK_Search;

r from_bk(bk le) := transform
  self.did := (unsigned6)le.debtor_did;
  self.bk_count := 1;
  end;

bks := project(bk,from_bk(left));

comb := (bks+hs+ds+vs+cs+ss+es+rs+fis+fas+pls+bs+ps+d_paw+bc+ms)(did<>0);

res_layout := record
  unsigned6 did := comb.did;
  unsigned2 sex_cnt := sum(group,comb.sex_cnt);
  unsigned2 crim_cnt := sum(group,comb.crim_cnt);
  unsigned2 ccw_cnt := sum(group,comb.ccw_cnt);
  unsigned2 head_cnt := sum(group,comb.head_cnt);
  unsigned2 veh_cnt := sum(group,comb.veh_cnt);
  unsigned2 dl_cnt := sum(group,comb.dl_cnt);
  unsigned2 rel_count := sum(group,comb.rel_count);
  unsigned2 fire_count := sum(group,comb.fire_count);
  unsigned2 faa_count := sum(group,comb.faa_count);
  unsigned2 vess_count := sum(group,comb.vess_count);
  unsigned2 prof_count := sum(group,comb.prof_count);
  unsigned2 bus_count := sum(group,comb.bus_count);
  unsigned2 prop_count := sum(group,comb.prop_count);
  unsigned2 bk_count := sum(group,comb.bk_count);
  unsigned2 prop_asses_count := sum(group,comb.prop_asses_count);
  unsigned2 prop_deeds_count := sum(group,comb.prop_deeds_count);
  unsigned2 paw_count := sum(group,comb.paw_count);
  unsigned2 bc_count := sum(group,comb.bc_count);
end;      
           

res := table(comb,res_layout,did);

#IF (PRTE2_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Header.constants.PRTE_BUILD_WARN_MSG);
export Lookups := dataset([],{res});
#ELSE
export Lookups := res : PERSIST('persist::lookups');
#END