import address, ut, _control, lib_fileservices, lib_stringlib,versioncontrol, aid, idl_header;

export proc_map_monarch(string filedate) := function

Layout_Vendor_monarch := record
string client_No;
string orig_fullName;
string orig_address;
string orig_city;
string orig_state;
string orig_zip;
string orig_phone;
string orig_result_code;
string date_time;
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


			
groupname := 'thor400_30';

spray := FileServices.SprayVariable(_control.IPAddress.edata12,   
								   '/hds_2/phones_feedback/sources/customer/monarch/'+filedate+'/*.csv',,,,,groupName, 								   
								   '~thor_data400::in::phonesfeedback_monarch::'+filedate+'::raw',,,,true,true,true); 
								  
ds_in    := dataset('~thor_data400::in::phonesfeedback_monarch::'+filedate+'::raw',
						    Layout_Vendor_monarch,csv(quote('"'),terminator(['\r\n','\n'])));
								 
checkDS_IN := if(~exists(ds_in),
						fail('Unable to find vendor file on unix. Please investigate.'),
						output('Continuing'));
						
//filter only valid phones and names

ds_in_filter := ds_in( orig_phone <> '' );

Address.Mac_Is_Business(	ds_in_filter,orig_fullName,fPreclean,nameType);

temp_common_layout prepRecs(fPreclean L) := transform	
	clean_name 	:= if( L.nameType = 'P' or L.nameType = 'D',Address.CleanPersonLFM73(L.orig_fullName),'');
	
		
self.prep_addr_line1 := trimUpper(l.orig_address);
self.prep_addr_line_last := if(trimUpper(l.orig_city)!='',
					trimUpper(l.orig_city) + ', ' + trimUpper(l.orig_state) + ' ' + StringLib.StringFilter(l.orig_zip,'1234567890')[1..5],
					StringLib.StringCleanSpaces(trimUpper(l.orig_state) + ' ' + StringLib.StringFilter(l.orig_zip,'1234567890')[1..5]));

self.phone_feedback_id := '0';
self.login_history_id := '0000000000';
self.customerid := trimUpper(L.client_No);
self.phone_number := StringLib.StringFilter(l.orig_phone,'0123456789');
self.ssn := '';
self.fname := if( L.nameType = 'P' or L.nameType = 'D',clean_name[6..25],'');
self.mname := if( L.nameType = 'P' or L.nameType = 'D',clean_name[26..45],'');
self.lname := if( L.nameType = 'P' or L.nameType = 'D',clean_name[46..65],'');
self.alt_phone := '';
self.other_info := '';
self.phone_contact_type := MonarchContactType(l.orig_result_code);
self.feedback_source := '25';
self.transaction_id := '';
self.date_time_added := trim(l.date_time) ;
self.did := '';
self.loginid := '';
self.lf_filler := '\n';
self := [];
end;

temp_prepped := project(fPreclean,prepRecs(left));

prepped := temp_prepped(phone_contact_type!='');


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
writeFormat := output(flippedRecs,,'~thor_data400::in::phonesfeedback::monarch::'+filedate,overwrite,compressed);

add2super := FileServices.AddSuperFile('~thor_data400::in::phonesfeedback_fcra::sprayed::customer','~thor_data400::in::phonesfeedback::monarch::'+filedate);




Valid_rec := record
flippedRecs.phone_contact_type;
integer count_ := count(group);
end;

Valid_stat := sort(table(flippedRecs,Valid_rec,phone_contact_type,few),phone_contact_type);




unsigned integer countdiff := count(ds_in) - count(flippedRecs);

//Get Raw filename for report genration
Infileds := lib_fileservices.fileservices.Remotedirectory('edata12-bld.br.seisint.com','/hds_2/phones_feedback/sources/customer/monarch/'+filedate);

Rawfilelist := table(Infileds(name <> '.listing'),{record  Infileds.name end;},name,few);

string Infilename := Rawfilelist[1].name + ',' + Rawfilelist[2].name + ',' + Rawfilelist[3].name + ',' + Rawfilelist[4].name ;
//ListAllFilename := output(Rawfilelist(name <> '.listing'));
//report generation
 run_dt :=  ut.GetDate;
SuccessSubject := 'Stats for job Monarch PhoneFeedback '+run_dt;


bodycontent :=       'Run Date             = '+run_dt + '\n' +
															 
															 'Job ID               = ' + thorlib.WUID() + '\n' +
														//	 'Customer ID          = ' + Out_daily_stats(rawfilenm,clfilenm,srctype).customerid + '\n' +
															 'Customer Name        = MONARCH RECOVERY MANAGEMENT INC'+ '\n' +
															 'Jobname              = MONARCH PHONEFEEDBACK '+'\n' +
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
    
                               'Total Records filtered out                : '+ countdiff + '\n' +
															 '#########################' + '\n' +
															 'Total blank dispositions                  : '+ count(flippedRecs(phone_contact_type=''  )) + '\n' +
															 'Total Business Names                      : '+ count(flippedRecs(phone_contact_type!='' and fname = '' and lname = '')) + '\n' +
															 'Total blank Phones and Names                  : '+ (count(ds_in) - count(ds_in_filter)) + '\n' +
															 '% Disposition Match                       : '+ ROUND(count(flippedRecs)/count(ds_in)*100) + '\n' +
															 '###########################' ;
 														
														
 //string  attachment := output(	bodycontent);
	
	 SuccessBody		:= bodycontent;
	

	 BuildSuccess	:= fileservices.sendemail(
													Email_Notification_Lists.MonarchSuccess,
													SuccessSubject,
													SuccessBody);
	//													'Stats Complete - Please view attachment\n**File on thor expires in 7 days',
	//												'text/xml',
	//'attachment.txt') ;
												

	 BuildFailure	:= fileservices.sendemail(
													Email_Notification_Lists.BuildFailure,
													'PhonesFeedBack MONARCH Customer Stat Failed on '+ _Control.ThisEnvironment.Name,
													workunit +  failmessage);
							 
result := sequential(spray,checkDS_IN,writeFormat,add2super):SUCCESS(BuildSuccess),FAILURE(BuildFailure);

return result;
end;