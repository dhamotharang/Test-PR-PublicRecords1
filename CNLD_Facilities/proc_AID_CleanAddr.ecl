import ut, CNLD_Facilities, AID, Address, Lib_FileServices, lib_stringlib, DID_Add, Business_Header, Business_Header_SS, Prof_License_Mari,tools,MDR; 


in_Facilities := CNLD_Facilities.File_Facilities_in;


valid_military_states					:=	['AA','AE','AP','FM','MH','MP','PW'];
canadian_states_abbv := ['AB','BC','MB','NF','NT','NS','CN','ON','PE','QC','SK','YT'];
begin_paren := '^\\((.*)\\)(.*)$'; 
paren_pattern := '^(.*)\\((.*)\\)$';
single_paren := '^(.*)\\((.*)$';
sign_pattern := '^(.*)@(.*)$'; 
misc_pattern := '^(.*)(NO MAIL|NEED CHECK FOR|PAID FOR )(.*)$';
bad_addr_list := ['PO BOX #','PO BOX BOX','PO BOX NUMBER','PO BOX OFFICE','PO BOX BIN','PO BOX POB','PO BOX DRWR','PO BOX DRAWER'];

address_accept := '(PO BOX|GENERAL DELIVERY|^ONE |^TWO |^THREE |^SIX |^SIXTH |^EIGHT|^NINTH |^TEN |OFFICE CENTER|CNTR| OFFICE PARK| PLAZA$| PLAZA | PLZ|EXECUTIVE PARK|HWY)';
valid_unit_desig := '(^#| APT|^APT|BSMT|BLDG|^FL |FRNT|HNGR|LBBY|^LOT |LOWR|OFC|^PH |PIER|^PMB |^REAR|^RM |^SIDE|SLIP|SPC|^STOP|^STE |TRLR|^UNIT|^UPPR)';
city_addr := '(^BLDG |^SUITE |^STE |^#|^B1D )';


// Normalizing Addresses
r0 := RECORD
		CNLD_Facilities.layout_Facilities_Out;
		// string1		addr_ind;						
		string55	addr_id;            
		string55	addr_addr1;         
		string55	addr_addr2;
		string30	addr_city; 
		string2 	addr_st;
		string5		addr_zip;
		string10	addr_phone;
		string10	addr_fax;
		string8		addr_date;
		string1		addr_status;
		string1		addr_rank;
		string60	name_dba;												
		string50	name_contact;
		
END;

r0 	NormItAddr(CNLD_Facilities.layout_Facilities_Out L, INTEGER C) := TRANSFORM
SELF := L;
// self.ADDR_IND 		:=  '';
SELF.addr_id 		:= CHOOSE(C, L.addr1_id, L.addr2_id, L.addr3_id);
SELF.addr_addr1 := CHOOSE(C, L.addr1_line1, L.addr2_line1, L.addr3_line1);
SELF.addr_addr2 := CHOOSE(C, L.addr1_line2, L.addr2_line2, L.addr3_line2);
SELF.addr_city	:= CHOOSE(C, L.addr1_city, L.addr2_city, L.addr3_city);
SELF.addr_st		:= CHOOSE(C, L.addr1_st, L.addr2_st, L.addr3_st);
SELF.addr_zip		:= CHOOSE(C, L.addr1_zip, L.addr2_zip, L.addr3_zip);
SELF.addr_phone	:= CHOOSE(C, L.addr1_phone, L.addr2_phone, L.addr3_phone);
SELF.addr_fax		:= CHOOSE(C, L.addr1_fax, L.addr2_fax, L.addr3_fax);
SELF.addr_date	:= CHOOSE(C, L.addr1_date, L.addr2_date, L.addr3_date);
SELF.addr_status := CHOOSE(C, L.addr1_status, L.addr3_status, L.addr3_status);
SELF.addr_rank	:= CHOOSE(C, L.addr1_rank, L.addr2_rank, L.addr3_rank);
SELF.name_dba := CHOOSE(C, L.name_dba_1, L.name_dba_2, L.name_dba_3);
SELF.name_contact := CHOOSE(C, L.name_contact_1, L.name_contact_2, L.name_contact_3);

