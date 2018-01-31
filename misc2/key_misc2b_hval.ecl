import doxie,Data_Services;

in_ds := misc2.file_in_misc2b;

layout_out := record
	data16 hval;
	unsigned3 startDate;
  unsigned3 endDate;
 String2 state;
end;

layout_out in_to_base(in_ds l) := transform
	self.hval := stringlib.string2data(l.hval);
	self.startdate := (unsigned3) l.startdate;
	self.enddate := (unsigned3) l.enddate;
	self := l;
	end;
kf := project(in_ds, in_to_base(left));

export Key_misc2b_hval  := index(kf,{hval},{kf}, Data_Services.Data_location.Prefix()+'thor_data400::key::misc2b::hval_' + doxie.Version_SuperKey);
