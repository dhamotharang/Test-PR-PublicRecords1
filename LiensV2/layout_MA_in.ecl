export layout_MA_in := module

export ChildSupport := record, maxlength(4096)
  string  FilingNumber;
  string  FirstName;
  string  LastName;
  string  Last4SSN;
  string  Street;
  string  City;
  string  State;
  string  ZipCode;
  string  LienAmount;
  string  FilingDate;
  string  ReleaseDate;
  string  SearchName;
  string  ReleasedBy;
  string  ReleaseCode;
end;

export welflien := record, maxlength(4096)
  string  Name;
  string  FilingNumber;
  string  FilingDate;
  string  ReleaseDate;
  string  SearchName;
end;

export Writ := record, maxlength(4096)
  string  FilingNumber;
  string  FilingLetter;
  string  FilingType;
  string  FilingDate;
  string  FilingDischargeDate;
  string  FilingDateStamp;
  string  FilingIDStamp;
end;

export WritName := record, maxlength(4096)
  string  Name;
  string  SearchName;
  string  FilingNumber;
  string  FilingLetter;
  string  NameType;
end;

export WritType := record, maxlength(4096)
  string  FilingType;
  string  FilingDescription;
end;

end;