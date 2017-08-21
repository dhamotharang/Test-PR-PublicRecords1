import address, ut, _control, lib_fileservices, versioncontrol, aid, idl_header;

export proc_map_zenith(string filedate) := function

Layout_Vendor_Zenith := record
string orig_Account;
string orig_DateTime;
string orig_Phone;
string orig_CallCode;
string orig_IO_Code;
string orig_firstName;
string orig_lastName;
string orig_Address1;
string orig_Address2;
string orig_City;
string orig_State;
string orig_Zip;
string orig_SSN;
string crlf;
end;

layout_common := PhonesFeedback.Layouts_PhonesFeedback.Layout_PhonesFeedback_in;
     
temp_common_layout := record
layout_common;
string100 prep_addr_line1			:= '';
string50	prep_addr_line_last		:= '';
unsigned8	raw_aid								:=  0;
end;	 
	 
trimUpper(string s) := function
			return trim(stringlib.StringToUppercase(s),left,right);
			end; 

getContactType(string t) := function
			contactType := CASE(trim(t),  '084' => '1',
										  '101' => '1',
										  '103' => '3',
										  '104' => '1',
										  '105' => '1',
										  '106' => '1',
										  '200' => '2',
										  '202' => '1',
										  '203' => '1',
										  '204' => '1',
										  '205' => '1',
										  '206' => '1',
										  '207' => '1',
										  '208' => '1',
										  '209' => '4',
										  '210' => '3',
										  '211' => '1',
										  '212' => '1',
										  '213' => '1',
										  '217' => '1',
										  '218' => '1',
										  '');
			return contactType;
			end; 
			
// Get date/time in required format			
a := ut.GetTimeDate();

parsePat := ('([[:digit:]]{4})-([[:digit:]]{2})-([[:digit:]]{2})([[:digit:]]{2})([[:digit:]]{2})([[:digit:]]{3})');

yyyy := regexfind(parsePat,a,1);
mm   := regexfind(parsePat,a,2);
dd   := regexfind(parsePat,a,3);
hhT  := regexfind(parsePat,a,4);
mmT  := regexfind(parsePat,a,5);
sssT := regexfind(parsePat,a,6);

mmm := case(mm, '01' => 'Jan',
				'02' => 'Feb',				
				'03' => 'Mar', 
				'04' => 'Apr', 
				'05' => 'May', 
				'06' => 'Jun', 
				'07' => 'Jul', 
				'08' => 'Aug', 
				'09' => 'Sep', 
				'10' => 'Oct', 
				'11' => 'Nov', 
				'12' => 'Dec',
				'XXX');
				
hhhT := (string)if((unsigned1)hhT > 12, (unsigned1)hhT - 12, (unsigned1)hhT);				
ampm := if((unsigned1)hhT > 11, 'PM', 'AM');
current_date_time := mmm + ' ' + 
					 trim((string)(unsigned1)dd) + ' ' + 
					 trim(yyyy) + ' ' + 
					 trim((string)(unsigned1)hhhT) + ':' + 
					 trim(mmT) + 
					 trim(ampm);
					 
hhmmss:= hhT+mmT+sssT[1..2];					 

// groupName := versioncontrol.groupname();

groupname := 'thor400_30';

spray := FileServices.SprayVariable(_control.IPAddress.edata12,   
								   '/hds_2/phones_feedback/sources/customer/zenith/raw/'+filedate+'/*',,,,,groupName, 								   
								   '~thor_data400::in::phonesfeedback_zenith::'+filedate+'::raw',,,,true,true,true); 
								  
ds_in    := dataset('~thor_data400::in::phonesfeedback_zenith::'+filedate+'::raw',
						    Layout_Vendor_zenith,csv(separator('\t'),quote('"'),heading(1),
													 terminator(['\r\n','\n'])));
								 
checkDS_IN := if(~exists(ds_in),
						fail('Unable to find vendor file on unix. Please investigate.'),
						output('Continuing'));

temp_common_layout prepRecs(Layout_Vendor_Zenith L) := transform,
							skip(StringLib.StringFilter(L.orig_Phone,'0123456789')='')	
