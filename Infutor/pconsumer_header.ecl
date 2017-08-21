/*2011-05-02T22:11:45Z (Cecelie Guyton)
test 76599
*/
import DayBatchPCNSR, ut, header, mdr;

inputPcnsr := DayBatchPCNSR.File_PCNSR; //old only

/* //INFUTOR into Header base layout */
{header.layout_header, string phone2} reformat(recordof(DayBatchPCNSR.File_PCNSR) l, integer c) := transform

Valid_Date_Range(string in_date) := in_date[1..6] between '190101' and ut.GetDate[1..6];

	self.did := l.did;
	self.rid := (16 * 1000000000000) + c; //? how to populate this field - changed to 16 as to not duplicate other records in infutor
	self.src := mdr.sourceTools.src_pcnsr;
	self.dt_last_seen := (unsigned)l.recency_date[..6];
	self.dt_first_seen := map((unsigned)l.telephone_acquisition_date[..6] = 0 => self.dt_last_seen, (unsigned)l.telephone_acquisition_date[..6]);
	self.dt_vendor_last_reported := 0; //? how to populate this field, no filedate in file
	self.dt_vendor_first_reported := 0; //? how to populate this field, no filedate in file
	self.dt_nonglb_last_seen := 0;
	self.vendor_id := (qstring18)c; //? how to populate this field, no record key in file
	self.dob := (unsigned)l.date_of_birth;
	self.suffix := l.addr_suffix;
	self.city_name := l.v_city_name;
	self.phone := regexreplace('[^0-9]', l.area_code+l.phone_number, '');
	self.phone2 := regexreplace('[^0-9]', l.phone2_number, '');
	self.ssn := '';
	self.rec_type := '';
	self.county := l.county[3..];
	self := l;
end;

hdrPcnsrPre := project(inputPcnsr(did > 0), reformat(left, counter));

{header.layout_header, string phone2} phone2populate(recordof(hdrPcnsrPre) l) := transform

	self.phone := l.phone2;
	self := l;
end;

hdrPcnsrNrm := project(hdrPcnsrPre(phone2 <> ''), phone2populate(left));

hdrPcnsr := dedup(sort(project(hdrPcnsrNrm + hdrPcnsrPre, header.layout_header), record, except rid), record, except rid);


export pconsumer_header := hdrPcnsr;