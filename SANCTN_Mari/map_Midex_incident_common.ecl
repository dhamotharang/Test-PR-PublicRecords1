//The purpose of this process will be to map the Non-Public and FreddieMac common layout
//incident data to the Sanction incident dataset

IMPORT SANCTN_Mari, Ut, Lib_FileServices, Address, lib_stringlib;

export map_Midex_incident_common (string filedate) := function

//NonPublic incident clean files
dLayout_incident := RECORD
SANCTN_Mari.layout_NonPublic_incident_clean;
string70	source_doc_orig;
string17	source_ref_orig;
string45	member_name_orig;
string45	submitter_orig;
string100	address_orig;
string25	submitter_nick;
END;

ds_incident		:= dataset(SANCTN_Mari.cluster_name +'in::SANCTN::NP::midex_incident_cleaned',dLayout_incident,flat);

//Destination directory
SanctnDest		:= '~thor_data400::out::SANCTN::NP::';

//Mapping Freddie Mac clean file to SANCTN_Incident common layout
SANCTN_Mari.layouts_SANCTN_common.SANCTN_incident_base clnIncidentToCommon(dLayout_incident input)  := TRANSFORM
		self.BATCH							:= ut.CleanSpacesAndUpper(input.BATCH);
		self.BATCH_DATE					:= input.batch_date_clean;
		self.INCIDENT_NUM				:= (string)input.INCIDENT_NO;
		self.DBCODE							:= ut.CleanSpacesAndUpper(input.DBCODE);
		self.INT_KEY						:= input.INTPK;
		self.SRCE_CD						:= IF(trim(input.DBCODE) = 'N','S0901','S0900');
		self.AGENCY							:= input.AGENCY;
		self.MEMBER_NAME				:= input.MEMBER_NAME;
		self.SUBMITTER_NAME			:= input.SUBMITTER;
		self.SUBMITTER_NICKNAME := input.SUBMITTER_NICK;
		self.SUBMITTER_PHONE		:= input.cln_submit_phone;
		self.SUBMITTER_FAX			:= input.cln_submit_fax;
		self.SUBMITTER_EMAIL		:= input.submit_email;
		self.PROP_ADDR					:= input.PROP_ADDRESS;
		self.PROP_CITY					:= input.PROP_CITY;
		self.PROP_STATE					:= input.PROP_STATE;
		self.PROP_ZIP						:= trim(input.PROP_ZIP);
		self.SOURCE_REF					:= input.SOURCE_REF;
		self.ADDITIONAL_INFO		:= ut.CleanSpacesAndUpper(input.ADDINF);
		self.INCIDENT_DATE			:= input.incident_date_clean;
		self.MODIFIED_DATE			:= input.modified_date_clean;
		self.ENTRY_DATE					:= input.entry_date_clean;
		self.BILLING_CODE				:= input.billing_code;
		self.JURISDICTION				:= input.jurisdiction;
		self.CASE_NUM						:= ut.CleanSpacesAndUpper(input.case_number);
		self.SOURCE_DOC					:= input.source_doc;
		
		//CCPA-97 Initialize new fields
		self.date_vendor_first_reported := '';
		self.date_vendor_last_reported 	:= '';
		self.global_sid											 	:= 0;
		self.record_sid											 	:= 0;
		self.dt_effective_first:=0;
  		self.dt_effective_last:=0;
  		self.delta_ind := 0;
		self	:= input;
		self := [];
END;

ds_NP_incident	:= project(ds_incident,clnIncidentToCommon(left));

NP_incident_out	:= output(ds_NP_incident,,SanctnDest+'midex_incident_base',overwrite);
return sequential(NP_incident_out);
end;