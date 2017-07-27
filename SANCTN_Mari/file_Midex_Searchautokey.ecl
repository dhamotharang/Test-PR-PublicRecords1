import standard, ut, doxie, SANCTN_Mari; 


ds_incident := distribute(SANCTN_Mari.files_SANCTN_did.clnIncident_did, hash(incident_num));
ds_party	:= distribute(SANCTN_Mari.files_SANCTN_did.clnParty_DID,hash(incident_num));
ds_incident_common	:= distribute(SANCTN_Mari.files_SANCTN_common.incident_common,hash(incident_num));


// Creating Search File needed for creating AUTOKEYS
r0 := record
    unsigned6 did;
		unsigned6 bdid;
		unsigned6 aid;
		// unsigned6 record_id;
		// unsigned6 record_foreign;
		// string3 which_party;
		// string1 party_type;
		unsigned4 lookups;
		STRING10 	BATCH;
		STRING8 INCIDENT_NUM;
		STRING7	PARTY_NUM;
		// STRING8	INCIDENT_DATE;
		// STRING70	AGENCY;
		// STRING100	NAME_PARTY;
		STRING50	NAME_FIRST;
		STRING50	NAME_LAST;
		STRING50	NAME_MIDDLE;
		STRING10	SUFFIX;
		STRING150	PARTY_FIRM;
		STRING45	ADDRESS;
		STRING45	CITY;
		STRING2		STATE;
		STRING9		ZIP;
		standard.addr addr;
		standard.name name;
    string100 company;
		string8   DOB;
		string10  SUBMITTER_PHONE;
		string9   SSN_TIN;
		string11	SSN;
		string10	TIN;
		string5   SRCE_CD;
		STRING1		DBCODE;
		// STRING20 		LICENSE_NUM;
		// STRING80		LICENSE_TYPE;
		unsigned1 zero := 0;
		string1   blank:='';
end;


r0  transform_incident(ds_incident Linput) := transform
		self.DID		 	:= Linput.DID;
		self.BDID		  := Linput.BDID;
		self.AID			:= Linput.AID;
		// self.RECORD_ID	  	:= 0;
		// self.RECORD_FOREIGN := 0;
		// self.WHICH_PARTY		:= '';
		// self.PARTY_TYPE			:= 'I';
		self.LOOKUPS				:= 0;
		self.BATCH					:= Linput.BATCH;
		self.INCIDENT_NUM		:= Linput.INCIDENT_NUM;
		self.PARTY_NUM			:= '';
//not needed for Autokey
		// self.INCIDENT_DATE	:= Linput.INCIDENT_DATE;	
		// self.AGENCY					:= Linput.AGENCY;				
		// self.NAME_PARTY			:= '';
		self.NAME_FIRST			:= '';
		self.NAME_LAST			:= '';
		self.NAME_MIDDLE		:= '';
		self.SUFFIX					:= '';
		self.PARTY_FIRM			:= '';
		self.ADDRESS				:= Linput.PROP_ADDR;
		self.CITY						:= Linput.PROP_CITY;
		self.STATE					:= Linput.PROP_STATE;
		self.ZIP						:= Linput.PROP_ZIP;
		self.ADDR						:= Linput;
		self.NAME						:= Linput;
		self.COMPANY				:= Linput.CNAME;
// 	self.name.name_score := '';
		self.addr          	:= [];
		self.DOB	:= '';
		self.SUBMITTER_PHONE	:= Linput.SUBMITTER_PHONE;
		self.SSN_TIN	:= '';
		self.SSN			:= '';
		self.TIN			:= '';
		self.DBCODE		:= Linput.DBCODE;
		// self.LICENSE_NUM := '';
		// self.LICENSE_TYPE := '';
		self.SRCE_CD	:= Linput.SRCE_CD;
		self          := Linput;
end;

s1 := dedup(project(ds_incident,transform_incident(left)),record,all,local);


r0 transform_party(ds_party Linput) := transform
		self.DID			 			:= Linput.DID;
		self.BDID			 			:= Linput.BDID;
		self.AID						:= Linput.AID;
		// self.RECORD_ID			:= 0;
		// self.RECORD_FOREIGN  := 0;
		// self.WHICH_PARTY  := '';
		// self.PARTY_TYPE 	:= 'P';
		self.LOOKUPS      := 0;
		self.BATCH				:= Linput.BATCH;
		self.INCIDENT_NUM	:= Linput.INCIDENT_NUM;
		self.PARTY_NUM		:= Linput.PARTY_NUM;
//not needed for Autokey
//		self.INCIDENT_DATE	:= '';
//		self.AGENCY					:= '';
		// self.NAME_PARTY			:= Linput.NAME_PARTY;
		self.NAME_FIRST			:= Linput.NAME_FIRST;
		self.NAME_LAST			:= Linput.NAME_LAST;
		self.NAME_MIDDLE		:= Linput.NAME_MIDDLE;
		self.SUFFIX					:= Linput.SUFFIX;
		self.PARTY_FIRM			:= Linput.PARTY_FIRM;
		self.ADDRESS				:= Linput.ADDRESS;
		self.CITY						:= Linput.CITY;
		self.STATE					:= Linput.STATE;
		self.ZIP						:= Linput.ZIP;		
    self.ADDR			 		:= Linput;
		self.name      		:= Linput;
		self.company	 		:= Linput.CNAME;
//	self.name.name_score := '';
		self.addr     		:= [];
		self.DOB	 				:= Linput.DOB;
		self.SUBMITTER_PHONE	 := '';
		self.SSN_TIN			:= IF(Linput.SSN != '',Linput.SSN,
													IF(Linput.TIN != '',Linput.TIN,''));
		self.SSN			:= Linput.SSN;
		self.TIN			:= Linput.TIN;
		self.DBCODE		:= Linput.DBCODE;
		// self.LICENSE_NUM := Linput.LICENSE_NUM;
		// self.LICENSE_TYPE := Linput.LICENSE_TYPE;
		self.SRCE_CD	:= '';
end;

s2 := dedup(project(ds_party,transform_party(left)),record,all,local);

//Join incident and party to populate incident_date and srce_cd for party
r0	trans_incidentdate_party(s2 Linput, ds_incident_common Rinput)	:= transform
//		self.INCIDENT_DATE	:= Rinput.INCIDENT_DATE;
		self.SRCE_CD	:= Rinput.SRCE_CD;
		self	:= Linput;
end;

j_s2	:= join(s2, ds_incident_common,
							trim(left.INCIDENT_NUM,left,right) = trim(right.INCIDENT_NUM,left,right),
							trans_incidentdate_party(left,right),left outer,local);

p1	:= s1 + j_s2;

export file_Midex_Searchautokey := p1;