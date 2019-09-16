EXPORT AddPerson_Business_Info(dataset(INQL_v2.Layouts.Common_layout) baseFile, boolean fcra = false, unsigned logType = 0) := function

 BasePer := case(logType,
   1 => baseFile(repflag = '' and domain_name + clean_cname1 + ucc_number + ein + charter_number = '' and source_file = 'ACCURINT'),
   2 => baseFile(repflag = '' and domain_name + clean_cname1 + ucc_number + ein + charter_number = '' and source_file = 'CUSTOM'),
   3 => baseFile(repflag = '' and domain_name + clean_cname1 + ucc_number + ein + charter_number = '' and source_file = 'BATCH'),
   4 => baseFile(domain_name + clean_cname1 + ucc_number + ein + charter_number = '' and source_file = 'BATCHR3'),
   5 => baseFile(repflag = '' and source_file = 'BANKO'),   
   6 => baseFile(ORIG_REFERENCE_CODE = 'ENTITYINDIVIDUAL' and source_file = 'BRIDGER'),
   7 => baseFile(repflag = '' and source_file = 'RISKWISE'),
   8 => baseFile(domain_name + clean_cname1 + ucc_number + ein + charter_number = '' and source_file = 'IDM_BLS'),
   dataset([], INQL_v2.Layouts.Common_layout)
   );
   
 //-----------PROJECT INTO PERSON QUERY LAYOUT-----------//
  person_project := project(BasePer, 
		transform(INQL_v2.Layouts.Common_ThorAdditions,
			self.mbs.Company_ID         := left.Company_ID;
			self.mbs.Global_Company_ID 	:= left.Global_Company_ID;
			
			self.allow_flags.Allowflags := left.Allowflags;

			self.bus_intel.Sub_market   := left.sub_market;
			self.bus_intel.Industry     := left.industry;
			self.bus_intel.Primary_Market_Code   := left.Primary_Market_Code;
			self.bus_intel.Secondary_Market_Code := left.Secondary_Market_Code;
			self.bus_intel.Industry_1_Code := left.Industry_1_Code;
			self.bus_intel.Industry_2_Code := left.Industry_2_Code;
			self.bus_intel.Vertical        := left.vertical;
			self.bus_intel.Use             := left.use;
			
			self.Permissions.GLB_purpose 	 := left.glb_purpose;
			self.Permissions.DPPA_purpose  := left.dppa_purpose;
			self.Permissions.FCRA_purpose  := left.fcra_purpose;
			
			self.search_info.DateTime         := left.datetime;
			self.search_info.Login_History_ID := left.login_history_id;
			self.search_info.Transaction_ID   := left.transaction_id;
			self.search_info.Sequence_Number  := left.sequence_number;
			self.search_info.Method           := left.method;
			self.search_info.Product_Code     := left.product_code;
			self.search_info.Transaction_Type := left.transaction_type;
			self.search_info.Function_Description := left.function_description;
			self.search_info.IPAddr           := left.ORIG_IP_ADDRESS2;

			self.bus_q.CName := left.clean_cname1;

      self.bus_q.appended_bdid  := if(logType = 3, left.appendbdid, 0);
			self.bus_q.appended_ein   := if(logType = 3, left.appendtaxid, '');
      self.bus_q.domain_name    := if(logType in [3,4], left.domain_name, '');
      self.bus_q.ein            := if(logType in [3,4], left.ein, '');
      self.bus_q.charter_number := if(logType in [3,4], left.Charter_Number, '');
      self.bus_q.ucc_number     := if(logType in [3,4], left.ucc_number, '');

			self.person_q.Full_Name   := left.orig_full_name1;
			self.person_q.Title       := '';
			self.person_q.First_Name  := left.orig_fname;
			self.person_q.Middle_Name := left.orig_mname;
			self.person_q.Last_Name   := left.orig_lname;
			self.person_q.Address     := left.orig_addr1;
			self.person_q.City        := left.orig_city1;
			self.person_q.State       := left.orig_state1;
			self.person_q.Zip         := left.orig_zip1;
			self.person_q.Personal_Phone := left.personal_phone;
			self.person_q.Work_Phone     := left.work_phone;
			self.person_q.DOB            := left.dob;
			self.person_q.DL             := left.dl; // unique id
			self.person_q.DL_St          := left.dl_state; // unique id
			self.person_q.Email_Address  := left.email_address;
			self.person_q.SSN            := left.ssn;
			self.person_q.LinkID         := left.linkid;
			self.person_q.IPAddr         := left.PERSON_ORIG_IP_ADDRESS1;
			self.person_q.FName          := left.fname;
			self.person_q.MName          := left.mname;
			self.person_q.LName          := left.lname;
			self.person_q.Name_Suffix    := left.name_suffix;
			self.person_q.prim_range     := left.prim_range;
			self.person_q.predir         := left.predir ;
			self.person_q.prim_name      := left.prim_name ;
			self.person_q.addr_suffix    := left.addr_suffix ;
			self.person_q.postdir        := left.postdir;
			self.person_q.unit_desig     := left.unit_desig;
			self.person_q.sec_range      := left.sec_range;
			self.person_q.v_city_name    := left.v_city_name;
			self.person_q.st             := left.st;
			self.person_q.zip5           := left.zip5;
			self.person_q.zip4           := left.zip4;
			self.person_q.addr_rec_type  := left.addr_rec_type ;
			self.person_q.fips_state     := left.fips_state;
			self.person_q.fips_county    := left.fips_county;
			self.person_q.geo_lat        := left.geo_lat;
			self.person_q.geo_long       := left.geo_long;
			self.person_q.cbsa           := left.cbsa;
			self.person_q.geo_blk        := left.geo_blk;
			self.person_q.geo_match      := left.geo_match;
			self.person_q.err_stat       := left.err_stat;
			self.person_q.Appended_SSN   := left.appendssn;
			self.person_q.Appended_ADL   := left.appendadl;
			self.source                  := stringlib.stringtouppercase(left.source_file);
      self := left; 
			self := []));

 BaseBus := case(logType,
   1 => baseFile(repflag = '' and domain_name + clean_cname1 + ucc_number + ein + charter_number <> '' and source_file = 'ACCURINT'),
   2 => baseFile(repflag = '' and domain_name + clean_cname1 + ucc_number + ein + charter_number <> '' and source_file = 'CUSTOM'),
   3 => baseFile(repflag = '' and domain_name + clean_cname1 + ucc_number + ein + charter_number <> '' and source_file = 'BATCH'),
   4 => baseFile(domain_name + clean_cname1 + ucc_number + ein + charter_number <> '' and source_file = 'BATCHR3'),
   6 => baseFile(ORIG_REFERENCE_CODE <> 'ENTITYINDIVIDUAL' and source_file = 'BRIDGER'),
   8 => baseFile(domain_name + clean_cname1 + ucc_number + ein + charter_number <> '' and source_file = 'IDM_BLS'),
   dataset([], INQL_v2.Layouts.Common_layout)
   );
   
