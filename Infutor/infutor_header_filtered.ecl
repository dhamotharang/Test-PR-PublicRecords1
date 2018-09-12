import autokeyb2,doxie,header, ut, codes,RoxieKeyBuild, infutor,mdr, doxie_build, watchdog, mdr, census_data, lib_Datalib;



export infutor_header_filtered(boolean excludeForeclosure = false) := function

Test_Count := 0;

/* //INFUTOR into Header base layout */
header.layout_header reformat(infutor.infutor_layout_main.layout_base_tracker l, integer c) := transform
cversion_dev := infutor._config.get_cversion_dev; 
/* //check date validity by length, number values, and between 1901 and today */

Valid_Date_Range(string in_date) := in_date[1..6] between '190101' and ut.GetDate[1..6];
	self.did := l.did;
	self.rid := (15 * 1000000000000) + c;
	self.src := 'IF';
	self.dt_last_seen := map(l.addr_type='O' => max((unsigned)l.last_activity_dt[1..6],(unsigned)l.effective_dt[1..6]), 
							 stringlib.stringtouppercase(l.addr_type) = 'P1' => (unsigned)l.prev1_addr_effective_dt[1..6],
							 stringlib.stringtouppercase(l.addr_type) = 'P2' => (unsigned)l.prev2_addr_effective_dt[1..6],
							 stringlib.stringtouppercase(l.addr_type) = 'P3' => (unsigned)l.prev3_addr_effective_dt[1..6],
							 stringlib.stringtouppercase(l.addr_type) = 'P4' => (unsigned)l.prev4_addr_effective_dt[1..6],
							 stringlib.stringtouppercase(l.addr_type) = 'P5' => (unsigned)l.prev5_addr_effective_dt[1..6],
							 0);
	self.dt_first_seen := map(l.addr_type='O' => (unsigned)l.effective_dt[1..6], self.dt_last_seen);
	self.dt_vendor_last_reported := (unsigned)cversion_dev[1..6];
	self.dt_vendor_first_reported := (unsigned)cversion_dev[1..6];
	self.dt_nonglb_last_seen := 0;
	self.vendor_id := (qstring18)l.boca_id;
	self.dob := (integer4)l.orig_dob_dd_appended;
	self.suffix := l.addr_suffix;
	self.city_name := l.v_city_name; // changed from p to v as v is used in other examples and is completely spelled out
	self.rec_type := '';
	self.county := l.county[3..];
	self.ssn		:= '';
	self := l;
end;

hdrINF := distribute(project(infutor.File_Infutor_DID(did > 0), reformat(left, counter)), hash(did));

watch_dog := distribute(watchdog.File_Best_nonglb, hash(did));

/* if dob year in watchdog year is different and not empty, then blank the infutor dob */
hdrINFBestDOBs := join(hdrINF, watch_dog,
						left.did = right.did,						
							transform(recordof(hdrINF), 
								stringDob(integer4 dob) := ((string)dob)[1..4];
							self.dob := if(stringDob(left.dob) = stringDob(right.dob) or (integer4)stringDob(right.dob) = 0, left.dob, 0);
							self := left), left outer, local);
							
/* //GATHER LIST OF SRC's PERMISSABLE IN KnowX from Header */
cv3 := if(excludeForeclosure, 
            set(codes.file_codes_v3_in(long_flag = 'N' and 
						field_name2 = 'ALLOW' and file_name = 'PERSON-HEADER' and field_name = 'CONSUMER-PORTAL' 
						and code not in ['VO', 'FR'])// VO is in header but has to be created from its base file b/c of missing reg state field for filtering
						, code),
            set(codes.file_codes_v3_in(long_flag = 'N' and 
						field_name2 = 'ALLOW' and file_name = 'PERSON-HEADER' and field_name = 'CONSUMER-PORTAL' 
						and code <> 'VO')// VO is in header but has to be created from its base file b/c of missing reg state field for filtering
						, code));

/* //FILTER Header using CodesV3*/
hdr := doxie_build.file_header_building(src in cv3);

/* //combine files and remove empty DIDs and fix Infutor DOBs */

comb_prepDOBs_pre := infutor.pconsumer_header + hdrINFBestDOBs + infutor.Voters_Header;
comb_prepDOBs := infutor_reflection_header(comb_prepDOBs_pre + infutor.gong_header);

Header.MAC_format_DOB(comb_prepDOBs, dob, comb_CleanDOBs)

cmbFileswDID := hdr + comb_CleanDOBs : persist('~persist::infutor::header_combined_layout');

verify_dates := fn_hdr_addrdate_blank(cmbFileswDID);

/* //place files in doxie key format - per salini Pamidimukkala's instruction  */
recordof(doxie.header_pre_keybuild)-layout_header_exclusions doxie_chlay(header.layout_header l) := transform
	self := l;
end;

cmbFILEDoxie := project(verify_dates, doxie_chlay(left));

census_data.MAC_Fips2County_Keyed(cmbFILEDoxie,st,county,county_name,file_with_county_name);

distcmbFILE0 := distribute(file_with_county_name, hash(did));

distcmbFILE := distcmbFILE0 + project(Header.Dummy_records.NonFCRAseed, transform({distcmbFILE0},self:=left,self:=[]));

// remove records with the address of a domestic violence shelter
result := Infutor.DomesticViolence.Filter(distcmbFILE);

return result;

end;