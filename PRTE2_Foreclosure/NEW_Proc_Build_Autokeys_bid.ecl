// NEW_Proc_Build_Autokeys_bid 
// Moved over from PRTE2 module to create specialized PRTE2_Foreclosure module.

IMPORT AutoKeyB2, ut, roxiekeybuild, Data_Services, Doxie, PRTE2_Common;


EXPORT NEW_Proc_Build_Autokeys_bid(string filedate) := MODULE

/* *************** CODE LEFT OVER FROM LINDA THAT WAS NOT BEING USED DURING A BUILD ***************************
 			inkeyQA := files.keyBuildInkey+'QA::bid::';
   			inkeyBuilt := files.keyBuildInkey+'BUILT::bid::';
   			inkeyFather := files.keyBuildInkey+'FATHER::bid::';
   			inkeyGrandF := files.keyBuildInkey+'GRANDFATHER::bid::';
   			SHARED performAllClearOrCreate(STRING name) := FUNCTION
   					NOTHOR(PRTE2_Common.SuperFiles.ClearOrCreate(inkeyQA + name));
   					NOTHOR(PRTE2_Common.SuperFiles.ClearOrCreate(inkeyBuilt + name));
   					NOTHOR(PRTE2_Common.SuperFiles.ClearOrCreate(inkeyFather + name));
   					NOTHOR(PRTE2_Common.SuperFiles.ClearOrCreate(inkeyGrandF + name));
   					return true;
   			END;
   			
   			performAllClearOrCreate('Payload');
   			performAllClearOrCreate('AddressB2');
   			performAllClearOrCreate('CityStNameB2');
   			performAllClearOrCreate('NameB2');
   			performAllClearOrCreate('StNameB2');
   			performAllClearOrCreate('ZipB2');
   			performAllClearOrCreate('NameWords2');
   			performAllClearOrCreate('Address');
   			performAllClearOrCreate('CityStName');
   			performAllClearOrCreate('Name');
   			performAllClearOrCreate('StName');
   			performAllClearOrCreate('Zip');
   			performAllClearOrCreate('NameWords2');
   			performAllClearOrCreate('SSN2');
END: *********** CODE LEFT OVER FROM LINDA THAT WAS NOT BEING USED DURING A BUILD ***************************
*/

			//************************************


			EXPORT file_out2 := Join_files(filedate).All_Foreclosures_Expanded;	


			EXPORT File_Foreclosure_Autokey_bid_CT :=
											project(file_out2,
											transform(recordof(file_out2) - [bid,bid_score],
												self.bdid := left.bid,
												self.bdid_score := left.bid_score,
												self := left));	

			df_in := File_Foreclosure_Autokey_bid_CT(bdid != 0);


			df2 := project (df_in, {unsigned6 bdid, df_in.foreclosure_id});

//*****************************************************************************************************************************			
			EXPORT df3 := dedup (sort (df2, RECORD), RECORD);
//********** NOTE: 7/2/2014 - df3 ABOVE IS USED in PRTE2_Foreclosure.Proc_build_foreclosure_keys **************************
// however, see notes in Proc_build_foreclosure_keys because this file never gets processed later in that process.
//*****************************************************************************************************************************			

			EXPORT Key_Foreclosures_BID3 := index(df3,{bdid},{string70 fid := foreclosure_id},'~prte::key::foreclosure_bid_' + doxie.Version_SuperKey);		

			//*BDID:	
			EXPORT File_Foreclosure_Autokey_bdid_CT :=
											project(file_out2,
											transform(recordof(file_out2) - [bid,bid_score],
												self.bdid := left.bdid,
												self.bdid_score := left.bdid_score,
												self := left));

			df_in_bdid := File_Foreclosure_Autokey_bdid_CT(bdid != 0);

			df2_bdid := project (df_in_bdid, {unsigned6 bdid, df_in_bdid.foreclosure_id});

//*****************************************************************************************************************************			
			EXPORT df3_bdid := dedup (sort (df2_bdid, RECORD), RECORD);	
//********** NOTE: 7/2/2014 - df3_bdid ABOVE IS USED in PRTE2_Foreclosure.Proc_build_foreclosure_keys **************************
//*****************************************************************************************************************************			

			//*DID:	
			df_in_did := file_out2(did != 0);

			df2_did := project (df_in_did, {unsigned6 did, df_in_did.foreclosure_id});

//*****************************************************************************************************************************			
			EXPORT df3_did := dedup (sort (df2_did, RECORD), RECORD);
//********** NOTE: 7/2/2014 - df3_did ABOVE IS USED in PRTE2_Foreclosure.Proc_build_foreclosure_keys **************************
//*****************************************************************************************************************************			

/* *************** CODE LEFT OVER FROM LINDA THAT WAS NOT BEING USED DURING A BUILD ***************************
				ak_keyname	:= files.ak_keyname+'bid::';
   			ak_logical	:= files.ak_logical(filedate)+'bid::';
   			ak_skipSet	:= ['P','Q','F'];
   			ak_typeStr	:= 'AK';
   			ak_dataset  := File_Foreclosure_Autokey_bid_CT;
   
   			// To build the updated keys
   			layout_autokey := RECORD
   					ak_dataset;
   			END;
   
   			AutoKeyB2.MAC_Build (ak_dataset,name_first,name_middle,name_last,
   							 ssn,
   							 zero,
   							 blank,
   							 site_prim_name,
   							 site_prim_range,
   							 site_st,
   							 site_p_city_name,
   							 site_zip,
   							 site_sec_range,
   							 zero,
   							 zero,zero,zero,
   							 zero,zero,zero,
   							 zero,zero,zero,
   							 zero,
   							 did,
   							 name_Company, // compname which is string thus "blank"
   							 zero,
   							 zero,
   							 site_prim_name,
   							 site_prim_range,
   							 site_st,
   							 site_p_city_name,
   							 site_zip,
   							 site_sec_range,
   							 bdid, // bdid_out
   							 ak_keyname,
   							 ak_logical,
   							 bld_auto_keys,false,
   							 ak_skipSet,true,ak_typeStr,
   							 true,,,zero);
   							 
   			AutoKeyB2.MAC_AcceptSK_to_QA(ak_keyname, move_auto_keys,, ak_skipSet);
   
   			EXPORT retval := SEQUENTIAL(bld_auto_keys, move_auto_keys);
END: *********** CODE LEFT OVER FROM LINDA THAT WAS NOT BEING USED DURING A BUILD ***************************
*/

END;