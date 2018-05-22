import data_services,driversv2, LiensV2, eMerges, Marriage_Divorce_V2, Corp2, UCCV2, header, atf, faa, prof_licensev2, doxie, RoxieKeyBuild, relationship,
       business_header, BankruptcyV2, doxie_files, doxie_build, SexOffender, watercraft, ut,
       ln_propertyv2, vehicleV2, paw, PRTE2_Header, mdr, d2c, Phonesplus_v2, Email_Data, American_student_list, tools, VersionControl;

//----------No glb and dppa sources---------------------//
export Key_Prep_D2C_lookup() := function

//-------Addresses_cnt-------// 
 h := doxie_build.file_header_building(~MDR.sourceTools.SourceIsGLB(src), ~MDR.sourceTools.SourceIsDPPA(src), did > 0, src not in D2C.Constants.PersonHeaderRestrictedSources); 
 
 doxie_build.Layout_D2C_Lookup from_h(h le) := transform
  self.did := le.did;
  self.Addresses_cnt := 1;
  end;  
 hs := project(h,from_h(left));

//-------PhonesPlus_cnt-------//
 // ph := Phonesplus_v2.File_Phonesplus_Base(did > 0, (unsigned)cellphone > 0, vendor not in D2C.Constants.PhonesPlusRestrictedSources);
 
 f_phonesplus := Phonesplus_v2.File_phonesplus_base(did > 0, current_rec);
 ut.mac_suppress_by_phonetype(f_phonesplus,cellphone,state,_fphonesplus_cell,true,did);
 _keybuild_phonesplus_base := f_phonesplus(cellphone<>'');
 ph := _keybuild_phonesplus_base(vendor not in D2C.Constants.PhonesPlusRestrictedSources);

 doxie_build.Layout_D2C_Lookup from_ph(ph le) := transform
  self.did := le.did;
  self.PhonesPlus_cnt := 1;
  end;
 phs := project(ph,from_ph(left));

//-------Email_cnt-------//
 em	 := Email_Data.Key_Did(did > 0, email_src not in D2C.Constants.EmailRestrictedSources);
  
 doxie_build.Layout_D2C_Lookup from_em(em le) := transform
  self.did := le.did;
  self.Email_cnt := 1;
  end;
 ems := project(em,from_em(left));

//----------Education_Student_cnt---------------//
 st := American_student_list.File_American_Student_DID_v2(did <> 0);

 doxie_build.Layout_D2C_Lookup from_st(st le) := transform
  self.did := le.did;
  self.Education_Student_cnt := 1;
  end;  
 sts := project(st,from_st(left));

//-------Possible_Relatives_and_Associates_cnt-------//
 D2C_dids:=dedup(h,did,all);

 file_relativesv3:=dataset('~thor_data400::base::insuranceheader::qa::relatives_v3',relationship.layout_output.titled,flat);
 rel:=distribute(file_relativesv3(not(confidence IN ['NOISE','LOW'])),hash(did1));

 D2C_rel := join(rel, D2C_dids,left.did1 = right.did);

 doxie_build.Layout_D2C_Lookup from_r(D2C_rel le) := transform
  self.did := le.did;
  self.Possible_Relatives_and_Associates_cnt := 1;
  end;  
 rs := project(D2C_rel,from_r(left));
 
//----------Possible_Properties_owned_cnt---------------//
 // pr := ln_propertyv2.File_Search_DID(did > 0);
 pr := LN_PropertyV2.key_ownership_did(false)(did > 0);

 doxie_build.Layout_D2C_Lookup from_prop(pr le) := transform
  self.did := (unsigned6)le.did;
  self.Possible_Properties_owned_cnt := 1;
 end;  
 ps := project(pr,from_prop(left));
  
//-------Criminal_Records_cnt-------//  
 c := doxie_files.File_Offenders((unsigned6)did > 0, data_type not in D2C.Constants.DOCRestrictedDataTypes, vendor not in D2C.Constants.DOCRestrictedVendors);

 doxie_build.Layout_D2C_Lookup from_c(c le) := transform
  self.did := (unsigned6)le.did;
  self.Criminal_Records_cnt := 1;
  end;
 cs := project(c,from_c(left));

