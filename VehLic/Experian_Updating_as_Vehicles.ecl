import Lib_StringLib, ut, header;

string1		lNameType_Owner		:=	'1';
string1		lNameType_Lessor	:=	'2';
string1		lNameType_Registrant:=	'4';
string1		lNameType_Lessee	:=	'5';
string1		lNameType_Lienholder:=	'7';

string1		lOwnerType_Person	:=	'1';
string1		lOwnerType_Business	:=	'2';

sValidExperianUpdatingStates	:=	['AK','CO','DC','IL','LA','MA','MI','NY','TN','UT','ME','WI'];
sValidExperianUpdatingExceptions:=	['ME','WI'];
/*
unsigned3 fEarliestDateSeenByState(string pState)
 :=	case(pState,
		 'AK'	=> 198601,
		 'CO'	=> 199501,
		 'DC'	=> 199601,
		 'IL'	=> 199201,
		 'LA'	=> 199604,
		 'MA'	=> 198801,
		 'MI'	=> 199501,
		 'NY'	=> 199601,
		 'TN'	=> 199601,
		 'UT'	=> 199604,
		 'ME'   => 197511,
		 0
		);

unsigned3 lEarliestProcessDate	:= 200502;
*/
rExperianFullWithKey
 :=
  record
	string120	UniqueKey := '';
	VehLic.Layout_Experian_Updating_Full;
  end
 ;

rExperianFullWithKey	tCreateUniqueKey(VehLic.Layout_Experian_Updating_Full pInput)
 :=
  transform
//	self.UniqueKey	:= 	pInput.MSTR_SRC_STATE + pInput.VIN + pInput.PLATE_NBR + pInput.ORG_REG_DT + pInput.REG_RENEW_DT + pInput.TITLE_NBR + pInput.ORG_TITLE_DT + pInput.TITLE_TRANS_DT;
	self.UniqueKey	:= 	pInput.MSTR_SRC_STATE + pInput.VIN;
	self			:=	pInput;
  end
 ;

//dExperianAll			:=	VehLic.File_Experian_Updating_Full(append_STATE_ORIGIN in sValidExperianUpdatingStates);
//dExperianAll			:=	VehLic.File_Experian_Updating_Full((first_nm<>'' or middle_nm<>'' or last_nm<>'') and append_STATE_ORIGIN in sValidExperianUpdatingStates);
dExperianAll			:=	vehlic.File_Experian_Unique(first_nm<>'' or middle_nm<>'' or last_nm<>'');
dExperianFull			:=	dExperianAll(append_STATE_ORIGIN not in sValidExperianUpdatingExceptions);
dExperianME             :=  dExperianAll(append_STATE_ORIGIN='ME' and ((ut.max2((integer)ORG_REG_DT,ut.max2((integer)TITLE_TRANS_DT,(integer)ORG_TITLE_DT)) > 20030421) OR (ut.max2(ut.max2((integer)TITLE_TRANS_DT,(integer)ORG_TITLE_DT),(integer)ORG_TITLE_DT) < 19970430)));
dExperianWI             :=  dExperianAll(append_STATE_ORIGIN='WI' and ((integer)REG_RENEW_DT>20041203 or (integer)TITLE_TRANS_DT>20041203));

dExperianAllReady		:=	dExperianFull
						+	dExperianME
						+	dExperianWI
						;

//******************************************************************
// get table for lookup join to set date_seen values
rExperianMinProcessDate
 :=
  record
	dExperianAllReady.append_STATE_ORIGIN;
	typeof(dExperianAllReady.append_PROCESS_DATE)	EarliestProcessDate	:=	min(group,if((unsigned8)dExperianAllReady.append_PROCESS_DATE<>0,
																						 dExperianAllReady.append_PROCESS_DATE,
																						 '99999999'
																						)
																			   );
  end
 ;

dExperianMinProcessDate	:=	table(dExperianAllReady,rExperianMinProcessDate,dExperianAllReady.append_STATE_ORIGIN,few);
//******************************************************************

dExperianFullWithKey	:=	project(dExperianAllReady,tCreateUniqueKey(left));
dExperianFullDist		:=	distribute(dExperianFullWithKey,hash(UniqueKey));

rVehicleWithUniqueKey
 :=
  record
	typeof(dExperianFullDist.UniqueKey)	UniqueKey;
	VehLic.Layout_Vehicles;
  end
 ;

string8	fFixDate(string8 pDateIn)
 :=	if((integer8)pDateIn=0,
	   '',
	   Lib_StringLib.StringLib.StringFindReplace(pDateIn,' ','0')
	  );

string	fFixOrigName(string1 pOwnerType, string pFName, string pMName, string pLName, string pSuffix, string pSuffix2)
 :=	if(pOwnerType = '1',
	   trim(pFName) + trim(' ' + pMName) + trim(' ' + pLName) + trim(' ' + pSuffix) + trim(' ' + pSuffix2),
	   pFName + pMName + pLName + pSuffix + pSuffix2
	  );

string10	fFixZip(string5 pZip5, string4 pZip4)
 :=	pZip5 + if((integer4)pZip4 <> 0,
			   '-' + pZip4,
			   ''
			  );

string	fFixUnknownForSort(string pString)
 :=	lib_stringlib.StringLib.stringfindreplace(pString,'UNKNOWN','ZZKNOWN');

string	fRemoveUnknown(string pString)
 :=	lib_stringlib.StringLib.stringfindreplace(pString,'ZZKNOWN','       ');

unsigned3 fBestSeenDate(string2 pState, string8 pRegDate, string8 pTitleDate, string8 pProcessDate, string8 pEarliestProcessDate)
 :=
  function
	unsigned3	lRegDate			:=	(unsigned8)(pRegDate[1..6]);
	unsigned3	lTitleDate			:=	(unsigned8)(pTitleDate[1..6]);
	unsigned3	lProcessDate		:=	(unsigned8)(pProcessDate[1..6]);
	unsigned3	lEarliestProcessDate:=	(unsigned8)(pEarliestProcessDate[1..6]);
	unsigned3	lReturnValue		:=	if(lProcessDate > lEarliestProcessDate + 2,
										   lProcessDate,
										   if(lRegDate <= lProcessDate and lRegDate <> 0,
											  lRegDate,
											  if(lTitleDate <= lProcessDate,
												 lTitleDate,
												 0
												)
											 )
										  );
	return lReturnValue;
  end
 ;

mGenericAsVehicle
 :=
  macro
	self.UniqueKey					:=	pInput.UniqueKey;
	self.orig_state					:=	pInput.append_STATE_ORIGIN;
	self.source_code				:=	'AE';
	self.dt_first_seen				:=	fBestSeenDate(self.orig_state,fFixDate(pInput.REG_RENEW_DT),fFixDate(if(pInput.TITLE_TRANS_DT<>'',pInput.TITLE_TRANS_DT,pInput.ORG_TITLE_DT)),pInput.append_PROCESS_DATE,pMinDateTable.EarliestProcessDate);
    self.dt_last_seen				:=	fBestSeenDate(self.orig_state,fFixDate(pInput.REG_RENEW_DT),fFixDate(if(pInput.TITLE_TRANS_DT<>'',pInput.TITLE_TRANS_DT,pInput.ORG_TITLE_DT)),pInput.append_PROCESS_DATE,pMinDateTable.EarliestProcessDate);
	self.dt_vendor_first_reported	:=	(unsigned8)(pInput.append_PROCESS_DATE[1..6]);
	self.dt_vendor_last_reported	:=	(unsigned8)(pInput.append_PROCESS_DATE[1..6]);
	self.VEHICLE_NUMBERxBG1			:=	if(length(trim(pInput.VIN)) < 11
										or length(Lib_StringLib.stringlib.stringfilter(pInput.VIN,'0')) >= 5
										or pInput.VIN[1..4] = 'HOME'
										or pInput.VIN[1..4] = 'HMDE',
										   trim(pInput.VIN) + trim(pInput.TITLE_NBR) + trim(pInput.REG_RENEW_DT) + trim(pInput.PLATE_NBR),
										   pInput.VIN
										  );
	self.ORIG_VIN					:=	pInput.VIN;
	self.YEAR_MAKE					:=	if((integer2)pInput.MODEL_YR = 0,
										   '',
										   if(pInput.MODEL_YR > '2020',
											  '19' + pInput.MODEL_YR[3..4],
											  Lib_StringLib.StringLib.stringfindreplace(pInput.MODEL_YR,' ','0')
											 )
										  );
	self.MAKE_CODE					:=	pInput.MAKE;						//THOR cleanup, CODES_V3 lookup
	self.MODEL						:=	pInput.SERIES;
	self.MAJOR_COLOR_CODE			:=	pInput.PRIME_COLOR;
	self.MINOR_COLOR_CODE			:=	pInput.SECOND_COLOR;
	self.BODY_CODE					:=	pInput.BODY_STYLE;
	self.NET_WEIGHT					:=	if((integer2)pInput.WEIGHT = 0,
										   '',
										   trim((string)(integer4)pInput.WEIGHT,all)
										  );
	self.NUMBER_OF_AXLES			:=	if((integer2)pInput.AXLE_CNT = 0,
										   '',
										   trim((string)(integer4)pInput.AXLE_CNT,all)
										  );
	self.LICENSE_PLATE_NUMBERxBG4	:=	pInput.PLATE_NBR;
	self.TRUE_LICENSE_PLSTE_NUMBER	:=	pInput.PLATE_NBR;
	self.REGISTRATION_EXPIRATION_DATE	:= fFixDate(pInput.REG_EXP_DT);
	self.LICENSE_PLATE_CODE			:=	pInput.PLATE_TYP_CD;
	self.DECAL_NUMBER				:=	pInput.REG_DECAL_NBR;
	self.FIRST_REGISTRATION_DATE	:=	fFixDate(pInput.ORG_REG_DT);
	self.REGISTRATION_EFFECTIVE_DATE	:=	fFixDate(pInput.REG_RENEW_DT);
	self.TITLE_NUMBERxBG9			:=	pInput.TITLE_NBR;
	self.TITLE_ISSUE_DATE			:=	fFixDate(if(pInput.TITLE_TRANS_DT <> '',pInput.TITLE_TRANS_DT,pInput.ORG_TITLE_DT));
	self.PREVIOUS_TITLE_ISSUE_DATE	:=	fFixDate(if(pInput.ORG_TITLE_DT <> '' and pInput.ORG_TITLE_DT <> pInput.TITLE_TRANS_DT,pInput.ORG_TITLE_DT,''));
  endmacro
 ;


