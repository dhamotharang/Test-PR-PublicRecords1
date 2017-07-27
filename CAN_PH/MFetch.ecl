IMPORT autokey;

EXPORT MFetch := MODULE (autokey.IFetch)
  export Fetch_Zip (string t, boolean workHard, boolean noFail = true) := CAN_PH.Fetch_Zip (t, workHard, noFail);
  export Fetch_ZipPRLname (string t, boolean workHard, boolean noFail = true) := CAN_PH.Fetch_ZipPRLname (t, workHard, noFail);
  export Fetch_Address (string t, boolean workHard, boolean noFail = true) := CAN_PH.Fetch_Address (t, workHard, noFail);
END;