//The purpose of this mapping is to map in the Midex codes dataset to
//the Non-Public SANCTN common layout.

IMPORT SANCTN_Mari, Ut, lib_stringlib, Prof_License_Mari, codes,PromoteSupers;

export map_Midex_codes	(string filedate)	:= function

// Codes dataset
ds_MidexCd				:= SANCTN_Mari.files_Midex_common_raw.NonPublicSanctnCd;
TransLicTypeLkp 	:= Sanctn_Mari.files_Midex_common_raw.LicenseTypeLookup;
ProfessionCodeLkp := sanctn_mari.files_Midex_common_raw.ProfessionCodeLookup;
IncidentCodeLkp		:= sanctn_mari.files_Midex_common_raw.IncidentCodeLookup;
VerifyCodeLkp			:= sanctn_mari.files_Midex_common_raw.VerificationCodeLookup;

//Destination directory
SanctnDest				:= SANCTN_Mari.cluster_name +'base::SANCTN::NP::';

//Mapping code fields
SANCTN_Mari.layouts_SANCTN_common.Midex_cd			mapCds(ds_MidexCd L)  := TRANSFORM
		self.BATCH			:= L.BATCH;
		self.DBCODE			:= L.DBCODE;
		self.PRIMARY_KEY	:= L.PKID;
		self.FOREIGN_KEY	:= L.FKID;		
		self.INCIDENT_NUM	:= (string)L.INCIDENT_NO;
		self.NUMBER			:= L.NUMBER;
		self.FIELD_NAME	:= L.FIELDNAME;
		self.CODE_STATE	:= ut.CleanSpacesAndUpper(trim(L.CODESTATE,left,right));
		
		/* Adding Addl logic to handle skewed data*/
  	trimCodeValue := ut.CleanSpacesAndUpper(trim(L.CODEVALUE,left,right));
		trimOtherDesc := ut.CleanSpacesAndUpper(trim(L.OTHERDESC,left,right));
		trimCodeType	:= ut.CleanSpacesAndUpper(trim(L.CODETYPE,left,right));
	  
    set_desc := ['ONSIT','INSPE','VERIF','PROPE','AUTOM','INFOR','EMPLO','ON-SI','BANKR','PUBLI','ON SI','DRIVE','VISUA','WRITT','MULTI','OCCUP', 'PRD O'];
		set_partial := ['SITE','FIELD','CHECK','BANK','USPS'];
		set_other := ['OTH ','OTH-'];
		self.CODE_TYPE	:= trimCodeType;
		 														
		fixCodeValue := IF(trimCodeValue in set_desc,'',
															IF(TrimCodeValue in set_partial,'',
																	If(TrimCodeValue[1..4] in set_other, TrimCodeValue[1..3],
																			// IF(TrimCodeValue in ['CERT. APPR','CERTIFIED'],L.CODETYPE, 
																							trimCodeValue)));
																
																
	  fixOtherDesc :=	IF(trimCodeValue in set_desc, TrimCodeValue + TrimOtherDesc,
																IF(trimCodeValue in set_partial, TrimCodeValue + ' '+ TrimOtherDesc,
																		IF(trimCodeValue[1..4] in set_other and trimCodeValue[5] != '', TrimCodeValue[5] + TrimOtherDesc,
																					TrimOtherDesc)));
		
		
    tmpCodeValue := IF(L.CODETYPE= 'VERIFICATION' AND L.OTHERDESC != '',fixCodeValue,trimCodeValue);
		self.CODE_VALUE	:= IF(L.CODETYPE = 'INCIDENT' and tmpCodeValue != '',
														CASE(trim(tmpCodeValue),
																			'V0E05' => 'VOE05',
																			'AP08' => 'APP08',
																			'AP09' => 'APP09',
																			'AP99' => 'APP99',
																			'APPO5' => 'APP05',
																			'CRDO4' => 'CRD04',
																			'VOE5' => 'VOE05',
																			'VODI0' => 'VOD10',
																			tmpCodeValue),
																				tmpCodeValue);
																				
		self.OTHER_DESC	:= IF(L.CODETYPE= 'VERIFICATION' AND L.OTHERDESC != '',fixOtherDesc,trimOtherDesc);
		self.CLN_LICENSE_NUMBER := IF(self.CODE_VALUE in ['N/A','LICENSED','LBR','BANK'],'',
																	IF(self.CODE_VALUE = 'MU-NS-OM-A',self.CODE_VALUE,
																	IF(self.FIELD_NAME = 'LICENSECODE' AND regexfind('[0-9]',trim(self.CODE_TYPE)) and tmpCodeValue = ''
																					or TrimCodeValue in ['CERT. APPR','CERTIFIED'],
																								Prof_license_mari.fCleanLicenseNbr(self.CODE_TYPE),	
																	IF(self.FIELD_NAME = 'LICENSECODE', Prof_license_mari.fCleanLicenseNbr(self.CODE_VALUE),
																	''))));
		self.STD_TYPE_DESC := '';
		self:=[];