rVehicleWithUniqueKey	tExperianOwnerAsVehicleWithKey(dExperianFullDist pInput, dExperianMinProcessDate pMinDateTable)
 :=
  transform
	mGenericAsVehicle()
	self.OWNER_1_CUSTOMER_TYPExBG3		:=	if(pInput.OWNER_TYP_CD = lOwnerType_Person,'I','B');
	self.OWN_1_CUSTOMER_NAME			:=	fFixUnknownForSort(fFixOrigName(pInput.OWNER_TYP_CD,pInput.FIRST_NM,pInput.MIDDLE_NM,pInput.LAST_NM,pInput.NAME_SUFFIX,pInput.PROF_SUFFIX));
	self.OWN_1_FEID_SSN 				:=	pInput.IND_SSN;
	self.OWN_1_DOB						:=	if(pInput.OWNER_TYP_CD = '1',fFixDate(pInput.IND_DOB),'');
	boolean	lMCityBlank					:=	pInput.M_CITY = '';
	self.OWN_1_STREET_ADDRESS			:=	if(lMCityBlank,
											   trim(pInput.PHYS_RANGE) + trim(' ' + pInput.P_PRE_DIR) + trim(' ' + pInput.P_STREET) + trim(' ' + pInput.P_SUFFIX) + trim(' ' + pInput.P_POST_DIR) + trim(' ' + if(pInput.P_POB<>'','PO BOX ' + pInput.P_POB,'')) + trim(' ' + if(pInput.P_RR_NBR<>'','RR ' + pInput.P_RR_NBR,'')) + trim(' ' + if(pInput.P_RR_BOX<>'','BOX ' + pInput.P_RR_BOX,'')) + trim(' ' + pInput.P_SCNDRY_RNG) + trim(' ' + pInput.P_SCNDRY_DES),
											   trim(pInput.MAIL_RANGE) + trim(' ' + pInput.M_PRE_DIR) + trim(' ' + pInput.M_STREET) + trim(' ' + pInput.M_SUFFIX) + trim(' ' + pInput.M_POST_DIR) + trim(' ' + if(pInput.M_POB<>'','PO BOX ' + pInput.M_POB,'')) + trim(' ' + if(pInput.M_RR_NBR<>'','RR ' + pInput.M_RR_NBR,'')) + trim(' ' + if(pInput.M_RR_BOX<>'','BOX ' + pInput.M_RR_BOX,'')) + trim(' ' + pInput.M_SCNDRY_RNG) + trim(' ' + pInput.M_SCNDRY_DES)
											  );
	self.OWN_1_CITY						:=	if(lMCityBlank,
											   pInput.P_CITY,
											   pInput.M_CITY
											  );
	self.OWN_1_STATE					:=	if(lMCityBlank,
											   pInput.P_State,
											   pInput.M_State
											  );
	self.OWN_1_ZIP5_ZIP4_FOREIGN_POSTAL	:=	if(lMCityBlank,
											   fFixZip(pInput.P_Zip5,pInput.P_Zip4),
											   fFixZip(pInput.M_Zip5,pInput.P_Zip5)
											  );
	self.own_1_title 					:=	fFixUnknownForSort(pInput.P_NAME[01..05]);
	self.own_1_fname 					:=	fFixUnknownForSort(pInput.P_NAME[06..25]);
	self.own_1_mname 					:=	fFixUnknownForSort(pInput.P_NAME[26..45]);
	self.own_1_lname 					:=	fFixUnknownForSort(pInput.P_NAME[46..65]);
	self.own_1_name_suffix 				:=	fFixUnknownForSort(pInput.P_NAME[66..70]);
	self.own_1_company_name 			:=	fFixUnknownForSort(if(self.OWNER_1_CUSTOMER_TYPExBG3 = 'B',self.OWN_1_CUSTOMER_NAME,''));
	self.own_1_prim_range 				:=	if(lMCityBlank,pInput.P_CLEAN_ADDRESS[001..010],pInput.M_CLEAN_ADDRESS[001..010]);
	self.own_1_predir 					:=	if(lMCityBlank,pInput.P_CLEAN_ADDRESS[011..012],pInput.M_CLEAN_ADDRESS[011..012]);
	self.own_1_prim_name 				:=	if(lMCityBlank,pInput.P_CLEAN_ADDRESS[013..040],pInput.M_CLEAN_ADDRESS[013..040]);
	self.own_1_suffix 					:=	if(lMCityBlank,pInput.P_CLEAN_ADDRESS[041..044],pInput.M_CLEAN_ADDRESS[041..044]);
	self.own_1_postdir 					:=	if(lMCityBlank,pInput.P_CLEAN_ADDRESS[045..046],pInput.M_CLEAN_ADDRESS[045..046]);
	self.own_1_unit_desig 				:=	if(lMCityBlank,pInput.P_CLEAN_ADDRESS[047..056],pInput.M_CLEAN_ADDRESS[047..056]);
	self.own_1_sec_range 				:=	if(lMCityBlank,pInput.P_CLEAN_ADDRESS[057..064],pInput.M_CLEAN_ADDRESS[057..064]);
	self.own_1_p_city_name 				:=	if(lMCityBlank,pInput.P_CLEAN_ADDRESS[065..089],pInput.M_CLEAN_ADDRESS[065..089]);
	self.own_1_v_city_name 				:=	if(lMCityBlank,pInput.P_CLEAN_ADDRESS[090..114],pInput.M_CLEAN_ADDRESS[090..114]);
	self.own_1_state_2 					:=	if(lMCityBlank,pInput.P_CLEAN_ADDRESS[115..116],pInput.M_CLEAN_ADDRESS[115..116]);
	self.own_1_zip5 					:=	if(lMCityBlank,pInput.P_CLEAN_ADDRESS[117..121],pInput.M_CLEAN_ADDRESS[117..121]);
	self.own_1_zip4 					:=	if(lMCityBlank,pInput.P_CLEAN_ADDRESS[122..125],pInput.M_CLEAN_ADDRESS[122..125]);
	self.own_1_county					:=	if(lMCityBlank,pInput.P_CLEAN_ADDRESS[143..145],pInput.M_CLEAN_ADDRESS[143..145]);
  end                                                                
 ;

