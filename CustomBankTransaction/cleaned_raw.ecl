import ut, lib_stringlib, address, AID, NID;

infile_20130117 := CustomBankTransaction.files.file_in_20130117;
infile_20130117_dedup := dedup(infile_20130117, all);

file_in_20140204 := CustomBankTransaction.files.file_in_20140204;
infile_20140204_dedup := dedup(file_in_20140204, all);

layout_preclean := CustomBankTransaction.layouts.preclean;
Layout_base 	:= CustomBankTransaction.layouts.base;
infile_addr_lookup := CustomBankTransaction.files.branch_addr_lookup_20140204;

layout_preclean tpreclean20130117(infile_20130117_dedup le) := transform

tempcleanzip := trim(lib_stringlib.stringlib.stringfilter(trim(le.zip_cd,left,right),'0123456789'),left, right);
searchpattern := '(.*), (.*), (.*)';
	
bank_parse1 := trim(regexfind(searchpattern, le.Q17_bk_ctr_addr, 1),left,right);
bank_parse2 := trim(regexfind(searchpattern, le.Q17_bk_ctr_addr, 2),left,right);
bank_parse3 := trim(regexfind(searchpattern, le.Q17_bk_ctr_addr, 3),left,right);

ATM_parse1 := trim(regexfind(searchpattern, le.Q22_atm_most_visited_addr, 1),left,right);
ATM_parse2 := trim(regexfind(searchpattern, le.Q22_atm_most_visited_addr, 2),left,right);
ATM_parse3 := trim(regexfind(searchpattern, le.Q22_atm_most_visited_addr, 3),left,right);

  self.address1 := trim(le.addr_line_tx,left,right);
	self.address2 := trim(trim(le.City_tx,left,right) + if(le.City_tx <> '', ', ', ' ') +
									 trim(le.State_cd,left,right) + ' ' +
									if(length(tempcleanzip) = 4, '0'+tempcleanzip,tempcleanzip), left,right);
	self.Q17_bk_ctr_address1 := bank_parse1;
	self.Q17_bk_ctr_address2 := bank_parse2 + ', ' + bank_parse3;
	self.Q22_atm_most_visited_address1 := ATM_parse1;
	self.Q22_atm_most_visited_address2 := ATM_parse2 + ', ' + ATM_parse3;
	self.date_first_seen := (string8)ut.min2(ut.min2((integer)le.Q01_last_ATM_visit_dt, (integer)Le.Q02_atm_last_deposit_dt), (integer)le.Q03_atm_last_withdrawal_dt);
  self.date_last_seen := (string8)ut.max2(ut.max2((integer)le.Q01_last_ATM_visit_dt, (integer)Le.Q02_atm_last_deposit_dt), (integer)le.Q03_atm_last_withdrawal_dt);																																	
  self.process_date := ut.GetDate;
	self.date_vendor_first_reported := self.process_date;
	self.date_vendor_last_reported := self.process_date;
	self := le;
	self := [];
	
	end;
	
preclean_out_20130117 := project(infile_20130117_dedup, tpreclean20130117(left));

//preclean 20140204 chase data
temp_rec := record

layouts.layout_in_20140204;
layouts.layout_branch_addr_lookup - branch_number;

end;

temp_rec tjoinlookup(infile_20140204_dedup le, infile_addr_lookup ri) := transform

self := le;
self := ri;

end;


append_branch_addr_20140204 := join(infile_20140204_dedup, infile_addr_lookup, (unsigned)trim(left.branch_location_number) = (unsigned)trim(right.branch_number),
tjoinlookup(left,right), left outer, lookup);

layout_preclean tpreclean20140204(append_branch_addr_20140204 le) := transform

tempcleanzip := trim(lib_stringlib.stringlib.stringfilter(trim(le.Current_Address_Zip,left,right),'0123456789'),left, right);
tempcleanzip_branch := trim(lib_stringlib.stringlib.stringfilter(trim(le.Zip,left,right),'0123456789'),left, right);
string8 clean_open_date := le.Original_Open_Date[7..10] + le.Original_Open_Date[1..2] + le.Original_Open_Date[4..5];
  
  self.brth_dt := le.DOB;
	self.frst_nm := le.first_name;
	self.mdl_nm  := le.middle_name;
	self.last_nm := le.last_name;
	self.addr_line_tx  :=  le.Current_Address_Street;
	self.city_tx  := le.Current_Address_City;
	self.state_cd := le.Current_Address_state;
	self.zip_cd := le.Current_Address_Zip;
  self.Q16_opn_yr  :=   le.Original_Open_Date[7..10];
  self.Q17_bk_ctr_addr   :=   trim(le.Address) + ', ' + trim(le.City) + ', ' +  le.state  + ' ' + le.Zip;
  self.address1 := trim(le.Current_Address_Street,left,right);
	self.address2 := trim(trim(le.Current_Address_City,left,right) + if(le.Current_Address_City <> '',', ',' ') +
									 trim(le.Current_Address_state,left,right) + ' ' +
									if(length(tempcleanzip) = 4, '0'+tempcleanzip,tempcleanzip), left,right);
	self.Q17_bk_ctr_address1 := trim(le.Address,left,right);
	self.Q17_bk_ctr_address2 := trim(trim(le.city, left, right) + if(le.city <> '', ', ', ' ') +  trim(le.state,left,right) + ' ' +
									if(length(tempcleanzip_branch) = 4, '0'+ tempcleanzip_branch, tempcleanzip_branch), left,right);
	self.open_date := clean_open_date;
	self.process_date := (string8)((integer)ut.getdate - 1);
	self.date_vendor_first_reported := self.process_date;
	self.date_vendor_last_reported  := self.process_date; 
  self := le;
	self := [];
	
	end;
	
