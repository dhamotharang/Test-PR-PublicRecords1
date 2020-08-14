IMPORT doxie,doxie_cbrs,doxie_crs;

EXPORT all_records_prs(DATASET(doxie_cbrs.layout_references) bdids,
                                                             doxie.IDataAccess mod_access,
                                                             UNSIGNED1 ofac_version = 1,
                                                             BOOLEAN include_ofac = FALSE,
                                                             REAL global_watchlist_threshold = 0.8
                                                             
) := FUNCTION

//***** MY RECORDSETS
cntr := doxie_cbrs.count_records_prs(bdids, mod_access, ofac_version, include_ofac, global_watchlist_threshold);
tarr := doxie_cbrs.best_records_prs_target(bdids,mod_access);
hirr := doxie_cbrs.hierarchy_records;
idnr := doxie_cbrs.ID_Number_records(bdids,mod_access);
nmvr := doxie_cbrs.name_variation_records_max(bdids);
bnkr := doxie_cbrs.bankruptcy_records_prs_max(bdids);
bnk2r := doxie_cbrs.bankruptcy_v2_records_prs_max(bdids);
uccr := doxie_cbrs.UCC_Records_prs_max(bdids);
ucc2r := doxie_cbrs.UCC_v2_Records_prs_max(bdids);
li2r := doxie_cbrs.liens_v2_records_prs_max(bdids);
lier := doxie_cbrs.lien_records_prs_max(bdids);
judr := doxie_cbrs.Judgement_records_prs_max(bdids);
cfir := doxie_cbrs.Corporation_Filings_records_prs_max(bdids);
brer := doxie_cbrs.business_registration_records_prs_max(bdids).records;
abrr := doxie_cbrs.Associated_Business_records_prs_max(bdids,mod_access);
oaar := doxie_cbrs.others_at_address_records_max(bdids);
abbc := doxie_cbrs.Associated_Business_byContact_records_max(bdids);
conr := doxie_cbrs.contact_records_prs_max(bdids);
pror := doxie_cbrs.property_records_prs_byAddress_max(bdids);
// pro2r:= doxie_cbrs.property_records_v2; //removing at least for now as it is unused
idor := doxie_cbrs.Internet_Domains_records_max(bdids);
dnbr := doxie_cbrs.DNB_records_max(bdids, mod_access);
rvlr := doxie_cbrs.reverse_lookup_records_prs_max(bdids,mod_access);
ypar := doxie_cbrs.YellowPages_records_prs_max(bdids);
patr := doxie_cbrs.Patriot_records_max(ofac_version, include_ofac, global_watchlist_threshold);
plir := doxie_cbrs.proflic_records_prs_max(bdids,mod_access);
bbbr := doxie_cbrs.BBB_records_prs_max(bdids);
bnmr := doxie_cbrs.BBB_NM_records_prs_max(bdids);
ebsr := IF(NOT doxie.DataRestriction.EBR,doxie_cbrs.EBR_Summary_records_prs_max(bdids));
vehr := doxie_cbrs.motor_vehicle_records_prs_max(bdids,mod_access);
cadr := doxie_cbrs.contact_address_records(bdids);

reccntr := RECORDOF(cntr);
rectarr := RECORDOF(tarr);
rechirr := RECORDOF(hirr);
recidnr := RECORDOF(idnr);
recnmvr := RECORDOF(nmvr);
recbnkr := RECORDOF(bnkr);
recbnk2r:= RECORDOF(bnk2r);
recuccr := RECORDOF(uccr);
recucc2r:= RECORDOF(ucc2r);
recli2r := RECORDOF(li2r);
reclier := RECORDOF(lier);
recjudr := RECORDOF(judr);
reccfir := RECORDOF(cfir);
recbrer := RECORDOF(brer);
recabrr := RECORDOF(abrr);
recoaar := RECORDOF(oaar);
recabbc := RECORDOF(abbc);
recconr := RECORDOF(conr);
recpror := RECORDOF(pror);
// recpro2r:= recordof(pro2r);
recidor := RECORDOF(idor);
recdnbr := RECORDOF(dnbr);
recrvlr := RECORDOF(rvlr);
recypar := RECORDOF(ypar);
recpatr := RECORDOF(patr);
recplir := RECORDOF(plir);
recbbbr := RECORDOF(bbbr);
recbnmr := RECORDOF(bnmr);
recebsr := RECORDOF(ebsr);
recvehr := RECORDOF(vehr);
reccadr := RECORDOF(cadr);