rVehicleWithUniqueKey	tExperianRegistrantAsVehicleWithKey(dExperianFullDist pInput, dExperianMinProcessDate pMinDateTable)
 :=
  transform
	mGenericAsVehicle()
	self.REGISTRANT_1_CUSTOMER_TYPExBG5	:=	if(pInput.OWNER_TYP_CD = lOwnerType_Person,'I','B');
	self.REG_1_CUSTOMER_NAME			:=	fFixUnknownForSort(fFixOrigName(pInput.OWNER_TYP_CD,pInput.FIRST_NM,pInput.MIDDLE_NM,pInput.LAST_NM,pInput.NAME_SUFFIX,pInput.PROF_SUFFIX));
    self.REG_1_FEID_SSN 				:=	pInput.IND_SSN;
    self.REG_1_DOB						:=	if(pInput.OWNER_TYP_CD = '1',fFixDate(pInput.IND_DOB),'');
	boolean	lMCityBlank					:=	pInput.M_CITY = '';
    self.REG_1_STREET_ADDRESS			:=	if(lMCityBlank,
											   trim(pInput.PHYS_RANGE) + trim(' ' + pInput.P_PRE_DIR) + trim(' ' + pInput.P_STREET) + trim(' ' + pInput.P_SUFFIX) + trim(' ' + pInput.P_POST_DIR) + trim(' ' + if(pInput.P_POB<>'','PO BOX ' + pInput.P_POB,'')) + trim(' ' + if(pInput.P_RR_NBR<>'','RR ' + pInput.P_RR_NBR,'')) + trim(' ' + if(pInput.P_RR_BOX<>'','BOX ' + pInput.P_RR_BOX,'')) + trim(' ' + pInput.P_SCNDRY_RNG) + trim(' ' + pInput.P_SCNDRY_DES),
											   trim(pInput.MAIL_RANGE) + trim(' ' + pInput.M_PRE_DIR) + trim(' ' + pInput.M_STREET) + trim(' ' + pInput.M_SUFFIX) + trim(' ' + pInput.M_POST_DIR) + trim(' ' + if(pInput.M_POB<>'','PO BOX ' + pInput.M_POB,'')) + trim(' ' + if(pInput.M_RR_NBR<>'','RR ' + pInput.M_RR_NBR,'')) + trim(' ' + if(pInput.M_RR_BOX<>'','BOX ' + pInput.M_RR_BOX,'')) + trim(' ' + pInput.M_SCNDRY_RNG) + trim(' ' + pInput.M_SCNDRY_DES)
											  );
    self.REG_1_CITY						:=	if(lMCityBlank,
											   pInput.P_CITY,
											   pInput.M_CITY
											  );
    self.REG_1_STATE					:=	if(lMCityBlank,
											   pInput.P_State,
											   pInput.M_State
											  );
    self.REG_1_ZIP5_ZIP4_FOREIGN_POSTAL	:=	if(lMCityBlank,
											   fFixZip(pInput.P_Zip5,pInput.P_Zip4),
											   fFixZip(pInput.M_Zip5,pInput.P_Zip5)
											  );
	self.reg_1_title 					:=	fFixUnknownForSort(pInput.P_NAME[01..05]);
	self.reg_1_fname 					:=	fFixUnknownForSort(pInput.P_NAME[06..25]);
	self.reg_1_mname 					:=	fFixUnknownForSort(pInput.P_NAME[26..45]);
	self.reg_1_lname 					:=	fFixUnknownForSort(pInput.P_NAME[46..65]);
	self.reg_1_name_suffix 				:=	fFixUnknownForSort(pInput.P_NAME[66..70]);
	self.reg_1_company_name 			:=	fFixUnknownForSort(if(self.REGISTRANT_1_CUSTOMER_TYPExBG5 = 'B',self.REG_1_CUSTOMER_NAME,''));
	self.reg_1_prim_range 				:=	if(lMCityBlank,pInput.P_CLEAN_ADDRESS[001..010],pInput.M_CLEAN_ADDRESS[001..010]);
	self.reg_1_predir 					:=	if(lMCityBlank,pInput.P_CLEAN_ADDRESS[011..012],pInput.M_CLEAN_ADDRESS[011..012]);
	self.reg_1_prim_name 				:=	if(lMCityBlank,pInput.P_CLEAN_ADDRESS[013..040],pInput.M_CLEAN_ADDRESS[013..040]);
	self.reg_1_suffix 					:=	if(lMCityBlank,pInput.P_CLEAN_ADDRESS[041..044],pInput.M_CLEAN_ADDRESS[041..044]);
	self.reg_1_postdir 					:=	if(lMCityBlank,pInput.P_CLEAN_ADDRESS[045..046],pInput.M_CLEAN_ADDRESS[045..046]);
	self.reg_1_unit_desig 				:=	if(lMCityBlank,pInput.P_CLEAN_ADDRESS[047..056],pInput.M_CLEAN_ADDRESS[047..056]);
	self.reg_1_sec_range 				:=	if(lMCityBlank,pInput.P_CLEAN_ADDRESS[057..064],pInput.M_CLEAN_ADDRESS[057..064]);
	self.reg_1_p_city_name 				:=	if(lMCityBlank,pInput.P_CLEAN_ADDRESS[065..089],pInput.M_CLEAN_ADDRESS[065..089]);
	self.reg_1_v_city_name 				:=	if(lMCityBlank,pInput.P_CLEAN_ADDRESS[090..114],pInput.M_CLEAN_ADDRESS[090..114]);
	self.reg_1_state_2 					:=	if(lMCityBlank,pInput.P_CLEAN_ADDRESS[115..116],pInput.M_CLEAN_ADDRESS[115..116]);
	self.reg_1_zip5 					:=	if(lMCityBlank,pInput.P_CLEAN_ADDRESS[117..121],pInput.M_CLEAN_ADDRESS[117..121]);
	self.reg_1_zip4 					:=	if(lMCityBlank,pInput.P_CLEAN_ADDRESS[122..125],pInput.M_CLEAN_ADDRESS[122..125]);
	self.reg_1_county					:=	if(lMCityBlank,pInput.P_CLEAN_ADDRESS[143..145],pInput.M_CLEAN_ADDRESS[143..145]);
  end                                                                
 ;

rVehicleWithUniqueKey	tExperianLienholderAsVehicleWithKey(dExperianFullDist pInput, dExperianMinProcessDate pMinDateTable)
 :=
  transform
	mGenericAsVehicle()
	boolean	lMCityBlank					:=	pInput.M_CITY = '';
	self.LH_1_LIEN_DATE					:=	'';
	self.LH_1_CUSTOMER_NAME				:=	fFixUnknownForSort(fFixOrigName(pInput.OWNER_TYP_CD,pInput.FIRST_NM,pInput.MIDDLE_NM,pInput.LAST_NM,pInput.NAME_SUFFIX,pInput.PROF_SUFFIX));
    self.LH_1_STREET_ADDRESS			:=	if(lMCityBlank,
											   trim(pInput.PHYS_RANGE) + trim(' ' + pInput.P_PRE_DIR) + trim(' ' + pInput.P_STREET) + trim(' ' + pInput.P_SUFFIX) + trim(' ' + pInput.P_POST_DIR) + trim(' ' + if(pInput.P_POB<>'','PO BOX ' + pInput.P_POB,'')) + trim(' ' + if(pInput.P_RR_NBR<>'','RR ' + pInput.P_RR_NBR,'')) + trim(' ' + if(pInput.P_RR_BOX<>'','BOX ' + pInput.P_RR_BOX,'')) + trim(' ' + pInput.P_SCNDRY_RNG) + trim(' ' + pInput.P_SCNDRY_DES),
											   trim(pInput.MAIL_RANGE) + trim(' ' + pInput.M_PRE_DIR) + trim(' ' + pInput.M_STREET) + trim(' ' + pInput.M_SUFFIX) + trim(' ' + pInput.M_POST_DIR) + trim(' ' + if(pInput.M_POB<>'','PO BOX ' + pInput.M_POB,'')) + trim(' ' + if(pInput.M_RR_NBR<>'','RR ' + pInput.M_RR_NBR,'')) + trim(' ' + if(pInput.M_RR_BOX<>'','BOX ' + pInput.M_RR_BOX,'')) + trim(' ' + pInput.M_SCNDRY_RNG) + trim(' ' + pInput.M_SCNDRY_DES)
											  );
    self.LH_1_CITY						:=	if(lMCityBlank,pInput.P_CITY,pInput.M_CITY);
    self.LH_1_STATE						:=	if(lMCityBlank,pInput.P_State,pInput.M_State);
    self.LH_1_ZIP5_ZIP4_FOREIGN_POSTAL	:=	if(lMCityBlank,fFixZip(pInput.P_Zip5,pInput.P_Zip4),fFixZip(pInput.M_Zip5,pInput.P_Zip5));
  end
 ;

dOwnersOnly			:=	join(dExperianFullDist(NAME_TYP_CD in [lNameType_Owner,lNameType_Lessor]),dExperianMinProcessDate,
							 left.append_STATE_ORIGIN = right.append_STATE_ORIGIN,
							 tExperianOwnerAsVehicleWithKey(left,right),
							 lookup
							);

dOwnersDist			:=	distribute(dOwnersOnly,hash(TITLE_NUMBERxBG9,TITLE_ISSUE_DATE,orig_vin,own_1_lname,own_1_fname,own_1_mname,own_1_zip5,own_1_prim_range,own_1_prim_name));
dOwnersSort			:=	sort(dOwnersDist,TITLE_NUMBERxBG9,TITLE_ISSUE_DATE,orig_vin,own_1_lname,own_1_fname,own_1_mname,own_1_company_name,own_1_Zip5,own_1_prim_range,own_1_prim_name,dt_first_seen,local);
dOwnersDedup		:=	dedup(dOwnersSort,TITLE_NUMBERxBG9,TITLE_ISSUE_DATE,orig_vin,own_1_lname,own_1_fname,own_1_mname,own_1_company_name,own_1_Zip5,own_1_prim_range,own_1_prim_name,local);

dRegistrantsOnly	:=	join(dExperianFullDist(NAME_TYP_CD in [lNameType_Registrant,lNameType_Lessee]),dExperianMinProcessDate,
							 left.append_STATE_ORIGIN = right.append_STATE_ORIGIN,
							 tExperianRegistrantAsVehicleWithKey(left,right),
							 lookup
							);
dRegistrantsDist	:=	distribute(dRegistrantsOnly,hash(LICENSE_PLATE_NUMBERxBG4,REGISTRATION_EFFECTIVE_DATE,orig_vin,reg_1_lname,reg_1_fname,reg_1_mname,reg_1_company_name,reg_1_Zip5,reg_1_prim_range,reg_1_prim_name));
dRegistrantsSort	:=	sort(dRegistrantsDist,LICENSE_PLATE_NUMBERxBG4,REGISTRATION_EFFECTIVE_DATE,orig_vin,reg_1_lname,reg_1_fname,reg_1_mname,reg_1_company_name,reg_1_Zip5,reg_1_prim_range,reg_1_prim_name,dt_first_seen,local);
dRegistrantsDedup	:=	dedup(dRegistrantsSort,LICENSE_PLATE_NUMBERxBG4,REGISTRATION_EFFECTIVE_DATE,orig_vin,reg_1_lname,reg_1_fname,reg_1_mname,reg_1_company_name,reg_1_Zip5,reg_1_prim_range,reg_1_prim_name,local);

dLienholdersOnly	:=	join(dExperianFullDist(NAME_TYP_CD in [lNameType_Lienholder]),dExperianMinProcessDate,
							 left.append_STATE_ORIGIN = right.append_STATE_ORIGIN,
							 tExperianLienholderAsVehicleWithKey(left,right),
							 lookup
							);

