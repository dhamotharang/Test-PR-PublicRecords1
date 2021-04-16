//The purpose of this mapping is to map in the Midex Party text dataset to
//the Non-Public SANCTN common layout.

IMPORT SANCTN_Mari, Ut, lib_stringlib,std,PromoteSupers;
EXPORT map_party_text (string filedate)	:= function

// Incident text dataset
ds_PartyTxt	:= SANCTN_Mari.files_Midex_common_raw.PartyText;

//Destination directory
SanctnDest		:= SANCTN_Mari.cluster_name +'base::SANCTN::NP::';

//Mapping text fields
SANCTN_Mari.layouts_SANCTN_common.SANCTN_party_text mapPartyTxt(ds_PartyTxt L)  := TRANSFORM
		self.BATCH				:= L.BATCH;
		self.DBCODE				:= L.DBCODE;
		self.INCIDENT_NUM	:= (string)L.INCIDENT_NO;
		self.PARTY_NUM		:= L.NUMBER;
		self.SEQ					:= L.SEQ;
		self.FIELD_NAME		:= ut.CleanSpacesAndUpper(L.FIELDNAME);
		
		TrimText := ut.CleanSpacesAndUpper(L.TXT);
		replace_tilde := STD.Str.FindReplace(TrimText,'~','\r');
		self.FIELD_TXT		:= STD.Str.FindReplace(replace_tilde, '&AMP;','&');
		self:=[];
		
END;

ds_Text	:= project(ds_PartyTxt,mapPartyTxt(left));


PromoteSupers.MAC_SF_BuildProcess(ds_Text, SanctnDest +'partytext', ds_text_out, 3, /*csvout*/false, /*compress*/false);
return sequential(ds_text_out);
end;
     