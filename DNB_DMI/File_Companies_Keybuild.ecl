import tools,dnb,BIPV2;

export File_Companies_Keybuild(

	 string														pVersion							= 'built'
	,boolean													pUseOtherEnvironment	= false
	,dataset(Layouts.Base.companiesForBip2	)	pBaseCompaniesFile		= Files(pVersion,pUseOtherEnvironment).base.companies.new								

) :=
function

	dBaseCompaniesFile := project(pBaseCompaniesFile,transform({layouts.base.Companies_prev,BIPV2.IDlayouts.l_xlink_ids}, 

			self.date_first_seen	:= (string8)left.date_first_seen	;
			self.date_last_seen		:= (string8)left.date_last_seen		;
			self.record_type			:= utilities.RT2CurrentHistoricalFlag(left.record_type);
			self									:= left;
	
	));

 Layout_DNB_Base_Linkids := record
 DNB.Layout_DNB_Base;
 BIPV2.IDlayouts.l_xlink_ids;
 end;

	tools.mac_RedefineFormat(dBaseCompaniesFile,Layout_DNB_Base_Linkids, dreturndataset);

	return dreturndataset;

end;