dCombined			:=	dOwnersDedup + dRegistrantsDedup + dLienholdersOnly;

rVehicleWithUniqueKey	tRollupSameVehicle(dCombined pLeft, dCombined pRight)
 :=
  transform
	boolean lNewRecordIsOwner		:=	pRight.own_1_company_name <> '' or pRight.own_1_lname <> '';
	boolean lNewRecordIsRegistrant	:=	pRight.reg_1_company_name <> '' or pRight.reg_1_lname <> '';
	boolean lNewRecordIsLienholder	:=	lNewRecordIsOwner = false and lNewRecordIsRegistrant = false;
	boolean lNewRecordIsPerson		:=	if(lNewRecordIsOwner,pRight.own_1_lname <> '',pRight.reg_1_lname <> '');
	boolean lNewRecordIsBusiness	:=	if(lNewRecordIsOwner,pRight.own_1_company_name <> '',pRight.reg_1_company_name <> '');
	boolean lOwner1IsFilled			:=	pLeft.own_1_company_name <> '' or pLeft.own_1_lname <> '';
	boolean lOwner2IsFilled			:=	pLeft.own_2_company_name <> '' or pLeft.own_2_lname <> '';
	boolean lRegistrant1IsFilled	:=	pLeft.reg_1_company_name <> '' or pLeft.reg_1_lname <> '';
	boolean lRegistrant2IsFilled	:=	pLeft.reg_2_company_name <> '' or pLeft.reg_2_lname <> '';
	boolean lLienholder1IsFilled	:=	pLeft.LH_1_CUSTOMER_NAME <> '';
	boolean lLienholder2IsFilled	:=	pLeft.LH_2_CUSTOMER_NAME <> '';
	boolean lLienHolder3IsFilled	:=	pLeft.LH_3_CUSTOMER_NAME <> '';
	self.OWNER_1_CUSTOMER_TYPExBG3	:=	if(lNewRecordIsOwner and not lOwner1IsFilled,pRight.OWNER_1_CUSTOMER_TYPExBG3,pLeft.OWNER_1_CUSTOMER_TYPExBG3);
	self.OWN_1_CUSTOMER_NAME		:=	if(lNewRecordIsOwner and not lOwner1IsFilled,pRight.OWN_1_CUSTOMER_NAME,pLeft.OWN_1_CUSTOMER_NAME);
    self.OWN_1_FEID_SSN 			:=	if(lNewRecordIsOwner and not lOwner1IsFilled,pRight.OWN_1_FEID_SSN,pLeft.OWN_1_FEID_SSN);
    self.OWN_1_DOB					:=	if(lNewRecordIsOwner and not lOwner1IsFilled,pRight.OWN_1_DOB,pLeft.OWN_1_DOB);
    self.OWN_1_STREET_ADDRESS		:=	if(lNewRecordIsOwner and not lOwner1IsFilled,pRight.OWN_1_STREET_ADDRESS,pLeft.OWN_1_STREET_ADDRESS);
    self.OWN_1_CITY					:=	if(lNewRecordIsOwner and not lOwner1IsFilled,pRight.OWN_1_CITY,pLeft.OWN_1_CITY);
    self.OWN_1_STATE				:=	if(lNewRecordIsOwner and not lOwner1IsFilled,pRight.OWN_1_STATE,pLeft.OWN_1_STATE);
    self.OWN_1_ZIP5_ZIP4_FOREIGN_POSTAL	:=	if(lNewRecordIsOwner and not lOwner1IsFilled,pRight.OWN_1_ZIP5_ZIP4_FOREIGN_POSTAL,pLeft.OWN_1_ZIP5_ZIP4_FOREIGN_POSTAL);
	self.own_1_title 				:=	if(lNewRecordIsOwner and not lOwner1IsFilled,pRight.own_1_title,pLeft.own_1_title);
	self.own_1_fname 				:=	if(lNewRecordIsOwner and not lOwner1IsFilled,pRight.own_1_fname,pLeft.own_1_fname);
	self.own_1_mname 				:=	if(lNewRecordIsOwner and not lOwner1IsFilled,pRight.own_1_mname,pLeft.own_1_mname);
	self.own_1_lname 				:=	if(lNewRecordIsOwner and not lOwner1IsFilled,pRight.own_1_lname,pLeft.own_1_lname);
	self.own_1_name_suffix 			:=	if(lNewRecordIsOwner and not lOwner1IsFilled,pRight.own_1_name_suffix,pLeft.own_1_name_suffix);
	self.own_1_company_name 		:=	if(lNewRecordIsOwner and not lOwner1IsFilled,pRight.own_1_company_name,pLeft.own_1_company_name);
	self.own_1_prim_range 			:=	if(lNewRecordIsOwner and not lOwner1IsFilled,pRight.own_1_prim_range,pLeft.own_1_prim_range);
	self.own_1_predir 				:=	if(lNewRecordIsOwner and not lOwner1IsFilled,pRight.own_1_predir,pLeft.own_1_predir);
	self.own_1_prim_name 			:=	if(lNewRecordIsOwner and not lOwner1IsFilled,pRight.own_1_prim_name,pLeft.own_1_prim_name);
	self.own_1_suffix 				:=	if(lNewRecordIsOwner and not lOwner1IsFilled,pRight.own_1_suffix,pLeft.own_1_suffix);
	self.own_1_postdir 				:=	if(lNewRecordIsOwner and not lOwner1IsFilled,pRight.own_1_postdir,pLeft.own_1_postdir);
	self.own_1_unit_desig 			:=	if(lNewRecordIsOwner and not lOwner1IsFilled,pRight.own_1_unit_desig,pLeft.own_1_unit_desig);
	self.own_1_sec_range 			:=	if(lNewRecordIsOwner and not lOwner1IsFilled,pRight.own_1_sec_range,pLeft.own_1_sec_range);
	self.own_1_p_city_name 			:=	if(lNewRecordIsOwner and not lOwner1IsFilled,pRight.own_1_p_city_name,pLeft.own_1_p_city_name);
	self.own_1_v_city_name 			:=	if(lNewRecordIsOwner and not lOwner1IsFilled,pRight.own_1_v_city_name,pLeft.own_1_v_city_name);
	self.own_1_state_2 				:=	if(lNewRecordIsOwner and not lOwner1IsFilled,pRight.own_1_state_2,pLeft.own_1_state_2);
	self.own_1_zip5 				:=	if(lNewRecordIsOwner and not lOwner1IsFilled,pRight.own_1_zip5,pLeft.own_1_zip5);
	self.own_1_zip4 				:=	if(lNewRecordIsOwner and not lOwner1IsFilled,pRight.own_1_zip4,pLeft.own_1_zip4);
	self.own_1_county				:=	if(lNewRecordIsOwner and not lOwner1IsFilled,pRight.own_1_county,pLeft.own_1_county);
	self.OWNER_2_CUSTOMER_TYPE	:=	if(lNewRecordIsOwner and lOwner1IsFilled and not lOwner2IsFilled,pRight.OWNER_1_CUSTOMER_TYPExBG3,pLeft.OWNER_2_CUSTOMER_TYPE);
	self.OWN_2_CUSTOMER_NAME		:=	if(lNewRecordIsOwner and lOwner1IsFilled and not lOwner2IsFilled,pRight.OWN_1_CUSTOMER_NAME,pLeft.OWN_2_CUSTOMER_NAME);
    self.OWN_2_FEID_SSN 			:=	if(lNewRecordIsOwner and lOwner1IsFilled and not lOwner2IsFilled,pRight.OWN_1_FEID_SSN,pLeft.OWN_2_FEID_SSN);
    self.OWN_2_DOB					:=	if(lNewRecordIsOwner and lOwner1IsFilled and not lOwner2IsFilled,pRight.OWN_1_DOB,pLeft.OWN_2_DOB);
    self.OWN_2_STREET_ADDRESS		:=	if(lNewRecordIsOwner and lOwner1IsFilled and not lOwner2IsFilled,pRight.OWN_1_STREET_ADDRESS,pLeft.OWN_2_STREET_ADDRESS);
    self.OWN_2_CITY					:=	if(lNewRecordIsOwner and lOwner1IsFilled and not lOwner2IsFilled,pRight.OWN_1_CITY,pLeft.OWN_2_CITY);
    self.OWN_2_STATE				:=	if(lNewRecordIsOwner and lOwner1IsFilled and not lOwner2IsFilled,pRight.OWN_1_STATE,pLeft.OWN_2_STATE);
    self.OWN_2_ZIP5_ZIP4_FOREIGN_POSTAL	:=	if(lNewRecordIsOwner and lOwner1IsFilled and not lOwner2IsFilled,pRight.OWN_1_ZIP5_ZIP4_FOREIGN_POSTAL,pLeft.OWN_2_ZIP5_ZIP4_FOREIGN_POSTAL);
	self.own_2_title 				:=	if(lNewRecordIsOwner and lOwner1IsFilled and not lOwner2IsFilled,pRight.own_1_title,pLeft.own_2_title);
	self.own_2_fname 				:=	if(lNewRecordIsOwner and lOwner1IsFilled and not lOwner2IsFilled,pRight.own_1_fname,pLeft.own_2_fname);
	self.own_2_mname 				:=	if(lNewRecordIsOwner and lOwner1IsFilled and not lOwner2IsFilled,pRight.own_1_mname,pLeft.own_2_mname);
	self.own_2_lname 				:=	if(lNewRecordIsOwner and lOwner1IsFilled and not lOwner2IsFilled,pRight.own_1_lname,pLeft.own_2_lname);
	self.own_2_name_suffix 			:=	if(lNewRecordIsOwner and lOwner1IsFilled and not lOwner2IsFilled,pRight.own_1_name_suffix,pLeft.own_2_name_suffix);
	self.own_2_company_name 		:=	if(lNewRecordIsOwner and lOwner1IsFilled and not lOwner2IsFilled,pRight.own_1_company_name,pLeft.own_2_company_name);
	self.own_2_prim_range 			:=	if(lNewRecordIsOwner and lOwner1IsFilled and not lOwner2IsFilled,pRight.own_1_prim_range,pLeft.own_2_prim_range);
	self.own_2_predir 				:=	if(lNewRecordIsOwner and lOwner1IsFilled and not lOwner2IsFilled,pRight.own_1_predir,pLeft.own_2_predir);
	self.own_2_prim_name 			:=	if(lNewRecordIsOwner and lOwner1IsFilled and not lOwner2IsFilled,pRight.own_1_prim_name,pLeft.own_2_prim_name);
	self.own_2_suffix 				:=	if(lNewRecordIsOwner and lOwner1IsFilled and not lOwner2IsFilled,pRight.own_1_suffix,pLeft.own_2_suffix);
	self.own_2_postdir 				:=	if(lNewRecordIsOwner and lOwner1IsFilled and not lOwner2IsFilled,pRight.own_1_postdir,pLeft.own_2_postdir);
	self.own_2_unit_desig 			:=	if(lNewRecordIsOwner and lOwner1IsFilled and not lOwner2IsFilled,pRight.own_1_unit_desig,pLeft.own_2_unit_desig);
	self.own_2_sec_range 			:=	if(lNewRecordIsOwner and lOwner1IsFilled and not lOwner2IsFilled,pRight.own_1_sec_range,pLeft.own_2_sec_range);
	self.own_2_p_city_name 			:=	if(lNewRecordIsOwner and lOwner1IsFilled and not lOwner2IsFilled,pRight.own_1_p_city_name,pLeft.own_2_p_city_name);
	self.own_2_v_city_name 			:=	if(lNewRecordIsOwner and lOwner1IsFilled and not lOwner2IsFilled,pRight.own_1_v_city_name,pLeft.own_2_v_city_name);
	self.own_2_state_2 				:=	if(lNewRecordIsOwner and lOwner1IsFilled and not lOwner2IsFilled,pRight.own_1_state_2,pLeft.own_2_state_2);
	self.own_2_zip5 				:=	if(lNewRecordIsOwner and lOwner1IsFilled and not lOwner2IsFilled,pRight.own_1_zip5,pLeft.own_2_zip5);
	self.own_2_zip4 				:=	if(lNewRecordIsOwner and lOwner1IsFilled and not lOwner2IsFilled,pRight.own_1_zip4,pLeft.own_2_zip4);
	self.own_2_county				:=	if(lNewRecordIsOwner and lOwner1IsFilled and not lOwner2IsFilled,pRight.own_1_county,pLeft.own_2_county);
	self.REGISTRANT_1_CUSTOMER_TYPExBG5	:=	if(lNewRecordIsRegistrant and not lRegistrant1IsFilled,pRight.REGISTRANT_1_CUSTOMER_TYPExBG5,pLeft.REGISTRANT_1_CUSTOMER_TYPExBG5);
	self.REG_1_CUSTOMER_NAME		:=	if(lNewRecordIsRegistrant and not lRegistrant1IsFilled,pRight.REG_1_CUSTOMER_NAME,pLeft.REG_1_CUSTOMER_NAME);
    self.REG_1_FEID_SSN 			:=	if(lNewRecordIsRegistrant and not lRegistrant1IsFilled,pRight.REG_1_FEID_SSN,pLeft.REG_1_FEID_SSN);
    self.REG_1_DOB					:=	if(lNewRecordIsRegistrant and not lRegistrant1IsFilled,pRight.REG_1_DOB,pLeft.REG_1_DOB);
    self.REG_1_STREET_ADDRESS		:=	if(lNewRecordIsRegistrant and not lRegistrant1IsFilled,pRight.REG_1_STREET_ADDRESS,pLeft.REG_1_STREET_ADDRESS);
    self.REG_1_CITY					:=	if(lNewRecordIsRegistrant and not lRegistrant1IsFilled,pRight.REG_1_CITY,pLeft.REG_1_CITY);
    self.REG_1_STATE				:=	if(lNewRecordIsRegistrant and not lRegistrant1IsFilled,pRight.REG_1_STATE,pLeft.REG_1_STATE);
    self.REG_1_ZIP5_ZIP4_FOREIGN_POSTAL	:=	if(lNewRecordIsRegistrant and not lRegistrant1IsFilled,pRight.REG_1_ZIP5_ZIP4_FOREIGN_POSTAL,pLeft.REG_1_ZIP5_ZIP4_FOREIGN_POSTAL);
	self.reg_1_title 				:=	if(lNewRecordIsRegistrant and not lRegistrant1IsFilled,pRight.REG_1_title,pLeft.REG_1_title);
	self.reg_1_fname 				:=	if(lNewRecordIsRegistrant and not lRegistrant1IsFilled,pRight.REG_1_fname,pLeft.REG_1_fname);
	self.reg_1_mname 				:=	if(lNewRecordIsRegistrant and not lRegistrant1IsFilled,pRight.REG_1_mname,pLeft.REG_1_mname);
	self.reg_1_lname 				:=	if(lNewRecordIsRegistrant and not lRegistrant1IsFilled,pRight.REG_1_lname,pLeft.REG_1_lname);
	self.reg_1_name_suffix 			:=	if(lNewRecordIsRegistrant and not lRegistrant1IsFilled,pRight.REG_1_name_suffix,pLeft.REG_1_name_suffix);
	self.reg_1_company_name 		:=	if(lNewRecordIsRegistrant and not lRegistrant1IsFilled,pRight.REG_1_company_name,pLeft.REG_1_company_name);
	self.reg_1_prim_range 			:=	if(lNewRecordIsRegistrant and not lRegistrant1IsFilled,pRight.REG_1_prim_range,pLeft.REG_1_prim_range);
	self.reg_1_predir 				:=	if(lNewRecordIsRegistrant and not lRegistrant1IsFilled,pRight.REG_1_predir,pLeft.REG_1_predir);
	self.reg_1_prim_name 			:=	if(lNewRecordIsRegistrant and not lRegistrant1IsFilled,pRight.REG_1_prim_name,pLeft.REG_1_prim_name);
	self.reg_1_suffix 				:=	if(lNewRecordIsRegistrant and not lRegistrant1IsFilled,pRight.REG_1_suffix,pLeft.REG_1_suffix);
	self.reg_1_postdir 				:=	if(lNewRecordIsRegistrant and not lRegistrant1IsFilled,pRight.REG_1_postdir,pLeft.REG_1_postdir);
	self.reg_1_unit_desig 			:=	if(lNewRecordIsRegistrant and not lRegistrant1IsFilled,pRight.REG_1_unit_desig,pLeft.REG_1_unit_desig);
	self.reg_1_sec_range 			:=	if(lNewRecordIsRegistrant and not lRegistrant1IsFilled,pRight.REG_1_sec_range,pLeft.REG_1_sec_range);
	self.reg_1_p_city_name 			:=	if(lNewRecordIsRegistrant and not lRegistrant1IsFilled,pRight.REG_1_p_city_name,pLeft.REG_1_p_city_name);
	self.reg_1_v_city_name 			:=	if(lNewRecordIsRegistrant and not lRegistrant1IsFilled,pRight.REG_1_v_city_name,pLeft.REG_1_v_city_name);
	self.reg_1_state_2 				:=	if(lNewRecordIsRegistrant and not lRegistrant1IsFilled,pRight.REG_1_state_2,pLeft.REG_1_state_2);
	self.reg_1_zip5 				:=	if(lNewRecordIsRegistrant and not lRegistrant1IsFilled,pRight.REG_1_zip5,pLeft.REG_1_zip5);
	self.reg_1_zip4 				:=	if(lNewRecordIsRegistrant and not lRegistrant1IsFilled,pRight.REG_1_zip4,pLeft.REG_1_zip4);
	self.reg_1_county				:=	if(lNewRecordIsRegistrant and not lRegistrant1IsFilled,pRight.REG_1_county,pLeft.REG_1_county);
	self.REGISTRANT_2_CUSTOMER_TYPE	:=	if(lNewRecordIsRegistrant and lRegistrant1IsFilled and not lRegistrant2IsFilled,pRight.REGISTRANT_1_CUSTOMER_TYPExBG5,pLeft.REGISTRANT_2_CUSTOMER_TYPE);
	self.REG_2_CUSTOMER_NAME		:=	if(lNewRecordIsRegistrant and lRegistrant1IsFilled and not lRegistrant2IsFilled,pRight.REG_1_CUSTOMER_NAME,pLeft.REG_2_CUSTOMER_NAME);
    self.REG_2_FEID_SSN 			:=	if(lNewRecordIsRegistrant and lRegistrant1IsFilled and not lRegistrant2IsFilled,pRight.REG_1_FEID_SSN,pLeft.REG_2_FEID_SSN);
    self.REG_2_DOB					:=	if(lNewRecordIsRegistrant and lRegistrant1IsFilled and not lRegistrant2IsFilled,pRight.REG_1_DOB,pLeft.REG_2_DOB);
    self.REG_2_STREET_ADDRESS		:=	if(lNewRecordIsRegistrant and lRegistrant1IsFilled and not lRegistrant2IsFilled,pRight.REG_1_STREET_ADDRESS,pLeft.REG_2_STREET_ADDRESS);
    self.REG_2_CITY					:=	if(lNewRecordIsRegistrant and lRegistrant1IsFilled and not lRegistrant2IsFilled,pRight.REG_1_CITY,pLeft.REG_2_CITY);
    self.REG_2_STATE				:=	if(lNewRecordIsRegistrant and lRegistrant1IsFilled and not lRegistrant2IsFilled,pRight.REG_1_STATE,pLeft.REG_2_STATE);
    self.REG_2_ZIP5_ZIP4_FOREIGN_POSTAL	:=	if(lNewRecordIsRegistrant and lRegistrant1IsFilled and not lRegistrant2IsFilled,pRight.REG_1_ZIP5_ZIP4_FOREIGN_POSTAL,pLeft.REG_2_ZIP5_ZIP4_FOREIGN_POSTAL);
	self.reg_2_title 				:=	if(lNewRecordIsRegistrant and lRegistrant1IsFilled and not lRegistrant2IsFilled,pRight.REG_1_title,pLeft.REG_2_title);
	self.reg_2_fname 				:=	if(lNewRecordIsRegistrant and lRegistrant1IsFilled and not lRegistrant2IsFilled,pRight.REG_1_fname,pLeft.REG_2_fname);
	self.reg_2_mname 				:=	if(lNewRecordIsRegistrant and lRegistrant1IsFilled and not lRegistrant2IsFilled,pRight.REG_1_mname,pLeft.REG_2_mname);
	self.reg_2_lname 				:=	if(lNewRecordIsRegistrant and lRegistrant1IsFilled and not lRegistrant2IsFilled,pRight.REG_1_lname,pLeft.REG_2_lname);
	self.reg_2_name_suffix 			:=	if(lNewRecordIsRegistrant and lRegistrant1IsFilled and not lRegistrant2IsFilled,pRight.REG_1_name_suffix,pLeft.REG_2_name_suffix);
	self.reg_2_company_name 		:=	if(lNewRecordIsRegistrant and lRegistrant1IsFilled and not lRegistrant2IsFilled,pRight.REG_1_company_name,pLeft.REG_2_company_name);
	self.reg_2_prim_range 			:=	if(lNewRecordIsRegistrant and lRegistrant1IsFilled and not lRegistrant2IsFilled,pRight.REG_1_prim_range,pLeft.REG_2_prim_range);
	self.reg_2_predir 				:=	if(lNewRecordIsRegistrant and lRegistrant1IsFilled and not lRegistrant2IsFilled,pRight.REG_1_predir,pLeft.REG_2_predir);
	self.reg_2_prim_name 			:=	if(lNewRecordIsRegistrant and lRegistrant1IsFilled and not lRegistrant2IsFilled,pRight.REG_1_prim_name,pLeft.REG_2_prim_name);
	self.reg_2_suffix 				:=	if(lNewRecordIsRegistrant and lRegistrant1IsFilled and not lRegistrant2IsFilled,pRight.REG_1_suffix,pLeft.REG_2_suffix);
	self.reg_2_postdir 				:=	if(lNewRecordIsRegistrant and lRegistrant1IsFilled and not lRegistrant2IsFilled,pRight.REG_1_postdir,pLeft.REG_2_postdir);
	self.reg_2_unit_desig 			:=	if(lNewRecordIsRegistrant and lRegistrant1IsFilled and not lRegistrant2IsFilled,pRight.REG_1_unit_desig,pLeft.REG_2_unit_desig);
	self.reg_2_sec_range 			:=	if(lNewRecordIsRegistrant and lRegistrant1IsFilled and not lRegistrant2IsFilled,pRight.REG_1_sec_range,pLeft.REG_2_sec_range);
	self.reg_2_p_city_name 			:=	if(lNewRecordIsRegistrant and lRegistrant1IsFilled and not lRegistrant2IsFilled,pRight.REG_1_p_city_name,pLeft.REG_2_p_city_name);
	self.reg_2_v_city_name 			:=	if(lNewRecordIsRegistrant and lRegistrant1IsFilled and not lRegistrant2IsFilled,pRight.REG_1_v_city_name,pLeft.REG_2_v_city_name);
	self.reg_2_state_2 				:=	if(lNewRecordIsRegistrant and lRegistrant1IsFilled and not lRegistrant2IsFilled,pRight.REG_1_state_2,pLeft.REG_2_state_2);
	self.reg_2_zip5 				:=	if(lNewRecordIsRegistrant and lRegistrant1IsFilled and not lRegistrant2IsFilled,pRight.REG_1_zip5,pLeft.REG_2_zip5);
	self.reg_2_zip4 				:=	if(lNewRecordIsRegistrant and lRegistrant1IsFilled and not lRegistrant2IsFilled,pRight.REG_1_zip4,pLeft.REG_2_zip4);
	self.reg_2_county				:=	if(lNewRecordIsRegistrant and lRegistrant1IsFilled and not lRegistrant2IsFilled,pRight.REG_1_county,pLeft.REG_2_county);
	self.LH_1_CUSTOMER_NAME			:=	if(lNewRecordIsLienholder and not lLienholder1IsFilled,pRight.LH_1_CUSTOMER_NAME,pLeft.LH_1_CUSTOMER_NAME);
    self.LH_1_STREET_ADDRESS		:=	if(lNewRecordIsLienholder and not lLienholder1IsFilled,pRight.LH_1_STREET_ADDRESS,pLEFT.LH_1_STREET_ADDRESS);
    self.LH_1_CITY					:=	if(lNewRecordIsLienholder and not lLienholder1IsFilled,pRight.LH_1_CITY,pLEFT.LH_1_CITY);
    self.LH_1_STATE					:=	if(lNewRecordIsLienholder and not lLienholder1IsFilled,pRight.LH_1_STATE,pLEFT.LH_1_STATE);
    self.LH_1_ZIP5_ZIP4_FOREIGN_POSTAL	:=	if(lNewRecordIsLienholder and not lLienholder1IsFilled,pRight.LH_1_ZIP5_ZIP4_FOREIGN_POSTAL,pLEFT.LH_1_ZIP5_ZIP4_FOREIGN_POSTAL);
	self.LH_2_CUSTOMER_NAME			:=	if(lNewRecordIsLienholder and lLienholder1IsFilled and not lLienholder2IsFilled,pRight.LH_1_CUSTOMER_NAME,pLeft.LH_2_CUSTOMER_NAME);
    self.LH_2_STREET_ADDRESS		:=	if(lNewRecordIsLienholder and lLienholder1IsFilled and not lLienholder2IsFilled,pRight.LH_1_STREET_ADDRESS,pLEFT.LH_2_STREET_ADDRESS);
    self.LH_2_CITY					:=	if(lNewRecordIsLienholder and lLienholder1IsFilled and not lLienholder2IsFilled,pRight.LH_1_CITY,pLEFT.LH_2_CITY);
    self.LH_2_STATE					:=	if(lNewRecordIsLienholder and lLienholder1IsFilled and not lLienholder2IsFilled,pRight.LH_1_STATE,pLEFT.LH_2_STATE);
    self.LH_2_ZIP5_ZIP4_FOREIGN_POSTAL	:=	if(lNewRecordIsLienholder and lLienholder1IsFilled and not lLienholder2IsFilled,pRight.LH_1_ZIP5_ZIP4_FOREIGN_POSTAL,pLEFT.LH_2_ZIP5_ZIP4_FOREIGN_POSTAL);
	self.LH_3_CUSTOMER_NAME			:=	if(lNewRecordIsLienholder and lLienholder1IsFilled and lLienholder2IsFilled and not lLienholder3IsFilled,pRight.LH_1_CUSTOMER_NAME,pLeft.LH_3_CUSTOMER_NAME);
    self.LH_3_STREET_ADDRESS		:=	if(lNewRecordIsLienholder and lLienholder1IsFilled and lLienholder2IsFilled and not lLienholder3IsFilled,pRight.LH_1_STREET_ADDRESS,pLEFT.LH_3_STREET_ADDRESS);
    self.LH_3_CITY					:=	if(lNewRecordIsLienholder and lLienholder1IsFilled and lLienholder2IsFilled and not lLienholder3IsFilled,pRight.LH_1_CITY,pLEFT.LH_3_CITY);
    self.LH_3_STATE					:=	if(lNewRecordIsLienholder and lLienholder1IsFilled and lLienholder2IsFilled and not lLienholder3IsFilled,pRight.LH_1_STATE,pLEFT.LH_3_STATE);
    self.LH_3_ZIP5_ZIP4_FOREIGN_POSTAL	:=	if(lNewRecordIsLienholder and lLienholder1IsFilled and lLienholder2IsFilled and not lLienholder3IsFilled,pRight.LH_1_ZIP5_ZIP4_FOREIGN_POSTAL,pLEFT.LH_3_ZIP5_ZIP4_FOREIGN_POSTAL);
	self.VEHICLE_NUMBERxBG1			:=	if(pRight.VEHICLE_NUMBERxBG1 <> '',pRight.VEHICLE_NUMBERxBG1,pLeft.VEHICLE_NUMBERxBG1);
	self.ORIG_VIN					:=	if(pRight.ORIG_VIN <> '',pRight.ORIG_VIN,pLeft.ORIG_VIN);
	self.YEAR_MAKE					:=	if(pRight.YEAR_MAKE <> '',pRight.YEAR_MAKE,pLeft.YEAR_MAKE);
	self.MAKE_CODE					:=	if(pRight.MAKE_CODE <> '',pRight.MAKE_CODE,pLeft.MAKE_CODE);
	self.MODEL						:=	if(pRight.MODEL <> '',pRight.MODEL,pLeft.MODEL);
	self.MAJOR_COLOR_CODE			:=	if(pRight.MAJOR_COLOR_CODE <> '',pRight.MAJOR_COLOR_CODE,pLeft.MAJOR_COLOR_CODE);
	self.MINOR_COLOR_CODE			:=	if(pRight.MINOR_COLOR_CODE <> '',pRight.MINOR_COLOR_CODE,pLeft.MINOR_COLOR_CODE);
	self.BODY_CODE					:=	if(pRight.BODY_CODE <> '',pRight.BODY_CODE,pLeft.BODY_CODE);
	self.NET_WEIGHT					:=	if(pRight.NET_WEIGHT <> '',pRight.NET_WEIGHT,pLeft.NET_WEIGHT);
	self.NUMBER_OF_AXLES			:=	if(pRight.NUMBER_OF_AXLES <> '',pRight.NUMBER_OF_AXLES,pLeft.NUMBER_OF_AXLES);
	self.LICENSE_PLATE_NUMBERxBG4	:=	if(pRight.LICENSE_PLATE_NUMBERxBG4 <> '',pRight.LICENSE_PLATE_NUMBERxBG4,pLeft.LICENSE_PLATE_NUMBERxBG4);
	self.TRUE_LICENSE_PLSTE_NUMBER	:=	if(pRight.TRUE_LICENSE_PLSTE_NUMBER <> '',pRight.TRUE_LICENSE_PLSTE_NUMBER,pLeft.TRUE_LICENSE_PLSTE_NUMBER);
	self.REGISTRATION_EXPIRATION_DATE	:=	if(pRight.REGISTRATION_EXPIRATION_DATE <> '',pRight.REGISTRATION_EXPIRATION_DATE,pLeft.REGISTRATION_EXPIRATION_DATE);
	self.LICENSE_PLATE_CODE			:=	if(pRight.LICENSE_PLATE_CODE <> '',pRight.LICENSE_PLATE_CODE,pLeft.LICENSE_PLATE_CODE);
	self.DECAL_NUMBER				:=	if(pRight.DECAL_NUMBER <> '',pRight.DECAL_NUMBER,pLeft.DECAL_NUMBER);
	self.FIRST_REGISTRATION_DATE	:=	if(pRight.FIRST_REGISTRATION_DATE <> '',pRight.FIRST_REGISTRATION_DATE,pLeft.FIRST_REGISTRATION_DATE);
	self.REGISTRATION_EFFECTIVE_DATE	:=	if(pRight.REGISTRATION_EFFECTIVE_DATE <> '',pRight.REGISTRATION_EFFECTIVE_DATE,pLeft.REGISTRATION_EFFECTIVE_DATE);
	self.TITLE_NUMBERxBG9			:=	if(pRight.TITLE_NUMBERxBG9 <> '',pRight.TITLE_NUMBERxBG9,pLeft.TITLE_NUMBERxBG9);
	self.TITLE_ISSUE_DATE			:=	if(pRight.TITLE_ISSUE_DATE <> '',pRight.TITLE_ISSUE_DATE,pLeft.TITLE_ISSUE_DATE);
	self.PREVIOUS_TITLE_ISSUE_DATE	:=	if(pRight.PREVIOUS_TITLE_ISSUE_DATE <> '',pRight.PREVIOUS_TITLE_ISSUE_DATE,pLeft.PREVIOUS_TITLE_ISSUE_DATE);
	self.seq_no						:=	pLeft.seq_no + 1;
	self							:=	pRight;
  end
 ;

