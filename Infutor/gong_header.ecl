/*2011-05-02T22:11:45Z (Cecelie Guyton)
test 76599
*/
import autokeyb2,doxie,header, ut, codes,RoxieKeyBuild, infutor,mdr, doxie_build, gong, mdr;

inputGong := gong.File_History;

/* //Gong History into Header base layout */
header.layout_header reformat(recordof(inputGong) l, integer c) := transform

Valid_Date_Range(string in_date) := in_date[1..6] between '190101' and ut.GetDate[1..6];

	self.did := l.did;
	self.rid := (17 * 1000000000000) + c; //? how to populate this field - changed to 16 as to not duplicate other records in infutor
	self.src := if(l.bell_id='NEU',mdr.sourceTools.src_Gong_Neustar, mdr.sourceTools.src_Gong_History);
	self.dt_last_seen := map((unsigned)l.dt_last_seen = 0 => (unsigned)l.dt_first_seen[..6], (unsigned)l.dt_first_seen[..6]);
	self.dt_first_seen := map((unsigned)l.dt_first_seen = 0 => self.dt_last_seen, (unsigned)l.dt_first_seen[..6]);
	self.dt_vendor_last_reported := 0; //? how to populate this field, no filedate in file
	self.dt_vendor_first_reported := 0; //? how to populate this field, no filedate in file
	self.dt_nonglb_last_seen := 0;
	self.vendor_id := (qstring18)c; //? how to populate this field, no record key in file
	self.dob := 0;
	self.suffix := l.v_suffix;
	self.city_name := l.v_city_name;
	self.phone := l.phone10;
	self.ssn := '';
	self.rec_type := '';
	self.title := l.name_prefix;
	self.fname := l.name_first;
	self.mname := l.name_middle;
	self.lname := l.name_last;
	self.zip := l.z5;
	self.zip4 := l.z4;
	self.county := l.county_code[3..];
	
	self := l;
end;

hdrGong := dedup(sort(project(inputGong(did > 0), reformat(left, counter)), record, except rid), record, except rid);

export gong_header := hdrGong;