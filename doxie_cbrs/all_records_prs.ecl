import doxie_crs,doxie,LN_PropertyV2_Services;

export all_records_prs(dataset(doxie_cbrs.layout_references) bdids, unsigned1 ofac_version = 1,
                                                             boolean include_ofac = false, real global_watchlist_threshold = 0.8
) := FUNCTION

//***** MY RECORDSETS
cntr := doxie_cbrs.count_records_prs(bdids, ofac_version, include_ofac, global_watchlist_threshold);
tarr := doxie_cbrs.best_records_prs_target(bdids);
hirr := doxie_cbrs.hierarchy_records;
idnr := doxie_cbrs.ID_Number_records(bdids);
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
abrr := doxie_cbrs.Associated_Business_records_prs_max(bdids);  
oaar := doxie_cbrs.others_at_address_records_max(bdids);
abbc := doxie_cbrs.Associated_Business_byContact_records_max(bdids);
conr := doxie_cbrs.contact_records_prs_max(bdids);
pror := doxie_cbrs.property_records_prs_byAddress_max(bdids);
// pro2r:= doxie_cbrs.property_records_v2; //removing at least for now as it is unused
idor := doxie_cbrs.Internet_Domains_records_max(bdids);
dnbr := doxie_cbrs.DNB_records_max(bdids);
rvlr := doxie_cbrs.reverse_lookup_records_prs_max(bdids);
ypar := doxie_cbrs.YellowPages_records_prs_max(bdids);
patr := doxie_cbrs.Patriot_records_max(ofac_version, include_ofac, global_watchlist_threshold);
plir := doxie_cbrs.proflic_records_prs_max(bdids);
bbbr := doxie_cbrs.BBB_records_prs_max(bdids);
bnmr := doxie_cbrs.BBB_NM_records_prs_max(bdids);
ebsr := if(not doxie.DataRestriction.EBR,doxie_cbrs.EBR_Summary_records_prs_max(bdids));
vehr := doxie_cbrs.motor_vehicle_records_prs_max(bdids);
cadr := doxie_cbrs.contact_address_records(bdids);

reccntr := recordof(cntr);
rectarr := recordof(tarr);
rechirr := recordof(hirr);
recidnr := recordof(idnr);
recnmvr := recordof(nmvr);
recbnkr := recordof(bnkr);
recbnk2r:= recordof(bnk2r);
recuccr := recordof(uccr);
recucc2r:= recordof(ucc2r);
recli2r := recordof(li2r);
reclier := recordof(lier);
recjudr := recordof(judr);
reccfir := recordof(cfir);
recbrer := recordof(brer);
recabrr := recordof(abrr); 
recoaar := recordof(oaar);
recabbc := recordof(abbc);
recconr := recordof(conr);
recpror := recordof(pror);
// recpro2r:= recordof(pro2r);
recidor := recordof(idor);
recdnbr := recordof(dnbr);
recrvlr := recordof(rvlr);
recypar := recordof(ypar);
recpatr := recordof(patr);
recplir := recordof(plir);
recbbbr := recordof(bbbr);
recbnmr := recordof(bnmr);
recebsr := recordof(ebsr);
recvehr := recordof(vehr);
reccadr := recordof(cadr);

//***** THE COMBINED LAYOUT
rec := record, maxlength(doxie_crs.maxlength_report)
	dataset(reccntr) count_children;
	dataset(rectarr) target_children;
	dataset(rechirr) hierarchy_children;
	dataset(recidnr) ID_number_children;
	dataset(recnmvr) name_variation_children;
	dataset(recbnkr) bankruptcy_children;
	dataset(recbnk2r) bankruptcy_v2_children;
	dataset(recuccr) ucc_children;
	dataset(recucc2r) ucc_v2_children;
	dataset(recli2r) liens_v2_children;
	dataset(reclier) Liens_children;
	dataset(recjudr) Judgements_children;
	dataset(reccfir) Corporation_Filings_children;
	dataset(recbrer) business_registration_children;
	dataset(recabrr) Associated_Business_children;
	dataset(recoaar) others_at_address_children;
	dataset(recabbc) Associated_ByContact_children;
	dataset(recconr) contact_children;
	dataset(recpror) property_children;
	// dataset(recpro2r) property2_children;
	dataset(recidor) Internet_Domains_children;
	dataset(recdnbr) DNB_children;
	dataset(recrvlr) reverse_lookup_children;
	dataset(recypar) yellow_page_children;
	dataset(recpatr) patriot_children;
	dataset(recplir) professional_license_children;
	dataset(recbbbr) bbb_children;
	dataset(recbnmr) bbb_nonmember_children;
	dataset(recebsr) ebr_summary_children;
	dataset(recvehr) vehicle_children;
	dataset(reccadr) contact_address_children;
end;


//***** PROJECT THEM IN
nada := dataset([0], {unsigned1 a});

rec getall(nada l) := transform
	self.count_children := cntr;
	self.target_children := tarr;
	self.hierarchy_children := hirr;
	self.ID_number_children := idnr;
	self.name_variation_children := nmvr;
	self.bankruptcy_children := bnkr;
	self.bankruptcy_v2_children := bnk2r;
	self.ucc_children := uccr;
	self.ucc_v2_children := ucc2r;
	self.liens_v2_children := li2r;
	self.Liens_children := lier;
	self.Judgements_children := judr;
	self.Corporation_Filings_children := cfir;
	self.business_registration_children := brer;
	self.Associated_Business_children := abrr;
	self.others_at_address_children := oaar;
	self.Associated_ByContact_children := abbc;
	self.contact_children := conr;
	self.property_children := pror;
	// self.property2_children := pro2r;
	self.Internet_Domains_children := idor;
	self.DNB_children := dnbr;
	self.reverse_lookup_children := rvlr;
	self.yellow_page_children := ypar;
	self.patriot_children := patr;
	self.professional_license_children := plir;
	self.bbb_children := bbbr;
	self.bbb_nonmember_children := bnmr;
	self.ebr_summary_children := ebsr;
	self.vehicle_children := vehr;
	self.contact_address_children := cadr;
	self := [];
end;

return project(nada, getall(left));
END;
