import doxie, Doxie_Raw, ut, STD;

todays_date := (string)STD.Date.Today();

export Prov_records(dataset(doxie.layout_references) in_dids) := function

doxie.MAC_Selection_Declare()

boolean Include_GroupAffiliations := false : stored('IncludeGroupAffiliations');
boolean Include_HospitalAffiliations := false : stored('IncludeHospitalAffiliations');
boolean Include_Education := false : stored('IncludeEducation');
boolean Include_BusinessAddress := false : stored('IncludeBusinessAddress');
Include_GroupAffiliations_val := Include_Them_All or Include_GroupAffiliations;
Include_HospitalAffiliations_val := Include_Them_All or Include_HospitalAffiliations;
Include_Education_val := Include_Them_All or Include_Education;
Include_BusinessAddress_val := Include_Them_All or Include_BusinessAddress;

prov_rec := doxie.ING_provider_report_recordsbyDid(in_dids);

layout_prov := doxie.ingenix_provider_module.layout_ingenix_provider_report;
layout_prov set_prov(prov_rec l) := transform
  self.business_address := if(Include_BusinessAddress_val, l.business_address);
  self.specialty := sort(dedup(sort(l.specialty, specialtyid), specialtyid),specialtytiertypeid);
  self.group_affiliation := if (Include_GroupAffiliations_val, l.group_affiliation);
  self.hospital_affiliation := if(Include_HospitalAffiliations_val, l.hospital_affiliation);
  self.degree := if(Include_Education_val, l.degree);
  self.residency := if(Include_Education_val, l.residency);
  self.medschool := if(Include_Education_val, l.medschool);
  prov_active := l.license(Termination_Date > todays_date);
  prov_inactive := l.license(Termination_Date <= todays_date);
  doxie_raw.MAC_ENTRP_CLEAN(prov_inactive,Termination_Date,prov_entrp);
  prov_curr := CHOOSEN(SORT(prov_Active+prov_entrp,-Termination_Date,record),1);
  prov_res := IF(ut.IndustryClass.is_entrp,IF(ut.IndustryClass.entdateval=1,prov_curr,prov_entrp+prov_active),l.license);
  self.license := prov_res;
  self := l;
end;


prov_res := project(prov_rec, set_prov(left));

return prov_res;

end;
