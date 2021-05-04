Import obituaries,ut, VersionControl,	PromoteSupers;

EXPORT Map_Newspaper_Conversion := function

file_date_in:= VersionControl.fGetFilenameVersion('~thor_data400::raw::tributes_newspaper');

ds_newspaper_in := Obituaries.files.newspaper_raw;

Obituaries.layouts.layout_reor_tribute TransNewspaper(obituaries.layouts.newspaper_raw l) := TRANSFORM
	 self.filedate		    :=	(string8)file_date_in;
   self.person_id 	    :=	ut.fn_RemoveSpecialChars(l.Obituary_ID);
	 self.rec_type		    :=	'';
	 self.prefix					:=	'';
   self.fname						:=	ut.CleanSpacesAndUpper(stringlib.StringFindReplace(ut.fn_RemoveSpecialChars(l.first_name),'.',''));
   self.mname						:=	ut.CleanSpacesAndUpper(stringlib.StringFindReplace(ut.fn_RemoveSpecialChars(l.middle_name),'.',''));
   self.lname						:=	ut.CleanSpacesAndUpper(stringlib.StringFindReplace(ut.fn_RemoveSpecialChars(l.last_name),'.',''));
   self.name_suffix			:=	'';
   self.Maiden_Name     :=  ut.CleanSpacesAndUpper(l.Maiden_Name);
   self.Nick_Name       :=  ut.CleanSpacesAndUpper(l.Nick_Name);
   self.gender					:=	'';
   self.age							:=	ut.fn_RemoveSpecialChars(l.age);
	 TrimDoB              :=  IF(trim(l.dob,left,right) != '00000000',trim(ut.fn_RemoveSpecialChars(l.dob),left,right),'');
	 TrimDoD              :=  IF(trim(l.dod,left,right) != '00000000',trim(ut.fn_RemoveSpecialChars(l.dod),left,right),'');
   self.birth_month			:=	if(TrimDoB <> '', TrimDoB[1..2],'');
   self.birth_day				:=	if(TrimDoB <> '', TrimDoB[3..4],'');
	 self.birth_year			:=	if(TrimDoB <> '', TrimDoB[5..8],'');
   self.death_month 		:=	if(TrimDoD <> '', TrimDoD[1..2],'');
   self.death_day				:=	if(TrimDoD <> '', TrimDoD[3..4],'');
   self.death_year			:=	if(TrimDoD <> '', TrimDoD[5..8],'');
	 Trim_City            :=  ut.CleanSpacesAndUpper(ut.fn_RemoveSpecialChars(l.Funeral_Service_in_City));
	 Trim_State           :=  ut.CleanSpacesAndUpper(ut.fn_RemoveSpecialChars(l.Funeral_Service_in_State));
   self.location_city		:=	IF(Trim_City = 'N/A','',Trim_City);
   self.location_state	:=	MAP(Trim_State = 'ALABAMA'  =>	'AL',
																Trim_State = 'ALASKA'   =>	'AK',
																Trim_State = 'ARIZONA'  =>	'AZ',
																Trim_State = 'ARKANSAS' =>	'AR',
																Trim_State = 'CALIFORNIA' =>	'CA',
																Trim_State = 'COLORADO'   =>	'CO',
																Trim_State = 'CONNECTICUT' =>	'CT',		
																Trim_State = 'DELAWARE' =>	'DE',
																Trim_State = 'FLORIDA' =>	'FL',
																Trim_State = 'GEORGIA' =>	'GA',
																Trim_State = 'HAWAII'  =>	'HI',
																Trim_State = 'IDAHO'   =>	'ID',
																Trim_State = 'ILLINOIS' =>	'IL',
																Trim_State = 'INDIANA'  =>	'IN',
																Trim_State = 'IOWA'   =>	'IA',
																Trim_State = 'KANSAS' =>	'KS',
																Trim_State = 'KENTUCKY' =>	'KY',
																Trim_State = 'LOUISIANA' =>	'LA',
																Trim_State = 'MAINE' =>	'ME',
																Trim_State = 'MARYLAND' =>	'MD',
																Trim_State = 'MASSACHUSETTS' =>	'MA',
																Trim_State = 'MICHIGAN' =>	'MI',
																Trim_State = 'MINNESOTA' =>	'MN',
																Trim_State = 'MISSISSIPPI' =>	'MS',
																Trim_State = 'MISSOURI' =>	'MO',
																Trim_State = 'MONTANA' =>	'MT',
																Trim_State = 'NEBRASKA' =>	'NE',
																Trim_State = 'NEVADA' =>	'NV',
																Trim_State = 'NEW HAMPSHIRE' =>	'NH',
																Trim_State = 'NEW JERSEY' =>	'NJ',
																Trim_State = 'NEW MEXICO' =>	'NM',
																Trim_State = 'NEW YORK' =>	'NY',
																Trim_State = 'NORTH CAROLINA' =>	'NC',
																Trim_State = 'NORTH DAKOTA' =>	'ND',
																Trim_State = 'OHIO' =>	'OH',
																Trim_State = 'OKLAHOMA' =>	'OK',
																Trim_State = 'OREGON' =>	'OR',
																Trim_State = 'PENNSYLVANIA' =>	'PA',
																Trim_State = 'RHODE ISLAND' =>	'RI',
																Trim_State = 'SOUTH CAROLINA' =>	'SC',
																Trim_State = 'SOUTH DAKOTA' =>	'SD',
																Trim_State = 'TENNESSEE' =>	'TN',
																Trim_State = 'TEXAS' =>	'TX',
																Trim_State = 'UTAH' =>	'UT',
																Trim_State = 'VERMONT' =>	'VT',
																Trim_State = 'VIRGINIA' =>	'VA',
																Trim_State = 'WASHINGTON' =>	'WA',
																Trim_State = 'WEST VIRGINIA' =>	'WV',
																Trim_State = 'WISCONSIN' =>	'WI',
																Trim_State = 'WYOMING' =>	'WY',
																Trim_State = 'N/A' => '',
																Trim_State);																												
	 self.Obit_Date       :=  ut.CleanSpacesAndUpper(l.Obit_Date);
   self.Updated_Date    :=  ut.CleanSpacesAndUpper(l.Updated_At);
   self.Funeral_Service_in_City  :=  ut.CleanSpacesAndUpper(l.Funeral_Service_in_City);
   self.Funeral_Service_in_State :=  ut.CleanSpacesAndUpper(l.Funeral_Service_in_State);
   self.Service_Location_Zip_Code:=  ut.CleanSpacesAndUpper(l.Service_Location_Zip_Code);
   self.Obituary_Link      :=  ut.CleanSpacesAndUpper(l.Obituary_Link);
   self.Newspaper_Source   :=  ut.CleanSpacesAndUpper(l.Newspaper_Source);
   self.Newspaper_City     :=  ut.CleanSpacesAndUpper(l.Newspaper_City);
   self.Newspaper_Zip_Code :=  ut.CleanSpacesAndUpper(l.Newspaper_Zip_Code);		
	 self.Service_Text       :=  ut.CleanSpacesAndUpper(l.Funeral_Service_Info);
	 SELF := [];
	END; 

tribute_newspaper := project(ds_newspaper_in,TransNewspaper(left));


PromoteSupers.MAC_SF_BuildProcess(tribute_newspaper,'~thor_data400::in::tributes_newspaper',build_newspaper_out,3, /*csvout*/false, /*compress*/true);


RETURN build_newspaper_out;
END;
