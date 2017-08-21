import didville, did_add, Header_Slimsort, ut, WatchDog, AID, lib_stringlib;

inFile_AddressFeedback :=  AddressFeedback.File_inAddressFeedback;
dedup_AddrFeedback := dedup(sort(distribute(inFile_AddressFeedback(trim(Address_feedback_id,left,right) not in['', '0']),
																								hash32(Address_feedback_id)), record, local), record, local);
Layout_AddressFeed_in := AddressFeedback.Layouts.Lay_AddressFeedback_in;
Layout_AddressFeed_base := AddressFeedback.Layouts.Lay_AddressFeedback_base;

Lay_DidRec := record
	Layout_AddressFeed_base;
	temp_suffix := '';
End;

Lay_prepAID := record
Layout_AddressFeed_base;
string100   prep_addr_line1 := '';
string50	prep_addr_line_last := '';
End;	
	
Lay_SetDate := record
Layout_AddressFeed_in;
string12 timestamp;
End;

DateConversion(String dt) := Function 
month := Map(		stringlib.StringtoUpperCase(dt[1..3]) = 'JAN' => '01',
								stringlib.StringtoUpperCase(dt[1..3]) = 'FEB' => '02',
								stringlib.StringtoUpperCase(dt[1..3]) = 'MAR' => '03',
								stringlib.StringtoUpperCase(dt[1..3]) = 'APR' => '04',
								stringlib.StringtoUpperCase(dt[1..3]) = 'MAY' => '05',
								stringlib.StringtoUpperCase(dt[1..3]) = 'JUN' => '06',
								stringlib.StringtoUpperCase(dt[1..3]) = 'JUL' => '07',
								stringlib.StringtoUpperCase(dt[1..3]) = 'AUG' => '08',
								stringlib.StringtoUpperCase(dt[1..3]) = 'SEP' => '09',
								stringlib.StringtoUpperCase(dt[1..3]) = 'OCT' => '10',
								stringlib.StringtoUpperCase(dt[1..3]) = 'NOV' => '11',
								stringlib.StringtoUpperCase(dt[1..3]) = 'DEC' => '12', '');
day := If(length(Trim(dt[5..6],left, right)) = 1, '0'+ Trim(dt[5..6],left, right), dt[5..6]);
Year := If((integer)dt[8..11]<1000, dt[7..10], dt[8..11]);
frmtDate := If(dt <> '', If(length(trim(dt, left, right)) >8, year+month+day, dt), '');
Return frmtDate;
End;

Timestamp(String dt) := Function
tempDt_1 := If((integer)dt[8..11]<1000, dt[1..4]+'0'+dt[5..], dt);
DtFrmtted := DateConversion(tempDt_1);
tempDt_2 := Trim(tempDt_1[12..], left, right);
len := lib_Stringlib.Stringlib.StringFind(tempDt_2, ':', 1);
timeFrmtted_1 :=If(len = 2 and length(tempDt_2) = 5, '0' + tempDt_2[1..2] + '0' + tempDt_2[3..5],
										If(len = 2 and length(tempDt_2) = 6, '0'+tempDt_2[1..6],
												If(len = 3 and length(tempDt_2) = 6, tempDt_2[1..3]+'0'+tempDt_2[4..6],
															If(len = 3 and length(tempDt_2) = 7, tempDt_2, ''))));
timeFrmtted_2 := lib_Stringlib.Stringlib.StringFindReplace(timeFrmtted_1, ':', '');
timeFrmtted_3 := If(timeFrmtted_2[5..6] = 'PM',(string) ((integer) timeFrmtted_2[1..2]+12) +timeFrmtted_2[3..4], timeFrmtted_2[1..4]);
datetimestamp := DtFrmtted + timeFrmtted_3;
Return datetimestamp;
End;

//Sybase FCRA Data Follows (Online - Web)
Lay_SetDate xSetDate(AddressFeedback.Layouts.Lay_AddressFeedback_in l) := transform
self.timestamp := Timestamp(l.date_time_added);
Self.date_time_added :=  DateConversion(l.date_time_added);
self := l;
end;

SetDate := project(dedup_AddrFeedback,xSetDate(left));

//Get rid of duplicate phone_feedback_id's retaining the most recent date_time_added
dSetDate := dedup(sort(distribute(SetDate,skew(0.1)),record,-timestamp,local),record, timestamp,local);
//Project deduped online records back to original input layoutShared 
FinalInFile := project(dSetDate, AddressFeedback.Layouts.Lay_AddressFeedback_in);
//Create temporary records for AID processing
Lay_prepAID prepAID(FinalInFile L) := transform
	
