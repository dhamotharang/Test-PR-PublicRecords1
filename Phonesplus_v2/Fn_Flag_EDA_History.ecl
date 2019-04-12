﻿//*************Funtions to flag records that match gong history by name, address and phone7 
//             or by did and phone7
export Fn_Flag_EDA_History(dataset(recordof(Layout_In_Phonesplus.layout_in_common)) phplus_in) := function

layout_temp := Record
	Layout_In_Phonesplus.layout_in_common;
	unsigned8	orig_rules;
end;

layout_temp SaveOrigRules(phplus_in infile) := TRANSFORM
	SELF.orig_rules := infile.rules;
	SELF.rules := 0;
  SELF := infile;
END;

phplus_in_temp := PROJECT(phplus_in,SaveOrigRules(LEFT));

//------------Score Non-published scores with high in_flag
recordof(phplus_in_temp) t_edah_score(phplus_in_temp le) := transform
	self.in_flag 	    := if ( Translation_Codes.fFlagIsOn(le.eda_hist_match, 10b) or
							    Translation_Codes.fFlagIsOn(le.eda_hist_match, 1000b),
								false,le.in_flag); 
						
	self.rules  		:= if ( Translation_Codes.fFlagIsOn(le.eda_hist_match, 10b) or
							    Translation_Codes.fFlagIsOn(le.eda_hist_match, 1000b),
								Translation_Codes.rules_bitmap_code('Disconnected-EDA'),
								le.rules); 
	self := le;
end;

edah_score := project(phplus_in_temp, t_edah_score(left));

//------------Propagate Disconnect EDA score to all records for the individuals flagged

edah_score_flagged := edah_score(Translation_Codes.fFlagIsOn(rules, Translation_Codes.rules_bitmap_code('Disconnected-EDA')));

recordof(phplus_in_temp) t_prop_eda(edah_score le,edah_score_flagged  ri) := transform
	self.in_flag 	   := if(ri.rules <> 0b, ri.in_flag, le.in_flag);
	self.rules 	       := if(ri.rules <> 0b, ri.rules, le.rules);
	self := le;
end;


prop_edah    := join(distribute(edah_score, hash(phone7_did_key)),
				    dedup(sort(distribute(edah_score_flagged, hash(phone7_did_key)), phone7_did_key, local), phone7_did_key, local),
					left.phone7_did_key = right.phone7_did_key,
					t_prop_eda(left, right),
					local,
					left outer);

pplus_eda_appended := PROJECT(prop_edah,TRANSFORM(Layout_In_Phonesplus.layout_in_common, SELF.rules := Left.orig_rules | Left.rules; SELF :=
          LEFT));

return pplus_eda_appended;
end;