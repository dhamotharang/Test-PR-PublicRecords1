import standard, ut, doxie, SANCTN_Mari, address, Lib_FileServices, lib_stringlib ; 

//** Incident Information(Submitter Information is not searchable or to be seen **
// ds_incident := distribute(SANCTN_Mari.files_SANCTN_did.clnIncident_did, hash(incident_num));
// ds_incident_common	:= distribute(SANCTN_Mari.files_SANCTN_common.incident_common,hash(incident_num));

ds_party	:= distribute(SANCTN_Mari.files_SANCTN_did.clnParty_DID,hash(incident_num));
ds_party_aka := distribute(SANCTN_Mari.files_SANCTN_common.party_aka_dba, hash(batch,incident_num, party_num));


// Creating Search File needed for creating AUTOKEYS
r0 := record
    unsigned6 did;
		unsigned6 bdid;
		unsigned6 aid;
		unsigned4 lookups;
		STRING10 	BATCH;
		STRING8 INCIDENT_NUM;
		STRING7	PARTY_NUM;
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
		string10  PHONE;
		string9   SSN_TIN;
		string11	SSN;
		string10	TIN;
		string5   SRCE_CD;
		STRING1		DBCODE;
		unsigned1 zero := 0;
		string1   blank:='';
		//CCPA-97 Per requirement, all in scope data needs to have a date when the data was collected
		STRING8 date_vendor_first_reported;
		STRING8 date_vendor_last_reported;
		//CCPA-97 Add 2 new fields for CCPA
		unsigned4 global_sid;
		unsigned8 record_sid;
end;


r0 transform_party(ds_party Linput) := transform
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
		//CCPA-97 
		self.date_vendor_first_reported := Linput.date_vendor_first_reported;
		self.date_vendor_last_reported := Linput.date_vendor_last_reported;
		self.global_sid := Linput.global_sid;
		self.record_sid := Linput.record_sid;

end;

s1 := dedup(project(ds_party,transform_party(left)),record,all,local);


r1 := record
	SANCTN_Mari.layouts_SANCTN_common.party_aka_dba;
	string5		title;
	string20 	fname;
	string20 	mname;
	string20 	lname;
	string5  	name_suffix;
	string3  	name_score;
	string100 cname;
	//CCPA-97 new fields for CCPA. However these fields are not in thor_data400::base::sanctn::np::party_aka_dba
	STRING8 date_vendor_first_reported:='';
	STRING8 date_vendor_last_reported:='';
end;


r1 	cln_Midexparty_AKA(ds_party_aka input)	:= TRANSFORM
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


r0 transform_party_aka(ds_CleanParsedAKA Linput) := transform
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
		//CCPA-97 
		self.date_vendor_first_reported := Linput.date_vendor_first_reported;
		self.date_vendor_last_reported := Linput.date_vendor_last_reported;
		self.global_sid := Linput.global_sid;
		self.record_sid := Linput.record_sid;
end;

s2 := dedup(project(ds_CleanParsedAKA,transform_party_aka(left)),record,all,local);


p1	:= s1 + s2;


export file_Midex_Searchautokey := p1;