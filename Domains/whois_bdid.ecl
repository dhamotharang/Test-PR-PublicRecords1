import ut, Business_Header, Business_Header_SS, did_add;

Layout_Whois_Temp := record
string46 company_name;
string34 source_group;
Layout_Whois_Base;
end;

// BDID the Whois File
Layout_Whois_Temp InitDomains(Layout_Whois l) := transform
SELF.company_name := Stringlib.StringToUpperCase(l.registrant_name);
SELF.source_group := l.domain_name;
self.title := '';
self.fname := '';
self.mname := '';
self.lname := '';
self.name_suffix := '';
self.name_score := '';
SELF := l;
END;

Domains_Init := project(File_Whois, InitDomains(left));

Business_Header.MAC_Source_Match(Domains_Init, Domains_BDID_Init,
                        false, bdid,
                        false, 'W',
                        true, source_group,
                        company_name,
                        prim_range, prim_name, sec_range, zip,
                        false, phone_field,
                        false, fein_field)

// Then do a standard BDID match for the records which did not BDID,
// since the Corporate file may be newer than the Business Headers
BDID_Matchset := ['A'];

Domains_BDID_Match := Domains_BDID_Init(bdid <> 0);
Domains_BDID_NoMatch := Domains_BDID_Init(bdid = 0);


Business_Header_SS.MAC_Add_BDID_Flex(Domains_BDID_NoMatch,
                                  BDID_Matchset,
                                  company_name,
                                  prim_range, prim_name, zip,
								  sec_range, state,
                                  phone_field, fein_field,
                                  bdid, Layout_Whois_Temp,
                                  false, BDID_score_field,
                                  Domains_BDID_Rematch)

Domains_BDID_Combined := Domains_BDID_Match + Domains_BDID_Rematch;

Domains.Layout_Whois_Base FormatBase(Layout_Whois_Temp L) := transform
self := l;
end;

Domains_BDID_All := project(Domains_BDID_Combined, FormatBase(left));

export whois_bdid := Domains_BDID_All : persist('TEMP::whois_bdid');