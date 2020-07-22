IMPORT iesp;

EXPORT GetRiskIndicators() := FUNCTION
//Risk Indicator definitions
 iesp.phonefinder.t_PhoneFinderRiskIndicator gt1() := TRANSFORM
    SELF.Category := 'Phone Association';
    SELF.level := 'H';
    SELF.LevelCount := 1; 
    SELF.RiskId := 1;
    SELF.RiskDescription := 'Phone is not active with this person';
    SELF.Active := true;
    SELF := [];
  END;
  
iesp.phonefinder.t_PhoneFinderRiskIndicator gt2() := TRANSFORM
    SELF.Category := 'Phone Association';
    SELF.level := 'H';
    SELF.LevelCount := 1;
    SELF.RiskId := 2;
    SELF.Threshold := 0;
    SELF.ThresholdA := 30;
    SELF.RiskDescription := 'First Seen Date is within “Threshold” and "ThresholdA” days (1st date range)';
    SELF.Active := true;
    SELF := [];
  END;
  
   iesp.phonefinder.t_PhoneFinderRiskIndicator gt3() := TRANSFORM
    SELF.Category := 'Phone Association';
    SELF.level := 'M';
    SELF.LevelCount := 3;
    SELF.RiskId := 3;
    SELF.Threshold := 365;
    SELF.RiskDescription := 'Last seen date is older than “Threshold” days';
    SELF.Active := true;
    SELF := [];
  END;

  iesp.phonefinder.t_PhoneFinderRiskIndicator gt4() := TRANSFORM
    SELF.Category := 'Phone Association';
    SELF.level := 'L';
    SELF.LevelCount := 99;
    SELF.RiskId := 5;
    SELF.RiskDescription := 'Primary Phone is listed as a “Business”';
    SELF.Active := true;
    SELF.OTP := true;
    SELF := [];
  END;
  
iesp.phonefinder.t_PhoneFinderRiskIndicator gt5() := TRANSFORM
    SELF.Category := 'Phone Activity';
    SELF.level := 'H';
    SELF.LevelCount := 1;
    SELF.RiskId := 6;
    SELF.ThresholdA := 7;
    SELF.RiskDescription := 'Phone # has been ported within the past “ThresholdA” days';
    SELF.Active := true;
    SELF := [];
  END;
  
   iesp.phonefinder.t_PhoneFinderRiskIndicator gt6() := TRANSFORM
    SELF.Category := 'Phone Activity';
    SELF.level := 'M';
    SELF.LevelCount := 3;
    SELF.RiskId := 7;
    SELF.ThresholdA := 5;
    SELF.RiskDescription := 'Phone # has been ported more than “ThresholdA” times with this person';
    SELF.Active := true;
    SELF := [];
  END;
    iesp.phonefinder.t_PhoneFinderRiskIndicator gt7() := TRANSFORM
    SELF.Category := 'Phone Activity';
    SELF.level := 'L';
    SELF.LevelCount := 99;
    SELF.ThresholdA := 30;
    SELF.RiskId := 8;
    SELF.RiskDescription := 'Phone # was the origination phone used to spoof another phone # within the past “ThresholdA” days';
    SELF.Active := true;
    SELF := [];
  END;
  
iesp.phonefinder.t_PhoneFinderRiskIndicator gt8() := TRANSFORM
    SELF.Category := 'Phone Activity';
    SELF.level := 'L';
    SELF.LevelCount := 99;
    SELF.RiskId := 9;
    SELF.ThresholdA := 60;
    SELF.RiskDescription := 'Phone # has been spoofed within the past “ThresholdA” days';
    SELF.Active := true;
    SELF := [];
  END;
  
   iesp.phonefinder.t_PhoneFinderRiskIndicator gt9() := TRANSFORM
    SELF.Category := 'Phone Activity';
    SELF.level := 'H';
    SELF.LevelCount := 1;
    SELF.RiskId := 15;
    SELF.Threshold := 2;
    SELF.ThresholdA := 7;
    SELF.RiskDescription := 'Phone # has received “Threshold” OTP requests within the past “ThresholdA” days';
    SELF.Active := true;
    SELF := [];
  END;
    iesp.phonefinder.t_PhoneFinderRiskIndicator gt10() := TRANSFORM
    SELF.Category := 'Phone Criteria';
    SELF.level := 'M';
    SELF.LevelCount := 3;
    SELF.RiskId := 16;
    SELF.RiskDescription := 'Phone # is a Prepaid Phone';
    SELF.Active := true;
    SELF := [];
  END;
  
