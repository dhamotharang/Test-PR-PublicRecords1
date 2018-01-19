import doxie, Data_Services;

dfd := LN_PropertyV2.File_Deed_Building(ln_fares_id != '');
	
d_ln := dfd(ln_fares_id[1]!='R'); 
d_fa := dfd(ln_fares_id[1]='R');
	
// filter same formatted and unformatted records  

d_fa_d := d_fa(fares_unformatted_apn != LN_Propertyv2.fn_strip_pnum(apnt_or_pin_number)); 
d_fa_s := d_fa(fares_unformatted_apn = LN_Propertyv2.fn_strip_pnum(apnt_or_pin_number)); 

 
d_fa_d tnorm(d_fa_d L, integer cnt) := transform

self.fares_unformatted_apn := choose(cnt, l.fares_unformatted_apn, LN_Propertyv2.fn_strip_pnum(l.apnt_or_pin_number));						  
          
self := L;

end;
					   
norm_file := normalize(d_fa_d, 2, tnorm(left, counter));

d := d_ln + d_fa_s + norm_file ; 
	
df := dedup(d(fares_unformatted_apn !=''),fares_unformatted_apn,ln_fares_id,all);

export Key_Deed_ParcelNum := 

index(df,
  {fares_unformatted_apn},
  {ln_fares_id},
  Data_Services.Data_location.Prefix('Property')+'thor_data400::key::ln_propertyV2::' + doxie.Version_SuperKey + '::deed.parcelNum');
