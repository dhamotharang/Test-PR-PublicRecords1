import	STD, Nid, Address, header, risk_indicators;

LayoutTemp := RECORD
	layout_gongMaster;
	string80		preppedname;
END;


rgx1 := '/.*$';
rgx2 := '(ARCHITECT|ARCHT|ATTY AT LAW|ATTY OFC|ATTY|CERT PUB ACCT|CHRPRCTR|OFC|FAX LINE|FAX LI|FCCP|INS|ATTORNEY AT LAW|DENTIST|LWYR|OPTMTRST|ORAL SURGN|ORTHDNTST|PHY & SUR|PODIATRST|RL EST|REAL ESTATE|REALTOR|RES|RLT|RLTR|RVT|SURG)$';
string FixupName(string s) := TRIM(MAP(
		REGEXFIND(rgx1, s, NOCASE) => REGEXREPLACE(rgx1, s, '', NOCASE),
		REGEXFIND(rgx2, s, NOCASE) => REGEXREPLACE(rgx2, s, '', NOCASE),
		s));



string MakeListedName(string fname, string mname, string lname, string sfx) :=
					TRIM(STD.Str.CleanSpaces(STD.Str.ToUpperCase(lname + ' ' + fname + ' ' + mname + ' ' + sfx)),LEFT,RIGHT);

layout_gongMaster xDualNames(layout_gongMaster L, integer n) := TRANSFORM
 self.name_prefix			:= if(n=1,L.cln_title, L.cln_title2);
 self.name_first			:= if(n=1,L.cln_fname, L.cln_fname2);
 self.name_middle			:= if(n=1,L.cln_mname, L.cln_mname2);
 self.name_last				:= if(n=1,L.cln_lname, L.cln_lname2);
 self.name_suffix 		:= if(n=1,L.cln_suffix, L.cln_suffix2);
 self.dual_name_flag := 'Y';
 self.nid := L.nid + if(n=1, Nid.NameIndicators.DerivedName, Nid.NameIndicators.DerivedName2);
 self.listing_type_res := if(L.RECORD_TYPE='P','R',L.listing_type_res);
// self.company_name := if(L.Business_name='',MakeListedName(L.first_name,L.middle_name,L.last_name,L.suffix_name),
//															STD.Str.ToUpperCase(L.Business_name));
 self := L;
END;


layout_gongMaster xNames(layout_gongMaster L) := TRANSFORM
 self.name_prefix			:= L.cln_title;
 self.name_first			:= if(L.nametype='P',L.cln_fname,UC(L.First_name));
 self.name_middle			:= MAP(
														L.nametype='P' => IF(L.Middle_Name = '\'', '',L.cln_mname),
														L.Middle_Name = '\'' => '',
														UC(L.Middle_Name)
													);
 self.name_last				:= if(L.nametype='P',L.cln_lname,UC(L.Last_name));
 self.name_suffix 		:= if(L.nametype='P',L.cln_suffix,UC(L.Suffix_name));
 self.dual_name_flag := 'N';
 self.listing_type_res := if(L.nametype='P','R',L.listing_type_res);
// self.company_name := if(L.Business_name='',MakeListedName(L.first_name,L.middle_name,L.last_name,L.suffix_name),
//															STD.Str.ToUpperCase(L.Business_name));
 self := L;
END;	

EXPORT proc_CleanNames(dataset(layout_gongMaster) infile) := FUNCTION

	master1a := PROJECT(infile(RECORD_TYPE = 'P' OR
								(RECORD_TYPE = 'R' AND First_name='' and Middle_name='' AND last_name='')),
								TRANSFORM(LayoutTemp,		// try to extract names from professional
									self.preppedname := fixupName(LEFT.Business_name);
									self := LEFT;));
	master1b := infile(RECORD_TYPE = 'R',First_name<>'' OR Middle_name<>'' OR last_name<>'');
	CleanNames_full := Nid.fn_CleanFullNames(master1a, preppedname, useV2 := true);
	CleanNames_parsed := Nid.fn_CleanParsedNames(master1b, First_name, Middle_Name, Last_name, Suffix_name, useV2 := true);

	clnnames := PROJECT(CleanNames_full,layout_gongMaster) & PROJECT(CleanNames_parsed,layout_gongMaster);	// 
	clnnames1 := PROJECT(clnnames(nametype<>'D'), xNames(LEFT));
	clnnames2 := NORMALIZE(clnnames(nametype='D',dual_name_flag<>'Y'), 2, xDualNames(LEFT,COUNTER));
	clnnames3 := PROJECT(infile(RECORD_TYPE in ['B','G']), TRANSFORM(layout_gongMaster,
													self.dual_name_flag := 'N';
													self := LEFT;));
	clnnames4 := clnnames1 & clnnames2 & clnnames3;

	header.Mac_Apply_Title(clnnames4, name_prefix, name_first, name_middle, clnnames5) ;

	return clnnames5;	// : PERSIST('~thor::persist::gong::neustar::cleannames');
end;