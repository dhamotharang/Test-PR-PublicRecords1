import census_data;
#workunit ('name', 'Convert Emerges voters to Lexis CSRA voters');

export csra_layout := record
   string2 State_Abbreviation;
   string10 County_Code;
   string5 Title;
   string20 Last_Name;
   string15 First_Name;
   string15 Middle_Name;
   string5 Suffix;
   string10 Voter_ID;
   string8 Date_of_Birth;
   string2 Age_Code;
   string3 Age;
   string1 Gender;
   string2 Race;
   string2 Active_Code;
   string1 Parsed_Code;
   string59 Res_Line1;
   string29 Res_Line2;
   string15 City;
   string2 State;
   string5 ZipCode5;
   string4 ZipCode4;
   string1 Mail_Parsed;
   string49 Mail_Line1;
   string39 Mail_Line2;
   string15 Mail_City;
   string2 Mail_State;
   string5 Mail_ZipCode5;
   string4 Mail_ZipCode4;
   string10 Telephone;
   string3 Party_Code;
   string8 Date_of_Registration;
   string8 Last_Date_Voted;
   string7 History0;
   string7 History1;
   string7 History2;
   string7 History3;
   string7 History4;
   string7 History5;
   string7 History6;
   string7 History7;
   string7 History8;
   string7 History9;
   string6 Congressional;
   string6 State_Senate;
   string6 State_House;
   string6 Judicial;
   string20 Precinct;
   string20 Town;
   string6 Village;
   string6 Ward;
   string6 District;
   string89 State_Specific_Data;
end;

export csra_layout_temp := record
   string2 State_Abbreviation;
   string10 County_Code;
   string2 fipsstate;
   string3 fipscounty;
   string18 county_name;
   string5 Title;
   string20 Last_Name;
   string15 First_Name;
   string15 Middle_Name;
   string5 Suffix;
   string10 Voter_ID;
   string15 Voter_ID_temp;
   string12 source_voterId;
   string15 motorVoterId;
   string8 Date_of_Birth;
   string2 Age_Code;
   string3 Age;
   string1 Gender;
   string2 Race;
   string2 Active_Code;
   string1 Parsed_Code;
   string59 Res_Line1;
   string29 Res_Line2;
   string15 City;
   string2 State;
   string5 ZipCode5;
   string4 ZipCode4;
   string1 Mail_Parsed;
   string49 Mail_Line1;
   string39 Mail_Line2;
   string15 Mail_City;
   string2 Mail_State;
   string5 Mail_ZipCode5;
   string4 Mail_ZipCode4;
   string10 Telephone;
   string3 Party_Code;
   string8 Date_of_Registration;
   string8 Last_Date_Voted;
   string7 History0;
   string7 History1;
   string7 History2;
   string7 History3;
   string7 History4;
   string7 History5;
   string7 History6;
   string7 History7;
   string7 History8;
   string7 History9;
   string6 Congressional;
   string6 State_Senate;
   string6 State_House;
   string6 Judicial;
   string20 Precinct;
   string20 Town;
   string6 Village;
   string6 Ward;
   string6 District;
   string89 State_Specific_Data;
end;

string3 mapPoliticalParty(string2 state, string2 poliparty, string3 county) :=
MAP(
   state = 'AR' =>
 MAP( (integer)trim(poliparty) = 1 => 'D',
(integer)trim(poliparty) = 2 => 'R', ' '),

state = 'CO' =>
 MAP( (integer)trim(poliparty) = 1 => 'D',
(integer)trim(poliparty) = 6 => 'F',
(integer)trim(poliparty) = 5 => 'G',
(integer)trim(poliparty) = 7 => 'I',
(integer)trim(poliparty) = 3 => 'L',
(integer)trim(poliparty) = 10 => 'N',
(integer)trim(poliparty) = 2 => 'R', ' '),

state = 'CN' =>
 MAP( (integer)trim(poliparty) = 1 => 'D',
(integer)trim(poliparty) = 5 => 'G',
(integer)trim(poliparty) = 8 => 'I',
(integer)trim(poliparty) = 3 => 'L',
(integer)trim(poliparty) = 2 => 'R',
(integer)trim(poliparty) = 26 => 'S' , ' '),

state = 'DE' =>
 MAP( (integer)trim(poliparty) = 21 => 'A',
(integer)trim(poliparty) = 12 => 'B',
(integer)trim(poliparty) = 16 => 'C',
(integer)trim(poliparty) = 1 => 'D',
(integer)trim(poliparty) = 4 => 'E',
(integer)trim(poliparty) = 22 => 'F',
(integer)trim(poliparty) = 5 => 'H',
(integer)trim(poliparty) = 7 => 'I',
(integer)trim(poliparty) = 24 => 'K',
(integer)trim(poliparty) = 3 => 'L',
(integer)trim(poliparty) = 6 => 'M',
(integer)trim(poliparty) = 25 => 'N',
(integer)trim(poliparty) = 23 => 'O',
(integer)trim(poliparty) = 14 => 'P',
(integer)trim(poliparty) = 15 => 'Q',
(integer)trim(poliparty) = 2 => 'R',
(integer)trim(poliparty) = 26 => 'T',
(integer)trim(poliparty) = 10 => 'V' , ' '),

state = 'DC' =>
 MAP( (integer)trim(poliparty) = 1 => 'D',
(integer)trim(poliparty) = 23 => 'O',
(integer)trim(poliparty) = 2 => 'R',
(integer)trim(poliparty) = 27 => 'S',
(integer)trim(poliparty) = 28 => 'U' , ' '),

state = 'GA' =>
 MAP( (integer)trim(poliparty) = 1 => 'D',
(integer)trim(poliparty) = 2 => 'R' , ' '),

state = 'KS'  =>
 MAP( (integer)trim(poliparty) = 15 => 'C',
(integer)trim(poliparty) = 1 => 'D',
(integer)trim(poliparty) = 6 => 'F',
(integer)trim(poliparty) = 7 => 'I',
(integer)trim(poliparty) = 3 => 'L',
(integer)trim(poliparty) = 2 => 'R' , ' '),

state = 'LA'  =>
 MAP( (integer)trim(poliparty) = 1 => 'D',
(integer)trim(poliparty) = 23 => 'O',
(integer)trim(poliparty) = 2 => 'R',
(integer)trim(poliparty) = 6 => 'X' , ' '),

state = 'NV' =>
 MAP(county = '510' =>
   MAP( (integer)trim(poliparty) = 1 => 'DEM',
(integer)trim(poliparty) = 20 => 'DS',
(integer)trim(poliparty) = 5 => 'GRE',
(integer)trim(poliparty) = 5 => 'GRN',
(integer)trim(poliparty) = 7 => 'IND',
(integer)trim(poliparty) = 3 => 'LIB',
(integer)trim(poliparty) = 10 => 'NLP',
(integer)trim(poliparty) = 23 => 'OTR',
(integer)trim(poliparty) = 6 => 'REF',
(integer)trim(poliparty) = 2 => 'REP', ' '),

   county = '001' =>
   MAP( (integer)trim(poliparty) = 1 => 'DEM',
(integer)trim(poliparty) = 20 => 'DS',
(integer)trim(poliparty) = 5 => 'GRN',
(integer)trim(poliparty) = 3 => 'LIB',
(integer)trim(poliparty) = 10 => 'NLP',
(integer)trim(poliparty) = 23 => 'OTR',
(integer)trim(poliparty) = 6 => 'REF',
(integer)trim(poliparty) = 2 => 'REP', ' '),


   county = '003' =>
   MAP( (integer)trim(poliparty) = 1 => '01',
(integer)trim(poliparty) = 2 => '02',
(integer)trim(poliparty) = 3 => '04',
(integer)trim(poliparty) = 5 => '31',
(integer)trim(poliparty) = 10 => '45',
(integer)trim(poliparty) = 6 => '96',
(integer)trim(poliparty) = 23 => 'OT',
(integer)trim(poliparty) = 23 => 'OTH', ' '),

   county = '005' =>
   MAP( (integer)trim(poliparty) = 1 => 'DEM',
(integer)trim(poliparty) = 5 => 'GRE',
(integer)trim(poliparty) = 5 => 'GRN',
(integer)trim(poliparty) = 7 => 'IND',
(integer)trim(poliparty) = 3 => 'LIB',
(integer)trim(poliparty) = 6 => 'REF',
(integer)trim(poliparty) = 2 => 'REP', ' '),

   county = '007' =>
   MAP( (integer)trim(poliparty) = 1 => 'DEM',
(integer)trim(poliparty) = 5 => 'GRN',
(integer)trim(poliparty) = 7 => 'INP',
(integer)trim(poliparty) = 3 => 'LIB',
(integer)trim(poliparty) = 23 => 'OTH',
(integer)trim(poliparty) = 6 => 'REF',
(integer)trim(poliparty) = 2 => 'REP', ' '),

   county = '009' =>
   MAP( (integer)trim(poliparty) = 1 => 'DEM',
(integer)trim(poliparty) = 7 => 'IAP',
(integer)trim(poliparty) = 7 => 'IND',
(integer)trim(poliparty) = 5 => 'GRN',
(integer)trim(poliparty) = 3 => 'LIB',
(integer)trim(poliparty) = 2 => 'REP', ' '),


   county = '011' =>
   MAP( (integer)trim(poliparty) = 1 => 'DEM',
(integer)trim(poliparty) = 5 => 'GRN',
(integer)trim(poliparty) = 7 => 'INP',
(integer)trim(poliparty) = 3 => 'LIB',
(integer)trim(poliparty) = 6 => 'REF',
(integer)trim(poliparty) = 2 => 'REP', ' '),

   county = '013' =>
   MAP( (integer)trim(poliparty) = 1 => 'DEM',
(integer)trim(poliparty) = 7 => 'IND',
(integer)trim(poliparty) = 5 => 'GRN',
(integer)trim(poliparty) = 3 => 'LIB',
(integer)trim(poliparty) = 6 => 'REF',
(integer)trim(poliparty) = 2 => 'REP', ' '),

   county = '015' =>
   MAP( (integer)trim(poliparty) = 1 => 'DEM',
(integer)trim(poliparty) = 3 => 'LIB',
(integer)trim(poliparty) = 10 => 'NL',
(integer)trim(poliparty) = 23 => 'OTH',
(integer)trim(poliparty) = 23 => 'OTR',
(integer)trim(poliparty) = 2 => 'REP', ' '),

   county = '017' =>
   MAP( (integer)trim(poliparty) = 1 => 'DEM',
(integer)trim(poliparty) = 5 => 'GRN',
(integer)trim(poliparty) = 7 => 'IND',
(integer)trim(poliparty) = 3 => 'LIB',
(integer)trim(poliparty) = 10 => 'NL',
(integer)trim(poliparty) = 6 => 'REF',
(integer)trim(poliparty) = 2 => 'REP', ' '),

 
   county = '019' =>
   MAP( (integer)trim(poliparty) = 1 => 'DEM',
(integer)trim(poliparty) = 5 => 'GRN',
(integer)trim(poliparty) = 7 => 'INP',
(integer)trim(poliparty) = 3 => 'LIB',
(integer)trim(poliparty) = 23 => 'OTH', 
(integer)trim(poliparty) = 6 => 'REF',
(integer)trim(poliparty) = 2 => 'REP', ' '),

   county = '021' =>
   MAP( (integer)trim(poliparty) = 1 => 'DEM',
(integer)trim(poliparty) = 20 => 'DS', 
(integer)trim(poliparty) = 7 => 'IND',
(integer)trim(poliparty) = 3 => 'LIB',
(integer)trim(poliparty) = 10 => 'NL',
(integer)trim(poliparty) = 23 => 'OTH',
(integer)trim(poliparty) = 23 => 'OTR',
(integer)trim(poliparty) = 6 => 'REF',
(integer)trim(poliparty) = 2 => 'REP', ' '),

   county = '023' =>
   MAP( (integer)trim(poliparty) = 1 => 'DEM',
(integer)trim(poliparty) = 5 => 'GRN',
(integer)trim(poliparty) = 7 => 'IAP',
(integer)trim(poliparty) = 3 => 'LIB',
(integer)trim(poliparty) = 10 => 'NLP',
(integer)trim(poliparty) = 23 => 'OTH',
(integer)trim(poliparty) = 6 => 'REF',
(integer)trim(poliparty) = 2 => 'REP', ' '),


   county = '027' =>
   MAP( (integer)trim(poliparty) = 1 => 'DEM',
(integer)trim(poliparty) = 5 => 'GRN',
(integer)trim(poliparty) = 7 => 'IND',
(integer)trim(poliparty) = 3 => 'LIB',
(integer)trim(poliparty) = 10 => 'NL',
(integer)trim(poliparty) = 6 => 'REF',
(integer)trim(poliparty) = 2 => 'REP', ' '),

   county = '029' =>
   MAP( (integer)trim(poliparty) = 1 => 'DEM',
(integer)trim(poliparty) = 5 => 'GRN',
(integer)trim(poliparty) = 3 => 'LIB',
(integer)trim(poliparty) = 10 => 'N/L',
(integer)trim(poliparty) = 23 => 'OTR',
(integer)trim(poliparty) = 6 => 'REF',
(integer)trim(poliparty) = 2 => 'REP', ' '),

   county = '031' =>
   MAP( (integer)trim(poliparty) = 21 => 'AME',
(integer)trim(poliparty) = 1 => 'DEM',
(integer)trim(poliparty) = 5 => 'GRN',
(integer)trim(poliparty) = 7 => 'IND',
(integer)trim(poliparty) = 3 => 'LIB',
(integer)trim(poliparty) = 10 => 'NL',
(integer)trim(poliparty) = 23 => 'OTH',
(integer)trim(poliparty) = 2 => 'REP',
(integer)trim(poliparty) = 6 => 'RFM', ' '),


   county = '033' =>
   MAP( (integer)trim(poliparty) = 1 => 'DEM',
(integer)trim(poliparty) = 5 => 'GRN',
(integer)trim(poliparty) = 7 => 'IND',
(integer)trim(poliparty) = 3 => 'LIB',
(integer)trim(poliparty) = 10 => 'NL',
(integer)trim(poliparty) = 23 => 'OTH',
(integer)trim(poliparty) = 2 => 'REP', ' '), ' '),

state = 'NY' =>
 MAP( (integer)trim(poliparty) = 1 => 'D',
(integer)trim(poliparty) = 26 => 'E',
(integer)trim(poliparty) = 13 => 'F',
(integer)trim(poliparty) = 5 => 'G',
(integer)trim(poliparty) = 8 => 'I',
(integer)trim(poliparty) = 4 => 'L',
(integer)trim(poliparty) = 23 => 'O',
(integer)trim(poliparty) = 2 => 'R',
(integer)trim(poliparty) = 9 => 'T',
(integer)trim(poliparty) = 17 => 'W', ' '),


state = 'OH' =>
 MAP( (integer)trim(poliparty) = 1 => 'D',
(integer)trim(poliparty) = 6 => 'E',
(integer)trim(poliparty) = 3 => 'L',
(integer)trim(poliparty) = 10 => 'N',
(integer)trim(poliparty) = 2 => 'R', ' '),

state = 'OK' =>
 MAP( (integer)trim(poliparty) = 1 => 'DEM',
(integer)trim(poliparty) = 7 => 'IND',
(integer)trim(poliparty) = 3 => 'LIB',
(integer)trim(poliparty) = 2 => 'REP', ' '),

state = 'PA' =>
 MAP( (integer)trim(poliparty) = 11 => 'B',
(integer)trim(poliparty) = 1 => 'D',
(integer)trim(poliparty) = 26 => 'E',
(integer)trim(poliparty) = 6 => 'F',
(integer)trim(poliparty) = 4 => 'G',
(integer)trim(poliparty) = 7 => 'I',
(integer)trim(poliparty) = 3 => 'L',
(integer)trim(poliparty) = 23 => 'O',
(integer)trim(poliparty) = 2 => 'R',
(integer)trim(poliparty) = 15 => 'T' , ' '),

state = 'RI' =>
 MAP( (integer)trim(poliparty) = 33 => 'C',
(integer)trim(poliparty) = 1 => 'D',
(integer)trim(poliparty) = 13 => 'F',
(integer)trim(poliparty) = 7 => 'I',
(integer)trim(poliparty) = 2 => 'R' , ' '),

state = 'UT' =>
 MAP( (integer)trim(poliparty) = 21 => 'A',
(integer)trim(poliparty) = 15 => 'C',
(integer)trim(poliparty) = 1 => 'D',
(integer)trim(poliparty) = 5 => 'G',
(integer)trim(poliparty) = 7 => 'I',
(integer)trim(poliparty) = 3 => 'L',
(integer)trim(poliparty) = 10 => 'N',
(integer)trim(poliparty) = 23 => 'O',
(integer)trim(poliparty) = 2 => 'R' , ' '),

state = 'IL' or state = 'OR' or state = 'NC' or state = 'NJ' or state = 'WA' =>
 MAP( (integer)trim(poliparty) = 11 => 'B',
(integer)trim(poliparty) = 1 => 'D',
(integer)trim(poliparty) = 26 => 'E',
(integer)trim(poliparty) = 6 => 'F',
(integer)trim(poliparty) = 4 => 'G',
(integer)trim(poliparty) = 7 => 'I',
(integer)trim(poliparty) = 3 => 'L',
(integer)trim(poliparty) = 23 => 'O',
(integer)trim(poliparty) = 2 => 'R',
(integer)trim(poliparty) = 15 => 'T', ' '),
 
(integer)trim(poliparty) = 11 => 'B',
(integer)trim(poliparty) = 1 => 'D',
(integer)trim(poliparty) = 26 => 'E',
(integer)trim(poliparty) = 6 => 'F',
(integer)trim(poliparty) = 4 => 'G',
(integer)trim(poliparty) = 7 => 'I',
(integer)trim(poliparty) = 3 => 'L',
(integer)trim(poliparty) = 23 => 'O', 
(integer)trim(poliparty) = 2 => 'R',
(integer)trim(poliparty) = 15 => 'T', ' ');