iesp.phonefinder.t_PhoneFinderRiskIndicator gt11() := TRANSFORM
    SELF.Category := 'Phone Criteria';
    SELF.level := 'M';
    SELF.LevelCount := 3;
    SELF.RiskId := 17;
    SELF.RiskDescription := 'Phone # is associated to a No Contract Carrier';
    SELF.Active := true;
    SELF.OTP := true;
    SELF := [];
  END;
  
   iesp.phonefinder.t_PhoneFinderRiskIndicator gt12() := TRANSFORM
    SELF.Category := 'Phone Criteria';
    SELF.level := 'M';
    SELF.LevelCount := 3;
    SELF.RiskId := 18;
    SELF.RiskDescription := 'Phone Service Type is Landline';
    SELF.Active := true;
    SELF := [];
  END;
    iesp.phonefinder.t_PhoneFinderRiskIndicator gt13() := TRANSFORM
    SELF.Category := 'Phone Criteria';
    SELF.level := 'L';
    SELF.LevelCount := 99;
    SELF.RiskId := 19;
    SELF.RiskDescription := 'Phone Service Type is Wireless';
    SELF.Active := true;
    SELF := [];
  END;
  
iesp.phonefinder.t_PhoneFinderRiskIndicator gt14() := TRANSFORM
    SELF.Category := 'Phone Criteria';
    SELF.level := 'H';
    SELF.LevelCount := 1;
    SELF.RiskId := 20;
    SELF.RiskDescription := 'Phone Service Type is VOIP';
    SELF.Active := true;
    SELF := [];
  END;
  
   iesp.phonefinder.t_PhoneFinderRiskIndicator gt15() := TRANSFORM
    SELF.Category := 'Phone Association';
    SELF.level := 'M';
    SELF.LevelCount := 3;
    SELF.RiskId := 22;
    SELF.Threshold := 31;
    SELF.ThresholdA := 60;
    SELF.RiskDescription := 'First Seen Date is within “Threshold” and “ThresholdA” days (2nd date range)';
    SELF.Active := true;
    SELF := [];
  END;
   iesp.phonefinder.t_PhoneFinderRiskIndicator gt16() := TRANSFORM
    SELF.Category := 'Phone Association';
    SELF.level := 'L';
    SELF.LevelCount := 99;
    SELF.RiskId := 23;
    SELF.Threshold := 61;
    SELF.ThresholdA := 90;
    SELF.RiskDescription := 'First Seen Date is within “Threshold” and “ThresholdA” days (2nd date range)';
    SELF.Active := true;
    SELF := [];
  END;
  
iesp.phonefinder.t_PhoneFinderRiskIndicator gt17() := TRANSFORM
    SELF.Category := 'Phone Association';
    SELF.level := 'L';
    SELF.LevelCount := 99;
    SELF.RiskId := 24;
    SELF.RiskDescription := 'Primary address is zoned as “Business”';
    SELF.Active := true;
    SELF := [];
  END;
  
   iesp.phonefinder.t_PhoneFinderRiskIndicator gt18() := TRANSFORM
    SELF.Category := 'Phone Association';
    SELF.level := 'L';
    SELF.LevelCount := 99;
    SELF.RiskId := 25;
    SELF.RiskDescription := 'Primary address is not the “Current” address for the Primary Subject';
    SELF.Active := true;
    SELF := [];
  END;
    iesp.phonefinder.t_PhoneFinderRiskIndicator gt19() := TRANSFORM
    SELF.Category := 'Phone Activity';
    SELF.level := 'H';
    SELF.LevelCount := 1;
    SELF.ThresholdA := 14;
    SELF.RiskId := 26;
    SELF.RiskDescription := 'Phone # was the destination phone used in a spoofing activity within the past “ThresholdA” days';
    SELF.Active := true;
    // SELF.OTP := true;
    SELF := [];
  END;
  