dCombinedDist		:=	distribute(dCombined,hash(UniqueKey));
dCombinedSortOwners	:=	sort(dCombinedDist(own_1_lname<>'' or own_1_company_name<>''),UniqueKey,TITLE_NUMBERxBG9,TITLE_ISSUE_DATE,dt_first_seen,own_1_lname,own_1_fname,own_1_company_name,local);     
dCombinedSortRegs	:=	sort(dCombinedDist(reg_1_lname<>'' or reg_1_company_name<>''),UniqueKey,REGISTRATION_EFFECTIVE_DATE,LICENSE_PLATE_NUMBERxBG4,dt_first_seen,reg_1_lname,reg_1_fname,reg_1_company_name,local);     
dCombinedSortLHs	:=	sort(dCombinedDist(lh_1_customer_name<>''),UniqueKey,TITLE_NUMBERxBG9,TITLE_ISSUE_DATE,dt_first_seen,lh_1_customer_name,local);     

dRolledUpOwners	:=	rollup(dCombinedSortOwners,
						   left.UniqueKey = right.UniqueKey
					   and left.TITLE_NUMBERxBG9 = right.TITLE_NUMBERxBG9
					   and left.TITLE_ISSUE_DATE = right.TITLE_ISSUE_DATE
					   and left.dt_first_seen = right.dt_first_seen,
						   tRollupSameVehicle(left,right),
						   local
						  );

