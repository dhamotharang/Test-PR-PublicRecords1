IMPORT _control, MDR, infoUSA, did_add, ut, header_slimSORT, didville, business_header,business_header_ss, address,watchdog,mdr,AID,lib_stringlib,idl_header,bipv2, PromoteSupers, std;

layout_deadco_temp 
	:= RECORD
	    unsigned6 tmsid;
			qstring34 vendor_id;
			File_DEADCO_Clean_In;
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
END;

layout_deadco_temp trfPrepAddr(File_DEADCO_Clean_In l)	:=	transform
	self.prep_addr_line1			:=	l.STREET1;
	self.prep_addr_last_line	:=	lib_StringLib.StringLib.StringToUpperCase(trim(trim(l.city1,left,right) + if(l.city1 <> '',', ',''),left)
																		+ trim(l.STATE1,left,right) + ' ' + trim(l.ZIP1_5,left,right));
	self.Append_RawAID				:=	0;
	self.Append_ACEAID				:=	0;	
	self											:=	l;
	self											:=	[];
end;

file_in			:= project(File_DEADCO_Clean_In,trfPrepAddr(left));

HasAddress	:=	trim(file_in.prep_addr_line1, left,right) != '' and 
								trim(file_in.prep_addr_last_line, left,right) != '';
									
dWith_address			:= file_in(HasAddress);
dWithout_address	:= file_in(not(HasAddress));

unsigned4	lFlags 	:= AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	

AID.MacAppendFromRaw_2Line(dWith_address, prep_addr_line1, prep_addr_last_line, Append_RawAID, dwithAID, lFlags);
	
