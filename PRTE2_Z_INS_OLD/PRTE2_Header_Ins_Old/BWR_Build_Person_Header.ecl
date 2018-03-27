//* PRTE.BWR_Build - 
//  To build PersonHeader, Relatives, Watchdog, including adding new foreclosure and LNProperty records
// -----------------------------------------------------------------------------------------------------
IMPORT ut,PRTE, _control, PRTE2_Common,InsuranceHeader_xLink;
#OPTION('multiplePersistInstances',FALSE);
#WORKUNIT ('name', 'CustTest PersonHdr and Watchdog');
//* 
//* note: change newbuild to current date (with alpha if needed)
string NewBuildVersion := ut.GetDate+'';

//* oldbuild and oldbuild2 should match each version in DOPS this should replace
OldBuild1 := '20160426';		// Check DOPS PersonHeaderKeys, FCRA_PersonHeaderKeys & RelativeKeys)
OldBuild2 := '20160426';		// Check DOPS WatchDogKeys

// emailForDOPS	:= _control.MyInfo.EmailAddressNormal;	// For those who can sandbox in Production
// emailForDOPS := 'jennifer.stewart@lexisnexis.com';		// SAMPLE for anyone in Boca to use
emailForDOPS := PRTE2_Common.Email.DOPSInterestEmails;		// Standard for Alpharetta builds.
boolean is_test_run := false;	// IF you are in PROD, true stops the DOPS UpdateVersion from happening.

build_module1 := PRTE.Proc_Build_Header_keys_v2(NewBuildVersion,OldBuild1,is_test_run,emailForDOPS);
build_module2 := PRTE.Proc_Build_Watchdog_Keys_v2(NewBuildVersion,OldBuild2,is_test_run,emailForDOPS);

// post_processing_actions are built into the individual modules ...
post_steps_1 := build_module1.Production_Post_Processing_Actions;
post_steps_2 := build_module2.Production_Post_Processing_Actions;
pkBuild1 := build_module1.Build_Keys;
pkBuild2 := build_module2.Build_Keys;

#stored ('CustomerTestEnv','Y');
XLAB:=InsuranceHeader_xLink.CustTest_Proc_GoExternal(NewBuildVersion);
XLAB_DOPS_UPDATE := PRTE.UpdateVersion( 'PersonLABKeys', NewBuildVersion, emailForDOPS, 'B', 'N', 'N');
XLAB_ProdYN := PRTE2_Common.Constants.Running_in_production;
XLAB_DOPS_ACTION := IF(XLAB_ProdYN,XLAB_DOPS_UPDATE,OUTPUT('No DOPS done in dataland'));

sequential(
 pkBuild1
 ,pkBuild2
 ,post_steps_1
 ,post_steps_2
 ,XLAB
 ,XLAB_DOPS_ACTION
 ) : SUCCESS(	PRTE2_Common.Email.sendSuccess('PersonHdr/Watchdog')	),
		 FAILURE(	PRTE2_Common.Email.sendFail('PersonHdr/Watchdog')	);


