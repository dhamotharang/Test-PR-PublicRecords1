// Proc_build_foreclosure_keys
// Moved over from PRTE2 module to create specialized PRTE2_Foreclosure module.  
// Renamed from Proc_build_foreclosure_bid to Proc_Build_Foreclosure_keys since this isn't all bid
// Jun 2014 - moved from a FUNCTION over to a MODULE so we can offer EXPORTED definitions of the indexes

IMPORT AutoKeyB2, ut, RoxieKeyBuild, Data_Services, Doxie;

EXPORT Proc_build_foreclosure_keys (string filedate):= MODULE

		//*** THREE BID KEYS REFERENCED FIRST ****************************************************			
		
/* *************** CODE LEFT OVER FROM LINDA THAT WAS NOT BEING USED DURING A BUILD ***************************
			SHARED dfx := new_proc_build_autokeys_bid(filedate).df3;
   		EXPORT Key_Foreclosures_BIDx := index(dfx,{bdid},{string70 fid := foreclosure_id},'~prte::key::foreclosure_bid_' + doxie.Version_SuperKey);		
   
   //TODO 7/2/2014 - I DON'T SEE ABOVE KEY SHOWING UP ANYWHERE
   // searching prte*key*foreclosure*bid shows 3 versioned (nonSF) keys back in 2012 by lcain - none created since.
END: *********** CODE LEFT OVER FROM LINDA THAT WAS NOT BEING USED DURING A BUILD ***************************
*/

		// -------------------------------------------------------
		SHARED dfx_bdid := NEW_proc_build_autokeys_bid(filedate).df3_bdid;
		EXPORT Key_Foreclosures_BDIDx := index (dfx_bdid,{bdid},{string70 fid := foreclosure_id},'~prte::key::foreclosure_bdid_' + doxie.Version_SuperKey);		

		// ------------------------------------------------------
		SHARED dfx_did := NEW_Proc_Build_Autokeys_bid(filedate).df3_did;
		// dfx_did_filtered := dfx_did(foreclosure_id<>'');
		EXPORT Key_Foreclosure_DIDx := index(dfx_did,{did},{string70 fid := foreclosure_id},'~prte::key::foreclosures_did_' + doxie.Version_SuperKey);

		// -----------------------------------------------------------------

		//*** ONE KEY REFERENCED FOR FID *********************************************************			
		SHARED dfx_fid := NEW_proc_build_autokeys(filedate).foreclosure_ak_dataset2;
		EXPORT Key_Foreclosure_FIDx := index(dfx_fid,{fid},{dfx_fid},'~prte::key::foreclosures_fid_' + doxie.Version_SuperKey);

		//****************************************************************************************			

		RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Key_Foreclosures_BDIDx,'~prte::key::foreclosure_bdid','~prte::key::foreclosure::'+filedate+'::bdid',do5);
		RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Key_Foreclosure_DIDx,'~prte::key::foreclosures_did','~prte::key::foreclosure::'+filedate+'::did',do7);
		RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Key_Foreclosure_FIDx,'~prte::key::foreclosures_fid','~prte::key::foreclosure::'+filedate+'::fid',do8);
// 7/2/2014 - ??? what about the 4th index???   '~prte::key::foreclosure_bid'

		// Move keys to built superfile
		RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~prte::key::foreclosure_bdid','~prte::key::foreclosure::'+filedate+'::bdid',do25);
		RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~prte::key::foreclosure_did','~prte::key::foreclosure::'+filedate+'::did',do27);
		RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~prte::key::foreclosure_fid','~prte::key::foreclosure::'+filedate+'::fid',do28);
// 7/2/2014 - ??? what about the 4th index???   '~prte::key::foreclosure_bid'


		// Move keys to QA superfile
		ut.mac_sk_move_v2('~prte::key::foreclosure_bdid','Q',do35,2);
		ut.mac_sk_move_v2('~prte::key::foreclosure_did','Q',do37,2);
		ut.mac_sk_move_v2('~prte::key::foreclosure_fid','Q',do38,2);
// 7/2/2014 - ??? what about the 4th index???   '~prte::key::foreclosure_bid'


		// autokeys

		EXPORT buildkeys := sequential(
								parallel(do5,do7,do8),
								do25,
								do27,
								do28,
								parallel(do35,do37,do38)
							);
							
end;