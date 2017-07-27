IMPORT ut, Business_Header;

dIn :=File_base(company<>'');
	//*********************************************************************************
	// Translate Contacts from Taxpro to Business Contact Format
	//*********************************************************************************

Business_Header.Layout_Business_Contact_Full Translate_Taxpro_to_BCF(dIn pInput)
:= TRANSFORM
	SELF.company_title 		:= '';   
	SELF.name_score    		:= Business_Header.CleanName(pInput.name.fname,pInput.name.mname,pInput.name.lname,pInput.name.name_suffix)[142];
	SELF.addr_suffix   		:= pInput.addr.addr_suffix;
	SELF.city 	      	 	:= pInput.addr.v_city_name;
	SELF.zip           		:= (UNSIGNED3)pInput.addr.zip5;
	SELF.zip4          		:= (UNSIGNED2)pInput.addr.zip4;
	SELF.source 		    := 'TP';
	SELF.record_type 		:= 'N';
	SELF.company_name  		:= pInput.company;
	SELF.vendor_id 	   		:= 'TP'+hash(pInput.company);
	SELF.company_prim_range := pInput.addr.prim_range;
	SELF.company_predir 	:= pInput.addr.predir;
	SELF.company_prim_name 	:= pInput.addr.prim_name;
	SELF.company_addr_suffix:= pInput.addr.addr_suffix;
	SELF.company_postdir 	:= pInput.addr.postdir;
	SELF.company_unit_desig := pInput.addr.unit_desig;
	SELF.company_sec_range 	:= pInput.addr.sec_range;
	SELF.company_city 		:= pInput.addr.v_city_name;
	SELF.company_state 		:= pInput.addr.st;
	SELF.company_zip 		:= (UNSIGNED3)pInput.addr.zip5;
	SELF.company_zip4 		:= (UNSIGNED2)pInput.addr.zip4;
	SELF.company_phone 		:= 0;
	SELF.dt_first_seen 		:= (unsigned)pInput.dt_first_seen;
	SELF.dt_last_seen 		:= (unsigned)pInput.dt_last_seen;
	SELF.ssn 				:= (UNSIGNED4)pInput.ssn;
	SELF.email_address 		:= '';
	SELF.PHONE              := 0;
	self.bdid 				:= 0;
	self.did 				:= 0;
	self.state 				:= pInput.addr.st;
	self.county 			:= '';
	self.msa 				:= pInput.addr.cbsa;
	SELF.title				:= pInput.name.title;		
	SELF.fname				:= pInput.name.fname;		
	SELF.mname				:= pInput.name.mname;
	SELF.lname				:= pInput.name.lname;
	SELF.name_suffix		:= pInput.name.name_suffix;	
	SELF.prim_range		    := pInput.addr.prim_range;
	SELF.predir				:= pInput.addr.predir;
	SELF.prim_name			:= pInput.addr.prim_name;
	SELF.postdir			:= pInput.addr.postdir;
	SELF.unit_desig			:= pInput.addr.unit_desig;
	SELF.sec_range			:= pInput.addr.sec_range;  
	SELF.geo_lat			:= pInput.addr.geo_lat;SELF.geo_long:= pInput.addr.geo_long;	
	SELF 					:= pInput;
	END;

	Taxpro_Contacts := Project(dIn, Translate_Taxpro_to_BCF(LEFT));

	Taxpro_Contacts_Filtered	:=	Taxpro_Contacts( 
											 lname<>'',fname<>'',
											 (prim_range <> '' or prim_name <> ''),
											 (INTEGER)name_score < 3, 
											 Business_Header.CheckPersonName(fname, mname, lname, name_suffix)
											) : persist(business_header.Bus_Thor + 'persist::Taxpro::Taxpro_As_Business_Contact');

	

export Taxpro_As_Business_contact := Taxpro_Contacts_Filtered;