gordon.x_layout xPlusPlus(gordon.vessel_layout v)  := 
  transform
	SELF.first_name := v.full_name;
	SELF.last_name := v.location;
	SELF.status := v.location_code;
	SELF.shipId := v.shipId + 'x';
	SELF.gross_weight := v.gross_weight + '99';
	SELF.factor := '7';
	SELF.flag := v.flag; //kill
	SELF.name := v.contact;
	SELF.corrosive_code := v.code1;
  end;