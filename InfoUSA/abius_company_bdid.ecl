import ut, Business_Header, Business_Header_SS, did_add;

abius_in := InfoUSA.File_ABIUS_Company_Data_In;

layout_abius_temp := record
			unsigned6 tmsid;
			qstring34 vendor_id;
			abius_in;
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
end;

layout_abius_temp AddSeqNum(abius_in l, unsigned4 cnt) := transform
		self.tmsid:= cnt;
		self.vendor_id := L.ABI_NUMBER + L.COMPANY_NAME;
		self.CREDIT_desc   	  := MAP(  L.CREDIT_CODE='A' =>'EXCELLENT',
									L.CREDIT_CODE='B' =>'VERY GOOD',
									L.CREDIT_CODE='C' =>'GOOD',
									L.CREDIT_CODE='I' =>'UNKNOWN',
									L.CREDIT_CODE='U' =>'INSTITUTIONAL OR GOVERNMENT','');
		
		self.INDIVIDUAL_FIRM  :=MAP(L.INDIVIDUAL_FIRM_cd='1' =>'INDIVIDUAL',
		                                 L.INDIVIDUAL_FIRM_cd='2' =>'FIRM','');
		self.ad_size       	  := MAP(  L.ad_size_cd='A' =>'REGULAR LISTING',
									L.ad_size_cd='B' =>'BOLD LISTING',
									L.ad_size_cd='C' =>'IN-COLUMN LISTING',
									L.ad_size_cd='D' =>'DISPLAY AD','');
									
		self.POPULATION       := MAP(  L.POPULATION_CD='1' =>'1  - 24,999',
									L.POPULATION_CD='5' =>'25,000 - 49,999',
									L.POPULATION_CD='6' =>'50,000 - 99,999',
									L.POPULATION_CD='7' =>'100,000 - 249,999',
									L.POPULATION_CD='8' =>'250,000 - 499,999',
									L.POPULATION_CD='9' =>'500,000 +','');
									
		self.EMPLOYEE_SIZE    := MAP(L.EMPLOYEE_SIZE_CD='A' =>'1 - 4',
									L.EMPLOYEE_SIZE_CD='B' =>'5 - 9',
									L.EMPLOYEE_SIZE_CD='C' =>'10 - 19',
									L.EMPLOYEE_SIZE_CD='D' =>'20 - 49',
									L.EMPLOYEE_SIZE_CD='E' =>'50 - 99',
									L.EMPLOYEE_SIZE_CD='F' =>'100 - 249',
									L.EMPLOYEE_SIZE_CD='G' =>'250 - 499',
									L.EMPLOYEE_SIZE_CD='H' =>'500 - 999',
									L.EMPLOYEE_SIZE_CD='I' =>'1,000 - 4,999',
									L.EMPLOYEE_SIZE_CD='J' =>'5,000 - 9,999',
									L.EMPLOYEE_SIZE_CD='K' =>'10,000 +','');
									
		self.SALES_VOLUME      := MAP(L.SALES_VOLUME_CD='A'  =>'Less than $500,000',
									L.SALES_VOLUME_CD='B' =>'$500,000 - $1 Million',
									L.SALES_VOLUME_CD='C' =>'$1 Million  - $2.5 Million',
									L.SALES_VOLUME_CD='D' =>'$2.5 Million - $5 Million ',
									L.SALES_VOLUME_CD='E' =>'$5 Million - $10 Million',
									L.SALES_VOLUME_CD='F' =>'$10 Million - $20 Million',
									L.SALES_VOLUME_CD='G' =>'$20 Million - $50 Million',
									L.SALES_VOLUME_CD='H' =>'$50 Million - $100 Million ',
									L.SALES_VOLUME_CD='I' =>'$100 Million - $500 Million ',
									L.SALES_VOLUME_CD='J' =>'$500 Million - $1 Billion',
									L.SALES_VOLUME_CD='K' =>'Over $1 Billion ','');
									
		self.BUSINESS_STATUS    := MAP(L.BUSINESS_STATUS_CD='1' =>'HEADQUARTERS',
									L.BUSINESS_STATUS_CD='2' =>'BRANCHES',
									L.BUSINESS_STATUS_CD='3' =>'SUBSIDIARY HEADQUARTERS','');
									
		self.OFFICE_SIZE        := MAP(L.OFFICE_SIZE_CD='A'  =>'1 PROFESSIONAL',
									L.OFFICE_SIZE_CD='B' =>'2 PROFESIONALS',
									L.OFFICE_SIZE_CD='C' =>'3 PROFESSIONALS',
									L.OFFICE_SIZE_CD='D' =>'4 PROFESSIONALS',
									L.OFFICE_SIZE_CD='E' =>'5 - 9 PROFESSIONALS',
									L.OFFICE_SIZE_CD='F' =>'10+ PROFESSIONALS','');
		self.TOTAL_EMPLOYEE_SIZE:= MAP(L.TOTAL_EMPLOYEE_SIZE_CD='A' =>'1 - 4',
									L.TOTAL_EMPLOYEE_SIZE_CD='B' =>'5 - 9',
									L.TOTAL_EMPLOYEE_SIZE_CD='C' =>'10 - 19',
									L.TOTAL_EMPLOYEE_SIZE_CD='D' =>'20 - 49',
									L.TOTAL_EMPLOYEE_SIZE_CD='E' =>'50 - 99',
									L.TOTAL_EMPLOYEE_SIZE_CD='F' =>'100 - 249',
									L.TOTAL_EMPLOYEE_SIZE_CD='G' =>'250 - 499',
									L.TOTAL_EMPLOYEE_SIZE_CD='H' =>'500 - 999',
									L.TOTAL_EMPLOYEE_SIZE_CD='I' =>'1,000 - 4,999',
									L.TOTAL_EMPLOYEE_SIZE_CD='J' =>'5,000 - 9,999',
									L.TOTAL_EMPLOYEE_SIZE_CD='K' =>'10,000 +','');	
		self.STOCK_EXCHANGE  	:= MAP( L.STOCK_EXCHANGE_CD='1' =>'NYSE',
									L.STOCK_EXCHANGE_CD='2' =>'ASE',
									L.STOCK_EXCHANGE_CD='3' =>'NASDAQ',
									L.STOCK_EXCHANGE_CD='9' =>'OTHER','');
		self.TOTAL_OUTPUT_SALES := MAP(L.TOTAL_OUTPUT_SALES_CD='A'  =>'Less than $500,000',
									L.TOTAL_OUTPUT_SALES_CD='B' =>'$500,000 - $1 Million',
									L.TOTAL_OUTPUT_SALES_CD='C' =>'$1 Million  - $2.5 Million',
									L.TOTAL_OUTPUT_SALES_CD='D' =>'$2.5 Million - $5 Million ',
									L.TOTAL_OUTPUT_SALES_CD='E' =>'$5 Million - $10 Million',
									L.TOTAL_OUTPUT_SALES_CD='F' =>'$10 Million - $20 Million',
									L.TOTAL_OUTPUT_SALES_CD='G' =>'$20 Million - $50 Million',
									L.TOTAL_OUTPUT_SALES_CD='H' =>'$50 Million - $100 Million ',
									L.TOTAL_OUTPUT_SALES_CD='I' =>'$100 Million - $500 Million ',
									L.TOTAL_OUTPUT_SALES_CD='J' =>'$500 Million - $1 Billion',
									L.TOTAL_OUTPUT_SALES_CD='K' =>'Over $1 Billion ','');
		self.sic_desc				:= decode_SIC6(l.sic_cd);
		self.secondary_sic_desc1	:= decode_SIC6(l.SECONDARY_SIC_1);
		self.secondary_sic_desc2	:= decode_SIC6(l.SECONDARY_SIC_2);
		self.secondary_sic_desc3	:= decode_SIC6(l.SECONDARY_SIC_3);
        self.secondary_sic_desc4	:= decode_SIC6(l.SECONDARY_SIC_4);
	    self.Industry_desc         := decode_Industry(l.sic_cd+l.Industry_Specific_cd);
	    self.Franchise_desc        := decode_Franchise(l.sic_cd+l.Franchise_cd);

		self := l;