dRolledUpRegs	:=	rollup(dCombinedSortRegs,
						   left.UniqueKey = right.UniqueKey
					   and left.REGISTRATION_EFFECTIVE_DATE = right.REGISTRATION_EFFECTIVE_DATE
					   and left.LICENSE_PLATE_NUMBERxBG4 = right.LICENSE_PLATE_NUMBERxBG4
					   and left.dt_first_seen = right.dt_first_seen,
						   tRollupSameVehicle(left,right),
						   local
						  );

dRolledUpLHs	:=	rollup(dCombinedSortLHs,
						   left.UniqueKey = right.UniqueKey
					   and left.TITLE_NUMBERxBG9 = right.TITLE_NUMBERxBG9
					   and left.TITLE_ISSUE_DATE = right.TITLE_ISSUE_DATE
					   and left.dt_first_seen = right.dt_first_seen,
						   tRollupSameVehicle(left,right),
						   local
						  );

mGetFilled(pFieldName)
 :=
  macro
	self.pFieldName	:=	if(pRight.pFieldName <> '', pRight.pFieldName, pLeft.pFieldName);
  endmacro
 ;

mGetFilledAndUnknown(pFieldName)
 :=
  macro
	self.pFieldName	:=	fRemoveUnknown(if(pRight.pFieldName <> '', pRight.pFieldName, pLeft.pFieldName));
  endmacro
 ;

