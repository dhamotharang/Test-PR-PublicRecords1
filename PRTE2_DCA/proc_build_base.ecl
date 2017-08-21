IMPORT  PRTE2_DCA, PRTE2, PromoteSupers, Address, ut, AID, AID_Support;
#constant(AID_Support.Constants.StoredWhichAIDCache, AID_Support.Constants.eCache.ForNonHeader);

EXPORT proc_build_base(String filedate) := FUNCTION

	dIn	:= PRTE2_DCA.Files.file_in_plus;
	
	unsigned4	lFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;
		
	AID.MacAppendFromRaw_2Line(dIn, addr_1, addr_2, rawaid, addr_clean, lFlags);
	
	addr_clean CleanAll(addr_clean mailing, addr_clean physical) := TRANSFORM
			SELF.physical_address.prim_range	:=  physical.AIDWork_ACECache.prim_range;
			SELF.physical_address.predir      :=  physical.AIDWork_ACECache.predir;
			SELF.physical_address.prim_name   :=  physical.AIDWork_ACECache.prim_name;
			SELF.physical_address.addr_suffix :=  physical.AIDWork_ACECache.addr_suffix;
			SELF.physical_address.postdir     :=  physical.AIDWork_ACECache.postdir;
			SELF.physical_address.unit_desig  :=  physical.AIDWork_ACECache.unit_desig;
			SELF.physical_address.sec_range   :=  physical.AIDWork_ACECache.sec_range;
			SELF.physical_address.p_city_name :=  physical.AIDWork_ACECache.p_city_name;
			SELF.physical_address.v_city_name :=  physical.AIDWork_ACECache.v_city_name;
			SELF.physical_address.st          :=  physical.AIDWork_ACECache.st;
			SELF.physical_address.zip         :=  physical.AIDWork_ACECache.zip5;
			SELF.physical_address.zip4        :=  physical.AIDWork_ACECache.zip4;
			SELF.physical_address.cart        :=  physical.AIDWork_ACECache.cart;
			SELF.physical_address.cr_sort_sz  :=  physical.AIDWork_ACECache.cr_sort_sz;
			SELF.physical_address.lot         :=  physical.AIDWork_ACECache.lot;
			SELF.physical_address.lot_order   :=  physical.AIDWork_ACECache.lot_order;
			SELF.physical_address.dbpc        :=  physical.AIDWork_ACECache.dbpc;
			SELF.physical_address.chk_digit   :=  physical.AIDWork_ACECache.chk_digit;
			SELF.physical_address.rec_type    :=  physical.AIDWork_ACECache.rec_type;
			SELF.physical_address.geo_lat     :=  physical.AIDWork_ACECache.geo_lat;
			SELF.physical_address.geo_long    :=  physical.AIDWork_ACECache.geo_long;
			SELF.physical_address.msa         :=  physical.AIDWork_ACECache.msa;
			SELF.physical_address.geo_blk     :=  physical.AIDWork_ACECache.geo_blk;
			SELF.physical_address.geo_match   :=  physical.AIDWork_ACECache.geo_match;
			SELF.physical_address.err_stat  	:=  physical.AIDWork_ACECache.err_stat;
			SELF.physical_rawaid              :=  physical.AIDWork_RawAID;
			SELF.physical_address.fips_state 	:=  physical.addr_type_flag;	
			SELF.physical_addr_1 							:=  physical.addr_1;
			SELF.physical_addr_2							:=  physical.addr_2;
			
			SELF.mailing_address.prim_range  	:=  mailing.AIDWork_ACECache.prim_range;
			SELF.mailing_address.predir       :=  mailing.AIDWork_ACECache.predir;
			SELF.mailing_address.prim_name    :=  mailing.AIDWork_ACECache.prim_name;
			SELF.mailing_address.addr_suffix 	:=  mailing.AIDWork_ACECache.addr_suffix;
			SELF.mailing_address.postdir      :=  mailing.AIDWork_ACECache.postdir;
			SELF.mailing_address.unit_desig  	:=  mailing.AIDWork_ACECache.unit_desig;
			SELF.mailing_address.sec_range    :=  mailing.AIDWork_ACECache.sec_range;
			SELF.mailing_address.p_city_name 	:=  mailing.AIDWork_ACECache.p_city_name;
			SELF.mailing_address.v_city_name 	:=  mailing.AIDWork_ACECache.v_city_name;
			SELF.mailing_address.st           :=  mailing.AIDWork_ACECache.st;
			SELF.mailing_address.zip          :=  mailing.AIDWork_ACECache.zip5;
			SELF.mailing_address.zip4         :=  mailing.AIDWork_ACECache.zip4;
			SELF.mailing_address.cart         :=  mailing.AIDWork_ACECache.cart;
			SELF.mailing_address.cr_sort_sz   :=  mailing.AIDWork_ACECache.cr_sort_sz;
			SELF.mailing_address.lot          :=  mailing.AIDWork_ACECache.lot;
			SELF.mailing_address.lot_order    :=  mailing.AIDWork_ACECache.lot_order;
			SELF.mailing_address.dbpc         :=  mailing.AIDWork_ACECache.dbpc;
			SELF.mailing_address.chk_digit    :=  mailing.AIDWork_ACECache.chk_digit;
			SELF.mailing_address.rec_type  		:=  mailing.AIDWork_ACECache.rec_type;
			SELF.mailing_address.geo_lat      :=  mailing.AIDWork_ACECache.geo_lat;
			SELF.mailing_address.geo_long     :=  mailing.AIDWork_ACECache.geo_long;
			SELF.mailing_address.msa          :=  mailing.AIDWork_ACECache.msa;
			SELF.mailing_address.geo_blk      :=  mailing.AIDWork_ACECache.geo_blk;
			SELF.mailing_address.geo_match    :=  mailing.AIDWork_ACECache.geo_match;
			SELF.mailing_address.err_stat    	:=  mailing.AIDWork_ACECache.err_stat;
			SELF.mailing_rawaid               :=  mailing.AIDWork_RawAID;      
			SELF.mailing_address.fips_state 	:=  mailing.addr_type_flag;		
			SELF.mailing_addr_1 							:=  mailing.addr_1;
			SELF.mailing_addr_2								:=  mailing.addr_2;			
			
			//all of the rest of the fields in both datasets match, so just take everything from mailing
			//companies
			SELF.companies.Assets 				:= mailing.Assets;
			SELF.companies.Bus_Desc 			:= mailing.Bus_Desc;
			SELF.companies.E_mail 				:= mailing.E_mail;
			SELF.companies.Earnings 			:= mailing.Earnings;
			SELF.companies.EMP_NUM 				:= mailing.EMP_NUM;
			SELF.companies.Enterprise_num := mailing.Enterprise_num;
			SELF.companies.Exchange1 			:= mailing.Exchange1;
			SELF.companies.Exchange10 		:= mailing.Exchange10;
			SELF.companies.Exchange11 		:= mailing.Exchange11;
			SELF.companies.Exchange12 		:= mailing.Exchange12;
			SELF.companies.Exchange13 		:= mailing.Exchange13;
			SELF.companies.Exchange14 		:= mailing.Exchange14;
			SELF.companies.Exchange15 		:= mailing.Exchange15;
			SELF.companies.Exchange16 		:= mailing.Exchange16;
			SELF.companies.Exchange17 		:= mailing.Exchange17;
			SELF.companies.Exchange18 		:= mailing.Exchange18;
			SELF.companies.Exchange19 		:= mailing.Exchange19;
			SELF.companies.Exchange2 			:= mailing.Exchange2;
			SELF.companies.Exchange3 			:= mailing.Exchange3;
			SELF.companies.Exchange4 			:= mailing.Exchange4;
			SELF.companies.Exchange5 			:= mailing.Exchange5;
			SELF.companies.Exchange6 			:= mailing.Exchange6;
			SELF.companies.Exchange7 			:= mailing.Exchange7;
			SELF.companies.Exchange8 			:= mailing.Exchange8;
			SELF.companies.Exchange9 			:= mailing.Exchange9;
			SELF.companies.Fax 						:= mailing.Fax;
			SELF.companies.FYE 						:= mailing.FYE;
			SELF.companies.Incorp 				:= mailing.Incorp;
			SELF.companies.JV_Parent1 		:= mailing.JV_Parent1;
			SELF.companies.jv1_num 				:= mailing.jv1_;
			SELF.companies.JV_Parent2 		:= mailing.JV_Parent2;
			SELF.companies.jv2_num 				:= mailing.jv2_;
			SELF.companies.Level 					:= mailing.Level;
			SELF.companies.Liabilities 		:= mailing.Liabilities;
			SELF.companies.Naics_Text1 		:= mailing.Naics_Text1;
			SELF.companies.Naics_Text10 	:= mailing.Naics_Text10;
			SELF.companies.Naics_Text2 		:= mailing.Naics_Text2;
			SELF.companies.Naics_Text3 		:= mailing.Naics_Text3;
			SELF.companies.Naics_Text4 		:= mailing.Naics_Text4;
			SELF.companies.Naics_Text5 		:= mailing.Naics_Text5;
			SELF.companies.Naics_Text6 		:= mailing.Naics_Text6;
			SELF.companies.Naics_Text7 		:= mailing.Naics_Text7;
			SELF.companies.Naics_Text8 		:= mailing.Naics_Text8;
			SELF.companies.Naics_Text9 		:= mailing.Naics_Text9;
			SELF.companies.Naics1 				:= mailing.Naics1;
			SELF.companies.Naics10 				:= mailing.Naics10;
			SELF.companies.Naics2 				:= mailing.Naics2;
			SELF.companies.Naics3 				:= mailing.Naics3;
			SELF.companies.Naics4 				:= mailing.Naics4;
			SELF.companies.Naics5 				:= mailing.Naics5;
			SELF.companies.Naics6 				:= mailing.Naics6;
			SELF.companies.Naics7 				:= mailing.Naics7;
			SELF.companies.Naics8 				:= mailing.Naics8;
			SELF.companies.Naics9 				:= mailing.Naics9;
			SELF.companies.Name 					:= mailing.Name;
			SELF.companies.Note 					:= mailing.Note;
			SELF.companies.Parent_Name 		:= mailing.Parent_Name;
			SELF.companies.Parent_Number 	:= mailing.Parent_Number;
			SELF.companies.percent_owned 	:= mailing.percent_owned;
			SELF.companies.Phone 					:= mailing.Phone;
			SELF.companies.Root 					:= mailing.Root;
			SELF.companies.Sales 					:= mailing.Sales;
			SELF.companies.Sales_Desc 		:= mailing.Sales_Desc;
			SELF.companies.Sic1 					:= mailing.Sic1;
			SELF.companies.Sic10 					:= mailing.Sic10;
			SELF.companies.Sic2 					:= mailing.Sic2;
			SELF.companies.Sic3 					:= mailing.Sic3;
			SELF.companies.Sic4 					:= mailing.Sic4;
			SELF.companies.Sic5 					:= mailing.Sic5;
			SELF.companies.Sic6 					:= mailing.Sic6;
			SELF.companies.Sic7 					:= mailing.Sic7;
			SELF.companies.Sic8 					:= mailing.Sic8;
			SELF.companies.Sic9 					:= mailing.Sic9;
			SELF.companies.Sub 						:= mailing.Sub;
			SELF.companies.Telex 					:= mailing.Telex;
			SELF.companies.Text1 					:= mailing.Text1;
			SELF.companies.Text10 				:= mailing.Text10;
			SELF.companies.Text2 					:= mailing.Text2;
			SELF.companies.Text3 					:= mailing.Text3;
			SELF.companies.Text4 					:= mailing.Text4;
			SELF.companies.Text5 					:= mailing.Text5;
			SELF.companies.Text6 					:= mailing.Text6;
			SELF.companies.Text7 					:= mailing.Text7;
			SELF.companies.Text8 					:= mailing.Text8;
			SELF.companies.Text9 					:= mailing.Text9;
			SELF.companies.Ticker_Symbol 	:= mailing.Ticker_Symbol;
			SELF.companies.Update_Date 		:= mailing.Update_Date;
			SELF.companies.URL 						:= mailing.URL;
			//physical address from input file
			SELF.companies.address1.PO_Box_Bldg		:= mailing.PO_Box_Bldg;
			SELF.companies.address1.Street				:= mailing.Street;
			SELF.companies.address1.Foreign_PO		:= mailing.Foreign_PO;
			SELF.companies.address1.Misc__adr			:= mailing.Misc__adr;
			SELF.companies.address1.Postal_Code_1	:= mailing.Postal_Code_1;
			SELF.companies.address1.City					:= mailing.City;
			SELF.companies.address1.State					:= mailing.State;
			SELF.companies.address1.Zip						:= mailing.Zip;
			SELF.companies.address1.Province			:= mailing.Province;
			SELF.companies.address1.Postal_Code_2	:= mailing.Postal_Code_2;
			SELF.companies.address1.Country				:= mailing.Country;
			SELF.companies.address1.Postal_Code_3	:= mailing.Postal_Code_3;
			//mailing address from input file
			SELF.companies.address2.PO_Box_Bldg		:= mailing.PO_Box_Bldg_A;
			SELF.companies.address2.Street				:= mailing.StreetA;
			SELF.companies.address2.Foreign_PO		:= mailing.Foreign_PO_BoxA;
			SELF.companies.address2.Misc__adr			:= mailing.Misc__adr_A;
			SELF.companies.address2.Postal_Code_1	:= mailing.Postal_Code_1A;
			SELF.companies.address2.City					:= mailing.City_A;
			SELF.companies.address2.State					:= mailing.State_A;
			SELF.companies.address2.Zip						:= mailing.Zip_A;
			SELF.companies.address2.Province			:= mailing.Province_A;
			SELF.companies.address2.Postal_Code_2	:= mailing.Postal_Code_2A;
			SELF.companies.address2.Country				:= mailing.CountryA;
			SELF.companies.address2.Postal_Code_3	:= mailing.Postal_Code_3A;
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
			SELF.killreport := mailing;
			SELF.killreport := [];
			
			//mergeracquis - not needed for PRCT
			SELF.mergeracquis := mailing;
			SELF.mergeracquis := [];
			
			//clean_phones
			SELF.clean_phones.phone := address.CleanPhone(mailing.phone);
			SELF.clean_phones.fax		:= address.CleanPhone(mailing.fax);
			SELF.clean_phones.telex	:= address.CleanPhone(mailing.telex);
			
			//clean_dates
			SELF.clean_dates.update_date := mailing.update_date;

			//generating fake BDID AND DID  
			SELF.did 		:= prte2.fn_AppendFakeID.did(mailing.exec1_fname, mailing.exec1_lname, mailing.link_ssn, mailing.link_dob, mailing.cust_name);	
			SELF.bdid 	:= prte2.fn_AppendFakeID.bdid(mailing.Name,	SELF.physical_address.prim_range,	SELF.physical_address.prim_name, SELF.physical_address.v_city_name, SELF.physical_address.st, SELF.physical_address.zip, mailing.cust_name); 
      //generating linkids
      vLinkingIds := prte2.fn_AppendFakeID.LinkIds(mailing.name, mailing.link_fein, mailing.link_inc_date, SELF.physical_address.prim_range, SELF.physical_address.prim_name, 
                                                   SELF.physical_address.sec_range, SELF.physical_address.v_city_name, SELF.physical_address.st, SELF.physical_address.zip, mailing.cust_name);
                      
      SELF.powid	:= vLinkingIds.powid;
      SELF.proxid	:= vLinkingIds.proxid;
      SELF.seleid	:= vLinkingIds.seleid;
      SELF.orgid	:= vLinkingIds.orgid;
      SELF.ultid	:= vLinkingIds.ultid;	 
			
			SELF := mailing;
			SELF := [];
	END;
	
	file_clean_sort := sort(addr_clean, row_id, addr_type_flag); //addr_type_flag flag is 'M' or 'P'
	
	file_clean_rollup := rollup(file_clean_sort, CleanAll(left,right), row_id);
	
	df_base := PROJECT(file_clean_rollup, PRTE2_DCA.Layouts.layout_base);

	PromoteSupers.MAC_SF_BuildProcess(df_base,Constants.base_dca, writefile);

	Return writefile;


END;