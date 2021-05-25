import doxie_files, doxie,ut,sanctn_mari,Data_Services;	

f_sanctn_incidentcode :=	SANCTN_Mari.files_SANCTN_common.incident_codes(trim(FIELD_NAME) != 'INTERNALCODE' AND CLN_LICENSE_NUMBER<>'');

KeyName 			:= 'thor_data400::key::sanctn::np::';

set_state_abbr := ['AL','AK','AS','AZ','AR','CA','CO','CT','DE','DC',
										'FM','FL','GA','GU','HI','ID','IL','IN','IA','KS',
										'KY','LA','ME','MH','MD','MA','MI','MN','MS','MO',
										'MT','NE','NV','NH','NJ','NM','NY','NC','ND','MP',
										'OH','OK','OR','PW','PA','PR','RI','SC','SD','TN',
										'TX','UT','VT','VI','VA','WA','WV','WI','WY','AE',
										'AA','AP'];


slim_License_NBR := record
	STRING8		BATCH;
	STRING1	 	DBCODE;
	STRING8		INCIDENT_NUM;
	STRING7		PARTY_NUM;
	STRING20	FIELD_NAME;
	STRING20	LICENSE_TYPE;
	STRING20	CODE_VALUE;
	STRING2		LICENSE_STATE;
	STRING500	OTHER_DESC;
	STRING80  STD_TYPE_DESC;   	
	//STRING20	CLN_LICENSE_NUMBER;
	STRING20	NMLS_ID;
	//STRING50 	NMLS_ID_TYPE;
	STRING26 	MIDEX_RPT_NBR;
end;

slim_license_nbr xformCODES(f_sanctn_incidentcode L)  := TRANSFORM
		self.BATCH								:= L.BATCH;
		self.DBCODE								:= L.DBCODE;
		self.INCIDENT_NUM				  := L.INCIDENT_NUM;
		self.PARTY_NUM						:= L.NUMBER;
		self.FIELD_NAME						:= L.FIELD_NAME;  	// LICENSECODE OR PROFESSIONCODE
		self.LICENSE_TYPE					:= L.CODE_TYPE;
		self.CODE_VALUE						:= L.CODE_VALUE;
		
		filterInvalidChar := stringlib.stringfilter(stringlib.stringtouppercase(L.CODE_STATE),'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
		self.LICENSE_STATE				:= if(L.FIELD_NAME = 'LICENSECODE' AND L.CODE_VALUE[1..2] in set_state_abbr and filterInvalidChar = '',L.CODE_VALUE[1..2],filterInvalidChar);
		self.STD_TYPE_DESC				:= L.STD_TYPE_DESC;
		//self.CLN_LICENSE_NUMBER		:= L.CLN_LICENSE_NUMBER;
		self.NMLS_ID							:= L.CLN_LICENSE_NUMBER;
		//SELF.NMLS_ID_TYPE					:= 'NMLS ID';
		selF.OTHER_DESC						:= L.OTHER_DESC;
		
		tmp_incident_number := ut.rmv_ld_zeros(l.INCIDENT_NUM);
		tmp_party_number := ut.rmv_ld_zeros(L.NUMBER);
	  cln_party_number := if(trim(tmp_party_number) = '0','',tmp_party_number);
	  self.midex_rpt_nbr := StringLib.StringCleanSpaces(trim(L.BATCH)+'-' 
																														+ tmp_incident_number +'-' 
																														+ cln_party_number);
		SELF := L;
		SELF := [];
END;          
	
dsLicenseNbr := project(f_sanctn_incidentcode(REGEXFIND('NMLS',CODE_TYPE,NOCASE)),xformCODES(left));	
dsLicenseNbr_dedup := dedup(dsLicenseNbr ,RECORD);
		
export key_nmls_midex  := index(dsLicenseNbr_dedup
																	, {midex_rpt_nbr}
																	,{dsLicenseNbr_dedup}
																	,Data_Services.Data_Location.Prefix('sanctn')+ Keyname + doxie.Version_SuperKey +'::nmls_midex');
																	