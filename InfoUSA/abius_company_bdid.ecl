import infoUSA, did_add, ut, header_slimSORT, didville, business_header,business_header_ss, address,watchdog,mdr, AID,lib_stringlib, idl_header,BIPV2;

abius_in 	:= InfoUSA.File_ABIUS_Company_Data_In;

layout_AID_temp	:= RECORD
 	abius_in;
	AID.Common.xAID	Append_RawAID;
	AID.Common.xAID	Append_ACEAID;
	string100	prep_addr_line1;
	string50	prep_addr_last_line;			
END;

layout_AID_temp trfPrepAddr(abius_in l)	:=	transform
	self.prep_addr_line1			:=	l.STREET1;
	self.prep_addr_last_line	:=	lib_StringLib.StringLib.StringToUpperCase(trim(trim(l.city1,left,right) + if(l.city1 <> '',', ',''),left)
																		+ trim(l.STATE1,left,right) + ' ' + trim(l.ZIP1_5,left,right));
	self.Append_RawAID				:=	0;
	self.Append_ACEAID				:=	0;	
	self											:=	l;
	self											:=	[];
end;

fileAID 	:= project(abius_in, trfPrepAddr(left));

HasAddress	:=	trim(fileAID.prep_addr_last_line, left,right) != '';
									
dWith_address			:= fileAID(HasAddress);
dWithout_address	:= fileAID(not(HasAddress));

unsigned4	lFlags 	:= AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	

AID.MacAppendFromRaw_2Line(dWith_address, prep_addr_line1, prep_addr_last_line, Append_RawAID, dwithAID, lFlags);
	
dBase := project(dwithAID,transform(
																			layout_AID_temp
																			,
																			self.Append_ACEAID			:= left.aidwork_acecache.aid;
																			self.Append_RawAID			:= left.aidwork_rawaid;
																			self.prim_range					:= left.aidwork_acecache.prim_range;
																			self.predir							:= left.aidwork_acecache.predir;
																			self.prim_name					:= left.aidwork_acecache.prim_name;
																			self.addr_suffix				:= left.aidwork_acecache.addr_suffix;
																			self.postdir						:= left.aidwork_acecache.postdir;
																			self.unit_desig					:= left.aidwork_acecache.unit_desig;
																			self.sec_range					:= left.aidwork_acecache.sec_range;
																			self.p_city_name				:= left.aidwork_acecache.p_city_name;
																			self.v_city_name				:= left.aidwork_acecache.v_city_name;
																			self.st									:= left.aidwork_acecache.st;
																			self.z5									:= left.aidwork_acecache.zip5;
																			self.zip4								:= left.aidwork_acecache.zip4;
																			self.cart								:= left.aidwork_acecache.cart;
																			self.cr_sort_sz					:= left.aidwork_acecache.cr_sort_sz;
																			self.lot								:= left.aidwork_acecache.lot;
																			self.lot_order					:= left.aidwork_acecache.lot_order;
																			self.dpbc								:= left.aidwork_acecache.dbpc;
																			self.chk_digit					:= left.aidwork_acecache.chk_digit;
																			self.rec_type						:= left.aidwork_acecache.rec_type;
																			self.county							:= left.aidwork_acecache.county;
																			self.geo_lat						:= left.aidwork_acecache.geo_lat;
																			self.geo_long						:= left.aidwork_acecache.geo_long;
																			self.msa								:= left.aidwork_acecache.msa;
																			self.geo_blk						:= left.aidwork_acecache.geo_blk;
																			self.geo_match					:= left.aidwork_acecache.geo_match;
																			self.err_stat						:= left.aidwork_acecache.err_stat;
																			self										:= left;
																		)
								) + dWithout_address;
	
ut.mac_flipnames(dBase,fname,mname,lname,dFlippedNames);	

layout_abi_number 
    :=RECORD
	   dFlippedNames.abi_number;
		 dFlippedNames.process_date;
	END;
	
layout_abius_temp := record
      BIPV2.IDlayouts.l_xlink_ids;  //Added for BIP project	
			unsigned8 source_rec_id := 0; //Added for BIP project	
      string2 source;
			unsigned4 dt_first_seen;   // Date record first seen at Seisint
			unsigned4 dt_last_seen;    // Date record last (most recently seen) at Seisint
			unsigned4 dt_vendor_first_reported;
			unsigned4 dt_vendor_last_reported;
			unsigned6 tmsid;
			qstring34 vendor_id;
			abius_in;
		  string17 AD_SIZE;
			string20 POPULATION;
			string20 EMPLOYEE_SIZE;
			string30 SALES_VOLUME;
			string40 INDUSTRY_desc;
			string25 BUSINESS_STATUS;
			string20 OFFICE_SIZE;
			string13 TOTAL_EMPLOYEE_SIZE;
			string30 TOTAL_OUTPUT_SALES;
			string6  STOCK_EXCHANGE;
			string27 CREDIT_DESC;
			string10 INDIVIDUAL_FIRM;
			string50 sic_desc;
			string50 secondary_sic_desc1;
			string50 secondary_sic_desc2;
			string50 secondary_sic_desc3;
			string50 secondary_sic_desc4;
			AID.Common.xAID	Append_RawAID;
			AID.Common.xAID	Append_ACEAID;
			string100	prep_addr_line1;
			string50	prep_addr_last_line;	
