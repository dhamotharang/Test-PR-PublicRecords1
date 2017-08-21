//* Get_payload attribute
IMPORT prte_csv,ut,NID,Doxie,address,_control,PRTE,iesp,ut,Doxie,address,STD,NID,AutoKeyB2,autokey,AutoKeyI;

EXPORT Get_payload := MODULE
	EXPORT Foreclosures := FUNCTION
	

	ds1  := PRTE_CSV.Foreclosure.dthor_data400__key__foreclosure__autokey__payload;
	OUTPUT (ds1,,'~prte::ct::foreclosure::join::payload',OVERWRITE);	
	
	ds1a  := JOIN(ds1,PRTE_CSV.Foreclosure.dthor_data400__key__foreclosure__autokey__address,
					left.fakeid = right.did,	
					left outer
					);
	
	
	ds2  := JOIN(ds1a,PRTE_CSV.Foreclosure.dthor_data400__key__foreclosure__autokey__addressb2,
					left.fakeid = right.bdid,	
	
					left outer
	
					);
					
	
	
	ds3  := JOIN(ds2,PRTE_CSV.Foreclosure.dthor_data400__key__foreclosure__autokey__citystname,
					left.city_code = right.city_code
					and left.st = right.st
					and left.dph_lname = right.dph_lname
					and left.lname = right.lname
					and left.pfname = right.pfname
					and left.fname = right.fname
					and left.states = right.states
					and left.lname1 = right.lname1
					and left.lname2 = right.lname2
					and left.lname3 = right.lname3
					and left.lookups = right.lookups
					and left.did = right.did,
					left outer,
					keep(1)
					);
					
	
	ds4  := JOIN(ds3,PRTE_CSV.Foreclosure.dthor_data400__key__foreclosure__autokey__citystnameb2,
	        left.city_code = right.city_code
						and left.bdid = right.bdid, 
					left outer
						);
	
					
 					
	
	ds5  := JOIN(ds4,PRTE_CSV.Foreclosure.dthor_data400__key__foreclosure__autokey__name,
					left.dph_lname = right.dph_lname
					and left.lname = right.lname
					and left.pfname = right.pfname
					and left.fname = right.fname
					and left.dob = right.dob
					and left.did = right.did,
					left outer,
					keep (1)
					);
					
	ds6 := JOIN(ds5,PRTE_CSV.Foreclosure.dthor_data400__key__foreclosure__autokey__nameb2,
					left.cname_indic = right.cname_indic
					and left.cname_sec = right.cname_sec
					and left.bdid = right.bdid,
					left outer
						);
					
	
	
	ds7 := JOIN(ds6,PRTE_CSV.Foreclosure.dthor_data400__key__foreclosure__autokey__namewords2,
					left.st = right.state
					and left.bdid = right.bdid,
					left outer,
					keep (1)
					);
				
					
					
	ds9 := JOIN(ds7,PRTE_CSV.Foreclosure.dthor_data400__key__foreclosure__autokey__ssn2,
				 left.dph_lname = right.dph_lname
				 and left.pfname = right.pfname
				 and left.did = right.did,
				 left outer,
				 keep (1)
				 );
					
					
	ds10 := JOIN(ds9,PRTE_CSV.Foreclosure.dthor_data400__key__foreclosure__autokey__stname,
				left.st = right.st
				and left.dph_lname = right.dph_lname
				and left.pfname = right.pfname
				and left.minit = right.minit
				and left.yob = right.yob
				and left.dob = right.dob
				and left.states = right.states
				and left.did = right.did,
				left outer,
				keep (1)
				);
				
	ds11 := JOIN(ds10,PRTE_CSV.Foreclosure.dthor_data400__key__foreclosure__autokey__stnameb2,
				left.st = right.st
				and left.cname_indic = right.cname_indic
				and left.cname_sec = right.cname_sec
				and left.bdid = right.bdid,
				left outer,
				keep (1)
				);
				
	
				
	ds12 := JOIN(ds11,PRTE_CSV.Foreclosure.dthor_data400__key__foreclosure__autokey__zip,
				left.zip = (string)right.zip		
				and left.dph_lname = right.dph_lname
				and left.lname = right.lname
				and left.pfname = right.pfname
				and left.fname = right.fname
				and left.minit = right.minit
				and left.yob = right.yob
				and left.dob = right.dob
				and left.did = right.did,
				left outer,
				keep (1)
				);
	
	ds13 := JOIN(ds12,PRTE_CSV.Foreclosure.dthor_data400__key__foreclosure__autokey__zipb2,
				left.zip = (string) right.zip
				and left.cname_indic = right.cname_indic
				and left.cname_sec = right.cname_sec
				and left.bdid = right.bdid,
				left outer,
				keep (1)
				);
	

	
	
