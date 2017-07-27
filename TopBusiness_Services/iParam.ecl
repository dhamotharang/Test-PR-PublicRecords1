IMPORT BIPV2;

EXPORT iParam :=
MODULE

  // Business Id search params
  EXPORT BIDParams :=
  INTERFACE
    EXPORT UNSIGNED6 DotID                := 0;
		EXPORT UNSIGNED6 EmpID                := 0;
		EXPORT UNSIGNED6 POWID                := 0;
		EXPORT UNSIGNED6 ProxID               := 0;
		EXPORT UNSIGNED6 SELEID               := 0;
		EXPORT UNSIGNED6 OrgID                := 0;
		EXPORT UNSIGNED6 UltID                := 0;
    EXPORT STRING1   BusinessIDFetchLevel := BIPV2.IDconstants.Fetch_Level_SELEID;
  END;

END;