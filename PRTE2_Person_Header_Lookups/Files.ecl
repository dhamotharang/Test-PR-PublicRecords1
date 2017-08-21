
Import Data_Services, header, doxie, prte2_Corp, prte2_phonesplus, prte2_lnproperty,phonesplus,
       doxie_files, doxie_build,  ut,prte2_bankruptcy, prte2_lnproperty, business_header,
       PRTE2_Header, prte2_paw, prte2_watercraft, prte2_dlv2,  prte2_prof_licensev2, prte2_faa
			 ,prte2_atf, prte2_doc, prte2_sexoffender, prte2_emergeskeys, prte2_bankruptcy, prte2_vehicle
			 ,Business_HeaderV2 ;;

EXPORT files := module
	
	ca := distribute(PRTE2_CORP.Files.DS_cont_Direct(ut.TitleRank(cont_type_desc) <= 6 and did!=0),hash(corp_key));

	Layouts.r_layout from_ca(ca le) := transform
		self.did := le.did;
		self.corp_affil_count := 1;
	end;
		
	cas := project(dedup(sort(ca,corp_key,did,local),corp_key,did,local),from_ca(left));

	pr1 := PRTE2_LNProperty.Files.file_search_building_did_out;

	pr := dedup(sort(distribute(pr1,hash(ln_fares_id)),ln_fares_id,local),ln_fares_id,local);

	Layouts.r_layout from_propn(pr le) := transform
		self.did := (unsigned6)le.did;
		self.nonfares_prop_count := IF(le.ln_fares_id[1] <>'R',1,0);
		self.nofares_prop_asses_count := IF(le.ln_fares_id[2] = 'A' AND le.ln_fares_id[1] <>'R', 1, 0);
		self.nofares_prop_deeds_count := IF(le.ln_fares_id[2] = 'D' AND le.ln_fares_id[1] <>'R', 1, 0);
	end;
		
	ps := project(pr,from_propn(left));  

	pp := PRTE2_PhonesPlus.Files.fphonesplus_did(phonesplus.IsCellSource(vendor),(unsigned)CellPhone<>0);

	Layouts.r_layout from_pp(pp le) := transform
		self.did := le.did;
		self.phonesplus_count := 1;
	end;

	pps := project(pp,from_pp(left));
////////////////
			 

prop :=  prte2_lnproperty.files.file_search_building_did_out;// ln_propertyv2.File_Search_DID;

Layouts.r_layout from_prop(prop le) := transform
  self.did := (unsigned6)le.did;
  self.prop_count := 1;
  self.prop_asses_count := IF(le.ln_fares_id[2] = 'A', 1, 0);
  self.prop_deeds_count := IF(le.ln_fares_id[2] = 'D', 1, 0);
  end;
  
props := project(prop,from_prop(left));  
  
b := dataset([],business_header.Layout_Business_Contact_Plus); //business_header.File_Business_Contacts_Plus;

Layouts.r_layout from_b(b le) := transform
  self.did := le.did;
  self.bus_count := 1;
  end;
  
bs := project(b,from_b(left));

Layouts.r_layout from_bc(recordof(business_header.Files().Out.Contacts.qa) le) :=
TRANSFORM
  self.did := (unsigned6)le.did;
  self.bc_count := 1;
END;

bc := project(dataset([],Business_HeaderV2.Layouts.out.Business_Contacts)((unsigned)did<>0),from_bc(LEFT));//business_header.Files().Out.Contacts.qa

Layouts.r_layout from_paw(recordof(prte2_paw.files.file_Employment_Out) le) :=
TRANSFORM
  self.did := (unsigned6)le.did;
  self.paw_count := 1;
END;

d_paw := project(prte2_paw.files.file_Employment_Out(score>'003' and (unsigned)did<>0),from_paw(LEFT));

m := dedup(sort( 
		distribute(prte2_watercraft.files.Search((unsigned6)did<>0),hash(watercraft_key,state_origin)),
		watercraft_key,state_origin,did,local),watercraft_key,state_origin,did,local);
		
Layouts.r_layout from_m(m le) := transform
  self.did := (unsigned6) le.did;
  self.vess_count := 1;
  end;

ms := project(m,from_m(left));

pl := prte2_prof_licensev2.files.DS_File_prolicv2_Base2;

Layouts.r_layout from_pl(pl le) := transform
  self.did := (unsigned6)le.did;
  self.prof_count := 1;
  end;
  
pls := project(pl,from_pl(left));  

faaf := prte2_faa.files.raw_airmen;//faa.file_airmen_data_out;

Layouts.r_layout from_faa(faaf le) := transform
  self.did := (unsigned6)le.did_out;
  self.faa_count := 1;
  end;

fas := project(faaf,from_faa(left));

fire := prte2_atf.files.Base_out;// atf.file_firearms_explosives_base;

Layouts.r_layout from_fi(fire le) := transform
  self.did := (unsigned6)le.did_out;
  self.fire_count := 1;
  end;
  
