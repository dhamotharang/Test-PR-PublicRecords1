import ln_property;

export ln_property_valid_state := [
'AK','AL','AR','AS','AZ','CA','CO','CT','DC','DE',
'FL','FM','GA','GU','HI','IA','ID','IL','IN','KS',
'KY','LA','MA','MD','ME','MH','MI','MN','MO','MP',
'MS','MT','NC','ND','NE','NH','NJ','NM','NV','NY',
'OH','OK','ON','OR','PA','PR','PW','RI','SC','SD',
'TN','TX','UM','UT','VA','VI','VT','WA','WI','WV',
'WY'];

fNonzero(string Input) :=
 if(length(trim(stringlib.stringfilter(Input,'0')))=length(trim(Input)),'',Input);
 
File_Assessment := dataset(ln_property.fileNames.builtAssessor, 
                           LN_Property.Layout_Property_Common_Model_BASE, flat)(state_code in ln_property_valid_state);

//dLexis := File_Assessment(vendor_source_flag in ['DAYTN','OKCTY']);
//dFares := File_Assessment(vendor_source_flag[1..3] = 'FAR');
						
st_co_rec := record
 File_Assessment.state_code;
 File_Assessment.county_name;
end;

prior_rec := record
 st_co_rec;
 File_Assessment.apna_or_pin_number;
 decimal1 has_prior_info;
 //File_Assessment.prior_sales_price;
 //string8 prior_date;
end;

prior_rec map_prior(File_Assessment l) := transform
 
 string8 v_prior_date   := fNonzero(if(trim(l.prior_recording_date)!='',l.prior_recording_date,l.prior_transfer_date));
 string8 v_prior_sale   := fNonzero(l.prior_sales_price);
 string30 v_county1     := stringlib.stringtouppercase(l.county_name);
 string30 v_county2     := if(stringlib.stringfind(v_county1,'BOROUGH',1)!=0,v_county1[1..stringlib.stringfind(v_county1,'BOROUGH',1)-1],
                           if(trim(v_county1,left,right)='FAIRBANKS N. STAR','FAIRBANKS NORTH STAR',
						   stringlib.stringfindreplace(v_county1,'\'','')));
 
 self.county_name       := v_county2;
 self.has_prior_info    := if(trim(v_prior_date)!='' or trim(v_prior_sale)!='',1,0);
 self := l;
end;

//The dedup prevents a property with multiple records being counted for more than once
dPrior := dedup(project(File_Assessment,map_prior(left)),state_code,county_name,apna_or_pin_number,-has_prior_info);

prior_statrec := record
 dPrior.state_code;
 dPrior.county_name;
 //decimal10 has_prior := dPrior.has_prior_info=1;
 decimal10 has_prior_info := count(group,dPrior.has_prior_info=1);
 decimal10 st_co_ct  := count(group);
end;

prior_results    := sort(table(dPrior,prior_statrec,state_code,county_name),state_code,county_name);

output(prior_results,,'out::ln_property_assr_prior_info_stats',overwrite);