fullName	:=	trimUpper(trim(l.orig_FirstName,left,right) + ' ' +													  
						  trim(l.orig_LastName,left,right));		
		
clean_name 	:= Address.CleanPersonFML73_fields(fullName).CleanNameRecord;
self.prep_addr_line1 := trimUpper(l.orig_address1) + ' ' + trimUpper(l.orig_address2);
self.prep_addr_line_last := if(trimUpper(l.orig_city)!='',
					trimUpper(l.orig_city) + ', ' + trimUpper(l.orig_state) + ' ' + StringLib.StringFilter(l.orig_zip,'1234567890')[1..5],
					StringLib.StringCleanSpaces(trimUpper(l.orig_state) + ' ' + StringLib.StringFilter(l.orig_zip,'1234567890')[1..5]));

self.phone_feedback_id := '0';
self.login_history_id := '0000000000';
self.customerid := '1005391';
self.phone_number := StringLib.StringFilter(l.orig_phone,'0123456789');
self.ssn := StringLib.StringFilter(l.orig_ssn,'0123456789');
self.fname := clean_name.fname;
self.mname := clean_name.mname;
self.lname := clean_name.lname;
self.alt_phone := '';
self.other_info := '';
self.phone_contact_type := getContactType(l.orig_CallCode);
self.feedback_source := '8';
self.transaction_id := '';
self.date_time_added := current_date_time;
self.did := '';
self.loginid := '';
self.lf_filler := '\n';
self := [];
end;

temp_prepped := project(ds_in,prepRecs(left));
// output(count(temp_prepped),named('Temp_Prepped_Count_In'));

//Drop all temp_prepped records having a blank phone_contact_type
prepped := temp_prepped(phone_contact_type!='');
// output(count(prepped),named('Final_Prepped_Count_In'));

// output(choosen(prepped,500));

//***********************************************************************************
//* Clean address using the AID maco
//////////////////////////////////////////////////////////////////////////////////////
HasAddress	:=	trim(prepped.prep_addr_line1,left,right)     != '' and
				trim(prepped.prep_addr_line_last,left,right) != '';
								
dWith_address		:= prepped(HasAddress);
dWithout_address	:= prepped(not(HasAddress));

unsigned4	lFlags 	:= AID.Common.eReturnValues.ACECacheRecords;	

AID.MacAppendFromRaw_2Line(dWith_address, prep_addr_line1, prep_addr_line_last, Raw_AID, dwithAID, lFlags);


//*** Populate the clean address fields from the AID cleaned address records.
layout_common	 mapCleanAddr(dwithAID l) := transform		
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
	self        					:= l;		 
end;

//** Adding back the filtered blank address records to the rest of the file.
dAID_Cleaned_Addr := project(dwithAID, mapCleanAddr(left)) + 
                     project(dWithout_address,transform(layout_common, self := left, self := []));
				
//***********************************************************************************

// Flip names that may have been wrongly parsed by the name cleaner.
ut.mac_flipnames(dAID_Cleaned_Addr, fname, mname, lname, flippedRecs);

// Write out the prepped vendor data to a logical for use in despraying to Unix.
writeFormat := output(flippedRecs,,'~thor_data400::in::phonesfeedback::zenith_formatted::'+filedate,__COMPRESSED__,overwrite);

despray := lib_fileservices.fileservices.Despray('~thor_data400::in::phonesfeedback::zenith_formatted::'+filedate,_control.IPAddress.edata12,									            
 									'/hds_2/phones_feedback/sources/customer/zenith/clean/zenith_'+filedate+'_'+hhmmss+'.txt',,,,TRUE);									

deleteLogicals := sequential(/*FileServices.DeleteLogicalFile('~thor_data400::in::phonesfeedback_zenith::'+filedate+'::raw'),*/
							 FileServices.DeleteLogicalFile('~thor_data400::in::phonesfeedback::zenith_formatted::'+filedate));

result := sequential(spray,checkDS_IN,writeFormat,despray,deleteLogicals);

return result;
end;