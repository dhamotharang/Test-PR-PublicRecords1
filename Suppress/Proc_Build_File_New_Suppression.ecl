import Doxie,RoxieKeyBuild,ut;

export Proc_Build_File_New_Suppression(STRING pVersion) := function

dNonPullSSN_Rec := DATASET('~thor_data400::in::suppress', Suppress.Layout_New_Suppression, csv(terminator('\r\n'), separator(','), quote('\'')));

pullSSN := Doxie.File_pullSSN[5..];  //first 5 records are garbage

Suppress.Layout_New_Suppression PopNewSupp(pullSSN L) := transform
 self.Product := 'ALL';
 self.Linking_type := map(length(stringlib.stringfilterout(trim(l.ssn),'0123456789'))>0 => '',
													length(trim(l.ssn))=12 => 'DID',
													length(trim(l.ssn))=9 => 'SSN','?');
 self.Linking_ID := if(length(stringlib.stringfilterout(trim(l.ssn),'0123456789'))>0,'',l.ssn);												
 self.Document_Type := map(l.ssn[1..2] in ['RA','RD'] => 'ln_fares_id',
													length(stringlib.stringfilterout(trim(l.ssn),'0123456789'))=0 => '','offender_key');
 self.Document_ID := if(length(stringlib.stringfilterout(trim(l.ssn),'0123456789'))=0,'',l.ssn);												
 self.Comment := 'Original PullSSN data';
 self := [];
end;

New_Suppression := PROJECT(pullSSN,PopNewSupp(LEFT)) + dNonPullSSN_Rec + File_PeopleWise;
																	
RoxieKeyBuild.Mac_SF_BuildProcess(new_suppression,'~thor_data400::base::new_suppression_file','~thor_data400::base::new_suppression::'+pVersion+'::data',build_file,2);

return build_file;

end;
