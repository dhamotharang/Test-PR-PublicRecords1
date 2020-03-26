IMPORT  doxie,mdr, PRTE2_PAW, paw,BIPV2, ut;

EXPORT keys := MODULE

	EXPORT key_paw_bdid := INDEX(
		FILES.file_bdid(Bdid>0), 
		{bdid}, 
		{contact_id}, 
		Constants.KeyName_paw + doxie.Version_SuperKey + '::bdid');
	
   	EXPORT key_paw_companyname_domain := INDEX(
   		FILES.file_companyname_domain(domain !=''), 
   		{domain}, 
   		{FILES.file_companyname_domain}, 
   		Constants.KeyName_paw + doxie.Version_SuperKey + '::companyname_domain');
	
	EXPORT key_paw_contactid := INDEX(
   		FILES.file_contactid(contact_id > 0), 
   		{contact_id}, 
   		{FILES.file_contactid}, 
   		Constants.KeyName_paw + doxie.Version_SuperKey + '::contactid');
   	
		EXPORT key_did := INDEX(
   		FILES.file_did(did>0), 
   		{did}, 
   		{contact_id}, 
   		Constants.KeyName_paw + doxie.Version_SuperKey + '::did');
	
	/////////LinkIDs////////////
	EXPORT Key_LinkIds := MODULE
		shared DedupBase := dedup(sort(PAW.File_keybuild_BIPv2(Files.file_Employment_Out_BIPv2),record, local),record,local);
		BIPV2.IDmacros.mac_IndexWithXLinkIDs(DedupBase, k, Constants.KeyName_paw + doxie.Version_SuperKey + '::linkids')
		export Key := k;
		//DEFINE THE INDEX ACCESS
		export kFetch2(
			dataset(BIPV2.IDlayouts.l_xlink_ids2) inputs, 
			string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
														//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
														//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
			unsigned2 ScoreThreshold = 0,						//Applied at lowest leve of ID
			joinLimit = 25000,
			unsigned1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin
			) := FUNCTION
				BIPV2.IDmacros.mac_IndexFetch2(inputs, Key, out, Level, joinLimit, JoinType);
				return out;																					
		END;
	END;
	
	
    	EXPORT key_did_fcra := function
			
			//DF-11712: FCRA Consumer Data Field Depreciation	
			ut.MAC_CLEAR_FIELDS(FILES.file_Employment_Out(did>0 and source in Constants.PAW_FCRA_sources), 
													Employment_Out_cleared, constants.fields_to_clear);
			return INDEX(Employment_Out_cleared, {did}, {Employment_Out_cleared}, 
										Constants.KeyName_paw + doxie.Version_SuperKey + '::did_fcra');

			end;
END;
