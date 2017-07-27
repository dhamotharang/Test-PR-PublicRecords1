export MAC_Parse_Company_Branch(infile,
                                company_name_field,             // existing field in infile
                                match_company_name_field,       // appended to infile
                                match_branch_number_field,      // appended to infile
                                match_branch_position_field,    // appended to infile
                                match_branch_unit_desig_field,  // appended to infile
                                match_branch_unit_field,        // appended to infile
                                outfile) := macro



#uniquename(layout_infile_seq)
#uniquename(uid)
#uniquename(clean_company_name)

%layout_infile_seq% := record
qstring200 %clean_company_name%;
unsigned6 %uid% := 0;
infile;
end;

#uniquename(init_match)

%layout_infile_seq% %init_match%(infile L) := transform
self.%clean_company_name% := stringlib.stringfilterout(L.company_name_field, ',.');
self := L;
end;

#uniquename(infile_init)
%infile_init% := project(infile, %init_match%(left));

#uniquename(infile_seq)
// add unique sequence number to input file
ut.MAC_Sequence_Records(%infile_init%, %uid%, %infile_seq%)

pattern furniture_word := ['COMPANY', 
'CO',
'CORP',
'CORPORATION',
'CORPORATE',
'SERVICE',
'SERVICES',
'SER',
'INC',
'INCORPORATED',
'INTL',
'INTERNATIONAL',
'GLOBAL',
'INTERCONTINENTAL',
'WORLDWIDE',
'ASSOC',
'ASS',
'ASSO',
'ASSOCIATES',
'ASSOCIATION',
'BOUTIQUE',
'INDUSTRIES',
'INDUSTRIAL',
'IND',
'ENTERPRISES',
'ENTERPRISE',
'TRADING',
'GP',
'G P',
'QA',
'Q A',
'LP',
'L P',
'LLP',
'COOP',
'FACTORY',
'GRP',
'GROUP',
'LC',
'L C',
'LLC',
'FL LLC',
'BUILDING',
'CONDOMINIUM',
'COMMISSION',
'CLUB',
'DEPT',
'DEPARTMENT',
'DEPARTMENTS',
'NATIONWIDE',
'CONTRACTORS',
'CONTRACTING',
'WORLD',
'ADVANCED',
'STORE',
'STORES',
'THE',
'OF',
'MALL',
'LTD',
'LIMITED',
'LIABILITY',
'PARTNERSHIP',
'PARTNERS',
'PARTNER',
'FRANCHISE',
'INDUSTRY',
'INDUSTRIES',
'VENTURE',
'VENTURES',
'HOLDING',
'HOLDINGS',
'GENERAL'];

pattern number := pattern('[0-9]');
pattern numbers := number+;
pattern alpha := pattern('[A-Za-z]');
pattern punct := pattern('[,.;:]');
pattern ws := [' ','\t'];
pattern wss := ws+;
pattern wsp := (ws | '-' | punct)+;
pattern roman_numeral := pattern('[IVXLCDM]');
pattern roman_numerals := roman_numeral+;
pattern branchind := ['BRANCH','BUILDING','CONDOMINIUM','TRUST','SERIES','GROUP','POST','FUND','UNIT','STORE','LOC','LOCATION','NUMBER','NO'];
pattern branchend := (number | alpha | '-')+;
pattern branchunit := (numbers opt(branchend)) | (roman_numerals not in furniture_word opt('-' alpha));

pattern branchnum := ((first | ws) branchind (wss | '-' | '#') branchunit (wsp | last)) |
                      ((first | ws) '#' opt(wss) branchunit (wsp | last)) |
                      ((first | ws | '-') branchunit ((wsp furniture_word (wsp | last)) | (wsp last))) |
                      ('(' opt(wss) branchunit opt(wss) ')') |
                      ('"' opt(wss) branchend opt(wss) '"') |
                      ((first | ws) branchind (wss | '-' | '#') (branchend not in (furniture_word | branchind)) (wsp | last));

#uniquename(layout_infile_match)
#uniquename(infile_match)

%layout_infile_match% := record
%infile_seq%;
qstring81 match_company_name_field := ut.cleancompany(map(matchposition(branchnum) = 1 =>  trim(%infile_seq%.%clean_company_name%[(matchposition(branchnum)+matchlength(branchnum))..],left),
                                   matchposition(branchnum) > 1 => 
                                     stringlib.stringcleanspaces(%infile_seq%.%clean_company_name%[1..matchposition(branchnum)-1] + ' ' +
                                                                 %infile_seq%.%clean_company_name%[(matchposition(branchnum)+matchlength(branchnum))..]),
                                   %infile_seq%.%clean_company_name%));
qstring20 match_branch_number_field := trim(matchtext(branchnum));
unsigned1 match_branch_position_field := matchposition(branchnum);
qstring20 match_branch_unit_desig_field := matchtext(branchnum/branchind);
qstring20 match_branch_unit_field := stringlib.stringcleanspaces(if(matchtext(branchnum/branchunit) <> '',
                                                                      matchtext(branchnum/branchunit),
                                                                      matchtext(branchnum/branchend)));
end;

// parse company name into match company name and branch information
%infile_match% := parse(%infile_seq%, %clean_company_name%, branchnum, %layout_infile_match%, first, scan all, not matched);

#uniquename(infile_Match_Branch_Dist)
%infile_Match_Branch_Dist% := distribute(%infile_match%, hash(%uid%));

#uniquename(infile_Match_Branch_RN)
%infile_Match_Branch_RN% := %infile_Match_Branch_Dist%(match_branch_number_field <> '' AND
                                                     stringlib.stringfilterout(match_branch_number_field, 'IVXLCDM') = '');

#uniquename(infile_Match_Branch_RN_Sort)
%infile_Match_Branch_RN_Sort% := sort(%infile_Match_Branch_RN%, %uid%, match_branch_position_field, local);

#uniquename(infile_Match_Branch_RN_Dedup)
%infile_Match_Branch_RN_Dedup% := dedup(%infile_Match_Branch_RN_Sort%, %uid%, local);

#uniquename(infile_Match_Branch_Other)
%infile_Match_Branch_Other% := %infile_Match_Branch_Dist%(NOT (match_branch_number_field <> '' AND
                                                        stringlib.stringfilterout(match_branch_number_field, 'IVXLCDM') = ''));

#uniquename(infile_Match_Branch_Sort)
%infile_Match_Branch_Sort% := sort(%infile_Match_Branch_Other% + %infile_Match_Branch_RN_Dedup%, %uid%, if(match_branch_unit_desig_field <> '', 0, 1), -match_branch_position_field, local);

#uniquename(infile_Match_Branch_Dedup)
%infile_Match_Branch_Dedup% := dedup(%infile_Match_Branch_Sort%, %uid%, local);

// project to output format
#uniquename(layout_outfile)

%layout_outfile% := record
infile;
qstring81 match_company_name_field;
qstring20 match_branch_number_field;
unsigned1 match_branch_position_field;
qstring20 match_branch_unit_desig_field;
qstring20 match_branch_unit_field;
end;

#uniquename(format_output)
%layout_outfile% %format_output%(%layout_infile_match% L) := transform
self := L;
end;

outfile := project(%infile_Match_Branch_Dedup%, %format_output%(left));

endmacro;