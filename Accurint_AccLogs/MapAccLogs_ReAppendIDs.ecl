import ut, address, aid, lib_stringlib, address, did_add, Business_Header_SS;

export MapAccLogs_ReAppendIDs(dataset({accurint_acclogs.Layout_AccLogs_Base.Main, string orig_transaction_id, string orig_dateadded}) old_base) := function

//// DID and BDID base

HeaderVer_New := ut.IsNewProdHeaderVersion('accurint_auditing');
HeaderVer_Update := ut.PostDID_HeaderVer_Update('accurint_auditing');

did_match_set := ['A','D','S','P','4','Z'];

did_add.MAC_Match_Flex(old_base(fname <> '' and lname <> ''), did_match_set,
						ssn, dob, fname, mname, lname, name_suffix,
						prim_range, prim_name, sec_range, zip, st, phone,
						did, recordof(old_base),false,'',
						75, DIDFile);
						
DIDready := if(stringlib.stringtouppercase(ut.weekday((unsigned6)ut.GetDate[1..8])) in ['SATURDAY', 'SUNDAY'] and HeaderVer_New
					,DIDFile + old_base(fname = '' or lname =''),
					old_base); // -- run on weekend if new header

BHeaderVer_New := ut.IsNewProdHeaderVersion('accurint_auditing', 'bheader_file_version');
BHeaderVer_Update := ut.PostDID_HeaderVer_Update('accurint_auditing', 'bheader_file_version');

bdid_match_set := ['A','P'];  

inBDID := DIDready(cname <> '');

Business_Header_SS.MAC_Match_Flex(inBDID, bdid_match_set,
									cname,
									prim_range, prim_name, zip, sec_range, st, phone, foo,
									bdid, recordof(old_base), 
									false, '', BDIDFile);
									
ReAppendsReady := if(stringlib.stringtouppercase(ut.weekday((unsigned6)ut.GetDate[1..8])) in ['SATURDAY', 'SUNDAY'] and BHeaderVer_New
					,BDIDFile + DIDready(cname = ''),
					DIDready); // -- run on weekend if new business header
					

return ReAppendsReady;
end;