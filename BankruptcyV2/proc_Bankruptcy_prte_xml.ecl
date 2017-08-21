//Creates new XML files for PRTE keys - Bug#174616

IMPORT ut, bankruptcyV2, _Control;

string8 version_date	:= '20150410';	//change date to reflect current key build version date

//New Records
ds_status		:= dataset('~file::edata12-bld.br.seisint.com::hds_180::bankruptcyv2::temp::test_status.csv',bankruptcyV2.layouts_bk_test.status,CSV(heading(single),separator(',')));
ds_comment 	:= dataset('~file::edata12-bld.br.seisint.com::hds_180::bankruptcyv2::temp::test_comments.csv',bankruptcyV2.layouts_bk_test.comments,CSV(heading(single),separator(',')));
ds_main			:= dataset('~file::edata12-bld.br.seisint.com::hds_180::bankruptcyv2::temp::test_tmsid_main_key.csv',bankruptcyV2.layouts_bk_test.main,CSV(separator(',')));

	layout_status := record, maxLength(10000) 
		string8 status_date;
		string30 status_type;
	end;

	layout_comments := record, maxLength(10000) 
		string8 filing_date;
		string30 description;
	end;

	rKeybankruptcyv2_main_tmsid	:= record 
		string50 tmsid;
		string8 process_date;
		string1 source;
		string12 id;
		string10 seq_number;
		string8 date_created;
		string8 date_modified;
		string5 court_code;
		string50 court_name;
		string40 court_location;
		string7 case_number;
		string25 orig_case_number;
		string3 chapter;
		string8 date_filed;
		string10 orig_filing_type;
		string12 filing_status;
		string3 orig_chapter;
		string8 orig_filing_date;
		string5 assets_no_asset_indicator;
		string1 filer_type;
		string1 corp_flag;
		string8 meeting_date;
		string8 meeting_time;
		string90 address_341;
		string8 claims_deadline;
		string8 complaint_deadline;
		string8 disposed_date;
		string35 disposition;
		string3 pro_se_ind;
		string35 judge_name;
		string5 judges_identification;
		string128 record_type;
		string2 filing_jurisdiction;
		string20 assets;
		string20 liabilities;
		string1 casetype;
		string1 assoccode;
		string8 date_last_seen;
		string8 date_first_seen;
		string8 date_vendor_first_reported;
		string8 date_vendor_last_reported;
		string8 converted_date;
		string8 reopen_date;
		string8 case_closing_date;
		DATASET(layout_status) status;
		DATASET(layout_comments) comments;
		unsigned8 __internal_fpos__;
	end;

//Previous XML record
dKeybankruptcyv2_main_tmsid	:= 	dataset('~file::edata12-bld.br.seisint.com::data_999::tkirk::prte_extracts::special::thor_data400__key__bankruptcyv2____main__tmsid.xml', rKeybankruptcyv2_main_tmsid, xml('Dataset/Row'));
output(count(dKeybankruptcyv2_main_tmsid),named('Prev_BK2_XML_Count'));
output(count(ds_main(tmsid<>'')),named('New_Record_Count'));

///////////////////////////////////////////////////////////////////////////////////////////
//Flatten Parent///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////

dsMain := record
	string50 tmsid;
	string8 process_date;
	string1 source;
	string12 id;
	string10 seq_number;
	string8 date_created;
	string8 date_modified;
	string5 court_code;
	string50 court_name;
	string40 court_location;
	string7 case_number;
	string25 orig_case_number;
	string3 chapter;
	string8 date_filed;
	string10 orig_filing_type;
	string12 filing_status;
	string3 orig_chapter;
	string8 orig_filing_date;
	string5 assets_no_asset_indicator;
	string1 filer_type;
	string1 corp_flag;
	string8 meeting_date;
	string8 meeting_time;
	string90 address_341;
	string8 claims_deadline;
	string8 complaint_deadline;
	string8 disposed_date;
	string35 disposition;
	string3 pro_se_ind;
	string35 judge_name;
	string5 judges_identification;
	string128 record_type;
	string2 filing_jurisdiction;
	string20 assets;
	string20 liabilities;
	string1 casetype;
	string1 assoccode;
	string8 date_last_seen;
	string8 date_first_seen;
	string8 date_vendor_first_reported;
	string8 date_vendor_last_reported;
	string8 converted_date;
	string8 reopen_date;
	string8 case_closing_date;