//-----------PROJECT INTO BUSINESS QUERY LAYOUT-----------//
 bus_project := project(BaseBus, 
		transform(INQL_v2.Layouts.Common_ThorAdditions,
			self.mbs.Company_ID        := left.Company_ID;
			self.mbs.Global_Company_ID := left.Global_Company_ID;
			
			self.allow_flags.Allowflags:= left.Allowflags;

			self.bus_intel.Sub_market            := left.sub_market;
			self.bus_intel.Industry              := left.industry;
			self.bus_intel.Primary_Market_Code   := left.Primary_Market_Code;
			self.bus_intel.Secondary_Market_Code := left.Secondary_Market_Code;
			self.bus_intel.Industry_1_Code       := left.Industry_1_Code;
			self.bus_intel.Industry_2_Code       := left.Industry_2_Code;
			self.bus_intel.Vertical              := left.vertical;
			self.bus_intel.Use                   := left.use;

			self.Permissions.GLB_purpose 	:= left.glb_purpose;
			self.Permissions.DPPA_purpose := left.dppa_purpose;
			self.Permissions.FCRA_purpose := left.fcra_purpose;
			
			self.search_info.DateTime          := left.datetime;
			self.search_info.Login_History_ID  := left.login_history_id;
			self.search_info.Transaction_ID    := left.transaction_id;
			self.search_info.Sequence_Number   := left.sequence_number;
			self.search_info.Method            := left.method;
			self.search_info.Product_Code      := left.product_code;
			self.search_info.Transaction_Type  := left.transaction_type;
			self.search_info.Function_Description := left.function_description;
			self.search_info.IPAddr            := left.ORIG_IP_ADDRESS2;

			self.bus_q.CName         := left.clean_cname1;
			self.bus_q.Address       := left.orig_addr1;
			self.bus_q.City          := left.orig_city1;
			self.bus_q.State         := left.orig_state1;
			self.bus_q.Zip           := left.orig_zip1;
			self.bus_q.Company_Phone := left.company_phone;
			self.bus_q.domain_name   := left.domain_name;
			self.bus_q.ein           := left.ein;
			self.bus_q.charter_number:= left.Charter_Number;
			self.bus_q.ucc_number    := left.UCC_Number;
			self.bus_q.prim_range    := left.prim_range ;
			self.bus_q.predir        := left.predir;
			self.bus_q.prim_name     := left.prim_name;
			self.bus_q.addr_suffix   := left.addr_suffix;
			self.bus_q.postdir       := left.postdir;
			self.bus_q.unit_desig  	 := left.unit_desig;
			self.bus_q.sec_range     := left.sec_range ;
			self.bus_q.v_city_name   := left.v_city_name ;
			self.bus_q.st            := left.st;
			self.bus_q.zip5          := left.zip5 ;
			self.bus_q.zip4          := left.zip4 ;
			self.bus_q.addr_rec_type := left.addr_rec_type ;
			self.bus_q.fips_state    := left.fips_state;
			self.bus_q.fips_county   := left.fips_county;
			self.bus_q.geo_lat       := left.geo_lat ;
			self.bus_q.geo_long      := left.geo_long ;
			self.bus_q.cbsa          := left.cbsa;
			self.bus_q.geo_blk       := left.geo_blk ;
			self.bus_q.geo_match     := left.geo_match;
			self.bus_q.err_stat      := left.err_stat;
			self.bus_q.appended_bdid := left.appendbdid;
			self.bus_q.appended_ein  := left.appendtaxid;
			self.source              := stringlib.stringtouppercase(left.source_file);
		  self := left;
			self := []));

 BaseBusUser := case(logType,
   1 => baseFile(repflag <> '' and source_file = 'ACCURINT'),
   2 => baseFile(repflag = '' and domain_name + clean_cname1 + ucc_number + ein + charter_number = '' and source_file = 'CUSTOM'),
   3 => baseFile(repflag <> '' and source_file = 'BATCH'),
   5 => baseFile(repflag <> ''and source_file = 'BANKO'),
   7 => baseFile(repflag <> '' and source_file = 'RISKWISE'),
   8 => baseFile(domain_name + clean_cname1 + ucc_number + ein + charter_number = '' and source_file = 'IDM_BLS'),
   dataset([], INQL_v2.Layouts.Common_layout)
   );
