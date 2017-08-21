import ut;

export Fares_Latest_Filing_flag := module

//  Latest Flag for Assessor ##########################################################
export Assessorwflag(dataset(recordof(LN_PropertyV2.layout_property_common_model_base)) in_asses) :=
function

asses_dist := distribute(in_asses,hash(fares_unformatted_apn,(integer)fips_code,property_full_street_address));

asses_sort      := sort(asses_dist, fares_unformatted_apn,(integer)fips_code,property_full_street_address,local); 
asses_sort_grpd := group(asses_sort,fares_unformatted_apn,(integer)fips_code,property_full_street_address,local);
asses_grpd_sort := sort(asses_sort_grpd,-(integer)tax_year,-(integer)assessed_value_year,-(integer)process_date); 


 
asses_grpd_sort tkeepflag(asses_grpd_sort L, asses_grpd_sort R) := transform

                 
   self.current_record   := if(l.current_record = '', 'Y','N'); 
  //self.current_record := if(l.current_record = '', 'Y', if( l.current_record = 'Y' and  ((integer)r.recdate >= (integer)l.recdate) ,'Y','N'));
  self := R;

end;

Assesor_iterate := GROUP(iterate(asses_grpd_sort, tkeepflag(left, right)));

Assesor_iterate  reformat(Assesor_iterate l) := transform

   self.current_record   :=  if(l.current_record = 'N', '',l.current_record); 
   self := l ;
end; 

Assesor_current_flag := project(Assesor_iterate ,reformat(left)); 


return Assesor_current_flag;

end;

//  Latest Flag for Deed ##########################################################

export Deedwflag(dataset(recordof(LN_PropertyV2.layout_deed_mortgage_common_model_base)) in_deeds) :=
function

empty_apn  := in_deeds(fares_unformatted_apn = ''); 

non_empty_apn := in_deeds(fares_unformatted_apn <> ''); 

deeds_dist := distribute(non_empty_apn,hash(fares_unformatted_apn,(integer)fips_code,property_full_street_address));

deeds_sort      := sort(deeds_dist, fares_unformatted_apn,(integer)fips_code,property_full_street_address,local); 
deeds_sort_grpd := group(deeds_sort,fares_unformatted_apn,fips_code,property_full_street_address,local);
deeds_grpd_sort := sort(deeds_sort_grpd,-(integer)recording_date,-(integer)contract_date,-(integer)process_date); 


 
deeds_grpd_sort tkeepflag(deeds_grpd_sort L, deeds_grpd_sort R) := transform

                 
   self.current_record   := if(l.current_record = '', 'Y','N'); 
  //self.current_record := if(l.current_record = '', 'Y', if( l.current_record = 'Y' and  ((integer)r.recdate >= (integer)l.recdate) ,'Y','N')); // keep two records with current flag for same recdate
  self := R;

end;

deed_iterate := GROUP(iterate(deeds_grpd_sort, tkeepflag(left, right))) + empty_apn;

deed_iterate  reformat(deed_iterate l) := transform

   self.current_record   :=  if(l.current_record = 'N', '',l.current_record); 
   self := l ;
end; 

deed_current_flag := project(deed_iterate ,reformat(left)) ; 
return deed_current_flag;

end;
end; 