end;

flatMain := project(dKeybankruptcyv2_main_tmsid, dsMain);
	
in_file 	:= dKeybankruptcyv2_main_tmsid;

///////////////////////////////////////////////////////////////////////////////////////////
//Flatten Children/////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////

//Normalize Status	
	statusTable := table(in_file, 
									{integer statusCount := count(status), 
									in_file});
						
	out_status := record
		string50 tmsid;
		in_file.status;
	end;
	
	out_status getstatus(statusTable l, integer c):= transform
		self.tmsid		:= l.tmsid;
		self 					:= l.status[c];
	end;

	statusNorm := normalize(statusTable, 
													left.statusCount, 
													getStatus(left, counter));

//Normalize Comments
	commentsTable := table(in_file, 
									{integer commentsCount := count(comments), 
									in_file});
						
	out_comments := record
		string50 tmsid;
		in_file.comments;
	end;
	
	out_comments getcomments(commentsTable l, integer c):= transform
		self.tmsid		:= l.tmsid;
		self 					:= l.comments[c];
	end;

	commentsNorm := normalize(commentsTable, 
													left.commentsCount, 
													getcomments(left, counter));

///////////////////////////////////////////////////////////////////////////////////////////
//Concatenate New Recs/////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////

concat_status 	:= statusNorm 	+ ds_status(tmsid <> '');
concat_comments	:= commentsNorm + ds_comment(tmsid <> '');
concat_main			:= flatMain 		+ ds_main(tmsid <> '');

///////////////////////////////////////////////////////////////////////////////////////////
//Re-join all files   /////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////
//Add to Main
	Layout_Join_Main := record
		dsMain;
		dataset(layout_status) status{xpath('status')};
	end;

	Layout_Join_Main join_Main(concat_main l, concat_status r) := TRANSFORM
	   self.status 			:= row(R,layout_status);
	   self            	:= l;
	end;

	jn_Main := JOIN(concat_main
								 ,concat_status
								 ,trim(left.tmsid, left, right) = trim(right.tmsid, left, right)
								 ,join_Main(left,right)
								 ,left outer);
				 
	j_Main	:= sort(distribute(jn_Main, hash(tmsid)), tmsid, local);
	
	Layout_Join_AllV2	:= record
		Layout_Join_Main;
		dataset(layout_comments) comments{xpath('comments')};
		unsigned8 __internal_fpos__ := 0;
	end;
								 
	Layout_Join_AllV2 jComment(j_Main L, concat_comments R) := TRANSFORM
		self.comments := row(R,layout_comments);
		self := L;
END;

//Join comments file
j_AllV2 := join(j_Main, concat_comments,
							left.tmsid = right.tmsid,
							jComment(left,right),left outer);
							
output(count(j_AllV2),named('New_BK2_XML_Count'));
output(j_AllV2,named('BK2_join'));
	
