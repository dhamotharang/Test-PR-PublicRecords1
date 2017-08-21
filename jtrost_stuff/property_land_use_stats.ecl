import ln_property, ln_mortgage, property;

export ln_property_valid_state := [
'AK','AL','AR','AS','AZ','CA','CO','CT','DC','DE',
'FL','FM','GA','GU','HI','IA','ID','IL','IN','KS',
'KY','LA','MA','MD','ME','MH','MI','MN','MO','MP',
'MS','MT','NC','ND','NE','NH','NJ','NM','NV','NY',
'OH','OK','ON','OR','PA','PR','PW','RI','SC','SD',
'TN','TX','UM','UT','VA','VI','VT','WA','WI','WV',
'WY'];

r_codes := record
 string1   file;
 string1   vendor;
 string50  field;
 string15  code;
 string330 desc;
end;

lookup_ := dataset('~thor_dell400_2::persist::jtrost_property_lookup',r_codes,flat);

assr := dataset(ln_property.fileNames.builtAssessor, LN_Property.Layout_Property_Common_Model_BASE, flat)     (state_code in ln_property_valid_state or vendor_source_flag[1..3]='FAR');
deed := dataset(ln_property.filenames.builtDeeds,    LN_Mortgage.Layout_Deed_Mortgage_Common_Model_BASE, flat)(state      in ln_property_valid_state or vendor_source_flag[1..3]='FAR');

fares_assr := DATASET(property.Filename_Fares_Assessor, property.Layout_Fares_Assessor, THOR);						  

rVendor := record
 string1 vendor;
 string1 file;
 assr.homestead_homeowner_exemption;
 assr.tax_exemption1_code;
 assr.tax_exemption2_code;
 assr.tax_exemption3_code;
 assr.tax_exemption4_code;
 //assr.county_land_use_code;
 assr.county_land_use_description;
 string4 standardized_land_use_code;
 string1 timeshare_ind;
 //assr.zoning;
 string3 fares_bldg_code;
 deed.condo_code;
 deed.property_use_code;
 deed.fares_corporate_indicator;
 assr.no_of_buildings;
 assr.no_of_stories;
 assr.no_of_units;
 assr.parking_no_of_cars;
 assr.elevator;
 assr.assessee_name_type_code;
 assr.second_assessee_name_type_code;
 assr.mail_care_of_name_type_code;
end;

rVendor slimAssr(assr l) := transform
 self.vendor := if(l.vendor_source_flag in ['DAYTN','OKCTY'],'L','F');
 self.file   := 'A';
 //self.county_land_use_code := (string10)(unsigned4)l.county_land_use_code;
 self.standardized_land_use_code := (string4)(integer2)l.standardized_land_use_code;
 self.timeshare_ind              := l.timeshare_code;
 self.no_of_buildings            := (string3)(integer2)l.no_of_buildings;
 self.no_of_stories              := (string5)(integer2)l.no_of_stories;
 self.no_of_units                := (string5)(integer2)l.no_of_units;
 self.parking_no_of_cars         := (string5)(integer2)l.parking_no_of_cars;
 self := l;
 self := [];
end;

rVendor slimDeed(deed l) := transform
 self.vendor := if(l.vendor_source_flag in ['DAYTN','OKCTY'],'L','F');
 self.file   := 'D';
 self.standardized_land_use_code := (string4)(integer2)l.assessment_match_land_use_code;
 self.timeshare_ind              := l.timeshare_flag;
 self.property_use_code          := if(l.vendor_source_flag[1..3]='FAR',(string3)(integer2)l.property_use_code,l.property_use_code);
 self.fares_corporate_indicator  := l.fares_corporate_indicator;
 self := l;
 self := [];
end;

rVendor map_fares_bldg_code(fares_assr l) := transform
 self.vendor          := 'F';
 self.file            := 'A';
 self.fares_bldg_code := l.bldg_code;
 self := [];
end;

dAssr_           := project(assr,slimAssr(left));
dDeed_           := project(deed,slimDeed(left));
dfares_bldg_code := project(fares_assr(bldg_code<>''),map_fares_bldg_code(left));

dProperty := dAssr_+dDeed_+dfares_bldg_code;