end;

layout_abius_temp AddSeqNum(dFlippedNames l, unsigned4 cnt) := transform
    self.source_rec_id              := HASH64(TRIM(L.ABI_NUMBER) + TRIM(L.COMPANY_NAME) + TRIM(L.SIC_CD) + TRIM(L.SUBSIDIARY_PARENT_NUM) +
		                                   TRIM(L.ULTIMATE_PARENT_NUM) + TRIM(L.STREET1) + TRIM(L.CITY1) + TRIM(L.STATE1) + TRIM(L.PHONE) +
																	     StringLib.StringToUpperCase(TRIM(L.CONTACT_FNAME)) + StringLib.StringToUpperCase(TRIM(L.CONTACT_LNAME)) + TRIM(L.CONTACT_TITLE));
		self.source                     := mdr.sourceTools.src_INFOUSA_ABIUS_USABIZ;
		self.dt_first_seen              := (integer)(L.production_date[5..8] + L.production_date[1..4]);
		self.dt_last_seen               := (integer)(L.production_date[5..8] + L.production_date[1..4]);
		self.dt_vendor_first_reported   := (integer) L.process_date;
		self.dt_vendor_last_reported    := (integer) L.process_date;
		self.tmsid:= cnt;
		self.production_date            := (L.production_date[5..8] + L.production_date[1..4]);
		self.vendor_id := L.ABI_NUMBER + L.COMPANY_NAME;
		self.CREDIT_desc   	  := MAP(  L.CREDIT_CODE='A' =>'EXCELLENT',
									L.CREDIT_CODE='B' =>'VERY GOOD',
									L.CREDIT_CODE='C' =>'GOOD',
									L.CREDIT_CODE='I' =>'INSTITUTIONAL OR GOVERNMENT',
									L.CREDIT_CODE='U' =>'UNKNOWN',
									L.CREDIT_CODE='P' =>'PROFESSIONAL','');
		
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
	    self.Industry_desc          := decode_Industry(l.sic_cd+l.Industry_Specific_cd);
		self.SUBSIDIARY_PARENT_NUM  :=IF(regexreplace('^[0]+',l.SUBSIDIARY_PARENT_NUM,'')='','',l.SUBSIDIARY_PARENT_NUM);
	    self.ULTIMATE_PARENT_NUM    :=IF(regexreplace('^[0]+',l.ULTIMATE_PARENT_NUM,'')='','',l.ULTIMATE_PARENT_NUM);
	    self.NUM_EMPLOYEES_ACTUAL   :=regexreplace('^[0]+',l.NUM_EMPLOYEES_ACTUAL,'');
	    self.TOTAL_EMPLOYEES_ACTUAL :=regexreplace('^[0]+',l.TOTAL_EMPLOYEES_ACTUAL,'');
	  
		self := l;
end;
layout_abius_temp  rollupXform(layout_abius_temp pLeft, layout_abius_temp pRight) 
	:= transform
		
		self.Process_date  := (string8) Max((integer)pLeft.Process_date, (integer)pRight.Process_date);
		self.Dt_First_Seen := ut.Min2(pLeft.dt_First_Seen,pRight.dt_First_Seen);
		self.Dt_Last_Seen  := Max(pLeft.dt_Last_Seen ,pRight.dt_last_seen);
		self.Dt_Vendor_First_Reported := ut.min2(pLeft.dt_Vendor_First_Reported,pRight.dt_Vendor_First_Reported);
		self.Dt_Vendor_Last_Reported  := Max(pLeft.dt_Vendor_Last_Reported,pRight.dt_Vendor_Last_Reported);
		self 			   := pLeft;
	END;


dSlimer     := Sort(distribute(Table(dFlippedNames,Layout_ABi_number),hash(ABi_Number)),Abi_number,-process_date,local);
dLookup     := dedup(dSlimer,Abi_number);

file_in     := sort(distribute(dFlippedNames,hash(abi_number)),abi_number,process_date,local);

dGetlastedD := join(file_in,dLookup,left.abi_number=right.abi_number and left.process_date=right.process_date,lookup);

file_SORT 	:= SORT(distribute(project(dGetlastedD, AddSeqNum(left, counter))
					,hash(abi_number,company_name))
				    ,RECORD, EXCEPT tmsid,production_date,Process_date, dt_First_Seen, dt_Last_Seen,
								dt_Vendor_First_Reported, dt_Vendor_Last_Reported,rec_type,local);