mGetFilledInteger(pFieldName)
 :=
  macro
	self.pFieldName	:=	if(pRight.pFieldName <> 0, pRight.pFieldName, pLeft.pFieldName);
  endmacro
 ;

rVehicleWithUniqueKey	tJoinSameVehicle(dCombined pLeft, dCombined pRight)
 :=
  transform
	mGetFilled(uniquekey)
	mGetFilledInteger(dt_first_seen)
	mGetFilledInteger(dt_last_seen)
	mGetFilledInteger(dt_vendor_first_reported)
	mGetFilledInteger(dt_vendor_last_reported)
	mGetFilled(source_code)
	mGetFilled(orig_state)
	mGetFilled(OWNER_1_CUSTOMER_TYPExBG3)
	mGetFilledAndUnknown(OWN_1_CUSTOMER_NAME)
    mGetFilled(OWN_1_FEID_SSN)
    mGetFilled(OWN_1_DOB)
    mGetFilled(OWN_1_STREET_ADDRESS)
    mGetFilled(OWN_1_CITY)
    mGetFilled(OWN_1_STATE)
    mGetFilled(OWN_1_ZIP5_ZIP4_FOREIGN_POSTAL)
	mGetFilled(own_1_title)
	mGetFilledAndUnknown(own_1_fname)
	mGetFilledAndUnknown(own_1_mname)
	mGetFilledAndUnknown(own_1_lname)
	mGetFilled(own_1_name_suffix)
	mGetFilledAndUnknown(own_1_company_name)
	mGetFilled(own_1_prim_range)
	mGetFilled(own_1_predir)
	mGetFilled(own_1_prim_name)
	mGetFilled(own_1_suffix)
	mGetFilled(own_1_postdir)
	mGetFilled(own_1_unit_desig)
	mGetFilled(own_1_sec_range)
	mGetFilled(own_1_p_city_name)
	mGetFilled(own_1_v_city_name)
	mGetFilled(own_1_state_2)
	mGetFilled(own_1_zip5)
	mGetFilled(own_1_zip4)
	mGetFilled(own_1_county)
	mGetFilled(OWNER_2_CUSTOMER_TYPE)
	mGetFilledAndUnknown(OWN_2_CUSTOMER_NAME)
    mGetFilled(OWN_2_FEID_SSN)
    mGetFilled(OWN_2_DOB)
    mGetFilled(OWN_2_STREET_ADDRESS)
    mGetFilled(OWN_2_CITY)
    mGetFilled(OWN_2_STATE)
    mGetFilled(OWN_2_ZIP5_ZIP4_FOREIGN_POSTAL)
	mGetFilled(own_2_title)
	mGetFilledAndUnknown(own_2_fname)
	mGetFilledAndUnknown(own_2_mname)
	mGetFilledAndUnknown(own_2_lname)
	mGetFilled(own_2_name_suffix)
	mGetFilledAndUnknown(own_2_company_name)
	mGetFilled(own_2_prim_range)
	mGetFilled(own_2_predir)
	mGetFilled(own_2_prim_name)
	mGetFilled(own_2_suffix)
	mGetFilled(own_2_postdir)
	mGetFilled(own_2_unit_desig)
	mGetFilled(own_2_sec_range)
	mGetFilled(own_2_p_city_name)
	mGetFilled(own_2_v_city_name)
	mGetFilled(own_2_state_2)
	mGetFilled(own_2_zip5)
	mGetFilled(own_2_zip4)
	mGetFilled(own_2_county)
	mGetFilled(REGISTRANT_1_CUSTOMER_TYPExBG5)
	mGetFilledAndUnknown(REG_1_CUSTOMER_NAME)
    mGetFilled(REG_1_FEID_SSN)
    mGetFilled(REG_1_DOB)
    mGetFilled(REG_1_STREET_ADDRESS)
    mGetFilled(REG_1_CITY)
    mGetFilled(REG_1_STATE)
    mGetFilled(REG_1_ZIP5_ZIP4_FOREIGN_POSTAL)
	mGetFilled(reg_1_title)
	mGetFilledAndUnknown(reg_1_fname)
	mGetFilledAndUnknown(reg_1_mname)
	mGetFilledAndUnknown(reg_1_lname)
	mGetFilled(reg_1_name_suffix)
	mGetFilledAndUnknown(reg_1_company_name)
	mGetFilled(reg_1_prim_range)
	mGetFilled(reg_1_predir)
	mGetFilled(reg_1_prim_name)
	mGetFilled(reg_1_suffix)
	mGetFilled(reg_1_postdir)
	mGetFilled(reg_1_unit_desig)
	mGetFilled(reg_1_sec_range)
	mGetFilled(reg_1_p_city_name)
	mGetFilled(reg_1_v_city_name)
	mGetFilled(reg_1_state_2)
	mGetFilled(reg_1_zip5)
	mGetFilled(reg_1_zip4)
	mGetFilled(reg_1_county)
	mGetFilled(REGISTRANT_2_CUSTOMER_TYPE)
	mGetFilledAndUnknown(REG_2_CUSTOMER_NAME)
    mGetFilled(REG_2_FEID_SSN)
    mGetFilled(REG_2_DOB)
    mGetFilled(REG_2_STREET_ADDRESS)
    mGetFilled(REG_2_CITY)
    mGetFilled(REG_2_STATE)
    mGetFilled(REG_2_ZIP5_ZIP4_FOREIGN_POSTAL)
	mGetFilled(reg_2_title)
	mGetFilledAndUnknown(reg_2_fname)
	mGetFilledAndUnknown(reg_2_mname)
	mGetFilledAndUnknown(reg_2_lname)
	mGetFilled(reg_2_name_suffix)
	mGetFilledAndUnknown(reg_2_company_name)
	mGetFilled(reg_2_prim_range)
	mGetFilled(reg_2_predir)
	mGetFilled(reg_2_prim_name)
	mGetFilled(reg_2_suffix)
	mGetFilled(reg_2_postdir)
	mGetFilled(reg_2_unit_desig)
	mGetFilled(reg_2_sec_range)
	mGetFilled(reg_2_p_city_name)
	mGetFilled(reg_2_v_city_name)
	mGetFilled(reg_2_state_2)
	mGetFilled(reg_2_zip5)
	mGetFilled(reg_2_zip4)
	mGetFilled(reg_2_county)
	mGetFilledAndUnknown(LH_1_CUSTOMER_NAME)
    mGetFilled(LH_1_STREET_ADDRESS)
    mGetFilled(LH_1_CITY)
    mGetFilled(LH_1_STATE)
    mGetFilled(LH_1_ZIP5_ZIP4_FOREIGN_POSTAL)
	mGetFilledAndUnknown(LH_2_CUSTOMER_NAME)
    mGetFilled(LH_2_STREET_ADDRESS)
    mGetFilled(LH_2_CITY)
    mGetFilled(LH_2_STATE)
    mGetFilled(LH_2_ZIP5_ZIP4_FOREIGN_POSTAL)
	mGetFilledAndUnknown(LH_3_CUSTOMER_NAME)
    mGetFilled(LH_3_STREET_ADDRESS)
    mGetFilled(LH_3_CITY)
    mGetFilled(LH_3_STATE)
    mGetFilled(LH_3_ZIP5_ZIP4_FOREIGN_POSTAL)
	mGetFilled(VEHICLE_NUMBERxBG1)
	mGetFilled(ORIG_VIN)
	mGetFilled(YEAR_MAKE)
	mGetFilled(MAKE_CODE)
	mGetFilled(MODEL)
	mGetFilled(MAJOR_COLOR_CODE)
	mGetFilled(MINOR_COLOR_CODE)
	mGetFilled(BODY_CODE)
	mGetFilled(NET_WEIGHT)
	mGetFilled(NUMBER_OF_AXLES)
	mGetFilled(LICENSE_PLATE_NUMBERxBG4)
	mGetFilled(TRUE_LICENSE_PLSTE_NUMBER)
	mGetFilled(REGISTRATION_EXPIRATION_DATE)
	mGetFilled(LICENSE_PLATE_CODE)
	mGetFilled(DECAL_NUMBER)
	mGetFilled(FIRST_REGISTRATION_DATE)
	mGetFilled(REGISTRATION_EFFECTIVE_DATE)
	mGetFilled(TITLE_NUMBERxBG9)
	mGetFilled(TITLE_ISSUE_DATE)
	mGetFilled(PREVIOUS_TITLE_ISSUE_DATE)
	self.seq_no						:=	pLeft.seq_no + 1;
  end
 ;

