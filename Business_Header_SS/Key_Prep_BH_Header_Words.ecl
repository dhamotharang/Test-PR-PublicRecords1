Import Data_Services, Business_Header, PRTE2_Business_Header;

#IF (PRTE2_Business_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Business_Header.constants.PRTE_BUILD_WARN_MSG);
wf := PRTE2_Business_Header.Files().Base.CompanyWords.keybuild;
#ELSE
wf := business_header.Files().Base.CompanyWords.keybuild;
#END;


Layout_Header_Word_Index_Index := RECORD
	wf.word;
	wf.state;
	wf.seq;
	wf.bh_filepos;
	wf.bdid;
	wf.__filepos;
END;
	
// The index contains all the fields in the file -- the file itself is never
// referenced through the index.
EXPORT Key_Prep_BH_Header_Words := INDEX(
	wf, Layout_Header_Word_Index_Index, 
	'~thor_data400::key::business_header.CoNameWords' + thorlib.wuid());