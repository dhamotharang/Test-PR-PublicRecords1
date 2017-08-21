import Lib_StringLib, ut, vehlic, standard,vehicleCodes, codes;

string1		lNameType_Owner		:=	'1';
string1		lNameType_Lessor	:=	'2';
string1		lNameType_Registrant:=	'4';
string1		lNameType_Lessee	:=	'5';
string1		lNameType_Lienholder:=	'7';

string1		lOwnerType_Person	:=	'1';
string1		lOwnerType_Business	:=	'2';

//sValidExperianUpdatingStates	:=	['AK','CO','DC','IL','LA','MA','MI','NY','TN','UT','ME','WI'];
sValidExperianUpdatingExceptions:=	['ME','WI'];

//combine annual full + monthly 
dExperianAll			:=	VehicleV2.file_experian_in + vehiclev2.File_Experian_Annual_Full;
dExperianFull			:=	dExperianAll(append_STATE_ORIGIN not in sValidExperianUpdatingExceptions);
dExperianME             :=  dExperianAll(append_STATE_ORIGIN='ME' and ((ut.max2((integer)ORG_REG_DT,ut.max2((integer)TITLE_TRANS_DT,(integer)ORG_TITLE_DT)) > 20030421) OR (ut.max2(ut.max2((integer)TITLE_TRANS_DT,(integer)ORG_TITLE_DT),(integer)ORG_TITLE_DT) < 19970430)));
dExperianWI             :=  dExperianAll(append_STATE_ORIGIN='WI' and ((integer)REG_RENEW_DT>20041203 or (integer)TITLE_TRANS_DT>20041203));

dExperianAllReady		:=	dExperianFull
						+	dExperianME
						+	dExperianWI					
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
 
string fFixbody1(string pString) := lib_stringlib.stringlib.stringfindreplace(pString,'|',' ');

string fFixbody2(string pString) := lib_stringlib.stringlib.stringfindreplace(pString,'~',' ');


unsigned4 fBestSeenDate(string8 pRegDate,string8 pTitleDate, string8 pProcessDate)
 :=
  function
	unsigned4	lRegDate			:=	(unsigned8)pRegDate;
	unsigned4	lTitleDate			:=	(unsigned8)pTitleDate;
	unsigned4	lProcessDate		:=	(unsigned8)pProcessDate;
	unsigned4	lReturnValue		:=	if(lRegDate <= lProcessDate and lRegDate <> 0,
											  lRegDate,
										 if(lTitleDate <= lProcessDate and lTitleDate <> 0,
											  lTitleDate,
											  0));
	return lReturnValue;
  end
 ;

