import bankrupt, did_add, ut, Business_Header_SS, Business_Header;

#stored('did_add_force','thor');

sequential(
		fileservices.startsuperfiletransaction(),
		fileservices.clearsuperfile('~thor_data400::in::bk_search_did_FATHER',true),
		fileservices.addsuperfile('~thor_data400::in::bk_search_did_FATHER','~thor_Data400::in::bk_search_did_IN'),
		fileservices.clearsuperfile('~thor_data400::in::bk_search_did_IN'),
		fileservices.addsuperfile('~thor_data400::in::bk_search_did_IN','~thor_data400::in::bk_search'+bankrupt.version_search_doxie),
		fileservices.finishsuperfiletransaction()
		);


df := bankrupt.File_BKSearch_In;

temprec := record
	df;
    unsigned6 did := 0;
    unsigned1 did_score := 0;
    string9    a_ssn := '';
    unsigned6 bdid_new := 0;
    unsigned1 restr :=0;
    qstring34  source_group := df.court_code + df.case_number;
    qstring34  vendor_id := df.court_code + df.case_number + df.debtor_type;
end;

df2 := table(df,temprec);

myset := ['A','S','Z','4'];

did_add.MAC_Match_Flex(df2,myset,orig_ssn,foo,debtor_fname,debtor_mname,debtor_lname,
            debtor_name_suffix,prim_range, prim_name, sec_range, z5,st,foo,
            did,temprec,true,did_score,75,outf)

did_add.Mac_Append_SSN_With_Restrictions(outf,out2,did,a_ssn,restr)

to_bdid := out2;
to_bdid_company := to_bdid(debtor_company <> '');
to_bdid_no_company := to_bdid(debtor_company = '');

business_matchset := ['A'];

Business_Header.MAC_Source_Match(to_bdid_company, bdid_init,
                       FALSE, bdid_new,
                        FALSE, 'B',
                        TRUE, source_group,
                        debtor_company,
                        prim_range, prim_name, sec_range, z5,
                        FALSE, phone_field,
                        FALSE, fein_field,
                        TRUE, vendor_id)



bdid_match := bdid_init(bdid_new <> 0);
bdid_nomatch := bdid_init(bdid_new = 0);

Business_Header_SS.MAC_Add_BDID_FLEX(
            bdid_nomatch, business_matchset,
            debtor_company,
            prim_range, prim_name, z5,
            sec_range, st,
            phone_field, fein_field,
            bdid_new,
            temprec,
            false, BDID_Score_field,  //these should default to zero in definition
			bdid_rematch)

out3 := to_bdid_no_company + bdid_match + bdid_rematch;


typeof(df) into(out3 L) := transform
	boolean ssn_flag := If ((length(trim(L.orig_ssn)) = 4 AND length(trim(L.a_ssn)) = 9 AND l.orig_ssn[1..4] <> L.a_ssn[6..9]) OR
							(length(trim(L.orig_ssn)) = 9 AND length(trim(L.a_ssn)) = 9 AND L.orig_ssn <> L.a_ssn) OR
                            (length(trim(L.orig_ssn)) = 4 AND length(trim(L.a_ssn)) = 4 AND L.orig_ssn[1..4] <> L.a_ssn[1..4]) OR
                            (length(trim(L.orig_ssn)) = 9 AND length(trim(L.a_ssn)) = 4),
                            TRUE,FALSE);
	self.debtor_ssn := if (ssn_flag or L.a_ssn = '',L.orig_ssn,L.a_ssn);
	self.debtor_did := if (ssn_flag or L.did = 0,'',intformat(L.did,12,1));
	self.debtor_did_score := if (ssn_flag,'999',intformat(L.did_score,3,1));
	self.bdid := if(L.bdid_new <> 0,intformat(L.bdid_new,12,1),'');
	self.GLB_flag := if(ut.bit_test(L.restr, 3) OR ut.bit_test(L.restr, 2) OR L.restr = 0, 'N', 'Y');
	self := L;
end;

out4 := project(out3,into(LEFT));

output(out4,,'~thor_data400::out::bankrupt_search_v8_20050419',overwrite)
