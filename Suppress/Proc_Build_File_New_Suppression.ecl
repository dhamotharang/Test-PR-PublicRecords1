import Doxie,RoxieKeyBuild,ut,crim_common,header_services, official_records;

//Data_Type: 1 = Offender_key, 2 = Official Records, 3 = Bob Records

export Proc_Build_File_New_Suppression(STRING pVersion) := function

//############# Layouts ###############
inRec :=
RECORD
	string60 ssn; //This is not neccesarily an ssn - It can also be a Criminal Offender Key, Official Records ID or Fares ID.
	string1 lf;
END;

inLN_Optpout :=
RECORD
  string12 did;
END;

web_layout := record
Suppress.Layout_New_Suppression;
string2 crlf;
end;

//#####################################
//####### Data sets ###################
//LN_VIP file
df_peoplewise   := dataset('~thor_data400::in::peoplewise', Suppress.Layout_New_Suppression , csv(terminator('\n'), separator(','), quote('\'')));
//Exported PullSSN file - From Web based form
web_suppress    := dataset('~thor_data400::in::web_suppression', web_layout, flat);
//LN OpOut file - SSN and DID records 
LN_OptOut       := dataset('~thor_data400::out::ln_optout_did', inLN_Optpout, flat);
//PPLWise OpOut file - SSN and DID records 
PPLWise_OptOut       := dataset('~thor_data400::out::pplwise_optout_did_consumer', inLN_Optpout, flat);
//ALL records (Bob records)
df_Supplemental := doxie.File_pullSSN_Supplemental_All;
//LE Records
df_PullSSN_LE   := dataset('~thor_data400::in::pull_ssn_le', inRec, flat);
//New LAB records
df_suppress_lab := dataset('~thor_data400::in::suppression::lab', Suppress.Layout_New_Suppression, flat);
//#####################################


//###########################################################################################################
/*The following Transform is to classify the All records as SSN or DID.*/
Suppress.Layout_New_Suppression AllRecords(df_Supplemental l) := transform
 self.Product := 'ALL';
 self.Linking_type :=  map(length(trim(l.ssn))=12 => 'DID',
						   length(trim(l.ssn))=9 => 'SSN','');
 self.Linking_ID := l.ssn;
 self.Comment := 'BOBS ALL RECORDS';
 self := [];
end;
//###########################################################################################################
//###########################################################################################################


LE_Offender_Keys := web_suppress(Document_Type = 'OFFENDER KEY');


//##############################################################
//########### Begin For PullSSN LE - Offender Keys##############
Suppress.Layout_New_Suppression off_key_Output_le(LE_Offender_Keys l) := transform
self.Product := 'LE';
self.Linking_type := l.Linking_type;    
self.Linking_ID := l.Linking_ID;     
self.Document_Type :=l.Document_Type;
self.Document_ID := l.Document_ID;
self.Date_Added := l.Date_Added;
self.User := l.User;
self.Compliance_ID := l.Compliance_ID;
self.Comment := l.Comment;
END;
//############## End PullSSN LE - Offender Keys ################
//##############################################################

//########################################################################################
//The following Transform is to classify all the records from the Pullssn_LE file as 'LE'.
Suppress.Layout_New_Suppression PopNewSupp_LE(df_PullSSN_LE L) := transform
 self.Product := 'LE';
 self.Linking_type := map(length(trim(l.ssn))=12 => 'DID',
					      length(trim(l.ssn))=9  => 'SSN','');
 self.Linking_ID := l.ssn;
 self.Comment := 'PULLSSN_LE DID OR SSN';
 self := [];
end;
//########################################################################################
//########################################################################################

//##############################################################
//########### Begin For web_suppress reformat ##############
Suppress.Layout_New_Suppression web_suppress_Output(web_suppress l) := transform
self.Product := l.Product;
self.Linking_type := l.Linking_type;    
self.Linking_ID := l.Linking_ID;     
self.Document_Type :=l.Document_Type;
self.Document_ID := l.Document_ID;
self.Date_Added := l.Date_Added;
self.User := l.User;
self.Compliance_ID := l.Compliance_ID;
self.Comment := l.Comment;
END;
//############## End For web_suppress reformat ################
//##############################################################

//###########################################################################################################
/*The following Transform is to classify LN Opt Out records as SSN or DID.*/
Suppress.Layout_New_Suppression LN_Opt_Out_Records(LN_OptOut l) := transform
 self.Product := 'ACCURINT';
 self.Linking_type :=  map(length(trim(l.did))=12 => 'DID',
						   length(trim(l.did))=9 => 'SSN','');
 self.Linking_ID := l.did;
 self.Comment := 'LN OPT OUT RECORDS';
 self := [];
end;
//###########################################################################################################
//###########################################################################################################

//###########################################################################################################
/*The following Transform is to classify PPLWise Opt Out records as SSN or DID.*/
Suppress.Layout_New_Suppression PPLWise_Opt_Out_Records(PPLWise_OptOut l) := transform
 self.Product := 'CONSUMER';
 self.Linking_type :=  map(length(trim(l.did))=12 => 'DID',
						   length(trim(l.did))=9 => 'SSN','');
 self.Linking_ID := l.did;
 self.Comment := 'CONSUMER OPT OUT RECORDS';
 self := [];
end;
//###########################################################################################################
//###########################################################################################################

New_Suppression_base := PROJECT(df_Supplemental,AllRecords(LEFT)) + PROJECT(web_suppress,web_suppress_Output(LEFT)) + PROJECT(LE_Offender_Keys,off_key_Output_le(LEFT)) + PROJECT(LN_OptOut,LN_Opt_Out_Records(LEFT)) + PROJECT(PPLWise_OptOut,PPLWise_Opt_Out_Records(LEFT)) + PROJECT(df_PullSSN_LE,PopNewSupp_LE(LEFT)) /*+  df_peoplewise*/ + df_suppress_lab;
New_Suppression      := New_Suppression_base(Linking_ID not in Suppress.UNsuppress_DID());
New_Suppression_fcra := New_Suppression_base(Linking_ID not in Suppress.UNsuppress_DID(true));
															
RoxieKeyBuild.Mac_SF_BuildProcess(new_suppression,'~thor_data400::base::new_suppression_file','~thor_data400::base::new_suppression::'+pVersion+'::data',build_file,2);
RoxieKeyBuild.Mac_SF_BuildProcess(new_suppression_fcra,'~thor_data400::base::new_suppression_file_fcra','~thor_data400::base::new_suppression_fcra::'+pVersion+'::data',build_file_fcra,2);

return sequential(build_file, build_file_fcra);

end;
