import lib_stringlib, watercraft, watercraft_preprocess, ut, STD;

// translates fl_mz.mp Ab intio graph into ECL

fIn_clean_raw := watercraft_preprocess.file_FL_clean_in;
process_date := (string8)STD.Date.Today();

Watercraft.Macro_Clean_Hull_ID(fIn_clean_raw, Watercraft.layout_FL,hull_clean_in)
watercraft.Macro_Is_hull_id_in_MIC(hull_clean_in, Watercraft.layout_FL,wDatasetwithflag)

Watercraft_preprocess.Layout_Watercraft_Search_Common search_mapping_format(wDatasetwithflag L, integer1 C)
:=
 transform
	IsValidRegDate						:=	STD.DATE.IsValidDate((integer)L.REG_DATE);
 	self.date_first_seen			:=	IF(IsValidRegDate AND L.REG_DATE < process_date,L.REG_DATE,'');
	self.date_last_seen				:=	IF(IsValidRegDate AND L.REG_DATE < process_date,L.REG_DATE,'');
	self.date_vendor_first_reported	:=	process_date;
	self.date_vendor_last_reported	:=	process_date;
	//New watercraft_key logic to be implemented at a later date
	// self.watercraft_key			:=	stringlib.StringFindReplace(IF(length(trim(L.HULL_ID,left,right)) = 12 and trim(L.year,left,right) >= '1972' and L.is_hull_id_in_MIC, trim(L.HULL_ID,left,right),
																													// L.STATEABREV+trim(L.REG_NUM,left,right)+trim(L.year,left,right)),' ','');                               
	self.watercraft_key			:=	if(length(trim(L.HULL_ID,left,right)) = 12 and trim(L.year,left,right) >= '1972' and L.is_hull_id_in_MIC, trim(L.HULL_ID,left,right),
																 trim(L.HULL_ID,left,right) + trim(L.MAKE,left,right) + trim(L.YEAR,left,right));
	self.sequence_key				:=	trim(L.REG_DATE,left,right);
	self.state_origin				:=	'FL';
	self.source_code				:=	'AW';
	self.orig_name					:=	choose(C,L.NAME, L.OWN2_CUSTOMER_NAME, L.REG1_NAME, L.REG2_NAME);
	tempName1Type						:= IF(TRIM(L.NAME,left,right) <> '', 'O1','');
	tempName2Type						:= IF(TRIM(L.OWN2_CUSTOMER_NAME,left,right) <> '', 'O2','');
	tempReg1Type						:= IF(TRIM(L.REG1_NAME,left,right) <> '', 'R1','');
	tempReg2Type						:= IF(TRIM(L.REG2_NAME,left,right) <> '', 'R2','');
	self.orig_name_type_code				:=	choose(C, tempName1Type, tempName2Type, tempReg1Type, tempReg2Type);
	self.orig_name_type_description	:=	map((self.orig_name_type_code[1]='O')=>'OWNER',
																					(self.orig_name_type_code[1]='R')=>'REGISTRANT',
																					'');

	self.orig_address_1	:=	choose(C, L.ADDRESS_1, L.OWN2_ADDRESS, L.REG1_ADDRESS, L.REG2_ADDRESS);
	self.orig_address_2	:=	choose(C, L.OWN1_APT_NUMBER, L.OWN2_APT_NUMBER, L.REG1_APT_NO, L.REG2_APT_NO);
	self.orig_city			:=	choose(C, L.CITY, L.OWN2_CITY, L.REG1_CITY, L.REG2_CITY);
	self.orig_state			:=	choose(C, L.STATE, L.OWN2_STATE, L.REG1_STATE, L.REG2_STATE);
	self.orig_zip				:=	choose(C, L.ZIP, L.OWN2_ZIP, L.REG1_ZIP, L.REG2_ZIP);
	self.orig_fips			:=	choose(C, L.FIPS, '');
	self.dob						:=	choose(C, L.OWN1_DOB, L.OWN2_DOB, L.REG1_DOB, L.REG2_DOB);
	self.orig_ssn				:=	choose(C,if((L.OWN1_CUST_TYPE='I' and L.OWN1_FEID_SSN<>'000000000'),L.OWN1_FEID_SSN,''),
																		if((L.OWN2_CUST_TYPE='I' and L.OWN2_FEID_SSN<>'000000000'),L.OWN2_FEID_SSN,''),
																		if((L.REGSTRANT1_TYPE='I' and L.REG1_FEID_SSN<>'000000000'),L.REG1_FEID_SSN,''),
																		if((L.REGIST2_CUST_TYPE='I' and L.REG2_FEID_SSN<>'000000000'),L.REG2_FEID_SSN,''));
	self.orig_fein			:=	choose(C,if((L.OWN1_CUST_TYPE='B' and L.OWN1_FEID_SSN<>'000000000'),L.OWN1_FEID_SSN,''),
																		if((L.OWN2_CUST_TYPE='B' and L.OWN2_FEID_SSN<>'000000000'),L.OWN2_FEID_SSN,''),
																		if((L.REGSTRANT1_TYPE='B' and L.REG1_FEID_SSN<>'000000000'),L.REG1_FEID_SSN,''),
																		if((L.REGIST2_CUST_TYPE='B' and L.REG2_FEID_SSN<>'000000000'),L.REG2_FEID_SSN,''));
	// CUST_TYPE denotes business(B)
	// or individual(I) for Florida.  Because DOB is populated differently for each entity,
	// a way to exclude type "B" is needed for header build.  bug#33002
	self.gender						:=	choose(C,if(L.OWN1_CUST_TYPE='B','B',L.OWN1_SEX),
																			if(L.OWN2_CUST_TYPE='B','B',L.OWN2_SEX),
																			if(L.REGSTRANT1_TYPE='B','B',L.REG1_SEX),
																			if(L.REGIST2_CUST_TYPE='B','B',L.REG2_SEX));
																			
	self.name_format	:= 'L';
	tempOwn1Addr	:= StringLib.StringCleanSpaces(L.ADDRESS_1+' '+L.OWN1_APT_NUMBER);
	tempOwn2Addr	:= StringLib.StringCleanSpaces(L.OWN2_ADDRESS+' '+L.OWN2_APT_NUMBER);
	tempReg1Addr	:= StringLib.StringCleanSpaces(L.REG1_ADDRESS+' '+L.REG1_APT_NO);
	tempReg2Addr	:= StringLib.StringCleanSpaces(L.REG2_ADDRESS+' '+L.REG2_APT_NO);
	self.prep_address_situs	:= choose(C,tempOwn1Addr, tempOwn2Addr, tempReg1Addr, tempReg2Addr);
	
	tempOwn1LastSitus				:= StringLib.StringCleanSpaces(trim(L.CITY,left,right)
																													+	IF(trim(L.CITY) <> '',', ','')
																													+ trim(L.STATE,left,right)
																													+	' ' + trim(L.ZIP,left,right)[1..5]
																													+trim(L.ZIP,left,right)[7..10]);
	tempOwn2LastSitus				:= StringLib.StringCleanSpaces(trim(L.OWN2_CITY,left,right)
																													+	IF(trim(L.OWN2_CITY) <> '',', ','')
																													+ trim(L.OWN2_STATE,left,right)
																													+	' ' + trim(L.OWN2_ZIP,left,right)[1..5]
																													+trim(L.OWN2_ZIP,left,right)[7..10]);
	tempReg1LastSitus				:= StringLib.StringCleanSpaces(trim(L.REG1_CITY,left,right)
																													+	IF(trim(L.REG1_CITY) <> '',', ','')
																													+ trim(L.REG1_STATE,left,right)
																													+	' ' + trim(L.REG1_ZIP,left,right)[1..5]
																													+trim(L.REG1_ZIP,left,right)[7..10]);
	tempReg2LastSitus				:= StringLib.StringCleanSpaces(trim(L.REG2_CITY,left,right)
																													+	IF(trim(L.REG2_CITY) <> '',', ','')
																													+ trim(L.REG2_STATE,left,right)
																													+	' ' + trim(L.REG2_ZIP,left,right)[1..5]
																													+trim(L.REG2_ZIP,left,right)[7..10]);
	self.prep_address_last_situs	:= choose(C,tempOwn1LastSitus, tempOwn2LastSitus, tempReg1LastSitus, tempReg2LastSitus);
	self := L;
	self := [];
  end ;

Mapping_FL_as_Search_norm			:= normalize(wDatasetwithflag,4,search_mapping_format(left,counter));

//Checking if name is a business and blanking DOB and setting name_format to 'U' - Does not catch all, but catches most
Watercraft_preprocess.Layout_Watercraft_Search_Common RmvDOB(Mapping_FL_as_Search_norm L) := TRANSFORM
	IsValidDOB				:= STD.DATE.IsValidDate((integer)L.DOB);
	self.DOB					:= IF(watercraft_preprocess.is_company(L.orig_name)=1 and L.GENDER = 'B','',
												IF(IsValidDOB,L.DOB,''));
	self.name_format	:= IF(watercraft_preprocess.is_company(L.orig_name)=1 and L.GENDER = 'B','U','L');
	self			:= L;
END;

d_RmvDOB	:= project(Mapping_FL_as_Search_norm, RmvDOB(left));

EXPORT Map_FL_raw_to_Search := d_RmvDOB(orig_name <> '');