import prte_csv, prte2_sanctn_np, data_services, sanctn_mari, std, ut,address;

EXPORT Files := module

//Incoming Files
export incident_in					:= dataset(constants.in_prefix_name + 'incident', prte2_sanctn_np.layouts.recIncident, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
export incidentcode_in			:= dataset(constants.in_prefix_name + 'incidentcode', prte2_sanctn_np.layouts.recCode, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
export incidenttext_in			:= dataset(constants.in_prefix_name + 'incidenttext', prte2_sanctn_np.layouts.recIncidentText, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
export party_in							:= dataset(constants.in_prefix_name + 'party',  prte2_sanctn_np.layouts.recParty, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
export partytext_in					:= dataset(constants.in_prefix_name + 'partytext', prte2_sanctn_np.layouts.recPartyText, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
export party_aka_dba_in			:= dataset(constants.in_prefix_name + 'party_aka_dba', prte2_sanctn_np.layouts.recPartyAkaDba, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));

//Base Files
export base_incident					:= dataset(constants.base_prefix_name + 'incident',layouts.incident_base,thor);
export base_incidentcode			:= dataset(constants.base_prefix_name +'incidentcode', layouts.incidentcode_base,thor);
export base_incidenttext			:= dataset(constants.base_prefix_name +'incidenttext', layouts.incidenttext_base,thor);
export base_party							:= dataset(constants.base_prefix_name +'party', layouts.party_base,thor);
export base_partytext					:= dataset(constants.base_prefix_name +'partytext', layouts.partytext_base,thor);
export base_party_aka_dba			:= dataset(constants.base_prefix_name +'party_aka_dba', layouts.party_aka_dba_base,thor);

// Key Files
export tbl_bdid 					:= project(base_party(BDID != 0), transform(layouts.bdid_key, self.incident_num := left.incident_num, self := left));	
export tbl_did 						:= project(base_party(did != 0), transform(layouts.did_key, self.incident_num := left.incident_num, self := left));	

export dsIncident					:= dedup(project(base_incident,transform(layouts.incident_key,self:=left)), record);
export dsIncidentCd 			:= project(base_incidentcode,transform(layouts.layout_Midex_cd,self:=left));																																				
export dsIncidentText 		:= project(base_incidenttext,transform(layouts.IncidentText_Key,self:=left));
export dsPartyText				:= project(base_partytext, transform(layouts.PartyText_key,self := left));

layouts.License_Key 	xformStateCD(base_incidentcode L)  := TRANSFORM
		self.incident_num 			:= L.incident_num,
		self.PARTY_NUM					:= L.NUMBER;
		self.LICENSE_NBR				:= trim(L.CODE_VALUE);
		filterInvalidChar 			:= STD.Str.Filter(STD.Str.ToUpperCase(L.CODE_STATE),'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
		self.LICENSE_STATE			:= if(L.CODE_VALUE[1..2] in constants.set_state_abbr and filterInvalidChar = '',L.CODE_VALUE[1..2],filterInvalidChar);
		self.LICENSE_TYPE				:= if(L.STD_TYPE_DESC != '', ut.CleanSpacesAndUpper(L.STD_TYPE_DESC),L.CODE_TYPE);
		self.CLN_LICENSE_NUMBER	:= L.CLN_LICENSE_NUMBER;
		self := L;
END;          

dsLicenseNbr := project(base_incidentcode(trim(FIELD_NAME) = 'LICENSECODE' AND CLN_LICENSE_NUMBER<>'' and (NOT REGEXFIND('NMLS',CODE_TYPE,NOCASE))),xformStateCD(left));	
dsLicenseNbr_dedup := dedup(dsLicenseNbr,RECORD);
export dsLicenseNbr_filter := dsLicenseNbr_dedup(CLN_LICENSE_NUMBER != '');


layouts.License_Midex_Key 	xformCODES(base_incidentcode L)  := TRANSFORM
		self.BATCH								:= L.BATCH;
		self.DBCODE								:= L.DBCODE;
		self.INCIDENT_NUM				  := L.INCIDENT_NUM;
		self.PARTY_NUM						:= L.NUMBER;
		self.FIELD_NAME						:= L.FIELD_NAME;  	// LICENSECODE OR PROFESSIONCODE
		self.LICENSE_TYPE					:= L.CODE_TYPE;
		self.CODE_VALUE						:= L.CODE_VALUE;
		
		filterInvalidChar := STD.Str.Filter(STD.Str.ToUpperCase(L.CODE_STATE),'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
		self.LICENSE_STATE				:= if(L.FIELD_NAME = 'LICENSECODE' AND L.CODE_VALUE[1..2] in constants.set_state_abbr and filterInvalidChar = '',L.CODE_VALUE[1..2],filterInvalidChar);
		self.STD_TYPE_DESC				:= L.STD_TYPE_DESC;
		self.CLN_LICENSE_NUMBER		:= L.CLN_LICENSE_NUMBER;
		selF.OTHER_DESC						:= L.OTHER_DESC;
		
		tmp_incident_number := ut.rmv_ld_zeros(l.INCIDENT_NUM);
		tmp_party_number := ut.rmv_ld_zeros(L.NUMBER);
		cln_party_number := if(trim(tmp_party_number) = '0','0',tmp_party_number);
		self.midex_rpt_nbr := STD.Str.CleanSpaces(trim(L.BATCH)+'-'
																							+ tmp_incident_number + if(cln_party_number <> '','-' ,'')
																							+ cln_party_number);
		self := L;
END;          
	
export dsLicenseNbr_midex 				:= dedup(project(base_incidentcode(trim(FIELD_NAME) != 'INTERNALCODE' AND CLN_LICENSE_NUMBER <>'' and  (NOT REGEXFIND('NMLS',CODE_TYPE,NOCASE))),xformCODES(left)), record);	


export dsPartyMidex := project(base_party(batch <> ''),transform(layouts.Party_Midex_Key,
																											self.party_key := (string)left.party_key;
																											tmp_incident_number := ut.rmv_ld_zeros(left.INCIDENT_NUM);
																											tmp_party_number := ut.rmv_ld_zeros(left.PARTY_NUM);
																											cln_party_number := if(trim(tmp_party_number) = '0','0',tmp_party_number);
																											self.midex_rpt_nbr := std.str.CleanSpaces(trim(left.BATCH) + '-'
																																																+ trim(tmp_incident_number) + if(cln_party_number <> '','-' ,'') 
																																																+ trim(cln_party_number));
																											self:=left));																																			


layouts.NMLS_ID_key populateNMLSId(base_incidentcode L)  := TRANSFORM
		SELF.incident_num 		:= L.incident_num,
		SELF.NMLS_ID				  := L.CLN_LICENSE_NUMBER;
		self.PARTY_NUM			  := L.NUMBER;
		filterInvalidChar 	  := STD.Str.Filter(STD.Str.ToUpperCase(L.CODE_STATE),'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
		self.LICENSE_STATE		:= if(L.CODE_VALUE[1..2] in constants.set_state_abbr and filterInvalidChar = '',L.CODE_VALUE[1..2],filterInvalidChar);
		self.LICENSE_TYPE			:= if(L.CODE_TYPE != '', L.CODE_TYPE, ut.CleanSpacesAndUpper(L.STD_TYPE_DESC));
		tmp_incident_number 	:= ut.rmv_ld_zeros(l.INCIDENT_NUM);
		tmp_party_number 			:= ut.rmv_ld_zeros(L.NUMBER);
	  cln_party_number 			:= if(trim(tmp_party_number) = '0','0',tmp_party_number);
	  self.MIDEX_RPT_NBR 		:= STD.Str.CleanSpaces(trim(L.BATCH)+'-' 
																								+ tmp_incident_number +if(cln_party_number <> '','-' ,'') 
																								+ cln_party_number);
		self := L;
		SELF := [];
END;          
	

dsLicenseNMLS := dedup(project(base_incidentcode(trim(FIELD_NAME) = 'LICENSECODE' AND CLN_LICENSE_NUMBER <>'' and REGEXFIND('NMLS',CODE_TYPE,NOCASE)),populateNMLSId(left)), record);	
// dsLicenseNMLS_dedup := dedup(dsLicenseNMLS ,RECORD);
export dsLicenseNMLS_filter := dsLicenseNMLS(NMLS_ID != '');


layouts.NMLS_MIDEX_Key 	xCODES(base_incidentcode L)  := TRANSFORM
		self.BATCH					:= L.BATCH;
		self.DBCODE					:= L.DBCODE;
		self.INCIDENT_NUM		:= L.INCIDENT_NUM;
		self.PARTY_NUM			:= L.NUMBER;
		self.FIELD_NAME			:= L.FIELD_NAME;  	// LICENSECODE OR PROFESSIONCODE
		self.LICENSE_TYPE		:= L.CODE_TYPE;
		self.CODE_VALUE			:= L.CODE_VALUE;
		
		filterInvalidChar := std.str.filter(std.str.touppercase(L.CODE_STATE),'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
		self.LICENSE_STATE	:= if(L.FIELD_NAME = 'LICENSECODE' AND L.CODE_VALUE[1..2] in constants.set_state_abbr and filterInvalidChar = '',L.CODE_VALUE[1..2],filterInvalidChar);
		self.STD_TYPE_DESC	:= L.STD_TYPE_DESC;
		self.NMLS_ID				:= L.CLN_LICENSE_NUMBER;
		selF.OTHER_DESC			:= L.OTHER_DESC;
		
		tmp_incident_number := ut.rmv_ld_zeros(l.INCIDENT_NUM);
		tmp_party_number 		:= ut.rmv_ld_zeros(L.NUMBER);
	  cln_party_number 		:= if(trim(tmp_party_number) = '0','0',tmp_party_number);
	  self.midex_rpt_nbr 	:= std.str.CleanSpaces(trim(L.BATCH)+'-' 
																							+ tmp_incident_number +if(cln_party_number <> '','-' ,'') 
																							+ cln_party_number);
		SELF := L;
		SELF := [];
END;          
	
export dsNMLS_MIDEX := dedup(project(base_incidentcode(trim(FIELD_NAME) != 'INTERNALCODE' AND CLN_LICENSE_NUMBER <>'' and REGEXFIND('NMLS',CODE_TYPE,NOCASE)),xCODES(left)), record);	


export dsParty := project(base_party(batch <> ''),transform(layouts.Party_Key,
																								self.BATCH 				:= trim(left.BATCH,left,right);
																								self.INCIDENT_NUM	:= trim(left.INCIDENT_NUM,left,right);
																								self.PARTY_NUM		:= trim(left.PARTY_NUM,left,right);
																								self:=left));


export dsPartySSN := dedup(project(base_party(SSN != ''),transform(layouts.SSN4_key,	self.ssn4 := LEFT.ssn[6..9];self      := LEFT; self :=[])), record);

export dsPartyTIN := dedup(project(base_party(TIN != ''),transform(layouts.TIN_Key, self:=left)), record);

export party_aka_dba_new	:= project(base_party_aka_dba, TRANSFORM(layouts.PARTY_AKA_DBA_Key, SELF := LEFT));																																			


//Autokeys
ds_party			:= base_party(batch <> '');
ds_party_aka 	:= base_party_aka_dba(batch <> '');

// Creating Search File needed for creating AUTOKEYS
layouts.autokeys 	transform_party(ds_party Linput) := transform
		self.DID			 		:= Linput.DID;
		self.BDID			 		:= Linput.BDID;
		self.AID					:= Linput.AID;
		self.LOOKUPS      := 0;
		self.BATCH				:= Linput.BATCH;
		self.INCIDENT_NUM	:= Linput.INCIDENT_NUM;
		self.PARTY_NUM		:= Linput.PARTY_NUM;
		self.NAME_FIRST		:= Linput.NAME_FIRST;
		self.NAME_LAST		:= Linput.NAME_LAST;
		self.NAME_MIDDLE	:= Linput.NAME_MIDDLE;
		self.SUFFIX				:= Linput.SUFFIX;
		self.PARTY_FIRM		:= Linput.PARTY_FIRM;
		self.ADDRESS			:= Linput.ADDRESS;
		self.CITY					:= Linput.CITY;
		self.STATE				:= Linput.STATE;
		self.ZIP					:= Linput.ZIP;		
    self.ADDR			 		:= Linput;
		self.name      		:= Linput;
		self.company	 		:= Linput.CNAME;
		self.addr     		:= [];
		self.DOB	 				:= Linput.DOB;
		self.PHONE				:= Linput.PHONE;
		self.SSN_TIN			:= IF(Linput.SSN != '',Linput.SSN,
													IF(Linput.TIN != '',Linput.TIN,''));
		self.SSN			:= Linput.SSN;
		self.TIN			:= Linput.TIN;
		self.DBCODE		:= Linput.DBCODE;
		self.SRCE_CD	:= '';
end;

s1 := dedup(project(ds_party,transform_party(left)),record,all,local);


layouts.autokeys2  cln_Midexparty_AKA(ds_party_aka input)	:= TRANSFORM
//Clean names
	 tempPName    		:= if(input.NAME_TYPE = 'A',Address.CleanPersonFML73(input.AKA_DBA_TEXT),'');
   CleanPName   		:= if(NOT((INTEGER)tempPName[71..73] < 80),trim(tempPName),'');
	 CleanCmpName  		:= if(input.NAME_TYPE = 'D',stringlib.StringToUpperCase(trim(input.AKA_DBA_TEXT)),'');
   self.title 	 		:= if(NOT((INTEGER)tempPName[71..73] < 80) AND tempPName <> '',CleanPName[1..5],'');
   self.fname 	 		:= if(NOT((INTEGER)tempPName[71..73] < 80) AND tempPName <> '',CleanPName[6..25],'');
   self.mname 	 		:= if(NOT((INTEGER)tempPName[71..73] < 80) AND tempPName <> '',CleanPName[26..45],'');
   self.lname 	 		:= if(NOT((INTEGER)tempPName[71..73] < 80) AND tempPName <> '',CleanPName[46..65],'');
   self.name_suffix := if(NOT((INTEGER)tempPName[71..73] < 80) AND tempPName <> '',CleanPName[66..70],'');
   self.name_score 	:= if(NOT((INTEGER)tempPName[71..73] < 80) AND tempPName <> '',CleanPName[71..73],'');
	 self.cname       := CleanCmpName;
   self  := input;
END;

ds_CleanParsedAKA	:= project(ds_party_aka,cln_Midexparty_AKA(left));


layouts.autokeys transform_party_aka(ds_CleanParsedAKA Linput) := transform
		self.DID			 		:= 0;
		self.BDID			 		:= 0;
		self.AID					:= 0;
		self.LOOKUPS      := 0;
		self.BATCH				:= Linput.BATCH;
		self.INCIDENT_NUM	:= Linput.INCIDENT_NUM;
		self.PARTY_NUM		:= Linput.PARTY_NUM;
		self.NAME_FIRST		:= Linput.FIRST_NAME;
		self.NAME_LAST		:= Linput.LAST_NAME;
		self.NAME_MIDDLE	:= Linput.MIDDLE_NAME;
		self.SUFFIX				:= '';
		self.PARTY_FIRM		:= '';
		self.ADDRESS			:= '';
		self.CITY					:= '';
		self.STATE				:= '';
		self.ZIP					:= '';		
    // self.ADDR			 		:= '';
		self.name      		:= Linput;
		self.company	 		:= Linput.CNAME;
		self.addr     		:= [];
		self.DOB	 				:= '';
		self.PHONE				:= '';
		self.SSN_TIN			:= '';
		self.SSN					:= '';
		self.TIN					:= '';
		self.DBCODE				:= Linput.DBCODE;
		self.SRCE_CD			:= '';
end;

s2 := dedup(project(ds_CleanParsedAKA,transform_party_aka(left)),record,all,local);

p1	:= s1 + s2;
export Searchautokey := p1;

end;