import address, ut, _control, lib_fileservices, lib_stringlib,versioncontrol, aid, idl_header;

export proc_map_nco(string filedate) := function

Layout_Vendor_nco := record
string client_No;
string orig_fullName;
string orig_zip;
string orig_phone;
string orig_result_code;
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
								   '/hds_2/phones_feedback/sources/customer/nco/'+filedate+'/*.csv',,,,,groupName, 								   
								   '~thor_data400::in::phonesfeedback_nco::'+filedate+'::raw',,,,true,true,true); 
								  
ds_in    := dataset('~thor_data400::in::phonesfeedback_nco::'+filedate+'::raw',
						    Layout_Vendor_nco,csv(quote('"'),terminator(['\r\n','\n'])));
								 
checkDS_IN := if(~exists(ds_in),
						fail('Unable to find vendor file on unix. Please investigate.'),
						output('Continuing'));
						
//filter only valid phones and names

ds_in_filter := ds_in( orig_phone <> '' and regexfind('[A-Z]',trimUpper(trim(orig_fullName))) = true);

Address.Mac_Is_Business(	ds_in_filter,orig_fullName,fPreclean,nameType);

layout_common prepRecs(fPreclean L) := transform	
		
		
clean_name 	:= if( L.nameType = 'P' or L.nameType = 'D',Address.CleanPersonLFM73(L.orig_fullName),'');


self.phone_feedback_id := '0';
self.login_history_id := '0000000000';
self.customerid := trimUpper(L.client_No);
self.phone_number := StringLib.StringFilter(L.orig_phone,'0123456789');
self.fname := if( L.nameType = 'P' or L.nameType = 'D',clean_name[6..25],'');
self.mname := if( L.nameType = 'P' or L.nameType = 'D',clean_name[26..45],'');
self.lname := if( L.nameType = 'P' or L.nameType = 'D',clean_name[46..65],'');
self.alt_phone := '';
self.other_info := '';
self.phone_contact_type := NcoContactType(trimUpper(L.orig_result_code));
self.zip5 := if(StringLib.StringFind(trim(L.orig_zip),'-',1) = 0,trim(L.orig_zip)[1..5],trim(L.orig_zip));
self.zip4 := if(StringLib.StringFind(trim(L.orig_zip),'-',1) <> 0,trim(L.orig_zip)[5..],'');
self.feedback_source := '8';
self.transaction_id := '';
self.date_time_added := current_date_time;
self.did := '';
self.loginid := '';
self.lf_filler := '\n';
self := [];
end;

temp_prepped := project(fPreclean,prepRecs(left));

writefull := output(temp_prepped,,'~thor_data400::in::phonesfeedback::nco::'+filedate+'::full_file',overwrite);

// output(count(temp_prepped),named('Temp_Prepped_Count_In'));
//Drop all temp_prepped records having a blank phone_contact_type
prepped := temp_prepped(phone_contact_type!='' and fname <> '' and lname <> '');
// output(count(prepped),named('Final_Prepped_Count_In'));

// output(choosen(prepped,500));

//***********************************************************************************
//* Clean address using the AID maco
//////////////////////////////////////////////////////////////////////////////////////



//*** Populate the clean address fields from the AID cleaned address records.


//** Adding back the filtered blank address records to the rest of the file.
				
//***********************************************************************************

// Flip names that may have been wrongly parsed by the name cleaner.
ut.mac_flipnames(prepped, fname, mname, lname, flippedRecs);

// Write out the prepped vendor data to a logical for use in despraying to Unix.


writecmpFormat := output(flippedRecs,,'~thor_data400::in::phonesfeedback::nco::'+filedate,compressed,overwrite);



deleteLogicals := FileServices.DeleteLogicalFile('~thor_data400::in::phonesfeedback_nco::'+filedate+'::raw');

add2super :=  Sequential( FileServices.StartSuperFiletransaction(),
              FileServices.RemoveSuperFile('~thor_data400::in::phonesfeedback_fcra::sprayed::customer','~thor_data400::in::phonesfeedback::nco::'+filedate),
              FileServices.AddSuperFile('~thor_data400::in::phonesfeedback_fcra::sprayed::customer','~thor_data400::in::phonesfeedback::nco::'+filedate),

							FileServices.FinishSuperfileTransaction());

Valid_rec := record
flippedRecs.phone_contact_type;
integer count_ := count(group);
end;

Valid_stat := sort(table(flippedRecs,Valid_rec,phone_contact_type,few),phone_contact_type);


unsigned integer countdiff := count(ds_in) - count(flippedRecs);

//Get Raw filename for report genration
Infileds := lib_fileservices.fileservices.Remotedirectory('edata12-bld.br.seisint.com','/hds_2/phones_feedback/sources/customer/nco/'+filedate);

Rawfilelist := table(Infileds(name <> '.listing'),{record  Infileds.name end;},name,few);

string Infilename := Rawfilelist[1].name + ',' + Rawfilelist[2].name + ',' + Rawfilelist[3].name + ',' + Rawfilelist[4].name ;
//ListAllFilename := output(Rawfilelist(name <> '.listing'));
//report generation
 run_dt :=  ut.GetDate;
SuccessSubject := 'Stats for job NCO PhoneFeedback '+run_dt;


bodycontent :=       'Run Date             = '+run_dt + '\n' +
															 
															 'Job ID               = ' + thorlib.WUID() + '\n' +
														//	 'Customer ID          = ' + Out_daily_stats(rawfilenm,clfilenm,srctype).customerid + '\n' +
															 'Customer Name        = NCO FINANCIAL SYSTEMS INC'+ '\n' +
															 'Jobname              = NCO PHONEFEEDBACK '+'\n' +
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
															 'Total blank dispositions                  : '+ count(temp_prepped(phone_contact_type=''  )) + '\n' +
															 'Total Business Names                      : '+ count(temp_prepped(phone_contact_type!='' and fname = '' and lname = '')) + '\n' +
															 'Total blank Phones and Names                  : '+ (count(ds_in) - count(temp_prepped)) + '\n' +
															 '% Disposition Match                       : '+ ROUND(count(flippedRecs)/count(ds_in)*100) + '\n' +
															 '###########################' ;
 														
														
 //string  attachment := output(	bodycontent);
	
	 SuccessBody		:= bodycontent;
	

	 BuildSuccess	:= fileservices.sendemail(
													Email_Notification_Lists.NCOSuccess,
													SuccessSubject,
													SuccessBody);
	//													'Stats Complete - Please view attachment\n**File on thor expires in 7 days',
	//												'text/xml',
	//'attachment.txt') ;
												

	 BuildFailure	:= fileservices.sendemail(
													Email_Notification_Lists.BuildFailure,
													'PhonesFeedBack nco Customer Stat Failed on '+ _Control.ThisEnvironment.Name,
													workunit +  failmessage);
							 
result := sequential(spray,checkDS_IN,writefull,writecmpFormat,add2super):SUCCESS(BuildSuccess),FAILURE(BuildFailure);

return result;
end;