self.prep_addr_line1 := StringLib.StringCleanSpaces( trim(l.orig_street_number,left,right) + ' ' +
																							trim(l.orig_street_pre_direction,left,right) + ' ' +
																							trim(l.orig_street_name,left,right) + ' ' +
																							trim(l.orig_street_suffix,left,right) + ' ' +
																							trim(l.orig_street_post_direction,left,right) + ' ' +
																							trim(l.orig_unit_designation,left,right) + ' ' +
																							trim(l.orig_unit_number,left,right));
self.prep_addr_line_last	:=	StringLib.StringCleanSpaces(if(	trim(l.orig_city,left,right) !='',
																											trim(l.orig_city,left,right) + ', ' +
																											trim(l.orig_state,left,right) + ' ' +
																											trim(l.orig_zip5,left,right),
																											trim(l.orig_state,left,right) + ' ' +
																											trim(l.orig_zip5,left,right)));	
self := L;
Self := [];
end;					
preppedAID := project(FinalInFile,prepAID(left));
// Clean address using the AID maco
HasAddress := trim(preppedAID.prep_addr_line1,left,right) != '' and trim(preppedAID.prep_addr_line_last,left,right) != '';
								
dWith_address	:= preppedAID(HasAddress);
dWithout_address	:= preppedAID(not(HasAddress));

unsigned4	lFlags 	:= AID.Common.eReturnValues.ACECacheRecords;	

AID.MacAppendFromRaw_2Line(dWith_address, prep_addr_line1, prep_addr_line_last, Raw_AID, dwithAID, lFlags);
withAID := dwithAID;

// Populate the clean address fields from the AID cleaned address records
Layout_AddressFeed_base	popCleanAddr(withAID l) := transform		
	self.street_pre_direction		:= l.aidwork_acecache.predir;
	self.street_post_direction		:= l.aidwork_acecache.postdir;
	self.street_number				:= l.aidwork_acecache.prim_range;
	self.street_name				:= l.aidwork_acecache.prim_name;
	self.street_suffix			    := l.aidwork_acecache.addr_suffix;
	self.unit_number				:= l.aidwork_acecache.sec_range;
	self.unit_designation			:= l.aidwork_acecache.unit_desig;
	self.zip5						:= l.aidwork_acecache.zip5;
	self.zip4						:= l.aidwork_acecache.zip4;
	self.city			            := l.aidwork_acecache.p_city_name;
	self.state						:= l.aidwork_acecache.st;
	Self.raw_aid :=  l.aidwork_recordid;
	self        					:= l;		 
end;
// Add back the filtered blank address records to the rest of the file
dAID_Cleaned_Addr := project(withAID, popCleanAddr(left)) + 
										project(dWithout_address,transform(Layout_AddressFeed_base, self := left, self := []));

// Dedup cleaned records on entire record to remove records that now match.
// For example, before cleaning, city names were FT LAUDERDALE and FORT LAUDERDALE
ded_cleaned := dedup(sort(distribute(dAID_Cleaned_Addr,hash32(Address_feedback_id)), record, local), record, local);
// Project records to a layout that includes a name temp_suffix for ADL processing
Lay_DidRec trans(ded_cleaned L) := transform
	self.phone_number := If(L.phone_number<>'', stringlib.stringfilter(L.phone_number,'0123456789'), '');
	self := L;
	end;
allData      := project(ded_cleaned,trans(left));
// Get an ADL for all records, even though online data provides one, per Lisa Simmons, June 2011

matchset := ['A','P'];
did_Add.MAC_Match_Flex(allData,matchset,
					'','',fname,mname,lname,temp_suffix,
					street_number,street_name,unit_number,zip5,state,phone_number,
					did,
					Lay_DidRec,
					true, did_score,
					75,
					dsWithADL)
withDid := dsWithADL;
// Get an HHID for all records

didville.MAC_HHID_Append_By_Address(	withDid,// infile
																		dsHHID,// outfile
																		hhid, lname,
																		street_number, street_name, unit_number, state, zip5);
baseOnly_1 := dsHHID;
baseOnly := PROJECT(baseOnly_1,Layout_AddressFeed_base);
Export Proc_Build_Base := BaseOnly;