///////////////////////////////////////////////////////////////////////////////////////////
//Create BK3 Output////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////

	rKeybankruptcyv3_main_tmsid	:= record
  string50 tmsid;
  string8 process_date;
  string1 source;
  string12 id;
  string10 seq_number;
  string8 date_created;
  string8 date_modified;
  string1 method_dismiss;
  string1 case_status;
  string5 court_code;
  string50 court_name;
  string40 court_location;
  string7 case_number;
  string25 orig_case_number;
  string8 date_filed;
  string12 filing_status;
  string3 orig_chapter;
  string8 orig_filing_date;
  string5 assets_no_asset_indicator;
  string1 filer_type;
  string8 meeting_date;
  string8 meeting_time;
  string90 address_341;
  string8 claims_deadline;
  string8 complaint_deadline;
  string35 judge_name;
  string5 judges_identification;
  string2 filing_jurisdiction;
  string20 assets;
  string20 liabilities;
  string1 casetype;
  string1 assoccode;
  string25 splitcase;
  string25 filedinerror;
  string8 date_last_seen;
  string8 date_first_seen;
  string8 date_vendor_first_reported;
  string8 date_vendor_last_reported;
  string8 reopen_date;
  string8 case_closing_date;
  string8 datereclosed;
  string50 trusteename;
  string90 trusteeaddress;
  string25 trusteecity;
  string2 trusteestate;
  string5 trusteezip;
  string4 trusteezip4;
  string10 trusteephone;
  string12 trusteeid;
  string12 caseid;
  string8 bardate;
  string7 transferin;
  string250 trusteeemail;
  string8 planconfdate;
  string8 confheardate;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string25 v_city_name;
  string2 st;
  string5 zip;
  string4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dbpc;
  string1 chk_digit;
  string2 rec_type;
  string5 county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  string12 did;
  string9 app_ssn;
  string1 delete_flag;
  DATASET(layout_status) status;
  DATASET(layout_comments) comments;
  unsigned8 __internal_fpos__;
end;

///////////////////////////////////////////////////////////////////////////////////////////
//Flatten Parent///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////

BK3_main_tmsid	:= record
  string50 tmsid;
  string8 process_date;
  string1 source;
  string12 id;
  string10 seq_number;
  string8 date_created;
  string8 date_modified;
  string1 method_dismiss;
  string1 case_status;
  string5 court_code;
  string50 court_name;
  string40 court_location;
  string7 case_number;
  string25 orig_case_number;
  string8 date_filed;
  string12 filing_status;
  string3 orig_chapter;
  string8 orig_filing_date;
  string5 assets_no_asset_indicator;
  string1 filer_type;
  string8 meeting_date;
  string8 meeting_time;
  string90 address_341;
  string8 claims_deadline;
  string8 complaint_deadline;
  string35 judge_name;
  string5 judges_identification;
  string2 filing_jurisdiction;
  string20 assets;
  string20 liabilities;
  string1 casetype;
  string1 assoccode;
  string25 splitcase;
  string25 filedinerror;
  string8 date_last_seen;
  string8 date_first_seen;
  string8 date_vendor_first_reported;
  string8 date_vendor_last_reported;
  string8 reopen_date;
  string8 case_closing_date;
  string8 datereclosed;
  string50 trusteename;
  string90 trusteeaddress;
  string25 trusteecity;
  string2 trusteestate;
  string5 trusteezip;
  string4 trusteezip4;
  string10 trusteephone;
  string12 trusteeid;
  string12 caseid;
  string8 bardate;
  string7 transferin;
  string250 trusteeemail;
  string8 planconfdate;
  string8 confheardate;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string25 v_city_name;
  string2 st;
  string5 zip;
  string4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dbpc;
  string1 chk_digit;
  string2 rec_type;
  string5 county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  string12 did;
  string9 app_ssn;
  string1 delete_flag;
END;

//Previous Main BK3 record
	dKeybankruptcyv3_main_tmsid		:= 	dataset('~file::edata12-bld.br.seisint.com::data_999::tkirk::prte_extracts::special::thor_data400__key__bankruptcyv3____main__tmsid.xml', rKeybankruptcyv3_main_tmsid, xml('Dataset/Row'));
output(count(dKeybankruptcyv3_main_tmsid),named('Prev_BK3_XML_Count'));	

flatMainV3 := project(dKeybankruptcyv3_main_tmsid, BK3_main_tmsid);
	
in_fileV3 	:= dKeybankruptcyv3_main_tmsid;

///////////////////////////////////////////////////////////////////////////////////////////
//Flatten Children/////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////

//Normalize Status	
	statusTableV3 := table(in_fileV3, 
									{integer statusCount := count(status), 
									in_fileV3});
						
	
	out_status getstatusV3(statusTableV3 l, integer c):= transform
		self.tmsid		:= l.tmsid;
		self 					:= l.status[c];
	end;

	statusNormV3 := normalize(statusTableV3, 
														left.statusCount, 
														getStatusV3(left, counter));