iesp.phonefinder.t_PhoneFinderRiskIndicator gt20() := TRANSFORM
    SELF.Category := 'Phone Activity';
    SELF.level := 'H';
    SELF.LevelCount := 1;
    SELF.RiskId := 27;
    SELF.ThresholdA := 7;
    SELF.RiskDescription := 'Phone # was the spoofed phone used in a spoofing activity within the past “ThresholdA” days';
    SELF.Active := true;
    SELF := [];
  END;
  
   iesp.phonefinder.t_PhoneFinderRiskIndicator gt21() := TRANSFORM
    SELF.Category := 'Phone Association';
    SELF.level := 'H';
    SELF.LevelCount := 1;
    SELF.RiskId := 28;
    SELF.RiskDescription := 'Primary Subject associated to the phone is deceased';
    SELF.Active := true;
    SELF := [];
  END;
  
    iesp.phonefinder.t_PhoneFinderRiskIndicator gt22() := TRANSFORM
    SELF.Category := 'Phone Activity';
    SELF.level := 'L';
    SELF.LevelCount := 99;
    SELF.RiskId := 29;
   SELF.ThresholdA := 7;
    SELF.RiskDescription := 'SIM Card Information has changed in the last “ThresholdA” days';
    SELF.Active := true;
    SELF := [];
  END;
  
iesp.phonefinder.t_PhoneFinderRiskIndicator gt23() := TRANSFORM
    SELF.Category := 'Phone Activity';
    SELF.level := 'M';
    SELF.LevelCount := 3;
    SELF.RiskId := 30;
    SELF.Threshold := 2;
    SELF.ThresholdA := 7;
    SELF.RiskDescription := 'Phone # has had “Threshold” search requests within the past “ThresholdA” days';
    SELF.Active := true;
    SELF := [];
  END;
  
   iesp.phonefinder.t_PhoneFinderRiskIndicator gt24() := TRANSFORM
    SELF.Category := 'Phone Activity';
    SELF.level := 'H';
    SELF.LevelCount := 1;
    SELF.RiskId := 31;
    SELF.RiskDescription := 'Phone # is currently being forwarded';
    SELF.Active := true;
    SELF := [];
  END;

  iesp.phonefinder.t_PhoneFinderRiskIndicator gt25() := TRANSFORM
    SELF.Category := 'Phone Association';
    SELF.level := 'M';
    SELF.LevelCount := 3;
    SELF.RiskId := 32;
    SELF.RiskDescription := 'No First Seen Date associated to Phone #';
    SELF.Active := true;
    SELF := [];
  END;
  
iesp.phonefinder.t_PhoneFinderRiskIndicator gt26() := TRANSFORM
    SELF.Category := 'Phone Association';
    SELF.level := 'L';
    SELF.LevelCount := 99;
    SELF.RiskId := 33;
    SELF.RiskDescription := 'No Last Seen Date associated to Phone #';
    SELF.Active := true;
    SELF := [];
  END;
  
   iesp.phonefinder.t_PhoneFinderRiskIndicator gt27() := TRANSFORM
    SELF.Category := 'Phone Association';
    SELF.level := 'H';
    SELF.LevelCount := 1;
    SELF.RiskId := 34;
    SELF.RiskDescription := 'No First Seen and Last Seen Date associated to Phone #';
    SELF.Active := true;
    SELF := [];
  END;
    iesp.phonefinder.t_PhoneFinderRiskIndicator gt28() := TRANSFORM
    SELF.Category := 'Phone Activity';
    SELF.level := 'H';
    SELF.LevelCount := 1;
    SELF.ThresholdA := 5;
    SELF.RiskId := 35;
    SELF.RiskDescription := 'SIM Card Information has changed in the last “ThresholdA” days';
    SELF.Active := true;
    SELF := [];
  END;
  
