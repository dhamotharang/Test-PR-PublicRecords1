import inquiry_acclogs, ut, lib_fileservices, _control;

#workunit('name','Weekly - Inquiry Distribution Counts')

export _Comprehensive_Stats := module

#workunit('name','Weekly - Inquiry Distribution Counts')

import inquiry_acclogs;

inq_file := inquiry_acclogs.fn_ProdHist().file;

slim_Entity := record
	string stat_type;
	string4 transaction_datey;
	string2 transaction_datem;
	string2 transaction_dated;
	boolean opt_out;
	unsigned Appended_Adl;
	unsigned Appended_BDID;
	string10 prim_range ;
	string2  predir ;
	string28 prim_name ;
	string8  sec_range ;
	string25 v_city_name ;
	string2  st ;
	string5  zip5 ;
	string4  zip4 ;
	string10 Personal_Phone;
	string10 Work_Phone;
	string10 Company_Phone;
	unsigned DOB;
	string9 SSN ;
	string9 EIN;
	string30 Email_Address;
	boolean has_address;
	boolean has_phone;
	boolean has_adl;
	boolean has_bdid;
	string source;
	string product_code;
	string industry;
	string vertical;
	string use;
	string product;
end;


slim_Entity t_map_slim (inq_file le) := transform
		boolean is_person := (trim(
								le.Person_Q.Full_Name + 
								le.Person_Q.First_Name + 
								le.Person_Q.Middle_Name + 
								le.Person_Q.Last_Name + 
								le.Person_Q.Address + 
								le.Person_Q.City + 
								le.Person_Q.State + 
								le.Person_Q.Zip + 
								le.Person_Q.Personal_Phone + 
								le.Person_Q.Work_Phone + 
								le.Person_Q.DOB + 
								le.Person_Q.DL + 
								le.Person_Q.DL_St +
								le.Person_Q.Email_Address + 
								le.Person_Q.SSN, all)  <> '');
								
	boolean is_business := trim(le.Bus_Q.CName + 
								le.Bus_Q.Address + 
								le.Bus_Q.City + 
								le.Bus_Q.State + 
								le.Bus_Q.Zip + 
								le.Bus_Q.Company_Phone + 
								le.Bus_Q.EIN, all)  <> '' and 
								trim(le.BusUser_Q.First_Name + 
								le.BusUser_Q.Middle_Name + 
								le.BusUser_Q.Last_Name + 
								le.BusUser_Q.Address + 
								le.BusUser_Q.City + 
								le.BusUser_Q.State + 
								le.BusUser_Q.Zip + 
								le.BusUser_Q.Personal_Phone + 
								le.BusUser_Q.DOB + 
								le.BusUser_Q.DL + 
								le.BusUser_Q.DL_St +
								le.BusUser_Q.SSN, all) = ''
								;
	boolean is_buser := trim(le.BusUser_Q.First_Name + 
								le.BusUser_Q.Middle_Name + 
								le.BusUser_Q.Last_Name + 
								le.BusUser_Q.Address + 
								le.BusUser_Q.City + 
								le.BusUser_Q.State + 
								le.BusUser_Q.Zip + 
								le.BusUser_Q.Personal_Phone + 
								le.BusUser_Q.DOB + 
								le.BusUser_Q.DL + 
								le.BusUser_Q.DL_St +
								le.BusUser_Q.SSN, all) <> '';
								
		self.Appended_Adl 	:= map(is_person => le.Person_Q.Appended_Adl,
									is_buser => le.BusUser_Q.Appended_Adl,
								 0);
		self.Appended_BDID 	:= map(is_business => le.Bus_Q.Appended_BDID,
									0);
		self.prim_range   	:= map(is_person => le.Person_Q.prim_range,
								   is_business => le.Bus_Q.prim_range,
								   '');
		self.predir 		:= map(is_person => le.Person_Q.predir,
								   is_business => le.Bus_Q.predir,
								   '');
		self.prim_name 		:= map(is_person => le.Person_Q.prim_name,
								   is_business => le.Bus_Q.prim_name,
								   '');
		self.sec_range 		:= map(is_person => le.Person_Q.sec_range ,
								   is_business => le.Bus_Q.sec_range ,
								   '');
		self.v_city_name 	:= map(is_person => le.Person_Q.v_city_name ,
								   is_business => le.Bus_Q.v_city_name,
								   '');
		self.st 			:= map(is_person => le.Person_Q.st ,
								   is_business => le.Bus_Q.st,
								   '');
		self.zip5 			:= map(is_person => le.Person_Q.zip5 ,
								   is_business => le.Bus_Q.zip5,
								   '');
		self.zip4 			:= map(is_person => le.Person_Q.zip4 ,
								   is_business => le.Bus_Q.zip4,
								   '');
		self.Personal_Phone := map(is_person => le.Person_Q.Personal_Phone ,
								   is_buser => le.BusUser_Q.Personal_Phone,
								   '');
		self.Work_Phone		:= map(is_person => le.Person_Q.Work_Phone,
								   '');
		self.Company_Phone	:= map(is_business => le.Bus_Q.Company_Phone,
								   '');						   
		self.DOB			:= map(is_person => (unsigned)le.Person_Q.DOB ,
								   is_buser => (unsigned)le.BusUser_Q.DOB,
								   0);
		self.SSN 			:= map(is_person => le.Person_Q.SSN ,
								   is_buser => le.BusUser_Q.SSN,
								   '');
		self.EIN			:= map(is_business => le.Bus_Q.EIN,
								   '');
		self.Email_Address	:= map(is_person => le.Person_Q.Email_Address,
								   '');
		self.stat_type		:= map(is_person => 'PERSON' ,
								   is_business => 'BUSINESS',
								   is_buser => 'BUSINESS_USER',
								   '');
		self.has_address	:= self.prim_name <> '' and (self.zip5 <> '' or (self.v_city_name + self.st <> ''));
		self.has_phone		:= length(trim(self.personal_phone, all)) >= 7 or length(trim(self.company_phone, all)) >= 7 or length(trim(self.work_phone, all)) >= 7;
		self.has_adl			:= self.Appended_Adl > 0;
		self.has_bdid			:= self.Appended_bdid > 0;
		self.opt_out			:= inquiry_acclogs.fnTranslations.is_opt_out(le.allow_flags.allowflags);;

		self.industry := le.bus_intel.industry;
		self.vertical := le.bus_intel.vertical;
		self.use 			:= le.bus_intel.use;
		self.product 	:= le.search_info.function_description;
		self.product_code 	:= le.search_info.product_code;
		self.transaction_datey := le.search_info.datetime[..4];	
		self.transaction_datem := le.search_info.datetime[5..6];	
		self.transaction_dated := le.search_info.datetime[7..8];	
		self.source			:= le.source;
	    self := le;
	end;
		
