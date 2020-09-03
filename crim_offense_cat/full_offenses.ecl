import hygenics_crim;
// new_offenses.ecl - Used To Generate Full Offenses For Machine Learing Categorization
// Output Format is csv

export full_offenses(string filedate) := function

//Record Types
//Data Type 1 = DOC/Corrections
//Data Type 2 = Court
//Data Type 5 = Arrest

//Criminal build base files
DOC_Offenses := dataset('~thor_data400::base::corrections_offenses_public', hygenics_crim.Layout_Base_Offenses_with_OffenseCategory, flat);
Court_Arrest_Log_Offenses := dataset('~thor_data400::base::corrections_court_offenses_public', hygenics_crim.Layout_Base_CourtOffenses_with_OffenseCategory, flat);

superfile_shuffle := sequential(
                                FileServices.ClearSuperFile('~thor_data400::out::full_offenses_for_categorization_delete'),
                                FileServices.AddSuperFile('~thor_data400::out::full_offenses_for_categorization_delete', '~thor_data400::out::full_offenses_for_categorization_father',,1),
                                FileServices.ClearSuperFile('~thor_data400::out::full_offenses_for_categorization_father'),
                                FileServices.AddSuperFile('~thor_data400::out::full_offenses_for_categorization_father', '~thor_data400::out::full_offenses_for_categorization',,1),
                                FileServices.ClearSuperFile('~thor_data400::out::full_offenses_for_categorization'),
                                );

//Getting just the offenses to join to the Category file
slim_layout := record
string offense;
END;

slim_layout DOC_Offenses_Output(DOC_Offenses l) := transform
self.offense := trim(l.off_desc_1,LEFT,RIGHT);
END;

slim_layout Arrest_Log_Offenses_Output(Court_Arrest_Log_Offenses l) := transform
self.offense := trim(l.arr_off_desc_1,LEFT,RIGHT);
END;

slim_layout Court_Offenses_Output(Court_Arrest_Log_Offenses l) := transform
self.offense := trim(l.court_off_desc_1,LEFT,RIGHT);
END;

pDOC_Offenses := PROJECT(DOC_Offenses,DOC_Offenses_Output(LEFT));
pArrest_Log_Offenses := PROJECT(Court_Arrest_Log_Offenses,Arrest_Log_Offenses_Output(LEFT));
pCourt_Offenses := PROJECT(Court_Arrest_Log_Offenses,Court_Offenses_Output(LEFT));

// The full Offense Description Extract from the Criminal base files
Offenses_All := pDOC_Offenses + pArrest_Log_Offenses + pCourt_Offenses;


//Filtering, distibuting, sorting and deduping
Offenses_All_NonBlank := Offenses_All(offense <> '');

Offenses_Distributed := distribute(Offenses_All_NonBlank, hash(offense));

Offenses_Done := dedup(sort(Offenses_Distributed(offense <> ''),offense, local),offense, local);

//Output a file 
retval := sequential(
                     superfile_shuffle,
                     output(Offenses_Done,,'~thor_data400::out::full_offenses_for_categorization_' + filedate, CSV, all, overwrite),
                     FileServices.AddSuperFile('~thor_data400::out::full_offenses_for_categorization', '~thor_data400::out::full_offenses_for_categorization_' + filedate),
                     FileServices.Despray('~thor_data400::out::full_offenses_for_categorization_' + filedate, 'uspr-edata11.risk.regn.net', '/data/stub_cleaning/court/offense_category/input/' + filedate + '/full_offenses_' + filedate + '.csv',,,,TRUE)
										 );
						
return retval;

end;



