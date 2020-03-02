/***************************************************************************
 *
 * NOTE: All code below is for testing purposes only. 
 *
 ***************************************************************************/
import iesp;

export GetRiskIndicators() := function

  iesp.phonefinder.t_PhoneFinderRiskIndicator gt1() := transform
    self.Category := 'Phone Association';
    self.level := 'H';
    self.LevelCount := 1;
    // self.Threshold := 3;
    self.RiskId := 1;
    self.RiskDescription := 'Phone is not active with this person';
    self.Active := true;
    self := [];
  end;

  iesp.phonefinder.t_PhoneFinderRiskIndicator gt2() := transform
    self.Category := 'Phone Activity';
    self.level := 'H';
    self.LevelCount := 1;
    self.RiskId := 2;
    self.Threshold := 0;
    self.ThresholdA := 30;
    self.RiskDescription := 'First Seen Date is within Input A and Input B days (1st date range)';
    self.Active := true;
    self := [];
  end;
  
   iesp.phonefinder.t_PhoneFinderRiskIndicator gt3() := transform
    self.Category := 'Phone Activity';
    self.level := 'M';
    self.LevelCount := 1;
    self.RiskId := 3;
    self.Threshold := 365;
    self.RiskDescription := 'Last seen date is older than Input B days';
    self.Active := true;
    self := [];
  end;

  iesp.phonefinder.t_PhoneFinderRiskIndicator gt4() := transform
    self.Category := 'Phone Activity';
    self.level := 'L';
    self.LevelCount := 1;
    // self.Threshold := 3;
    self.RiskId := 5;
    self.RiskDescription := 'Primary Phone is listed as a Business';
    self.Active := true;
    self.OTP := true;
    self := [];
  end;
  
  iesp.phonefinder.t_PhoneFinderRiskIndicator gt5() := transform
    self.Category := 'Phone Activity';
    self.level := 'H';
    self.LevelCount := 1;
    self.RiskId := 6;
    self.ThresholdA := 7;
    self.RiskDescription := 'Phone # has been ported within the past Input B days';
    self.Active := true;
    self := [];
  end;
  
  iesp.phonefinder.t_PhoneFinderRiskIndicator gt6() := transform
    self.Category := 'Phone Activity';
    self.level := 'M';
    self.LevelCount := 1;
    self.RiskId := 7;
    self.ThresholdA := 5;
    self.RiskDescription := 'Phone # has been ported more than Input B times with this person';
    self.Active := true;
    self := [];
  end;

  iesp.phonefinder.t_PhoneFinderRiskIndicator gt7() := transform
    self.Category := 'Phone Activity';
    self.level := 'L';
    self.LevelCount := 1;
    self.ThresholdA := 30;
    self.RiskId := 8;
    self.RiskDescription := 'Phone # was the origination phone used to spoof another phone # within the past Input B days';
    self.Active := true;
    self := [];
  end;
  
  iesp.phonefinder.t_PhoneFinderRiskIndicator gt8() := transform
    self.Category := 'Phone Activity';
    self.level := 'L';
    self.LevelCount := 1;
    self.RiskId := 9;
    self.ThresholdA := 60;
    self.RiskDescription := 'Phone # has been spoofed within the past Input B days';
    self.Active := true;
    self := [];
  end;
  
  iesp.phonefinder.t_PhoneFinderRiskIndicator gt9() := transform
    self.Category := 'Phone Activity';
    self.level := 'H';
    self.LevelCount := 1;
    self.RiskId := 15;
    self.Threshold := 2;
    self.ThresholdA := 7;
    self.RiskDescription := 'Phone # has received Input A OTP requests within the past Input B days';
    self.Active := true;
    self := [];
  end;

  iesp.phonefinder.t_PhoneFinderRiskIndicator gt10() := transform
    self.Category := 'Phone Activity';
    self.level := 'M';
    self.LevelCount := 1;
    self.RiskId := 16;
    self.RiskDescription := 'Phone # is a Prepaid Phone';
    self.Active := true;
    self := [];
  end;
  
  iesp.phonefinder.t_PhoneFinderRiskIndicator gt11() := transform
    self.Category := 'Phone Activity';
    self.level := 'M';
    self.LevelCount := 1;
    self.RiskId := 17;
    // self.Threshold := 3;
    self.RiskDescription := 'Phone # is associated to a No Contract Carrier';
    self.Active := true;
    self.OTP := true;
    self := [];
  end;
  
   iesp.phonefinder.t_PhoneFinderRiskIndicator gt12() := transform
    self.Category := 'Phone Activity';
    self.level := 'M';
    self.LevelCount := 1;
    self.RiskId := 18;
    self.RiskDescription := 'Phone Service Type is Landline';
    self.Active := true;
    self := [];
  end;

  iesp.phonefinder.t_PhoneFinderRiskIndicator gt13() := transform
    self.Category := 'Phone Activity';
    self.level := 'L';
    self.LevelCount := 1;
    // self.Threshold := 3;
    self.RiskId := 19;
    self.RiskDescription := 'Phone Service Type is Wireless';
    self.Active := true;
    // self.OTP := true;
    self := [];
  end;
  
  iesp.phonefinder.t_PhoneFinderRiskIndicator gt14() := transform
    self.Category := 'Phone Activity';
    self.level := 'H';
    self.LevelCount := 1;
    self.RiskId := 20;
    // self.Threshold := 3;
    self.RiskDescription := 'Phone Service Type is VOIP';
    self.Active := true;
    // self.OTP := true;
    self := [];
  end;
  
  iesp.phonefinder.t_PhoneFinderRiskIndicator gt15() := transform
    self.Category := 'Phone Activity';
    self.level := 'M';
    self.LevelCount := 1;
    self.RiskId := 22;
    self.Threshold := 31;
    self.ThresholdA := 60;
    self.RiskDescription := 'First Seen Date is within Input A and Input B days (2nd date range)';
    self.Active := true;
    self := [];
  end;

  iesp.phonefinder.t_PhoneFinderRiskIndicator gt16() := transform
    self.Category := 'Phone Activity';
    self.level := 'L';
    self.LevelCount := 1;
    self.RiskId := 23;
    self.Threshold := 61;
    self.ThresholdA := 90;
    self.RiskDescription := 'First Seen Date is within Input A and Input B days (2nd date range)';
    self.Active := true;
    self := [];
  end;
  
  iesp.phonefinder.t_PhoneFinderRiskIndicator gt17() := transform
    self.Category := 'Phone Activity';
    self.level := 'L';
    self.LevelCount := 1;
    self.RiskId := 24;
    // self.Threshold := 3;
    self.RiskDescription := 'Primary address is zoned as Business';
    self.Active := true;
    // self.OTP := true;
    self := [];
  end;
  
  iesp.phonefinder.t_PhoneFinderRiskIndicator gt18() := transform
    self.Category := 'Phone Activity';
    self.level := 'L';
    self.LevelCount := 1;
    self.RiskId := 25;
    self.RiskDescription := 'Primary address is not the Current address for the Primary Subject';
    self.Active := true;
    self := [];
  end;

  iesp.phonefinder.t_PhoneFinderRiskIndicator gt19() := transform
    self.Category := 'Phone Activity';
    self.level := 'H';
    self.LevelCount := 1;
    self.ThresholdA := 30;
    self.RiskId := 26;
    self.RiskDescription := 'Phone # was the destination phone used in a spoofing activity within the past Input B days';
    self.Active := true;
    // self.OTP := true;
    self := [];
  end;
  
  iesp.phonefinder.t_PhoneFinderRiskIndicator gt20() := transform
    self.Category := 'Phone Activity';
    self.level := 'H';
    self.LevelCount := 1;
    self.RiskId := 27;
    self.ThresholdA := 7;
    self.RiskDescription := 'Phone # was the spoofed phone used in a spoofing activity within the past Input B days';
    self.Active := true;
    // self.OTP := true;
    self := [];
  end;
  
  iesp.phonefinder.t_PhoneFinderRiskIndicator gt21() := transform
    self.Category := 'Phone Activity';
    self.level := 'H';
    self.LevelCount := 1;
    self.RiskId := 28;
    self.RiskDescription := 'Primary Subject associated to the phone is deceased';
    self.Active := true;
    self := [];
  end;
  
    iesp.phonefinder.t_PhoneFinderRiskIndicator gt22() := transform
    self.Category := 'Phone Activity';
    self.level := 'L';
    self.LevelCount := 1;
    // self.Threshold := 3;
    self.RiskId := 29;
    self.RiskDescription := '';
    self.Active := true;
    // self.OTP := true;
    self := [];
  end;
  
  iesp.phonefinder.t_PhoneFinderRiskIndicator gt23() := transform
    self.Category := 'Phone Activity';
    self.level := 'M';
    self.LevelCount := 1;
    self.RiskId := 30;
    self.Threshold := 2;
    self.ThresholdA := 7;
    self.RiskDescription := 'Phone # has had Input A search requests within the past Input B days';
    self.Active := true;
    // self.OTP := true;
    self := [];
  end;
  
  iesp.phonefinder.t_PhoneFinderRiskIndicator gt24() := transform
    self.Category := 'Phone Activity';
    self.level := 'H';
    self.LevelCount := 1;
    self.RiskId := 31;
    self.RiskDescription := 'Phone # is currently being forwarded';
    self.Active := true;
    self := [];
  end;

  iesp.phonefinder.t_PhoneFinderRiskIndicator gt25() := transform
    self.Category := 'Phone Activity';
    self.level := 'M';
    self.LevelCount := 1;
    // self.Threshold := 3;
    self.RiskId := 32;
    self.RiskDescription := 'No First Seen Date associated to Phone #';
    self.Active := true;
    // self.OTP := true;
    self := [];
  end;
  
  iesp.phonefinder.t_PhoneFinderRiskIndicator gt26() := transform
    self.Category := 'Phone Activity';
    self.level := 'L';
    self.LevelCount := 1;
    self.RiskId := 33;
    // self.Threshold := 3;
    self.RiskDescription := 'No Last Seen Date associated to Phone #';
    self.Active := true;
    // self.OTP := true;
    self := [];
  end;
  
  iesp.phonefinder.t_PhoneFinderRiskIndicator gt27() := transform
    self.Category := 'Phone Activity';
    self.level := 'H';
    self.LevelCount := 1;
    self.RiskId := 34;
    self.RiskDescription := 'No First Seen and Last Seen Date associated to Phone #';
    self.Active := true;
    self := [];
  end;

  iesp.phonefinder.t_PhoneFinderRiskIndicator gt28() := transform
    self.Category := 'Phone Activity';
    self.level := 'H';
    self.LevelCount := 1;
    self.ThresholdA := 5;
    self.RiskId := 35;
    self.RiskDescription := 'SIM Card Information has changed in the last Input B days';
    self.Active := true;
    // self.OTP := true;
    self := [];
  end;
  
  iesp.phonefinder.t_PhoneFinderRiskIndicator gt29() := transform
    self.Category := 'Phone Activity';
    self.level := 'H';
    self.LevelCount := 1;
    self.RiskId := 36;
    self.ThresholdA := 5;
    self.RiskDescription := 'Device Information has changed in the last # days';
    self.Active := true;
    // self.OTP := true;
    self := [];
  end;
  
  iesp.phonefinder.t_PhoneFinderRiskIndicator gt30() := transform
    self.Category := 'Phone Activity';
    self.level := 'M';
    self.LevelCount := 1;
    self.RiskId := 37;
    self.RiskDescription := 'Phone Number part of a recently rejected transation in the Digital Identity Network';
    self.Active := true;
    self := [];
  end;

  iesp.phonefinder.t_PhoneFinderRiskIndicator gt31() := transform
    self.Category := 'Phone Activity';
    self.level := 'M';
    self.LevelCount := 1;
    self.Threshold := 3;
    self.RiskId := 38;
    self.RiskDescription := 'Phone Number present on Digital Identity Blacklist';
    self.Active := true;
    // self.OTP := true;
    self := [];
  end;
  
  iesp.phonefinder.t_PhoneFinderRiskIndicator gt32() := transform
    self.Category := 'Phone Activity';
    self.level := 'H';
    self.LevelCount := 1;
    self.RiskId := 39;
    // self.Threshold := 3;
    self.RiskDescription := 'Phone Number associated with Fraud in the Digital Identity Network';
    self.Active := true;
    // self.OTP := true;
    self := [];
  end;
  
  iesp.phonefinder.t_PhoneFinderRiskIndicator gt33() := transform
    self.Category := 'Phone Activity';
    self.level := 'L';
    self.LevelCount := 1;
    self.RiskId := 40;
    self.RiskDescription := 'The Digital Identity associated with the phone number has a bad reputation';
    self.Active := true;
    self := [];
  end;

  iesp.phonefinder.t_PhoneFinderRiskIndicator gt34() := transform
    self.Category := 'Phone Activity';
    self.level := 'L';
    self.LevelCount := 1;
    // self.Threshold := 3;
    self.RiskId := 41;
    self.RiskDescription := 'Phone Number First Seen Recently in the Digital Identity Network';
    self.Active := true;
    // self.OTP := true;
    self := [];
  end;
  
  iesp.phonefinder.t_PhoneFinderRiskIndicator gt35() := transform
    self.Category := 'Phone Activity';
    self.level := 'H';
    self.LevelCount := 1;
    self.RiskId := 42;
    self.ThresholdA := 3;
    self.RiskDescription := 'High Count of Devices Associated to Phone Number in Past Month';
    self.Active := true;
    // self.OTP := true;
    self := [];
  end;
  
  iesp.phonefinder.t_PhoneFinderRiskIndicator gt36() := transform
    self.Category := 'Phone Activity';
    self.level := 'H';
    self.LevelCount := 1;
    self.RiskId := 43;
    self.ThresholdA := 3;
    self.RiskDescription := 'High Count of Emails Associated to Phone Number in Past Month';
    self.Active := true;
    // self.OTP := true;
    self := [];
  end;

  iesp.phonefinder.t_PhoneFinderRiskIndicator gt37() := transform
    self.Category := 'Phone Activity';
    self.level := 'H';
    self.LevelCount := 1;
    self.RiskId := 45;
    self.ThresholdA := 8;
    self.RiskDescription := 'Phone Number is associated to more than "Input B" Identities';
    self.Active := true;
    // self.OTP := true;
    self := [];
  end;
  
  iesp.phonefinder.t_PhoneFinderRiskIndicator gt38() := transform
    self.Category := 'Phone Activity';
    self.level := 'L';
    self.LevelCount := 1;
    self.RiskId := 46;
    // self.Threshold := 3;
    self.RiskDescription := 'Surname of Phones Listing Name does not match Identity Found';
    self.Active := true;
    // self.OTP := true;
    self := [];
  end;
  
  iesp.phonefinder.t_PhoneFinderRiskIndicator gt39() := transform
    self.Category := 'Phone Activity';
    self.level := 'M';
    self.LevelCount := 1;
    self.RiskId := 47;
    self.Threshold := 2;
    self.ThresholdA := 7;
    self.RiskDescription := 'Phone Number Returned in more than "Input A" transactions in past "Input B" days';
    self.Active := true;
    self := [];
  end;

  RiskRule1:= dataset([gt1()]);
  RiskRule2:= dataset([gt2()]);
  RiskRule3:= dataset([gt3()]);
  RiskRule4:= dataset([gt4()]);
  RiskRule5:= dataset([gt5()]);
  RiskRule6:= dataset([gt6()]);
  RiskRule7:= dataset([gt7()]);
  RiskRule8:= dataset([gt8()]);
  RiskRule9:= dataset([gt9()]);
  RiskRule10:= dataset([gt10()]);
  RiskRule11:= dataset([gt11()]);
  RiskRule12:= dataset([gt12()]);
  RiskRule13:= dataset([gt13()]);
  RiskRule14:= dataset([gt14()]);
  RiskRule15:= dataset([gt15()]);
  RiskRule16:= dataset([gt16()]);
  RiskRule17:= dataset([gt17()]);
  RiskRule18:= dataset([gt18()]);
  RiskRule19:= dataset([gt19()]);
  RiskRule20:= dataset([gt20()]);
  RiskRule21:= dataset([gt21()]);
  RiskRule22:= dataset([gt22()]);
  RiskRule23:= dataset([gt23()]);
  RiskRule24:= dataset([gt24()]);
  RiskRule25:= dataset([gt25()]);
  RiskRule26:= dataset([gt26()]);
  RiskRule27:= dataset([gt27()]);
  RiskRule28:= dataset([gt28()]);
  RiskRule29:= dataset([gt29()]);
  RiskRule30:= dataset([gt30()]);
  RiskRule31:= dataset([gt31()]);
  RiskRule32:= dataset([gt32()]);
  RiskRule33:= dataset([gt33()]);
  RiskRule34:= dataset([gt34()]);
  RiskRule35:= dataset([gt35()]);
  RiskRule36:= dataset([gt36()]);
  RiskRule37:= dataset([gt37()]);
  RiskRule38:= dataset([gt38()]);
  RiskRule39:= dataset([gt39()]);
  
  RiskRules:= RiskRule1 + RiskRule2 + RiskRule3+
              RiskRule4 + RiskRule5 + RiskRule6+
              RiskRule7 + RiskRule8 + RiskRule9+
              RiskRule10 + RiskRule11 + RiskRule12+
              RiskRule13 + RiskRule14 + RiskRule15;
              // RiskRule16 + RiskRule17 + RiskRule18+
              // RiskRule19 + RiskRule20 + RiskRule21+
              // RiskRule22 + RiskRule23 + RiskRule24+
              // RiskRule25 + RiskRule26 + RiskRule27+
              // RiskRule28 + RiskRule29 + RiskRule30+
              // RiskRule31 + RiskRule32 + RiskRule33+
              // RiskRule34 + RiskRule35 + RiskRule36+
              // RiskRule37 + RiskRule38 + RiskRule39;
  return RiskRules;
end;