end;

abius_tmsid:= project(abius_in, AddSeqNum(left, counter));

layout_abius_bdid := record
unsigned6 bdid := 0;
abius_tmsid.tmsid;
abius_tmsid.vendor_id;
abius_tmsid.company_name;
abius_tmsid.prim_range;
abius_tmsid.prim_name;
abius_tmsid.sec_range;
abius_tmsid.st;
abius_tmsid.z5;
abius_tmsid.phone;
abius_tmsid.abi_number;
end;

abius_to_bdid := table(abius_tmsid, layout_abius_bdid);

// BDID ABIUS Company records
Business_Header.MAC_Source_Match(abius_to_bdid, abius_bdid_init,
                        false, bdid,
                        false, 'IA',
                        true, abi_number,
                        company_name,
                        prim_range, prim_name, sec_range, z5,
                        true, phone,
                        false, fein_field,
				        true, vendor_id);


BDID_Matchset := ['A','P'];

abius_bdid_match := abius_bdid_init(bdid <> 0);

abius_bdid_nomatch := abius_bdid_init(bdid = 0);

Business_Header_SS.MAC_Add_BDID_Flex(abius_bdid_nomatch,
                                  BDID_Matchset,
                                  company_name,
                                  prim_range, prim_name, z5,
                                  sec_range, st,
                                  phone, fein_field,
                                  bdid, layout_abius_bdid,
                                  false, BDID_score_field,
                                  abius_bdid_rematch)

abius_bdid_all := abius_bdid_match + abius_bdid_rematch;
					
// Append BDIDs and create base file
abius_bdid_append := join(abius_tmsid,
                          abius_bdid_all,
				          left.tmsid= right.tmsid,
				          transform(InfoUSA.Layout_ABIUS_Company_Base, self.bdid := right.bdid, self := left),
				          left outer,
				          hash);

export abius_company_bdid := abius_bdid_append : persist('TEMP::abius_company_bdid');
