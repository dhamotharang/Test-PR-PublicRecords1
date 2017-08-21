IMPORT STD, GlobalWatchLists, GlobalWatchLists_Preprocess, ut, Data_Services;

//Base File
ProdBase := dataset('~thor_data400::base::globalwatchlists',Globalwatchlists.Layout_GlobalWatchLists,flat);

// Office of Foreign Asset Control

  OFACRaw  := GlobalWatchLists_Preprocess.Files.dsOFACPrimary;
  OFACBase  := ProdBase(source = 'Office of Foreign Asset Control');				
	
	jOFAC:= join(OFACRaw,OFACBase,
              'OFAC' + left.sdn_id = right.pty_key,
              left only);
						 
MissingOFAC	:= count(jOFAC); 
jOFAC_out := IF(MissingOFAC > 0, FAIL(MissingOFAC + ' Office_Foreign_Asset_Control_InRaw_notbase'));
output(jOFAC,named('Office_Foreign_Asset_Control_InRaw_notbase'));
//============================================================================================
// OFAC - Palestinian Legislative Council
 OFACPLCRaw	:= DATASET(GlobalWatchLists_Preprocess.root+'ofac::new_plc',GlobalWatchLists_Preprocess.Layouts.rInputOFAC,CSV(HEADING(0),SEPARATOR(''),TERMINATOR(['\n', '\r\n']),QUOTE('"')));
 OFACPLCBase  := ProdBase(source = 'OFAC - Palestinian Legislative Council');			
		
	jOFACPLC:= join(OFACPLCRaw,OFACPLCBase,
                  'OFAC'+left.row_data[STD.Str.Find(left.row_data, '|', 1) + 1..STD.Str.Find(left.row_data, '|', 2) - 1] = right.pty_key,
                 left only);
								 
MissingOFACPLC := count(jOFACPLC); 
jOFACPLC_out := IF(MissingOFACPLC > 0, FAIL(MissingOFACPLC + ' US_OFAC_PLC_InRaw_notbase'));
output(jOFACPLC,named('US_OFAC_PLC_InRaw_notbase'));

EXPORT ValidateOFACRaw_to_Base := SEQUENTIAL(jOFAC_out, jOFACPLC_out)
																					: SUCCESS(output('ALL OFAC RECORDS FOUND IN BASE')),
																						FAILURE(FileServices.sendemail(GlobalWatchLists_Preprocess.Notification_Email_Address,'OFAC RECORDS MISSING FROM BASE. WU#: '+ workunit, failmessage));