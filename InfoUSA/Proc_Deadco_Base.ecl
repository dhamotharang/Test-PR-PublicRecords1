IMPORT infoUSA, did_add, ut, header_slimSORT, didville, business_header,business_header_ss, address,watchdog;

layout_deadco_temp 
	:= RECORD
			unsigned6 tmsid;
			qstring34 vendor_id;
			File_DEADCO_Clean_In;
			string15 AD_SIZE;
			string20 POPULATION;
			string20 EMPLOYEE_SIZE;
			string30 SALES_VOLUME;
			string40 INDUSTRY_desc;
			string12 BUSINESS_STATUS;
			string10 OFFICE_SIZE;
			string12 TOTAL_EMPLOYEE_SIZE;
			string30 TOTAL_OUTPUT_SALES;
			string5  STOCK_EXCHANGE;
			string27 CREDIT_DESC;
			string10 INDIVIDUAL_FIRM;
			string42 Franchise_desc;
			string50 sic_desc;
			string50 secondary_sic_desc1;
			string50 secondary_sic_desc2;
			string50 secondary_sic_desc3;
			string50 secondary_sic_desc4;
		
	END;

layout_deadco_temp AddridNum(File_DEADCO_Clean_In  pLeft, unsigned6 cnt) 
	:= transform
		self.tmsid 		   := cnt;
		self.vendor_id 	   := pLeft.ABI_number + pLeft.production_date;
		self.CREDIT_desc   := MAP(  pleft.CREDIT_CODE='A' =>'EXCELLENT',
									pleft.CREDIT_CODE='B' =>'VERY GOOD',
									pleft.CREDIT_CODE='C' =>'GOOD',
									pleft.CREDIT_CODE='I' =>'UNKNOWN',
									pleft.CREDIT_CODE='U' =>'INSTITUTIONAL OR GOVERNMENT','');
		
		self.INDIVIDUAL_FIRM       :=MAP(pLeft.INDIVIDUAL_FIRM_cd='1' =>'INDIVIDUAL',
		                                 pLeft.INDIVIDUAL_FIRM_cd='2' =>'FIRM','');
		self.ad_size       := MAP(  pLeft.ad_size_cd='A' =>'REGULAR LISTING',
									pLeft.ad_size_cd='B' =>'BOLD LISTING',
									pLeft.ad_size_cd='C' =>'IN-COLUMN LISTING',
									pLeft.ad_size_cd='D' =>'DISPLAY AD','');
									
		self.POPULATION    := MAP(  pLeft.POPULATION_CD='1' =>'1  - 24,999',
									pLeft.POPULATION_CD='5' =>'25,000 - 49,999',
									pLeft.POPULATION_CD='6' =>'50,000 - 99,999',
									pLeft.POPULATION_CD='7' =>'100,000 - 249,999',
									pLeft.POPULATION_CD='8' =>'250,000 - 499,999',
									pLeft.POPULATION_CD='9' =>'500,000 +','');
									
		self.EMPLOYEE_SIZE := MAP(pLeft.EMPLOYEE_SIZE_CD='A' =>'1 - 4',
									pLeft.EMPLOYEE_SIZE_CD='B' =>'5 - 9',
									pLeft.EMPLOYEE_SIZE_CD='C' =>'10 - 19',
									pLeft.EMPLOYEE_SIZE_CD='D' =>'20 - 49',
									pLeft.EMPLOYEE_SIZE_CD='E' =>'50 - 99',
									pLeft.EMPLOYEE_SIZE_CD='F' =>'100 - 249',
									pLeft.EMPLOYEE_SIZE_CD='G' =>'250 - 499',
									pLeft.EMPLOYEE_SIZE_CD='H' =>'500 - 999',
									pLeft.EMPLOYEE_SIZE_CD='I' =>'1,000 - 4,999',
									pLeft.EMPLOYEE_SIZE_CD='J' =>'5,000 - 9,999',
									pLeft.EMPLOYEE_SIZE_CD='K' =>'10,000 +','');
									
		self.SALES_VOLUME   := MAP(pLeft.SALES_VOLUME_CD='A'  =>'Less than $500,000',
									pLeft.SALES_VOLUME_CD='B' =>'$500,000 - $1 Million',
									pLeft.SALES_VOLUME_CD='C' =>'$1 Million  - $2.5 Million',
									pLeft.SALES_VOLUME_CD='D' =>'$2.5 Million - $5 Million ',
									pLeft.SALES_VOLUME_CD='E' =>'$5 Million - $10 Million',
									pLeft.SALES_VOLUME_CD='F' =>'$10 Million - $20 Million',
									pLeft.SALES_VOLUME_CD='G' =>'$20 Million - $50 Million',
									pLeft.SALES_VOLUME_CD='H' =>'$50 Million - $100 Million ',
									pLeft.SALES_VOLUME_CD='I' =>'$100 Million - $500 Million ',
									pLeft.SALES_VOLUME_CD='J' =>'$500 Million - $1 Billion',
									pLeft.SALES_VOLUME_CD='K' =>'Over $1 Billion ','');
									
		self.BUSINESS_STATUS  := MAP(pLeft.BUSINESS_STATUS_CD='1' =>'HEADQUARTERS',
									pLeft.BUSINESS_STATUS_CD='2' =>'BRANCHES',
									pLeft.BUSINESS_STATUS_CD='3' =>'SUBSIDIARY HEADQUARTERS','');
									
		self.OFFICE_SIZE     := MAP(pLeft.OFFICE_SIZE_CD='A'  =>'1 PROFESSIONAL',
									pLeft.OFFICE_SIZE_CD='B' =>'2 PROFESIONALS',
									pLeft.OFFICE_SIZE_CD='C' =>'3 PROFESSIONALS',
									pLeft.OFFICE_SIZE_CD='D' =>'4 PROFESSIONALS',
									pLeft.OFFICE_SIZE_CD='E' =>'5 - 9 PROFESSIONALS',
									pLeft.OFFICE_SIZE_CD='F' =>'10+ PROFESSIONALS','');
		self.TOTAL_EMPLOYEE_SIZE:= MAP(pLeft.TOTAL_EMPLOYEE_SIZE_CD='A' =>'1 - 4',
									pLeft.TOTAL_EMPLOYEE_SIZE_CD='B' =>'5 - 9',
									pLeft.TOTAL_EMPLOYEE_SIZE_CD='C' =>'10 - 19',
									pLeft.TOTAL_EMPLOYEE_SIZE_CD='D' =>'20 - 49',
									pLeft.TOTAL_EMPLOYEE_SIZE_CD='E' =>'50 - 99',
									pLeft.TOTAL_EMPLOYEE_SIZE_CD='F' =>'100 - 249',
									pLeft.TOTAL_EMPLOYEE_SIZE_CD='G' =>'250 - 499',
									pLeft.TOTAL_EMPLOYEE_SIZE_CD='H' =>'500 - 999',
									pLeft.TOTAL_EMPLOYEE_SIZE_CD='I' =>'1,000 - 4,999',
									pLeft.TOTAL_EMPLOYEE_SIZE_CD='J' =>'5,000 - 9,999',
									pLeft.TOTAL_EMPLOYEE_SIZE_CD='K' =>'10,000 +','');	
		self.STOCK_EXCHANGE  	:= MAP( pLeft.STOCK_EXCHANGE_CD='1' =>'NYSE',
									pLeft.STOCK_EXCHANGE_CD='2' =>'ASE',
									pLeft.STOCK_EXCHANGE_CD='3' =>'NASDAQ',
									pLeft.STOCK_EXCHANGE_CD='9' =>'OTHER','');
		self.TOTAL_OUTPUT_SALES := MAP(pLeft.TOTAL_OUTPUT_SALES_CD='A'  =>'Less than $500,000',
									pLeft.TOTAL_OUTPUT_SALES_CD='B' =>'$500,000 - $1 Million',
									pLeft.TOTAL_OUTPUT_SALES_CD='C' =>'$1 Million  - $2.5 Million',
									pLeft.TOTAL_OUTPUT_SALES_CD='D' =>'$2.5 Million - $5 Million ',
									pLeft.TOTAL_OUTPUT_SALES_CD='E' =>'$5 Million - $10 Million',
									pLeft.TOTAL_OUTPUT_SALES_CD='F' =>'$10 Million - $20 Million',
									pLeft.TOTAL_OUTPUT_SALES_CD='G' =>'$20 Million - $50 Million',
									pLeft.TOTAL_OUTPUT_SALES_CD='H' =>'$50 Million - $100 Million ',
									pLeft.TOTAL_OUTPUT_SALES_CD='I' =>'$100 Million - $500 Million ',
									pLeft.TOTAL_OUTPUT_SALES_CD='J' =>'$500 Million - $1 Billion',
									pLeft.TOTAL_OUTPUT_SALES_CD='K' =>'Over $1 Billion ','');
		self.sic_desc			:= decode_SIC6(pLeft.sic_cd);
		self.secondary_sic_desc1:= decode_SIC6(pLeft.SECONDARY_SIC_1);
		self.secondary_sic_desc2:= decode_SIC6(pLeft.SECONDARY_SIC_2);
		self.secondary_sic_desc3:= decode_SIC6(pLeft.SECONDARY_SIC_3);
        self.secondary_sic_desc4:= decode_SIC6(pLeft.SECONDARY_SIC_4);
	    self.Industry_desc      := decode_Industry(pLeft.sic_cd+pLeft.Industry_Specific_cd);
	    self.Franchise_desc     := decode_Franchise(pLeft.sic_cd+pLeft.Franchise_cd);
		self 			        := pLeft;
	END;

