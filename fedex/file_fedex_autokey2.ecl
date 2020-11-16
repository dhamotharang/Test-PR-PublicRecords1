
import ut;
export file_fedex_autokey2(string pversion,boolean delta=true):=module
ds := fedex.file_fedex_building(pversion,delta).file;

layout_autokeys := record
	unsigned1 zero	:= 0;
	unsigned6 did		:= 0;
	unsigned6 bdid	:= 0;
	unsigned4 dt_last_seen := 0;
	typeof(fedex.layout_fedex_base.first_name) fname;
	typeof(fedex.layout_fedex_base.middle_initial) mname;
	typeof(fedex.layout_fedex_base.last_name) lname;
	fedex.layout_fedex_base	-	[file_date,nametype,version];
end;

layout_autokeys add_field(ds l) := transform
	self.dt_last_seen	:= (unsigned4)l.file_date;
	self.fname := stringlib.stringtouppercase(l.first_name);
	self.mname := stringlib.stringtouppercase(l.middle_initial);
	self.lname := stringlib.stringtouppercase(l.last_name);
	self := l;
end;

ds_autokey := project(ds, add_field(left));

export file := ds_autokey;

end;