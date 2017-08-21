import PromoteSupers,doxie_build;

DOC_offense  := dataset('~thor_data400::base::corrections_offenses_public', hygenics_crim.Layout_Base_Offenses_with_OffenseCategory, flat);
Crt_offense  := dataset('~thor_data400::base::corrections_court_offenses_public', hygenics_crim.Layout_Base_CourtOffenses_with_OffenseCategory, flat);

offense_rec := record
 // Crt_offense.data_type;
 DOC_offense.off_desc_1 ;
 DOC_offense.off_desc_2 ;
 DOC_offense.offense_category;
 string8 dt_first_classified; 
 string8 dt_last_classified; 
 string1 Current_rec;
end;

arrest_offenses     := Project(Crt_offense(data_type ='5' and arr_off_desc_1 <> '' /*and offense_category <> 0*/),
                                                          transform(offense_rec,self.off_desc_1          := left.arr_off_desc_1; 
                                                                                self.off_desc_2          := left.arr_off_desc_2; 
																																								self.dt_first_classified := hygenics_crim._functions.GetDate;
																																								self.dt_last_classified  := hygenics_crim._functions.GetDate;
																																								self.Current_rec         := 'Y';																																								
																																								self := left;
																																								));																																								
court_offenses      := Project(Crt_offense(data_type ='2' and court_off_desc_1 <> '' /*and offense_category <> 0*/),
                                                          transform(offense_rec,self.off_desc_1          := left.court_off_desc_1;
                                                                                self.off_desc_2          := left.court_off_desc_2;  
																																								self.dt_first_classified := hygenics_crim._functions.GetDate;
																																								self.dt_last_classified  := hygenics_crim._functions.GetDate;
																																								self.Current_rec         := 'Y';
																																								self := left;
																																								));																																								
//dist_court_offense := TABLE(court_offense+arrest_offense ,{data_type,off_desc_1, count_ := count(group)},data_type,off_desc_1,few );
doc_offenses				:= Project(DOC_offense(off_desc_1 <> '' /*and offense_category <> 0*/),                 
                                                          transform(offense_rec,self.dt_first_classified := hygenics_crim._functions.GetDate;
																																								self.dt_last_classified  := hygenics_crim._functions.GetDate;
																																								self.Current_rec         := 'Y';
 																																			          self := left;
																																								));

old_ds := distribute(dataset('~thor_data400::base::corrections_offense_category_public', offense_rec,thor),HASH(off_desc_1,off_desc_2)); 
new_ds := dedup(sort(distribute(arrest_offenses+ court_offenses+ doc_offenses,HASH(off_desc_1,off_desc_2)),record,local),record,local); 

ProjectedOldds     := Project(old_ds(Current_rec ='Y'), transform(offense_rec, self.Current_rec         := 'Z';
 																																			         self := left;
																																								));
																																								
comb_history_ds    := If (nothor(FileServices.GetSuperFileSubCount('~thor_data400::base::corrections_offense_category_public') <> 0), 
                          Sort(ProjectedOldds+new_ds,-off_desc_1,-off_desc_2,-offense_category,-dt_last_classified,local),
  											  Sort(new_ds       ,-off_desc_1,-off_desc_2,-offense_category,-dt_last_classified,local)
												 );													
							
comb_history_ds rolluphist(comb_history_ds L, comb_history_ds R) := TRANSFORM
							
                self.off_desc_1          := L.off_desc_1;
                self.off_desc_2          := L.off_desc_2;
								self.dt_first_classified := R.dt_first_classified;
								self.dt_last_classified  := L.dt_last_classified;
	              self.offense_category    := L.offense_category ; 							
                SELF   := L; 
END;

rollupCrimOut := ROLLUP(comb_history_ds,  
                 trim(left.off_desc_1)  = trim(right.off_desc_1) and 
							   trim(left.off_desc_2)  = trim(right.off_desc_2) and 
							   left.offense_category  = right.offense_category ,
														   rolluphist(LEFT,RIGHT),local) : persist ('persist::Distinct_offense_category');		

CrimHistory_rolledup  := Project(rollupCrimOut, transform(offense_rec, self.Current_rec := If(left.Current_rec = 'Z','N',left.Current_rec );
                                                                    self.dt_last_classified	:= hygenics_crim._functions.GetDate;																																													
 																																		self := left;
																											));
CrimHistory_final     := If (nothor(FileServices.GetSuperFileSubCount('~thor_data400::base::corrections_offense_category_public') <> 0), 
                             CrimHistory_rolledup+old_ds(Current_rec ='N'),
  											     CrimHistory_rolledup
												     );
PromoteSupers.MAC_SF_BuildProcess(CrimHistory_final,'~thor_data400::base::corrections_offense_category_' + doxie_build.buildstate,aout,2,,true);

// sequential(aout);

export Proc_build_Offense_category_history := aout;