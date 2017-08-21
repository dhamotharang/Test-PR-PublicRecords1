import STRATA;

export Out_Base_Stats_Population_Group(string filedate) := function

rPopulationStats_Ingenix_NatlProf__Basefile_Group_BDID
 :=
  record
    CountGroup                                                                               := count(group);
    BDID_CountNonBlank                                   := sum(group,if(Ingenix_NatlProf.Basefile_Group_BDID.BDID<>'',1,0));
    BDID_SCORE_CountNonBlank                             := sum(group,if(Ingenix_NatlProf.Basefile_Group_BDID.BDID_SCORE<>'',1,0));
    dt_first_seen_CountNonBlank                          := sum(group,if(Ingenix_NatlProf.Basefile_Group_BDID.dt_first_seen<>'',1,0));
    dt_last_seen_CountNonBlank                           := sum(group,if(Ingenix_NatlProf.Basefile_Group_BDID.dt_last_seen<>'',1,0));
    dt_vendor_first_reported_CountNonBlank               := sum(group,if(Ingenix_NatlProf.Basefile_Group_BDID.dt_vendor_first_reported<>'',1,0));
    dt_vendor_last_reported_CountNonBlank                := sum(group,if(Ingenix_NatlProf.Basefile_Group_BDID.dt_vendor_last_reported<>'',1,0));
    Ingenix_NatlProf.Basefile_Group_BDID.FILETYP;
    ProcessDate_CountNonBlank                            := sum(group,if(Ingenix_NatlProf.Basefile_Group_BDID.ProcessDate<>'',1,0));
    
    GroupName_CountNonBlank                              := sum(group,if(Ingenix_NatlProf.Basefile_Group_BDID.GroupName<>'',1,0));
    GroupNameCompanyCount_CountNonBlank                  := sum(group,if(Ingenix_NatlProf.Basefile_Group_BDID.GroupNameCompanyCount<>'',1,0));
    GroupNameTierTypeID_CountNonBlank                    := sum(group,if(Ingenix_NatlProf.Basefile_Group_BDID.GroupNameTierTypeID<>'',1,0));
  end;



dPopulationStats_Ingenix_NatlProf__Basefile_Group_BDID := table(Ingenix_NatlProf.Basefile_Group_BDID,
                                                              rPopulationStats_Ingenix_NatlProf__Basefile_Group_BDID,
                                                              FILETYP,
										                                          few
									                                           );
STRATA.createXMLStats(dPopulationStats_Ingenix_NatlProf__Basefile_Group_BDID,
                      'Ingenix_NatlProf',
					            'Provider',
					            filedate,
					            '',
					            resultsOut,
								'view',
								'population'
					           );
					 
return resultsOut;
end;