abius_tmsid := rollup(file_SORT,rollupXform(LEFT,RIGHT),RECORD,
                                EXCEPT tmsid,production_date,Process_date, dt_First_Seen, dt_Last_Seen,
								dt_Vendor_First_Reported, dt_Vendor_Last_Reported,rec_type,local);
			       

layout_abius_bdid := record
BIPV2.IDlayouts.l_xlink_ids; 
abius_tmsid.source_rec_id;
abius_tmsid.source;
unsigned6 bdid := 0;
abius_tmsid.tmsid;
abius_tmsid.vendor_id;
abius_tmsid.company_name;
abius_tmsid.prim_range;
abius_tmsid.prim_name;
abius_tmsid.sec_range;
abius_tmsid.p_city_name;
abius_tmsid.st;
abius_tmsid.z5;
abius_tmsid.phone;
abius_tmsid.abi_number;
abius_tmsid.fname;
abius_tmsid.mname;
abius_tmsid.lname;
end;

abius_to_bdid := table(abius_tmsid, layout_abius_bdid);

// BDID ABIUS Company records

BDID_Matchset := ['A','P']; 
																	
Business_Header_SS.MAC_Add_BDID_Flex(abius_to_bdid            // Input Dataset
                                     ,BDID_Matchset           // BDID Matchset
                                     ,company_name            // company_name
                                     ,prim_range              // prim_range
																		 ,prim_name               // prim_name
																		 ,z5                      // zip5
                                     ,sec_range               // sec_range
																		 ,st                      // state
                                     ,phone                   // phone
																		 ,fein_field              // fein
                                     ,bdid                    // bdid
																		 ,layout_abius_bdid       // Output Layout
                                     ,false                   // output layout has bdid score field?
																		 ,BDID_score_field        // bdid_score
                                     ,abius_bdid_init         // Output Dataset   
	                                   ,												// default threscold
	                                   ,											  // use prod version of superfiles
                                     ,												// default is to hit prod from dataland, and on prod hit prod.		
	                                   ,BIPV2.xlink_version_set // Create BIP Keys only
	                                   ,           					   	// Url
	                                   ,								        // Email
	                                   ,p_city_name         		// City
	                                   ,fname          		      // fname
                                     ,mname          	      	// mname
	                                   ,lname          	        // lname
  																	 ,                        // contact_ssn
																		 ,source                  // source - MDR.sourceTools
																		 ,source_rec_id           // source_record_id
																		 ,FALSE                   // src_matching_is_priority
                                     );			
																	
abius_bdid_match := abius_bdid_init(bdid <> 0);

abius_bdid_nomatch := abius_bdid_init(bdid = 0);
Business_Header.MAC_Source_Match(abius_bdid_nomatch, abius_bdid_rematch,
                        false, bdid,
                        false, MDR.sourceTools.src_INFOUSA_ABIUS_USABIZ,
                        true, abi_number,
                        company_name,
                        prim_range, prim_name, sec_range, z5,
                        true, phone,
                        false, fein_field,
				        true, vendor_id);

abius_bdid_all := abius_bdid_match + abius_bdid_rematch;
					
// Append BDIDs and create base file
abius_bdid_append := join(abius_tmsid,
                          abius_bdid_all,
				                  left.tmsid= right.tmsid,
				                  transform(InfoUSA.Layout_ABIUS_Company_Base_AID,
									                  self.bdid       := right.bdid,
									                  self.ultid      := right.ultid,
								                  	self.orgid      := right.orgid,
									                  self.seleid     := right.seleid,
                                    self.proxid     := right.proxid,
                                    self.powid      := right.powid,
                                    self.empid      := right.empid,
                                    self.dotid      := right.dotid,
                                    self.ultscore   := right.ultscore,
                                    self.orgscore   := right.orgscore,
                                    self.selescore  := right.selescore,
                                    self.proxscore  := right.proxscore,
                                    self.powscore   := right.powscore,
                                    self.empscore   := right.empscore,
                                    self.dotscore   := right.dotscore,
                                    self.ultweight  := right.ultweight,
                                    self.orgweight  := right.orgweight,
                                    self.seleweight := right.seleweight,
                                    self.proxweight := right.proxweight,
                                    self.powweight  := right.powweight,
                                    self.empweight  := right.empweight,
                                    self.dotweight  := right.dotweight,
									                  self := left),
				                  left outer,
				                  hash);
//macro added to suppress people phone numbers
ut.mac_suppress_by_phonetype(abius_bdid_append, phone, st, abius_bdid_append_suppressed, false, '');

export abius_company_bdid := abius_bdid_append_suppressed : persist('TEMP::abius_company_bdid');