EXPORT	ds16  := JOIN(ds13,PRTE_CSV.Foreclosure.dthor_data400__key__foreclosure__fid,
			left.foreclosure_id = right.foreclosure_id,
			left outer

				);		


r:=PRTE_CSV.Foreclosure.dthor_data400__key__foreclosure__bdid(fid<>'');

OUTPUT (PRTE_CSV.Foreclosure.dthor_data400__key__foreclosure__bdid,,'prte::ct::foreclosure::input::bdid',OVERWRITE);
	

EXPORT	ds17 := join(ds16,r
		,left.bdid=right.bdid,
				transform(layouts.layout_foreclosure_expanded_payload,
				self.s4 := (string)left.ssn[4..4],
				self.ssn4 := (integer)left.ssn[6..9],
				self := left),
				left outer
				); 



EXPORT	ds18 := JOIN(ds17,PRTE_CSV.Foreclosure.dthor_data400__key__foreclosure__did,
			left.fid = right.fid,
			transform(layouts.layout_foreclosure_expanded_payload,
				self.did := (integer)IF(left.did <> 0,left.did,right.did),
				self := left),
				left outer,
			keep (1)
				); 	
			
	
	layouts.layout_foreclosure_expanded_payload PROJ_RECS(ds18 l) := transform
	    self.ssn4 := (integer)l.ssn [6..9];  
			self.s4 := (string)l.ssn[4..4];
			self := l;
			self := [];
	end;

	retds := project(ds18,PROJ_RECS(left));   
	
		
	return retds;
	
	END;

//* ===============================================================================*//	
//*         NEW_FORECLOSURES    for     Customer Test                              *//
//* ===============================================================================*//


//*  '~prte::ct::foreclosure::csv::scrambled';
	
	EXPORT File_customer_feed := PRTE2.Files.Foreclosure_Scrambled_DS;

  EXPORT NEW_Foreclosures(string pIndexVersion) := FUNCTION
	
	string8 today_date := ut.GetDate;

//* change this name after spraying the new foreclosure file:
	//* ==============================================================================*
	//* * * * * * *P A Y L O A D
	//* ==============================================================================*
	
