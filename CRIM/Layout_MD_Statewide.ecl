export Layout_MD_Statewide := module

export Circuit := record
string ID;
string CaseStatus;
string CaseType;
string TrackingNumber;
string FilingDate;
string CourtSystem;
string Case_Disposition;
string Case_DispositionDate;
string IncidentDate;
string Name;
string sex;
string Height;
string Weight;
string DOB;
string Race;
string Address;
string City;
string State;
string Zip;
string Alias;
string CourtDate;
string CourtTime;
string Room;
string CourtLocation;
string Reason;
string ChargeNo;
string CJISCode;
string StatuteCode;
string Charge_Description;
string OffenseDateFrom;
string OffenseDateTo;
string ArrestTrackingNo;
string Citation;
string ChargeAmendNo;
string SentenceVision;
string Charge_class;
string Plea;
string PleaDate;
string Disposition;
string DispositionDate;
end;

export District:= record
string ID;
string CaseStatus;
string CaseType;
string TrackingNumber; //TrackingNo
string IssuedDate;
string DocumentType;
string DistrictCode;
string LocationCode;
string CourtSystem;
string Case_Disposition;
string Name;
string sex;
string Height;
string Weight;
string DOB;
string Race;
string Address;
string City;
string State;
string Zip;
string CourtDate; //TrialDate
string CourtTime; //TrialTime
string Room;
string CourtLocation; //TrialLocation
string TrialType;
string ChargeNo;
string Charge_Description;
string StatuteCode; //Statute
string Statute_Description;
string AmendedDate;
string CJISCode;
string MO_PLL;
string ProbableCause;
string OffenseDateFrom; //IncidentDateFrom
string OffenseDateto; //IncidentDateTo
string VictimAge;
string Plea;
string Disposition;
string DispositionDate;
string Fine;
string Court_costs;
string CICF;
string Amt_Suspended_Fine;
string Amt_Suspended_Court_costs;
string Amt_Suspended_CICF;
string PBJ_EndDate;
string Probation_End_Date;
string Restitution_Amount;
string JailTerm;
string SuspendedTerm;
string CreditTimeServed;
string Alias;
end;

end;


