import infoUSA, address,Business_HeaderV2;

DEADCO_IN := Business_HeaderV2.Source_Files.infousa_deadco.BusinessHeader;


DEADCO_clean_layout_temp := record

infousa.Layout_DEADCO_In;
string73   clean_name;
string182  clean_address;

end;


DEADCO_clean_layout_temp tdeadcoclean(infousa.File_DEADCO_In L) := transform

self.clean_name    := Address.CleanPersonFML73(L.contact_name);
self.date_added    := if(length(trim(L.date_added, left, right)) = 6, if(trim(L.date_added, left, right) <> '195 8/',
                      trim(L.date_added, left, right), ''), '');

self := L;
self	:=	[];

end;

File_DEADCO_Clean_temp := project(infousa.File_DEADCO_In, tdeadcoclean(left));


infousa.Layout_DEADCO_Clean_In tDEADtoClean(File_DEADCO_Clean_temp L) := transform


self.dt_first_seen              := L.date_added;
self.dt_last_seen               := L.date_added;
self.dt_vendor_first_reported   := L.date_added;
self.dt_vendor_last_reported    := L.production_date[5..8] + L.production_date[1..4];
self.title											:= L.clean_name[1..5];
self.fname											:= L.clean_name[6..25];
self.mname											:= L.clean_name[26..45];
self.lname											:= L.clean_name[46..65];
self.name_suffix								:= L.clean_name[66..70];
self.name_cleaning_score				:= L.clean_name[71..73];
self.phone											:= ADDRESS.CleanPhone(L.phone);
self	:=	L;
self	:=	[];
end;


export File_DEADCO_Clean_In := project(File_DEADCO_clean_temp, tdeadtoclean(left));