import tools,address;

export Prep_Base(

	 dataset(Layouts.Base.Companies	)	pBaseCompaniesFile	= Files().base.companies.qa			
	,dataset(Layouts.Base.Contacts	)	pBaseContactsFile		= Files().base.contacts.qa			
	
) :=
module

	export Companies	:= project(pBaseCompaniesFile,transform(layouts.temporary.companies_aid_prep,
					self.physical_address1 	:=	tools.AID_Helpers.fRawFixLine1(left.rawfields.address1.street);
					self.physical_address2	:=	tools.AID_Helpers.fRawFixLineLast(
																											trim(left.rawfields.address1.city)    
																									+ ', ' + left.rawfields.address1.state   	
																									+ ' '  + left.rawfields.address1.zip[1..5]
																							);
	
					self.mailing_address1 	:=	tools.AID_Helpers.fRawFixLine1(left.rawfields.address2.street);
					self.mailing_address2		:=	tools.AID_Helpers.fRawFixLineLast(
																											trim(left.rawfields.address2.city)    
																									+ ', ' + left.rawfields.address2.state   	
																									+ ' '  + left.rawfields.address2.zip[1..5]
																							);
					self															:= left;
					self															:= [];
	))
	;
	
	export Contacts	:= project(pBaseContactsFile,transform(layouts.temporary.contacts_aid_prep,
					self.physical_address1 	:=	tools.AID_Helpers.fRawFixLine1(left.rawfields.address1.street);
					self.physical_address2	:=	tools.AID_Helpers.fRawFixLineLast(
																											trim(left.rawfields.address1.city)    
																									+ ', ' + left.rawfields.address1.state   	
																									+ ' '  + left.rawfields.address1.zip[1..5]
																							);
	
					self.mailing_address1 	:=	tools.AID_Helpers.fRawFixLine1(left.rawfields.address2.street);
					self.mailing_address2		:=	tools.AID_Helpers.fRawFixLineLast(
																											trim(left.rawfields.address2.city)    
																									+ ', ' + left.rawfields.address2.state   	
																									+ ' '  + left.rawfields.address2.zip[1..5]
																							);
					self															:= left;
					self															:= [];
	))
	;
	
end;