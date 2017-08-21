import address, ut, _control, lib_fileservices, lib_stringlib,versioncontrol, aid, idl_header;

export proc_map_protocol(string filedate) := function

Layout_Vendor_protocol := record
string client_No;
string lastName;
string firstName;
string address;
string city;
string state;
string zip;
string ssn;
string phone;
string phone_result_code;
string date_stamp;
string time_stamp;
string work;
string skip_vendor;
string dob;
string address_result_date;
string address_result_code;
string phone_result_date;
string phone_result_time;
string work_result_date;
string work_result_time;
string work_result_code;
end;

layout_common := PhonesFeedback.Layouts_PhonesFeedback.Layout_PhonesFeedback_in;
trimUpper(string s) := function
			return trim(stringlib.StringToUppercase(s),left,right);
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

// groupName := versioncontrol.groupname();   // Dataland use

groupname := 'thor400_30';

spray := FileServices.SprayVariable(_control.IPAddress.edata12,   
								   '/hds_2/phones_feedback/sources/customer/protocol/'+filedate+'/*.csv',,,,,groupName, 								   
								   '~thor_data400::in::phonesfeedback_protocol::'+filedate+'::raw',,,,true,true,true); 
								  
ds_in    := dataset('~thor_data400::in::phonesfeedback_protocol::'+filedate+'::raw',
						    Layout_Vendor_protocol,csv(quote('"'),terminator(['\r\n','\n'])));
								 
checkDS_IN := if(~exists(ds_in),
						fail('Unable to find vendor file on unix. Please investigate.'),
						output('Continuing'));
						
//filter only valid phones and names


rectemp := record
ds_in;
string fullName := '';
end;

ds_temp := project(ds_in,transform(rectemp,self.fullName := trimUpper(trim(LEFT.firstname,left,right)) + ' ' +													  
						  trimUpper(trim(LEFT.lastname,left,right)),self := LEFT));
							
ds_in_filter := ds_temp( phone <> '' and regexfind('[A-Z]',trim(fullName)) = true  );


Address.Mac_Is_Business(	ds_in_filter,fullName,fPreclean,nameType);

temp_common_layout := record
layout_common;
string100 prep_addr_line1			:= '';
string50	prep_addr_line_last		:= '';
unsigned8	raw_aid								:=  0;
end;	 

temp_common_layout prepRecs(fPreclean L) := transform	

self.prep_addr_line1 := trimUpper(l.address) ;
self.prep_addr_line_last := if(trimUpper(l.city)!='',
					trimUpper(l.city) + ', ' + trimUpper(l.state) + ' ' + StringLib.StringFilter(l.zip,'1234567890')[1..5],
					StringLib.StringCleanSpaces(trimUpper(l.state) + ' ' + StringLib.StringFilter(l.zip,'1234567890')[1..5]));
		
		
clean_name 	:= if( L.nameType = 'P' or L.nameType = 'D',Address.CleanPersonFML73(L.fullName),'');


self.phone_feedback_id := '0';
self.login_history_id := '0000000000';
self.customerid := trimUpper(L.client_No)[4..];
self.phone_number := StringLib.StringFilter(L.phone,'0123456789');
self.fname := if( L.nameType = 'P' or L.nameType = 'D',clean_name[6..25],'');
self.mname := if( L.nameType = 'P' or L.nameType = 'D',clean_name[26..45],'');
self.lname := if( L.nameType = 'P' or L.nameType = 'D',clean_name[46..65],'');
self.ssn := StringLib.StringFilter(L.ssn,'0123456789');
self.alt_phone := '';
self.other_info := '';
self.phone_contact_type := PhonesFeedback.PtclContacttype(trimUpper(L.phone_result_code));
self.feedback_source := '24';
self.transaction_id := '';
self.date_time_added := current_date_time;
self.zip5 := trim(L.zip[1..5]);
self.did := '';
self.loginid := '';
self.lf_filler := '\n';
self := [];
end;

temp_prepped := project(fPreclean,prepRecs(left));

prepped_validtype := temp_prepped(phone_contact_type!='');

prepped :=  prepped_validtype( fname <> '' or lname <> '');

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


// Write out the prepped vendor data to a logical.

writecmpFormat := output(flippedRecs,,'~thor_data400::in::phonesfeedback::protocol::'+filedate,compressed,overwrite);



 

