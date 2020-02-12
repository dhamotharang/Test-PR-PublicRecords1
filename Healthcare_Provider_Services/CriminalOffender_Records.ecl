import Healthcare_Header_Services,doxie,AutoStandardI,CriminalRecords_Services,iesp;

export CriminalOffender_Records (Healthcare_Header_Services.IParams.ReportParams inputData, 
                                 doxie.IDataAccess mod_access,
                                 dataset(doxie.layout_references) dsDids) := module

  tmpCrimSearchMod := module(project(inputData,CriminalRecords_Services.IParam.report,opt))
    doxie.compliance.MAC_CopyModAccessValues(mod_access);
    export string14 did := (string)dsDids[1].did;
    export string25 doc_number      := '';
    export string60 offender_key    := '';
    export boolean  IncludeAllCriminalRecords := true;
    export boolean  IncludeSexualOffenses := true;  
  end;

  crimResults := CriminalRecords_Services.ReportService_Records.val(tmpCrimSearchMod);
  // FilterCrims := crimResults(CriminalRecords.Name.last = inputData.LastName or inputData.LastName = '');
  sortOffenses := project(crimResults,
                    transform(iesp.criminal.t_CrimReportResponse, 
                          self.CriminalRecords := project(left.CriminalRecords(Name.Last = inputData.LastName or inputData.LastName = ''),transform(iesp.criminal.t_CrimReportRecord,
                                                            self.Offenses:= sort(left.Offenses,map(stringlib.StringFind(stringlib.StringToUpperCase(left.Offenses.Court.Level),'FELONY',1)>0 => 1,
                                                                                                   stringlib.StringFind(stringlib.StringToUpperCase(left.Offenses.Court.Level),'MISDEMEANOR',1)>0 => 2,
                                                                                                   stringlib.StringFind(stringlib.StringToUpperCase(left.Offenses.Court.Level),'INFRACTION',1)>0 => 3,
                                                                                                   4));
                                                            self := left));
                          self:=left));
  export dsCriminalRecords := choosen(sortOffenses.CriminalRecords,iesp.Constants.BR.MaxCrimRecords);
end;
