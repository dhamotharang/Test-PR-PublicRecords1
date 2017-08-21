/*
  BIP release procedure:
    1.  If there was a layout change, then before checking-in make the changes to the BIPV2.CommonBase,BIPV2.KeySuffix_mod2 & BIPV2.CommonBase_mod 
        to make the change available to the outside without sandboxing BIPV2._Config.  Then, change BIPV2._Config.BASE_LAYOUT_DYNAMIC to false, and then execute this 
        attribute in a builder window to make sure all the keys match up with the code:  BIPV2_Build.BWR_Verify_Packages.
    2.  check-in all attributes.  This points the xlink macros to the new files.  Don't check in BIPV2._Config.
    3.  after the reverse check in to dataland, execute BIPV2_Build.proc_Promote2QA(bipv2.keysuffix,true); to promote and update DOPS.  This also executes promote2qa on dataland.
    4.  execute BIPV2_Build._BWR_Verify_Checkin in a builder window on dataland and prod.
    5.  put in changes to the bipv2fullkeys package to DOPS, email roxie package team with list of changes, including removes.
    6.  Send an email to all letting them know that the newest Sprint is available on prod and dataland thors.
    7.  wait for the screaming.

BIP Layout Change procedure(before you check-in):
  1. change BIPV2._Config.BASE_LAYOUT_DYNAMIC to false.
  2. add another layout for this sprint, to the end of BIPV2.CommonBase_mod, like, Layout_S40.  it should contain the new layout(without any imports, etc)
  3. Then set the BIPV2.CommonBase_mod.layout_static to that new layout.  Example: 	EXPORT Layout_Static := Layout_S40;
  4. This should set you up for check-in.



BIP release to QA procedure:


BIP release to Thor only procedure:

BIP release to QA after thor only release procedure:

if you have to rename the keys:

  make sure that after you rename the keys, you copy or rename the rest of the keys on the other thors to keep them in sync
  safest way might be to copy the renamed keys over to the other thors again(even the ones not rebuilt), promote them to the supers, then check-in the new version.
  because if you just rename them all before checking in the version, that can cause failures because builds will be looking for the old version
  if you check-in, then rename the same can happen in reverse.


*/Bug: 182234 - LINKING: BIP Sprint 29 Build