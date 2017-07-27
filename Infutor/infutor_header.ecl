import autokeyb2,doxie,header, ut, codes,RoxieKeyBuild, infutor,mdr, doxie_build;

/* //INFUTOR into Header base layout */
header.layout_header reformat(infutor.infutor_layout_main.layout_base_tracker l, integer c) := transform

/* //check date validity by length, number values, and between 1901 and today */
fn_dtchange(string6 indate) := if(indate[1..6] between '190101' and ut.GetDate[1..6], indate, '999999');	
fn_ltdtchange(string6 indate) := if(regexfind('[1-9]', indate) and length(trim(indate, all)) in [6,8] and indate[1..6] between '190101' and ut.GetDate[1..6], indate, '');	
EarliestDate(string one, string two) := if(one < two, one, two);
LatestDate(string one, string two) := if(one > two, one, two);

find_earliest := regexreplace('999999',
																	EarliestDate(EarliestDate(EarliestDate(
																	EarliestDate(EarliestDate(EarliestDate(
																	fn_dtchange(l.last_activity_dt),fn_dtchange(l.effective_dt)),
																	fn_dtchange(l.prev1_addr_effective_dt)),
																	fn_dtchange(l.prev2_addr_effective_dt)),
																	fn_dtchange(l.prev3_addr_effective_dt)),
																	fn_dtchange(l.prev4_addr_effective_dt)),
																	fn_dtchange(l.prev5_addr_effective_dt))
															, '');

find_latest := (string)LatestDate(LatestDate(LatestDate(
																	LatestDate(LatestDate(LatestDate(
																	fn_ltdtchange(l.last_activity_dt),fn_ltdtchange(l.effective_dt)),
																	fn_ltdtchange(l.prev1_addr_effective_dt)),
																	fn_ltdtchange(l.prev2_addr_effective_dt)),
																	fn_ltdtchange(l.prev3_addr_effective_dt)),
																	fn_ltdtchange(l.prev4_addr_effective_dt)),
																	fn_ltdtchange(l.prev5_addr_effective_dt));

	self.did := l.did;
	self.rid := (15 * 1000000000000) + c;
	self.src := 'IF';
	self.dt_first_seen := if(l.orig_filing_dt[1..6] not between '190101' and ut.GetDate[1..6], (unsigned)find_earliest[1..6], (unsigned)l.orig_filing_dt[1..6]); //find earliest date vendor received an address/phone number
	self.dt_last_seen := (unsigned)find_latest[1..6];
	self.dt_vendor_last_reported := (unsigned)infutor.version_dev[1..6];
	self.dt_vendor_first_reported := (unsigned)infutor.version_dev[1..6];
	self.dt_nonglb_last_seen := 0;
	self.vendor_id := (qstring18)l.boca_id;
	self.dob := (unsigned)l.orig_dob_dd_appended;
	self.suffix := l.addr_suffix;
	self.city_name := l.p_city_name;
	self := l;
end;

hdrINF := project(infutor.File_Infutor_DID(did > 0), reformat(left, counter));

/* //GATHER LIST OF SRC's PERMISSABLE IN KnowX from Header */
cv3 := set(codes.file_codes_v3_in(long_flag = 'N' and 
						field_name2 = 'ALLOW' and file_name = 'PERSON-HEADER' and field_name = 'CONSUMER-PORTAL'), code);

/* //FILTER Header using CodesV3 */
hdr := doxie_build.file_header_building(src in cv3); // bug 61970 changed to keybuilding file for the addition of LT and TU

/* //combine files and remove empty DIDs */
cmbFileswDID := hdr + hdrINF;

/* //place files in doxie key format - per salini Pamidimukkala's instruction  */
recordof(doxie.header_pre_keybuild)-header.layout_header_exclusions doxie_chlay(header.layout_header l) := transform
	self := l;
end;

cmbFILEDoxie := project(cmbFileswDID, doxie_chlay(left));

srtcmbFILE := sort(distribute(cmbFILEDoxie, hash(did, rid)), record, local);

export infutor_header := srtcmbFile;