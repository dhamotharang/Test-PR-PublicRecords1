import doxie, doxie_build, ut, hygenics_search;

export Key_prep_casenumber(boolean IsFCRA = false) := function

key_layout := RECORD
hygenics_crim.file_offenders_keybuilding.case_num;
hygenics_crim.file_offenders_keybuilding.offender_key;
string1 file_indicator;
END;

doc_offense_ds 	:= dataset('~thor_data400::base::corrections_offenses_' + doxie_build.buildstate,hygenics_crim.Layout_Base_Offenses_with_OffenseCategory,flat);
Doc_Offense := Prep_Build.PB_File_Offenses(Doc_offense_ds);
court_offense_ds := dataset('~thor_Data400::base::corrections_court_offenses_' + doxie_build.buildstate,hygenics_crim.Layout_Base_CourtOffenses_with_OffenseCategory,flat);
court_offense := Prep_Build.PB_File_CourtOffenses(court_offense_ds);

invalid_case_nums := ['&nbsp;'];
offender   := dedup(sort(distribute(hygenics_crim.file_offenders_keybuilding( ),HASH64(offender_key)),offender_key,case_num,local),offender_key,case_num,local);
court_off  := dedup(sort(distribute(court_offense(court_case_number <>'' and court_case_number not in invalid_case_nums ) ,HASH64(offender_key)),offender_key,court_case_number,local),offender_key,court_case_number,local);
offense    := dedup(sort(distribute(doc_offense(case_num <>'' and case_num not in invalid_case_nums ),HASH64(offender_key)),offender_key,case_num,local),offender_key,case_num,local);

key_layout slimoffender(offender L) := TRANSFORM

self.case_num       := MAP(L.vendor ='NF' => hygenics_crim._functions.clean_case_number(L.case_num[4..]),
                           hygenics_crim._functions.clean_case_number(L.case_num));
self.file_indicator := 'O'; // stands for offender
self := L;
END;

slim_df 	  := project(offender(),slimoffender(left),local);


key_layout slimcourtoffenses(slim_df L, court_off R) := TRANSFORM

self.case_num       := MAP(R.vendor ='NF' => hygenics_crim._functions.clean_case_number(R.court_case_number[4..]),
                           hygenics_crim._functions.clean_case_number(R.court_case_number));
self.file_indicator := 'C'; // stands for court offense
self := L;
END;

key_layout slimoffenses(slim_df L, offense R) := TRANSFORM

self.case_num       := hygenics_crim._functions.clean_case_number(R.case_num);
self.file_indicator := 'D'; // stands for court offense
self := L;
END;

slim_dfco 	:= join(slim_df, court_off,
                    left.offender_key =right.offender_key,slimcourtoffenses(left,right),local);

slim_dfo 	  := join(slim_df, offense,
                   left.offender_key =right.offender_key,slimoffenses(left,right),local);

df := dedup(sort(slim_df  (case_num <>'' and case_num not in invalid_case_nums) + 
                 slim_dfco(case_num <>'') + 
								 slim_dfo (case_num <>''),record,local),offender_key,case_num,RIGHT,local) :persist('persist::corrections_offenders_casenumber');

output(df);
string file_name := if(IsFCRA, 
					 '~thor_data400::key::criminal_offenders::fcra::'+doxie.Version_SuperKey+'::casenumber',
					 '~thor_data400::key::corrections_offenders_casenumber'+doxie_build.buildstate + thorlib.wuid());

return index(df(case_num <> '' and length(trim(case_num)) >=3),{case_num},{Offender_key,file_indicator}, file_name);
//if (IsFCRA,
//           index(df2((integer)did != 0),{unsigned6 sdid := (integer)df2.did},{df2}, file_name, OPT),
//           index(df((integer)did != 0),{unsigned6 sdid := (integer)df.did},{df}, file_name));

end;