
export mac_get_payload_ids(ids,t,datasetPL,outPL
													,typeStr='AK',FakeIDField = 'unsigned6 FakeID'
													,outNewDIDs,outNewBDIDs) := macro


	//****** GRAB THE PAYLOAD KEY A
	AutokeyB2.mac_get_payload(ids,t,datasetPL,outPLfat,0,0, typestr)
		
  //****** IN THE NEW STYLE AUTOKEYS, ALL IDS ARE RECORD IDS, SO ILL GET THE DID AND BDID OFF OF PAYLOAD RECORDS THAT HAVE THEM
	hasdid  := outPLfat(indid >0 and ~AutokeyB2.ISFakeID(indid, typestr));
	hasBdid := outPLfat(inbdid >0 and ~AutokeyB2.ISFakeID(inbdid, typestr));
			 
	//****** ENSURE THAT YOUR NEWDIDS ACTUALLY CAME FROM A PERSON SEARCH (AND BDIDS FROM COMPANY SEARCH)
	outNewDIDs1 := join(hasdid, ids,left.id = right.id);
	outNewBDIDs1 := join(hasBdid, ids,left.id = right.id);
	
	outNewDIDs  := PROJECT(outNewDIDs1,assorted_Layouts.Layout_KeyFormat);
	outNewBDIDs := PROJECT(outNewBDIDs1,assorted_Layouts.Layout_KeyFormat);
						
	//outPL := project(outPLfat, assorted_Layouts.Layout_Search_Ids);
	assorted_Layouts.Layout_Search_Ids xfm_outpl(recordof(outPLfat) l):= TRANSFORM
		SELF.IsDeepDive := False;
		SELF := l;
		SELF := [];
	END;
	
	// OUTPUT(outPLfat,NAMED('outPLfat'));
							
	outPL := project(outPLfat, xfm_outpl(LEFT));
        
endmacro;