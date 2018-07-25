import doxie_ln, doxie_crs, ut, doxie, FCRA, LN_PropertyV2, suppress, ffd;

// ar, dr -- "base" deeds/assess records.
// For fcra-side ar, dr -- fcra-compliant "base" records;

EXPORT make_property_records
	(dataset(doxie_ln.layout_assessor_records) ar,
	 dataset(doxie_ln.layout_deed_records) dr,
	 boolean SkipNameCheck = false,
   DATASET (doxie.layout_best) ds_best  = DATASET ([], doxie.layout_best),
   boolean IsFCRA = false,
 	 nonSS = suppress.constants.NonSubjectSuppression.doNothing,
	 dataset(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
	 dataset(ffd.Layouts.PersonContextBatchSlim) slim_pc_recs = ffd.Constants.BlankPersonContextBatchSlim,
	 integer8 inFFDOptionsMask = 0
	 ) :=
FUNCTION

boolean showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask);
boolean ShowConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);

rec := doxie_crs.layout_property_ln;

rec_did := record(doxie_crs.layout_property_ln)
	unsigned6 search_did;  // did the search originally started with that found the FCRA fares_ids with
  unsigned6 party_did:=0;  // did in the search table to be filled in with below, will be used for nonSS	
end;

//combine deeds & asses together in a standard CRS format
std_property_0 := doxie_LN.GetStandardProperty (ar, dr);

std_property := project(std_property_0,transform(rec_did,self.search_did := left.did, self:=left));

key_county := LN_PropertyV2.key_county_fid(isFCRA);

  rec_did tr_name (rec_did l, key_county r) := transform
	  self.buyer_mailing_county := r.o_county_name;
    self.property_county := if(l.property_county  = '', r.p_county_name, l.property_county);
    self := l;
  end;

  pc := JOIN (std_property, key_county, 
                    (left.buyer_mailing_county = '' or left.property_county = '') and 
                    keyed (left.ln_fares_id = right.ln_fares_id),
                    tr_name (left, right), 
                    left outer, keep(1), limit (0));

name_rec := record
	rec_did;	
	string20  fname;
	string20  mname;
	string20  lname;
	string1 	name_source_code_1;
	unsigned8 persistent_record_id:=0;
end;

Key_search := LN_PropertyV2.key_search_fid(isFCRA);

name_rec search_tr_name (rec_did L, Key_search R) := transform
	rp := if(R.source_code_2 = 'P', R);
	ro := if(R.source_code_2 = 'O', R);
		
	self.address_prim_range := rp.prim_range;
	self.address_predir := rp.predir;
	self.address_prim_name := rp.prim_name;
	self.address_suffix := rp.suffix;
	self.address_postdir := rp.postdir;
	self.address_unit_desig := rp.unit_desig;
	self.address_sec_range := rp.sec_range;
	self.address_v_city_name := rp.v_city_name;
	self.address_ace_state := rp.st;
	self.address_ace_zip := rp.zip;
	self.address_ace_zip4 := rp.zip4;
	self.address_county := l.property_county; 
	
	//these names will optionally be used to set current=true (which really should read owned=true)
	self.fname := rp.fname;
	self.mname := rp.mname;
	self.lname := rp.lname;
	self.name_source_code_1 := r.source_code_1;
		
	is_SameAddr := 
		(stringlib.stringfilterout(l.property_full_street_address,'01 ')[1..6] = 
		 stringlib.stringfilterout(l.buyer_mailing_full_street_address,'01 ')[1..6]);
	
	pickoa(string rp, string ro, string le) := 
		map(is_SameAddr and rp <> '' => rp,
		    l.owners_address_prim_range <> '' => le,
			ro);

	self.owners_address_prim_range := pickoa(rp.prim_range, ro.prim_range, l.owners_address_prim_range);
	self.owners_address_predir := pickoa(rp.predir, ro.predir, l.owners_address_predir);
	self.owners_address_prim_name := pickoa(rp.prim_name, ro.prim_name, l.owners_address_prim_name);
	self.owners_address_suffix := pickoa(rp.suffix, ro.suffix, l.owners_address_suffix);
	self.owners_address_postdir := pickoa(rp.postdir, ro.postdir, l.owners_address_postdir);
	self.owners_address_unit_desig := pickoa(rp.unit_desig, ro.unit_desig, l.owners_address_unit_desig);
	self.owners_address_sec_range := pickoa(rp.sec_range, ro.sec_range, l.owners_address_sec_range);
	self.owners_address_v_city_name := pickoa(rp.v_city_name, ro.v_city_name, l.owners_address_v_city_name);
	self.owners_address_ace_state := pickoa(rp.st, ro.st, l.owners_address_ace_state);
	self.owners_address_ace_zip := pickoa(rp.zip, ro.zip, l.owners_address_ace_zip);
	self.owners_address_ace_zip4 := pickoa(rp.zip4, ro.zip4, l.owners_address_ace_zip4);
	buyer_mailing_county := if(nonSS <> suppress.constants.NonSubjectSuppression.doNothing and
															r.cname = '' and l.search_did <> l.party_did,
														 ''
														,l.buyer_mailing_county) ;
	
	self.owners_address_county := buyer_mailing_county; 
	self.buyer_mailing_county := buyer_mailing_county; 
	self.party_did := r.did;
	self.name_of_seller := if(nonSS <> suppress.constants.NonSubjectSuppression.doNothing and r.cname = '',
														if (r.source_code_1 = 'S', stringlib.StringCleanSpaces(r.fname + ' ' + r.mname + ' ' + r.lname) , '')
														,l.name_of_seller) ;
	self.Name_Owner_1 := if(nonSS <> suppress.constants.NonSubjectSuppression.doNothing and r.cname = '',
														if (r.source_code_1 = 'O' or r.source_code_1 = 'B', stringlib.StringCleanSpaces(r.fname + ' ' + r.mname + ' ' + r.lname) , '')
														,l.Name_Owner_1) ;
	self.persistent_record_id	:= r.persistent_record_id;
	self := l;													
