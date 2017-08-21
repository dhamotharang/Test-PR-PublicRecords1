ds := ln_property.File_Assessment(vendor_source_flag='OKCTY');

rec := record
 string12 ln_fares_id;
 string2  orig_st;
 string1  type_;
 string90 street;
 string60 csz;
end;

rec t_norm(ds l, integer c) := transform
 self.type_  := choose(c,'O','P');
 self.street := choose(c,stringlib.stringcleanspaces(l.mailing_full_street_address+l.mailing_unit_number),
                         stringlib.stringcleanspaces(l.property_full_street_address+l.property_unit_number)
				      );
 self.csz    := choose(c,stringlib.stringcleanspaces(l.mailing_city_state_zip),
                         stringlib.stringcleanspaces(l.property_city_state_zip)
					  );
 self.orig_st := l.state_code;
 self         := l;
end;

n_norm := normalize(ds,2,t_norm(left,counter));

rec2 := record
 n_norm;
 string10        prim_range;
 string2         predir;
 string28        prim_name;
 string4         addr_suffix;
 string2         postdir;
 string10        unit_desig;
 string8         sec_range;
 string25        p_city_name;
 string25        v_city_name;
 string2         st;
 string5         zip;
 string4         zip4;
 string4         cart;
 string1         cr_sort_sz;
 string4         lot;
 string1         lot_order;
 string2         dbpc;
 string1         chk_digit;
 string2         rec_type;
 string5         county;
 string10        geo_lat;
 string11        geo_long;
 string4         msa;
 string7         geo_blk;
 string1         geo_match;
 string4         err_stat;
end;

rec2 t_clean(n_norm l) := transform

 string182 v_ca := addrcleanlib.cleanaddress182(l.street,l.csz);
 
 self.prim_range	:= v_ca[1..10];
 self.predir		:= v_ca[11..12];
 self.prim_name		:= v_ca[13..40];
 self.addr_suffix	:= v_ca[41..44];
 self.postdir		:= v_ca[45..46];
 self.unit_desig	:= v_ca[47..56];
 self.sec_range		:= v_ca[57..64];
 self.st			:= v_ca[115..116];
 self.zip			:= v_ca[117..121];
 self.p_city_name 	:= v_ca[65..89];
 self.v_city_name 	:= v_ca[90..114];
 self.zip4 			:= v_ca[122..125];
 self.cart 			:= v_ca[126..129];
 self.cr_sort_sz 	:= v_ca[130];
 self.lot 			:= v_ca[131..134];
 self.lot_order 	:= v_ca[135];
 self.dbpc 			:= v_ca[136..137];
 self.chk_digit 	:= v_ca[138];
 self.rec_type 		:= v_ca[139..140];
 self.county 		:= v_ca[141..145];
 self.geo_lat 		:= v_ca[146..155];
 self.geo_long 		:= v_ca[156..166];
 self.msa 			:= v_ca[167..170];
 self.geo_blk 		:= v_ca[171..177];
 self.geo_match 	:= v_ca[178];
 self.err_stat 		:= v_ca[179..182];
 
 self               := l;
 
end;

p_clean := project(n_norm,t_clean(left));

rec2 t_existing_hack(p_clean l) := transform
 self.st := if(trim(l.st)='' and l.type_='P',l.orig_st,l.st);
 self    := l;
end;

p_existing_hack := project(p_clean,t_existing_hack(left)) : persist('~thor_dell400_2::persist::ln_properyt_okcty_address_reclean');
output(count(p_existing_hack),named('count1'));
//output(p_existing_hack);
//output(p_existing_hack(trim(csz)=''));
//output(p_existing_hack(trim(street)=''));

states_to_include := [
'AK','AL','AR','AZ','CA','CO','CT','DC','DE','FL',
'GA','HI','IA','ID','IL','IN','KS','KY','LA','MA',
'MD','ME','MI','MN','MO','MS','MT','NC','ND','NE',
'NH','NJ','NM','NV','NY','OH','OK','OR','PA','RI',
'SC','SD','TN','TX','UT','VA','VI','VT','WA','WI',
'WV','WY'
];

//If the clean state is blank, or invalid, there is simply nothing to replace... a clean address does not exist.
filter1 := p_existing_hack(st in states_to_include);
output(count(p_existing_hack),named('count2'));