//Pull out Trustees from the current V2 search file. These will be moved to the V3 main file. 
searchTrust	:=	sort(distribute(BankruptcyV2.file_bankruptcy_search(trim(name_type,left,right)='T1'),hash(tmsid)),tmsid,local);

main		:=	sort(distribute(BankruptcyV2.file_bankruptcy_main,hash(tmsid)),tmsid,local);

BankruptcyV2.layout_bankruptcy_main_v3.layout_bankruptcy_main_filing	joinForNewMain(bankruptcyV2.Layout_bankruptcy_main.layout_bankruptcy_main_filing l, BankruptcyV2.layout_bankruptcy_search r)	:=	transform
	self.process_date	:=	r.process_date;	
	self.trusteeName	:=	r.orig_name;
	self.trusteeAddress	:=	r.orig_addr1;
	self.trusteeCity	:=	r.orig_city;
	self.trusteeState	:= 	r.orig_st;
	self.trusteeZip		:=	r.orig_zip5;
	self.trusteeZip4	:=	r.orig_zip4;
	self.trusteePhone	:=	r.phone;
	self				:=	l;
	self				:=	r;	
	self				:=	[];
end;

// Join the trustees from the search file to the cases from the main file to create new V3 main file layout. 
export Map_BK_V2_V3_Main	:=	sort(distribute(join(main, searchTrust, trim(left.TMSID,left,right) = trim(right.TMSID,left,right), joinForNewMain(left, right),left outer, local),hash(tmsid)),tmsid,local);	

