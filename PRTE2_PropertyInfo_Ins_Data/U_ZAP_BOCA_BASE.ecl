/*  NOTE: This was done because the Boca Base file was not Boca data - it was early Alpharetta data
that Linda Cain created which someone then moved into a CSV in EData12 which Linda could not get to
So Linda created a small 300 test case additional file to add to that CSV which TOTALLY confused me
I thought it was a Boca Base.   ***SO*** we are duplicating much of that data twice.
We will zero out the Boca data file and leave it there for Boca to begin using if they want to add data into this PRTE query.
PRTE2_PropertyInfo.U_ZAP_BOCA_BASE
*/

//************************ RUN IN PRODUCTION, WE'RE NOT KEEPING BOCA FILES IN DEV ***********************

IMPORT PRTE2_PropertyInfo;
IMPORT ut, RoxieKeyBuild;
IMPORT PRTE2_Common as Common;
STRING fileVersion := ut.GetDate+'';

BOCA_SAVE_LAST_COPY_NAME	:= PRTE2_PropertyInfo.Files.BOCA_SAVE_LAST_COPY_NAME;

oldFile := PRTE2_PropertyInfo.Files.BOCA_BASE_SF_DS;
OUTPUT(oldFile,,BOCA_SAVE_LAST_COPY_NAME,overwrite);

NewFile := CHOOSEN(oldFile,0);

RoxieKeyBuild.Mac_SF_BuildProcess_V2(NewFile,
																		 PRTE2_PropertyInfo.Files.BASE_PREFIX_NAME, 
																		 PRTE2_PropertyInfo.Files.BOCA_BASE_PERM_SUFFIX,
																		 fileVersion, buildPIIBase, 3,
																		 false,true);
																			 
SEQUENTIAL (buildPIIBase);