//Normalize Comments
	commentsTableV3 := table(in_fileV3, 
									{integer commentsCount := count(comments), 
									in_fileV3});
						
	out_comments getcommentsV3(commentsTableV3 l, integer c):= transform
		self.tmsid		:= l.tmsid;
		self 					:= l.comments[c];
	end;

	commentsNormV3 := normalize(commentsTableV3, 
													left.commentsCount, 
													getcommentsV3(left, counter));

///////////////////////////////////////////////////////////////////////////////////////////
//Concatenate New Recs/////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////

concat_statusV3 	:= statusNormV3 	+ ds_status(tmsid <> '');
concat_commentsV3	:= commentsNormV3 + ds_comment(tmsid <> '');
ds_main_v3				:= project(ds_main(tmsid <> ''),transform(BK3_main_tmsid,self := left; self := [];));
concat_mainV3			:= flatMainV3 + ds_main_v3; 

//Get Trustee info for new records	
	ds_bkV3 := dataset('~thor_data400::base::bankruptcy::main_v3',bankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp ,flat);
	ds_bkV3_flat := project(ds_bkV3, BK3_main_tmsid);
	
//Sort prior to join
srt_bkV3	:= sort(distribute(ds_bkV3_flat,hash(tmsid)),tmsid,local);
srt_newBKV3	:= sort(distribute(concat_mainV3,hash(tmsid)),tmsid,local);
	
//Join to bkV3 file to get clean Name/Address/Trustee info
BK3_main_tmsid j_New_V3(srt_newBKV3 L, srt_bkV3 R) := transform
	self.datereclosed := R.datereclosed;
	self.trusteename := R.trusteename;
  self.trusteeaddress := R.trusteeaddress;
  self.trusteecity := R.trusteecity;
  self.trusteestate := R.trusteestate;
  self.trusteezip := R.trusteezip;
  self.trusteezip4 := R.trusteezip4;
  self.trusteephone := R.trusteephone;
  self.trusteeid := R.trusteeid;
  self.caseid := R.caseid;
  self.bardate := R.bardate;
  self.transferin := R.transferin;
  self.trusteeemail := R.trusteeemail;
  self.planconfdate := R.planconfdate;
  self.confheardate := R.confheardate;
  self.title := R.title;
  self.fname := R.fname;
  self.mname := R.mname;
  self.lname := R.lname;
  self.name_suffix := R.name_suffix;
  self.name_score := R.name_score;
  self.prim_range := R.prim_range;
  self.predir := R.predir;
  self.prim_name := R.prim_name;
  self.addr_suffix := R.addr_suffix;
  self.postdir := R.postdir;
  self.unit_desig := R.unit_desig;
  self.sec_range := R.sec_range;
  self.p_city_name := R.p_city_name;
  self.v_city_name := R.v_city_name;
  self.st := R.st;
  self.zip := R.zip;
  self.zip4 := R.zip4;
  self.cart := R.cart;
  self.cr_sort_sz := R.cr_sort_sz;
  self.lot := R.lot;
  self.lot_order := R.lot_order;
  self.dbpc := R.dbpc;
  self.chk_digit := R.chk_digit;
  self.rec_type := R.rec_type;
  self.county := R.county;
  self.geo_lat := R.geo_lat;
  self.geo_long := R.geo_long;
  self.msa := R.msa;
  self.geo_blk := R.geo_blk;
  self.geo_match := R.geo_match;
  self.err_stat := R.err_stat;
  self.did := R.did;
  self.app_ssn := R.app_ssn;
  self.delete_flag := R.delete_flag;
	self := L;
end;
	
	j_NewBK2_BK3	:= join(srt_newBKV3,srt_bkV3,
												left.tmsid = right.tmsid,
												j_New_V3(left,right),left outer,lookup);
												
