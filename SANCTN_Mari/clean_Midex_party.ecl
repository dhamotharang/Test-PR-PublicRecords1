//**Clean dates and SSN/TIN for the Non-Public and Freddie Mac party dataset 

IMPORT SANCTN_Mari, Address, lib_stringlib, ut, prof_license_mari,std;

export clean_Midex_party(string filedate) := function

//Non-Public party dataset
dSANCTN_party  := SANCTN_Mari.files_Midex_common_raw.NonPublicSanctnParty;
dPositionLkp	 := sanctn_mari.files_Midex_common_raw.PositionTtlLookup;

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


Layout_PartyClean clean_Midex_party(dSANCTN_party input) := TRANSFORM
	TrimCompany		:= ut.CleanSpacesAndUpper(input.company);
	TrimEmployer	:= ut.CleanSpacesAndUpper(input.employer);
	TrimPosition	:= ut.CleanSpacesAndUpper(input.position_title);
	TrimFName 		:= ut.CleanSpacesAndUpper(input.firstname);
	TrimLName 		:= ut.CleanSpacesAndUpper(input.lastname);
	TrimMName			:= ut.CleanSpacesAndUpper(input.middlename);
	TrimAddress		:= ut.CleanSpacesAndUpper(input.address);
	
	self.sanctions					:= ut.CleanSpacesAndUpper(input.sanctions);
	self.info								:= ut.CleanSpacesAndUpper(input.info);
	self.company						:= STD.Str.FindReplace(TrimCompany, '&AMP;','&');
	
// Capture Nickname	
	vNickFirst  := Prof_License_Mari.fGetNickname(TrimFName,'nick');
	vNickLast  	:= Prof_License_Mari.fGetNickname(TrimLName,'nick');
	vNickMid  	:= Prof_License_Mari.fGetNickname(TrimMName,'nick');
	
//Strim Nickname	
  StripNickFirst 	:= Prof_License_Mari.fGetNickname(TrimFName,'strip_nick');
	StripNickLast 	:= Prof_License_Mari.fGetNickname(TrimLName,'strip_nick');
	StripNickMid 		:= Prof_License_Mari.fGetNickname(TrimMName,'strip_nick');
	
	self.firstname					:= if(stripNickFirst = '', TrimFName,StripNickFirst);
	self.lastname						:= if(stripNickLast = '', TrimLName,StripNickLast);
	self.middlename					:= if(stripNickMid = '', TrimMName,StripNickMid);
	self.suffix							:= ut.CleanSpacesAndUpper(input.suffix);
	self.nickname						:= If(vNickFirst != '',vNickFirst,
																	IF(vNickLast != '', vNickLast,
																				vNickMid));
	self.position_title			:= STD.Str.FindReplace(TrimPosition, '&AMP;','&');
	self.employer						:= STD.Str.FindReplace(TrimEmployer, '&AMP;','&');
	
	prepAddressAmp 					:= STD.Str.FindReplace(TrimAddress, '&AMP;','&');
	prepAddressMain					:= STD.Str.FindReplace(prepAddressAmp, '(MAIN OFFICE)','');
	prepAddressColon				:= STD.Str.FindReplace(prepAddressMain, ':',' ');
	self.address						:= prepAddressColon;
	self.city								:= ut.CleanSpacesAndUpper(input.city);
	self.state							:= ut.CleanSpacesAndUpper(input.state);
	
    

	
// Convert the m/d/yy date to yyyymmdd
	 string8     fSlashedMDYtoCCYYMMDD(string pDateIn) := intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
                                                     + intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
									                 + intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);
	self.DOB									:= intformat((integer1)regexreplace('([0-9]+)/.*/.*',input.DOB,'$1'),2,1) + '/' + intformat((integer1)regexreplace('.*/([0-9]+)/.*',input.DOB,'$1'),2,1) + '/' + intformat((integer2)regexreplace('.*/.*/([0-9]+)',input.DOB,'$1'),4,1);
	self.dob_clean						:= if(self.DOB = '00/00/0000','',fSlashedMDYtoCCYYMMDD(trim(self.DOB,left,right)));
	self.ssn_clean						:= STD.Str.Filter(input.SSN,'0123456789');
	self.tin_clean						:= STD.Str.Filter(input.TIN,'0123456789');
	self.firstname_orig				:= TrimFName;
	self.lastname_orig				:= TrimLName;
	self.middlename_orig			:= TrimMName;
	self.company_orig					:= TrimCompany;
	self.position_title_orig	:= TrimPosition;
	self.employer_orig				:= TrimEmployer;
	self.address_orig					:= TrimAddress;
	self.stdPositionTtl				:= '';
	self.phone_clean					:= stringlib.stringfilterout(input.PHONE,'-');
	self.akaname							:= ut.CleanSpacesAndUpper(input.akaname);
	self.dbaname							:= ut.CleanSpacesAndUpper(input.dbaname);
  self := input;
END;

clean_data := sort(PROJECT(dSANCTN_party, clean_Midex_party(LEFT)),INCIDENT_NO,NUMBER);

// Populate STD_TYPE_DESC field via translation
Layout_PartyClean 	trans_position(clean_data L, dPositionLkp R) := transform
	self.stdPositionTtl :=  STD.Str.ToUpperCase(trim(R.std_position_ttl,left,right));
	self := L;
end;

ds_position_trans := JOIN(clean_data, dPositionLkp,
								      TRIM(left.position_title,left,right)= TRIM(right.position_title,left,right),
											trans_position(left,right),left outer,lookup);

output('NonPublic Party data: ' + count(clean_data));

clean_data_deduped := output(dedup(ds_position_trans,all),,SANCTN_Mari.cluster_name +'in::SANCTN::NP::midex_party_cleaned',overwrite);
return sequential(clean_data_deduped);

end;