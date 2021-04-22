IMPORT _control, MDR, bipv2,did_add,fair_isaac,didville,ut,header_slimsort,watchdog, Business_Header, Business_Header_SS, Prof_License_Mari,std;
#OPTION('multiplePersistInstances',FALSE);

export party_did(dataset(recordof(layout_SANCTN_party_clean)) j_party_toclean ) := function

temprec := record
	j_party_toclean;
	string		blk := '';
	bipv2.IDlayouts.l_xlink_ids;
	unsigned6	did := 0;
	unsigned3 did_score := 0;
	unsigned6	bdid := 0;
	unsigned3 bdid_score := 0;
	string9		ssn_appended := '';
	string9 	temp_ssn		 := '';
	unsigned8 source_rec_id := 0;
	string1		enh_did_src	:= '';					//Ehanced did source; M for Mari, S for SANCTN, N for SANCTN Non-public
end;
	
// Create a unique source_rec_id by hashing on all raw fields
TEMPREC add_id(j_party_toclean L) := transform
	self.temp_ssn  := std.str.filterout(L.SSNUMBER,'-');
	self.source_rec_id := hash64(
														ut.CleanSpacesAndUpper(L.BATCH_NUMBER) +
														ut.CleanSpacesAndUpper(L.INCIDENT_NUMBER) +
														ut.CleanSpacesAndUpper(L.PARTY_NUMBER) +
														ut.CleanSpacesAndUpper(L.RECORD_TYPE) +
														ut.CleanSpacesAndUpper(L.ORDER_NUMBER) +
														ut.CleanSpacesAndUpper(L.PARTY_NAME) +
														ut.CleanSpacesAndUpper(L.PARTY_POSITION) +
														ut.CleanSpacesAndUpper(L.PARTY_VOCATION) +
														ut.CleanSpacesAndUpper(L.PARTY_FIRM) +
														ut.CleanSpacesAndUpper(L.inADDRESS) +
														ut.CleanSpacesAndUpper(L.inCITY) +
														ut.CleanSpacesAndUpper(L.inSTATE) +
														ut.CleanSpacesAndUpper(L.inZIP) +
														ut.CleanSpacesAndUpper(L.SSNUMBER) +
														ut.CleanSpacesAndUpper(L.FINES_LEVIED) +
														ut.CleanSpacesAndUpper(L.RESTITUTION) +
														ut.CleanSpacesAndUpper(L.OK_FOR_FCR)); 
	self 							:= l;
end;
 
df2	:= project(j_party_toclean,add_id(LEFT));

//MATCHSET should be set of char1's indicating matchfields
/*
   matchset   -    should be set of char1's indicating the indicatives in infile
                          'A' = Address
                          'D' = DOB
                          'S' = ssn
                          'P' = phone
    ***                   'Q' = Address match excluding the fuzzy logic.  Equivalent to setting use_fuzzy = false in previous versions.  Acts the same regardless of whether matchset contains 'A'.
					 '4' = ssn4 matching (last 4 digits of ssn)
					 'G' = age matching
					 'Z' = zip code matching
*/
myset := ['A','S','Q','Z'];

did_add.MAC_Match_Flex(df2, myset
											 ,temp_ssn, blk, fname, mname, lname, name_suffix
											 ,prim_range, prim_name, sec_range, zip5, st
											 ,'',did, temprec,true
											 ,did_score
											 ,70
											 ,outf)

//Propagate did using SANCTN, SANCTN NP, and MARI datasets
outf_enh_did := Prof_License_Mari.fnMidexDid.SANCTN_Enhance_Did(outf);

did_add.MAC_Add_SSN_By_DID(outf_enh_did
                          ,did
													,ssn_appended
													,out2
													,true)	


out3 := out2 : PERSIST(SANCTN.cluster +'persist::SANCTN::party_did_new');

//MATCHSET should be set of char1's indicating matchfields
/*  'A' = Address
  'F' = FEIN
  'P' = phone
    * company name will always be part of the match if any of
      the above flags are set.
  'N' = Allow match on company name only.
*/
bdid_matchset  := ['A','N'];
Business_Header_SS.MAC_Match_Flex(
																	out3						// Input Dataset
																	,bdid_matchset	// BDID Matchset what fields to match on 
																	,cname					// company_name
																	,prim_range			// prim_range
																	,prim_name			// prim_name
																	,zip5						// zip5
																	,sec_range			// sec_range
																	,st							// state
																	,blk						// phone
																	,blk						// fein
																	,BDID						// bdid
																	,temprec				// output layout
																	,true						// output layout has bdid score field?
																	,BDID_SCORE			// bdid_score
																	,bdid_out				// output dataset
																	,								// keep_count  
																	,								// score_threshold
																	,								// file version (prod)
																	,								// use other environment?
																	,BIPV2.xlink_version_set  // BIP2 ids
																	,								// URL (not available)
																	, 							// email (not available)
																	,p_city_name		// city
																	,fname					// contact's first name
																	,mname 				  // contact's middle name
																	,lname					// contact's last name                 			 
																	,ssn_appended		// contact ssn
																	, 							// source
																	,source_rec_id	// source_record_id
																	,FALSE
																	);

out4 := PROJECT(bdid_out, transform(SANCTN.layout_SANCTN_did, self := left;self:=[];));

addGlobalSID := MDR.macGetGlobalSid(out4, 'Sanctn', '', 'global_sid'); //DF-25379: Populate Global_SIDs

dsSanctn_did := addGlobalSID  : PERSIST(SANCTN.cluster +'persist::SANCTN::party_did_new2');

return dsSanctn_did;

end;