string3 mapStatus(string2 state, string1 active_status, string2 voter_status) :=
MAP(
   state = 'AL' =>
 MAP( active_status = 'A' => 'Y',
      active_status = 'I' => 'N', ' '),
state = 'CO' =>
 MAP( active_status = 'A' or active_status = 'I' => active_status,
	 voter_status = '10' => 'CD',
	 voter_status = '13' => 'CM',
	 trim(voter_status) = '9' => 'CP',
	 trim(voter_status) = '8' => 'CU',
	 trim(voter_status) = '2' => 'CJ', ' '),
state = 'CN' =>
 MAP( active_status = 'A' or active_status = 'I' => active_status,
	 voter_status = '10' => 'D',
	 trim(voter_status) = '2' => 'F',
	 trim(voter_status) = '9' => 'R',
	 voter_status = '13' => 'C', ' '),
state = 'MI' =>
 MAP( active_status = 'A' or active_status = 'I' or active_status = 'C' => active_status,
	 voter_status = '16' => 'V', ' '),
state = 'GA' or state = 'KS' or state = 'LA' or state = 'MA' or state = 'MO' or state = 'OK' or
state = 'RI' or state = 'SC' =>
 MAP( active_status = 'A' or active_status = 'I'=> active_status, ' '),
 MAP( active_status = 'A' or active_status = 'I' or active_status = 'C' => active_status, ' '));


csra_layout_temp convert2CSRA_temp(emerges.layout_voters_out l):= transform
  self.State_Abbreviation := map(L.source_state = '' => stringlib.StringToUpperCase(L.res_state), 
							L.source_state);
  self.Title := stringlib.StringToUpperCase(trim(L.title_in)[1..5]);
  self.Last_Name := stringlib.StringToUpperCase(trim(L.lname_in)[1..20]);
  self.First_Name := stringlib.StringToUpperCase(trim(L.fname_in)[1..15]);
  self.Middle_Name := stringlib.StringToUpperCase(trim(L.mname_in)[1..15]);
  self.Date_of_Birth := L.dob;
  self.Age_Code := stringlib.StringToUpperCase(L.AgeCat);
