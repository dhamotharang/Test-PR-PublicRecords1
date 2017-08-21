import liensv2, lib_stringlib, address;

//////////////////////////////////////////////////////////////////////////////////////////////////
////////
////////MA STATEWIDE WRITS, CHILDSUPPORT LIENS, WELFARE LIENS 
////////
//////////////////////////////////////////////////////////////////////////////////////////////////

//////// JOIN WRIT NAME, WRITS, AND WRIT TYPES

writ_layout := record, maxlength(4096)
  string  FilingNumber;
  string  FilingLetter;
  string  FilingDate;
  string  FilingDischargeDate;
  string  FilingDateStamp;
  string  FilingIDStamp;
  string  Name;
  string  SearchName;
  string  NameType;
  string  FilingType;
  string  FilingDescription;
end;

writ_layout joinWrits(liensv2.layout_MA_in.Writ l, liensv2.layout_MA_in.WritType r) := transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

	self.filingDate := stringlib.stringfindreplace(fSlashedMDYtoCYMD((l.filingdate + ' ')[1..stringlib.stringfind(l.filingdate, ' ', 1)]), '00000000', '');
	self.FilingDischargeDate := stringlib.stringfindreplace(fSlashedMDYtoCYMD((l.FilingDischargeDate + ' ')[1..stringlib.stringfind(l.FilingDischargeDate, ' ', 1)]), '00000000', '');
	self.filingDateStamp := stringlib.stringfindreplace(fSlashedMDYtoCYMD((l.filingDateStamp + ' ')[1..stringlib.stringfind(l.filingDateStamp, ' ', 1)]), '00000000', '');
	self := l;
	self := r;
	self := [];
end;

writout := join(liensv2.file_MA_in.Writ, liensv2.file_MA_in.WritType, left.filingtype = right.filingtype, joinWrits(left, right), lookup);

writ_layout joinWritsName(liensv2.layout_MA_in.WritName l, writout r) := transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

	self := l;
	self := r;
	self := [];
end;

Writs := join(liensv2.file_MA_in.WritName, writout,left.FilingLetter = right.FilingLetter and left.FilingNumber = right.FilingNumber, joinWritsName(left, right));

/////////////// REFORMAT WRITS

liensV2.Layout_Liens_temp_base main_mapping_format(Writs L) := transform

// preCleanName		:= StringLib.StringFilter(StringLib.StringToUpperCase(l.name),
					   // ' -\'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); 

// CleanName			:= Address.CleanPersonLFM73(preCleanName);