//Join status/comments back to main
	Layout_Join_MainV3 := record
		BK3_main_tmsid;
		dataset(layout_status) status{xpath('status')};
	end;

	Layout_Join_MainV3 join_MainV3(concat_mainV3 l, concat_statusV3 r) := TRANSFORM
	   self.status 			:= row(R,layout_status);
	   self            	:= l;
	end;

	jn_MainV3 := JOIN(concat_mainV3
								 ,concat_statusV3
								 ,trim(left.tmsid, left, right) = trim(right.tmsid, left, right)
								 ,join_MainV3(left,right)
								 ,left outer);
				 
	j_MainV3	:= sort(distribute(jn_MainV3, hash(tmsid)), tmsid, local);
	
	Layout_Join_AllV3	:= record
		j_MainV3;
		dataset(layout_comments) comments{xpath('comments')};
		unsigned8 __internal_fpos__ := 0;
	end;
								 
	Layout_Join_AllV3 jCommentV3(j_MainV3 L, concat_commentsV3 R) := TRANSFORM
		self.comments := row(R,layout_comments);
		self := L;
END;

//Join comments file
j_AllV3 := join(j_MainV3, concat_commentsV3,
							left.tmsid = right.tmsid,
							jCommentV3(left,right),left outer);
									 
output(count(j_AllV3),named('New_BK3_XML_Count'));
output(j_AllV3, named('BK3_join'));
	
//Build Keys - *change date to reflect current key build version date
Key_bankruptcyv2_main_tmsid := buildindex(j_AllV2, {tmsid}, {j_AllV2}, '~prte::key::bankruptcyv2::'+version_date+'::main::tmsid',overwrite);
Key_bankruptcyv3_main_tmsid := buildindex(j_AllV3, {tmsid}, {j_AllV3}, '~prte::key::bankruptcyv3::'+version_date+'::main::tmsid',overwrite);
Key_bankruptcyv3_fcra_main_tmsid := buildindex(j_AllV3, {tmsid}, {j_AllV3}, '~prte::key::bankruptcyv3::fcra::'+version_date+'::main::tmsid',overwrite);

//sequential(Key_bankruptcyv2_main_tmsid, Key_bankruptcyv3_main_tmsid, Key_bankruptcyv3_fcra_main_tmsid);

//Output XML files
key_bkv2_xml	:= output(j_AllV2,,'~thor_data400::temp::bankruptcy::thor_data400__key__bankruptcyv2____main__tmsid.xml',XML,OVERWRITE);
key_bkv3_xml	:= output(j_AllV3,,'~thor_data400::temp::bankruptcy::thor_data400__key__bankruptcyv3____main__tmsid.xml',XML,OVERWRITE);
key_bkv3_fcra_xml	:= output(j_AllV3,,'~thor_data400::temp::bankruptcy::thor_data400__key__bankruptcyv3__fcra____main__tmsid.xml',XML,OVERWRITE);

//Despray XML files
despray_bk2_xml	:= fileservices.Despray('~thor_data400__key__bankruptcyv2____main__test_tmsid.xml', _Control.IPAddress.edata12, '/data_999/tkirk/prte_extracts/special/thor_data400__key__bankruptcyv2____main__tmsid.xml_updated',,,,true);
despray_bk3_xml	:= fileservices.Despray('~thor_data400::temp::bankruptcy::thor_data400__key__bankruptcyv3____main__tmsid.xml', _Control.IPAddress.edata12, '/data_999/tkirk/prte_extracts/special/thor_data400::temp::bankruptcy::thor_data400__key__bankruptcyv3____main__tmsid.xml_updated',,,,true);
despray_bk3_fcra	:= fileservices.Despray('~thor_data400::temp::bankruptcy::thor_data400__key__bankruptcyv3__fcra____main__tmsid.xml', _Control.IPAddress.edata12, '/data_999/tkirk/prte_extracts/special/thor_data400::temp::bankruptcy::thor_data400__key__bankruptcyv3__fcra____main__tmsid.xml_updated',,,,true);

EXPORT proc_Bankruptcy_prte_xml :=	sequential(key_bkv2_xml,
																							key_bkv3_xml,	
																							key_bkv3_fcra_xml,
																							despray_bk2_xml,
																							despray_bk3_xml,
																							despray_bk3_fcra);