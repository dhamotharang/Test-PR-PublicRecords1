EXPORT rNAC2Config := 
record
  string4    GroupID;          // Two letters, two numbers, unique within file
  string1    Delimiter1;       // If not a pipe character, error
  string1    ProductCode;      // n For NAC, p For PPA, anything else is error
  string1    Delimiter2;       // If not a pipe character, error
  string1    IsProd;           // 1 For Prod, 0 For Dev, anything else is error
  string1    Delimiter3;       // If not a pipe character, error
  string1    IsEncrypted;      // y if encrypted, n if not, anything else is error
  string1    Delimiter4;       // If not a pipe character, error
  string1    Onboarding;       // y if onboarding, n if not, anything else is error
  string1    LineFeed;         // If not a linefeed character, error
end;