self.tmsid  := 'MA'+'WRIT'+l.filingnumber;//trim(L.tmsid) ;
self.rmsid  := 'MA'+'WRIT'+l.filingnumber+l.filingletter;//L.rmsid;
self.process_date := StringLib.GetDateYYYYMMDD();
self.record_code  := L.FilingNumber;
self.ADDDELFLAG := '';
self.date_vendor_removed:= '';
self.filing_jurisdiction := 'MA';
self.filing_state := '';
self.orig_filing_number := L.FilingNumber;
self.orig_filing_type   := l.filingtype;
self.orig_filing_date   := L.filingdate;
self.orig_filing_time   := '';
self.filing_status      := '';
self.case_number        := '';
self.filing_number  := L.FilingNumber;
self.filing_type   := l.filingtype;
self.filing_type_desc := if(l.filingtype <> 'W', 'WRIT - ' + l.filingdescription, l.filingdescription);
self.filing_date := L.filingdatestamp;
self.filing_time := '';
self.vendor_entry_date := '';
self.judge := '';
self.case_title := '';
self.filing_book  := '';//L.book;
self.filing_page  := '';//L.page;
self.release_date := L.filingdischargedate; //L.ORIGLIEN;
self.amount       := '';//L.amount;
self.eviction     := '';//L.UNLAWDETYN;
self.judg_satisfied_date := '';
self.judg_vacated_date := '';
self.tax_code := '';
self.irs_serial_number := '';//if(L.FILETYPEID = 'FR' or L.FILETYPEID = 'FT', L.othercase, '');
self.effective_date    := '';
self.lapse_date        := '';
self.orig_full_debtorname := '';
self.debtor_name := if(l.nametype = 'D', L.name, ''); 
self.debtor_lname:= '';
self.debtor_fname:= '';
self.debtor_mname:= '';
self.debtor_suffix := '';//L.generation;
self.debtor_tax_id := '';//if(L.INDIVBUSUN ='I' and (L.AKA_YN = ' ' or L.AKA_YN = 'I'), '', L.ssn);
self.debtor_ssn    := '';//if(L.INDIVBUSUN ='I' and (L.AKA_YN = ' ' or L.AKA_YN = 'I'), L.ssn, '');
self.debtor_address1 := '';//L.address;
self.debtor_address2 := '';
self.debtor_city     := '';//L.city;
self.debtor_state    := '';//L.state;
self.debtor_zip5     := '';//L.zip;
self.debtor_zip4     := '';
self.debtor_country  := '';
self.creditor_name   := if(l.nametype = 'P', L.name, '');
self.creditor_address1 := '';
self.creditor_address2 := '';
self.creditor_city     := '';
self.creditor_state    := '';
self.creditor_zip5     := '';
self.creditor_zip4     := '';
self.creditor_country  := '';
self.atty_Name         := '';//L.ATTORNEY;
self.atty_address1      :='';// L.ATYADDRESS;
self.atty_city         :='';// L.ATYCITY;
self.atty_state        := '';//L.ATYSTATE;
self.atty_zip5          := '';//L.ATYZIP;
self.atty_phone        := '';//L.attorphone;
self.agency            := '';//L.court_description;
self.agency_city       := '';
self.agency_state      := 'MA';//L.courtid[1..2];
self.agency_county     := '';//L.county_name ;
self.clean_debtor_title						:= if(l.nametype ='P', '', Address.Clean_n_Validate_Name(l.name,'L', 75, 3, false).CleanNameRecord.title);
self.clean_debtor_fname						:= if(l.nametype ='P', '', Address.Clean_n_Validate_Name(l.name,'L', 75, 3, false).CleanNameRecord.fname);
self.clean_debtor_mname						:= if(l.nametype ='P', '', Address.Clean_n_Validate_Name(l.name,'L', 75, 3, false).CleanNameRecord.mname);
self.clean_debtor_lname						:= if(l.nametype ='P', '', Address.Clean_n_Validate_Name(l.name,'L', 75, 3, false).CleanNameRecord.lname);
self.clean_debtor_name_suffix	   				:= if(l.nametype ='P', '', Address.Clean_n_Validate_Name(l.name,'L', 75, 3, false).CleanNameRecord.name_suffix);
self.clean_debtor_score				:= if(l.nametype ='P', '', Address.Clean_n_Validate_Name(l.name,'L', 75, 3, false).CleanNameRecord.name_score);
self.clean_creditor_title						:= if(l.nametype ='D', '', Address.Clean_n_Validate_Name(l.name,'L', 75, 3, false).CleanNameRecord.title);
self.clean_creditor_fname						:= if(l.nametype ='D', '', Address.Clean_n_Validate_Name(l.name,'L', 75, 3, false).CleanNameRecord.fname);
self.clean_creditor_mname						:= if(l.nametype ='D', '', Address.Clean_n_Validate_Name(l.name,'L', 75, 3, false).CleanNameRecord.mname);
self.clean_creditor_lname						:= if(l.nametype ='D', '', Address.Clean_n_Validate_Name(l.name,'L', 75, 3, false).CleanNameRecord.lname);
self.clean_creditor_name_suffix	   				:= if(l.nametype ='D', '', Address.Clean_n_Validate_Name(l.name,'L', 75, 3, false).CleanNameRecord.name_suffix);
self.clean_creditor_score				:= if(l.nametype ='D', '', Address.Clean_n_Validate_Name(l.name,'L', 75, 3, false).CleanNameRecord.name_score);
self.clean_debtor_cname := if(l.nametype ='D' and Address.Clean_n_Validate_Name(l.name,'L', 75, 3, false).lname = '', l.name, '');
self.clean_creditor_cname := if(l.nametype ='P' and Address.Clean_n_Validate_Name(l.name,'L', 75, 3, false).lname = '', l.name, '');
self := [];
end;

/////////////// REFORMAT CHILD SUPPORT

liensV2.Layout_Liens_temp_base main_mapping_format2(liensv2.layout_ma_in.childsupport L) := transform

