export Update_File :=
module

	export Companies(

		 string pversion

	) := 
		Update_Companies(
	  	 Files().input.Companies.using
			,Files().input.Contacts.using //added for bipv2
			,Files().base.Contacts.qa     //added for bipv2
			,Files().base.Companies.qa
			,pversion
		);

	export Contacts(

		 string		pversion

	) :=
		Update_Contacts(
  		 Files().input.Contacts.using   
			,Files().base.Contacts.qa
			,Files().base.Companies.built
			,pversion
		);
	
end;