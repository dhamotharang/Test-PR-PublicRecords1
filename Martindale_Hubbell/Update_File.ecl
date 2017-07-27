export Update_File :=
module

	export Organizations(

		 string pversion

	) := 
		Update_Organizations(
			 pversion
			,Files().input.using
			,Files().base.Organizations.qa
		);

	export Affiliated_Individuals(

		 string		pversion

	) :=
		Update_Affiliated_Individuals(
			 pversion
			,Files().input.using
			,Files().base.Affiliated_Individuals.qa
			,Files().base.Organizations.built
		);
	
	export Unaffiliated_Individuals(

		 string		pversion

	) :=
		Update_Unaffiliated_Individuals(
			 pversion
			,Files().input.using
			,Files().base.Unaffiliated_Individuals.qa
		);

end;