END;

NormAddr := DEDUP(NORMALIZE(in_Facilities,3,NormItAddr(LEFT,COUNTER)),all,record);

BlankAddrRecs	:= NormAddr(addr1_id = '' AND addr2_id = '' AND addr3_id = '');
AddrRecs 	:= NormAddr(addr_id != '');
FilteredDeaRecs  := BlankAddrRecs + AddrRecs;

dsFacilityFile := sort(distribute(PROJECT(FilteredDeaRecs, transform(CNLD_Facilities.layout_Facilities_Slim, self :=left)),hash(gennum)),gennum,local);


layout_FacilDIDClean :=
		RECORD
			CNLD_Facilities.layout_Facilities_Slim;
			unsigned6	BDID,
			unsigned6	BDID_SCORE,
			unsigned6	RAWAID,
			string5		TITLE;
			string20	FNAME;
			string20	MNAME;
			string20	LNAME;
			string5		NAME_SUFFIX;
			string9   CLN_SSN_TAXID;
END;
		 
		 
layout_FacilCleanParsed :=
		RECORD
			layout_FacilDIDClean;
			string10	PRIM_RANGE;
			string2   PREDIR;
			string28	PRIM_NAME;
			string4   ADDR_SUFFIX;
			string2   POSTDIR;
			string10  UNIT_DESIG;
			string8		SEC_RANGE;
			string25  P_CITY_NAME;   	
			string25  V_CITY_NAME;
			string2		ST;
			string5		ZIP5;						
			string4   ZIP4;
			string4   CART;
			string1   CR_SORT_SZ;
			string4   LOT;
			string1   LOT_ORDER;
			string2   DPBC;
			string1   CHK_DIGIT;
	    string2   REC_TYPE;
	    string5   COUNTY;
	    string10  GEO_LAT;
			string11  GEO_LONG;
      string4   MSA;
			string7   GEO_BLK;
			string1   GEO_MATCH;
			string4   ERR_STAT;  			
	END;		
	


//AID process
	unsigned4 lAIDFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;

	layout_AIDClean_prep := RECORD
			string77	Append_Prep_Address_Situs;
			string54	Append_Prep_Address_Last_Situs;
			layout_FacilDIDClean;
	END;

	layout_AIDClean_prep tProjectAIDClean_prep(dsFacilityFile pInput) := TRANSFORM
		self.RawAID				:= 0;
		self.BDID					:= 0;
		self.BDID_SCORE		:= 0;
		self.TITLE				:= '';
		self.FNAME				:= '';
 		self.MNAME				:= '';
  	self.LNAME				:= '';
		self.NAME_SUFFIX	:= '';
		self.CLN_SSN_TAXID := IF(pInput.fednum_type = 'E', pInput.fednum,'');
															
