import doxie,data_services;
raw := file_areacode_change;


string8 convert_date(string6 d) := MAP(d = '' or length(d) < 6 => '',
								d[5..6] >= '50' => '19' + d[5..6] + d[1..2] + d[3..4],
								d[5..6] < '50' => '20' + d[5..6] + d[1..2] + d[3..4],
								'');		   

rec := risk_indicators.Layout_AreaCode_Change_plus;

rec format_dates(raw le) := transform
	self.old_date_established := convert_date(le.old_date_extablished);
	self.permissive_end := convert_date(le.permissive_end);
	self.permissive_start := convert_date(le.permissive_start);
	self.new_disconnect_date := convert_date(le.new_disconnect_date);
	self := le;
end;

base := project(raw, format_dates(left));


rec swap(base le) := transform
	self.old_NPA := le.new_NPA;
	self.old_NXX := le.new_NXX;
	self.new_NPA := le.old_NPA;
	self.new_NXX := le.old_NXX;
	self.reverse_flag := true;
	self := le;
end;

final := base + project(base, swap(left));

export Key_FCRA_AreaCode_Change_plus := index(final,{old_NPA,old_NXX},{final},data_services.data_location.prefix() + 'thor_data400::key::fcra::areacode_change_plus_' + doxie.Version_SuperKey);

