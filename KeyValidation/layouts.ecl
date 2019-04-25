EXPORT layouts := module

export summaryLayout := record
  string NameOfTheKey;
	string TypeOfTheKey;
	string TypeOfTheParent;
	integer NumberOfParentRecords;
	integer NumberOfKeyRecords;
	integer NumberOfJoinedRecords;
	integer NumberOfUnmatchedRecords;
	integer NumberOfKnownIssues;
	string Result;
	string NameOfDetailedReport;
end;

end;