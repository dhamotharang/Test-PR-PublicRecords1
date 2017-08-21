import ln_property, ln_propertyv2;

r_property_did := record
 string12 did;
end;

r_property_did t_unique_property_dids(ln_propertyv2.File_Search_DID l) := transform
 self.did := if(l.did<>0,intformat(l.did,12,1),'');
end;

property_dids := dedup(sort(distribute(project(ln_propertyv2.File_Search_DID,t_unique_property_dids(left))(did<>''),hash(did)),did,local),did,local);

first_data.Layout_FDS owner_based_on_deed(first_data.Hyphenated_Names l, first_data.Get_Current_Property_Deeds r) := transform
 
 boolean has_right_rec := if(r.lname<>'' or r.did<>'',true,false);
 
 self.rent_own_score_ := if(has_right_rec,'9',l.rent_own_score_);
 self                 := l;
end;

deed_attempt := join(first_data.Hyphenated_Names,first_data.Get_Current_Property_Deeds,
                     ((left.last_name =right.lname      or left.adl=right.did) and
			           left.house_nbr =right.prim_range                        and
			           left.str_name  =right.prim_name                         and
			           left.unit_nbr  =right.sec_range                         and
			           left.zip[1..5] =right.zip
			         ),
			         owner_based_on_deed(left,right),
			         left outer,keep(1)
			        );
					   
first_data.Layout_FDS owner_based_on_assessment(first_data.Layout_FDS l, first_data.Get_Current_Property_Assessments r) := transform
 
 boolean has_right_rec := if(r.lname<>'' or r.did<>'',true,false);
 
 self.rent_own_score_ := if(has_right_rec,'9',l.rent_own_score_);
 self                 := l;
end;

assr_attempt := join(deed_attempt,first_data.Get_Current_Property_Assessments,
                     ((left.last_name=right.lname      or left.adl=right.did) and
					   left.house_nbr =right.prim_range                       and
					   left.str_name  =right.prim_name                        and
					   left.unit_nbr  =right.sec_range                        and
					   left.zip[1..5] =right.zip
					  ),
					 owner_based_on_assessment(left,right),
					 left outer,keep(1)
					);

assr_attempt_dist := distribute(assr_attempt,hash(adl));

first_data.Layout_FDS likely_a_renter(first_data.Layout_FDS l, property_dids r) := transform
 
 boolean has_right_rec := if(r.did<>'',true,false);
 
 //If we already determined individual is an owner, leave as-is
 self.rent_own_score_ := if(l.rent_own_score_='9',l.rent_own_score_,
                         if(~has_right_rec and l.adl<>'' and l.unit_nbr<>'','1',
						 l.rent_own_score_));
 self                 := l;
end;

renter_attempt := join(assr_attempt_dist,property_dids,
                       left.adl=right.did,
				       likely_a_renter(left,right),
					   left outer,local
					  );

export Rent_Own_Score := renter_attempt;