//-----------PROJECT INTO BUSINESS USER QUERY LAYOUT-----------//			
 bususer_project := project(BaseBusUser,
		transform(INQL_v2.Layouts.Common_ThorAdditions,
			self.mbs.Company_ID        := left.Company_ID;
			self.mbs.Global_Company_ID := left.Global_Company_ID;
			
			self.allow_flags.Allowflags:= left.Allowflags;

			self.bus_intel.Sub_market            := left.sub_market;
			self.bus_intel.Industry              := left.industry;
			self.bus_intel.Primary_Market_Code   := left.Primary_Market_Code;
			self.bus_intel.Secondary_Market_Code := left.Secondary_Market_Code;
			self.bus_intel.Industry_1_Code       := left.Industry_1_Code;
			self.bus_intel.Industry_2_Code       := left.Industry_2_Code;
			self.bus_intel.Vertical              := left.vertical;
			self.bus_intel.Use                   := left.use;

			self.Permissions.GLB_purpose 	:= left.glb_purpose;
			self.Permissions.DPPA_purpose := left.dppa_purpose;
			self.Permissions.FCRA_purpose := left.fcra_purpose;
			
			self.search_info.DateTime          := left.datetime;
			self.search_info.Login_History_ID  := left.login_history_id;
			self.search_info.Transaction_ID    := left.transaction_id;
			self.search_info.Sequence_Number   := left.sequence_number;
			self.search_info.Method            := left.method;
			self.search_info.Product_Code      := left.product_code;
			self.search_info.Transaction_Type  := left.transaction_type;
			self.search_info.Function_Description := left.function_description;
			self.search_info.IPAddr            := left.ORIG_IP_ADDRESS2;
	
			self.bus_q.CName          := left.clean_cname1;
			self.bus_q.domain_name    := if(logType = 5, '', left.domain_name);
			self.bus_q.ein            := if(logType = 5, '', left.ein);
			self.bus_q.charter_number := if(logType = 5, '', left.Charter_Number);
			self.bus_q.ucc_number     := if(logType = 5, '', left.UCC_Number);
            
      self.bus_q.appended_bdid := if(logType in [3,5], left.appendbdid, 0);
			self.bus_q.appended_ein  := if(logType in [3,5], left.appendtaxid, '');

			self.bususer_q.Title        := '';
			self.bususer_q.First_Name   := left.orig_fname;
			self.bususer_q.Middle_Name  := left.orig_mname;
			self.bususer_q.Last_Name    := left.orig_lname;
			self.bususer_q.Address      := left.orig_addr1;
			self.bususer_q.City         := left.orig_city1;
			self.bususer_q.State        := left.orig_state1;
			self.bususer_q.Zip          := left.orig_zip1;
			self.bususer_q.Personal_Phone := left.personal_phone;
			self.bususer_q.DOB          := left.dob;
			self.bususer_q.DL           := left.dl; // unique id
			self.bususer_q.DL_St        := left.dl_state; // unique id
			self.bususer_q.FName        := left.fname;
			self.bususer_q.MName        := left.mname;
			self.bususer_q.LName        := left.lname;
			self.bususer_q.Name_Suffix  := left.name_suffix;
			self.bususer_q.prim_range   := left.prim_range;
			self.bususer_q.predir       := left.predir ;
			self.bususer_q.prim_name    := left.prim_name ;
			self.bususer_q.addr_suffix  := left.addr_suffix ;
			self.bususer_q.postdir      := left.postdir;
			self.bususer_q.unit_desig  	:= left.unit_desig;
			self.bususer_q.sec_range    := left.sec_range;
			self.bususer_q.v_city_name  := left.v_city_name;
			self.bususer_q.st           := left.st;
			self.bususer_q.zip5         := left.zip5;
			self.bususer_q.zip4         := left.zip4;
			self.bususer_q.addr_rec_type:= left.addr_rec_type ;
			self.bususer_q.fips_state   := left.fips_state;
			self.bususer_q.fips_county 	:= left.fips_county;
			self.bususer_q.geo_lat      := left.geo_lat;
			self.bususer_q.geo_long     := left.geo_long;
			self.bususer_q.cbsa         := left.cbsa;
			self.bususer_q.geo_blk      := left.geo_blk;
			self.bususer_q.geo_match    := left.geo_match;
			self.bususer_q.err_stat     := left.err_stat;
			self.bususer_q.Appended_SSN := left.appendssn;
			self.bususer_q.Appended_ADL := left.appendadl;
			self.source                 := stringlib.stringtouppercase(left.source_file);
      self := left;  
			self := []));

 comb := person_project + bus_project + bususer_project;
 
 Base := if(logType = 4
          ,dedup(sort(distribute(comb, hash(search_info.Sequence_Number + person_q.lname + bususer_q.lname + bus_q.cname))(mbs.company_id + mbs.global_company_id <> ''), record, local), record, local)
          ,if(logType = 3
            ,dedup(sort(distribute(comb, hash(search_info.Sequence_Number))(mbs.company_id + mbs.global_company_id <> ''), record, local), record, local)
            ,dedup(sort(distribute(comb, hash(search_info.Transaction_ID))(mbs.company_id + mbs.global_company_id <> ''), record, local), record, local)
            )
          );
 return  comb;

END;