preclean_out_20140204 := project(append_branch_addr_20140204, tpreclean20140204(left));

//combine chase 20130117 and 20140204 data

preclean_out := preclean_out_20130117 + preclean_out_20140204;

preclean_out_dedup := dedup(preclean_out, all);
//NID
Nid.Mac_CleanParsedNames(preclean_out_dedup, nameID_out,frst_nm, mdl_nm, last_nm, suffix_nm);

pre_AID := nameID_out : persist('~thor_data400::persist::chase_nameID_comb');
//AID
			//append AID for person address
/*unsigned4		lAIDAppendFlags	:=	AID.Common.eReturnValues.RawAID 
																| 	AID.Common.eReturnValues.ACECacheRecords;		
AID.MacAppendFromRaw_2Line(pre_AID, Address1, Address2, Append_RawAID, addressID_out,lAIDAppendFlags);
*/
	
Layout_base cleanaddress(pre_AID le) := transform
string182 clean_address := Address.CleanAddress182(le.address1, le.address2);																								   	
string182 clean_bk_address := Address.CleanAddress182(le.Q17_bk_ctr_address1, le.Q17_bk_ctr_address2);																								   
string182 clean_atm_address := Address.CleanAddress182(le.Q22_atm_most_visited_address1, le.Q22_atm_most_visited_address2);																								   

  self.ssn := if((unsigned)le.ssn > 0, le.ssn, '');
	self.Q04_ATM_last_deposit_amt    := (decimal8_2)le.Q04_ATM_last_deposit_amt;
  self.Q05_ATM_last_withdrawal_amt := (decimal8_2)le.Q05_ATM_last_withdrawal_amt;               
  self.Q08_last_ach_dep_amt       := (decimal8_2)le.Q08_last_ach_dep_amt;
	self.Q10_last_dep_amt           :=  (decimal8_2)le.Q10_last_dep_amt;
  self.Q12_debit_signature_last_amt := (decimal8_2)le.Q12_debit_signature_last_amt;
  self.Q14_debit_pin_last_amt       := (decimal8_2)le.Q14_debit_pin_last_amt;
  self.Q18_last_chk_amt             := (decimal8_2)le.Q18_last_chk_amt; 
	self.title 			:= le.cln_title;