recordof(file_Deadco_Clean_In)  rollupXform(File_DEADCO_Clean_In pLeft, File_DEADCO_Clean_In pRight) 
	:= transform
		
		self.Process_date  := IF(pLeft.Process_date > pRight.Process_date, pLeft.Process_date, pRight.Process_date);
		self.Dt_First_Seen := IF(pLeft.dt_First_Seen > pRight.dt_First_Seen, pRight.dt_First_Seen, pLeft.dt_First_Seen);
		self.Dt_Last_Seen  := IF(pLeft.dt_Last_Seen  < pRight.dt_Last_Seen,  pRight.dt_Last_Seen,  pLeft.dt_Last_Seen);
		self.Dt_Vendor_First_Reported := IF(pLeft.dt_Vendor_First_Reported > pRight.dt_Vendor_First_Reported, 
											pRight.dt_Vendor_First_Reported, pLeft.dt_Vendor_First_Reported);
		self.Dt_Vendor_Last_Reported  := IF(pLeft.dt_Vendor_Last_Reported  < pRight.dt_Vendor_Last_Reported,  
											pRight.dt_Vendor_Last_Reported, pLeft.dt_Vendor_Last_Reported);
		self 			   := pLeft;
	END;
	
file_in   				   := File_DEADCO_Clean_In;

