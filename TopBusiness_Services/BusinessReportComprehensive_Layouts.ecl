import iesp;
export BusinessReportComprehensive_Layouts := record
  iesp.topbusinessreport.t_TopBusinessReportOption;
	string32 ApplicationType;
	boolean internal_testing;
	boolean LnBranded;
	boolean restrictexperian := false;
end;