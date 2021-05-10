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


layout_nmls_id := record
	f_sanctn_incidentcode.BATCH;
	f_sanctn_incidentcode.INCIDENT_NUM;
	STRING7 	PARTY_NUM;
	//STRING20 	LICENSE_NBR;
	STRING2  	LICENSE_STATE;
	STRING80 	LICENSE_TYPE;
	//f_sanctn_incidentcode.CLN_LICENSE_NUMBER;
	STRING20 		NMLS_ID;
	//STRING50 		NMLS_ID_TYPE;
	STRING26 		MIDEX_RPT_NBR;
end;

layout_nmls_id populateNMLSId(f_sanctn_incidentcode L)  := TRANSFORM
		SELF.NMLS_ID						:= L.CLN_LICENSE_NUMBER;
		//SELF.NMLS_ID_TYPE				:= 'NMLS ID';
		self.PARTY_NUM					:= L.NUMBER;
		filterInvalidChar 			:= stringlib.stringfilter(stringlib.stringtouppercase(L.CODE_STATE),'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
		self.LICENSE_STATE			:= if(L.CODE_VALUE[1..2] in set_state_abbr and filterInvalidChar = '',L.CODE_VALUE[1..2],filterInvalidChar);
		//For NMLS records, use code_type as license_type
		//self.LICENSE_TYPE				:= if(L.STD_TYPE_DESC != '', ut.fnTrim2Upper(L.STD_TYPE_DESC),L.CODE_TYPE);
		self.LICENSE_TYPE				:= if(L.CODE_TYPE != '', L.CODE_TYPE, ut.fnTrim2Upper(L.STD_TYPE_DESC));
		tmp_incident_number 		:= ut.rmv_ld_zeros(l.INCIDENT_NUM);
		tmp_party_number 				:= ut.rmv_ld_zeros(L.NUMBER);
	  cln_party_number 				:= if(trim(tmp_party_number) = '0','',tmp_party_number);
	  self.MIDEX_RPT_NBR 			:= StringLib.StringCleanSpaces(trim(L.BATCH)+'-' 
																														+ tmp_incident_number +'-' 
																														+ cln_party_number);
		self := L;
		SELF := [];
END;          
	
//Modified to include NMLS records only 10/21/13	
dsLicenseNbr := project(f_sanctn_incidentcode(REGEXFIND('NMLS',CODE_TYPE,NOCASE)),populateNMLSId(left));	
dsLicenseNbr_dedup := dedup(dsLicenseNbr ,RECORD);
dsLicenseNbr_filter := dsLicenseNbr_dedup(NMLS_ID != '');
		
export key_nmls_id  := index(dsLicenseNbr_filter
																	, {NMLS_ID}
																	,{dsLicenseNbr_filter}
																	,Data_Services.Data_Location.Prefix('sanctn')+ Keyname + doxie.Version_SuperKey +'::nmls_id');
																	
																	
											
																	