//Prepping Address1
		BlankOutAddr1:= MAP(TRIM(pInput.ADDR_ADDR1) = TRIM(pInput.ORG_NAME) => '',
											 TRIM(pInput.ADDR_ADDR1) in bad_addr_list and pInput.ADDR_ADDR2 = '' => '',
											 LENGTH(TRIM(pInput.ADDR_ADDR1)) < 5 and pInput.ADDR_ADDR2 = '' => '',
											 pInput.ADDR_ADDR1 = '' and pInput.ADDR_ADDR2 <> '' => '',
																		Prof_License_Mari.mod_clean_name_addr.strippunctMisc(pInput.ADDR_ADDR1));

		fmtAddr1		:= MAP(StringLib.Stringfind(BlankOutAddr1[1..7],'DRAWER ',1) > 0 => StringLib.Stringfindreplace(BlankOutAddr1,'DRAWER ', 'PO BOX '),
												StringLib.Stringfind(BlankOutAddr1[1..4],'BOX ',1) > 0 => StringLib.Stringfindreplace(TRIM(BlankOutAddr1),'BOX ', 'PO BOX '),
												StringLib.Stringfind(TRIM(BlankOutAddr1[1]),'(',1) > 0 and REGEXFIND(begin_paren,BlankOutAddr1)=> REGEXFIND(begin_paren,pInput.ADDR_ADDR1,2),
												REGEXFIND(misc_pattern,BlankOutAddr1) => REGEXFIND(misc_pattern,BlankOutAddr1,1),
																					BlankOutAddr1);
												
		prepAddress1 := MAP(REGEXFIND('^([^0-9])*$',fmtAddr1) and pInput.ADDR_ST = 'PR' => fmtAddr1,
												REGEXFIND('^([^0-9])*$',fmtAddr1) and not REGEXFIND(address_accept,fmtAddr1)  => '',
												REGEXFIND('^([^0-9])*$',fmtAddr1) and REGEXFIND(address_accept,fmtAddr1) => fmtAddr1,
												REGEXFIND('^([^0-9])*$',fmtAddr1) and REGEXFIND('^([^A-Z]+)*$',trim(pInput.ADDR_ADDR2)) => '',
												REGEXFIND('^([^0-9])*$',fmtAddr1) and REGEXFIND('^([^0-9])*$',pInput.ADDR_ADDR2) => '',
																							fmtAddr1);
																		
		BlankOutAddr2 := 	MAP(LENGTH(TRIM(pInput.ADDR_ADDR1)) < 5 and pInput.ADDR_ADDR2 = '' => '',
													LENGTH(TRIM(pInput.ADDR_ADDR2)) < 5 and pInput.ADDR_ADDR1 = '' => '',
													pInput.ADDR_ADDR1 = '' and pInput.ADDR_ADDR2 <> '' => '',	
															pInput.ADDR_ADDR2);

//Prepping Address2													
		prepAddress2 := MAP(StringLib.Stringfind(BlankOutAddr2[1..7],'DRAWER ',1) > 0 => StringLib.Stringfindreplace(BlankOutAddr2,'DRAWER ', 'PO BOX '),
												REGEXFIND('^([^0-9])*$',pInput.ADDR_ADDR1) and REGEXFIND('^([^0-9])*$',BlankOutAddr2) => '',
												REGEXFIND('^([^0-9])*$',pInput.ADDR_ADDR1) and BlankOutAddr2[1..2] = 'RM' => '',
												REGEXFIND('^([^0-9])*$',pInput.ADDR_ADDR1) and REGEXFIND('^([^A-Z]+)*$',trim(BlankOutAddr2)) => '',
												REGEXFIND('^([^0-9])*$',pInput.ADDR_ADDR1) and BlankOutAddr2[1..4] in ['DEPT','BLDG','ROOM','UNIT'] => '',
												REGEXFIND(city_addr,pInput.ADDR_CITY) => pInput.ADDR_CITY,
																	BlankOutAddr2);	