file_SORT 	:= SORT(distribute(file_in, hash(zip5)),RECORD, except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported, process_date,local);  

deadco_tmsid:= DISTRIBUTE(project(rollup(file_SORT,rollupXform(LEFT,RIGHT),RECORD,
                                EXCEPT Process_date, dt_First_Seen, dt_Last_Seen,
								dt_Vendor_First_Reported, dt_Vendor_Last_Reported,local), AddridNum(left, counter))
			       ,HASH(tmsid));

layout_deadco_bdid 
	:= RECORD

		unsigned6 bdid 	:= 0;
		deadco_tmsid.tmsid;
		deadco_tmsid.vendor_id;
		deadco_tmsid.fname;
		deadco_tmsid.mname;
		deadco_tmsid.lname;
		deadco_tmsid.name_suffix;
		deadco_tmsid.company_name;
		deadco_tmsid.prim_range;
		deadco_tmsid.prim_name;
		deadco_tmsid.sec_range;
		deadco_tmsid.st;
		deadco_tmsid.zip5;
		deadco_tmsid.phone;
		deadco_tmsid.abi_number;
	END;

Layout_deadco_Base Tran_did_bdid_all(layout_deadco_temp pLeft,layout_deadco_bdid pRight)
	:=transform
	   
		self.bdid		:=pRight.bdid;
		self.vendor_id  :=pRight.vendor_id;
		self			:=pLeft;
	END;

deadco_to_bdid 			:= TABLE(deadco_tmsid, layout_deadco_bdid)(company_name<>'');
 

Business_Header.MAC_Source_Match(deadco_to_bdid
								,deadco_bdid_init
								,FALSE
								,bdid
								,FALSE
								,'ID'
								,TRUE
								,abi_number
								,company_name
								,prim_range
								,prim_name
								,sec_range
								,zip5
								,TRUE
								,phone
								,FALSE
								,fein_field
								,TRUE
								,vendor_id);


BDID_Matchset 		:= ['A','P'];

deadco_bdid_match 	:= deadco_bdid_init(bdid <> 0);

deadco_bdid_nomatch := deadco_bdid_init(bdid = 0);

Business_Header_SS.MAC_Add_BDID_Flex(deadco_bdid_nomatch,
									  BDID_Matchset,
									  company_name,
									  prim_range, 
									  prim_name, 
									  zip5,
									  sec_range, 
									  st,
									  phone, 
									  fein_field,
									  bdid, 
									  layout_deadco_bdid,
									  FALSE, 
									  BDID_score_field,
									  deadco_bdid_rematch)
Dbdid           	:= deadco_bdid_match + deadco_bdid_rematch:persist('TEMP::deadco_bdid');
deadco_bdid     	:= DISTRIBUTE(Dbdid  ,HASH(tmsid));
deadco_bdid_append 	:= JOIN(deadco_tmsid,
                           deadco_bdid,
				           LEFT.tmsid = right.tmsid,
				           Tran_did_bdid_all(LEFT,right),
				           LEFT outer,
				           LOCAL);
						   
ut.MAC_SF_BuildProcess(deadco_bdid_append,'~thor_data400::base::INFOUSA::deadco',do1,2);

export Proc_Deadco_base := do1;
