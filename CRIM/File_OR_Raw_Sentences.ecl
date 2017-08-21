import ut;

/* There are a number of judgments on sentences that should not be included within the set of data:

   DISC - "Discharged"
   JGDS - "Judgment Dismissd"
   JGSA - "Judgment Set-Aside"
   RVRS - "Reversed"
   SETA - "Set Aside"
   SLRP - "Sale Real Property"
   SUPR - "Superseded Judgment"
   USAT - "Unsatisfied Judgment"
   VCTD - "Vacated Judgment"
   VOID - "Voided  Judgment"
   ADWO - "Administrative Write-off"

*/
ignored_decisions := ['DISC','JGDS','JGSA','RVRS','SETA','SLRP'
			         ,'SUPR','USAT','VCTD','VOID','ADWO'];

ds_sentences := dataset(ut.foreign_dataland + '~thor_data400::in::or_court_mapped_Sentences',Crim.Layout_OR_Sentences,flat);

export File_OR_Raw_Sentences := ds_sentences(decision_status NOT IN ignored_decisions);