r_denorm := record
 string1  vendor;
 string1  file;
 string30 field;
 string45 value_;
 string45 value_desc;
end;

r_denorm denorm_property(dProperty l, integer c) := transform
 self.vendor := choose(c,l.vendor
                        ,l.vendor
						,l.vendor
						,l.vendor
						,l.vendor
						,l.vendor
						,l.vendor
						,l.vendor
						,l.vendor
						,l.vendor
						,l.vendor
						,l.vendor
						,l.vendor
						,l.vendor);
 self.file   := choose(c,l.file
                        ,l.file
						,l.file
						,l.file
						,l.file
						,l.file
						,l.file
						,l.file
						,l.file
						,l.file
						,l.file
						,l.file
						,l.file
						,l.file);
 self.field  := choose(c,'COUNTY LAND USE DESC'
                        ,'STANDARDIZED LAND USE'
						,'FARES BLDG CODE (2580 DIRECT)'
						,'HOMESTEAD HOMEOWNER'
						,'LEXIS TAX EXEMPTION'
						,'LEXIS TAX EXEMPTION'
						,'LEXIS TAX EXEMPTION'
						,'LEXIS TAX EXEMPTION'
						,'TIMESHARE'
						,'CONDO'
						,'PROPERTY USE'
						,'LEXIS NAME TYPE'
						,'LEXIS NAME TYPE'
						,'FARES CORPORATE IND');
 self.valUe_ := choose(c,l.county_land_use_description
                        ,l.standardized_land_use_code
						,l.fares_bldg_code
						,l.homestead_homeowner_exemption
						,l.tax_exemption1_code
						,l.tax_exemption2_code
						,l.tax_exemption3_code
						,l.tax_exemption4_code
						,l.timeshare_ind
						,l.condo_code
						,l.property_use_code
						,l.assessee_name_type_code
						,l.second_assessee_name_type_code
						,l.fares_corporate_indicator);
 //self.vendor := choose(c,l.vendor,l.vendor,l.vendor,l.vendor);
 //self.field  := choose(c,'COUNTY LAND USE CODE','COUNTY LAND USE DESC','LEXIS/FARES LAND USE','ZONING');
 //self.valUe_ := choose(c,l.county_land_use_code,l.county_land_use_description,l.standardized_land_use_code,l.zoning);
 self.value_desc := '';
end;

d_property_ := normalize(dProperty,14,denorm_property(left,counter));

fares_sluc      := d_property_(vendor='F' and trim(field)= 'STANDARDIZED LAND USE'         and value_<>'');
fares_bldg      := d_property_(vendor='F' and trim(field)= 'FARES BLDG CODE (2580 DIRECT)' and value_<>'');
fares_prop      := d_property_(vendor='F' and trim(field)= 'PROPERTY USE'                  and value_<>'');
lexis_sluc      := d_property_(vendor='L' and trim(field)= 'STANDARDIZED LAND USE'         and value_<>'');
lexis_prop      := d_property_(vendor='L' and trim(field)= 'PROPERTY USE'                  and value_<>'');
lexis_tax       := d_property_(vendor='L' and trim(field)= 'LEXIS TAX EXEMPTION'           and value_<>'');
lexis_condo     := d_property_(vendor='L' and trim(field)= 'CONDO'                         and value_<>'');
lexis_name_type := d_property_(vendor='L' and trim(field)= 'LEXIS NAME TYPE'               and value_<>'');
fares_corp_ind  := d_property_(trim(field)='FARES CORPORATE IND'                           and value_<>'');
county_use      := d_property_(trim(field)='COUNTY LAND USE DESC'                          and value_<>'');
homestead       := d_property_(trim(field)='HOMESTEAD HOMEOWNER'                           and value_<>'');
timeshare       := d_property_(trim(field)='TIMESHARE'                                     and value_<>'');

r_denorm t_codes_lookup(r_denorm l, lookup_ r) := transform
 self.value_desc := r.desc;
 self := l;
end;

d_fares_sluc := join(fares_sluc,lookup_
                   ,(trim(left.value_,left,right)=trim(right.code,left,right) and trim(right.field)='LAND_USE')
		           ,t_codes_lookup(left,right)
		           ,lookup,left outer);

