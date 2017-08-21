/*

STEP 1: run FidelityProp.proc.DoProp on dataland 400x
STEP 2: warn vesa and run FidelityProp.proc..DoPropWPhones(PropFileJustBuilt) on the prod 200x
STEP 3: run FidelityProp.proc(PropFileJustBuilt, WithPhoneFileJustBuilt) on dataland 400x
STEP 4: FidelityProp.proc_QA (requires updating file refs in first two lines)
STEP 5: Run FidelityProp.proc_chuncks to split the file into 30 peices (they want files no bigger than a Gig.  also, update file ref.)
STEP 6: Run FidelityProp.proc_despray (check file ref)
STEP 7: TBD - we probably need to let Rob Beckers team know the location and filenames and have them get the destination from Charlene

NOTES: 
-the history of this attribute has a ton (way too much) info about past runs

NOTES ON 20090925 RUN:
STEP 1: 
	http://10.173.88.208:8010/?inner=../WsWorkunits/WUInfo%3FWuid%3DW20090924-180543 - to create two prop files 
		was working around bug 44330 but i think the fix for that is now in mod_build
	http://dataland_esp.br.seisint.com:8010/?inner=/WsWorkunits/WUInfo?Wuid=W20090925-095409 - to put the prop files together

NOTES on 20091021 run:
Added DID and DOB (from four sources) to the output.  Found out after the fact I should have added
DOBs from a fifth source (criminal records).  Ran into a problem in step 5 with twice as many records
going into half as many files, and changed the constant in the BWR code to compensate.  BWR code for
each step is now broken out into a separate attribute.  Next time we should add the DOBs from the
other source -- remember to adjust csvHeading!  It would also be good to get away from the pipeline
of Roxie calls in step 2.

*/
