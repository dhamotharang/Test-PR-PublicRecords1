EXPORT Layouts := MODULE

EXPORT RawInput_layout := Record
  STRING Account;
  STRING First;
  STRING Middle;
  STRING Last;
  STRING NameSuffix;
  STRING StreetAddress;
  STRING City;
  STRING State;
  STRING Zip;
  STRING HomePhone;
  STRING SSN;
  STRING DateOfBirth;
  STRING WorkPhone;
  STRING Income;
  STRING DLnumber;
  STRING DLstate;
  STRING Balance;
  STRING ChargeOfFd;
  STRING FormerName;
  STRING Email;
  STRING EmployerName;
  STRING HistoryDate;
  STRING LexId;
END; 


EXPORT Input_Config := RECORD
STRING PFType;// BASIC, ULTIMATE, PREMIUM, PHONERISKASSESSMENT
STRING DRM;
STRING DPM;
STRING GLBPurpose;
STRING DLPurpose;
BOOLEAN VerifyPhoneName;
BOOLEAN VerifyPhoneLastName;
BOOLEAN VerifyPhoneNameAddress;

END;

EXPORT Input_layout := Record
  STRING Account;
  STRING First;
  STRING Middle;
  STRING Last;
  STRING StreetAddress;
  STRING City;
  STRING State;
  STRING Zip;
  STRING HomePhone;
  STRING SSN;
  STRING DateOfBirth;
  STRING WorkPhone;
  STRING Income;
  STRING DLnumber;
  STRING DLstate;
  STRING Balance;
  STRING ChargeOfFd;
  STRING FormerName;
  STRING Email;
  STRING EmployerName;
  STRING HistoryDate;
  STRING LexId;
END; 


END;