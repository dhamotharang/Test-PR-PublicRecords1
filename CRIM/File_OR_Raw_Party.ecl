import ut;

/* The translations for criminal defendant codes are found throughout the code tables file.
   You need to look in a number of locations to compile all the relevant values.  
   The following are my best guess at which are the proper codes to use, but it should be
   noted that none will come up unless linked with a criminal case throught he mapping process:

   3DA - "3rd-Party-Defendant/Appellant"
   3DC - "3rd-Party-Defendant/Respondent-Cross-Appellant"
   3DD - "3rd-Party-Defendant/Appellant-Cross-Respondent"
   3DF - "3rd-Party-Defendant"
   3DP - "3rd party defendant/cross-appellant"
   3DR - "3rd-Party-Defendant/Respondent"
   3DT - "3rd party defendant/cross-respondent"
   4DF - "4th Party Defendant"
   ACC - "Accused"
   AKA - "Also Known As"
   CDF - "Co-Defendant"
   COD - "Co-Delinquent"
   CRO - "Cross-Defendant"
   DAC - "Defendant/Appellant-Cross-Respondent"
   DAP - "Defendant/Appellant"
   DCA - "Defendant/Cross-Appellant"
   DCR - "Defendant/Cross-Respondent"
   DEF - "Defendant"
   DFA - "Defendant-Adverse Party"
   DFE - "Defendant-Relator"
   DFR - "Defendant/Respondent"
   DRC - "Defendant/Respondent-Cross-Appellant"
   DRR - "Defendant/Respondent-Cross-Respondent"
*/

crim_offenders    := ['3DA','3DC','3DD','3DF','3DP','3DR','3DT','4DF','ACC','AKA','CDF','COD'
                     ,'CRO','DAC','DAP','DCA','DCR','DEF','DFA','DFE','DFR','DRC','DRR'];

ds_party := dataset(ut.foreign_dataland + '~thor_data400::in::OR_Court_mapped_parties',Crim.Layout_OR_Party,flat);

// Filter for just criminal defendants
export File_OR_Raw_Party := ds_party(Party_Side IN crim_offenders);
