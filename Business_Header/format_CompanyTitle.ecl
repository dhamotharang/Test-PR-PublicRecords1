import text,ut;
export format_CompanyTitle(dataset(Layout_Business_Contact_Plus) contacts) := 
FUNCTION  //

slimrec := record
	unsigned8 uid;
	contacts.company_title;
end;

slimrec makeplusrec(contacts l) := transform
	self.company_title := trim(l.company_title, left, right);
	self.uid := 0;
	//self := l;
end;

tcontacts := dedup(project(contacts, makeplusrec(left)), all);
ut.MAC_Sequence_Records(tcontacts, uid, init)

prstr :=  'PRESIDENT';
vistr := 'VICE';
vpstr :=  vistr + ' ' + prstr;
mgrstr := 'MANAGER';
chmstr := 'CHAIRMAN';
exstr :=  'EXECUTIVE';
coostr := 'CHIEF OPERATING OFFICER';
ceostr := 'CHIEF EXECUTIVE OFFICER';
trstr :=  'TREASURER';
asstr :=  'ASSISTANT';
secstr := 'SECRETARY';

replace(string this) := case(trim(this,left,right),
'SEC' => secstr,
'VICE PRES' => vpstr,
'VICEPRES' => vpstr,
'EXEC V PRES' => exstr + ' ' + vpstr,
'EVP' => exstr + ' ' + vpstr,
'VP' => vpstr,
'COO' => coostr,
'CEO' => ceostr,
'PRES' => prstr,
'TREAS' => trstr,
'ASST MGR' => asstr + ' ' + mgrstr,
'MNGR' => mgrstr,
'MGR' => mgrstr,
'CHMN' => chmstr,
'CHRMN' => chmstr,
'COB' => chmstr + ' OF THE BOARD',
'PRIN' => 'PRINCIPAL',
'ASST' => asstr,
'OWNR' => 'OWNER',
'V' => vistr,
this);

PATTERN word := text.alpha+;
PATTERN company_titleword := word REPEAT(text.ws word, 0, 3);
PATTERN vcompany_title := VALIDATE(company_titleword,
		MATCHTEXT <> replace(MATCHTEXT));
PATTERN notalpha := ANY NOT IN text.Alpha;
PATTERN find_company_title :=	(FIRST | notalpha) 
							vcompany_title 
						(LAST | notalpha);

layout_company_title := RECORD
	init.company_title;
	string100  decode_company_title := '';
	STRING100  pcompany_title := MATCHTEXT(vcompany_title);
	string100  rcompany_title := replace(MATCHTEXT(vcompany_title));
	UNSIGNED8 rcid := init.uid;
END;

parsed := 
	dedup(
		distribute(
			PARSE(init, company_title, find_company_title, layout_company_title, SCAN all), 
		hash(rcid)), 
	local);

//OUTPUT(PARSED);



layout_company_title prepem(layout_company_title l) := transform
	self.decode_company_title := 
		if(l.pcompany_title = '', 
			 l.company_title,
			 stringlib.StringFindReplace(l.company_title, trim(l.pcompany_title,left,right), trim(l.rcompany_title)));
	self := l;
end;

prepped := project(parsed, prepem(left));
//OUTPUT(prepped);

layout_company_title rollem(layout_company_title l, layout_company_title r) := transform
	self.decode_company_title := 
		if(r.pcompany_title = '', 
			 l.decode_company_title,
			 stringlib.StringFindReplace(l.decode_company_title, trim(r.pcompany_title,left,right), trim(r.rcompany_title)));
	self := l;
end;

rlld := rollup(prepped, left.rcid = right.rcid, rollem(left, right), local);

ddpd := dedup(rlld(company_title <> decode_company_title), all);

return ddpd;


END;
