import Corp, ut, NID;

// Create contact base with all records removed which could contain a Corp record

bc := Business_Header.File_Business_Contacts(from_hdr = 'N', source <> 'C');  // filter out any contact that has a 'C' source type

ccout := Corp.Corp_Cont_Out;

layout_cont_slim := record
unsigned6 bdid := (unsigned6)ccout.bdid;
unsigned6 did := (unsigned6)ccout.did;
qstring20 fname := (qstring20)ccout.cont_fname;
qstring20 mname := (qstring20)ccout.cont_mname;
qstring20 lname := (qstring20)ccout.cont_lname;
qstring5 name_suffix := (qstring5)ccout.cont_name_suffix;
qstring120 company_name := Stringlib.StringToUpperCase(ccout.corp_legal_name);
end;

ccout_slim := table(ccout, layout_cont_slim);


// Filter out any contacts with same bdid, did
Business_Header.Layout_Business_Contact_Full RemoveCont(Business_Header.Layout_Business_Contact_Full l, layout_cont_slim r) := transform
self := l;
end;

bc_remove_1 := join(distribute(bc(bdid <> 0 and did <> 0), hash(bdid, did)),
                    distribute(ccout_slim(bdid <> 0, did <> 0), hash(bdid, did)),
				left.bdid = right.bdid and
				  left.did = right.did,
				RemoveCont(left, right),
				left only,
				local);
				
// Filter out any contacts with same company name and person name
bc_remove_2 := join(distribute(bc_remove_1 + bc(not((bdid <> 0 and did <> 0))),
                      hash(trim(ut.CleanCompany(company_name)), trim(lname), trim(NID.PreferredFirstVersionedStr(fname, NID.version)))),
				distribute(ccout_slim, hash(trim(ut.CleanCompany(company_name)), trim(lname), trim(NID.PreferredFirstVersionedStr(fname, NID.version)))),
				ut.CleanCompany(left.company_name) = ut.CleanCompany(right.company_name) and
				  left.lname = right.lname and
				  NID.PreferredFirstVersionedStr(left.fname, NID.version) = NID.PreferredFirstVersionedStr(right.fname, NID.version) and
				  left.mname = right.mname and
				  left.name_suffix = right.name_suffix,
				RemoveCont(left, right),
				left only,
				local);
				
export BH_Cont_Fix_Corp_Dates := bc_remove_2 
	: persist(persistnames.BHContFixCorpDates);