//-------Sexual_Offenses_cnt-------// 
 s := SexOffender.Key_SexOffender_DID(false)(did > 0);//Unrestricted

 doxie_build.Layout_D2C_Lookup from_s(s le) := transform
  self.did := (unsigned6)le.did;
  self.Sexual_Offenses_cnt := 1;
  end;
 ss := project(s,from_s(left));

//-------Liens_and_Judgements_cnt-------// 
 l := LiensV2.key_liens_DID(did > 0);//Unrestricted

 doxie_build.Layout_D2C_Lookup from_l(l le) := transform
  self.did := le.did;
  self.Liens_and_Judgements_cnt := 1;
  end;
 ls := project(l,from_l(left));

//-------Bankruptcies_cnt-------//
 bk := BankruptcyV2.key_bankruptcy_did(false)(did > 0); //Unrestricted

 doxie_build.Layout_D2C_Lookup from_bk(bk le) := transform
  self.did := le.did;
  self.Bankruptcies_cnt := 1;
  end;
 bks := project(bk,from_bk(left));

//-------Marriage_and_Divorce_cnt-------//
 md := Marriage_Divorce_V2.key_mar_div_did(false)(did > 0);

 doxie_build.Layout_D2C_Lookup from_md(md le) := transform
  self.did := (unsigned6)le.did;
  self.Marriage_and_Divorce_cnt := 1;
  end;
 mds := project(md,from_md(left));

//----------Professional_Licenses_cnt---------------//
 pl := prof_licensev2.File_ProfLic_Base((unsigned6)did > 0);//Unrestricted

 doxie_build.Layout_D2C_Lookup from_pl(pl le) := transform
				self.did := (unsigned6)le.did;
				self.Professional_Licenses_cnt := 1;
			end;  
 pls := project(pl,from_pl(left));

//----------People_at_Work_possible_employment_records_cnt---------------//
 paw := paw.files().base.built((unsigned)did > 0, score>'003');

 doxie_build.Layout_D2C_Lookup from_paw(paw le) :=
					TRANSFORM
						self.did := (unsigned6)le.did;
						self.People_at_Work_possible_employment_records_cnt := 1;
					END;
 paws := project(paw,from_paw(LEFT));
 
//----------Businesses_records_cnt---------------//
 b := Business_Header.Key_Business_Contacts_DID(did > 0);

 doxie_build.Layout_D2C_Lookup from_b(b le) := transform
  self.did := le.did;
  self.Businesses_records_cnt := 1;
  end;  
 bs := project(b,from_b(left));

//----------Corporate_affiliations_cnt---------------//
 crp := Corp2.Key_cont_did(did <> 0);
 
 doxie_build.Layout_D2C_Lookup from_crp(crp le) := transform
  self.did := le.did;
  self.Corporate_affiliations_cnt := 1;
  end;
	
 crps := project(crp,from_crp(left));
 
 //-------UCC_cnt-------//
 uc	 := UCCV2.File_UCC_Party_Base(did <> 0);
 
 doxie_build.Layout_D2C_Lookup from_uc(uc le) := transform
  self.did := le.did;
  self.UCC_cnt := 1;
  end;
 ucs := project(uc,from_uc(left)); 
 
 //-------Hunting_and_Fishing_Permits_cnt-------//
 hf	 := eMerges.file_hunters_out((unsigned6)did_out > 0, Source_Code not in D2C.Constants.CCWRestrictedSources);
 
 doxie_build.Layout_D2C_Lookup from_hf(hf le) := transform
  self.did := (unsigned6)le.did_out;
  self.Hunting_and_Fishing_Permits_cnt := 1;
  end;
 hfs := project(hf,from_hf(left)); 

//-------Concealed_Weapon_Permits_cnt-------//
 cw	 := eMerges.file_ccw_base((unsigned6)did_out > 0, Source_Code not in D2C.Constants.CCWRestrictedSources);
 
 doxie_build.Layout_D2C_Lookup from_cw(cw le) := transform
  self.did := (unsigned6)le.did_out;
  self.Concealed_Weapon_Permits_cnt := 1;
  end;
 cws := project(cw,from_cw(left)); 