END;                   
		     
ds_Codes	:= project(ds_MidexCd,mapCds(left));

// Populate STD_TYPE_DESC field via translation
SANCTN_Mari.layouts_SANCTN_common.Midex_cd			trans_lic_type(ds_Codes L, TransLicTypeLkp R) := transform
	self.STD_TYPE_DESC :=  if(trim(L.CODE_VALUE) = 'CERT. APPR','CERTIFIED APPRAISER',
															if(trim(L.CODE_VALUE) = 'LBR','MORTGAGE LENDER BRANCH',
																			ut.CleanSpacesAndUpper(trim(R.license_description,left,right))));
	self := L;
end;

ds_type_trans := JOIN(ds_Codes, TransLicTypeLkp,
								      TRIM(left.CODE_TYPE,left,right)= ut.CleanSpacesAndUpper(TRIM(right.license_type,left,right))
											AND trim(left.FIELD_NAME,left,right) = 'LICENSECODE',
											trans_lic_type(left,right),left outer,lookup);
											
SANCTN_Mari.layouts_SANCTN_common.Midex_cd			trans_profession_code(ds_type_trans L, ProfessionCodeLkp R) := transform
	self.OTHER_DESC :=  IF(L.OTHER_DESC = '',ut.CleanSpacesAndUpper(trim(R.text,left,right)),L.OTHER_DESC);
	self := L;
end;

ds_prof_trans := JOIN(ds_type_trans, ProfessionCodeLkp,
								      TRIM(left.CODE_VALUE,left,right)= TRIM(right.code,left,right)
											AND trim(left.FIELD_NAME,left,right) = 'PROFESSIONCODE',
											trans_profession_code(left,right),left outer,lookup);
											
SANCTN_Mari.layouts_SANCTN_common.Midex_cd			trans_incident_code(ds_prof_trans L, IncidentCodeLkp R) := transform
	self.OTHER_DESC :=  IF(L.OTHER_DESC = '',ut.CleanSpacesAndUpper(trim(R.text,left,right)), L.OTHER_DESC);
	self := L;
end;

ds_incd_trans := JOIN(ds_prof_trans, IncidentCodeLkp,
								      TRIM(left.CODE_VALUE,left,right)= TRIM(right.code,left,right)
											AND trim(left.FIELD_NAME,left,right) = 'INTERNALCODE'
											AND trim(left.CODE_TYPE,left,right) = 'INCIDENT',
											trans_incident_code(left,right),left outer,lookup);											


SANCTN_Mari.layouts_SANCTN_common.Midex_cd trans_verify_code(ds_incd_trans L, VerifyCodeLkp R) := transform
	self.OTHER_DESC :=  IF(trim(L.CODE_VALUE) = 'OTH:','OTHER:',
													if(trim(L.CODE_VALUE) = 'PRD.','PUBLIC RECORDS(S)',
																IF(L.OTHER_DESC = '',ut.CleanSpacesAndUpper(trim(R.text,left,right)), L.OTHER_DESC)));
	//Blank out the state if it is not a valid state
	SELF.CODE_STATE := IF(codes.valid_st(L.CODE_STATE), L.CODE_STATE,'');
	self := L;
	
end;

ds_verf_trans := JOIN(ds_incd_trans, VerifyCodeLkp,
								      TRIM(left.CODE_VALUE,left,right)= TRIM(right.code,left,right)
											AND trim(left.FIELD_NAME,left,right) = 'INTERNALCODE'
											AND trim(left.CODE_TYPE,left,right) = 'VERIFICATION',
											trans_verify_code(left,right),left outer,lookup);
	
									
PromoteSupers.MAC_SF_BuildProcess(ds_verf_trans, SanctnDest+'incidentcode', ds_codes_out, 3, /*csvout*/false, /*compress*/false);

return sequential(ds_codes_out);
end;