// Use for filtering 		
		tmpCitySTZip := StringLib.StringCleanSpaces(pInput.Addr_City + pInput.Addr_St + pInput.Addr_Zip);
		prepCity     := MAP(TRIM(pInput.ADDR_ADDR1) = TRIM(pInput.ADDR_CITY) => '',
												TRIM(pInput.ADDR_CITY) = TRIM(pInput.ADDR_ZIP) => '',
												REGEXFIND(city_addr,pInput.ADDR_CITY) => '',
														pInput.ADDR_CITY);
														
		prepLine1		:= tools.AID_Helpers.fRawFixLine1(ut.fn_addr_clean_prep(TRIM(TRIM(prepAddress1, LEFT,RIGHT) + ' ' 
																														+ TRIM(prepAddress2,LEFT,RIGHT)),'first'));
		
		prepLine2 	:= tools.AID_Helpers.fRawFixLineLast(ut.fn_addr_clean_prep(TRIM(TRIM(prepCity,LEFT,RIGHT) 
																														+ IF(prepCity <> '',', ','') + TRIM(pInput.ADDR_ST,LEFT,RIGHT)) 
																																+ ' ' + TRIM(pInput.ADDR_ZIP,LEFT,RIGHT),'last'));
												
	self.Append_Prep_Address_Situs			:=	MAP(tmpCitySTZip = '' => '',
																						  prepAddress1 != '' and  pInput.addr_st = 'PR'  => prepLine1,
																							
																							StringLib.StringFilter(prepAddress1,'0123456789') != '' 
																								AND StringLib.StringFilterOut(prepAddress1, '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ ,.-/#\'&:`*@()') = ''
																								AND (StringLib.StringFilterOut(pInput.ADDR_ZIP, '0123456789-') = '' AND LENGTH(TRIM(pInput.ADDR_ZIP, RIGHT, LEFT)) >= 5
																								AND (pInput.Addr_St IN ut.Set_State_Abbrev OR pInput.Addr_St IN valid_military_states))
																										=> prepLine1,
																								
																								StringLib.StringFilter(prepAddress1,'0123456789') != '' 
																								AND StringLib.StringFilterOut(prepAddress1, '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ ,.-/#\'&:`*@()') = ''
																								AND (StringLib.StringFilterOut(pInput.ADDR_ZIP, '0123456789-') = '' AND LENGTH(TRIM(pInput.ADDR_ZIP, RIGHT, LEFT)) >= 5
																								AND pInput.Addr_St = '') => prepLine1,
																								
																								StringLib.StringFilter(prepAddress1,'0123456789') = '' 
																								AND StringLib.StringFilterOut(prepAddress1, '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ ,.-/#\'&:`*@') = ''
																								AND (Regexfind(address_accept,prepAddress1) OR REGEXFIND(valid_unit_desig,prepAddress2))
																								AND StringLib.StringFilterOut(pInput.ADDR_ZIP, '0123456789-') != '' 
																								AND (pInput.Addr_St IN ut.Set_State_Abbrev OR pInput.Addr_St IN valid_military_states) => prepLine1,
																								
																								prepAddress1 = '' AND StringLib.StringFilter(prepAddress2,'0123456789') != ''
																								AND StringLib.StringFilterOut(prepAddress2, '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ ,.-/#\'&:`*') = ''
																								AND (StringLib.StringFilterOut(pInput.ADDR_ZIP, '0123456789-') = '' AND LENGTH(TRIM(pInput.ADDR_ZIP, RIGHT, LEFT)) >= 5
																								AND (pInput.Addr_St IN ut.Set_State_Abbrev OR pInput.Addr_St IN valid_military_states))
																								=> prepLine1,
																											
																								
																								StringLib.StringFilter(prepAddress1,'0123456789') != '' 
																								AND StringLib.StringFilterOut(prepAddress1, '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ ,.-/#\'&:`*@') = ''
																								AND pInput.ADDR_ZIP = '' and tmpCitySTZIP != ''
																								AND (pInput.Addr_St IN ut.Set_State_Abbrev OR pInput.Addr_St IN valid_military_states)
																									 => prepLine1,
																								
																								REGEXFIND('^([^0-9])*$',pInput.ADDR_ADDR1) and REGEXFIND(address_accept,pInput.ADDR_ADDR1) => prepLine1,
																								
																													'');																												
																								
	
		
		self.Append_Prep_Address_Last_Situs	:=	MAP(tmpCitySTZip = '' => '',
																							
																								pInput.ADDR_ZIP = '' and tmpCitySTZIP != ''
																								AND (pInput.Addr_St IN ut.Set_State_Abbrev OR pInput.Addr_St IN valid_military_states) => prepLine2,
																								
																								pInput.ADDR_ZIP != '' and tmpCitySTZIP != ''
																								AND (pInput.Addr_St IN ut.Set_State_Abbrev OR pInput.Addr_St IN valid_military_states) => prepLine2,
																								
																								pInput.ADDR_ZIP != '' and pInput.Addr_ST = ''  
																								and REGEXFIND('^([^A-Z]+)*$', pinput.addr_zip)  => prepLine2,
																								
																																							'');
    self := pInput;
	END;

	rsAIDCleanName	:= PROJECT(dsFacilityFile, tProjectAIDClean_prep(LEFT));
	
	rsAID_NoAddr		:=	rsAIDCleanName(Append_Prep_Address_Situs = '' AND Append_Prep_Address_Last_Situs = '' );
																					
	rsAID_Addr			:=	rsAIDCleanName(Append_Prep_Address_Last_Situs != '' );
	

	
	AID.MacAppendFromRaw_2Line(rsAID_Addr,Append_Prep_Address_Situs, Append_Prep_Address_Last_Situs, RawAID,
																											rsCleanAID, lAIDFlags);	
	
	layout_FacilCleanParsed tProjectClean(rsCleanAID pInput) := TRANSFORM
	  SELF.prim_range           := pInput.aidwork_acecache.prim_range;
    SELF.predir               := pInput.aidwork_acecache.predir;
    SELF.prim_name            := pInput.aidwork_acecache.prim_name;
    SELF.addr_suffix          := pInput.aidwork_acecache.addr_suffix;
    SELF.postdir              := pInput.aidwork_acecache.postdir;
    SELF.unit_desig           := pInput.aidwork_acecache.unit_desig;
    SELF.sec_range            := pInput.aidwork_acecache.sec_range;
    SELF.p_city_name          := pInput.aidwork_acecache.p_city_name;
    SELF.v_city_name          := pInput.aidwork_acecache.v_city_name;
    SELF.st                		:= pInput.aidwork_acecache.st;
    SELF.zip5                 := pInput.aidwork_acecache.zip5;
    SELF.zip4                 := pInput.aidwork_acecache.zip4;
    SELF.cart                 := pInput.aidwork_acecache.cart;
    SELF.cr_sort_sz           := pInput.aidwork_acecache.cr_sort_sz;
    SELF.lot                  := pInput.aidwork_acecache.lot;
    SELF.lot_order            := pInput.aidwork_acecache.lot_order;
    SELF.dpbc                 := pInput.aidwork_acecache.dbpc;
    SELF.chk_digit            := pInput.aidwork_acecache.chk_digit;
    SELF.rec_type             := pInput.aidwork_acecache.rec_type;
    SELF.county               := pInput.aidwork_acecache.county;
    SELF.geo_lat              := pInput.aidwork_acecache.geo_lat;
    SELF.geo_long             := pInput.aidwork_acecache.geo_long;
    SELF.msa                  := pInput.aidwork_acecache.msa;
    SELF.geo_blk              := pInput.aidwork_acecache.geo_blk;
    SELF.geo_match            := pInput.aidwork_acecache.geo_match;
    SELF.err_stat             := pInput.aidwork_acecache.err_stat;
    SELF.rawaid               := pInput.aidwork_rawaid;
    SELF  										:= pInput;		
	END;


	rsCleanAIDGoodAddr		:= PROJECT(rsCleanAID, tProjectClean(LEFT));
	rsCleanAIDGoodNoAddr	:= PROJECT(rsAID_NoAddr, TRANSFORM(layout_FacilCleanParsed,self := LEFT,self := []));

	rsCleanAIDGood	:=	rsCleanAIDGoodAddr + rsCleanAIDGoodNoAddr; 
	