dBase := project(dwithAID,transform(
																			layout_deadco_temp
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
																			self.zip5								:= left.aidwork_acecache.zip5;
																			self.zip4								:= left.aidwork_acecache.zip4;
																			self.cart								:= left.aidwork_acecache.cart;
																			self.cr_sort_sz					:= left.aidwork_acecache.cr_sort_sz;
																			self.lot								:= left.aidwork_acecache.lot;
																			self.lot_order					:= left.aidwork_acecache.lot_order;
																			self.dpbc								:= left.aidwork_acecache.dbpc;
																			self.chk_digit					:= left.aidwork_acecache.chk_digit;
																			self.rec_type						:= left.aidwork_acecache.rec_type;
																			self.ace_fips_st				:= left.aidwork_acecache.county[1..2];
																			self.ace_fips_county		:= left.aidwork_acecache.county[3..5];
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

layout_deadco_temp AddridNum(dFlippedNames  pLeft, unsigned6 cnt) 
	:= transform
		self.tmsid 		   := cnt;
		self.vendor_id 	   := pLeft.ABI_number + pLeft.production_date;
		self.CREDIT_desc   := MAP(  pleft.CREDIT_CODE='A' =>'EXCELLENT',
									pleft.CREDIT_CODE='B' =>'VERY GOOD',
									pleft.CREDIT_CODE='C' =>'GOOD',
									pleft.CREDIT_CODE='I' =>'INSTITUTIONAL OR GOVERNMENT',
									pleft.CREDIT_CODE='U' =>'UNKNOWN',
									pleft.CREDIT_CODE='P' =>'PROFESSIONAL','');
		
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
	    self.production_date    := (pLeft.production_date[5..8] + pLeft.production_date[1..4]);
		self.SUBSIDIARY_PARENT_NUM  :=IF(regexreplace('^[0]+',pleft.SUBSIDIARY_PARENT_NUM,'')='','',pleft.SUBSIDIARY_PARENT_NUM);
	    self.ULTIMATE_PARENT_NUM    :=IF(regexreplace('^[0]+',pleft.ULTIMATE_PARENT_NUM,'')='','',pleft.ULTIMATE_PARENT_NUM);
	    self.NUM_EMPLOYEES_ACTUAL   :=regexreplace('^[0]+',pleft.NUM_EMPLOYEES_ACTUAL,'');
	    self.TOTAL_EMPLOYEES_ACTUAL :=regexreplace('^[0]+',pleft.TOTAL_EMPLOYEES_ACTUAL,'');
		self 			        := pLeft;
	END;

recordof(dFlippedNames)  rollupXform(dFlippedNames pLeft, dFlippedNames pRight) 
	:= transform
		
		self.Process_date  := (string8) MAX((integer)pLeft.Process_date, (integer)pRight.Process_date);
		self.Dt_First_Seen := (string8) ut.Min2((integer)pLeft.dt_First_Seen,(integer)pRight.dt_First_Seen);
		self.Dt_Last_Seen  := (string8) MAX((integer)pLeft.dt_Last_Seen ,(integer)pRight.dt_last_seen);
		self.Dt_Vendor_First_Reported := (string8) ut.min2((integer)pLeft.dt_Vendor_First_Reported,(integer)pRight.dt_Vendor_First_Reported);
		self.Dt_Vendor_Last_Reported  := (string8) MAX((integer)pLeft.dt_Vendor_Last_Reported,(integer)pRight.dt_Vendor_Last_Reported);
    self 			   := pLeft;
	END;
	
file_SORT 	:= SORT(distribute(dFlippedNames, hash(zip5)),RECORD, except dt_first_seen,dt_last_seen, dt_vendor_first_reported,dt_vendor_last_reported, process_date,local);  

deadco_tmsid:= DISTRIBUTE(project(rollup(file_SORT,rollupXform(LEFT,RIGHT),RECORD,
                                EXCEPT Process_date, dt_First_Seen, dt_Last_Seen,
								dt_Vendor_First_Reported, dt_Vendor_Last_Reported,local), AddridNum(left, counter))
			       ,HASH(tmsid));

layout_deadco_bdid 
	:= RECORD
    BIPV2.IDlayouts.l_xlink_ids;
		string2 source := MDR.sourceTools.src_INFOUSA_DEAD_COMPANIES;
		unsigned6 bdid 	:= 0;
    unsigned8	source_rec_id := 0;	
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
		deadco_tmsid.p_city_name;
		deadco_tmsid.st;
		deadco_tmsid.zip5;
		deadco_tmsid.phone;
		deadco_tmsid.abi_number;
	END;

Layout_deadco_Base_AID Tran_did_bdid_all(layout_deadco_temp pLeft,layout_deadco_bdid pRight)
	:=transform
	   
		self.bdid		   := pRight.bdid;
		self.vendor_id := pRight.vendor_id;
		self.source_rec_id := 0;
		self.DotID		 := pRight.DotID;
		self.DotScore	 := pRight.DotScore;
		self.DotWeight := pRight.DotWeight;
		self.EmpID		 := pRight.EmpID;
		self.EmpScore	 := pRight.EmpScore;
		self.EmpWeight := pRight.EmpWeight;
		self.POWID		 := pRight.POWID;
		self.POWScore	 := pRight.POWScore;
		self.POWWeight := pRight.POWWeight;
		self.ProxID		 := pRight.ProxID;
		self.ProxScore := pRight.ProxScore;
		self.ProxWeight:= pRight.ProxWeight;
		self.SeleID		 := pRight.SeleID;
		self.SeleScore := pRight.SeleScore;
		self.SeleWeight:= pRight.SeleWeight;
		self.OrgID		 := pRight.OrgID;
		self.OrgScore	 := pRight.OrgScore;
		self.OrgWeight := pRight.OrgWeight;
		self.UltID		 := pRight.UltID;
		self.UltScore	 := pRight.UltScore;
		self.UltWeight := pRight.UltWeight;
		self.global_sid := 0;
		self.record_sid := 0;

		self			     := pLeft;
	END;

deadco_to_bdid 			:= TABLE(deadco_tmsid, layout_deadco_bdid)(company_name<>'');

BDID_Matchset 		:= ['A','P'];
 
Business_Header_SS.MAC_Add_BDID_Flex(
										deadco_to_bdid   					// Input Dataset
									  ,BDID_Matchset						// BDID Matchset
									  ,company_name							// company_name
									  ,prim_range 							// prim_range
									  ,prim_name 								// prim_name
									  ,zip5											// zip5
									  ,sec_range 								// sec_range
									  ,st												// state
									  ,phone 										// phone
									  ,fein_field								// fein
									  ,bdid 									  // bdid
									  ,layout_deadco_bdid			  // Output layout
									  ,FALSE 									  // output layout has bdid score field?
									  ,BDID_score_field				  // bdid_score
									  ,deadco_bdid_flex				  // Output dataset
										,												  // default threshold
										,												  // use prod version of superfiles
										,												  // default is to hit prod from dataland, and on prod hit prod
										,BIPV2.xlink_version_set  // Create BIP keys only
										,													// URL
										,													// Email
										,p_city_name							// City
										,fname										// fname
										,mname										// mname
										,lname										// lname
										,													// Contact_SSN
										,source										// Source - MDR.sourceTools
										,source_rec_id  					// Source_rec_id
										,FALSE 				);  				// Src_Matching_is_priority
			
BDID_not_zero := deadco_bdid_flex(bdid<>0);
BDID_zero     := deadco_bdid_flex(bdid=0);

Business_Header.MAC_Source_Match(
								 BDID_zero
								,dSourceMatchOut  
								,FALSE
								,bdid
								,FALSE
								,MDR.sourceTools.src_INFOUSA_DEAD_COMPANIES
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
									
Dbdid								:= dSourceMatchOut + BDID_not_zero : persist('TEMP::deadco_bdid');

deadco_bdid					:= DISTRIBUTE(Dbdid, HASH(tmsid));

deadco_bdid_append 	:= JOIN(deadco_tmsid,
														deadco_bdid,
														LEFT.tmsid = right.tmsid,
														Tran_did_bdid_all(LEFT,right),
														LEFT outer,
														LOCAL
														);

addGlobalSID				:= MDR.macGetGlobalSid(deadco_bdid_append,'DEADCO','','global_sid'); //DF-25968: Add Global_SID
														
ut.MAC_Append_Rcid(addGlobalSID, source_rec_id, deadco_source_rec_id);   
PromoteSupers.MAC_SF_BuildProcess(deadco_source_rec_id,'~thor_data400::base::INFOUSA::deadco',do1,2);

export Proc_Deadco_base := do1;