d_fares_bldg := join(fares_bldg,lookup_
          ,(trim(left.value_,left,right)=trim(right.code,left,right) and trim(right.field)='BLDG_CODE')
          ,t_codes_lookup(left,right)
		  ,lookup,left outer);

d_fares_prop := join(fares_prop,lookup_
          ,(trim(left.value_,left,right)=trim(right.code,left,right) and trim(right.field,left,right)='PROPERTY_IND')
          ,t_codes_lookup(left,right)
		  ,lookup,left outer);

d_lexis_sluc := join(lexis_sluc,lookup_
                   ,(trim(left.value_,left,right)=trim(right.code,left,right) and trim(right.field)='STANDARDIZED_LAND_USE_CODE')
		           ,t_codes_lookup(left,right)
		           ,lookup,left outer);

d_lexis_prop := join(lexis_prop,lookup_
                   ,(trim(left.value_,left,right)=trim(right.code,left,right) and trim(right.field)='PROPERTY_USE_CODE')
		           ,t_codes_lookup(left,right)
		           ,lookup,left outer);

d_lexis_tax := join(lexis_tax,lookup_
                   ,(trim(left.value_,left,right)=trim(right.code,left,right) and trim(right.field)='TAX_EXEMPTION1_CODE')
		           ,t_codes_lookup(left,right)
		           ,lookup,left outer);				   

d_lexis_condo := join(lexis_condo,lookup_
                   ,(trim(left.value_,left,right)=trim(right.code,left,right) and trim(right.field)='CONDO_CODE')
		           ,t_codes_lookup(left,right)
		           ,lookup,left outer);

d_lexis_name_type := join(lexis_name_type,lookup_
                   ,(trim(left.value_,left,right)=trim(right.code,left,right) and trim(right.field)='ASSESSEE_NAME_TYPE_CODE')
		           ,t_codes_lookup(left,right)
		           ,lookup,left outer);
				   
d_property := d_fares_sluc 
            + d_fares_bldg 
			+ d_fares_prop 
			+ d_lexis_sluc 
			+ d_lexis_prop 
			+ d_lexis_tax 
			+ d_lexis_condo 
			+ d_lexis_name_type 
			+ fares_corp_ind 
			+ county_use 
			+ homestead 
			+ timeshare;

stat1 := record
 d_property.vendor;
 d_property.file;
 d_property.field;
 d_property.value_;
 d_property.value_desc;
 count_ := count(group);
end;

out1      := table(d_property,stat1,vendor,file,field,value_,value_desc,few);//(count_>=10);
out1_filt := out1((trim(field) = 'COUNTY LAND USE DESC' and count_>=10000)
               or (trim(field) = 'HOMESTEAD HOMEOWNER'  and count_>=10000)
			   or (trim(field) = 'TIMESHARE'            and count_>=10000)
			   or (trim(field) = 'FARES CORPORATE IND'  )
			   or value_desc<>'');

//output(sort(out1_filt,field,file,vendor,value_,value_desc));

export property_land_use_stats := sort(out1_filt,field,file,vendor,value_,value_desc);

//output(out1_filt(vendor='F' and trim(field)= 'STANDARDIZED LAND USE'));
//output(out1_filt(vendor='F' and trim(field)= 'FARES BLDG CODE (2580 DIRECT)'));
//output(out1_filt(vendor='F' and trim(field)= 'PROPERTY USE'));
//output(out1_filt(vendor='L' and trim(field)= 'STANDARDIZED LAND USE'));
//output(out1_filt(vendor='L' and trim(field)= 'PROPERTY USE'));
//output(out1_filt(vendor='L' and trim(field)= 'LEXIS TAX EXEMPTION'));
//output(out1_filt(trim(field)= 'CONDO'));
//output(out1_filt(trim(field)= 'COUNTY LAND USE DESC'));
//output(out1_filt(trim(field)= 'HOMESTEAD HOMEOWNER'));
//output(out1_filt(trim(field)= 'TIMESHARE'));
//output(out1_filt(trim(field)= 'LEXIS NAME TYPE'));
//output(out1_filt(trim(field)= 'FARES CORPORATE IND'));