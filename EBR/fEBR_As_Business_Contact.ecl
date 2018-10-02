import Business_Header, ut,address,mdr;

export fEBR_As_Business_Contact(dataset(layout_0010_header_base) pInputHeaderBase, dataset(Layout_5610_Demographic_Data_Base) pInputDemoBase, boolean isPRCT = false) :=
function
	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Input Files to process
	//////////////////////////////////////////////////////////////////////////////////////////////
	//*** Removed the filters that had in place to filert out the quartely unload records - as per Jira DF-23116.
	demo_base 		:= pInputDemoBase;

	layout_BH_contact 	:= Business_Header.Layout_Business_Contact_Full_New;

	layout_demo_company_info := 
	record
		Layout_5610_Demographic_Data_Base;
		address.Layout_Clean182;
		string40    COMPANY_NAME;
		string10    PHONE_NUMBER;
	end;

	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Get company name and address information from the 0010_Header record
	//////////////////////////////////////////////////////////////////////////////////////////////
	demo_base_dist := distribute(demo_base, hash(FILE_NUMBER));
	demo_base_sort := sort(demo_base_dist, FILE_NUMBER, process_date, local);

	File_0010_Header_base_dist := distribute(pInputHeaderBase, hash(FILE_NUMBER));
	File_0010_Header_base_sort := sort(File_0010_Header_base_dist, FILE_NUMBER, process_date, local);

	layout_demo_company_info tGetCompanyInfo(demo_base_sort l, File_0010_Header_base_sort r) := 
	transform
		self.date_first_seen	:= r.date_first_seen;
		self.date_last_seen		:= r.date_last_seen;
		self					:= l;
		self					:= r;
	end;

	demo_base_company_info := join(demo_base_sort, File_0010_Header_base_sort, 
																	left.FILE_NUMBER = right.FILE_NUMBER and
																	(unsigned)left.process_date >= (unsigned)right.process_date_first_seen and 
																	(unsigned)left.process_date <= (unsigned)right.process_date_last_seen,
																	tGetCompanyInfo(left,right),
																	local);

	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Map to Business Contact Layout
	//////////////////////////////////////////////////////////////////////////////////////////////
	layout_BH_contact t5610_Demographic_Databusiness_contact(demo_base_company_info pInput) :=
	transform
		self.source 					:=	MDR.sourceTools.src_EBR;
		self.dppa							:=	false;
		self.dt_first_seen 		:=	(unsigned)pInput.date_first_seen;
		self.dt_last_seen 		:=	(unsigned)pInput.date_last_seen;
		self.prim_range				:=	pInput.prim_range;
		self.predir						:=	pInput.predir;
		self.prim_name				:=	pInput.prim_name;
		self.addr_suffix			:=	pInput.addr_suffix;
		self.postdir					:=	pInput.postdir;
		self.unit_desig				:=	pInput.unit_desig;
		self.sec_range				:=	pInput.sec_range;
		self.city							:=	pInput.v_city_name;
		self.state						:=	pInput.st;
		self.zip							:=	(unsigned)pInput.zip;
		self.zip4							:=	(unsigned)pInput.zip4;
		self.county						:=	pInput.county[3..5];
		self.msa							:=	pInput.msa;
		self.geo_lat					:=	pInput.geo_lat;
		self.geo_long					:=	pInput.geo_long;
		self.record_type			:=	pInput.record_type;
		self.phone						:=	(unsigned8)pInput.PHONE_NUMBER; // another phone on 0010_Header segment
		self.email_address		:=	'';
		self.ssn							:=	0;
		self.title						:=	pInput.clean_officer_name.title;
		self.fname 						:=	pInput.clean_officer_name.fname;
		self.mname						:=	pInput.clean_officer_name.mname;
		self.lname						:=	pInput.clean_officer_name.lname;
		self.name_suffix			:=	pInput.clean_officer_name.name_suffix;
		self.name_score				:=	Business_Header.CleanName(self.fname,self.mname,self.lname,self.name_suffix)[142];
		self.vendor_id				:=	pInput.FILE_NUMBER;
		self.company_title		:=	pInput.OFFICER_TITLE;
		self.company_department			:=	'';
		self.company_source_group		:=	'';
		self.company_name			:=	pInput.COMPANY_NAME;
		self.company_prim_range			:=	self.prim_range;
		self.company_predir		:=	self.predir;
		self.company_prim_name			:=	self.prim_name;
		self.company_addr_suffix		:=	self.addr_suffix;
		self.company_postdir	:=	self.postdir;
		self.company_unit_desig			:=	self.unit_desig;
		self.company_sec_range			:=	self.sec_range;
		self.company_city			:=	self.city;
		self.company_state		:=	self.state;
		self.company_zip			:=	self.zip;
		self.company_zip4			:=	self.zip4;
		self.company_phone		:=	(unsigned8)pInput.PHONE_NUMBER;
		self.company_fein			:=	0;
		self.bdid							:=	(unsigned8)pInput.bdid;
		self.did							:=  if(isPRCT, pInput.did, 0);
		self.vl_id          	:= 	pInput.FILE_NUMBER;
	end;

	demo_base_norm := project(demo_base_company_info, t5610_Demographic_Databusiness_contact(LEFT));

	return	if(isPRCT, demo_base_norm, demo_base_norm((integer)name_score < 3, Business_Header.CheckPersonName(fname, mname, lname, name_suffix)));

end;