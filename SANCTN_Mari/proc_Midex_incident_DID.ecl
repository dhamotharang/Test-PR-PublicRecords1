IMPORT SANCTN_Mari,ut,Lib_FileServices,lib_stringlib,Lib_date,Standard,Address,AID,DID_Add,Business_Header_SS,Business_Header,Header_SlimSort,
				Watchdog,mdr,header,PromoteSupers,BIPV2;
		 
export proc_Midex_incident_DID(string filedate) := function
		 
dsIncidentBase	:= SANCTN_Mari.files_SANCTN_did.incident_aid;


SANCTN_Mari.layouts_SANCTN_common.SANCTN_incident_did cln_MidexIncident(dsIncidentBase input)	:= TRANSFORM
		//Clean names
	 is_company   := SANCTN_Mari.func_is_company(input.SUBMITTER_NAME);
   CmpName      := SANCTN_Mari.func_is_company(input.AGENCY);
   
   tempSName    := if(is_company,'',Address.CleanPersonFML73(input.SUBMITTER_NAME));
   tempAgency  	:= if(CmpName,'',Address.CleanPersonFML73(input.AGENCY));
	 
   CleanSName   := if(NOT(is_company) AND NOT((INTEGER)tempSName[71..73] < 80)
                     ,trim(tempSName)
					 ,'');
   CleanAgency 	:= if(NOT(CmpName) AND NOT((INTEGER)tempAgency[71..73] < 80)
                     ,trim(tempAgency)
					 ,'');
   CleanCName   := if(is_company OR (INTEGER)tempSName[71..73] < 80
                     ,stringlib.StringToUpperCase(trim(input.SUBMITTER_NAME))
					 ,'');
   CleanCmpName := if( CmpName AND NOT(is_company),stringlib.StringToUpperCase(trim(input.AGENCY)),'');
 
	 self.title 		:= if(NOT(is_company) AND NOT((INTEGER)tempSName[71..73] < 80) AND input.SUBMITTER_NAME <> '',CleanSName[1..5],CleanAgency[1..5]);
   self.fname 				:= if(NOT(is_company) AND NOT((INTEGER)tempSName[71..73] < 80) AND input.SUBMITTER_NAME <> '',CleanSName[6..25],CleanAgency[6..25]);
   self.mname 				:= if(NOT(is_company) AND NOT((INTEGER)tempSName[71..73] < 80) AND input.SUBMITTER_NAME <> '',CleanSName[26..45],CleanAgency[26..45]);
   self.lname 				:= if(NOT(is_company) AND NOT((INTEGER)tempSName[71..73] < 80) AND input.SUBMITTER_NAME <> '',CleanSName[46..65],CleanAgency[46..65]);
   self.name_suffix 	:= if(NOT(is_company) AND NOT((INTEGER)tempSName[71..73] < 80) AND input.SUBMITTER_NAME <> '',CleanSName[66..70],CleanAgency[66..70]);
   self.name_score 		:= if(NOT(is_company) AND NOT((INTEGER)tempSName[71..73] < 80) AND input.SUBMITTER_NAME <> '',CleanSName[71..73],CleanAgency[71..73]); 
   self.cname         := if( is_company ,CleanCName,CleanCmpName);
		//CCPA-97 Initialize new fields
		self.date_vendor_first_reported := '';
		self.date_vendor_last_reported 	:= '';
		self.global_sid											 	:= 0;
		self.record_sid											 	:= 0;
   self  := input;
END;

ds_CleanParsedGood	:= project(dsIncidentBase,cln_MidexIncident(left));

//DID Incident if name is individual and not company
// 'A'= Address, 'P'= Phone, 'Q' = Address match excluding the fuzzy logic., 'Z' = zip code matching 
did_matchset  := ['A','P','Q','Z'];
DID_Add.MAC_Match_Flex(ds_CleanParsedGood, did_matchset,
											'', '', fname, mname, lname, name_suffix,
											prim_range, prim_name, sec_range, zip5, st,
											SUBMITTER_PHONE, DID, SANCTN_Mari.layouts_SANCTN_common.SANCTN_incident_did, true, 
										    DID_SCORE, //these should default to zero in definition
										    75,        //dids with a score below here will be dropped
											dsIncidentIndv);

incident_did := dsIncidentIndv : persist('~thor_data400::persist::sanctn:np::incident_did');											


//Hash on full raw data fields to make source_rec_id persistent
SANCTN_Mari.layouts_SANCTN_common.SANCTN_incident_bip addSourceRecId(dsIncidentIndv input)	:= TRANSFORM
	 self.source_rec_id	:= (unsigned8) (hash64(
													 input.BATCH
													,input.BATCH_DATE
													,input.DBCODE
													,input.INCIDENT_NUM
													,input.INCIDENT_DATE
													,input.INT_KEY
													,input.BILLING_CODE
													,input.CASE_NUM
													,input.JURISDICTION
													,input.AGENCY
													,input.SOURCE_DOC
													,input.SOURCE_REF
													,input.ADDITIONAL_INFO
													,input.MODIFIED_DATE
													,input.ENTRY_DATE
													,input.MEMBER_NAME
													,input.SUBMITTER_NAME
													,input.SUBMITTER_NICKNAME
													,input.SUBMITTER_PHONE
													,input.SUBMITTER_FAX
													,input.SUBMITTER_EMAIL
													,input.PROP_ADDR
													,input.PROP_CITY
													,input.PROP_STATE
													,input.PROP_ZIP));												
		self  						:= input;
END;   

dsIncidentSrcId := PROJECT(dsIncidentIndv, addSourceRecId(LEFT));

bdid_matchset  := ['N'];
Business_Header_SS.MAC_Match_Flex(dsIncidentSrcId, bdid_matchset,
																	cname, prim_range, prim_name, zip5, sec_range, st,
																	SUBMITTER_PHONE, '', BDID, SANCTN_Mari.layouts_SANCTN_common.SANCTN_incident_bip, true, 
																	BDID_SCORE, 							//these should default to zero in definition
																	dsIncidentComp
																	,													// keep count
																	,													// default threshold
																	,													// use prod version of superfiles
																	,													// default is to hit prod from dataland, and on prod hit prod.		
																	,BIPV2.xlink_version_set	// create BIP keys only
																	,													// url
																	,													// email 
																	,p_city_name							// city
																	,fname										// fname
																	,mname										// mname
																	,lname										// lname
																	,													// contact ssn
																	,													// source
																	,source_rec_id						// source_record_id
																	,false									  // if mac_Source_Match appears exists before flex macro
																	);

dsBaseIncident			:= project(dsIncidentComp, TRANSFORM(SANCTN_Mari.layouts_SANCTN_common.SANCTN_incident_base, self := left));
dsCleanIncidentDid	:= project(dsIncidentComp, TRANSFORM(SANCTN_Mari.layouts_SANCTN_common.SANCTN_incident_did, self := left));

PromoteSupers.MAC_SF_BuildProcess(dsIncidentComp, SANCTN_Mari.cluster_name +'base::SANCTN::NP::incident_bip', base_incident_out_bip, 3, /*csvout*/false, /*compress*/false);
PromoteSupers.MAC_SF_BuildProcess(dsBaseIncident, SANCTN_Mari.cluster_name +'base::SANCTN::NP::incident', base_incident_out, 3, /*csvout*/false, /*compress*/false);
incident_did_out		:= output(dsCleanIncidentDid,,SANCTN_Mari.cluster_name +'out::SANCTN::NP::cln_incident_did',overwrite);

retval	:= sequential(base_incident_out_bip,incident_did_out,base_incident_out);

return retval;

end;