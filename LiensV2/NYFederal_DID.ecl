import LiensV2, did_add, business_header_ss;

file_in := liensV2.Mapping_NYFDLN;

PreDID_Rec
 :=
  record
	liensv2.Layout_Liens_Temp_Base;
	integer8	debtor_temp_DID		    := 0;
	integer8	debtor_temp_BDID    	:= 0;

  end;


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
	 '', '', Clean_debtor_fname, clean_debtor_mname,clean_debtor_lname, clean_debtor_name_suffix,
	 clean_debtor_prim_range, clean_debtor_prim_name,  clean_debtor_sec_range, clean_debtor_zip, clean_debtor_st,'',
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

post_DID_BDID := postbdid_debtor +  postDID_debtor(clean_debtor_cname = '');


//reformat DID and BDID

liensV2.Layout_liens_DID tbdid(post_DID_BDID L)
 :=
  transform
    self.def_DID		:=	intformat(L.debtor_temp_DID,12,1);
    self.def_BDID	:=	intformat(L.debtor_temp_BDID,12,1);
	self.date_first_seen                :=      L.filing_date;
    self.date_last_seen                 :=      L.filing_date;
    self.date_vendor_first_reported     :=      L.process_date;
    self.date_vendor_last_reported      :=      L.process_date;

         self :=  L;

	end;

export NYFederal_DID := project(post_DID_BDID, tbdid(left)):persist('~thor_data400::persist::Liens::NYFederal_DID');