end;
flags := flagfile (file_id=FCRA.FILE_ID.SEARCH); 

pcp0 := join (pc, Key_search, 
                  keyed(left.ln_Fares_id = right.ln_fares_id)
									and ~((string)right.persistent_record_id in set(flags((unsigned6)did=left.search_did ),record_id) and isFCRA),
			            search_tr_name (left, right), left outer, keep (ut.limits.RECORDS_PER_FARES_ID), limit(0));
									
search_over := join(flags, FCRA.key_override_property.search,
										keyed(left.flag_file_id = right.flag_file_id) and isFCRA,
										transform(recordof(Key_search),self:=right,self:=[]), keep(ut.limits.OVERRIDE_LIMIT), limit(0)); 
											
pcp1 := pcp0 + join(pc, search_over, left.ln_fares_id = right.ln_fares_id and left.search_did = right.did,
										search_tr_name (left, right));										

name_rec addStatementIds ( name_rec l, FFD.Layouts.PersonContextBatchSlim r ) := transform,
	skip((~showDisputedRecords and r.isdisputed) or (~ShowConsumerStatements and exists(r.StatementIDs))) 
		self.statementids := dedup(l.statementids + r.statementids, all); // l from DG.ASSESSMENT or DG.DEED
		self.isdisputed :=	l.isdisputed or r.isdisputed; 
		self := l;
end;
pcp2 := join(pcp1, slim_pc_recs(isFCRA, datagroup=FFD.Constants.DataGroups.PROPERTY_SEARCH),
							(string) left.persistent_record_id = right.recid1
							and left.search_did  = (unsigned) right.lexid,
							addStatementIds(left, right),
							left outer, keep(1), limit(0));
 
nss_raw_0 := if(nonSS = suppress.constants.NonSubjectSuppression.doNothing,
								pcp2,
								project(pcp2(search_did<>party_did), // and bdid = 0 ),
												transform(recordof(name_rec),
																	self.owners_address_prim_range := '',
																	self.owners_address_predir := '',
																	self.owners_address_prim_name := '',
																	self.owners_address_suffix := '',
																	self.owners_address_postdir := '',
																	self.owners_address_unit_desig := '',
																	self.owners_address_sec_range := '',
																	self.owners_address_v_city_name := '',
																	self.owners_address_ace_state := '',
																	self.owners_address_ace_zip := '',
																	self.owners_address_ace_zip4 := '',
																	self.owners_address_county := '',
																	self.fname := '',
																	self.mname := '',
																	self.Name_Owner_1 := if(left.name_owner_1 <> '' and nonSS = suppress.constants.NonSubjectSuppression.returnRestrictedDescription,fcra.constants.FCRA_Restricted,''),
																	self.Name_Owner_2 := '',
																	self.buyer_mailing_full_street_address := '',
																	self.buyer_mailing_address_unit_number := '',
																	self.buyer_mailing_address_citystatezip := '', 
																	self.buyer_mailing_county := '',
																	// self.borrower1 := '',
																	// self.borrower2 := '',
																	self.name_of_seller := if(left.name_of_seller <> '' and nonSS = suppress.constants.NonSubjectSuppression.returnRestrictedDescription,fcra.constants.FCRA_Restricted,''), 
																	// self.buyer1 :=  '',
																	// self.buyer2 := '',
																	self.lname := if(nonSS = suppress.constants.NonSubjectSuppression.returnRestrictedDescription,fcra.constants.FCRA_Restricted,''),
																	self:=left)) +
													pcp2(~(search_did<>party_did)));// and bdid = 0 )));	

	nss_raw := sort(nss_raw_0,ln_fares_id,record);								

//try to make a few more owned
rec_did checkname(nss_raw l, doxie.layout_best r) := transform
	nmscore :=ut.NameMatch(r.fname, r.mname, r.lname, l.fname, l.mname, l.lname);	
	boolean set_curr := nmscore <= 5 and r.fname <> '' and r.lname <> '';
	self.current := if(set_curr, true, l.current);
	
	// if we are going to set current, we need to make sure the source_code is appropriate
	boolean changedCurr := set_curr and not l.current;
	self.source_code := if(changedCurr, l.name_source_code_1, l.source_code);
	
	self := l;
