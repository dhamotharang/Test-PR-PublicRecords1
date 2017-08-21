i := creditfile.File_Indic_Plus;
t := creditfile.file_trade_plus;
p := creditfile.File_Pubrec_Plus;

BUILDINDEX(i(soc<>0),creditfile.KeyType_Person_SSN_FName,creditfile.KeyName_Person_SSN_Fname,overwrite);
BUILDINDEX(i,creditfile.KeyType_Person,creditfile.KeyName_Person,overwrite);

BUILDINDEX(t,creditfile.KeyType_Trade_PersonId,creditfile.KeyName_Trade_Person,overwrite);
BUILDINDEX(t,creditfile.KeyType_Trade_Acct,creditfile.KeyName_Trade_Acct,overwrite);

BUILDINDEX(p,creditfile.KeyType_Pubrec_Person,creditfile.KeyName_Pubrec_Person,overwrite);

m := creditfile.File_Members;

r := record
  string10 memnum := m.memno[1..10];//m.memno[8..10]+m.memno[4..5]+m.memno[1..3]+m.memno[6..7];
  m.name;
  end;

ta := table(m,r);

creditfile.keytype_member into(ta le) := transform
  self := le;
  end;

BUILDINDEX(project(ta,into(left)),,'key::credit_member',overwrite)