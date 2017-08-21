import Doxie,RoxieKeyBuild,ut,crim_common,header_services, official_records;

//Data_Type: 1 = Offender_key, 2 = Official Records, 3 = Bob Records

export Proc_Build_File_New_Suppression_Test(STRING pVersion) := function

//############# Layouts ###############
inRec :=
RECORD
	string60 ssn; //This is not neccesarily an ssn - It can also be a Criminal Offender Key, Official Records ID or Fares ID.
	string1 lf;
END;

inLN_Optpout :=
RECORD
	string12 id; //This is an SSN or a DID.
	string1 lf;
END;
//#####################################
//####### Data sets ###################
//LN_VIP file
df_peoplewise   := dataset(ut.foreign_prod + '~thor_data400::in::peoplewise', Suppress.Layout_New_Suppression , csv(terminator('\n'), separator(','), quote('\'')));
//Exported PullSSN file - From Web based form
pullSSN         := dataset(ut.foreign_prod + '~thor_data400::in::pull_ssn', Suppress.Layout_New_Suppression, flat);
//LN OpOut file - SSN and DID records 
LN_OptOut       := dataset('~thor_data400::out::ln_optout_did', inLN_Optpout, flat);
//ALL records (Bob records)
df_Supplemental := doxie.File_pullSSN_Supplemental_All;
//LE Records
df_PullSSN_LE   := dataset('~thor_data400::in::pull_ssn_le', inRec, flat);
//New LAB records
df_suppress_lab   := dataset('~thor_data400::in::suppression::lab', Suppress.Layout_New_Suppression, flat);
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


LE_Offender_Keys := pullSSN(Document_Type = 'OFFENDER KEY');


//##############################################################
//########### Begin For PullSSN LE - Offender Keys##############
Suppress.Layout_New_Suppression off_key_Output_le(LE_Offender_Keys l) := transform
self.Product := 'LE';
self := [];
END;
//############## End PullSSN LE - Offender Keys ################
//##############################################################

//###########################################################################################################
/*The following Transform is to classify LN Opt Out records as SSN or DID.*/
Suppress.Layout_New_Suppression LN_Opt_Out_Records(LN_OptOut l) := transform
 self.Product := 'ACCURINT';
 self.Linking_type :=  map(length(trim(l.id))=12 => 'DID',
						   length(trim(l.id))=9 => 'SSN','');
 self.Linking_ID := l.id;
 self.Comment := 'LN OPT OUT RECORDS';
 self := [];
end;
//###########################################################################################################
//###########################################################################################################

New_Suppression := PROJECT(df_Supplemental,AllRecords(LEFT)) + PROJECT(LE_Offender_Keys,off_key_Output_le(LEFT)) + PROJECT(LN_OptOut,LN_Opt_Out_Records(LEFT)) + PullSSN + df_peoplewise + df_suppress_lab;
																	
RoxieKeyBuild.Mac_SF_BuildProcess(new_suppression,'~thor_data400::base::new_suppression_file','~thor_data400::base::new_suppression::'+pVersion+'::data',build_file,2);

return build_file;

end;
