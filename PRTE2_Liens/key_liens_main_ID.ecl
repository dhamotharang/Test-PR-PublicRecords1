Import Data_Services, PRTE2_Liens, liensv2, Doxie, ut;

export 	Key_liens_main_ID(boolean isFCRA = false) := FUNCTION

get_recs := PRTE2_Liens.files.Main_out;

ut.MAC_CLEAR_FIELDS(get_recs, get_recs_cleared, prte2_liens.Constants.fields_to_clear_main_id_fcra);

//	RR-10912 Liens - Project JuLi FCRA Restrictions
//	Manually update layout with bCBFlag until field is added to base file.
new_layout_liens_main := RECORD, MAXLENGTH(32766)
	STRING50 tmsid;
	STRING50 rmsid;
	STRING process_date;
	STRING record_code := '';
	STRING date_vendor_removed := '';
	STRING filing_jurisdiction := '';
	STRING filing_state := '';
	STRING20 orig_filing_number := '';
	STRING orig_filing_type := '';
	STRING orig_filing_date := '';
	STRING orig_filing_time := '';
	STRING case_number   := '';
	STRING20 filing_number := '';
	STRING filing_type_desc := '';
	STRING filing_date := '';
	STRING filing_time := '';
	STRING vendor_entry_date := '';
	STRING judge := '';
	STRING case_title := '';
	STRING filing_book := '';
	STRING filing_page := '';
	STRING release_date := '';
	STRING amount := '';
	STRING eviction := '';
	STRING satisifaction_type := '';
	STRING judg_satisfied_date := '';
	STRING judg_vacated_date := '';
	STRING tax_code := '';
	STRING irs_serial_number := '';
	STRING effective_date := '';
	STRING lapse_date := '';
	STRING accident_date := '';
	STRING sherrif_indc := '';
	STRING expiration_date := '';
	STRING agency :='';
	STRING agency_city :='';
	STRING agency_state :='';
	STRING agency_county :='';
	STRING legal_lot := '';
	STRING legal_block := '';
	STRING legal_borough := '';
	STRING certificate_number := '';
	BOOLEAN	bCBFlag	:=	FALSE;
	UNSIGNED8 persistent_record_id :=0 ; 
	DATASET(Liensv2.layout_liens_main_module.layout_filing_status) filing_status;
	STRING2  Filing_Type_ID  :=       '';
  STRING8  Collection_Date :=       '';
  STRING45 CaseLinkID      :=       '';
  STRING50 TMSID_old       :=       '';
  STRING50 RMSID_old       :=       '';
  BOOLEAN  CaseLinkID_Prop_Flag :=  FALSE;
	unsigned4	global_sid;
	unsigned8	record_sid;
	string10	orig_rmsid;
	string7		agencyid;
	string1		agencyid_src;

END;

get_recs_newLayout			:=	PROJECT(get_recs,
															TRANSFORM(new_layout_liens_main,
																SELF.bCBFlag	:=	FALSE;
															  Self.Filing_Type_ID  :=       '';
                                Self.Collection_Date :=       '';
                                Self.CaseLinkID      :=       '';
                                Self.TMSID_old       :=       '';
                                Self.RMSID_old       :=       '';
                                Self.CaseLinkID_Prop_Flag :=  FALSE;
																self.global_sid			 := 0;
																self.record_sid			 := 0;
																self.orig_rmsid			 := '';
																self.agencyid				 := '';
																self.agencyid_src		 := '';
																SELF			          	:=	LEFT;
															)
														);
get_recs_newLayout_FCRA	:=	PROJECT(get_recs_cleared,
															TRANSFORM(new_layout_liens_main,
																SELF.bCBFlag	:=	TRUE;
																Self.Filing_Type_ID  :=       '';
                                Self.Collection_Date :=       '';
                                Self.CaseLinkID      :=       '';
                                Self.TMSID_old       :=       '';
                                Self.RMSID_old       :=       '';
                                Self.CaseLinkID_Prop_Flag :=  FALSE;
																self.global_sid			 := 0;
																self.record_sid			 := 0;
																self.orig_rmsid			 := '';
																self.agencyid				 := '';
																self.agencyid_src		 := '';
																SELF					       :=	LEFT;
															)
														);
														

dMainOut	:=	IF(isFCRA,
									get_recs_newLayout_FCRA,
									get_recs_newLayout);
														



file_prefix := if(IsFCRA, 
                  Constants.KEY_PREFIX + 'fcra::',
                  Constants.KEY_PREFIX);
									
												
dist_id := distribute(dMainOut, hash(TMSID,RMSID));
sort_id := sort(dist_id, TMSID, RMSID,local);
RETURN index(sort_id,{tmsid,RMSID},{sort_id}, file_prefix + doxie.Version_SuperKey + '::main::TMSID.RMSID');

END;
