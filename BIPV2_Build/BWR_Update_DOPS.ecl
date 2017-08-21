import BIPv2,BIPV2_Build,tools;

pversion          := bipv2.KeySuffix;
pShouldUpdateDOPS := true;

email                 := BIPV2_Build.Send_Emails(pversion ,,not tools._constants.isdataland and pShouldUpdateDOPS);
UpdateFullKeysDops    := email.BIPV2FullKeys.Roxie;
UpdateWeeklyKeysDops  := email.BIPV2WeeklyKeys.Roxie;

sequential(
   UpdateFullKeysDops
  ,UpdateWeeklyKeysDops
);
