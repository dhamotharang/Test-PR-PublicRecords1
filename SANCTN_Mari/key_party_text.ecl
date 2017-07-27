import doxie_files, doxie,ut,sanctn_mari,Data_Services;

f_sanctn_partytext :=	SANCTN_Mari.files_SANCTN_common.party_text;
// layout_party_text	:=sanctn_mari.layouts_SANCTN_common.SANCTN_party_text;

KeyName 			:= 'thor_data400::key::sanctn::np::';

// dsPartyText := project(f_sanctn_partytext,transform(layout_party_text,self:=left));

export key_party_text := index(f_sanctn_partytext
																	,{BATCH, INCIDENT_NUM, PARTY_NUM}
																	,{f_sanctn_partytext}
																	,Data_Services.Data_Location.Prefix('sanctn')+ KeyName +doxie.Version_SuperKey+ '::partytext');
																	