//----------Firearms_and_Explosives_cnt---------------//
 fire := atf.file_firearms_explosives_base((unsigned6)did_out > 0);

 doxie_build.Layout_D2C_Lookup from_fi(fire le) := transform
  self.did := (unsigned6)le.did_out;
  self.Firearms_and_Explosives_cnt := 1;
  end;  
 fis := project(fire,from_fi(left));  
  
//----------Aircraft registrations from the FAA(FAA_Aircraft_cnt)---------------//
 ac := faa.file_aircraft_registration_out((unsigned6)did_out > 0);

 doxie_build.Layout_D2C_Lookup from_ac(ac le) := transform
  self.did := (unsigned6)le.did_out;
  self.FAA_Aircraft_cnt := 1;
  end;
 acs := project(ac, from_ac(left));  

//----------Pilot license info from the FAA(FAA_Pilot_cnt)---------------//
 am := faa.file_airmen_data_out((unsigned6)did_out > 0);
 
 doxie_build.Layout_D2C_Lookup from_am(am le) := transform
  self.did := (unsigned6)le.did_out;
  self.FAA_Pilot_cnt := 1;
  end;
 ams := project(am,from_am(left));

 comb := (hs+phs+ems+sts+rs+ps+cs+ss+ls+bks+mds+pls+paws+bs+crps+ucs+hfs+cws+fis+acs+ams)(did <> 0);

 res_layout := record
  unsigned6 did := comb.did;
	 unsigned2 Addresses_cnt := sum(group,comb.Addresses_cnt);
  unsigned2 PhonesPlus_cnt := sum(group,comb.PhonesPlus_cnt);
  unsigned2 Email_cnt := sum(group,comb.Email_cnt);
	 unsigned2 Education_Student_cnt := sum(group,comb.Education_Student_cnt);
	 unsigned2 Possible_Relatives_and_Associates_cnt := sum(group,comb.Possible_Relatives_and_Associates_cnt);
	 unsigned2 Possible_Properties_owned_cnt := sum(group,comb.Possible_Properties_owned_cnt);
	 unsigned2 Criminal_Records_cnt := sum(group,comb.Criminal_Records_cnt);
  unsigned2 Sexual_Offenses_cnt := sum(group,comb.Sexual_Offenses_cnt);
  unsigned2 Liens_and_Judgements_cnt := sum(group,comb.Liens_and_Judgements_cnt);
	 unsigned2 Bankruptcies_cnt := sum(group,comb.Bankruptcies_cnt);
  unsigned2 Marriage_and_Divorce_cnt := sum(group,comb.Marriage_and_Divorce_cnt);
	 unsigned2 Professional_Licenses_cnt := sum(group,comb.Professional_Licenses_cnt);	
	 unsigned2 People_at_Work_possible_employment_records_cnt := sum(group,comb.People_at_Work_possible_employment_records_cnt);
  unsigned2 Businesses_records_cnt := sum(group,comb.Businesses_records_cnt);
	 unsigned2 Corporate_affiliations_cnt := sum(group,comb.Corporate_affiliations_cnt);
	 unsigned2 UCC_cnt := sum(group,comb.UCC_cnt);
	 unsigned2 Hunting_and_Fishing_Permits_cnt := sum(group,comb.Hunting_and_Fishing_Permits_cnt);
	 unsigned2 Concealed_Weapon_Permits_cnt := sum(group,comb.Concealed_Weapon_Permits_cnt);  
	 unsigned2 Firearms_and_Explosives_cnt := sum(group,comb.Firearms_and_Explosives_cnt);
	 unsigned2 FAA_Aircraft_cnt := sum(group,comb.FAA_Aircraft_cnt);
  unsigned2 FAA_Pilot_cnt := sum(group,comb.FAA_Pilot_cnt);
	end;

#IF (PRTE2_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Header.constants.PRTE_BUILD_WARN_MSG);
 res := dataset([],res_layout);
 return index(res,{did},{res},data_services.data_location.Prefix()+'prte::key::D2C_lookups_' + doxie.Version_SuperKey);
#ELSE
 res := table(comb,res_layout,did,few,merge);
 return index(res,{did},{res},data_services.data_location.Prefix()+'thor_data400::key::D2C_lookups_' + doxie.Version_SuperKey);
#END

end;
