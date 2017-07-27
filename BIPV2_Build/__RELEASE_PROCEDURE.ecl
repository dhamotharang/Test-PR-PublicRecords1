/*
  BIP release procedure:
    1.  If there was a layout change, then before checking-in make the changes to the BIPV2.CommonBase,BIPV2.KeySuffix_mod2 & BIPV2.CommonBase_mod 
        to make the change available to the outside without sandboxing BIPV2._Config.  Then, change BIPV2._Config.BASE_LAYOUT_DYNAMIC to false, and then execute this 
        attribute in a builder window to make sure all the keys match up with the code:  BIPV2_Build.BWR_Verify_Packages.
    1.  check-in all attributes.  This points the xlink macros to the new files.  Don't check in BIPV2._Config.
    2.  execute BIPV2_Build.Promote2QA(bipv2.keysuffix,true); to promote and update DOPS.  This also executes promote2qa on dataland.
    3.  execute BIPV2_Build._BWR_Verify_Checkin in a builder window on dataland and prod.
    4.  put in changes to the bipv2fullkeys package to DOPS, email roxie package team with list of changes, including removes.
    5.  Send an email to all letting them know that the newest Sprint is available on prod and dataland thors.
    5.  wait for the screaming.

BIP release to QA procedure:


BIP release to Thor only procedure:

BIP release to QA after thor only release procedure:




*/