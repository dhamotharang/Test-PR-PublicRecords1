import ut;
relrec := business_header.Layout_Business_Relative;
export fun_RemoveBizRegAgents(dataset(relrec) rels, integer ceiling = 100) := 
FUNCTION

//not worried about giant groups because they are not used in (super)grouping by reports
tocheck := rels.business_registration and not rels.rel_group;
br := rels(tocheck);

//count the number of relationships between two businesses
r := record
	br;
	unsigned1 relationships;
end;

unsigned1 addit(boolean b) := if(b, 1, 0);
				
r addrel(br l) := transform  
	self.relationships := 
		((addit(l.corp_charter_number) +
		addit(l.business_registration) +
		addit(l.bankruptcy_filing) +
		addit(l.duns_number))*2 +
		(addit(l.duns_tree) +
		addit(l.edgar_cik) +
		addit(l.name) +
		addit(l.name_address) +
		addit(l.name_phone) +
		addit(l.gong_group))*2 +
		(addit(l.ucc_filing) +
		addit(l.fbn_filing) +
		addit(l.fein) +
		addit(l.phone) +
		addit(l.addr))*2 +
		(addit(l.mail_addr) +
		addit(l.rel_group) +
		addit(l.dca_company_number) +
		addit(l.dca_hierarchy) +
		addit(l.abi_number) +
		addit(l.abi_hierarchy))*2) DIV 2;
	self := l;
end;

brp := project(br, addrel(left));

brp_suspect := brp(relationships = 1);
brp_ok := brp(relationships <> 1);
ut.MAC_Slim_Back(brp_ok, relrec, brp_ok_slim)

rec1 := record
	brp.bdid1;
	cnt := count(group);
end;

brs1 := table(brp_suspect, rec1, bdid1);
brsg1 := brs1(cnt > ceiling);

rec2 := record
	brp.bdid2;
	cnt := count(group);
end;

brs2 := table(brp_suspect, rec2, bdid2);
brsg2 := brs2(cnt > ceiling);

relrec keepclean(brp l) := transform
	self := l;
end;

relrec keepclean2(relrec l) := transform
	self := l;
end;

cleaned1 := join(brp_suspect, brsg1, left.bdid1 = right.bdid1, keepclean(left), left only, hash);
cleaned2 := join(cleaned1, brsg2, left.bdid2 = right.bdid2, keepclean2(left), left only, hash);

outf := 
	rels(not tocheck) +
	brp_ok_slim +
	cleaned2;

return outf;

END;