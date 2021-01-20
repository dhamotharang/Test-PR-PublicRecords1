import LiensV2, did_add, business_header_ss;

file_in := liensV2.mapping_NYC;

PreDID_Rec
 :=
  record
	liensV2.Layout_Liens_temp_base;
	integer8	debtor_temp_DID		    := 0;
	integer8	debtor_temp_BDID    	:= 0;
	integer8	creditor_temp_DID		:= 0;
	integer8	creditor_temp_BDID    	:= 0;
	integer8	atty_temp_DID		    := 0;
	integer8	atty_temp_BDID    	    := 0;
	integer8	thd_temp_DID		    := 0;
	integer8	thd_temp_BDID    	    := 0;

  end
 ;

PreDID_Rec taddDID(file_in L)
 :=
  transform

	self			:=	L;
  end
 ;

PreDID	:= project(file_in,taddDID(left));

//append DID to Debtor
matchset :=['A', 'z'];

did_Add.MAC_Match_Flex(PreDID, matchset,
	 '', '', clean_debtor_fname, clean_debtor_mname,clean_debtor_lname, clean_debtor_name_suffix,
	 clean_debtor_prim_range, clean_debtor_prim_name, clean_debtor_sec_range, clean_debtor_zip, clean_debtor_st,'',
	 debtor_temp_did,
	 PreDID_Rec,
	 false, did_score_field,	//these should default to zero in definition
	 75,	  //dids with a score below here will be dropped
	 postDID_debtor)

//append BDID to Debtor

for_debtor_bdid := postDID_debtor(clean_debtor_cname != '');

myset := ['A', 'N'];

Business_Header_SS.MAC_Add_BDID_FLEX(for_debtor_bdid,myset,
						clean_debtor_cname,
                        clean_debtor_prim_range,clean_debtor_prim_name,clean_debtor_zip,clean_debtor_sec_range,
						clean_debtor_st,
						'','',
						debtor_temp_bdid,
						PreDID_Rec,
						false, BDID_Score_field,  //these should default to zero in definition
						postbdid_debtor);

debtor_added_DID := postbdid_debtor +  postDID_debtor(clean_debtor_cname = '');

//append DID to Credtor


did_Add.MAC_Match_Flex(debtor_added_DID, matchset,
	 '', '', clean_creditor_fname, clean_creditor_mname,clean_creditor_lname, clean_creditor_name_suffix,
	 clean_creditor_prim_range, clean_creditor_prim_name, clean_creditor_sec_range, clean_creditor_zip, clean_creditor_st,'',
	 creditor_temp_did,
	 PreDID_Rec,
	 false, did_score_field,	//these should default to zero in definition
	 75,	  //dids with a score below here will be dropped
	 postDID_creditor)

//append BDID to creditor

for_creditor_bdid := postDID_creditor(clean_creditor_cname != '');


Business_Header_SS.MAC_Add_BDID_FLEX(for_creditor_bdid,myset,
						clean_creditor_cname,
                        clean_creditor_prim_range,clean_creditor_prim_name,clean_creditor_zip,clean_creditor_sec_range,
						clean_creditor_st,
						'','',
						creditor_temp_bdid,
						PreDID_Rec,
						false, BDID_Score_field,  //these should default to zero in definition
						postbdid_creditor);

creditor_added_DID := postbdid_creditor +  postDID_creditor(clean_creditor_cname = '');

//append DID to atty

did_Add.MAC_Match_Flex(creditor_added_DID, matchset,
	 '', '', clean_atty_fname, clean_atty_mname,clean_atty_lname, clean_atty_name_suffix,
	 clean_atty_prim_range, clean_atty_prim_name, clean_atty_sec_range, clean_atty_zip, clean_atty_st,'',
	 atty_temp_did,
	 PreDID_Rec,
	 false, did_score_field,	//these should default to zero in definition
	 75,	  //dids with a score below here will be dropped
	 postDID_atty)

//append BDID to atty

for_atty_bdid := postDID_atty(clean_atty_cname != '');


Business_Header_SS.MAC_Add_BDID_FLEX(for_atty_bdid,myset,
						clean_atty_cname,
                        clean_atty_prim_range,clean_atty_prim_name,clean_atty_zip,clean_atty_sec_range,
						clean_atty_st,
						'','',
						atty_temp_bdid,
						PreDID_Rec,
						false, BDID_Score_field,  //these should default to zero in definition
						postbdid_atty);

atty_added_DID := postbdid_atty +  postDID_atty(clean_atty_cname = '');

//append DID to thd


did_Add.MAC_Match_Flex(atty_added_DID, matchset,
	 '', '', clean_thd_fname, clean_thd_mname,clean_thd_lname, clean_thd_name_suffix,
	 clean_thd_prim_range, clean_thd_prim_name, clean_thd_sec_range, clean_thd_zip, clean_thd_st,'',
	 thd_temp_did,
	 PreDID_Rec,
	 false, did_score_field,	//these should default to zero in definition
	 75,	  //dids with a score below here will be dropped
	 postDID_thd)

//append BDID to thd

for_thd_bdid := postDID_thd(clean_thd_cname != '');


Business_Header_SS.MAC_Add_BDID_FLEX(for_thd_bdid,myset,
						clean_thd_cname,
                        clean_thd_prim_range,clean_thd_prim_name,clean_thd_zip,clean_thd_sec_range,
						clean_thd_st,
						'','',
						thd_temp_bdid,
						PreDID_Rec,
						false, BDID_Score_field,  //these should default to zero in definition
						postbdid_thd);

post_DID_BDID := postbdid_thd +  postDID_thd(clean_thd_cname = '');

//reformat DID and BDID

liensV2.Layout_liens_DID tBdid(post_DID_BDID L)
 :=
  transform
    self.def_DID		:=	intformat(L.debtor_temp_DID,12,1);
    self.def_BDID		:=	intformat(L.debtor_temp_BDID,12,1);
    self.creditor_DID		:=	intformat(L.creditor_temp_DID,12,1);
    self.creditor_BDID		:=	intformat(L.creditor_temp_BDID,12,1);
    self.atty_DID		:=	intformat(L.atty_temp_DID,12,1);
	self.atty_BDID		:=	intformat(L.atty_temp_BDID,12,1);
	self.thd_DID		:=	intformat(L.thd_temp_DID,12,1);
	self.thd_BDID		:=	intformat(L.thd_temp_BDID,12,1);
	self.date_first_seen                :=      L.orig_filing_date;
    self.date_last_seen                 :=      L.orig_filing_date;
    self.date_vendor_first_reported     :=      L.process_date;
    self.date_vendor_last_reported      :=      L.process_date;
	self            := L;

	end;

export NYC_DID := project(post_DID_BDID, tbdid(left)): persist('~thor_data400::persist::Liens::NYC_DID');
