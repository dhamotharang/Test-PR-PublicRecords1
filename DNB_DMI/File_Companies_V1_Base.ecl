import dnb,tools;

export File_Companies_V1_Base(

	 dataset(DNB.Layout_DNB_Base					)	pCompanyBase	= Files(,_Constants().IsDataland,'DNB').V1.Companies.father

) :=
function

	tools.mac_RedefineFormat(pCompanyBase,layouts.base.Companies_prev,dredefineformat);

	dBaseCompaniesFile := project(dredefineformat	,transform(Layouts.Base.CompaniesForBIP2, 

			self.date_first_seen	:= (unsigned4)left.date_first_seen	;
			self.date_last_seen		:= (unsigned4)left.date_last_seen		;
			self.record_type			:= utilities.CurrentHistoricalFlag2RT(left.record_type);
			self									:= left;
			self									:= [];
	
	));

	return dBaseCompaniesFile;


end;