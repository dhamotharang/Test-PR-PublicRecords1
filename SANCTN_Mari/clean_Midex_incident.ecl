//**Clean dates for the Non-Public and Freddie Mac incident dataset 

IMPORT SANCTN_Mari, Address, lib_stringlib, ut,Prof_License_Mari, std;


export clean_Midex_incident (string filedate) := function

//Non-Public dataset
dSANCTN_incident    := SANCTN_Mari.files_Midex_common_raw.NonPublicSanctnIncd;

dLayout_incident := RECORD
SANCTN_Mari.layout_NonPublic_incident_clean;
string70	source_doc_orig;
string17	source_ref_orig;
string45	member_name_orig;
string45	submitter_orig;
string100	address_orig;
string25	submitter_nick;
END;

dLayout_incident 		clean_Midex_incident(dSANCTN_incident input) := TRANSFORM
		trimSouceDoc			:= ut.CleanSpacesAndUpper(input.source_doc);
		trimSourceRef			:= ut.CleanSpacesAndUpper(input.source_ref);
		trimMemberName		:= ut.CleanSpacesAndUpper(input.member_name);
		trimSubmitterName := ut.CleanSpacesAndUpper(input.submitter);
		trimAddress				:= ut.CleanSpacesAndUpper(input.prop_address);
		
// Capture Nickname	
		prepSubmitter := StringLib.StringFindReplace(trimSubmitterName, '&AMP;','&');
		vNickSubmitter  := Prof_License_Mari.fGetNickname(prepSubmitter,'nick');
	
//Strim Nickname	
		StripNickSubmitter 	:= Prof_License_Mari.fGetNickname(prepSubmitter,'strip_nick');
		
		self.BILLING_CODE					:= ut.CleanSpacesAndUpper(input.billing_code);
	  self.JURISDICTION					:= ut.CleanSpacesAndUpper(input.JURISDICTION);
		self.agency								:= ut.CleanSpacesAndUpper(input.agency);
		self.source_doc						:= STD.Str.FindReplace(trimSouceDoc, '&AMP;','&');
		self.source_ref						:= STD.Str.FindReplace(trimSourceRef, '&AMP;','&');
		self.Addinf								:= ut.CleanSpacesAndUpper(input.addinf);
		self.Member_Name					:= STD.Str.FindReplace(trimMemberName, '&AMP;','&');
		self.Submitter						:= StripNickSubmitter;
		prepAddressAmp 						:= STD.Str.FindReplace(trimAddress, '&AMP;','&');
		prepAddressColon1 				:= STD.Str.FindReplace(prepAddressAmp, 'S:','');
		prepAddressColon2					:= STD.Str.FindReplace(prepAddressColon1, '#1:','');
		prepAddressColon3					:= STD.Str.FindReplace(prepAddressColon2, '#2:',';');
		self.prop_address 				:= STD.Str.CleanSpaces(prepAddressColon3);
		self.prop_city						:= ut.CleanSpacesAndUpper(input.prop_city);
		self.prop_state						:= ut.CleanSpacesAndUpper(input.prop_state);
		
		
// Convert the m/d/yy date to yyyymmdd
	 string8     fSlashedMDYtoCCYYMMDD(string pDateIn) := intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
                                                     + intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
									                 + intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

	 self.BATCHDATE					:= intformat((integer1)regexreplace('([0-9]+)/.*/.*',input.BATCHDATE,'$1'),2,1) + '/' + intformat((integer1)regexreplace('.*/([0-9]+)/.*',input.BATCHDATE,'$1'),2,1) + '/' + intformat((integer2)regexreplace('.*/.*/([0-9]+)',input.BATCHDATE,'$1'),4,1);
	 self.batch_date_clean	:= if(self.BATCHDATE = '00/00/0000','',fSlashedMDYtoCCYYMMDD(trim(self.BATCHDATE,left,right)));																	 
	 self.INCDT							:= intformat((integer1)regexreplace('([0-9]+)/.*/.*',input.INCDT,'$1'),2,1) + '/' + intformat((integer1)regexreplace('.*/([0-9]+)/.*',input.INCDT,'$1'),2,1) + '/' + intformat((integer2)regexreplace('.*/.*/([0-9]+)',input.INCDT,'$1'),4,1);
	 self.incident_date_clean	:= if(self.INCDT = '00/00/0000','',fSlashedMDYtoCCYYMMDD(trim(self.INCDT,left,right)));
	 self.ENTRY_DATE				:= intformat((integer1)regexreplace('([0-9]+)/.*/.*',input.ENTRY_DATE,'$1'),2,1) + '/' + intformat((integer1)regexreplace('.*/([0-9]+)/.*',input.ENTRY_DATE,'$1'),2,1) + '/' + intformat((integer2)regexreplace('.*/.*/([0-9]+)',input.ENTRY_DATE,'$1'),4,1);
	 self.entry_date_clean	:= if(self.ENTRY_DATE = '00/00/0000','',fSlashedMDYtoCCYYMMDD(trim(self.ENTRY_DATE,left,right)));
   self.MODIFY_DATE       := intformat((integer1)regexreplace('([0-9]+)/.*/.*',input.MODIFY_DATE,'$1'),2,1) + '/' + intformat((integer1)regexreplace('.*/([0-9]+)/.*',input.MODIFY_DATE,'$1'),2,1) + '/' + intformat((integer2)regexreplace('.*/.*/([0-9]+)',input.MODIFY_DATE,'$1'),4,1);
	 self.modified_date_clean := if(self.MODIFY_DATE = '00/00/0000','',fSlashedMDYtoCCYYMMDD(trim(self.MODIFY_DATE,left,right)));
	 self.cln_submit_phone  := ut.CleanPhone(input.submit_phone);
	 self.cln_submit_fax		:= ut.CleanPhone(input.SUBMIT_PHONE_FAX);
	 self.source_doc_orig		:= trimSouceDoc;
	 self.source_ref_orig		:= trimSourceRef;
	 self.member_name_orig	:= trimMemberName;
	 self.submitter_orig		:= trimSubmitterName;
	 self.address_orig			:= trimAddress;
	 self.submitter_nick		:= If(vNickSubmitter = '','',vNickSubmitter);
   self := input;
END;

clean_data := sort(PROJECT(dSANCTN_incident, clean_Midex_incident(LEFT)),BATCH,INCIDENT_NO);

output('NonPublic Incident data: ' + count(clean_data));

clean_data_deduped := output(dedup(clean_data,all),,SANCTN_Mari.cluster_name +'in::SANCTN::NP::midex_incident_cleaned',overwrite);
return sequential(clean_data_deduped);

end;