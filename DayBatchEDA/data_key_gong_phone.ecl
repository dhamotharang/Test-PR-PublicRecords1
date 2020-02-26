Import gong_Neustar, dx_gong;

valid_gong_full := gong_Neustar.File_Gong_Full_Prepped_For_Keys_1(trim(phone10) <> '');

dx_gong.layouts.i_phone split_phone_areacode(valid_gong_full l) := transform
  string7 p7 := if(l.phone10[8..10] ='', l.phone10[1..7], l.phone10[4..10]);
  string3 area := if(l.phone10[8..10] ='', '', l.phone10[1..3]);
  self.phone7    := p7;
	self.area_code := area;	
  //Fields added to be used as keyed fields:
  self.ph7 := p7;
  self.ph3 := area;
  self.business_flag := l.listing_type_bus = 'B';

	self := l;
end;

export data_key_gong_phone := project(valid_gong_full, split_phone_areacode(left));