VehicleV2.Layout_Experian_Updating_temp_module.Layout_Experian_Updating_as_VehicleV2	tExperianAsVehicleV2(dExperianAllReady pInput)
 :=
  transform
  
	self.state_origin				:=	pInput.append_STATE_ORIGIN;
	self.source_code				:=	'AE';
	self.dt_first_seen				:=	fBestSeenDate(fFixDate(pInput.REG_RENEW_DT),fFixDate(if(pInput.TITLE_TRANS_DT<>'',pInput.TITLE_TRANS_DT,pInput.ORG_TITLE_DT)),pInput.append_PROCESS_DATE);
    self.dt_last_seen				:=	fBestSeenDate(fFixDate(pInput.REG_RENEW_DT),fFixDate(if(pInput.TITLE_TRANS_DT<>'',pInput.TITLE_TRANS_DT,pInput.ORG_TITLE_DT)),pInput.append_PROCESS_DATE);
	self.dt_vendor_first_reported	:=	(unsigned8)pInput.append_PROCESS_DATE;
	self.dt_vendor_last_reported	:=	(unsigned8)pInput.append_PROCESS_DATE;
	self.ORIG_VIN					:=	pInput.VIN;
	self.YEAR_MAKE					:=	if((integer2)pInput.MODEL_YR = 0,
										   '',
										   if(pInput.MODEL_YR > '2020',
											  '19' + pInput.MODEL_YR[3..4],
											  Lib_StringLib.StringLib.stringfindreplace(pInput.MODEL_YR,' ','0')
											 )
										  );
	self.NET_WEIGHT					:=	if((integer2)pInput.WEIGHT = 0,
										   '',
										   trim((string)(integer4)pInput.WEIGHT,all)
										  );
	self.NUMBER_OF_AXLES			:=	if((integer2)pInput.AXLE_CNT = 0,
										   '',
										   trim((string)(integer4)pInput.AXLE_CNT,all)
										  );									  
	self.MAKE_CODE					:=	if(length(trim(pInput.make, left, right)) < 6, pInput.make, '');
	self.orig_make_desc     :=  if(length(trim(pInput.make, left, right)) > 5, pInput.make, '');
	self.MODEL						:=	pInput.model;
	self.series                     := pInput.series;
	self.MAJOR_COLOR_CODE			:=	pInput.PRIME_COLOR;
	self.MINOR_COLOR_CODE			:=	pInput.SECOND_COLOR;
	self.BODY_CODE					:=	if(length(trim(fFixbody2(fFixbody1(pInput.BODY_STYLE)), left, right)) < 6, fFixbody2(fFixbody1(pInput.BODY_STYLE)), '');
	self.orig_Body_Desc					:= if(length(trim(fFixbody2(fFixbody1(pInput.BODY_STYLE)), left, right)) > 5, fFixbody2(fFixbody1(pInput.BODY_STYLE)), '');
	self.VEHICLE_TYPE                  :=  pInput.VEHICLE_TYP;
	self.LICENSE_PLATE_NUMBERxBG4	   :=  pInput.PLATE_NBR;
	self.TRUE_LICENSE_PLSTE_NUMBER	   :=  pInput.PLATE_NBR;
	self.LICENSE_STATE                 :=  pInput.PLATE_STATE;
	self.PREVIOUS_LICENSE_STATE        :=  pInput.PREV_PLATE_STATE;
	self.PREVIOUS_LICENSE_PLATE_NUMBER := pInput.PREV_PLATE_NBR;
	self.REGISTRATION_EXPIRATION_DATE	:= if((unsigned8)fFixDate(pInput.REG_EXP_DT) > (unsigned8)fFixDate(pInput.REG_RENEW_DT), fFixDate(pInput.REG_EXP_DT), '');
	self.LICENSE_PLATE_CODE			:=	pInput.PLATE_TYP_CD;
	self.DECAL_NUMBER				:=	pInput.REG_DECAL_NBR;
	self.FIRST_REGISTRATION_DATE	:=	fFixDate(pInput.ORG_REG_DT);
	self.REGISTRATION_EFFECTIVE_DATE	:= if((unsigned8)fFixDate(pInput.REG_EXP_DT) > (unsigned8)fFixDate(pInput.REG_RENEW_DT), fFixDate(pInput.REG_RENEW_DT), '');
	self.TITLE_NUMBERxBG9			:=	pInput.TITLE_NBR;
	self.TITLE_ISSUE_DATE			:=	fFixDate(if(pInput.TITLE_TRANS_DT <> '',pInput.TITLE_TRANS_DT,pInput.ORG_TITLE_DT));
	self.PREVIOUS_TITLE_ISSUE_DATE	:=	fFixDate(if(pInput.ORG_TITLE_DT <> '' and pInput.ORG_TITLE_DT <> pInput.TITLE_TRANS_DT,pInput.ORG_TITLE_DT,''));
    self.orig_name_type             :=  pInput.name_typ_CD;
	self.orig_party_type            :=  if(pInput.OWNER_TYP_CD = lOwnerType_Person,'I','B');
	self.orig_name                  :=  (fFixOrigName(pInput.OWNER_TYP_CD,pInput.FIRST_NM,pInput.MIDDLE_NM,pInput.LAST_NM,pInput.NAME_SUFFIX,pInput.PROF_SUFFIX));
    boolean	lMCityBlank				:=	pInput.M_CITY = '';
	self.orig_ADDRESS			    :=	if(lMCityBlank,
											   trim(pInput.PHYS_RANGE) + trim(' ' + pInput.P_PRE_DIR) + trim(' ' + pInput.P_STREET) + trim(' ' + pInput.P_SUFFIX) + trim(' ' + pInput.P_POST_DIR) + trim(' ' + if(pInput.P_POB<>'','PO BOX ' + pInput.P_POB,'')) + trim(' ' + if(pInput.P_RR_NBR<>'','RR ' + pInput.P_RR_NBR,'')) + trim(' ' + if(pInput.P_RR_BOX<>'','BOX ' + pInput.P_RR_BOX,'')) + trim(' ' + pInput.P_SCNDRY_RNG) + trim(' ' + pInput.P_SCNDRY_DES),
											   trim(pInput.MAIL_RANGE) + trim(' ' + pInput.M_PRE_DIR) + trim(' ' + pInput.M_STREET) + trim(' ' + pInput.M_SUFFIX) + trim(' ' + pInput.M_POST_DIR) + trim(' ' + if(pInput.M_POB<>'','PO BOX ' + pInput.M_POB,'')) + trim(' ' + if(pInput.M_RR_NBR<>'','RR ' + pInput.M_RR_NBR,'')) + trim(' ' + if(pInput.M_RR_BOX<>'','BOX ' + pInput.M_RR_BOX,'')) + trim(' ' + pInput.M_SCNDRY_RNG) + trim(' ' + pInput.M_SCNDRY_DES)
	                    			   );
    self.orig_city					:=	if(lMCityBlank,
											   pInput.P_CITY,
											   pInput.M_CITY
											  );
	self.orig_STATE					:=	if(lMCityBlank,
											   pInput.P_State,
											   pInput.M_State
											  );
	self.orig_zip	                :=	if(lMCityBlank,
											   fFixZip(pInput.P_Zip5,pInput.P_Zip4),
											   fFixZip(pInput.M_Zip5,pInput.P_Zip5)
											  );
	self.orig_ssn                        :=      if(pInput.OWNER_TYP_CD = '1',pInput.IND_SSN,''); 
	self.orig_FEIN                       :=      if(pInput.OWNER_TYP_CD = '2',pInput.IND_SSN,''); 
	self.orig_DOB                        :=      if(pInput.OWNER_TYP_CD = '1',fFixDate(pInput.IND_DOB),'');
	self.orig_sex                        :=      '';
	self.orig_lien_date                  :=      '';
	self.history := '';						 
	self.title 		 :=      pInput.P_NAME[01..05];                                                                                                                      
    self.fname 		 :=      pInput.P_NAME[06..25];                                                                                                                      
    self.mname 		 :=      pInput.P_NAME[26..45];                                                                                                                      
    self.lname 		 :=      pInput.P_NAME[46..65];                                                                                                                      
    self.name_suffix :=      pInput.P_NAME[66..70];                                                                                                                      
    self.name_score	 :=      pInput.P_NAME[71..73]; 
    self.Append_Clean_cname			     :=      if(pInput.OWNER_TYP_CD = '2',self.orig_name,'');                                                                       
    self.prim_range  :=      if(lMCityBlank,pInput.P_CLEAN_ADDRESS[001..010],pInput.M_CLEAN_ADDRESS[001..010]);                                                                      
    self.predir	 :=      if(lMCityBlank,pInput.P_CLEAN_ADDRESS[011..012],pInput.M_CLEAN_ADDRESS[011..012]);                                                                      
    self.prim_name	 :=  if(lMCityBlank,pInput.P_CLEAN_ADDRESS[013..040],pInput.M_CLEAN_ADDRESS[013..040]);                                                                      
    self.addr_suffix :=  if(lMCityBlank,pInput.P_CLEAN_ADDRESS[041..044],pInput.M_CLEAN_ADDRESS[041..044]);                                                                      
    self.postdir	 :=  if(lMCityBlank,pInput.P_CLEAN_ADDRESS[045..046],pInput.M_CLEAN_ADDRESS[045..046]);                                                                      
    self.unit_desig  :=  if(lMCityBlank,pInput.P_CLEAN_ADDRESS[047..056],pInput.M_CLEAN_ADDRESS[047..056]);                                                                      
    self.sec_range	 :=  if(lMCityBlank,pInput.P_CLEAN_ADDRESS[057..064],pInput.M_CLEAN_ADDRESS[057..064]);                                                                      
    self.v_city_name :=	 if(lMCityBlank,pInput.P_CLEAN_ADDRESS[090..114],pInput.M_CLEAN_ADDRESS[090..114]);
    self.st		     :=	 if(lMCityBlank,pInput.P_CLEAN_ADDRESS[115..116],pInput.M_CLEAN_ADDRESS[115..116]);
    self.zip5		 :=	 if(lMCityBlank,pInput.P_CLEAN_ADDRESS[117..121],pInput.M_CLEAN_ADDRESS[117..121]);
    self.zip4		 :=	 if(lMCityBlank,pInput.P_CLEAN_ADDRESS[122..125],pInput.M_CLEAN_ADDRESS[122..125]);
    self.fips_state  :=	 if(lMCityBlank,pInput.P_CLEAN_ADDRESS[141..142],pInput.M_CLEAN_ADDRESS[141..142]);
    self.fips_county :=	 if(lMCityBlank,pInput.P_CLEAN_ADDRESS[143..145],pInput.M_CLEAN_ADDRESS[143..145]);
    self.geo_lat	 :=	 if(lMCityBlank,pInput.P_CLEAN_ADDRESS[146..155],pInput.M_CLEAN_ADDRESS[146..155]);
    self.geo_long	 :=	 if(lMCityBlank,pInput.P_CLEAN_ADDRESS[156..166],pInput.M_CLEAN_ADDRESS[156..166]);
    self.cbsa		 :=	 if(lMCityBlank,pInput.P_CLEAN_ADDRESS[167..170],pInput.M_CLEAN_ADDRESS[167..170]);
    self.geo_blk	 :=	 if(lMCityBlank,pInput.P_CLEAN_ADDRESS[171..177],pInput.M_CLEAN_ADDRESS[171..177]);
    self.geo_match	 :=	 if(lMCityBlank,pInput.P_CLEAN_ADDRESS[178..178],pInput.M_CLEAN_ADDRESS[178..178]);
    self.err_stat	   :=	 if(lMCityBlank,pInput.P_CLEAN_ADDRESS[179..182],pInput.M_CLEAN_ADDRESS[179..182]);
    self := pInput;
  end                                                                
 ;

