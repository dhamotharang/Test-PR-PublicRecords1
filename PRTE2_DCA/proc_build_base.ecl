IMPORT  PRTE2_DCA, PRTE2, PromoteSupers, Address, ut, AID, AID_Support, std, mdr ;

EXPORT proc_build_base(String filedate) := FUNCTION



 d_in := PRTE2.AddressCleaner(Files.file_in_plus,  
 ['addr_1'],
 ['addr_2'],
 [],
 [],
 [],
 ['mail_address'],
 ['mail_address_rawaid']);
 
D_out	:=	Project(d_In,
Transform(Layouts.Layout_base,
			SELF.physical_address.prim_range	:=  left.mail_address.prim_range;
			SELF.physical_address.predir      :=  left.mail_address.predir;
			SELF.physical_address.prim_name   :=  left.mail_address.prim_name;
			SELF.physical_address.addr_suffix :=  left.mail_address.addr_suffix;
			SELF.physical_address.postdir     :=  left.mail_address.postdir;
			SELF.physical_address.unit_desig  :=  left.mail_address.unit_desig;
			SELF.physical_address.sec_range   :=  left.mail_address.sec_range;
			SELF.physical_address.p_city_name :=  left.mail_address.p_city_name;
			SELF.physical_address.v_city_name :=  left.mail_address.v_city_name;
			SELF.physical_address.st          :=  left.mail_address.st;
			SELF.physical_address.zip         :=  left.mail_address.zip;
			SELF.physical_address.zip4        :=  left.mail_address.zip4;
			SELF.physical_address.cart        :=  left.mail_address.cart;
			SELF.physical_address.cr_sort_sz  :=  left.mail_address.cr_sort_sz;
			SELF.physical_address.lot         :=  left.mail_address.lot;
			SELF.physical_address.lot_order   :=  left.mail_address.lot_order;
			SELF.physical_address.dbpc        :=  left.mail_address.dbpc;
			SELF.physical_address.chk_digit   :=  left.mail_address.chk_digit;
			SELF.physical_address.rec_type    :=  left.mail_address.rec_type;
			SELF.physical_address.geo_lat     :=  left.mail_address.geo_lat;
			SELF.physical_address.geo_long    :=  left.mail_address.geo_long;
			SELF.physical_address.msa         :=  left.mail_address.msa;
			SELF.physical_address.geo_blk     :=  left.mail_address.geo_blk;
			SELF.physical_address.geo_match   :=  left.mail_address.geo_match;
			SELF.physical_address.err_stat  	:=  left.mail_address.err_stat;
			SELF.physical_rawaid              :=  left.mail_address_rawaid;
			SELF.physical_address.fips_state 	:=  left.mail_address.fips_state;	
			SELF.physical_addr_1 							:=  left.addr_1;
			SELF.physical_addr_2							:=  left.addr_2;
			
			SELF.mailing_address.prim_range  	:=  left.mail_address.prim_range;
			SELF.mailing_address.predir       :=  left.mail_address.predir;
			SELF.mailing_address.prim_name    :=  left.mail_address.prim_name;
			SELF.mailing_address.addr_suffix 	:=  left.mail_address.addr_suffix;
			SELF.mailing_address.postdir      :=  left.mail_address.postdir;
			SELF.mailing_address.unit_desig  	:=  left.mail_address.unit_desig;
			SELF.mailing_address.sec_range    :=  left.mail_address.sec_range;
			SELF.mailing_address.p_city_name 	:=  left.mail_address.p_city_name;
			SELF.mailing_address.v_city_name 	:=  left.mail_address.v_city_name;
			SELF.mailing_address.st           :=  left.mail_address.st;
			SELF.mailing_address.zip          :=  left.mail_address.zip;
			SELF.mailing_address.zip4         :=  left.mail_address.zip4;
			SELF.mailing_address.cart         :=  left.mail_address.cart;
			SELF.mailing_address.cr_sort_sz   :=  left.mail_address.cr_sort_sz;
			SELF.mailing_address.lot          :=  left.mail_address.lot;
			SELF.mailing_address.lot_order    :=  left.mail_address.lot_order;
			SELF.mailing_address.dbpc         :=  left.mail_address.dbpc;
			SELF.mailing_address.chk_digit    :=  left.mail_address.chk_digit;
			SELF.mailing_address.rec_type  		:=  left.mail_address.rec_type;
			SELF.mailing_address.geo_lat      :=  left.mail_address.geo_lat;
			SELF.mailing_address.geo_long     :=  left.mail_address.geo_long;
			SELF.mailing_address.msa          :=  left.mail_address.msa;
			SELF.mailing_address.geo_blk      :=  left.mail_address.geo_blk;
			SELF.mailing_address.geo_match    :=  left.mail_address.geo_match;
			SELF.mailing_address.err_stat    	:=  left.mail_address.err_stat;
			SELF.mailing_rawaid               :=  left.mail_address_rawaid;
			SELF.mailing_address.fips_state 	:=  left.mailing_address.fips_state;		
			SELF.mailing_addr_1 							:=  left.addr_1;
			SELF.mailing_addr_2								:=  left.addr_2;			
			
			//all of the rest of the fields in both datasets match, so just take everything from left
			//companies
			SELF.companies.Assets 				:= left.Assets;
			SELF.companies.Bus_Desc 			:= left.Bus_Desc;
			SELF.companies.E_mail 				:= left.E_mail;
			SELF.companies.Earnings 			:= left.Earnings;
			SELF.companies.EMP_NUM 				:= left.EMP_NUM;
			SELF.companies.Enterprise_num := left.Enterprise_num;
			SELF.companies.Exchange1 			:= left.Exchange1;
			SELF.companies.Exchange10 		:= left.Exchange10;
			SELF.companies.Exchange11 		:= left.Exchange11;
			SELF.companies.Exchange12 		:= left.Exchange12;
			SELF.companies.Exchange13 		:= left.Exchange13;
			SELF.companies.Exchange14 		:= left.Exchange14;
			SELF.companies.Exchange15 		:= left.Exchange15;
			SELF.companies.Exchange16 		:= left.Exchange16;
			SELF.companies.Exchange17 		:= left.Exchange17;
			SELF.companies.Exchange18 		:= left.Exchange18;
			SELF.companies.Exchange19 		:= left.Exchange19;
			SELF.companies.Exchange2 			:= left.Exchange2;
			SELF.companies.Exchange3 			:= left.Exchange3;
			SELF.companies.Exchange4 			:= left.Exchange4;
			SELF.companies.Exchange5 			:= left.Exchange5;
			SELF.companies.Exchange6 			:= left.Exchange6;
			SELF.companies.Exchange7 			:= left.Exchange7;
			SELF.companies.Exchange8 			:= left.Exchange8;
			SELF.companies.Exchange9 			:= left.Exchange9;
			SELF.companies.Fax 						:= left.Fax;
			SELF.companies.FYE 						:= left.FYE;
			SELF.companies.Incorp 				:= left.Incorp;
			SELF.companies.JV_Parent1 		:= left.JV_Parent1;
			SELF.companies.jv1_num 				:= left.jv1_;
			SELF.companies.JV_Parent2 		:= left.JV_Parent2;
			SELF.companies.jv2_num 				:= left.jv2_;
			SELF.companies.Level 					:= left.Level;
			SELF.companies.Liabilities 		:= left.Liabilities;
			SELF.companies.Naics_Text1 		:= left.Naics_Text1;
			SELF.companies.Naics_Text10 	:= left.Naics_Text10;
			SELF.companies.Naics_Text2 		:= left.Naics_Text2;
			SELF.companies.Naics_Text3 		:= left.Naics_Text3;
			SELF.companies.Naics_Text4 		:= left.Naics_Text4;
			SELF.companies.Naics_Text5 		:= left.Naics_Text5;
			SELF.companies.Naics_Text6 		:= left.Naics_Text6;
			SELF.companies.Naics_Text7 		:= left.Naics_Text7;
			SELF.companies.Naics_Text8 		:= left.Naics_Text8;
			SELF.companies.Naics_Text9 		:= left.Naics_Text9;
			SELF.companies.Naics1 				:= left.Naics1;
			SELF.companies.Naics10 				:= left.Naics10;
			SELF.companies.Naics2 				:= left.Naics2;
			SELF.companies.Naics3 				:= left.Naics3;
			SELF.companies.Naics4 				:= left.Naics4;
			SELF.companies.Naics5 				:= left.Naics5;
			SELF.companies.Naics6 				:= left.Naics6;
			SELF.companies.Naics7 				:= left.Naics7;
			SELF.companies.Naics8 				:= left.Naics8;
			SELF.companies.Naics9 				:= left.Naics9;
			SELF.companies.Name 					:= left.Name;
			SELF.companies.Note 					:= left.Note;
			SELF.companies.Parent_Name 		:= left.Parent_Name;
			SELF.companies.Parent_Number 	:= left.Parent_Number;
			SELF.companies.percent_owned 	:= left.percent_owned;
			SELF.companies.Phone 					:= left.Phone;
			SELF.companies.Root 					:= left.Root;
			SELF.companies.Sales 					:= left.Sales;
			SELF.companies.Sales_Desc 		:= left.Sales_Desc;
			SELF.companies.Sic1 					:= left.Sic1;
			SELF.companies.Sic10 					:= left.Sic10;
			SELF.companies.Sic2 					:= left.Sic2;
			SELF.companies.Sic3 					:= left.Sic3;
			SELF.companies.Sic4 					:= left.Sic4;
			SELF.companies.Sic5 					:= left.Sic5;
			SELF.companies.Sic6 					:= left.Sic6;
			SELF.companies.Sic7 					:= left.Sic7;
			SELF.companies.Sic8 					:= left.Sic8;
			SELF.companies.Sic9 					:= left.Sic9;
			SELF.companies.Sub 						:= left.Sub;
			SELF.companies.Telex 					:= left.Telex;
			SELF.companies.Text1 					:= left.Text1;
			SELF.companies.Text10 				:= left.Text10;
			SELF.companies.Text2 					:= left.Text2;
			SELF.companies.Text3 					:= left.Text3;
			SELF.companies.Text4 					:= left.Text4;
			SELF.companies.Text5 					:= left.Text5;
			SELF.companies.Text6 					:= left.Text6;
			SELF.companies.Text7 					:= left.Text7;
			SELF.companies.Text8 					:= left.Text8;
			SELF.companies.Text9 					:= left.Text9;
			SELF.companies.Ticker_Symbol 	:= left.Ticker_Symbol;
			SELF.companies.Update_Date 		:= left.Update_Date;
			SELF.companies.URL 						:= left.URL;
			//physical address from input file
			SELF.companies.address1.PO_Box_Bldg		:= left.PO_Box_Bldg;
			SELF.companies.address1.Street				:= left.Street;
			SELF.companies.address1.Foreign_PO		:= left.Foreign_PO;
			SELF.companies.address1.Misc__adr			:= left.Misc__adr;
			SELF.companies.address1.Postal_Code_1	:= left.Postal_Code_1;
			SELF.companies.address1.City					:= left.City;
			SELF.companies.address1.State					:= left.State;
			SELF.companies.address1.Zip						:= left.Zip;
			SELF.companies.address1.Province			:= left.Province;
			SELF.companies.address1.Postal_Code_2	:= left.Postal_Code_2;
			SELF.companies.address1.Country				:= left.Country;
			SELF.companies.address1.Postal_Code_3	:= left.Postal_Code_3;
		//	left address from input file
			SELF.companies.address2.PO_Box_Bldg		:= left.PO_Box_Bldg_A;
			SELF.companies.address2.Street				:= left.StreetA;
			SELF.companies.address2.Foreign_PO		:= left.Foreign_PO_BoxA;
			SELF.companies.address2.Misc__adr			:= left.Misc__adr_A;
			SELF.companies.address2.Postal_Code_1	:= left.Postal_Code_1A;
			SELF.companies.address2.City					:= left.City_A;
			SELF.companies.address2.State					:= left.State_A;
			SELF.companies.address2.Zip						:= left.Zip_A;
			SELF.companies.address2.Province			:= left.Province_A;
			SELF.companies.address2.Postal_Code_2	:= left.Postal_Code_2A;
			SELF.companies.address2.Country				:= left.CountryA;
			SELF.companies.address2.Postal_Code_3	:= left.Postal_Code_3A;
		
		//default company fields
			SELF.companies.parent_enterprise_number 	:= [];
			SELF.companies.ultimate_enterprise_number := [];
			SELF.companies.company_type 							:= [];
			SELF.companies.net_worth 									:= [];
			SELF.companies.doesimport 								:= [];
			SELF.companies.doesexport 								:= [];
			SELF.companies.exchange20 								:= [];
			SELF.companies.extended_profile 					:= [];
			SELF.companies.cbsa 											:= [];
			SELF.companies.competitors 								:= [];
			
			//killreport - not needed for PRCT
			SELF.killreport := left;
			SELF.killreport := [];
			
			//mergeracquis - not needed for PRCT
			SELF.mergeracquis := left;
			SELF.mergeracquis := [];
			
			//clean_phones
			SELF.clean_phones.phone := address.CleanPhone(left.phone);
			SELF.clean_phones.fax		:= address.CleanPhone(left.fax);
			SELF.clean_phones.telex	:= address.CleanPhone(left.telex);
			
			//clean_dates
			 SELF.clean_dates.update_date := left.update_date;

			// generating fake BDID AND DID  
			 // SELF.did 			:= prte2.fn_AppendFakeID.did(left.exec1_fname, left.exec1_lname, left.link_ssn, left.link_dob, left.cust_name);	
			 self.exec1_did := if(left.exec1_did > 0, left.exec1_did,  prte2.fn_AppendFakeID.did(left.exec1_fname, left.exec1_lname, left.exec1_link_ssn, left.exec1_link_dob, left.cust_name));	
			 self.exec2_did	:= if(left.exec2_did > 0, left.exec2_did,  prte2.fn_AppendFakeID.did(left.exec2_fname, left.exec2_lname, left.exec2_link_ssn, left.exec2_link_dob, left.cust_name));	
			 self.exec3_did	:= if(left.exec3_did > 0, left.exec3_did,  prte2.fn_AppendFakeID.did(left.exec3_fname, left.exec3_lname, left.exec3_link_ssn, left.exec3_link_dob, left.cust_name));	
			 self.exec4_did	:= if(left.exec4_did > 0, left.exec4_did,  prte2.fn_AppendFakeID.did(left.exec4_fname, left.exec4_lname, left.exec4_link_ssn, left.exec4_link_dob, left.cust_name));	
			 self.exec5_did	:= if(left.exec5_did > 0, left.exec5_did,  prte2.fn_AppendFakeID.did(left.exec5_fname, left.exec5_lname, left.exec5_link_ssn, left.exec5_link_dob, left.cust_name));	

			 SELF.bdid 	:= prte2.fn_AppendFakeID.bdid(left.Name,	SELF.physical_address.prim_range,	SELF.physical_address.prim_name, SELF.physical_address.v_city_name, SELF.physical_address.st, SELF.physical_address.zip, left.cust_name); 
      
			//generating linkids
       vLinkingIds := prte2.fn_AppendFakeID.LinkIds(left.name, left.link_fein, left.link_inc_date, SELF.physical_address.prim_range, SELF.physical_address.prim_name, 
                                                   SELF.physical_address.sec_range, SELF.physical_address.v_city_name, SELF.physical_address.st, SELF.physical_address.zip, left.cust_name);
                      
       SELF.powid		:= vLinkingIds.powid;
       SELF.proxid	:= vLinkingIds.proxid;
       SELF.seleid	:= vLinkingIds.seleid;
       SELF.orgid		:= vLinkingIds.orgid;
       SELF.ultid		:= vLinkingIds.ultid;	 
			 
			 self.file_type	:= left.type_orig;
			
			 SELF := left;
			 SELF := [];
			
));
	
	file_clean_sort := sort(d_out(addr_type_flag='M'), row_id); //addr_type_flag flag is 'M' or 'P'
	
	df_base := PROJECT(file_clean_sort, PRTE2_DCA.Layouts.layout_base);
	
	//Populate global sids
	assign_global_sid := MDR.macGetGlobalSid(df_base, 'DCA', 'file_type', 'global_sid');

	PromoteSupers.MAC_SF_BuildProcess(assign_global_sid,Constants.base_dca, writefile);

	Return writefile;
		
END;