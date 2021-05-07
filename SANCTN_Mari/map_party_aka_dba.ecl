IMPORT SANCTN_Mari, Ut, lib_stringlib, std,PromoteSupers ;


EXPORT map_party_aka_dba (string filedate)	:= function

// Incident text dataset
ds_Party_aka_dba	:= SANCTN_Mari.files_Midex_common_raw.PartyAkaDba;

//Destination directory
SanctnDest		:= SANCTN_Mari.cluster_name +'base::SANCTN::NP::';


//Mapping text fields
SANCTN_Mari.layouts_SANCTN_common.PARTY_AKA_DBA 	mapPartyAkaDba(ds_Party_aka_dba L)  := TRANSFORM
		self.BATCH				:= L.BATCH;
		self.DBCODE				:= L.DBCODE;
		self.INCIDENT_NUM	:= (string)L.INCIDENT_NO;
		self.PARTY_NUM		:= L.NUMBER;
		self.NAME_TYPE		:= ut.CleanSpacesAndUpper(L.NAME_TYPE);
		self.FIRST_NAME		:= ut.CleanSpacesAndUpper(L.FIRST_NAME);
		self.MIDDLE_NAME	:= ut.CleanSpacesAndUpper(L.MIDDLE_NAME);
		self.LAST_NAME		:= ut.CleanSpacesAndUpper(L.LAST_NAME);
		self.AKA_DBA_TEXT	:= if(L.COMPANY != '',ut.CleanSpacesAndUpper(L.COMPANY), STD.Str.CleanSpaces(TRIM(self.FIRST_NAME +' '+ self.MIDDLE_NAME+' '+self.LAST_NAME)));
		self.PARTY_KEY		:= L.PARTYPK;
		self:=[];
		
END;

ds_Aka_Dba	:= project(ds_Party_aka_dba,mapPartyAkaDba(left));

PromoteSupers.MAC_SF_BuildProcess(ds_Aka_Dba, SanctnDest +'party_aka_dba', ds_aka_dba_out, 3, /*csvout*/false, /*compress*/false);
return sequential(ds_aka_dba_out);
end;
     