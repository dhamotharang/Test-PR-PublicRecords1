import InsuranceHeader_PreProcess, idl_header, header;

export Process := module

	/*-------------------- performLinkingPreProcess ----------------------------------------*/
	EXPORT performLinkingPreProcess(dataset(idl_header.Layout_Header_Link) headerRecs)  := FUNCTION

		// IngestOutpt
		hdrWithBocaAndInsRecs			:= Files.AsHeaderAll_Current_DS;

		// Assing gender
		hdrWithUpdatedGender 			:= InsuranceHeader_PreProcess.UpdateGender(hdrWithBocaAndInsRecs);

		// Patch DIDs 
		patchDIDs									:= InsuranceHeader_PreProcess.fn_updateDID(hdrWithUpdatedGender);

    output(count(headerRecs),   					named('Total_Header_Records'));	
		//output(count(hdrWithBocaRecs),  			named('Total_Header_Plus_Boca_Records')); 
		output(count(hdrWithBocaAndInsRecs), 	named('Total_Header_Plus_Boca_AND_Ins_Records'));
		output(count(hdrWithUpdatedGender), 	named('Total_Header_With_Updated_Gender'));
		output(count(patchDIDs), 							named('Total_Header_With_PatchDIDs'));
		
		return patchDIDs;
	END;

end; 