iesp.phonefinder.t_PhoneFinderRiskIndicator gt29() := TRANSFORM
    SELF.Category := 'Phone Activity';
    SELF.level := 'H';
    SELF.LevelCount := 1;
    SELF.RiskId := 36;
    SELF.ThresholdA := 5;
    SELF.RiskDescription := 'Device Information has changed in the last # days';
    SELF.Active := true;
    SELF := [];
  END;
  
   iesp.phonefinder.t_PhoneFinderRiskIndicator gt30() := TRANSFORM
    SELF.Category := 'Phone Activity';
    SELF.level := 'M';
    SELF.LevelCount := 3;
    SELF.RiskId := 37;
    SELF.ThresholdB := '1';
    SELF.RiskDescription := 'Phone Number part of a recently rejected transation in the Digital Identity Network';
    SELF.Active := true;
    SELF := [];
  END;
    iesp.phonefinder.t_PhoneFinderRiskIndicator gt31() := TRANSFORM
    SELF.Category := 'Phone Activity';
    SELF.level := 'M';
    SELF.LevelCount := 3;
    SELF.Threshold := 3;
    SELF.RiskId := 38;
    SELF.RiskDescription := 'Phone Number present on Digital Identity Blacklist';
    SELF.Active := true;
    SELF := [];
  END;
  
iesp.phonefinder.t_PhoneFinderRiskIndicator gt32() := TRANSFORM
    SELF.Category := 'Phone Activity';
    SELF.level := 'H';
    SELF.LevelCount := 1;
    SELF.RiskId := 39;
    SELF.ThresholdB := '1';
    SELF.RiskDescription := 'Phone Number associated with Fraud in the Digital Identity Network';
    SELF.Active := true;
    SELF := [];
  END;
  
   iesp.phonefinder.t_PhoneFinderRiskIndicator gt33() := TRANSFORM
    SELF.Category := 'Phone Activity';
    SELF.level := 'L';
    SELF.LevelCount := 99;
    SELF.RiskId := 40;
    SELF.RiskDescription := 'The Digital Identity associated with the phone number has a bad reputation';
    SELF.Active := true;
    SELF := [];
  END;
    iesp.phonefinder.t_PhoneFinderRiskIndicator gt34() := TRANSFORM
    SELF.Category := 'Phone Activity';
    SELF.level := 'L';
    SELF.LevelCount := 99;
    SELF.RiskId := 41;
    SELF.Threshold := 1;
    SELF.RiskDescription := 'Phone Number First Seen Recently in the Digital Identity Network';
    SELF.Active := true;
    SELF := [];
  END;
  
iesp.phonefinder.t_PhoneFinderRiskIndicator gt35() := TRANSFORM
    SELF.Category := 'Phone Activity';
    SELF.level := 'H';
    SELF.LevelCount := 1;
    SELF.RiskId := 42;
    SELF.ThresholdA := 4;
    SELF.RiskDescription := 'High Count of Devices Associated to Phone Number in Past Month';
    SELF.Active := true;
    SELF := [];
  END;
  
iesp.phonefinder.t_PhoneFinderRiskIndicator gt36() := TRANSFORM
    SELF.Category := 'Phone Activity';
    SELF.level := 'H';
    SELF.LevelCount := 1;
    SELF.RiskId := 43;
    SELF.ThresholdA := 3;
    SELF.RiskDescription := 'High Count of Emails Associated to Phone Number in Past Month';
    SELF.Active := true;
    SELF := [];
  END;

iesp.phonefinder.t_PhoneFinderRiskIndicator gt37() := TRANSFORM
    SELF.Category := 'Phone Activity';
    SELF.level := 'H';
    SELF.LevelCount := 1;
    SELF.RiskId := 45;
    SELF.ThresholdA := 8;
    SELF.RiskDescription := 'Phone Number is associated to more than "ThresholdA" Identities';
    SELF.Active := true;
    // SELF.OTP := true;
    SELF := [];
  END;
  