combined_file			:=	project(dExperianAllReady, tExperianAsVehicleV2(left));

//rollup the raw data except process data and standardized fields 

combined_file_dist := distribute(combined_file, hash(state_origin, orig_vin));
dCombinedSort   := sort(combined_file_dist, 

state_origin                       
,ORIG_VIN                          
,YEAR_MAKE                         
,NET_WEIGHT                        
,NUMBER_OF_AXLES                   
,MAKE_CODE                         
,orig_make_desc                    
,MODEL                             
,series                            
,MAJOR_COLOR_CODE                  
,MINOR_COLOR_CODE                  
,BODY_CODE                         
,orig_Body_Desc                    
,VEHICLE_TYPE                      
,LICENSE_PLATE_NUMBERxBG4          
,TRUE_LICENSE_PLSTE_NUMBER         
,LICENSE_STATE                     
,PREVIOUS_LICENSE_STATE            
,PREVIOUS_LICENSE_PLATE_NUMBER     
,REGISTRATION_EXPIRATION_DATE      
,LICENSE_PLATE_CODE                
,DECAL_NUMBER                      
,FIRST_REGISTRATION_DATE           
,REGISTRATION_EFFECTIVE_DATE       
,TITLE_NUMBERxBG9                  
,TITLE_ISSUE_DATE                  
,PREVIOUS_TITLE_ISSUE_DATE         
,orig_name_type                    
,orig_party_type                   
,orig_name                         
,orig_ADDRESS                      
,orig_city                         
,orig_STATE                        
,orig_zip                          
,orig_ssn                          
,orig_FEIN                         
,orig_DOB
,fname 		                                                                
 ,mname 		                                                                    
    ,lname 		                                                                   
    ,name_suffix                                                                       	         
    ,Append_Clean_cname	                                           
    ,prim_range                                                                     
    ,predir	                                                                        
    ,prim_name	                                                          
    ,addr_suffix                                                         
    ,postdir	                                                    
    ,unit_desig                                                                
    ,sec_range                                                           
    ,v_city_name             
    ,st		         
    ,zip5
,-dt_vendor_last_reported, local);

