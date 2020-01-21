import Business_Header, VersionControl,mdr,ut,NID,_control,tools,STD;

export Proc_Build_Business_Contacts_Base_Files (

	 string																											pversion
	,dataset(Business_Header.Layout_Business_Contact_Full_New)	pBC_Base	= BC_Init_Final()	
	,dataset(Business_Header.Layout_Business_Contacts_Stats  )	pBC_Stats	= BC_Stats()

) := 
module

	shared names := filenames(pversion).base;
	
	shared dBC_All_Recs := mdr.macGetGlobalSID(pBC_Base, 'BusinessHeader', 'source', 'global_sid');
	
	VersionControl.macBuildNewLogicalFile( names.contacts.new						,dBC_All_Recs		,Build_Contacts			);
	VersionControl.macBuildNewLogicalFile( names.contactsPlus.new				,dBC_All_Recs		,Build_ContactsPlus	);
	VersionControl.macBuildNewLogicalFile( names.PeopleAtWorkStats.new	,pBC_Stats			,Build_Stats				);
	
	
	dothis := OUTPUT('MAKE SURE THESE TWO FILES HAVE THE SAME NUMBER OF RECORDS, PLEASE!');
	
	export all := 
	sequential(

		 Build_Contacts			
		,Build_ContactsPlus	
		,promote(pversion,'^.*?base::business_header.*?contacts.*$'							).new2built
		,Build_Stats				
		,promote(pversion,'^.*?base::business_header.*?people_at_work_stats.*$'	).new2built
		,dothis
	);
	
end;