slim_inq := project(inq_file, t_map_slim(left));
									
prefix_comprehensive_table := table(slim_inq, {transaction_datey, transaction_datem, transaction_dated, stat_type, industry, vertical, use, product, source, product_code, has_address, has_phone, has_adl, has_bdid, opt_out,
															cnt := count(group)},
															transaction_datey, transaction_datem, transaction_dated, stat_type, industry, vertical, use, product, source, product_code, has_address, has_phone, has_adl, has_bdid, opt_out, few);

shared comprehensive_table_yyyymmdd := join(prefix_comprehensive_table, dedup(inquiry_acclogs.File_Function_Description_Rollups,rollup_string,all),
															regexreplace('[^A-Z0-9]', left.product, '') = right.rollup_string,
															transform({recordof(prefix_comprehensive_table)},
																self.product := if(right.rollup_string <> '', right.selected_version, left.product);
																self := left), lookup, left outer) : independent;
																
shared comprehensive_table_yyyymm				:=	table(comprehensive_table_yyyymmdd, 
																		{transaction_datey, transaction_datem, stat_type, industry, vertical, use, product, source, product_code, has_address, has_phone, has_adl, has_bdid, opt_out,
																		 cntsum := sum(group, cnt)},
																		 transaction_datey, transaction_datem, stat_type, industry, vertical, use, product, source, product_code, has_address, has_phone, has_adl, has_bdid, opt_out, few)
															;
	

shared comprehensive_table_nodate := table(comprehensive_table_yyyymmdd, 
																		{stat_type, industry, vertical, use, product, source, product_code, has_address, has_phone, has_adl, has_bdid, opt_out, 
																		 cntsum := sum(group, cnt)},
																		 stat_type, industry, vertical, use, product, source, product_code, has_address, has_phone, has_adl, has_bdid, opt_out, few);

shared comprehensive_table_slim_nodate := table(comprehensive_table_yyyymmdd, 
																		{vertical, industry, use, product, source, product_code, opt_out, 
																		 cntsum := sum(group, cnt)},
																		 vertical, industry, use, product, source, product_code, opt_out, few);


/* Calc - Keep Six Months for Filter */
mmtoday := ut.getdate[5..6];
lesser := ut.getdate[..4]+intformat(if((integer)mmtoday <= 5, 12 + ((integer)mmtoday - 5), (integer)mmtoday - 5), 2, 1);

despray(string dsnm, string unixnm) := 
				fileservices.Despray(dsnm, 
														 _control.IPAddress.edata12, 
														 '/inquiry_data_01/stats/'+unixnm, 
														 , 
														 , 
														 , 
														 true);
										 
export build_stats := sequential(

												output(sort(comprehensive_table_yyyymmdd, record),,'out::inquiry_acclogs::comprehensive_table_yyyymmdd', overwrite, csv(heading, quote('"'), separator(',')));
												output(sort(comprehensive_table_yyyymm, record),,'out::inquiry_acclogs::comprehensive_table_yyyymm', overwrite, csv(heading,quote('"'), separator(',')));
												output(sort(comprehensive_table_nodate, record),,'out::inquiry_acclogs::comprehensive_table_nodate', overwrite, csv(heading,quote('"'), separator(',')));
												output(sort(comprehensive_table_slim_nodate, record),,'out::inquiry_acclogs::comprehensive_table_slim_nodate', overwrite, csv(heading,quote('"'), separator(',')));

												despray('out::inquiry_acclogs::comprehensive_table_yyyymmdd', 'comprehensive_table_yyyymmdd'),
												despray('out::inquiry_acclogs::comprehensive_table_yyyymm', 'comprehensive_table_yyyymm'),
												despray('out::inquiry_acclogs::comprehensive_table_nodate', 'comprehensive_table_nodate'),
												despray('out::inquiry_acclogs::comprehensive_table_slim_nodate', 'comprehensive_table_slim_nodate')

												);
																				 
export file_yyyymmdd		:= dataset('out::inquiry_acclogs::comprehensive_table_yyyymmdd', recordof(comprehensive_table_yyyymmdd), csv);
export file_yyyymm			:= dataset('out::inquiry_acclogs::comprehensive_table_yyyymm', recordof(comprehensive_table_yyyymm), csv);
export file_nodate			:= dataset('out::inquiry_acclogs::comprehensive_table_nodate', recordof(comprehensive_table_nodate), csv);
export file_slim_nodate	:= dataset('out::inquiry_acclogs::comprehensive_table_slim_nodate', recordof(comprehensive_table_slim_nodate), csv);

end;