preCleanName		:= StringLib.StringFilter(StringLib.StringToUpperCase(l.lastname + ', ' + l.firstname),
					   ' -\'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); 

CleanName			:= Address.CleanPersonLFM73(preCleanName);

CleanAddress		:= Address.CleanAddress182(l.street, l.city + ', ' + l.state + ' ' + l.zipcode);

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.tmsid  := 'MA'+'CHSUP'+l.filingnumber;//trim(L.tmsid) ;
self.rmsid  := 'MA'+'CHSUP'+l.filingnumber;//L.rmsid;
self.process_date := StringLib.GetDateYYYYMMDD();
self.record_code  := L.FilingNumber;
self.ADDDELFLAG := '';
self.date_vendor_removed:= '';
self.filing_jurisdiction := 'MA';
self.filing_state := '';
self.orig_filing_number := L.FilingNumber;
self.orig_filing_type   := '';
self.orig_filing_date   := stringlib.stringfindreplace(fSlashedMDYtoCYMD(l.filingdate), '00000000', '');
self.orig_filing_time   := '';
self.filing_status      := '';
self.case_number        := '';
self.filing_number  := L.FilingNumber;
self.filing_type_desc := 'Child Support Lien';
self.filing_date := stringlib.stringfindreplace(fSlashedMDYtoCYMD(l.filingdate), '00000000', '');
self.filing_time := '';
self.vendor_entry_date := '';
self.judge := '';
self.case_title := '';
self.filing_book  := '';//L.book;
self.filing_page  := '';//L.page;
self.release_date := stringlib.stringfindreplace(fSlashedMDYtoCYMD(l.releasedate), '00000000', ''); //L.ORIGLIEN;
self.amount       := regexreplace('[^\\.0-9]', L.lienamount, '');
self.eviction     := '';//L.UNLAWDETYN;
self.judg_satisfied_date := '';
self.judg_vacated_date := '';
self.tax_code := '';
self.irs_serial_number := '';//if(L.FILETYPEID = 'FR' or L.FILETYPEID = 'FT', L.othercase, '');
self.effective_date    := '';
self.lapse_date        := '';
self.orig_full_debtorname := '';
self.debtor_name := L.lastname + ', ' + l.firstname; 
self.debtor_lname:= L.lastname;
self.debtor_fname:= l.firstname;
self.debtor_mname:= '';
self.debtor_suffix := '';//L.generation;
self.debtor_tax_id := '';//if(L.INDIVBUSUN ='I' and (L.AKA_YN = ' ' or L.AKA_YN = 'I'), '', L.ssn);
self.debtor_ssn    := if(l.last4ssn <> '', '00000' + l.last4ssn, '');//if(L.INDIVBUSUN ='I' and (L.AKA_YN = ' ' or L.AKA_YN = 'I'), L.ssn, '');
self.debtor_address1 := L.street;
self.debtor_address2 := '';
self.debtor_city     := L.city;
self.debtor_state    := L.state;
self.debtor_zip5     := L.zipcode[1..5];
self.debtor_zip4     := stringlib.stringfilter(L.zipcode, '0123465789')[6..9];
self.debtor_country  := '';
self.agency            := '';//L.court_description;
self.agency_city       := '';
self.agency_state      := 'MA';//L.courtid[1..2];
self.agency_county     := '';//L.county_name ;

self.clean_debtor_prim_range 	:= CleanAddress[1..10]; 
self.clean_debtor_predir 		:= CleanAddress[11..12];					   
self.clean_debtor_prim_name 		:= CleanAddress[13..40];
self.clean_debtor_addr_suffix 	:= CleanAddress[41..44];
self.clean_debtor_postdir 		:= CleanAddress[45..46];
self.clean_debtor_unit_desig 	:= CleanAddress[47..56];
self.clean_debtor_sec_range 		:= CleanAddress[57..64];
self.clean_debtor_p_city_name 	:= CleanAddress[65..89];
self.clean_debtor_v_city_name 	:= CleanAddress[90..114];
self.clean_debtor_st 			:= if(CleanAddress[115..116]='',ziplib.ZipToState2(CleanAddress[117..121]),CleanAddress[115..116]);
self.clean_debtor_zip 			:= CleanAddress[117..121];
self.clean_debtor_zip4 			:= CleanAddress[122..125];
self.clean_debtor_cart 			:= CleanAddress[126..129];
self.clean_debtor_cr_sort_sz 	:= CleanAddress[130];
self.clean_debtor_lot 			:= CleanAddress[131..134];
self.clean_debtor_lot_order 		:= CleanAddress[135];
self.clean_debtor_dpbc 			:= CleanAddress[136..137];
self.clean_debtor_chk_digit 		:= CleanAddress[138];
self.clean_debtor_record_type 		:= CleanAddress[139..140];
self.clean_debtor_ace_fips_st	:= CleanAddress[141..142];
self.clean_debtor_fipscounty:= CleanAddress[143..145];
self.clean_debtor_geo_lat 		:= CleanAddress[146..155];
self.clean_debtor_geo_long 		:= CleanAddress[156..166];
self.clean_debtor_msa 			:= CleanAddress[167..170];
// self.clean_debtor_geo_blk 		:= CleanAddress[171..177];
self.clean_debtor_geo_match 		:= CleanAddress[178];
self.clean_debtor_err_stat 		:= CleanAddress[179..182];

self.clean_debtor_title 			:= CleanName[1..5];
self.clean_debtor_fname 			:= CleanName[6..25];
self.clean_debtor_mname 			:= CleanName[26..45];
self.clean_debtor_lname 			:= CleanName[46..65];
self.clean_debtor_name_suffix 	:= CleanName[66..70];
self.clean_debtor_score := CleanName[71..73];
self := [];
end;

/////////////// REFORMAT WELFARE LIENS

liensV2.Layout_Liens_temp_base main_mapping_format3(liensv2.layout_ma_in.welflien L) := transform

preCleanName		:= StringLib.StringFilter(StringLib.StringToUpperCase(l.name),
					   ' -\'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); 

CleanName			:= Address.CleanPersonLFM73(preCleanName);

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.tmsid  := 'MA'+'WEFL'+l.filingnumber;//trim(L.tmsid) ;
self.rmsid  := 'MA'+'WEFL'+l.filingnumber;//L.rmsid;
self.process_date := StringLib.GetDateYYYYMMDD();
self.record_code  := L.FilingNumber;
self.ADDDELFLAG := '';
self.date_vendor_removed:= '';
self.filing_jurisdiction := 'MA';
self.filing_state := '';
self.orig_filing_number := L.FilingNumber;
self.orig_filing_type   := '';
self.orig_filing_date   := stringlib.stringfindreplace(fSlashedMDYtoCYMD(l.filingdate), '00000000', '');
self.orig_filing_time   := '';
self.filing_status      := '';
self.case_number        := '';
self.filing_number  := L.FilingNumber;
self.filing_type_desc := 'Welfare Lien';
self.filing_date := stringlib.stringfindreplace(fSlashedMDYtoCYMD(l.filingdate), '00000000', '');
self.filing_time := '';
self.vendor_entry_date := '';
self.judge := '';
self.case_title := '';
self.filing_book  := '';//L.book;
self.filing_page  := '';//L.page;
self.release_date := stringlib.stringfindreplace(fSlashedMDYtoCYMD(l.releasedate), '00000000', ''); //L.ORIGLIEN;
self.amount       := '';
self.eviction     := '';//L.UNLAWDETYN;
self.judg_satisfied_date := '';
self.judg_vacated_date := '';
self.tax_code := '';
self.irs_serial_number := '';//if(L.FILETYPEID = 'FR' or L.FILETYPEID = 'FT', L.othercase, '');
self.effective_date    := '';
self.lapse_date        := '';
self.orig_full_debtorname := '';
self.debtor_name := L.name; 
self.debtor_lname:= '';
self.debtor_fname:= '';
self.debtor_mname:= '';
self.debtor_suffix := '';//L.generation;
self.debtor_tax_id := '';//if(L.INDIVBUSUN ='I' and (L.AKA_YN = ' ' or L.AKA_YN = 'I'), '', L.ssn);
self.debtor_ssn    := '';
self.agency            := '';//L.court_description;
self.agency_city       := '';
self.agency_state      := 'MA';//L.courtid[1..2];
self.agency_county     := '';//L.county_name ;

self.clean_debtor_title 			:= CleanName[1..5];
self.clean_debtor_fname 			:= CleanName[6..25];
self.clean_debtor_mname 			:= CleanName[26..45];
self.clean_debtor_lname 			:= CleanName[46..65];
self.clean_debtor_name_suffix 	:= CleanName[66..70];
self.clean_debtor_score := CleanName[71..73];
self := [];
end;
///////////////////////////////////////////////

export Mapping_MA := 
project(liensv2.file_MA_in.welflien(FilingNumber <> 'FilingNumber'), main_mapping_format3(left)) 
+ 
project(liensv2.file_MA_in.childsupport(FilingNumber <> 'FilingNumber'), main_mapping_format2(left)) 
+ 
project(writs(FilingNumber <> 'FilingNumber'), main_mapping_format(left))
// Writs
;