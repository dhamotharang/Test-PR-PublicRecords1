//The purpose of this process will be to map the Non-Public and FreddieMac common layout
//party data to the Sanction party dataset

IMPORT SANCTN_Mari, Ut, Address, Lib_FileServices, lib_stringlib,std;

export map_Midex_party_common	(string filedate)	:= function

//NonPublic party clean file 
Layout_PartyClean := RECORD
SANCTN_Mari.layout_NonPublic_party_clean;
string20 nickname;
STRING150 company_orig;
STRING45 	position_title_orig;
STRING150 employer_orig;
STRING50 	firstname_orig;
STRING50 	lastname_orig;
STRING50	middlename_orig;
string45	address_orig;
string60  stdPositionTtl;
end;

ds_party		:= dataset(SANCTN_Mari.cluster_name +'in::SANCTN::NP::midex_party_cleaned',Layout_PartyClean,flat);

SanctnDest	:= SANCTN_Mari.cluster_name +'out::SANCTN::NP::';

//Mapping Non-Public clean file to SANCTN_Party common layout
SANCTN_Mari.layouts_SANCTN_common.SANCTN_party_base clnPartyToCommon(Layout_PartyClean input)  := TRANSFORM
		self.BATCH						:= trim(STD.Str.ToUpperCase(input.BATCH));
		self.INCIDENT_NUM			:= (string) input.INCIDENT_NO;
		self.DBCODE						:= ut.CleanSpacesAndUpper(input.DBCODE);
		self.PARTY_NUM				:= trim(input.NUMBER);
		self.PARTY_KEY				:= input.PARTYPK;
		self.INT_KEY					:= input.INTPK;
		self.NAME_FIRST				:= input.FIRSTNAME;
		self.NAME_LAST				:= input.LASTNAME;
		self.NAME_MIDDLE			:= input.MIDDLENAME;
		self.SUFFIX						:= input.SUFFIX;
		self.PARTY_POSITION		:= input.stdPositionTtl;
		self.PARTY_EMPLOYER		:= input.EMPLOYER;
		self.PARTY_FIRM				:= input.COMPANY;
		self.SSN							:= input.ssn_clean;
		self.DOB							:= input.dob_clean;
		self.ADDRESS					:= input.ADDRESS;
		self.CITY							:= input.CITY;
		self.STATE						:= input.STATE;
		self.ZIP							:= trim(input.ZIP);
		self.TIN							:= input.tin_clean;
		self.SANCTIONS				:= trim(STD.Str.ToUpperCase(input.SANCTIONS));
		self.ADDITIONAL_INFO	:= trim(STD.Str.ToUpperCase(input.INFO));
		self.PARTY_TYPE				:= IF(input.number = '000', 'O','P');
		// self.LICENSE_NUM		:= trim(stringlib.StringToUpperCase(input.LICENSE_NO));
		self.NICKNAME					:= input.NICKNAME;
		self.PHONE						:= trim(input.PHONE);
		self.AKANAME					:= trim(STD.Str.ToUpperCase(input.AKANAME));
		self.DBANAME					:= trim(STD.Str.ToUpperCase(input.DBANAME));

		//CCPA-97 Initialize new fields
		self.date_vendor_first_reported := '';
		self.date_vendor_last_reported 	:= '';
		self.global_sid											 	:= 0;
		self.record_sid											 	:= 0;
		self := input;
		self:=[];

		// self := [];
END;

ds_NP_party	:= project(ds_party,clnPartyToCommon(left));

//keeps the old file layout by removing enh_did_src field
ds_NP_party_less := project(ds_NP_party, SANCTN_Mari.layouts_SANCTN_common.SANCTN_party_base-enh_did_src);

ds_NP_party_out	:= output(ds_NP_party_less,,SanctnDest+'midex_party_base',overwrite);
return sequential(ds_NP_party_out);
end;