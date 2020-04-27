import did_add, ut, Business_Header, Business_Header_SS;

/*---------------[ IMPORTANT ]---------------*/
/*                                           */
/* Remember to set the version_search_doxie  */
/* attribute.                                */
/*                                           */
/*-------------------------------------------*/

pre := sequential(
		fileservices.startsuperfiletransaction(),
		fileservices.clearsuperfile('~thor_data400::in::liens_did_father',true),
		fileservices.addsuperfile('~thor_data400::in::liens_did_father','~thor_Data400::in::liens_did_in'),
		fileservices.clearsuperfile('~thor_data400::in::liens_did_in'),
		fileservices.addsuperfile('~thor_data400::in::liens_did_in','~thor_data400::in::liens'+bankrupt.version_search_doxie),
		fileservices.finishsuperfiletransaction()
		);

df := bankrupt.File_Liens;

temprec := record
	df;
	unsigned6	did_temp := 0;
	unsigned1 did_score_temp := 0;
	string9	ssn_appended_temp := '';
	unsigned6 bdid_new := 0;
	qstring34  vendor_id := df.courtid + df.casenumber;
	qstring120 company_name := if(df.def_company <> '', df.def_company, df.defname);
end;

df2 := table(df,temprec);


myset := ['A','S','Z','4'];

did_add.MAC_Match_Flex(df2,myset,orig_ssn,foo,def_fname,def_mname,def_lname,
	def_name_suffix,prim_range, prim_name, sec_range, zip, state, foo,
	did_temp,temprec,true,did_score_temp,70,outf)

did_add.MAC_Add_SSN_By_DID(outf,did_temp,ssn_appended_temp,out2,true)

to_bdid := out2 : persist('TEMP:liens_did');
to_bdid_company := to_bdid((indivbusun='B' or aka_yn = 'B') and company_name <> '');
to_bdid_no_company := to_bdid(not((indivbusun='B' or aka_yn = 'B') and company_name <> ''));

business_matchset := ['A'];

Business_Header.MAC_Source_Match(to_bdid_company, bdid_init,
                        FALSE, bdid_new,
                        FALSE, 'LJ',
                        TRUE, vendor_id,
                        company_name,
                        prim_range, prim_name, sec_range, zip,
                        FALSE, phone_field,
                        FALSE, fein_field,
				    TRUE, vendor_id)

bdid_match := bdid_init(bdid_new <> 0);

bdid_nomatch := bdid_init(bdid_new = 0);


Business_Header_SS.MAC_Add_BDID_FLEX(
	bdid_nomatch, business_matchset,
	company_name,
	prim_range, prim_name, zip,
	sec_range, state,
	phone_field, fein_field,
	bdid_new,
	temprec,
	false, BDID_Score_field,  //these should default to zero in definition
	bdid_rematch)

out3 := to_bdid_no_company + bdid_match + bdid_rematch;

typeof(df) into(out3 L) := transform
	boolean ssn_flag := If ((length(trim(L.orig_ssn)) = 4 AND length(trim(L.ssn_appended_temp)) = 9 AND l.orig_ssn[1..4] <> L.ssn_appended_temp[6..9]) OR
					 (length(trim(L.orig_ssn)) = 9 AND length(trim(L.ssn_appended_temp)) = 9 AND L.orig_ssn <> L.ssn_appended_temp) OR
					 (length(trim(L.orig_ssn)) = 4 AND length(trim(L.ssn_appended_temp)) = 4 AND L.orig_ssn[1..4] <> L.ssn_appended_temp[1..4]) OR
					 (length(trim(L.orig_ssn)) = 9 AND length(trim(L.ssn_appended_temp)) = 4),
				  TRUE,FALSE);
	self.ssn_appended := if (ssn_flag or L.ssn_appended_temp = '',L.orig_ssn,L.ssn_appended_temp);
	self.did := if (ssn_flag or L.did_temp = 0,'',intformat(L.did_temp,12,1));
	self.did_score := if (ssn_flag,'999',intformat(L.did_score_temp,3,1));
	self.bdid := if(L.bdid_new <> 0,intformat(L.bdid_new,12,1),'');
	self := L;
end;

out4 := project(out3,into(LEFT));
output(out4,,'~thor_data400::out::liens_rebdid_20050512',overwrite);
//ut.mac_sf_buildprocess(out4,'~thor_data400::base::liens',done,3)

//sequential (pre,done);
//output(count(df((integer)df.did > 0)));

//output(out4,,'out::liens_did_added',overwrite);
