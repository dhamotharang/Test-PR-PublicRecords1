import Business_Header, Risk_Indicators, ut;

export getExecutive(unsigned6 bdid_value, unsigned1 glb) := function

inrec := record
	unsigned6 bdid := 0;
end;

input := dataset([{bdid_value}], inrec);

rank_layout := record
	Business_Header.Key_Business_Contacts_BDID;
	unsigned1 t_rank := 0;
	string8 sic_code := '';
end;

rank_layout add_contacts(inrec le, Business_Header.Key_Business_Contacts_BDID rt) := transform
	self.bdid := le.bdid;
	self := rt;
end;

bus_contacts := join(input, Business_Header.Key_Business_Contacts_BDID,
				keyed(left.bdid=right.bdid) and left.bdid!=0 and
				(~right.glb OR ut.PermissionTools.glb.ok( glb)),
				add_contacts(left,right), left outer, keep(50), atmost(riskwise.max_atmost));

rank_layout addRank_and_sic(bus_contacts le, business_header.Key_SIC_Code rt) := transform
	self.t_rank := ut.TitleRank(le.company_title);
	self.sic_code := rt.sic_code;
	self := le;
end;


wRank := join(bus_contacts, business_header.key_SIC_Code,
			keyed(left.bdid=right.bdid),
			addRank_and_sic(left, right), left outer, atmost(riskwise.max_atmost));
	
sorted_bus_contacts := sort(wRank, -dt_last_seen);

rank_layout filterByRank(wRank le, wRank ri) := transform
	self := if(ri.t_rank < le.t_rank, ri, le);	// give me the record with the best rank, 1 being the best, 31 being the worst									
end;

executive_contact := rollup(wRank, true, filterByRank(left, right));				

return executive_contact;

end;