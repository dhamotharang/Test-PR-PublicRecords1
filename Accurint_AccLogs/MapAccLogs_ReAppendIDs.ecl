import ut, address, aid, lib_stringlib, address, did_add, Business_Header_SS, header_slimsort, business_header;

export MapAccLogs_ReAppendIDs(dataset({accurint_acclogs.Layout_AccLogs_Base.Main, string orig_transaction_id, string orig_dateadded}) pOld_base) := function

//// DID and BDID base

DoW := stringlib.stringtouppercase(trim(version, all));

// HeaderVer_New := ut.IsNewProdHeaderVersion('accurint_auditing');

did_match_set := ['A','D','S','P','4','Z'];

old_base := project(pOld_base, transform({recordof(pold_base)}, self.did := 0, self := left));

did_add.MAC_Match_Flex(old_base(fname <> '' and lname <> ''), did_match_set,
						ssn, dob, fname, mname, lname, name_suffix,
						prim_range, prim_name, sec_range, zip, st, phone,
						did, recordof(old_base),false,'',
						75, DIDFile);
						
DIDready := DIDFile + old_base(fname = '' or lname ='');
// DIDready := if(HeaderVer_New
								// ,DIDFile + old_base(fname = '' or lname =''),
								// old_base
								// ); // -- run on weekend if new header

// BHeaderVer_New := ut.IsNewProdHeaderVersion('accurint_auditing', 'bheader_file_version');

bdid_match_set := ['A','P'];  

inBDID := DIDready(cname <> '');

Business_Header_SS.MAC_Match_Flex(inBDID, bdid_match_set,
									cname,
									prim_range, prim_name, zip, sec_range, st, phone, foo,
									bdid, recordof(old_base), 
									false, '', BDIDFile);
									
ReAppendsReady := BDIDFile + DIDready(cname = '');
// ReAppendsReady := if(BHeaderVer_New
					// ,BDIDFile + DIDready(cname = ''),
					// DIDready); // -- run on weekend if new business header
					

return ReAppendsReady;
end;