//Florida uses a voter id that's first 3 characters are the first 3 of the county the voter is registered in.  This makes the voter id too big
//for the csra 10 character voter id, so I will take out those first three characters so we don't lose information.
//Florida is the only state that does this--verified through stats
  self.Voter_ID_temp := map(self.State_Abbreviation = 'FL' and 
					length(stringlib.StringFilterOut(trim(L.source_voterId[1..3], all), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')) = 0 => trim(L.source_voterId, all)[4..12],
					length(stringlib.StringFilterOut(trim(L.source_voterId, all), '0')) = 0 => ' ',
					L.source_voterId);
  self.Voter_ID := map(length(trim(self.Voter_ID_temp, all)) <= 10 and length(trim(self.Voter_ID_temp, all)) > 0 => trim(self.Voter_ID_temp, all)[1..10],
				   length(trim(self.Voter_ID_temp, all)) > 10 and (integer)(trim(self.Voter_ID_temp, all)) > 0  and 
					length(stringlib.StringFilterOut(trim(self.Voter_ID_temp, all), '0123456789.')) = 0 => (string)((integer)(trim(self.Voter_ID_temp, all)))[1..10],
				   length(trim(self.Voter_ID_temp, all)) > 10 and (integer)(trim(self.Voter_ID_temp, all)) = 0 => trim(self.Voter_ID_temp, all)[1..10],
				   length(trim(self.Voter_ID_temp, all)) = 0 => 
					map(length(trim(L.motorVoterId, all)) <= 10 => trim(L.motorVoterId, all)[1..10],
						length(trim(L.motorVoterId, all)) > 10 and (integer)(trim(L.motorVoterId, all)) > 0 and
							length(stringlib.StringFilterOut(trim(L.motorVoterId, all), '0123456789.')) = 0 => (string)((integer)(trim(L.motorVoterId, all)))[1..10],
						length(trim(L.motorVoterId, all)) > 10 and (integer)(trim(L.motorVoterId, all)) = 0 => trim(L.motorVoterId, all)[1..10], 
							trim(L.motorVoterId, all)[1..10]), trim(self.Voter_ID_temp, all)[1..10]);

  self.Date_of_Registration := L.RegDate;
  self.Race := map(trim(L.race) = 'N' => 'M', trim(L.race) = 'U' => 'O', L.race);
  self.Party_Code := mapPoliticalParty(l.source_state, l.poliparty, l.county);
  self.Telephone := L.phone;
  self.Active_Code := mapStatus(l.source_state,L.active_status, l.voterStatus);
  self.Res_Line1 := stringlib.StringToUpperCase(L.ResAddr1);
  self.Res_Line2 := stringlib.StringToUpperCase(trim(L.ResAddr2)[1..29]);
  self.City := stringlib.StringToUpperCase(trim(L.Res_city)[1..15]);
  self.State := stringlib.StringToUpperCase(L.res_state);
  self.ZipCode5 := L.res_zip[1..5];
  self.ZipCode4 := L.res_zip[6..9];
//  self.County_Code := stringlib.StringToUpperCase(L.res_county);
  self.County_Code := ' ';
  self.Mail_Line1 := stringlib.StringToUpperCase(L.mail_addr1);
  self.Mail_Line2 := stringlib.StringToUpperCase(trim(L.mail_addr2)[1..39]);
  self.Mail_City := stringlib.StringToUpperCase(trim(L.mail_city)[1..15]);
  self.Mail_State := stringlib.StringToUpperCase(L.mail_state);
  self.Mail_ZipCode5 := L.mail_zip[1..5];
  self.Mail_ZipCode4 := L.mail_zip[6..9];
  self.Town := L.towncode;
  self.District := L.distcode;
  self.Precinct := L.precinct1;
  self.Village := trim(L.villagePrecinct)[1..6];
  self.State_House := L.stateHouse;
  self.State_Senate := L.stateSenate;
  self.Judicial := L.JudicialDist;
  self.Last_Date_Voted := L.LastDayVote;
  self.Suffix := stringlib.StringToUpperCase(L.name_suffix_in);
  self.Age := ' ';
  self.Parsed_Code := ' ';
  self.Mail_Parsed := ' ';
  self.State_Specific_Data := ' ';
  self.History0 := '04';
  self.History1 := '03';
  self.History2 := map(l.source_state != 'IL' => '02' + trim(map(trim(L.Primary02) = 'Y' => 'P', '')) + 
					 trim(map(trim(L.Special02) = 'Y' => 'S', '')) +
					 trim(map(trim(L.General02) = 'Y' => 'G', '')), 
					 trim(map(trim(L.Primary02) = 'Y' => 'P', '')) + 
					 trim(map(trim(L.Special02) = 'Y' => 'S', '')) +
					 trim(map(trim(L.General02) = 'Y' => 'G', '')) + '02');
  self.History3 := map(l.source_state != 'IL' => '01' + trim(map(trim(L.Primary01) = 'Y' => 'P', '')) + 
					 trim(map(trim(L.Special01) = 'Y' => 'S', '')) +
					 trim(map(trim(L.General01) = 'Y' => 'G', '')),
					 trim(map(trim(L.Primary01) = 'Y' => 'P', '')) + 
					 trim(map(trim(L.Special01) = 'Y' => 'S', '')) +
					 trim(map(trim(L.General01) = 'Y' => 'G', '')) + '01');
  self.History4 := map(l.source_state != 'IL' => '00' + trim(map(trim(L.Primary00) = 'Y' => 'P', '')) + 
					 trim(map(trim(L.Special00) = 'Y' => 'S', '')) +
					 trim(map(trim(L.General00) = 'Y' => 'G', '')) +
					 trim(map(trim(L.Pres00) = 'Y' => 'B', '')),
					 trim(map(trim(L.Primary00) = 'Y' => 'P', '')) + 
					 trim(map(trim(L.Special00) = 'Y' => 'S', '')) +
					 trim(map(trim(L.General00) = 'Y' => 'G', '')) +
					 trim(map(trim(L.Pres00) = 'Y' => 'B', '')) + '00');
  self.History5 := map(l.source_state != 'IL' => '99' + trim(map(trim(L.Primary99) = 'Y' => 'P', '')) + 
					 trim(map(trim(L.Special99) = 'Y' => 'S', '')) +
					 trim(map(trim(L.General99) = 'Y' => 'G', '')),
					 trim(map(trim(L.Primary99) = 'Y' => 'P', '')) + 
					 trim(map(trim(L.Special99) = 'Y' => 'S', '')) +
					 trim(map(trim(L.General99) = 'Y' => 'G', '')) + '99');
  self.History6 := map(l.source_state != 'IL' => '98' + trim(map(trim(L.Primary98) = 'Y' => 'P', '')) + 
					 trim(map(trim(L.Special98) = 'Y' => 'S', '')) +
					 trim(map(trim(L.General98) = 'Y' => 'G', '')),
					 trim(map(trim(L.Primary98) = 'Y' => 'P', '')) + 
					 trim(map(trim(L.Special98) = 'Y' => 'S', '')) +
					 trim(map(trim(L.General98) = 'Y' => 'G', '')) + '98');
  self.History7 := map(l.source_state != 'IL' => '97' + trim(map(trim(L.Primary97) = 'Y' => 'P', '')) + 
					 trim(map(trim(L.Special97) = 'Y' => 'S', '')) +
					 trim(map(trim(L.General97) = 'Y' => 'G', '')),
					 trim(map(trim(L.Primary97) = 'Y' => 'P', '')) + 
					 trim(map(trim(L.Special97) = 'Y' => 'S', '')) +
					 trim(map(trim(L.General97) = 'Y' => 'G', '')) + '97');
  self.History8 := map(l.source_state != 'IL' => '96' + trim(map(trim(L.Primary96) = 'Y' => 'P', '')) + 
					 trim(map(trim(L.Special96) = 'Y' => 'S', '')) +
					 trim(map(trim(L.General96) = 'Y' => 'G', '')) +
					 trim(map(trim(L.Pres96) = 'Y' => 'B', '')),
					 trim(map(trim(L.Primary96) = 'Y' => 'P', '')) + 
					 trim(map(trim(L.Special96) = 'Y' => 'S', '')) +
					 trim(map(trim(L.General96) = 'Y' => 'G', '')) +
					 trim(map(trim(L.Pres96) = 'Y' => 'B', '')) + '96');
  self.History9 := '95';
  self.Congressional := L.USHouse;
  self.Ward := trim(L.Ward)[1..6];
  self.fipsstate := L.ace_fips_st;
  self.fipscounty := L.county;
  self.county_name := ' ';
  self := L;
end;

voters := emerges.file_voters_base;

CSRA_voters_projected := project(voters,convert2CSRA_temp(left));
count(CSRA_voters_projected(State_Abbreviation != ''));
csra_voters_nonblankfips := CSRA_voters_projected(State_Abbreviation != '' and fipscounty != '');
csra_voters_blankfips    := CSRA_voters_projected(State_Abbreviation = '' or fipscounty = '');
count(csra_voters_nonblankfips(State_Abbreviation != ''));
count(csra_voters_blankfips(State_Abbreviation != ''));

// ------------------------------------------------------------------------
// -- Join to fips2county key to get county name
// ------------------------------------------------------------------------

census_data.MAC_Fips2County(csra_voters_nonblankfips,State_Abbreviation,fipscounty,county_name,csra_voters_joined);
count(csra_voters_joined(State_Abbreviation != ''));
count(csra_voters_joined(county_name != ''));
count(csra_voters_joined(fipscounty != ''));

/*
csra_layout_temp get_county_name(CSRA_voters_nonblankfips l, Census_Data.Key_Fips2County r) := transform
	self.county_name := r.county_name;
	self := l;
end;

csra_voters_joined := join(CSRA_voters_nonblankfips,Census_Data.Key_Fips2County,
                    left.fipsstate = right.state_code and
		                left.fipscounty = right.county_fips,
                          get_county_name(LEFT, right),left outer);

*/
// ------------------------------------------------------------------------
// -- mapOhio function
// ------------------------------------------------------------------------
string2 mapOhio(string18 county_name) :=
MAP(
        trim(county_name) = 'ADAMS' => '01',
        trim(county_name) = 'ALLEN' => '02',
        trim(county_name) = 'ASHLAND' => '03',
        trim(county_name) = 'ASHTABULA' => '04',
        trim(county_name) = 'ATHENS' => '05',
        trim(county_name) = 'AUGLAIZE' => '06',
        trim(county_name) = 'BELMONT' => '07',
        trim(county_name) = 'BROWN' => '08',
        trim(county_name) = 'BUTLER' => '09',
        trim(county_name) = 'CARROLL' => '10',
        trim(county_name) = 'CHAMPAIGN' => '11',
        trim(county_name) = 'CLARK' => '12',
        trim(county_name) = 'CLERMONT' => '13',
        trim(county_name) = 'CLINTON' => '14',
        trim(county_name) = 'COLUMBIANA' => '15',
        trim(county_name) = 'COSHOCTON' => '16',
        trim(county_name) = 'CRAWFORD' => '17',
        trim(county_name) = 'CUYAHOGA' => '18',
        trim(county_name) = 'DARKE' => '19',
        trim(county_name) = 'DEFIANCE' => '20',
        trim(county_name) = 'DELAWARE' => '21',
        trim(county_name) = 'ERIE' => '22',
        trim(county_name) = 'FAIRFIELD' => '23',
        trim(county_name) = 'FAYETTE' => '24',
        trim(county_name) = 'FRANKLIN' => '25',
        trim(county_name) = 'FULTON' => '26',
        trim(county_name) = 'GALLIA' => '27',
        trim(county_name) = 'GEAUGA' => '28',
        trim(county_name) = 'GREENE' => '29',
        trim(county_name) = 'GUERNSEY' => '30',
        trim(county_name) = 'HAMILTON' => '31',
        trim(county_name) = 'HANCOCK' => '32',
        trim(county_name) = 'HARDIN' => '33',
        trim(county_name) = 'HARRISON' => '34',
        trim(county_name) = 'HENRY' => '35',
        trim(county_name) = 'HIGHLAND' => '36',
        trim(county_name) = 'HOCKING' => '37',
        trim(county_name) = 'HOLMES' => '38',
        trim(county_name) = 'HURON' => '39',
        trim(county_name) = 'JACKSON' => '40',
        trim(county_name) = 'JEFFERSON' => '41',
        trim(county_name) = 'KNOX' => '42',
        trim(county_name) = 'LAKE' => '43',
        trim(county_name) = 'LAWRENCE' => '44',
        trim(county_name) = 'LICKING' => '45',
        trim(county_name) = 'LOGAN' => '46',
        trim(county_name) = 'LORAIN' => '47',
        trim(county_name) = 'LUCAS' => '48',
        trim(county_name) = 'MADISON' => '49',
        trim(county_name) = 'MAHONING' => '50',
        trim(county_name) = 'MARION' => '51',
        trim(county_name) = 'MEDINA' => '52',
        trim(county_name) = 'MEIGS' => '53',
        trim(county_name) = 'MERCER' => '54',
        trim(county_name) = 'MIAMI' => '55',
        trim(county_name) = 'MONROE' => '56',
        trim(county_name) = 'MONTGOMERY' => '57',
        trim(county_name) = 'MORGAN' => '58',
        trim(county_name) = 'MORROW' => '59',
        trim(county_name) = 'MUSKINGUM' => '60',
        trim(county_name) = 'NOBLE' => '61',
        trim(county_name) = 'OTTAWA' => '62',
        trim(county_name) = 'PAULDING' => '63',
        trim(county_name) = 'PERRY' => '64',
        trim(county_name) = 'PICKAWAY' => '65',
        trim(county_name) = 'PIKE' => '66',
        trim(county_name) = 'PORTAGE' => '67',
        trim(county_name) = 'PREBLE' => '68',
        trim(county_name) = 'PUTNAM' => '69',
        trim(county_name) = 'RICHLAND' => '70',
        trim(county_name) = 'ROSS' => '71',
        trim(county_name) = 'SANDUSKY' => '72',
        trim(county_name) = 'SCIOTO' => '73',
        trim(county_name) = 'SENECA' => '74',
        trim(county_name) = 'SHELBY' => '75',
        trim(county_name) = 'STARK' => '76',
        trim(county_name) = 'SUMMIT' => '77',
        trim(county_name) = 'TRUMBULL' => '78',
        trim(county_name) = 'TUSCARAWAS' => '79',
        trim(county_name) = 'UNION' => '80',
        trim(county_name) = 'VAN' => '81',
        trim(county_name) = 'VINTON' => '82',
        trim(county_name) = 'WARREN' => '83',
        trim(county_name) = 'WASHINGTON' => '84',
        trim(county_name) = 'WAYNE' => '85',
        trim(county_name) = 'WILLIAMS' => '86',
        trim(county_name) = 'WOOD' => '87',
        trim(county_name) = 'WYANDOT' => '88', ' ');

// ------------------------------------------------------------------------
// -- mapSC function
// ------------------------------------------------------------------------
string2 mapSC(string18 county_name) :=
MAP(
        trim(county_name) = 'ABBEVILLE' => '01',
        trim(county_name) = 'AIKEN' => '02',
        trim(county_name) = 'ALLENDALE' => '03',
        trim(county_name) = 'ANDERSON' => '04',
        trim(county_name) = 'BAMBERG' => '05',
        trim(county_name) = 'BARNWELL' => '06',
        trim(county_name) = 'BEAUFORT' => '07',
        trim(county_name) = 'BERKELEY' => '08',
        trim(county_name) = 'CALHOUN' => '09',
        trim(county_name) = 'CHARLESTON' => '10',
        trim(county_name) = 'CHEROKEE' => '11',
        trim(county_name) = 'CHESTER' => '12',
        trim(county_name) = 'CHESTERFIELD' => '13',
        trim(county_name) = 'CLARENDON' => '14',
        trim(county_name) = 'COLLETON' => '15',
        trim(county_name) = 'DARLINGTON' => '16',
        trim(county_name) = 'DILLON' => '17',
        trim(county_name) = 'DORCHESTER' => '18',
        trim(county_name) = 'EDGEFIELD' => '19',
        trim(county_name) = 'FAIRFIELD' => '20',
        trim(county_name) = 'FLORENCE' => '21',
        trim(county_name) = 'GEORGETOWN' => '22',
        trim(county_name) = 'GREENVILLE' => '23',
        trim(county_name) = 'GREENWOOD' => '24',
        trim(county_name) = 'HAMPTON' => '25',
        trim(county_name) = 'HORRY' => '26',
        trim(county_name) = 'JASPER' => '27',
        trim(county_name) = 'KERSHAW' => '28',
        trim(county_name) = 'LANCASTER' => '29',
        trim(county_name) = 'LAURENS' => '30',
        trim(county_name) = 'LEE' => '31',
        trim(county_name) = 'LEXINGTON' => '32',
        trim(county_name) = 'MCCORMICK' => '33',
        trim(county_name) = 'MARION' => '34',
        trim(county_name) = 'MARLBORO' => '35',
        trim(county_name) = 'NEWBERRY' => '36',
        trim(county_name) = 'OCONEE' => '37',
        trim(county_name) = 'ORANGEBURG' => '38',
        trim(county_name) = 'PICKENS' => '39',
        trim(county_name) = 'RICHLAND' => '40',
        trim(county_name) = 'SALUDA' => '41',
        trim(county_name) = 'SPARTANBURG' => '42',
        trim(county_name) = 'SUMTER' => '43',
        trim(county_name) = 'UNION' => '44',
        trim(county_name) = 'WILLIAMSBURG' => '45',
        trim(county_name) = 'YORK' => '46', ' ');
// ------------------------------------------------------------------------
// -- mapMN function
// ------------------------------------------------------------------------
string2 mapMN(string18 county_name) :=
MAP(
        trim(county_name) = 'BEAVERHEAD' => '1',
        trim(county_name) = 'BIG' => '2',
        trim(county_name) = 'BLAINE' => '3',
        trim(county_name) = 'BROADWATER' => '4',
        trim(county_name) = 'CARBON' => '5',
        trim(county_name) = 'CARTER' => '6',
        trim(county_name) = 'CASCADE' => '7',
        trim(county_name) = 'CHOUTEAU' => '8',
        trim(county_name) = 'CUSTER' => '9',
        trim(county_name) = 'DANIELS' => '10',
        trim(county_name) = 'DAWSON' => '11',
        trim(county_name) = 'ANACONDA-DEER' => '12',
        trim(county_name) = 'FALLON' => '13',
        trim(county_name) = 'FERGUS' => '14',
        trim(county_name) = 'FLATHEAD' => '15',
        trim(county_name) = 'GALLATIN' => '16',
        trim(county_name) = 'GARFIELD' => '17',
        trim(county_name) = 'GLACIER' => '18',
        trim(county_name) = 'GOLDEN' => '19',
        trim(county_name) = 'GRANITE' => '20',
        trim(county_name) = 'HILL' => '21',
        trim(county_name) = 'JEFFERSON' => '22',
        trim(county_name) = 'JUDITH' => '23',
        trim(county_name) = 'LAKE' => '24',
        trim(county_name) = 'LEWIS' => '25',
        trim(county_name) = 'LIBERTY' => '26',
        trim(county_name) = 'LINCOLN' => '27',
        trim(county_name) = 'MADISON' => '28',
        trim(county_name) = 'MCCONE' => '29',
        trim(county_name) = 'MEAGHER' => '30',
        trim(county_name) = 'MINERAL' => '31',
        trim(county_name) = 'MISSOULA' => '32',
        trim(county_name) = 'MUSSELSHELL' => '33',
        trim(county_name) = 'PARK' => '34',
        trim(county_name) = 'PETROLEUM' => '35',
        trim(county_name) = 'PHILLIPS' => '36',
        trim(county_name) = 'PONDERA' => '37',
        trim(county_name) = 'POWDER' => '38',
        trim(county_name) = 'POWELL' => '39',
        trim(county_name) = 'PRAIRIE' => '40',
        trim(county_name) = 'RAVALLI' => '41',
        trim(county_name) = 'RICHLAND' => '42',
        trim(county_name) = 'ROOSEVELT' => '43',
        trim(county_name) = 'ROSEBUD' => '44',
        trim(county_name) = 'SANDERS' => '45',
        trim(county_name) = 'SHERIDAN' => '46',
        trim(county_name) = 'BUTTE-SILVER' => '47',
        trim(county_name) = 'STILLWATER' => '48',
        trim(county_name) = 'SWEET' => '49',
        trim(county_name) = 'TETON' => '50',
        trim(county_name) = 'TOOLE' => '51',
        trim(county_name) = 'TREASURE' => '52',
        trim(county_name) = 'VALLEY' => '53',
        trim(county_name) = 'WHEATLAND' => '54',
        trim(county_name) = 'WIBAUX' => '55',
        trim(county_name) = 'YELLOWSTONE' => '56', ' ');

// ------------------------------------------------------------------------
// -- mapTX function
// ------------------------------------------------------------------------
string3 mapTX(string18 county_name) :=
MAP(
        trim(county_name) = 'ANDERSON' => '001',
        trim(county_name) = 'ANDREWS' => '002',
        trim(county_name) = 'ANGELINA' => '003',
        trim(county_name) = 'ARANSAS' => '004',
        trim(county_name) = 'ARCHER' => '005',
        trim(county_name) = 'ARMSTRONG' => '006',
        trim(county_name) = 'ATASCOSA' => '007',
        trim(county_name) = 'AUSTIN' => '008',
        trim(county_name) = 'BAILEY' => '009',
        trim(county_name) = 'BANDERA' => '010',
        trim(county_name) = 'BASTROP' => '011',
        trim(county_name) = 'BAYLOR' => '012',
        trim(county_name) = 'BEE' => '013',
        trim(county_name) = 'BELL' => '014',
        trim(county_name) = 'BEXAR' => '015',
        trim(county_name) = 'BLANCO' => '016',
        trim(county_name) = 'BORDEN' => '017',
        trim(county_name) = 'BOSQUE' => '018',
        trim(county_name) = 'BOWIE' => '019',
        trim(county_name) = 'BRAZORIA' => '020',
        trim(county_name) = 'BRAZOS' => '021',
        trim(county_name) = 'BREWSTER' => '022',
        trim(county_name) = 'BRISCOE' => '023',
        trim(county_name) = 'BROOKS' => '024',
        trim(county_name) = 'BROWN' => '025',
        trim(county_name) = 'BURLESON' => '026',
        trim(county_name) = 'BURNET' => '027',
        trim(county_name) = 'CALDWELL' => '028',
        trim(county_name) = 'CALHOUN' => '029',
        trim(county_name) = 'CALLAHAN' => '030',
        trim(county_name) = 'CAMERON' => '031',
        trim(county_name) = 'CAMP' => '032',
        trim(county_name) = 'CARSON' => '033',
        trim(county_name) = 'CASS' => '034',
        trim(county_name) = 'CASTRO' => '035',
        trim(county_name) = 'CHAMBERS' => '036',
        trim(county_name) = 'CHEROKEE' => '037',
        trim(county_name) = 'CHILDRESS' => '038',
        trim(county_name) = 'CLAY' => '039',
        trim(county_name) = 'COCHRAN' => '040',
        trim(county_name) = 'COKE' => '041',
        trim(county_name) = 'COLEMAN' => '042',
        trim(county_name) = 'COLLIN' => '043',
        trim(county_name) = 'COLLINGSWORTH' => '044',
        trim(county_name) = 'COLORADO' => '045',
        trim(county_name) = 'COMAL' => '046',
        trim(county_name) = 'COMANCHE' => '047',
        trim(county_name) = 'CONCHO' => '048',
        trim(county_name) = 'COOKE' => '049',
        trim(county_name) = 'CORYELL' => '050',
        trim(county_name) = 'COTTLE' => '051',
        trim(county_name) = 'CRANE' => '052',
        trim(county_name) = 'CROCKETT' => '053',
        trim(county_name) = 'CROSBY' => '054',
        trim(county_name) = 'CULBERSON' => '055',
        trim(county_name) = 'DALLAM' => '056',
        trim(county_name) = 'DALLAS' => '057',
        trim(county_name) = 'DAWSON' => '058',
        trim(county_name) = 'DEAF SMITH' => '059',
        trim(county_name) = 'DELTA' => '060',
        trim(county_name) = 'DENTON' => '061',
        trim(county_name) = 'DEWITT' => '062',
        trim(county_name) = 'DICKENS' => '063',
        trim(county_name) = 'DIMMIT' => '064',
        trim(county_name) = 'DONLEY' => '065',
        trim(county_name) = 'DUVAL' => '066',
        trim(county_name) = 'EASTLAND' => '067',
        trim(county_name) = 'ECTOR' => '068',
        trim(county_name) = 'EDWARDS' => '069',
        trim(county_name) = 'ELLIS' => '070',
        trim(county_name) = 'EL PASO' => '071',
        trim(county_name) = 'ERATH' => '072',
        trim(county_name) = 'FALLS' => '073',
        trim(county_name) = 'FANNIN' => '074',
        trim(county_name) = 'FAYETTE' => '075',
        trim(county_name) = 'FISHER' => '076',
        trim(county_name) = 'FLOYD' => '077',
        trim(county_name) = 'FOARD' => '078',
        trim(county_name) = 'FORT BEND' => '079',
        trim(county_name) = 'FRANKLIN' => '080',
        trim(county_name) = 'FREESTONE' => '081',
        trim(county_name) = 'FRIO' => '082',
        trim(county_name) = 'GAINES' => '083',
        trim(county_name) = 'GALVESTON' => '084',
        trim(county_name) = 'GARZA' => '085',
        trim(county_name) = 'GILLESPIE' => '086',
        trim(county_name) = 'GLASSCOCK' => '087',
        trim(county_name) = 'GOLIAD' => '088',
        trim(county_name) = 'GONZALES' => '089',
        trim(county_name) = 'GRAY' => '090',
        trim(county_name) = 'GRAYSON' => '091',
        trim(county_name) = 'GREGG' => '092',
        trim(county_name) = 'GRIMES' => '093',
        trim(county_name) = 'GUADALUPE' => '094',
        trim(county_name) = 'HALE' => '095',
        trim(county_name) = 'HALL' => '096',
        trim(county_name) = 'HAMILTON' => '097',
        trim(county_name) = 'HANSFORD' => '098',
        trim(county_name) = 'HARDEMAN' => '099',
        trim(county_name) = 'HARDIN' => '100',
        trim(county_name) = 'HARRIS' => '101',
        trim(county_name) = 'HARRISON' => '102',
        trim(county_name) = 'HARTLEY' => '103',
        trim(county_name) = 'HASKELL' => '104',
        trim(county_name) = 'HAYS' => '105',
        trim(county_name) = 'HEMPHILL' => '106',
        trim(county_name) = 'HENDERSON' => '107',
        trim(county_name) = 'HIDALGO' => '108',
        trim(county_name) = 'HILL' => '109',
        trim(county_name) = 'HOCKLEY' => '110',
        trim(county_name) = 'HOOD' => '111',
        trim(county_name) = 'HOPKINS' => '112',
        trim(county_name) = 'HOUSTON' => '113',
        trim(county_name) = 'HOWARD' => '114',
        trim(county_name) = 'HUDSPETH' => '115',
        trim(county_name) = 'HUNT' => '116',
        trim(county_name) = 'HUTCHINSON' => '117',
        trim(county_name) = 'IRION' => '118',
        trim(county_name) = 'JACK' => '119',
        trim(county_name) = 'JACKSON' => '120',
        trim(county_name) = 'JASPER' => '121',
        trim(county_name) = 'JEFF DAVIS' => '122',
        trim(county_name) = 'JEFFERSON' => '123',
        trim(county_name) = 'JIM HOGG' => '124',
        trim(county_name) = 'JIM WELLS' => '125',
        trim(county_name) = 'JOHNSON' => '126',
        trim(county_name) = 'JONES' => '127',
        trim(county_name) = 'KARNES' => '128',
        trim(county_name) = 'KAUFMAN' => '129',
        trim(county_name) = 'KENDALL' => '130',
        trim(county_name) = 'KENEDY' => '131',
        trim(county_name) = 'KENT' => '132',
        trim(county_name) = 'KERR' => '133',
        trim(county_name) = 'KIMBLE' => '134',
        trim(county_name) = 'KING' => '135',
        trim(county_name) = 'KINNEY' => '136',
        trim(county_name) = 'KLEBERG' => '137',
        trim(county_name) = 'KNOX' => '138',
        trim(county_name) = 'LAMAR' => '139',
        trim(county_name) = 'LAMB' => '140',
        trim(county_name) = 'LAMPASAS' => '141',
        trim(county_name) = 'LA SALLE' => '142',
        trim(county_name) = 'LAVACA' => '143',
        trim(county_name) = 'LEE' => '144',
        trim(county_name) = 'LEON' => '145',
        trim(county_name) = 'LIBERTY' => '146',
        trim(county_name) = 'LIMESTONE' => '147',
        trim(county_name) = 'LIPSCOMB' => '148',
        trim(county_name) = 'LIVE OAK' => '149',
        trim(county_name) = 'LLANO' => '150',
        trim(county_name) = 'LOVING' => '151',
        trim(county_name) = 'LUBBOCK' => '152',
        trim(county_name) = 'LYNN' => '153',
        trim(county_name) = 'MADISON' => '154',
        trim(county_name) = 'MARION' => '155',
        trim(county_name) = 'MARTIN' => '156',
        trim(county_name) = 'MASON' => '157',
        trim(county_name) = 'MATAGORDA' => '158',
        trim(county_name) = 'MAVERICK' => '159',
        trim(county_name) = 'MCCULLOCH' => '160',
        trim(county_name) = 'MCLENNAN' => '161',
        trim(county_name) = 'MCMULLEN' => '162',
        trim(county_name) = 'MEDINA' => '163',
        trim(county_name) = 'MENARD' => '164',
        trim(county_name) = 'MIDLAND' => '165',
        trim(county_name) = 'MILAM' => '166',
        trim(county_name) = 'MILLS' => '167',
        trim(county_name) = 'MITCHELL' => '168',
        trim(county_name) = 'MONTAGUE' => '169',
        trim(county_name) = 'MONTGOMERY' => '170',
        trim(county_name) = 'MOORE' => '171',
        trim(county_name) = 'MORRIS' => '172',
        trim(county_name) = 'MOTLEY' => '173',
        trim(county_name) = 'NACOGDOCHES' => '174',
        trim(county_name) = 'NAVARRO' => '175',
        trim(county_name) = 'NEWTON' => '176',
        trim(county_name) = 'NOLAN' => '177',
        trim(county_name) = 'NUECES' => '178',
        trim(county_name) = 'OCHILTREE' => '179',
        trim(county_name) = 'OLDHAM' => '180',
        trim(county_name) = 'ORANGE' => '181',
        trim(county_name) = 'PALO PINTO' => '182',
        trim(county_name) = 'PANOLA' => '183',
        trim(county_name) = 'PARKER' => '184',
        trim(county_name) = 'PARMER' => '185',
        trim(county_name) = 'PECOS' => '186',
        trim(county_name) = 'POLK' => '187',
        trim(county_name) = 'POTTER' => '188',
        trim(county_name) = 'PRESIDIO' => '189',
        trim(county_name) = 'RAINS' => '190',
        trim(county_name) = 'RANDALL' => '191',
        trim(county_name) = 'REAGAN' => '192',
        trim(county_name) = 'REAL' => '193',
        trim(county_name) = 'RED RIVER' => '194',
        trim(county_name) = 'REEVES' => '195',
        trim(county_name) = 'REFUGIO' => '196',
        trim(county_name) = 'ROBERTS' => '197',
        trim(county_name) = 'ROBERTSON' => '198',
        trim(county_name) = 'ROCKWALL' => '199',
        trim(county_name) = 'RUNNELS' => '200',
        trim(county_name) = 'RUSK' => '201',
        trim(county_name) = 'SABINE' => '202',
        trim(county_name) = 'SAN AUGUSTINE' => '203',
        trim(county_name) = 'SAN JACINTO' => '204',
        trim(county_name) = 'SAN PATRICIO' => '205',
        trim(county_name) = 'SAN SABA' => '206',
        trim(county_name) = 'SCHLEICHER' => '207',
        trim(county_name) = 'SCURRY' => '208',
        trim(county_name) = 'SHACKELFORD' => '209',
        trim(county_name) = 'SHELBY' => '210',
        trim(county_name) = 'SHERMAN' => '211',
        trim(county_name) = 'SMITH' => '212',
        trim(county_name) = 'SOMERVELL' => '213',
        trim(county_name) = 'STARR' => '214',
        trim(county_name) = 'STEPHENS' => '215',
        trim(county_name) = 'STERLING' => '216',
        trim(county_name) = 'STONEWALL' => '217',
        trim(county_name) = 'SUTTON' => '218',
        trim(county_name) = 'SWISHER' => '219',
        trim(county_name) = 'TARRANT' => '220',
        trim(county_name) = 'TAYLOR' => '221',
        trim(county_name) = 'TERRELL' => '222',
        trim(county_name) = 'TERRY' => '223',
        trim(county_name) = 'THROCKMORTON' => '224',
        trim(county_name) = 'TITUS' => '225',
        trim(county_name) = 'TOM GREEN' => '226',
        trim(county_name) = 'TRAVIS' => '227',
        trim(county_name) = 'TRINITY' => '228',
        trim(county_name) = 'TYLER' => '229',
        trim(county_name) = 'UPSHUR' => '230',
        trim(county_name) = 'UPTON' => '231',
        trim(county_name) = 'UVALDE' => '232',
        trim(county_name) = 'VAL VERDE' => '233',
        trim(county_name) = 'VAN ZANDT' => '234',
        trim(county_name) = 'VICTORIA' => '235',
        trim(county_name) = 'WALKER' => '236',
        trim(county_name) = 'WALLER' => '237',
        trim(county_name) = 'WARD' => '238',
        trim(county_name) = 'WASHINGTON' => '239',
        trim(county_name) = 'WEBB' => '240',
        trim(county_name) = 'WHARTON' => '241',
        trim(county_name) = 'WHEELER' => '242',
        trim(county_name) = 'WICHITA' => '243',
        trim(county_name) = 'WILBARGER' => '244',
        trim(county_name) = 'WILLACY' => '245',
        trim(county_name) = 'WILLIAMSON' => '246',
        trim(county_name) = 'WILSON' => '247',
        trim(county_name) = 'WINKLER' => '248',
        trim(county_name) = 'WISE' => '249',
        trim(county_name) = 'WOOD' => '250',
        trim(county_name) = 'YOAKUM' => '251',
        trim(county_name) = 'YOUNG' => '252',
        trim(county_name) = 'ZAPATA' => '253',
        trim(county_name) = 'ZAVALA' => '254', ' ');

// ------------------------------------------------------------------------
// -- mapGA function
// ------------------------------------------------------------------------
string3 mapGA(string18 county_name) :=
MAP(
        trim(county_name) = 'APPLING' => '001',
        trim(county_name) = 'ATKINSON' => '002',
        trim(county_name) = 'BACON' => '003',
        trim(county_name) = 'BAKER' => '004',
        trim(county_name) = 'BALDWIN' => '005',
        trim(county_name) = 'BANKS' => '006',
        trim(county_name) = 'BARROW' => '007',
        trim(county_name) = 'BARTOW' => '008',
        trim(county_name) = 'BEN HILL' => '009',
        trim(county_name) = 'BERRIEN' => '010',
        trim(county_name) = 'BIBB' => '011',
        trim(county_name) = 'BLECKLEY' => '012',
        trim(county_name) = 'BRANTLEY' => '013',
        trim(county_name) = 'BROOKS' => '014',
        trim(county_name) = 'BRYAN' => '015',
        trim(county_name) = 'BULLOCH' => '016',
        trim(county_name) = 'BURKE' => '017',
        trim(county_name) = 'BUTTS' => '018',
        trim(county_name) = 'CALHOUN' => '019',
        trim(county_name) = 'CAMDEN' => '020',
        trim(county_name) = 'CANDLER' => '021',
        trim(county_name) = 'CARROLL' => '022',
        trim(county_name) = 'CATOOSA' => '023',
        trim(county_name) = 'CHARLTON' => '024',
        trim(county_name) = 'CHATHAM' => '025',
        trim(county_name) = 'CHATTAHOOCHEE' => '026',
        trim(county_name) = 'CHATTOOGA' => '027',
        trim(county_name) = 'CHEROKEE' => '028',
        trim(county_name) = 'CLARKE' => '029',
        trim(county_name) = 'CLAY' => '030',
        trim(county_name) = 'CLAYTON' => '031',
        trim(county_name) = 'CLINCH' => '032',
        trim(county_name) = 'COBB' => '033',
        trim(county_name) = 'COFFEE' => '034',
        trim(county_name) = 'COLQUITT' => '035',
        trim(county_name) = 'COLUMBIA' => '036',
        trim(county_name) = 'COOK' => '037',
        trim(county_name) = 'COWETA' => '038',
        trim(county_name) = 'CRAWFORD' => '039',
        trim(county_name) = 'CRISP' => '040',
        trim(county_name) = 'DADE' => '041',
        trim(county_name) = 'DAWSON' => '042',
        trim(county_name) = 'DECATUR' => '043',
        trim(county_name) = 'DEKALB' => '044',
        trim(county_name) = 'DODGE' => '045',
        trim(county_name) = 'DOOLY' => '046',
        trim(county_name) = 'DOUGHERTY' => '047',
        trim(county_name) = 'DOUGLAS' => '048',
        trim(county_name) = 'EARLY' => '049',
        trim(county_name) = 'ECHOLS' => '050',
        trim(county_name) = 'EFFINGHAM' => '051',
        trim(county_name) = 'ELBERT' => '052',
        trim(county_name) = 'EMANUEL' => '053',
        trim(county_name) = 'EVANS' => '054',
        trim(county_name) = 'FANNIN' => '055',
        trim(county_name) = 'FAYETTE' => '056',
        trim(county_name) = 'FLOYD' => '057',
        trim(county_name) = 'FORSYTH' => '058',
        trim(county_name) = 'FRANKLIN' => '059',
        trim(county_name) = 'FULTON' => '060',
        trim(county_name) = 'GILMER' => '061',
        trim(county_name) = 'GLASCOCK' => '062',
        trim(county_name) = 'GLYNN' => '063',
        trim(county_name) = 'GORDON' => '064',
        trim(county_name) = 'GRADY' => '065',
        trim(county_name) = 'GREENE' => '066',
        trim(county_name) = 'GWINNETT' => '067',
        trim(county_name) = 'HABERSHAM' => '068',
        trim(county_name) = 'HALL' => '069',
        trim(county_name) = 'HANCOCK' => '070',
        trim(county_name) = 'HARALSON' => '071',
        trim(county_name) = 'HARRIS' => '072',
        trim(county_name) = 'HART' => '073',
        trim(county_name) = 'HEARD' => '074',
        trim(county_name) = 'HENRY' => '075',
        trim(county_name) = 'HOUSTON' => '076',
        trim(county_name) = 'IRWIN' => '077',
        trim(county_name) = 'JACKSON' => '078',
        trim(county_name) = 'JASPER' => '079',
        trim(county_name) = 'JEFF DAVIS' => '080',
        trim(county_name) = 'JEFFERSON' => '081',
        trim(county_name) = 'JENKINS' => '082',
        trim(county_name) = 'JOHNSON' => '083',
        trim(county_name) = 'JONES' => '084',
        trim(county_name) = 'LAMAR' => '085',
        trim(county_name) = 'LANIER' => '086',
        trim(county_name) = 'LAURENS' => '087',
        trim(county_name) = 'LEE' => '088',
        trim(county_name) = 'LIBERTY' => '089',
        trim(county_name) = 'LINCOLN' => '090',
        trim(county_name) = 'LONG' => '091',
        trim(county_name) = 'LOWNDES' => '092',
        trim(county_name) = 'LUMPKIN' => '093',
        trim(county_name) = 'MACON' => '094',
        trim(county_name) = 'MADISON' => '095',
        trim(county_name) = 'MARION' => '096',
        trim(county_name) = 'MCDUFFIE' => '097',
        trim(county_name) = 'MCINTOSH' => '098',
        trim(county_name) = 'MERIWETHER' => '099',
        trim(county_name) = 'MILLER' => '100',
        trim(county_name) = 'MITCHELL' => '101',
        trim(county_name) = 'MONROE' => '102',
        trim(county_name) = 'MONTGOMERY' => '103',
        trim(county_name) = 'MORGAN' => '104',
        trim(county_name) = 'MURRAY' => '105',
        trim(county_name) = 'MUSCOGEE' => '106',
        trim(county_name) = 'NEWTON' => '107',
        trim(county_name) = 'OCONEE' => '108',
        trim(county_name) = 'OGLETHORPE' => '109',
        trim(county_name) = 'PAULDING' => '110',
        trim(county_name) = 'PEACH' => '111',
        trim(county_name) = 'PICKENS' => '112',
        trim(county_name) = 'PIERCE' => '113',
        trim(county_name) = 'PIKE' => '114',
        trim(county_name) = 'POLK' => '115',
        trim(county_name) = 'PULASKI' => '116',
        trim(county_name) = 'PUTNAM' => '117',
        trim(county_name) = 'QUITMAN' => '118',
        trim(county_name) = 'RABUN' => '119',
        trim(county_name) = 'RANDOLPH' => '120',
        trim(county_name) = 'RICHMOND' => '121',
        trim(county_name) = 'ROCKDALE' => '122',
        trim(county_name) = 'SCHLEY' => '123',
        trim(county_name) = 'SCREVEN' => '124',
        trim(county_name) = 'SEMINOLE' => '125',
        trim(county_name) = 'SPALDING' => '126',
        trim(county_name) = 'STEPHENS' => '127',
        trim(county_name) = 'STEWART' => '128',
        trim(county_name) = 'SUMTER' => '129',
        trim(county_name) = 'TALBOT' => '130',
        trim(county_name) = 'TALIAFERRO' => '131',
        trim(county_name) = 'TATTNALL' => '132',
        trim(county_name) = 'TAYLOR' => '133',
        trim(county_name) = 'TELFAIR' => '134',
        trim(county_name) = 'TERRELL' => '135',
        trim(county_name) = 'THOMAS' => '136',
        trim(county_name) = 'TIFT' => '137',
        trim(county_name) = 'TOOMBS' => '138',
        trim(county_name) = 'TOWNS' => '139',
        trim(county_name) = 'TREUTLEN' => '140',
        trim(county_name) = 'TROUP' => '141',
        trim(county_name) = 'TURNER' => '142',
        trim(county_name) = 'TWIGGS' => '143',
        trim(county_name) = 'UNION' => '144',
        trim(county_name) = 'UPSON' => '145',
        trim(county_name) = 'WALKER' => '146',
        trim(county_name) = 'WALTON' => '147',
        trim(county_name) = 'WARE' => '148',
        trim(county_name) = 'WARREN' => '149',
        trim(county_name) = 'WASHINGTON' => '150',
        trim(county_name) = 'WAYNE' => '151',
        trim(county_name) = 'WEBSTER' => '152',
        trim(county_name) = 'WHEELER' => '153',
        trim(county_name) = 'WHITE' => '154',
        trim(county_name) = 'WHITFIELD' => '155',
        trim(county_name) = 'WILCOX' => '156',
        trim(county_name) = 'WILKES' => '157',
        trim(county_name) = 'WILKINSON' => '158',
        trim(county_name) = 'WORTH' => '159', ' ');

// ------------------------------------------------------------------------
// -- mapUT function
// ------------------------------------------------------------------------
string2 mapUT(string18 county_name) :=
MAP(
        trim(county_name) = 'BEAVER' => '01',
        trim(county_name) = 'BOX ELDER' => '02',
        trim(county_name) = 'CACHE' => '03',
        trim(county_name) = 'CARBON' => '04',
        trim(county_name) = 'DAGGETT' => '05',
        trim(county_name) = 'DAVIS' => '06',
        trim(county_name) = 'DUCHESNE' => '07',
        trim(county_name) = 'EMERY' => '08',
        trim(county_name) = 'GARFIELD' => '09',
        trim(county_name) = 'GRAND' => '10',
        trim(county_name) = 'IRON' => '11',
        trim(county_name) = 'JUAB' => '12',
        trim(county_name) = 'KANE' => '13',
        trim(county_name) = 'MILLARD' => '14',
        trim(county_name) = 'MORGAN' => '15',
        trim(county_name) = 'PIUTE' => '16',
        trim(county_name) = 'RICH' => '17',
        trim(county_name) = 'SALT LAKE' => '18',
        trim(county_name) = 'SAN JUAN' => '19',
        trim(county_name) = 'SANPETE' => '20',
        trim(county_name) = 'SEVIER' => '21',
        trim(county_name) = 'SUMMIT' => '22',
        trim(county_name) = 'TOOELE' => '23',
        trim(county_name) = 'UINTAH' => '24',
        trim(county_name) = 'UTAH' => '25',
        trim(county_name) = 'WASATCH' => '26',
        trim(county_name) = 'WASHINGTON' => '27',
        trim(county_name) = 'WAYNE' => '28',
        trim(county_name) = 'WEBER' => '29', ' ');

// ------------------------------------------------------------------------
// -- mapAL function
// ------------------------------------------------------------------------
string2 mapAL(string18 county_name) :=
MAP(
        trim(county_name) = 'JEFFERSON' => '01',
        trim(county_name) = 'MOBILE' => '02',
        trim(county_name) = 'MONTGOMERY' => '03',
        trim(county_name) = 'AUTAUGA' => '04',
        trim(county_name) = 'BALDWIN' => '05',
        trim(county_name) = 'BARBOUR' => '06',
        trim(county_name) = 'BLOUNT' => '08',
        trim(county_name) = 'BULLOCK' => '09',
        trim(county_name) = 'BUTLER' => '10',
        trim(county_name) = 'CALHOUN' => '11',
        trim(county_name) = 'CHAMBERS' => '12',
        trim(county_name) = 'CHEROKEE' => '13',
        trim(county_name) = 'CHILTON' => '14',
        trim(county_name) = 'CHOCTAW' => '15',
        trim(county_name) = 'CLARKE' => '16',
        trim(county_name) = 'CLAY' => '17',
        trim(county_name) = 'CLEBURNE' => '18',
        trim(county_name) = 'COFFEE' => '19',
        trim(county_name) = 'COLBERT' => '20',
        trim(county_name) = 'CONECUH' => '21',
        trim(county_name) = 'COOSA' => '22',
        trim(county_name) = 'COVINGTON' => '23',
        trim(county_name) = 'CRENSHAW' => '24',
        trim(county_name) = 'CULLMAN' => '25',
        trim(county_name) = 'DALE' => '26',
        trim(county_name) = 'DALLAS' => '27',
        trim(county_name) = 'DEKALB' => '28',
        trim(county_name) = 'ELMORE' => '29',
        trim(county_name) = 'ESCAMBIA' => '30',
        trim(county_name) = 'ETOWAH' => '31',
        trim(county_name) = 'FRANKLIN' => '33',
        trim(county_name) = 'GENEVA' => '34',
        trim(county_name) = 'GREENE' => '35',
        trim(county_name) = 'HALE' => '36',
        trim(county_name) = 'HENRY' => '37',
        trim(county_name) = 'HOUSTON' => '38',
        trim(county_name) = 'JACKSON' => '39',
        trim(county_name) = 'LAMAR' => '40',
        trim(county_name) = 'LAUDERDALE' => '41',
        trim(county_name) = 'LAWRENCE' => '42',
        trim(county_name) = 'LEE' => '43',
        trim(county_name) = 'LIMESTONE' => '44',
        trim(county_name) = 'LOWNDES' => '45',
        trim(county_name) = 'MACON' => '46',
        trim(county_name) = 'MADISON' => '47',
        trim(county_name) = 'MARENGO' => '48',
        trim(county_name) = 'MARION' => '49',
        trim(county_name) = 'MARSHALL' => '50',
        trim(county_name) = 'MONROE' => '51',
        trim(county_name) = 'MORGAN' => '52',
        trim(county_name) = 'PERRY' => '53',
        trim(county_name) = 'PIKE' => '55',
        trim(county_name) = 'RANDOLPH' => '56',
        trim(county_name) = 'RUSSELL' => '57',
        trim(county_name) = 'SHELBY' => '58',
        trim(county_name) = 'ST. CLAIR' => '59',
        trim(county_name) = 'SUMTER' => '60',
        trim(county_name) = 'TALLADEGA' => '61',
        trim(county_name) = 'TALLAPOOSA' => '62',
        trim(county_name) = 'TUSCALOOSA' => '63',
        trim(county_name) = 'WALKER' => '64',
        trim(county_name) = 'WILCOX' => '65',
        trim(county_name) = 'WINSTON' => '66', ' ');

// ------------------------------------------------------------------------
// -- mapAR function
// ------------------------------------------------------------------------
string2 mapAR(string18 county_name) :=
MAP(
        trim(county_name) = 'ARKANSAS A' => '01',
        trim(county_name) = 'ARKANSAS B' => '02',
        trim(county_name) = 'ASHLEY' => '03',
        trim(county_name) = 'BAXTER' => '04',
        trim(county_name) = 'BENTON' => '05',
        trim(county_name) = 'BOONE' => '06',
        trim(county_name) = 'BRADLEY' => '07',
        trim(county_name) = 'CALHOUN' => '08',
        trim(county_name) = 'CARROLL A' => '09',
        trim(county_name) = 'CARROLL B' => '10',
        trim(county_name) = 'CHICOT' => '11',
        trim(county_name) = 'CLARK' => '12',
        trim(county_name) = 'CLAY A' => '13',
        trim(county_name) = 'CLAY B' => '14',
        trim(county_name) = 'CLEBURNE' => '15',
        trim(county_name) = 'CLEVELAND' => '16',
        trim(county_name) = 'COLUMBIA' => '17',
        trim(county_name) = 'CONWAY' => '18',
        trim(county_name) = 'CRAIGHEAD A' => '19',
        trim(county_name) = 'CRAIGHEAD B' => '20',
        trim(county_name) = 'CRAWFORD' => '21',
        trim(county_name) = 'CRITTENDEN' => '22',
        trim(county_name) = 'CROSS' => '23',
        trim(county_name) = 'DALLAS' => '24',
        trim(county_name) = 'DESHA' => '25',
        trim(county_name) = 'DREW' => '26',
        trim(county_name) = 'FAULKNER' => '27',
        trim(county_name) = 'FRANKLIN A' => '28',
        trim(county_name) = 'FRANKLIN B' => '29',
        trim(county_name) = 'FULTON' => '30',
        trim(county_name) = 'GARLAND' => '31',
        trim(county_name) = 'GRANT' => '32',
        trim(county_name) = 'GREENE' => '33',
        trim(county_name) = 'HEMPSTEAD' => '34',
        trim(county_name) = 'HOT SPRING' => '35',
        trim(county_name) = 'HOWARD' => '36',
        trim(county_name) = 'INDEPENDENCE' => '37',
        trim(county_name) = 'IZARD' => '38',
        trim(county_name) = 'JACKSON' => '39',
        trim(county_name) = 'JEFFERSON' => '40',
        trim(county_name) = 'JOHNSON' => '41',
        trim(county_name) = 'LAFAYETTE' => '42',
        trim(county_name) = 'LAWRENCE' => '43',
        trim(county_name) = 'LEE' => '44',
        trim(county_name) = 'LINCOLN' => '45',
        trim(county_name) = 'LITTLE RIVER' => '46',
        trim(county_name) = 'LOGAN A' => '47',
        trim(county_name) = 'LOGAN B' => '48',
        trim(county_name) = 'LONOKE' => '49',
        trim(county_name) = 'MADISON' => '50',
        trim(county_name) = 'MARION' => '51',
        trim(county_name) = 'MILLER' => '52',
        trim(county_name) = 'MISSISSIPPI A' => '53',
        trim(county_name) = 'MISSISSIPPI B' => '54',
        trim(county_name) = 'MONROE' => '55',
        trim(county_name) = 'MONTGOMERY' => '56',
        trim(county_name) = 'NEVADA' => '57',
        trim(county_name) = 'NEWTON' => '58',
        trim(county_name) = 'OUACHITA' => '59',
        trim(county_name) = 'PERRY' => '60',
        trim(county_name) = 'PHILLIPS' => '61',
        trim(county_name) = 'PIKE' => '62',
        trim(county_name) = 'POINSETT' => '63',
        trim(county_name) = 'POLK' => '64',
        trim(county_name) = 'POPE' => '65',
        trim(county_name) = 'PRAIRIE A' => '66',
        trim(county_name) = 'PRAIRIE B' => '67',
        trim(county_name) = 'PULASKI' => '68',
        trim(county_name) = 'RANDOLPH' => '69',
        trim(county_name) = 'SALINE' => '70',
        trim(county_name) = 'SCOTT' => '71',
        trim(county_name) = 'SEARCY' => '72',
        trim(county_name) = 'SEBASTIAN A' => '73',
        trim(county_name) = 'SEBASTIAN B' => '74',
        trim(county_name) = 'SEVIER' => '75',
        trim(county_name) = 'SHARP' => '76',
        trim(county_name) = 'ST. FRANCIS' => '77',
        trim(county_name) = 'STONE' => '78',
        trim(county_name) = 'UNION' => '79',
        trim(county_name) = 'VAN BUREN' => '80',
        trim(county_name) = 'WASHINGTON' => '81',
        trim(county_name) = 'WHITE' => '82',
        trim(county_name) = 'WOODRUFF' => '83',
        trim(county_name) = 'YELL A' => '84',
        trim(county_name) = 'YELL B' => '85', ' ');

// ------------------------------------------------------------------------
// -- mapMI function
// ------------------------------------------------------------------------
string2 mapMI(string18 county_name) :=
MAP(
        trim(county_name) = 'ALCONA' => '01',
        trim(county_name) = 'ALGER' => '02',
        trim(county_name) = 'ALLEGAN' => '03',
        trim(county_name) = 'ALPENA' => '04',
        trim(county_name) = 'ANTRIM' => '05',
        trim(county_name) = 'ARENAC' => '06',
        trim(county_name) = 'BARAGA' => '07',
        trim(county_name) = 'BARRY' => '08',
        trim(county_name) = 'BAY' => '09',
        trim(county_name) = 'BENZIE' => '10',
        trim(county_name) = 'BERRIEN' => '11',
        trim(county_name) = 'BRANCH' => '12',
        trim(county_name) = 'CALHOUN' => '13',
        trim(county_name) = 'CASS' => '14',
        trim(county_name) = 'CHARLEVOIX' => '15',
        trim(county_name) = 'CHEBOYGAN' => '16',
        trim(county_name) = 'CHIPPEWA' => '17',
        trim(county_name) = 'CLARE' => '18',
        trim(county_name) = 'CLINTON' => '19',
        trim(county_name) = 'CRAWFORD' => '20',
        trim(county_name) = 'DELTA' => '21',
        trim(county_name) = 'DICKINSON' => '22',
        trim(county_name) = 'EATON' => '23',
        trim(county_name) = 'EMMET' => '24',
        trim(county_name) = 'GENESEE' => '25',
        trim(county_name) = 'GLADWIN' => '26',
        trim(county_name) = 'GOGEBIC' => '27',
        trim(county_name) = 'GRAND TRAVERSE' => '28',
        trim(county_name) = 'GRATIOT' => '29',
        trim(county_name) = 'HILLSDALE' => '30',
        trim(county_name) = 'HOUGHTON' => '31',
        trim(county_name) = 'HURON' => '32',
        trim(county_name) = 'INGHAM' => '33',
        trim(county_name) = 'IONIA' => '34',
        trim(county_name) = 'IOSCO' => '35',
        trim(county_name) = 'IRON' => '36',
        trim(county_name) = 'ISABELLA' => '37',
        trim(county_name) = 'JACKSON' => '38',
        trim(county_name) = 'KALAMAZOO' => '39',
        trim(county_name) = 'KALKASKA' => '40',
        trim(county_name) = 'KENT' => '41',
        trim(county_name) = 'KEWEENAW' => '42',
        trim(county_name) = 'LAKE' => '43',
        trim(county_name) = 'LAPEER' => '44',
        trim(county_name) = 'LEELANAU' => '45',
        trim(county_name) = 'LENAWEE' => '46',
        trim(county_name) = 'LIVINGSTON' => '47',
        trim(county_name) = 'LUCE' => '48',
        trim(county_name) = 'MACKINAC' => '49',
        trim(county_name) = 'MACOMB' => '50',
        trim(county_name) = 'MANISTEE' => '51',
        trim(county_name) = 'MARQUETTE' => '52',
        trim(county_name) = 'MASON' => '53',
        trim(county_name) = 'MECOSTA' => '54',
        trim(county_name) = 'MENOMINEE' => '55',
        trim(county_name) = 'MIDLAND' => '56',
        trim(county_name) = 'MISSAUKEE' => '57',
        trim(county_name) = 'MONROE' => '58',
        trim(county_name) = 'MONTCALM' => '59',
        trim(county_name) = 'MONTMORENCY' => '60',
        trim(county_name) = 'MUSKEGON' => '61',
        trim(county_name) = 'NEWAYGO' => '62',
        trim(county_name) = 'OAKLAND' => '63',
        trim(county_name) = 'OCEANA' => '64',
        trim(county_name) = 'OGEMAW' => '65',
        trim(county_name) = 'ONTONAGON' => '66',
        trim(county_name) = 'OSCEOLA' => '67',
        trim(county_name) = 'OSCODA' => '68',
        trim(county_name) = 'OTSEGO' => '69',
        trim(county_name) = 'OTTAWA' => '70',
        trim(county_name) = 'PRESQUE ISLE' => '71',
        trim(county_name) = 'ROSCOMMON' => '72',
        trim(county_name) = 'SAGINAW' => '73',
        trim(county_name) = 'ST. CLARI' => '74',
        trim(county_name) = 'ST. JOSEPH' => '75',
        trim(county_name) = 'SANILAC' => '76',
        trim(county_name) = 'SCHOOLCRAFT' => '77',
        trim(county_name) = 'SHIAWASSEE' => '78',
        trim(county_name) = 'TUSCOLA' => '79',
        trim(county_name) = 'VAN BUREN' => '80',
        trim(county_name) = 'WASHTENAW' => '81',
        trim(county_name) = 'WAYNE' => '82',
        trim(county_name) = 'WEXFORD' => '83', ' ');

// ------------------------------------------------------------------------
// -- mapKS function
// ------------------------------------------------------------------------
string2 mapKS(string18 county_name) :=
MAP(
        trim(county_name) = 'ALLEN' => 'AL',
        trim(county_name) = 'ANDERSON' => 'AN',
        trim(county_name) = 'ATCHISON' => 'AT',
        trim(county_name) = 'BARBER' => 'BA',
        trim(county_name) = 'BARTON' => 'BT',
        trim(county_name) = 'BOURBON' => 'BB',
        trim(county_name) = 'BROWN' => 'BR',
        trim(county_name) = 'BUTLER' => 'BU',
        trim(county_name) = 'CHASE' => 'CS',
        trim(county_name) = 'CHAUTAUQUA' => 'CQ',
        trim(county_name) = 'CHEROKEE' => 'CK',
        trim(county_name) = 'CHEYENNE' => 'CN',
        trim(county_name) = 'CLARK' => 'CA',
        trim(county_name) = 'CLAY' => 'CY',
        trim(county_name) = 'CLOUD' => 'CD',
        trim(county_name) = 'COFFEY' => 'CF',
        trim(county_name) = 'COMANCHE' => 'CM',
        trim(county_name) = 'COWLEY' => 'CL',
        trim(county_name) = 'CRAWFORD' => 'CR',
        trim(county_name) = 'DECATUR' => 'DC',
        trim(county_name) = 'DICKINSON' => 'DK',
        trim(county_name) = 'DONIPHAN' => 'DP',
        trim(county_name) = 'DOUGLAS' => 'DG',
        trim(county_name) = 'EDWARDS' => 'ED',
        trim(county_name) = 'ELK' => 'EK',
        trim(county_name) = 'ELLIS' => 'EL',
        trim(county_name) = 'ELLSWORTH' => 'EW',
        trim(county_name) = 'FINNEY' => 'FI',
        trim(county_name) = 'FORD' => 'FO',
        trim(county_name) = 'FRANKLIN' => 'FR',
        trim(county_name) = 'GEARY' => 'GE',
        trim(county_name) = 'GOVE' => 'GO',
        trim(county_name) = 'GRAHAM' => 'GH',
        trim(county_name) = 'GRANT' => 'GT',
        trim(county_name) = 'GRAY' => 'GY',
        trim(county_name) = 'GREELEY' => 'GL',
        trim(county_name) = 'GREENWOOD' => 'GW',
        trim(county_name) = 'HAMILTON' => 'HM',
        trim(county_name) = 'HARPER' => 'HP',
        trim(county_name) = 'HARVEY' => 'HV',
        trim(county_name) = 'HASKILL' => 'HS',
        trim(county_name) = 'HODGEMAN' => 'HG',
        trim(county_name) = 'JACKSON' => 'JA',
        trim(county_name) = 'JEFFERSON' => 'JF',
        trim(county_name) = 'JEWELL' => 'JW',
        trim(county_name) = 'JOHNSON' => 'JO',
        trim(county_name) = 'KEARNY' => 'KE',
        trim(county_name) = 'KINGMAN' => 'KM',
        trim(county_name) = 'KIOWA' => 'KW',
        trim(county_name) = 'LABETTE' => 'LB',
        trim(county_name) = 'LANE' => 'LE',
        trim(county_name) = 'LEAVENWORTH' => 'LV',
        trim(county_name) = 'LINCOLN' => 'LC',
        trim(county_name) = 'LINN' => 'LN',
        trim(county_name) = 'LOGAN' => 'LG',
        trim(county_name) = 'LYON' => 'LY',
        trim(county_name) = 'MARION' => 'MN',
        trim(county_name) = 'MARSHALL' => 'MS',
        trim(county_name) = 'MCPHERSON' => 'MP',
        trim(county_name) = 'MEADE' => 'ME',
        trim(county_name) = 'MIAMI' => 'MI',
        trim(county_name) = 'MITCHELL' => 'MC',
        trim(county_name) = 'MONTGOMERY' => 'MG',
        trim(county_name) = 'MORRIS' => 'MR',
        trim(county_name) = 'MORTON' => 'MT',
        trim(county_name) = 'NEMAHA' => 'NM',
        trim(county_name) = 'NEOSHO' => 'NO',
        trim(county_name) = 'NESS' => 'NS',
        trim(county_name) = 'NORTON' => 'NT',
        trim(county_name) = 'OSAGE' => 'OS',
        trim(county_name) = 'OSBORNE' => 'OB',
        trim(county_name) = 'OTTAWA' => 'OT',
        trim(county_name) = 'PAWNEE' => 'PN',
        trim(county_name) = 'PHILLIPS' => 'PL',
        trim(county_name) = 'POTTAWATOMIE' => 'PT',
        trim(county_name) = 'PRATT' => 'PR',
        trim(county_name) = 'RAWLINS' => 'RA',
        trim(county_name) = 'RENO' => 'RN',
        trim(county_name) = 'REPUBLIC' => 'RP',
        trim(county_name) = 'RICE' => 'RC',
        trim(county_name) = 'RILEY' => 'RL',
        trim(county_name) = 'ROOKS' => 'RO',
        trim(county_name) = 'RUSH' => 'RH',
        trim(county_name) = 'RUSSELL' => 'RS',
        trim(county_name) = 'SALINE' => 'SA',
        trim(county_name) = 'SCOTT' => 'SC',
        trim(county_name) = 'SEDGWICK' => 'SG',
        trim(county_name) = 'SEWARD' => 'SW',
        trim(county_name) = 'SHAWNEE' => 'SN',
        trim(county_name) = 'SHERIDAN' => 'SD',
        trim(county_name) = 'SHERMAN' => 'SH',
        trim(county_name) = 'SMITH' => 'SM',
        trim(county_name) = 'STAFFORD' => 'SF',
        trim(county_name) = 'STANTON' => 'ST',
        trim(county_name) = 'STEVENS' => 'SV',
        trim(county_name) = 'SUMNER' => 'SU',
        trim(county_name) = 'THOMAS' => 'TH',
        trim(county_name) = 'TREGO' => 'TR',
        trim(county_name) = 'WABAUNSEE' => 'WB',
        trim(county_name) = 'WALLACE' => 'WA',
        trim(county_name) = 'WASHINGTON' => 'WS',
        trim(county_name) = 'WICHITA' => 'WH',
        trim(county_name) = 'WILSON' => 'WL',
        trim(county_name) = 'WOODSON' => 'WO',
        trim(county_name) = 'WYANDOTTE' => 'WY', ' ');


// ------------------------------------------------------------------------
// -- mapCounty function to map emerges county to their CSRA county code field
// ------------------------------------------------------------------------
string10 mapCounty(string2 state, string3 fipscounty, string18 county_name) :=
MAP(
   state = 'CO' or state = 'OK' or state = 'RI' => county_name[1..10],
   state = 'DE' => county_name[1] + ' ' + county_name[1..8],
   state = 'IL' or state = 'MO' or state = 'NC' or state = 'OR' => fipscounty + county_name[1..7],
   state = 'NV' => county_name[1..7],
   state = 'NJ' or state = 'NY' or state = 'PA' or state = 'WA' => fipscounty,
   state = 'OH' => mapOhio(county_name) + county_name[1..8],
   state = 'SC' => mapSC(county_name),
   state = 'MN' => mapMN(county_name),
   state = 'TX' => mapTX(county_name),
   state = 'GA' => mapGA(county_name),
   state = 'UT' => mapUT(county_name),
   state = 'AL' => mapAL(county_name) + ' ' + county_name[1..7],
   state = 'AR' => mapAR(county_name) + ' ' + county_name[1..7],
   state = 'MI' => mapMI(county_name) + ' ' + county_name[1..7],
   state = 'KS' => mapKS(county_name),
   county_name[1..10]);


csra_layout convert2CSRA(csra_layout_temp l):= transform
  self.County_Code := mapCounty(L.State_Abbreviation,l.fipscounty, l.county_name);
  self := L;
end;

CSRA_voters_nonblankfips2 := project(csra_voters_joined,convert2CSRA(left));
count(CSRA_voters_nonblankfips2(State_Abbreviation != ''));
//count(CSRA_voters_nonblankfips2(county_name != ''));
//count(CSRA_voters_nonblankfips2(fipscounty != ''));

csra_layout convert2CSRA_blank(csra_layout_temp l):= transform
  self := L;
end;

CSRA_voters_blankfips2 := project(csra_voters_blankfips,convert2CSRA_blank(left));

CSRA_voters := CSRA_voters_nonblankfips2 + CSRA_voters_blankfips2;
//CSRA_voters := CSRA_voters_nonblankfips2;



output(CSRA_voters,,'out::csra_voters',overwrite);
count(csra_voters(County_Code != ''));
count(csra_voters(State_Abbreviation != ''));
count(csra_voters(State_Abbreviation != '' and County_Code != ''));
//count(csra_voters(county_name != ''));