//* Add MACROS for FAKEIDs, PARAMS, and FN_BUILD.DO	
 EXPORT rKeyForeclosure_autokey_expanded_payload := RECORD
		PRTE2.layouts.layout_foreclosure_expanded_payload;
 END;
 SHARED forecloserec := RECORD
  autokey.layouts.master AND NOT fakeid;
	rKeyForeclosure_autokey_expanded_payload AND NOT fakeid;
 END;


	 ds_inLayoutMaster_AKB :=  project(File_customer_feed, transform(forecloserec, 
	  string clean_address := address.CleanAddress182(left.address, left.city + ' ' + left.st + ' ' + left.zip);
	  unsigned1	zero := 0;
		unsigned6	property_rid := COUNTER;
		self.inp.fname := 	left.fname; 
		self.inp.mname := 	left.mname; 
		self.inp.lname := 	left.lname; 
		self.inp.ssn := 	if((integer)left.ssn=0,'',(string9)left.ssn); 
		self.inp.dob := 	(integer)left.dob; 
		self.inp.phone      := 	(string10) ''; 
		self.inp.prim_name  := clean_address[13..40]; 
		self.inp.prim_range := clean_address[1..10]; 
		self.inp.st         := clean_address[115..116]; 
		self.inp.city_name  := clean_address[65..89]; 
		self.inp.zip        := clean_address[117..121]; 
		self.inp.sec_range  := left.apt;
		self.inp.states := 	zero; 
		self.inp.lname1 := 	zero; 
		self.inp.lname2 := 	zero; 
		self.inp.lname3 := 	zero; 
		self.inp.city1 := 	zero; 
		self.inp.city2 := 	zero; 
		self.inp.city3 := 	zero; 
		self.inp.rel_fname1 := zero; 
		self.inp.rel_fname2 := zero; 
		self.inp.rel_fname3 := zero; 
		self.inp.lookups    := zero;
		self.inp.DID        := zero;
    self.inp.BDID     := zero;
	SELF.prim_name :=   clean_address [13..40];
	SELF.prim_range :=  clean_address [1..10];
	SELF.st :=    			clean_address[115..116];
	SELF.zip := 				clean_address[117..121];

	self.sec_range := Left.Apt;
	SELF.seq :=  160000 + Counter;

	SELF.bdid := 0;
	SELF.did := 0;
	SELF.did_score := 0;
	SELF.bdid_score := 0;
	SELF.city_code := doxie.Make_CityCode(Left.city);
	SELF.dph_lname := metaphonelib.DMetaPhone1(left.lname);
	SELF.pfname := NID.PreferredFirstVersionedStr(Left.fname,2);
	SELF.lname := Left.lname;
	SELF.fname := Left.fname;
	SELF.minit := Left.mname[1..1];	
	SELF.name_first := Left.fname;
	SELF.name_middle := Left.mname;
	SELF.name_last := Left.lname;
	SELF.site_prim_range := clean_address [1..10];
	SELF.site_predir := clean_address[11..12];
	SELF.site_prim_name := clean_address [13..40];
	SELF.site_addr_suffix := clean_address [41..44];
	Self.site_postdir := clean_address [45..46];
	SELF.site_unit_desig := clean_address [47..56];
	SELF.site_sec_range := left.sec_range_1;
	SELF.site_p_city_name := Left.p_city_name_1;
	SELF.site_v_city_name := Left.p_city_name_1;
	SELF.site_st := clean_address [115..116];
	SELF.site_zip := clean_address [117..121];
	SELF.site_zip4 := clean_address [122..125];
//* new fields:	
  SELF.DOB := IF ((integer)Left.DOB =0, 0, (integer)Left.DOB);
  SELF.ssn :=	if((integer)left.ssn=0,'',(string9)left.ssn); 
	self.ssn4 := if((integer)left.ssn=0, 0, (unsigned) left.ssn[6..9]);
	SELF.yob := IF ((integer)Left.DOB = 0, zero, (integer) Left.DOB [1..4]);
	SELF.s1 := Left.ssn[1..1];
	SELF.s2 := Left.ssn[2..2];
	SELF.s3 := Left.ssn[3..3];
	self.s4 := (string)left.ssn[4..4];
	SELF.s5 := Left.ssn[5..5];
	SELF.s6 := Left.ssn[6..6];
	SELF.s7 := Left.ssn[7..7];
	SELF.s8 := Left.ssn[8..8];
	SELF.s9 := Left.ssn[9..9];
 //*  FID fields:
	SELF.state := clean_address [115..116];
	SELF.county := clean_address [143..145];
	SELF.deed_category := Left.deed_event_type_cd;
	SELF.deed_desc := Left.deed_event_type_desc;
	SELF.document_type := Left.doc_type_cd;
	SELF.document_desc := Left.doc_type_desc;
	SELF.recording_date := Left.deed_recording_date;
	
	SELF.first_defendant_borrower_owner_first_name := Left.fname;
	SELF.first_defendant_borrower_owner_last_name := Left.lname;
	
	SELF.first_defendant_borrower_company_name := Left.ownr_1_cmpny_name;

	SELF.second_defendant_borrower_owner_first_name := '';
	SELF.second_defendant_borrower_owner_last_name := '';	
 	
	SELF.third_defendant_borrower_owner_first_name := '';
	SELF.third_defendant_borrower_owner_last_name := '';
	SELF.fourth_defendant_borrower_owner_first_name := '';
	SELF.fourth_defendant_borrower_owner_last_name := '';
		
	SELF.date_of_default := IF(left.cp_dflt_dt > '' and left.deed_event_type_desc > '', Left.cp_dflt_dt,'20090101');
	SELF.amount_of_default := IF (left.cp_dflt_amt > '' and left.deed_event_type_desc > '', Left.cp_dflt_amt,'12000');
	SELF.filing_date := Left.cp_filing_dt;
	SELF.court_case_nbr := Left.court_case_nbr;
	SELF.plaintiff_1 := Left.plntff1_name;
	SELF.plaintiff_2 := IF(Left.plntff2_name	> '', Left.fname + ' ' + Left.lname, '');
	SELF.auction_date := Left.cp_auction_dt;
	SELF.sales_price := Left.cp_sale_amt;
	SELF.trustee_name := Left.trustee_name;
	SELF.trustee_mailing_address := Left.trustee_addr;
	SELF.trustee_city := Left.trustee_city;
	SELF.trustee_state := Left.trustee_state;
	SELF.trustee_zip := Left.trustee_zipcd;
	SELF.trustee_phone := Left.trustee_phone_nbr;
	self.full_site_address_unparsed_1 := trim(self.site_prim_range,left,right) + ' ' + trim(self.site_prim_name,left,right);
	
      self.situs_house_number_1 := self. site_prim_range;
 		  self.situs_street_name_1  := self.site_prim_name;
			self.situs_house_number_prefix_1 := self.site_predir;
			self.situs_house_number_suffix_1 := self.site_addr_suffix;
			self.property_city_1    := self.site_p_city_name;
			self.property_state_1   := self.site_st;
			self.property_address_zip_code_1 := self.site_zip;
			self.situs1_p_city_name := self.site_p_city_name;
			self.situs1_v_city_name := self.site_p_city_name;
			self.situs1_prim_range  := self.site_prim_range;
			self.situs1_prim_name   := self.site_prim_name;
			self.situs1_postdir     := self.site_postdir;
			self.situs1_predir      := self.site_predir;
			self.situs1_addr_suffix := self.site_addr_suffix;
			self.situs1_unit_desig  := self.site_unit_desig;
			self.situs1_sec_range   := self.site_sec_range;
			self.situs1_st          := self.site_st;
			self.situs1_zip         := self.site_zip;
			self.situs1_zip4        := self.site_zip4;
			self.name1_first        := self.fname;
			self.name1_middle       := self.minit;
			self.name1_last         := self.lname;
	
	
	
	SELF.original_loan_date := Left.orig_loan_dt;
	SELF.original_loan_recording_date := Left.orig_loan_recording_dt;
	SELF.parcel_number_parcel_id := Left.parcel_number_parcel_id;
//*	SELF.parcel_number_unmatched_id := Left.parcel_number_unmatched_id;
	
	self.parcel_number_unmatched_id := IF (left.parcel_number_parcel_id > '', stringlib.stringfilter(Left.parcel_number_parcel_id,
						'0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'), '');
	SELF.property_indicator := Left.property_type_cd;
	SELF.property_desc := Left.property_type_desc;
	SELF.tract_subdivision_name := Left.subdv_name;
	SELF.expanded_legal := Left.expand_legal_desc;
	SELF.legal_2 := Left.legal_desc_2;
	SELF.legal_3 := Left.legal_desc_3;
	SELF.legal_4 := Left.legal_desc_4;
	  	
	self.foreclosure_id				:=	IF(left.parcel_number_unmatched_id <> '',
																	IF(TRIM(left.lname,LEFT,RIGHT) + TRIM(left.fname,LEFT,RIGHT) <> '',
																					StringLib.StringFindReplace(TRIM(left.parcel_number_unmatched_id,LEFT,RIGHT) + TRIM(left.lname,LEFT,RIGHT) + TRIM(left.fname,LEFT,RIGHT), ' ', ''),
																					StringLib.StringFindReplace(TRIM(left.parcel_number_unmatched_id,LEFT,RIGHT) + TRIM(left.ownr_1_cmpny_name,LEFT,RIGHT), ' ', '')
																				),''
	
																			);		
	self.cname_indic := IF(left.lndr_cmpny_name <> '', left.lndr_cmpny_name, left.ownr_1_cmpny_name);																			
	SELF.word :=		TRIM(self.cname_indic,LEFT,RIGHT);
  SELF := left;
	SELF := [];
	self.p := []; 
	self.b := []) ); 	  	
	
	OUTPUT (ds_inLayoutMaster_AKB,,'~prte::ct::foreclosure::input::foreclosure4',OVERWRITE);	
	//* FAKEIDs - generates a payload key file
	fc_dataset		:= ds_inLayoutMaster_AKB;
	fc_keyname    := PRTE2.AK_Constants.fc_keyname;
	fc_qa_keyname := PRTE2.AK_Constants.fc_qa_keyname;
	fc_logical    := PRTE2.AK_Constants.fc_logical(pIndexVersion);
	fc_skipSet    := PRTE2.AK_Constants.fc_skipSet; 
	unsigned1 indid  := 0;
	unsigned6 inbdid := 0;
		
  autokey.mac_useFakeIDs(	fc_dataset,
													ds_withFakeID_AKB, 
													proc_build_payload_key_AKB,
													fc_keyname,
													fc_logical,
													inp.DID,
													inp.BDID
												)	 
	EXPORT ds_forLayoutMaster_AKB	:=	ds_withFakeID_AKB;
	//*++++++++  Add a join for the Person Header Payload to this file, with a 
	//*++++++++  Transform to move the PH DID to the Foreclosure DID
			
	CT_Foreclosure_DID :=PRTE.Get_Header_Base.CT_Foreclosure;
  	
	New_Foreclosures :=  JOIN(ds_forLayoutMaster_AKB,CT_Foreclosure_DID,
					left.lname = right.lname
					and left.fname = right.fname
					and left.st    = right.st
					and left.inp.city_name  = right.p_city_name,
					 transform(layouts.layout_foreclosure_expanded_payload,
				     self.did := right.did,
						 self.fakeid := right.did,
						 self := left,
						 self :=[])			
						,left outer
	          ,keep (1)
					);

//*========================================================*

	retds := New_Foreclosures;
	return retds;		
 END;	

END;