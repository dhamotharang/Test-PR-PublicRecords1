IMPORT UT, STD, Address, Phones;

EXPORT GetValidFullName(DATASET($.Layouts.PhoneFinder.Final) dIn) := FUNCTION


$.Layouts.PhoneFinder.Final getfullname($.Layouts.PhoneFinder.Final L)  := TRANSFORM


  callerID := TRIM(L.RealTimePhone_Ext.ListingName);
  strlen := LENGTH(callerID);
  state := STD.Str.ToUpperCase(callerID[strlen-1..strlen]);
  city := STD.Str.ToUpperCase(callerID[1..strlen-4]);

  IsValidCity := UT.IsCityName(city);
  IsValidState := state IN ut.Set_State_Abbrev;

  isvalidcitystate := (IsValidCity AND IsValidState);
  
  SELF.Full_name := MAP((L.fname != '' or L.lname != '') => Address.NameFromComponents(L.fname, L.mname, L.lname, L.name_suffix),
                         L.listed_name != ''  => L.listed_name,
                         L.RealTimePhone_Ext.ListingName != '' AND ~isvalidcitystate => L.RealTimePhone_Ext.ListingName,
                        '');
  
  SELF := L;

END;


dOut := PROJECT(dIn, getfullname(LEFT));

RETURN dOut;

END;

