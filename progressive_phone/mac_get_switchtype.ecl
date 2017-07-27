export mac_get_switchtype(f_in, f_out, useNeustar=false ) := macro
import risk_indicators,CellPhone;

#uniquename(f_base)
%f_base% := DATASET([],Risk_Indicators.Layout_Telcordia_tds);

#uniquename(telcordia_tds_key)
%telcordia_tds_key% := INDEX(%f_base%,{npa,nxx},{%f_base%},
                             ut.foreign_prod + 'thor_data400::key::telcordia_tds_' + doxie.Version_SuperKey);

#uniquename(toll_free_set)
%toll_free_set% := ['800','811','822','833','844','855','866','877','888','899'];

#uniquename(get_switch_type)
f_in %get_switch_type%(f_in l, %telcordia_tds_key% r) := transform
		self.switch_type :=  if(l.subj_phone10 = '', '',
		                        if(l.subj_phone10[1..3] in %toll_free_set% or 
			     			               regexfind('I',R.SSC), '8', //toll free
													     map(R.COCType in ['EOC','PMC','RCC','SP1','SP2'] and 
																  (regexfind('C',R.SSC) or
																   regexfind('R',R.SSC) or
																   regexfind('S',R.SSC)) => 'C', //cell
																   regexfind('B',R.SSC) =>  'G', //pager					  
																   regexfind('N',R.SSC) =>  'P', //pots
																   regexfind('V',R.SSC) =>  'V', //voip						
																   regexfind('T',R.SSC) =>  'T', //time
																   regexfind('W',R.SSC) =>  'W', //weather
																   regexfind('8',R.SSC) =>  'I', //islands
																   'U' )));                       //unknown																														
     self := l;
end;		 

#uniquename(pre_neustar_f_out)
%pre_neustar_f_out% := join(f_in, %telcordia_tds_key%,
              (unsigned)left.subj_phone10>10000000 and
				      keyed(left.subj_phone10[1..3] = right.npa) and 
				      keyed(left.subj_phone10[4..6] = right.nxx)  and 
				      left.subj_phone10[7] = right.tb, 
				      %get_switch_type%(LEFT,RIGHT), left outer, keep(1), limit(2000, skip));

#uniquename(post_neustar)			// change switchtype based on neustar ported numbers				
%post_neustar% := JOIN(%pre_neustar_f_out%, CellPhone.key_neustar_phone,
		                       KEYED(RIGHT.cellphone = LEFT.subj_phone10),
													 TRANSFORM(recordof(f_in),
		                                 SELF.switch_type := IF(RIGHT.cellphone <> '',
		                                                            'C',
		                                                            LEFT.switch_type); 
		                                 SELF := LEFT),
		                       LEFT OUTER, keep(1), limit(0));
							
f_out := if(useNeustar = true, %post_neustar%, %pre_neustar_f_out%);
endmacro;