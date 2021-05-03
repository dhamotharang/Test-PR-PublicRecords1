import LN_PropertyV2,LN_PropertyV2_Fast,doxie, ln_property, ut;

export Key_Assessor_ParcelNum(boolean isFast = false) := FUNCTION

ds := if (isFast,
		LN_PropertyV2_Fast.CleanAssessment(LN_PropertyV2_Fast.Files.basedelta.assessment,true),
		LN_PropertyV2_Fast.CleanAssessment(LN_PropertyV2.File_Assessment,false)
		);

dfd := ds(ln_fares_id not in LN_PropertyV2.Suppress_LNFaresID, ln_fares_id != '');

keyPrefix := if (isFast, 'property_fast','ln_propertyv2');


d_ln := dfd(ln_fares_id[1]!='R'); 
d_fa := dfd(ln_fares_id[1]='R');
	
// filter same formatted and unformatted records  

d_fa_d := d_fa(fares_unformatted_apn != LN_Propertyv2.fn_strip_pnum(apna_or_pin_number)); 
d_fa_s := d_fa(fares_unformatted_apn = LN_Propertyv2.fn_strip_pnum(apna_or_pin_number)); 

 
d_fa_d tnorm(d_fa_d L, integer cnt) := transform

self.fares_unformatted_apn := choose(cnt, l.fares_unformatted_apn, LN_Propertyv2.fn_strip_pnum(l.apna_or_pin_number));						  
          
self := L;

end;
					   
norm_file := normalize(d_fa_d, 2, tnorm(left, counter));

d := d_ln + d_fa_s + norm_file ; 
	
df := dedup(d(fares_unformatted_apn !=''),fares_unformatted_apn,ln_fares_id,all);

return

index(df,
			{fares_unformatted_apn},
			{ln_fares_id},
			Constants.keyServerPointer+'thor_Data400::key::'+keyPrefix+'::' + doxie.Version_SuperKey + '::assessor.parcelNum');

END;