add2super := 
              FileServices.AddSuperFile('~thor_data400::in::phonesfeedback_fcra::sprayed::customer','~thor_data400::in::phonesfeedback::protocol::'+filedate) ;
						


Valid_rec := record
flippedRecs.phone_contact_type;
integer count_ := count(group);
end;

Valid_stat := sort(table(flippedRecs,Valid_rec,phone_contact_type,few),phone_contact_type);

unsigned integer countdiff := count(ds_in) - count(flippedRecs);

//Get Raw filename for report genration
Infileds := lib_fileservices.fileservices.Remotedirectory('edata12-bld.br.seisint.com','/hds_2/phones_feedback/sources/customer/protocol/'+filedate);

Rawfilelist := table(Infileds(name <> '.listing'),{record  Infileds.name end;},name,few);

string Infilename := Rawfilelist[1].name + ',' + Rawfilelist[2].name + ',' + Rawfilelist[3].name + ',' + Rawfilelist[4].name ;
//ListAllFilename := output(Rawfilelist(name <> '.listing'));
//report generation
 run_dt :=  ut.GetDate;
SuccessSubject := 'Stats for job Protocol PhoneFeedback '+filedate;


bodycontent :=       'Run Date             = '+run_dt + '\n' +
															 
															 'Job ID               = ' + thorlib.WUID() + '\n' +
														//	 'Customer ID          = ' + Out_daily_stats(rawfilenm,clfilenm,srctype).customerid + '\n' +
															 'Customer Name        = PROTOCOL'+ '\n' +
															 'Jobname              = PROTOCOL PHONEFEEDBACK '+'\n' +
															 'InputFileName        = ' + Infilename + '\n' +
													//		 'Input Filename       = ' + Out_daily_stats(rawfilenm,clfilenm,srctype).RawInputfilename + '\n' +
													//		 'Results Filename  #1 = ' + Out_daily_stats(rawfilenm,clfilenm,srctype).CleanInputfilename + '\n\n\n' + 

                               'Job Stats:'+	'\n' + 

                               'Total number of records in Input File     : '+ count(ds_in) + '\n' +
                               'Customer Input                            : '+ count(ds_in) + '\n' +
															 'Total Output Count                        : '+ count(flippedRecs) + '\n' +
											         
                               'Code 1 - Right Party Counts               : '+ count(flippedRecs(phone_contact_type = '1')) + '\n' +
                               'Code 2 - Relative or Associate Count      : '+ count(flippedRecs(phone_contact_type = '2')) + '\n' +
                               'Code 3 - Wrong Party Count                : '+ count(flippedRecs(phone_contact_type = '3')) + '\n' +
                               'Code 4 - Phone Disconnected Count         : '+ count(flippedRecs(phone_contact_type = '4'))  + '\n' +
                               'Code 6 - Answering machine                : '+ count(flippedRecs(phone_contact_type = '6'))  + '\n' +

    
                               'Total Records filtered out                : '+ countdiff + '\n' +
															 '#########################' + '\n' +
															 'Total blank dispositions                  : '+ count(temp_prepped(phone_contact_type=''  )) + '\n' +
															 'Total Business Names                      : '+ count(temp_prepped(phone_contact_type!='' and fname = '' and lname = '')) + '\n' +
															 'Total blank Phones and Names                  : '+ (count(ds_in) - count(temp_prepped)) + '\n' +
															 '% Disposition Match                       : '+ ROUND(count(flippedRecs)/count(ds_in)*100) + '\n' +
															 '###########################' ;
 														
														
 //string  attachment := output(	bodycontent);
	
	 SuccessBody		:= bodycontent;
	
	

	 BuildSuccess	:= fileservices.sendemail(
													Email_Notification_Lists.ProtocolSuccess,
													SuccessSubject,
													SuccessBody);
														
												

	 BuildFailure	:= fileservices.sendemail(
												Email_Notification_Lists.BuildFailure,
													'PhonesFeedBack Protocol Customer Stat Failed on '+ _Control.ThisEnvironment.Name,
													workunit +  failmessage);
							 
result := sequential(spray,checkDS_IN,writecmpFormat,add2super):SUCCESS(BuildSuccess),FAILURE(BuildFailure);

return result;

end;