iesp.phonefinder.t_PhoneFinderRiskIndicator gt38() := TRANSFORM
    SELF.Category := 'Phone Association';
    SELF.level := 'L';
    SELF.LevelCount := 99;
    SELF.RiskId := 46;
    SELF.RiskDescription := 'Surname of Phones Listing Name does not match Identity Found';
    SELF.Active := true;
    SELF := [];
  END;
  
   iesp.phonefinder.t_PhoneFinderRiskIndicator gt39() := TRANSFORM
    SELF.Category := 'Phone Activity';
    SELF.level := 'M';
    SELF.LevelCount := 3;
    SELF.RiskId := 47;
    SELF.Threshold := 2;
    SELF.ThresholdA := 7;
    SELF.RiskDescription := 'Phone Number Returned in more than "Threshold" transactions in past "ThresholdA" days';
    SELF.Active := true;
    SELF := [];
     END;

  iesp.phonefinder.t_PhoneFinderRiskIndicator gt40() := TRANSFORM
    SELF.Category := 'Phone Activity';
    SELF.level := 'H';
    SELF.LevelCount := 1;
    SELF.RiskId := 44;
    SELF.Threshold := 3;
    SELF.RiskDescription := 'Phones seen in multiple countries in the past Threshold Months';
    SELF.Active := true;
    SELF := [];
  END;

    iesp.phonefinder.t_PhoneFinderRiskIndicator gt41() := TRANSFORM
    SELF.Category := 'Phone Activity';
    SELF.level := 'H';
    SELF.LevelCount := 1;
    SELF.RiskId := 48;
    SELF.RiskDescription := 'Phone reported by selfreported sources';
    SELF.Active := true;
    SELF := [];
  END;

  RiskRule1:= DATASET([gt1()]);
  RiskRule2:= DATASET([gt2()]);
  RiskRule3:= DATASET([gt3()]);
  RiskRule4:= DATASET([gt4()]);
  RiskRule5:= DATASET([gt5()]);
  RiskRule6:= DATASET([gt6()]);
  RiskRule7:= DATASET([gt7()]);
  RiskRule8:= DATASET([gt8()]);
  RiskRule9:= DATASET([gt9()]);
  RiskRule10:= DATASET([gt10()]);
  RiskRule11:= DATASET([gt11()]);
  RiskRule12:= DATASET([gt12()]);
  RiskRule13:= DATASET([gt13()]);
  RiskRule14:= DATASET([gt14()]);
  RiskRule15:= DATASET([gt15()]);
  RiskRule16:= DATASET([gt16()]);
  RiskRule17:= DATASET([gt17()]);
  RiskRule18:= DATASET([gt18()]);
  RiskRule19:= DATASET([gt19()]);
  RiskRule20:= DATASET([gt20()]);
  RiskRule21:= DATASET([gt21()]);
  RiskRule22:= DATASET([gt22()]);
  RiskRule23:= DATASET([gt23()]);
  RiskRule24:= DATASET([gt24()]);
  RiskRule25:= DATASET([gt25()]);
  RiskRule26:= DATASET([gt26()]);
  RiskRule27:= DATASET([gt27()]);
  RiskRule28:= DATASET([gt28()]);
  RiskRule29:= DATASET([gt29()]);
  RiskRule30:= DATASET([gt30()]);
  RiskRule31:= DATASET([gt31()]);
  RiskRule32:= DATASET([gt32()]);
  RiskRule33:= DATASET([gt33()]);
  RiskRule34:= DATASET([gt34()]);
  RiskRule35:= DATASET([gt35()]);
  RiskRule36:= DATASET([gt36()]);
  RiskRule37:= DATASET([gt37()]);
  RiskRule38:= DATASET([gt38()]);
  RiskRule39:= DATASET([gt39()]);
  RiskRule40:= DATASET([gt40()]);
  RiskRule41:= DATASET([gt41()]);
  
  RiskRules:= RiskRule1 + RiskRule2 + RiskRule3+
              RiskRule4 + RiskRule5 + RiskRule6+
              RiskRule7 + RiskRule8 + RiskRule9+
              RiskRule10 + RiskRule11 + RiskRule12+
              RiskRule13 + RiskRule14 + RiskRule15+
              RiskRule16 + RiskRule17 + RiskRule18+
              RiskRule19 + RiskRule20+ RiskRule21+
              RiskRule22 + RiskRule23 + RiskRule24+
              RiskRule25 + RiskRule26 + RiskRule27+
              RiskRule28 + RiskRule29 + RiskRule30+
              RiskRule31 + RiskRule32 + RiskRule33+
              RiskRule34 + RiskRule35 + RiskRule36+
              RiskRule37 + RiskRule38 + RiskRule39
              + RiskRule40 + RiskRule41;

RETURN RiskRules;

END;