fis := project(fire,from_fi(left));  

rel := dataset([],header.layout_relatives);//header.File_Relatives;

Layouts.r_layout from_r(rel le, unsigned1 cnt) := transform
  self.did := if(cnt=1,le.person1,le.person2);
  self.rel_count := 1;
  end;
  
rs := normalize(rel,2,from_r(left,counter));
  
v := prte2_vehicle.files.party_building(history='' and append_did <> 0);//  vehiclev2.file_vehicleV2_party

v_dedup := dedup(v, vehicle_key,append_did, all); 

Layouts.r_layout from_v(v_dedup le) := transform
  self.did := le.append_did;
  self.veh_cnt := 1;				   
  end;

vs := project(v_dedup,from_v(left));

d :=  prte2_dlv2.files.dl2_dl_number(source_code<>'CY');//driversv2.File_DL

Layouts.r_layout from_d(d le) := transform
  self.did := le.did;
  self.dl_cnt := 1;
  end;  
  
ds := project(d,from_d(left));

h := doxie_build.file_header_building; 

Layouts.r_layout from_h(h le) := transform
  self.head_cnt := 1;
  self.did := le.did;
  end;
  
hs := project(h,from_h(left));

c := prte2_doc.files.file_offenders_keybuilding;// doxie_files.File_Offenders;

Layouts.r_layout from_c(c le) := transform
  self.did := (unsigned6)le.did;
  self.crim_cnt := 1;
  end;
cs := project(c,from_c(left));

s := prte2_sexoffender.files.SexOffender_base;//  SexOffender.file_Main;

Layouts.r_layout from_s(s le) := transform
  self.did := (unsigned6)le.did;
  self.sex_cnt := 1;
  end;
ss := project(s,from_s(left));
	
e := prte2_emergesKeys.files.DS_CCW_Out;// doxie_files.File_CCW_KeyBase;
Layouts.r_layout from_e(e le) := transform
  self.did := (unsigned6)le.did_out;
  self.ccw_cnt := 1;
  end;

es := project(e,from_e(left));

bk := prte2_bankruptcy.files.Search_Base;// bankrupt.File_BK_Search;

Layouts.r_layout from_bk(bk le) := transform
  self.did := (unsigned6)le.did;//debtor_did
  self.bk_count := 1;
  end;

bks := project(bk,from_bk(left));

	comb := (cas + pps + ps +
						bks+hs+ds+vs+cs+ss+es+rs+fis+fas+pls+bs+props+d_paw+bc+ms)(did<>0);
	
	res_layout := record
		unsigned6 did := comb.did;
		unsigned2 corp_affil_count := sum(group,comb.corp_affil_count);
		unsigned2 phonesplus_count := sum(group,comb.phonesplus_count);
		unsigned2 nonfares_prop_count := sum(group,comb.nonfares_prop_count);
		unsigned2 nofares_prop_asses_count := sum(group,comb.nofares_prop_asses_count);
		unsigned2 nofares_prop_deeds_count := sum(group,comb.nofares_prop_deeds_count);
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
		unsigned2 filler5_count := 0;
		unsigned2 filler6_count := 0;
		unsigned2 filler7_count := 0;
		unsigned2 filler8_count := 0;
		unsigned2 filler9_count := 0;
		unsigned2 filler10_count := 0;
	end;      
			 
	shared lookups_v2 := table(comb,res_layout,did);

	res2 := Header.LivingSituation;

	resrec := record
		lookups_v2;
		unsigned6 hhid;
		string1   gender;
		unsigned2 house_size;
		unsigned2 sg_within_7;
		unsigned2 dg_within_7;
		unsigned2 ug_within_7;
		unsigned2 sg_y_8_15;
		unsigned2 dg_y_8_15;
		unsigned2 ug_y_8_15;
		unsigned2 sg_y_16_30;
		unsigned2 dg_y_16_30;
		unsigned2 ug_y_16_30;
		unsigned2 sg_o_8_15;
		unsigned2 dg_o_8_15;
		unsigned2 ug_o_8_15;
		unsigned2 sg_o_16_30;
		unsigned2 dg_o_16_30;
		unsigned2 ug_o_16_30;
		unsigned2 sg_o_30;
		unsigned2 dg_o_30;
		unsigned2 ug_o_30;
		unsigned2 sg_y_30;
		unsigned2 dg_y_30;
		unsigned2 ug_y_30;
		unsigned2 sg;
		unsigned2 dg;
		unsigned2 ug;
		unsigned2	kids;
		unsigned2	parents;
	end;

	Layouts.full_rec into(lookups_v2 L, Header.LivingSituation R) := transform
		self.did := if (l.did != 0, L.did, r.did);
		self := l;
		self := R;
	end;

	res := join(lookups_v2,Header.LivingSituation,left.did = right.did,into(Left,right),full outer,hash);

	export File_Did_Lookups_v2 := res;

END;