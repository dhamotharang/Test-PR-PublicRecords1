import ut;

set of string10 set_NotAgent := 
	['STARBUCKS '];

rec := busreg.Layout_Busreg_Company_RID;

export remove_agents(dataset(rec) B, unsigned2 ceiling) :=
FUNCTION

//agents clearly marked
layout_agt := record
	string20 cln_lfc := ut.CleanCompany(B.OFC1_NAME);
end;

br_agents := table(B(OFC1_TITLE = 'AGT'), layout_agt);


//agents by count
r := record
	string20 cln_lfc := ut.CleanCompany(B.OFC1_NAME);
	b.company_name;
end;

bslim := table(b(OFC1_NAME[1..10] not in set_notagent),r);
bddpd := dedup(bslim,cln_lfc,company_name, all);

cr := record
	bddpd.cln_lfc;
	cnt := count(group);
end;

cnts := table(bddpd, cr, cln_lfc)(cnt > ceiling);

both := dedup(br_agents + table(cnts, {cln_lfc}), cln_lfc, all);
//pull them out
rec cleanit(rec l) := transform
	self := l;
end;

j := join(B, both, ut.CleanCompany(left.OFC1_NAME)[1..20] = right.cln_lfc, 
		cleanit(left), lookup, left only);

//some existing filters
j2 := j(
	stringlib.stringfind(OFC1_NAME, 'LEXIS DOCUMENT SERVICES', 1) = 0,
	stringlib.stringfind(OFC1_NAME, 'CORPAMERICA', 1) = 0,
	stringlib.stringfind(OFC1_NAME, ' CT CORP', 1) = 0,
	stringlib.stringfind(OFC1_NAME, 'AGENTS FOR DELAWARE CORPORATIONS', 1) = 0,
	stringlib.stringfind(OFC1_NAME, 'ALPHA LEGAL FORMS & MORE', 1) = 0,
	not (OFC1_NAME[1..2] = 'CT' and stringlib.stringfind(OFC1_NAME, 'CT CORP', 1) > 0),
	not (OFC1_NAME[1..3] = 'C T' and stringlib.stringfind(OFC1_NAME, 'C T CORP', 1) > 0),
	not (OFC1_NAME[1] = 'C' and  (OFC1_NAME[2] = 'T' or OFC1_NAME[3] = 'T')and stringlib.stringfind(OFC1_NAME, 'CORPORATION SYSTEM ', 1) > 0),
	not (stringlib.stringfind(OFC1_NAME,'BLUMBERG',1) > 0 and stringlib.stringfind(OFC1_NAME,'EXCELSIOR',1) > 0 and stringlib.stringfind(OFC1_NAME,'CORP',1) >0 )
	
	);
		
return j2;

END;