import doxie_raw;

export source_counts(DATASET(Doxie_Raw.Layout_crs_raw) srcChildren) := FUNCTION

p := TABLE(srcChildren, record
	unsigned2 death_cnt := sum(group,count(death_child)); 
  unsigned2 atf_cnt := sum(group,count(atf_child));
  unsigned2 bk_cnt := sum(group,count(bk_child)); 
  unsigned2 bkv2_cnt := sum(group,count(bk_V2_child)); 
  unsigned2 lien_cnt := sum(group,count(lien_child)); 
  unsigned2 lienv2_cnt := sum(group,count(lien_v2_child)); 
  unsigned2 dl_cnt := sum(group,count(dl_child)); 
  unsigned2 dl2_cnt := sum(group,count(dl2_child)); 
  unsigned2 proflic_cnt := sum(group,count(proflic_child)); 
  unsigned2 sanc_cnt := sum(group,count(sanc_child)); 
  unsigned2 prov_cnt := sum(group,count(prov_child)); 
  unsigned2 veh_cnt := sum(group,count(veh_child)); 
  unsigned2 vehv2_cnt := sum(group,count(veh_v2_child)); 
  unsigned2 dea_cnt := sum(group,count(dea_child));
  unsigned2 airc_cnt := sum(group,count(airc_child));
  unsigned2 pilot_cnt := sum(group,count(pilot_child));
	unsigned2 pilotCert_cnt := 0; //sum(group,count(pilotCert_child));
  unsigned2 watercraft_cnt := sum(group,count(watercraft_child));
	unsigned2 ucc_cnt := 0; //sum(group,count(ucc_child));
	unsigned2 uccv2_cnt := 0; //sum(group,count(ucc_v2_child));
	unsigned2 corpAffil_cnt := 0; //sum(group,count(corpAffil_child));
	unsigned2 voter_cnt := 0; // no corresponding child dataset in doxie_raw.layout_crs_raw ???
	unsigned2 voterv2_cnt := sum(group,count(voters_v2_child));
	unsigned2 ccw_cnt := 0; // no corresponding child dataset in doxie_raw.layout_crs_raw???
	unsigned2 hunt_cnt := 0; // no corresponding child dataset in doxie_raw.layout_crs_raw ???
	unsigned2 whoIs_cnt := 0; //sum(group,count(whoIs_child));
	unsigned2 phone_cnt := 0; //sum(group,count(phone_child));
	unsigned2 flcrash_cnt := 0; // are these even supposed to display ???
	unsigned2 DOC_Cnt := 0; // are these even supposed to display ???
	unsigned2 SO_Cnt := 0; // are these even supposed to display ???
  unsigned2 ak_cnt := sum(group,count(ak_child));
  unsigned2 emerge_cnt := sum(group,count(emerge_child));
  unsigned2 mswork_cnt := sum(group,count(mswork_child));
  unsigned2 util_cnt := sum(group,count(util_child));
  unsigned2 eq_cnt := sum(group,count(eq_child));
  unsigned2 en_cnt := sum(group,count(en_child));
  unsigned2 boater_cnt := sum(group,count(boater_child));
  unsigned2 deed_cnt := sum(group,count(deed_child));
  unsigned2 deedv2_cnt := sum(group,count(deed2_child));
  unsigned2 assessment_cnt := sum(group,count(assessor_child));
  unsigned2 assessmentv2_cnt := sum(group,count(assessor2_child));
  unsigned2 for_cnt := sum(group,count(for_child));
  unsigned2 nod_cnt := sum(group,count(nod_child));
  unsigned2 tu_cnt := sum(group,count(tu_child));
  unsigned2 tn_cnt := sum(group,count(tn_child));
  unsigned2 finder_cnt := sum(group,count(finder_child));
  unsigned2 busHeader_cnt := sum(group,count(BusHdr_child));
  unsigned2 busHeaderLinkIds_cnt := sum(group, count(BusHdrLinkIds_child));	
  unsigned2 targ_cnt := sum(group,count(targ_child));
  unsigned2 fbnv2_cnt := sum(group,count(fbnv2_child));
end);

RETURN p;
END;
