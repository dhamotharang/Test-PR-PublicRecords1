import doxie_files, doxie,ut,sanctn_mari,Data_Services;	

f_sanctn_incidentcode :=	SANCTN_Mari.files_SANCTN_common.incident_codes(trim(FIELD_NAME) = 'LICENSECODE' AND CLN_LICENSE_NUMBER<>'');

KeyName 			:= 'thor_data400::key::sanctn::np::';

set_state_abbr := ['AL','AK','AS','AZ','AR','CA','CO','CT','DE','DC',
										'FM','FL','GA','GU','HI','ID','IL','IN','IA','KS',
										'KY','LA','ME','MH','MD','MA','MI','MN','MS','MO',
										'MT','NE','NV','NH','NJ','NM','NY','NC','ND','MP',
										'OH','OK','OR','PW','PA','PR','RI','SC','SD','TN',
										'TX','UT','VT','VI','VA','WA','WV','WI','WY','AE',
										'AA','AP'];


slim_License_NBR := record
f_sanctn_incidentcode.BATCH;
f_sanctn_incidentcode.INCIDENT_NUM;
STRING7 	PARTY_NUM;
STRING20 	LICENSE_NBR;
STRING2  	LICENSE_STATE;
STRING80 	LICENSE_TYPE;
f_sanctn_incidentcode.CLN_LICENSE_NUMBER;
end;

slim_license_nbr xformStateCD(f_sanctn_incidentcode L)  := TRANSFORM
		self.PARTY_NUM					:= L.NUMBER;
		self.LICENSE_NBR				:= trim(L.CODE_VALUE);
		filterInvalidChar := stringlib.stringfilter(stringlib.stringtouppercase(L.CODE_STATE),'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
		self.LICENSE_STATE			:= if(L.CODE_VALUE[1..2] in set_state_abbr and filterInvalidChar = '',L.CODE_VALUE[1..2],filterInvalidChar);
		self.LICENSE_TYPE				:= if(L.STD_TYPE_DESC != '', ut.fnTrim2Upper(L.STD_TYPE_DESC),L.CODE_TYPE);
		self.CLN_LICENSE_NUMBER	:= L.CLN_LICENSE_NUMBER;
		self := L;
END;          

//Drop NMLS records 10/21/13	
dsLicenseNbr := project(f_sanctn_incidentcode(NOT REGEXFIND('NMLS',CODE_TYPE,NOCASE)),xformStateCD(left));	

dsLicenseNbr_dedup := dedup(dsLicenseNbr,RECORD);
dsLicenseNbr_filter := dsLicenseNbr_dedup(CLN_LICENSE_NUMBER != '');
		
export key_License_NBR  := index(dsLicenseNbr_filter
																	, {CLN_LICENSE_NUMBER,LICENSE_STATE}
																	,{dsLicenseNbr_filter}
																	,Data_Services.Data_Location.Prefix('sanctn')+ Keyname + doxie.Version_SuperKey +'::license_nbr');
																	
																	
											
																	
																