self.fname 			:= le.cln_fname;
self.mname 			:= le.cln_mname;
self.lname 			:= le.cln_lname;
self.name_suffix 	:= le.cln_suffix;
//append person clean address
self.prim_range    := clean_address[1..10];
self.predir        := clean_address[11..12]	;
self.prim_name     := clean_address[13..40];
self.addr_suffix     := clean_address[41..44];
self.postdir        := clean_address[45..46];
self.unit_desig	   :=	clean_address[47..56];
self.sec_range     := clean_address[57..64];
self.p_city_name    := clean_address[65..89];
self.v_city_name     := clean_address[90..114];
self.st            := clean_address[115..116];
self.zip           := clean_address[117..121]; 	
self.zip4          := clean_address[122..125];	
self.cart		   :=	clean_address[126..129];
self.cr_sort_sz	   :=	clean_address[130];
self.lot		   :=	clean_address[131..134];
self.lot_order		:=	clean_address[135];
self.dbpc		    :=	clean_address[136..137];
self.chk_digit		:=	clean_address[138];
self.rec_type	    :=	clean_address[139..140]	;
self.fips_state := clean_address[141..142];
self.fips_county		:=   clean_address[143..145];
self.geo_lat		:=	clean_address[146..155];
self.geo_long		:=	clean_address[156..166];
self.msa			:=	clean_address[167..170];
self.geo_blk		:=	clean_address[171..177];
self.geo_match		:=	clean_address[178];
self.err_stat		:=	clean_address[179..182]	;
//append bank clean address 
self.Q17_bk_ctr_addr_clean.prim_range    := clean_bk_address[1..10];
self.Q17_bk_ctr_addr_clean.predir        := clean_bk_address[11..12]	;
self.Q17_bk_ctr_addr_clean.prim_name     := clean_bk_address[13..40];
self.Q17_bk_ctr_addr_clean.addr_suffix     := clean_bk_address[41..44];
self.Q17_bk_ctr_addr_clean.postdir        := clean_bk_address[45..46];
self.Q17_bk_ctr_addr_clean.unit_desig	   :=	clean_bk_address[47..56];
self.Q17_bk_ctr_addr_clean.sec_range     := clean_bk_address[57..64];
self.Q17_bk_ctr_addr_clean.p_city_name    := clean_bk_address[65..89];
self.Q17_bk_ctr_addr_clean.v_city_name     := clean_bk_address[90..114];
self.Q17_bk_ctr_addr_clean.st            := clean_bk_address[115..116];
self.Q17_bk_ctr_addr_clean.zip           := clean_bk_address[117..121]; 	
self.Q17_bk_ctr_addr_clean.zip4          := clean_bk_address[122..125];	
self.Q17_bk_ctr_addr_clean.cart		   :=	clean_bk_address[126..129];
self.Q17_bk_ctr_addr_clean.cr_sort_sz	   :=	clean_bk_address[130];
self.Q17_bk_ctr_addr_clean.lot		   :=	clean_bk_address[131..134];
self.Q17_bk_ctr_addr_clean.lot_order		:=	clean_bk_address[135];
self.Q17_bk_ctr_addr_clean.dbpc		    :=	clean_bk_address[136..137];
self.Q17_bk_ctr_addr_clean.chk_digit		:=	clean_bk_address[138];
self.Q17_bk_ctr_addr_clean.rec_type	    :=	clean_bk_address[139..140]	;
self.Q17_bk_ctr_addr_clean.fips_state := clean_bk_address[141..142];
self.Q17_bk_ctr_addr_clean.fips_county		:=   clean_bk_address[143..145];
self.Q17_bk_ctr_addr_clean.geo_lat		:=	clean_bk_address[146..155];
self.Q17_bk_ctr_addr_clean.geo_long		:=	clean_bk_address[156..166];
self.Q17_bk_ctr_addr_clean.msa			:=	clean_bk_address[167..170];
self.Q17_bk_ctr_addr_clean.geo_blk		:=	clean_bk_address[171..177];
self.Q17_bk_ctr_addr_clean.geo_match		:=	clean_bk_address[178];
self.Q17_bk_ctr_addr_clean.err_stat		:=	clean_bk_address[179..182]	;
//append ATM clean address
self.Q22_atm_most_visited_addr_clean.prim_range    := clean_atm_address[1..10];
self.Q22_atm_most_visited_addr_clean.predir        := clean_atm_address[11..12]	;
self.Q22_atm_most_visited_addr_clean.prim_name     := clean_atm_address[13..40];
self.Q22_atm_most_visited_addr_clean.addr_suffix     := clean_atm_address[41..44];
self.Q22_atm_most_visited_addr_clean.postdir        := clean_atm_address[45..46];
self.Q22_atm_most_visited_addr_clean.unit_desig	   :=	clean_atm_address[47..56];
self.Q22_atm_most_visited_addr_clean.sec_range     := clean_atm_address[57..64];
self.Q22_atm_most_visited_addr_clean.p_city_name    := clean_atm_address[65..89];
self.Q22_atm_most_visited_addr_clean.v_city_name     := clean_atm_address[90..114];
self.Q22_atm_most_visited_addr_clean.st            := clean_atm_address[115..116];
self.Q22_atm_most_visited_addr_clean.zip           := clean_atm_address[117..121]; 	
self.Q22_atm_most_visited_addr_clean.zip4          := clean_atm_address[122..125];	
self.Q22_atm_most_visited_addr_clean.cart		   :=	clean_atm_address[126..129];
self.Q22_atm_most_visited_addr_clean.cr_sort_sz	   :=	clean_atm_address[130];
self.Q22_atm_most_visited_addr_clean.lot		   :=	clean_atm_address[131..134];
self.Q22_atm_most_visited_addr_clean.lot_order		:=	clean_atm_address[135];
self.Q22_atm_most_visited_addr_clean.dbpc		    :=	clean_atm_address[136..137];
self.Q22_atm_most_visited_addr_clean.chk_digit		:=	clean_atm_address[138];
self.Q22_atm_most_visited_addr_clean.rec_type	    :=	clean_atm_address[139..140]	;
self.Q22_atm_most_visited_addr_clean.fips_state := clean_atm_address[141..142];
self.Q22_atm_most_visited_addr_clean.fips_county		:=   clean_atm_address[143..145];
self.Q22_atm_most_visited_addr_clean.geo_lat		:=	clean_atm_address[146..155];
self.Q22_atm_most_visited_addr_clean.geo_long		:=	clean_atm_address[156..166];
self.Q22_atm_most_visited_addr_clean.msa			:=	clean_atm_address[167..170];
self.Q22_atm_most_visited_addr_clean.geo_blk		:=	clean_atm_address[171..177];
self.Q22_atm_most_visited_addr_clean.geo_match		:=	clean_atm_address[178];
self.Q22_atm_most_visited_addr_clean.err_stat		:=	clean_atm_address[179..182]	;
	self                          			:= le;
  end;

 cleaned_addr := project(pre_AID, cleanaddress(left)): persist('~thor_data400::persist::chase_clean_address_comb');

export Cleaned_raw := cleaned_addr;
  
 


	