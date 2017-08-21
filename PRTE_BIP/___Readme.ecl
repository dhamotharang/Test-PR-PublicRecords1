/*
The building of the PRTE keys is something we have to do whenever we change(layout) or add keys to the BIP packages unfortunately.  ïŒ
I want to get you up to speed on how to do this.  It is not hard, just a little tedious, but we have wrapped it up a little to make it easier.

So, first we need to figure out which keys changed layouts.  To do this automatically I created an attribute
BIPV2_Build._BWR_Check_BIPV2FullKeys_Changes

Also, since this runs under your userid you will have any layout changes sandboxed for the current sprint if you are running the build.  So if you use the same version as the build, it will not fail since the code will match the built keys.  So, to compare the new code to the old keys(and find the differences) you will need to pass as the version:
	â€˜qaâ€™	-- if you have not promoted all of the keys to the qa superfiles.  In this case, qa will contain the previous sprints keys.
	â€˜fatherâ€™	-- if you have promoted the keys to the qa superfiles.  In this case, father will contain the previous sprints keys.

Run this on hthor and it will take a few hours unfortunately(I am working on an improvement to the workunit manager that should make this quicker), but once it finishes, the workunits dataset in the workunit result will have all of the errors returned for each key(in the errors field).  Copy those and you will have the list of all the keys that changed.
I ran this last night for sprint 32 and here is the workunit:
http://prod_esp.br.seisint.com:8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=W20151105-005429#/stub/Summary
If you take a look at the errors field in the workunits dataset, I find these keys changed layouts:

eclagent:  (0,0) : 0: System error: 0: Index layout does not match published layout for index thor_data400::key::bipv2_lgid3::20151014::match_candidates_debug
eclagent:  (0,0) : 0: System error: 0: Index layout does not match published layout for index thor_data400::key::bipv2_lgid3::20151014::specificities_debug
eclagent:  (0,0) : 0: System error: 0: Index layout does not match published layout for index thor_data400::key::bipv2_seleid_relative::20151014::seleid::rel::assoc
eclagent:  (0,0) : 0: System error: 0: Index layout does not match published layout for index thor_data400::key::bizlinkfull::20151014::proxid::meow

Then, you have to modify the layout for those keys in prte to match production.

There is one attribute that you will need to modify if a key changes layout:
PRTE_BIP.PRTE_CSV_BIP_BH

So, for example, in sprint 31 the lgid3 match candidates key changed layout.  this is the bip key for it:
thor_data400::key::bipv2_lgid3::20150828::match_candidates_debug

and this is its corresponding prte key(the build date doesnâ€™t have to match between bip prod and prte):
prte::key::bipv2_lgid3::20151019::match_candidates_debug

To modify the layout for that key for prte, just go to the corresponding real key in BIP:
thor_data400::key::bipv2_lgid3::20150828::match_candidates_debug

and grab the layout for that key from ECL watch and paste it as the lgid3 match candidates key layout in the above attribute(PRTE_BIP.PRTE_CSV_BIP_BH).  When you look at the attribute, you will see the pattern of how the layouts are named for each key.  for this lgid3 match candidates key, it is 
rthor_data400__key__bipv2_lgid3__match_candidates_debug.

Then, you do the same for all of the keys that changed layouts.

Then you can build the revised keys by executing this(make sure to change the date to todayâ€™s date) on a thor:
PRTE_BIP._BWR_Build_BIP_Header_Keys

We want to build these keys before the sprint/build goes to production.

Here is the workunit I ran to build the PRTE keys because we changed two keys in Sprint 31:
http://prod_esp:8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=W20151019-163528#/stub/Summary
This builds the keys and also updates the PRTE dops page.

And FYI, Here is the dops monitor page for PRTE:
http://prte.risk.lexisnexis.com/nonfcramonitor.aspx

*/