typeof(dCombinedSort) tRollup(dCombinedSort L, dCombinedSort R) := transform


  self.dt_first_seen				    :=	ut.min2(L.dt_first_seen, R.dt_first_seen);
  self.dt_last_seen				      :=	ut.max2(L.dt_last_seen, R.dt_last_seen);
	self.dt_vendor_first_reported	:=	ut.min2(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
	self.dt_vendor_last_reported  :=  ut.max2(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
  self := L;
	
	end;
	
	
dcombinedRollup   := rollup(dCombinedSort, tRollup(left, right),
 
    state_origin		       	      
   ,ORIG_VIN			     
	,YEAR_MAKE			      				        				     
	,NET_WEIGHT			         				     
	,NUMBER_OF_AXLES		       				     
	,MAKE_CODE			     
	,orig_make_desc                  
	,MODEL			     
	,series                          
	,MAJOR_COLOR_CODE		     
	,MINOR_COLOR_CODE		     
	,BODY_CODE			     
	,orig_Body_Desc		     
	,VEHICLE_TYPE                    
	,LICENSE_PLATE_NUMBERxBG4	     
	,TRUE_LICENSE_PLSTE_NUMBER	     
	,LICENSE_STATE                   
	,PREVIOUS_LICENSE_STATE           
	,PREVIOUS_LICENSE_PLATE_NUMBER    
	,REGISTRATION_EXPIRATION_DATE     
	,LICENSE_PLATE_CODE		      
	,DECAL_NUMBER		      
	,FIRST_REGISTRATION_DATE          
	,REGISTRATION_EFFECTIVE_DATE      
	,TITLE_NUMBERxBG9		      
	,TITLE_ISSUE_DATE		      
	,PREVIOUS_TITLE_ISSUE_DATE	      
  ,orig_name_type                       
	,orig_party_type                  
	,orig_name                        
	,orig_ADDRESS		      
	,orig_city			       				      
	,orig_STATE			        			      
	,orig_zip	                 			      
	,orig_ssn                 
	,orig_FEIN                
	,orig_DOB                                         
  ,local);


export experian_updating_monthly_annual_rollup := dcombinedRollup; 