business_header.MAC_Source_Match(rsCleanAIDGood,
																			outrecs,
																			false,
																			BDID,
																			false,
																			MDR.sourceTools.src_CNLD_Facilities,
																			false,
																			foo,
																			ORG_NAME,
																			PRIM_RANGE,
																			PRIM_NAME,
																			SEC_RANGE,
																			ZIP5,
																			true,
																			ADDR_PHONE,
																			true, 
																			CLN_SSN_TAXID
																		 );


/* Identifying Corporation records 
// 'A' = Address, 'P' = Phone, 'F' = FEIN
// Record could contain up to 4 FEIN(s)
*/

bdid_matchset := ['A','P','F'];
Business_Header_SS.MAC_Match_Flex(outrecs, bdid_matchset,
                                      org_name, PRIM_RANGE, PRIM_NAME, ZIP5, 
																			SEC_RANGE, ST, ADDR_PHONE, CLN_SSN_TAXID, BDID, 
																			layout_FacilCleanParsed, true, 
																			BDID_SCORE,     //these should default to zero in definition
																			rsClnFacilityCorp);


rsAllFacilityRecOut := rsClnFacilityCorp;


export proc_AID_CleanAddr := output(rsAllFacilityRecOut,,'~thor_data400::base::facilities',overwrite);



