Import Data_Services, doxie, LN_Property,ut,LN_PropertyV2,LN_PropertyV2_Fast;

export Key_Deed_ParcelNum(boolean isFast = false) := FUNCTION

deed0 := LN_PropertyV2_Fast.CleanDeed(LN_PropertyV2.File_deed,false);
deed1	:= LN_PropertyV2_Fast.CleanDeed(LN_PropertyV2_Fast.Files.basedelta.deed_mortg,true);

ds := if (isFast,deed1, deed0);

dfd := ds														   (ln_fares_id != '');

keyPrefix := if (isFast, 'property_fast','ln_propertyv2');

	
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

return

index(df,
  {fares_unformatted_apn},
  {ln_fares_id},
  Constants.keyServerPointer+'thor_Data400::key::'+keyPrefix+'::' + doxie.Version_SuperKey + '::deed.parcelNum');
	
END;