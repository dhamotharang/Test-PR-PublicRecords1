import tools;

export Proc_Build_BIPV2WeeklyKeys_Package(

   string   pversion
  ,boolean  pPromote2QA 					= true
	,boolean  puseotherenvironment	= false

) := 
function

	shared knames           := keynames(pversion, puseotherenvironment);

	Build_contact_linkids   := tools.macf_writeindex('Key_Contact_Linkids.key     ,knames.contact_linkids.new'    );
	Build_dir_linkids       := tools.macf_writeindex('Key_Directories_Linkids.key ,knames.directories_linkids.new');

	BuildWeeklyKeys := 
	sequential(
		 Build_contact_linkids
		,PRTE2_BIPV2_BusHeader.Promote(pversion,'^~prte.*?key.*contact_linkids$').New2Built
		,Build_dir_linkids
		,PRTE2_BIPV2_BusHeader.Promote(pversion,'^~prte.*?key.*directories_linkids$').New2Built
		,if(pPromote2QA = true,Promote(pversion,'^~prte.*?key.*_linkids$').Built2QA)
	);

	return BuildWeeklyKeys;

end;