dOwnersAndLHs	:=	join(dRolledUpOwners,dRolledUpLHs,
						 left.UniqueKey = right.UniqueKey
					 and left.TITLE_NUMBERxBG9 = right.TITLE_NUMBERxBG9
					 and left.TITLE_ISSUE_DATE = right.TITLE_ISSUE_DATE
					 and left.dt_first_seen = right.dt_first_seen
					 and left.dt_last_seen = right.dt_last_seen
					 and left.dt_vendor_first_reported = right.dt_vendor_first_reported
					 and left.dt_vendor_last_reported = right.dt_vendor_last_reported,
						 tJoinSameVehicle(left,right),
						 full outer,
						 local
						);

dOwnersAndLHsAndRegs	:=	join(dOwnersAndLHs,dRolledUpRegs,
								 left.UniqueKey = right.UniqueKey
							 and left.dt_first_seen = right.dt_first_seen
							 and left.dt_last_seen = right.dt_last_seen
							 and left.dt_vendor_first_reported = right.dt_vendor_first_reported
							 and left.dt_vendor_last_reported = right.dt_vendor_last_reported
							 and (
								  (left.own_1_customer_name = right.reg_1_customer_name and left.own_2_customer_name = right.reg_2_customer_name)
								   or
								  (left.own_1_customer_name = right.reg_2_customer_name and left.own_2_customer_name = right.reg_1_customer_name)
								 ),
								 tJoinSameVehicle(left,right),
								 full outer,
								 local
								);

VehLic.Layout_Vehicles	tAsVehicles(dOwnersAndLHsAndRegs pInput)
 :=
  transform

    //fix dates way in the future 
  	unsigned3 v_nbr_months_reg_eff   := header.ConvertYYYYMMToNumberOfMonths((integer)pInput.registration_effective_date[1..6]);
	unsigned3 v_nbr_months_titl_iss  := header.ConvertYYYYMMToNumberOfMonths((integer)pInput.title_issue_date[1..6]);
	unsigned3 v_nbr_months_prev_titl := header.ConvertYYYYMMToNumberOfMonths((integer)pInput.previous_title_issue_date[1..6]);
	
	//6 months is arbitrary - it can be anything we want
	unsigned3 v_nbr_months_6_months_from_now := header.ConvertYYYYMMToNumberOfMonths((integer)ut.GetDate[1..6]+6);
	
	//197000 is also arbitrary
	unsigned3 v_nbr_months_197000 := 23640; //this is the result of passing '197000' to months conversion
  												 
    unsigned3 v_true_best_seen := if(v_nbr_months_reg_eff   between v_nbr_months_197000 and v_nbr_months_6_months_from_now,(unsigned3)pInput.REGISTRATION_EFFECTIVE_DATE[1..6],
	                              if(v_nbr_months_titl_iss  between v_nbr_months_197000 and v_nbr_months_6_months_from_now,(unsigned3)pInput.TITLE_ISSUE_DATE[1..6],
								  if(v_nbr_months_prev_titl between v_nbr_months_197000 and v_nbr_months_6_months_from_now,(unsigned3)pInput.PREVIOUS_TITLE_ISSUE_DATE[1..6],
	                              0)));
								  
	/*The incoming value of 0 means it's already been determined that nothing valid populates these fields*/
	self.dt_first_seen :=	if(pInput.dt_first_seen=0,pInput.dt_first_seen,v_true_best_seen);	                        							
    self.dt_last_seen  :=	if(pInput.dt_last_seen=0, pInput.dt_last_seen, v_true_best_seen);														
	
	self	:=	pInput;
  end
 ;

dRolledUp_FilledOnly	:=	dOwnersAndLHsAndRegs(OWNER_1_CUSTOMER_TYPExBG3 <> '' or REGISTRANT_1_CUSTOMER_TYPExBG5 <> '');

export Experian_Updating_as_Vehicles := project(dRolledUp_FilledOnly,tAsVehicles(left)) : persist('~thor_data400::persist::vehreg_experian_updating_as_vehicles');
