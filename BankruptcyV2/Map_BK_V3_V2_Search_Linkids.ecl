import BIPV2;
dsMain		:=	distribute(BankruptcyV2.file_bankruptcy_main_v3,hash(tmsid));

dsSearch	:=	distribute(BankruptcyV2.file_bankruptcy_search_v3_bip,hash(tmsid));

layout_bankruptcy_search_linkids := record
BankruptcyV2.layout_bankruptcy_search;
bipv2.IDlayouts.l_xlink_ids
end;


layout_bankruptcy_search_linkids trfSearch(dsSearch input) := transform
	self := input;
end;

layout_bankruptcy_search_linkids trfSearch2(dsMain input) := transform,skip(trim(input.TrusteeName,left,right)='' and trim(input.trusteeAddress,left,right) = '')
	self.process_date 		:=	input.process_date;
	self.TMSID 				:=	input.TMSID;
	self.seq_number			:=	input.seq_number;
	self.court_code			:=	input.court_code;
	self.case_number		:=	input.case_number;
	self.orig_case_number	:=	input.orig_case_number;
	self.debtor_type 		:=	'';
	self.debtor_seq			:=	'';
	self.ssn				:=	'';
	self.tax_id				:=	'';
	self.name_type			:=	'T1'; 
	self.orig_name			:=	input.TrusteeName; 
	self.orig_addr1			:=	input.trusteeAddress;
	self.orig_city			:=	input.trusteeCity;
	self.orig_st			:= 	input.trusteeState; 
	self.orig_zip5			:=	input.trusteeZip; 
	self.orig_zip4			:=	input.trusteezip4;
	self.phone				:=	input.trusteePhone; 
	self.DID				:=  input.DID;
	self.date_first_seen	:= 	input.date_first_seen;
	self.date_last_seen		:= 	input.date_last_seen;
	self.date_vendor_first_reported	:= input.date_vendor_first_reported;
	self.date_vendor_last_reported 	:= input.date_vendor_last_reported;
	self					:= 	input;
	self					:= 	[];
end;

fileSearch1 := 	project(dsSearch,trfSearch(left));// : persist('persist::bkv2::search1');

fileSearch2	:=	project(dsMain, trfSearch2(left));// : persist('persist::bkv2::search2');

export Map_BK_V3_V2_Search_Linkids := sort(distribute((fileSearch1 + fileSearch2),hash(tmsid)), tmsid,local);