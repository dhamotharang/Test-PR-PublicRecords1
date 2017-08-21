IMPORT PRTE2_PhonesPlus, Phonesplus_v2, header, Business_Header, MDR, _validate;

EXPORT as_headers := MODULE

	header.Layout_New_Records MapPeopleHeader(PRTE2_PhonesPlus.Layouts.Base_ext l) := TRANSFORM
	  self.did := l.did;
	  self.rid := 0;
		SELF.dt_first_seen 	           := l.DateFirstSeen;
		SELF.dt_last_seen 	           := l.DateLastSeen;
		SELF.dt_vendor_first_reported  := l.DateVendorFirstReported;
		SELF.dt_vendor_last_reported 	 := l.DateVendorLastReported;
	  self.dt_nonglb_last_seen 			 := l.dt_nonglb_last_seen;
	  self.rec_type 	:= (string1)l.orig_rec_type;
	  self.vendor_id 	:= l.cust_name;
	  self.dob 				:= (integer4)l.dob;
	  self.ssn 				:= l.cust_ssn;
	  self.city_name 	:= l.v_city_name;
		self.st					:= l.state;
		self.zip				:=	l.zip5;
	  self.phone 			:= IF(trim(l.orig_phone) = '', trim(l.cellphone),trim(l.orig_phone));
	  self.title 			:= l.title;
	  self.fname 			:= l.fname;
	  self.mname 			:= l.mname;
	  self.lname 			:= l.lname;
	  self.name_suffix := l.name_suffix;
	  self.county 		:= '';
	  self.cbsa 			:= if(l.msa!='',l.msa+'0','');
	  self.src 				:= MDR.sourceTools.src_Phones_Plus;
	  self.suffix 		:= l.addr_suffix;
	  self            := l;
		self            := [];
	 END;
		
	EXPORT person_header_phones := project(PRTE2_PhonesPlus.Files.f_phonesplus_ext(did<>0), MapPeopleHeader(left));
	
	//Business Header
	Ph_Business := PRTE2_PhonesPlus.Files.f_phonesplus_ext(orig_listing_type<>'', orig_publish_code IN ['P','U'], current_rec = true);
	
	Business_Header.Layout_Business_Header_New tPhonesAsBusinessHeader(Ph_Business l)	:=  TRANSFORM
		self.source 						:=	MDR.sourceTools.src_Phones_Plus;
		self.dt_first_seen 			:=	(unsigned4)l.DateFirstSeen;
		self.dt_last_seen 			:=	(unsigned4)l.DateLastSeen;
		self.dt_vendor_last_reported	:=	(unsigned4)l.DateVendorLastReported;
		self.dt_vendor_first_reported	:=	(unsigned4)l.DateVendorFirstReported;
		self.vl_id					    :=	l.cust_name;
		self.vendor_id					:=	self.vl_id;
		self.prim_range					:=	l.prim_range;
		self.predir							:=	l.predir;
		self.prim_name					:=	l.prim_name;
		self.addr_suffix				:=	l.addr_suffix;
		self.postdir						:=	l.postdir;
		self.unit_desig					:=	l.unit_desig;
		self.sec_range					:=	l.sec_range;
		self.city								:=	l.v_city_name;
		self.state							:=	l.state;
		self.zip								:=	(unsigned)l.zip5;
		self.zip4								:=	(unsigned)l.zip4;
		self.county							:=	'';
		self.msa								:=	l.msa;
		self.geo_lat						:=	l.geo_lat;
		self.geo_long						:=	l.geo_long;
		self.current						:=	true;
		self.phone							:=	(unsigned)l.CellPhone;
		self.company_name				:=	l.OrigName;
		self.bdid								:=	l.bdid;
	  END;
		
		EXPORT business_header_phones	:= PROJECT(Ph_Business(bdid <> 0), tPhonesAsBusinessHeader(left));
		
		//For Business records with contacts -- Records do not contain a contact AND a business name
	
END;