//***** THE COMBINED LAYOUT
rec := RECORD, MAXLENGTH(doxie_crs.maxlength_report)
  DATASET(reccntr) count_children;
  DATASET(rectarr) target_children;
  DATASET(rechirr) hierarchy_children;
  DATASET(recidnr) ID_number_children;
  DATASET(recnmvr) name_variation_children;
  DATASET(recbnkr) bankruptcy_children;
  DATASET(recbnk2r) bankruptcy_v2_children;
  DATASET(recuccr) ucc_children;
  DATASET(recucc2r) ucc_v2_children;
  DATASET(recli2r) liens_v2_children;
  DATASET(reclier) Liens_children;
  DATASET(recjudr) Judgements_children;
  DATASET(reccfir) Corporation_Filings_children;
  DATASET(recbrer) business_registration_children;
  DATASET(recabrr) Associated_Business_children;
  DATASET(recoaar) others_at_address_children;
  DATASET(recabbc) Associated_ByContact_children;
  DATASET(recconr) contact_children;
  DATASET(recpror) property_children;
  // dataset(recpro2r) property2_children;
  DATASET(recidor) Internet_Domains_children;
  DATASET(recdnbr) DNB_children;
  DATASET(recrvlr) reverse_lookup_children;
  DATASET(recypar) yellow_page_children;
  DATASET(recpatr) patriot_children;
  DATASET(recplir) professional_license_children;
  DATASET(recbbbr) bbb_children;
  DATASET(recbnmr) bbb_nonmember_children;
  DATASET(recebsr) ebr_summary_children;
  DATASET(recvehr) vehicle_children;
  DATASET(reccadr) contact_address_children;
END;


//***** PROJECT THEM IN
nada := DATASET([0], {UNSIGNED1 a});

rec getall(nada l) := TRANSFORM
  SELF.count_children := cntr;
  SELF.target_children := tarr;
  SELF.hierarchy_children := hirr;
  SELF.ID_number_children := idnr;
  SELF.name_variation_children := nmvr;
  SELF.bankruptcy_children := bnkr;
  SELF.bankruptcy_v2_children := bnk2r;
  SELF.ucc_children := uccr;
  SELF.ucc_v2_children := ucc2r;
  SELF.liens_v2_children := li2r;
  SELF.Liens_children := lier;
  SELF.Judgements_children := judr;
  SELF.Corporation_Filings_children := cfir;
  SELF.business_registration_children := brer;
  SELF.Associated_Business_children := abrr;
  SELF.others_at_address_children := oaar;
  SELF.Associated_ByContact_children := abbc;
  SELF.contact_children := conr;
  SELF.property_children := pror;
  // self.property2_children := pro2r;
  SELF.Internet_Domains_children := idor;
  SELF.DNB_children := dnbr;
  SELF.reverse_lookup_children := rvlr;
  SELF.yellow_page_children := ypar;
  SELF.patriot_children := patr;
  SELF.professional_license_children := plir;
  SELF.bbb_children := bbbr;
  SELF.bbb_nonmember_children := bnmr;
  SELF.ebr_summary_children := ebsr;
  SELF.vehicle_children := vehr;
  SELF.contact_address_children := cadr;
  SELF := [];
END;

RETURN PROJECT(nada, getall(LEFT));
END;