end;

pcp_many := join(nss_raw, ds_best, true, checkname(left, right), ALL);
// use pcp_many only if a subject entity exists; otherwise, use all property records found
// fixes a regression in location_report caused by bug 16919 (no prop info found)
ut.MAC_Slim_Back(nss_raw,rec_did,pcp_slim);

use_pcp := IF((SkipNameCheck or doxie.stored_Use_CurrentlyOwnedProperty_value or not EXISTS(ds_best))
							and not isFCRA, // always use pcp_many for FCRA queries, need to check name match to set current flag
							pcp_slim, 
							pcp_many);

rec_did rollem(rec_did l, rec_did r) := transform
	self.current := l.current or r.current;
	self.address_seq_no := if(l.address_seq_no > r.address_seq_no, l.address_seq_no, r.address_seq_no);	
	
	self.owners_address_prim_range := if(r.owners_address_prim_range = '', l.owners_address_prim_range, r.owners_address_prim_range);
	self.owners_address_predir := if(r.owners_address_predir = '', l.owners_address_predir, r.owners_address_predir);
	self.owners_address_prim_name := if(r.owners_address_prim_name = '', l.owners_address_prim_name, r.owners_address_prim_name);
	self.owners_address_suffix := if(r.owners_address_suffix = '', l.owners_address_suffix, r.owners_address_suffix);
	self.owners_address_postdir := if(r.owners_address_postdir = '', l.owners_address_postdir, r.owners_address_postdir);
	self.owners_address_unit_desig := if(r.owners_address_unit_desig = '', l.owners_address_unit_desig, r.owners_address_unit_desig);
	self.owners_address_sec_range := if(r.owners_address_sec_range = '', l.owners_address_sec_range, r.owners_address_sec_range);
	self.owners_address_v_city_name := if(r.owners_address_v_city_name = '', l.owners_address_v_city_name, r.owners_address_v_city_name);
	self.owners_address_ace_state := if(r.owners_address_ace_state = '', l.owners_address_ace_state, r.owners_address_ace_state);
	self.owners_address_ace_zip := if(r.owners_address_ace_zip = '', l.owners_address_ace_zip, r.owners_address_ace_zip);
	self.owners_address_ace_zip4 := if(r.owners_address_ace_zip4 = '', l.owners_address_ace_zip4, r.owners_address_ace_zip4);
	self.name_of_seller := if ( nonSS = suppress.constants.NonSubjectSuppression.doNothing, r.name_of_seller,
														map (r.name_of_seller <> '' and 
																r.name_of_seller <>  fcra.constants.FCRA_Restricted
																 => r.name_of_seller,
																l.name_of_seller <> '' and 
																l.name_of_seller <>  fcra.constants.FCRA_Restricted
														     => l.name_of_seller,
																l.name_of_seller = fcra.constants.FCRA_Restricted or
																r.name_of_seller = fcra.constants.FCRA_Restricted 
																 => fcra.constants.FCRA_Restricted,
																 ''));
	self.Name_Owner_1 := if ( nonSS = suppress.constants.NonSubjectSuppression.doNothing, r.Name_Owner_1,
														map (r.Name_Owner_1 <> '' and 
																r.Name_Owner_1 <>  fcra.constants.FCRA_Restricted
																 => r.Name_Owner_1,
																l.Name_Owner_1 <> '' and 
																l.Name_Owner_1 <>  fcra.constants.FCRA_Restricted
														     => l.Name_Owner_1,
																l.Name_Owner_1 = fcra.constants.FCRA_Restricted or
																r.Name_Owner_1 = fcra.constants.FCRA_Restricted 
																 => fcra.constants.FCRA_Restricted,
																 ''));	
	self.statementids := dedup(l.statementids + r.statementids, all);
	self.isdisputed := l.isdisputed or r.isdisputed;
	self := r;
end;

pcp := rollup(sort(use_pcp, ln_fares_id, record), left.ln_fares_id = right.ln_Fares_id, rollem(left, right));
										
//one little bit of cleaning
noz(string field) := IF(Stringlib.StringFilterOut(field,'0')='','',field);
string capit(string s) := stringlib.stringtouppercase(s);
rec ridz(rec_did l) := transform
	self.Loan_Term := noz(l.Loan_Term);
	self.Loan_Due_Date := noz(l.Loan_Due_Date);
	self.year_built := noz(l.year_built);
	self.stories_number := noz(l.stories_number);
	self.bedrooms := noz(l.bedrooms);
	self.full_baths := noz(l.full_baths);
	self.half_baths := noz(l.half_baths);
	self.buyer_mailing_county := capit(l.buyer_mailing_county);
	self.property_county := capit(l.property_county);
	self := l;
end;

wonoz := project(pcp, ridz(left));

return wonoz;

END;