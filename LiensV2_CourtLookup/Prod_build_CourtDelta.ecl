import PromoteSupers,doxie_build,std;

STRING8 GetDate := (STRING8)Std.Date.Today();																																					
CourtIn_Proj				:= Project(LiensV2_CourtLookup.Files().CourtIn,                 
                               transform(Layouts.rBaseCourtLookup,self.Date_first_seen := GetDate;
																										            	self.Date_last_seen  := GetDate;
																											            self.Current_rec     := 'Y';																											     
																											            self := left;
																											           ));

old_ds             := distribute(LiensV2_CourtLookup.Files().CourtBase,HASH(LNCourtCode)); 
new_ds             := dedup(sort(distribute(CourtIn_Proj,HASH(LNCourtCode)),record,local),record,local); 

ProjectedOldds     := Project(old_ds(Current_rec ='Y'), transform(Layouts.rBaseCourtLookup, self.Current_rec         := 'Z';
 																																			         self := left;
																																								));
																																								
combined_ds        := If (nothor(FileServices.GetSuperFileSubCount('~thor_data400::base::liens::courtsetupslj') <> 0), 
                          Sort(ProjectedOldds+new_ds,LNCourtCode,-Date_last_seen,RMSCourtCode,CourtName,local),
  											  Sort(new_ds               ,LNCourtCode,-Date_last_seen,RMSCourtCode,CourtName,local)
												 );													
							
							
						
combined_ds rolluphist(combined_ds L, combined_ds R) := TRANSFORM							
								self.Date_first_seen := R.Date_first_seen;
                SELF   := L; 
END;

rollupCourt           := ROLLUP(combined_ds,  
                                trim(left.LNCourtCode)  = trim(right.LNCourtCode)  and
																trim(left.County)       = trim(right.County)       and
																trim(left.CourtName)    = trim(right.CourtName)    and 
																trim(left.RMSCourtCode) = trim(right.RMSCourtCode) and
		                            trim(left.CourtName)    = trim(right.CourtName)    and
		                            trim(left.Address1)     = trim(right.Address1)     and
		                            trim(left.Address2)     = trim(right.Address2)     and
		                            trim(left.City)         = trim(right.City)         and
		                            trim(left.State)        = trim(right.State)        and
		                            trim(left.ZipCode)      = trim(right.ZipCode)      , 
												        rolluphist(LEFT,RIGHT),local) : persist ('persist::liens::courtsetupslj');		

CrimHistory_rolledup  := Project(rollupCourt, transform(Layouts.rBaseCourtLookup,self.Current_rec    := If(left.Current_rec = 'Z','N',left.Current_rec );
                                                                    self.Date_last_seen	:= If(left.Current_rec = 'Z',left.Date_last_seen,GetDate);																																													
 																																		self := left;
																));
CrimHistory_final     := If (nothor(FileServices.GetSuperFileSubCount('~thor_data400::base::liens::courtsetupslj') <> 0), 
                             CrimHistory_rolledup+old_ds(Current_rec ='N'),
  											     CrimHistory_rolledup
												     );
PromoteSupers.MAC_SF_BuildProcess(CrimHistory_final,'~thor_data400::base::liens::courtsetupslj',aout,2,,true);

// sequential(aout);

EXPORT Prod_build_CourtDelta := aout;