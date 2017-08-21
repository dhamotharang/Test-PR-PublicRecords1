export Strata(Parent
										, child_Address
										,	child_Alias
										, child_Dob
										, child_IDentifications
										, child_Phones
										, child_Pob
										, child_Additional,pversion,zout) := macro 
										
import STRATA;

	#uniquename(rPopulationStats_Parent);
	#uniquename(dPopulationStats_Parent);
	#uniquename(zParentStats);
	
	#uniquename(rPopulationStats_child_Address);
	#uniquename(dPopulationStats_child_Address);
	#uniquename(zChild_AddressStats);
	
	#uniquename(rPopulationStats_child_Alias);
	#uniquename(dPopulationStats_child_Alias);
	#uniquename(zChild_AliasStats);
	
	#uniquename(rPopulationStats_child_Dob);
	#uniquename(dPopulationStats_child_Dob);
	#uniquename(zChild_DobStats);
	
	#uniquename(rPopulationStats_child_Identifications);
	#uniquename(dPopulationStats_child_Identifications);
	#uniquename(zChild_IdentificationsStats);
	
	#uniquename(rPopulationStats_child_Phones);
	#uniquename(dPopulationStats_child_Phones);
	#uniquename(zChild_PhonesStats);
	
	#uniquename(rPopulationStats_child_Pob);
	#uniquename(dPopulationStats_child_Pob);
	#uniquename(zChild_PobStats);
	
	#uniquename(rPopulationStats_child_Additional);
	#uniquename(dPopulationStats_child_Additional);
	#uniquename(zChild_AdditionalStats);
    
%rPopulationStats_Parent%
 :=
  record
    CountGroup                                      := count(group);
		Parent.type;
    id_CountNonBlank               									:= sum(group,if(Parent.id<>'',1,0));
    title_CountNonBlank                      				:= sum(group,if(Parent.title<>'',1,0));
    firstname_CountNonBlank                         := sum(group,if(Parent.first_name<>'',1,0));
    middlename_CountNonBlank                        := sum(group,if(Parent.middle_name<>'',1,0));
    lastname_CountNonBlank                        	:= sum(group,if(Parent.last_name<>'',1,0));
		fullname_CountNonBlank                        	:= sum(group,if(Parent.full_name<>'',1,0));
    generation_CountNonBlank                        := sum(group,if(Parent.generation<>'',1,0));
		gender_CountNonBlank                        	  := sum(group,if(Parent.gender<>'',1,0));
    listedDate_CountNonBlank                        := sum(group,if(Parent.listed_date<>'',1,0));
    entityAddedBy_CountNonBlank                     := sum(group,if(Parent.entity_added_by<>'',1,0));
    reasonListed_CountNonBlank                      := sum(group,if(Parent.reason_listed<>'',1,0));
    referenceID_CountNonBlank                       := sum(group,if(Parent.reference_id<>'',1,0));
    comments_CountNonBlank                          := sum(group,if(Parent.comments<>'',1,0));
    searchCriteria_CountNonBlank                    := sum(group,if(Parent.search_criteria<>'',1,0));
 end;

%rPopulationStats_child_Address%
 :=
  record
	  CountGroup                                       := count(group);
		child_Address.type;
	  id_CountNonBlank                                 := sum(group,if(child_Address.id<>'',1,0));
    street1_CountNonBlank                            := sum(group,if(child_Address.street_1<>'',1,0));
    street2_CountNonBlank                            := sum(group,if(child_Address.street_2<>'',1,0));
    city_CountNonBlank                               := sum(group,if(child_Address.city<>'',1,0));
    state_CountNonBlank                              := sum(group,if(child_Address.state<>'',1,0));
    postalCode_CountNonBlank                         := sum(group,if(child_Address.postal_code<>'',1,0));
    country_CountNonBlank                            := sum(group,if(child_Address.country<>'',1,0));
    comments_CountNonBlank                           := sum(group,if(child_Address.comments<>'',1,0));
  end;

%rPopulationStats_child_Alias%
 :=
  record
	  CountGroup                                       := count(group);
		child_Alias.type;
	  id_CountNonBlank                                 := sum(group,if(child_Alias.id<>'',1,0));
    category_CountNonBlank                           := sum(group,if(child_Alias.category<>'',1,0));
    fullName_CountNonBlank                           := sum(group,if(child_Alias.full_name<>'',1,0));
    firstName_CountNonBlank                          := sum(group,if(child_Alias.first_name<>'',1,0));
    middleName_CountNonBlank                         := sum(group,if(child_Alias.middle_name<>'',1,0));
    lastName_CountNonBlank                           := sum(group,if(child_Alias.last_name<>'',1,0));
    generation_CountNonBlank                         := sum(group,if(child_Alias.generation<>'',1,0));
    comments_CountNonBlank                           := sum(group,if(child_Alias.comments<>'',1,0));
  end;

%rPopulationStats_child_Dob%
 :=
  record
	  CountGroup                                       := count(group);
		child_Dob.type;
	  id_CountNonBlank                                 := sum(group,if(child_Dob.id<>'',1,0));
    information_CountNonBlank                        := sum(group,if(child_Dob.information<>'',1,0));
    parsed_CountNonBlank                             := sum(group,if(child_Dob.parsed<>'',1,0));
    comments_CountNonBlank                           := sum(group,if(child_Dob.comments<>'',1,0));
  end;

%rPopulationStats_child_Identifications%
 :=
  record
	  CountGroup                                       := count(group);
		child_Identifications.type;
    id_CountNonBlank                                 := sum(group,if(child_Identifications.id<>'',1,0));	
    label_CountNonBlank                              := sum(group,if(child_Identifications.label<>'',1,0));	
    number_CountNonBlank                             := sum(group,if(child_Identifications.number<>'',1,0));	
    issuedBy_CountNonBlank                           := sum(group,if(child_Identifications.issued_by<>'',1,0));	
    dateIssued_CountNonBlank                         := sum(group,if(child_Identifications.date_issued<>'',1,0));	
    dateExpires_CountNonBlank                        := sum(group,if(child_Identifications.date_expires<>'',1,0));	
    comments_CountNonBlank                           := sum(group,if(child_Identifications.comments<>'',1,0));	

  end;

%rPopulationStats_child_Phones%
 :=
  record
	  CountGroup                                       := count(group);
		child_Phones.type;
    id_CountNonBlank                                 := sum(group,if(child_Phones.id<>'',1,0));	
    addressID_CountNonBlank                          := sum(group,if(child_Phones.address_id<>'',1,0));	
    number_CountNonBlank                             := sum(group,if(child_Phones.number<>'',1,0));	
    comments_CountNonBlank                           := sum(group,if(child_Phones.comments<>'',1,0));	

  end;
	
%rPopulationStats_child_Pob%
 :=
  record
	  CountGroup                                       := count(group);
		child_Pob.type;
	  id_CountNonBlank                                 := sum(group,if(child_Pob.id<>'',1,0));
    information_CountNonBlank                        := sum(group,if(child_Pob.information<>'',1,0));
    parsed_CountNonBlank                             := sum(group,if(child_Pob.parsed<>'',1,0));
    comments_CountNonBlank                           := sum(group,if(child_Pob.comments<>'',1,0));
  end;
	
%rPopulationStats_child_Additional%
 :=
  record
	  CountGroup                                       := count(group);
		child_Additional.type;
	  id_CountNonBlank                                 := sum(group,if(child_Additional.id<>'',1,0));
    information_CountNonBlank                        := sum(group,if(child_Additional.information<>'',1,0));
    parsed_CountNonBlank                             := sum(group,if(child_Additional.parsed<>'',1,0));
    comments_CountNonBlank                           := sum(group,if(child_Additional.comments<>'',1,0));

  end;
///////////////////////////////////////////////////////////////////////////////////////////////////////////
//output rParent stats
///////////////////////////////////////////////////////////////////////////////////////////////////////////
	%dPopulationStats_Parent% := table(Parent
	                  ,%rPopulationStats_Parent%
									  ,parent.type
                    ,few);

	STRATA.createXMLStats(%dPopulationStats_Parent%
	                  ,'Accuity'
										,'Main'
										,pVersion
										,''
										,%zParentStats%
										,'view'
										,'Population');
///////////////////////////////////////////////////////////////////////////////////////////////////////////
//output crAddress stats
///////////////////////////////////////////////////////////////////////////////////////////////////////////
	%dPopulationStats_child_Address% := table(child_Address
	                  ,%rPopulationStats_child_Address%
									  ,child_Address.type
									  ,few);
	STRATA.createXMLStats(%dPopulationStats_child_Address%
	                  ,'Accuity'
										,'Address'
										,pVersion
										,''
										,%zChild_AddressStats%
										,'view'
										,'Population');
					 
///////////////////////////////////////////////////////////////////////////////////////////////////////////
//output crAlias stats
///////////////////////////////////////////////////////////////////////////////////////////////////////////
	%dPopulationStats_child_Alias% := table(child_Alias
	                  ,%rPopulationStats_child_Alias%
									  ,child_Alias.type
									  ,few);
	STRATA.createXMLStats(%dPopulationStats_child_Alias%
	                  ,'Accuity'
										,'Alias'
										,pVersion
										,''
										,%zChild_AliasStats%
										,'view'
										,'Population');
///////////////////////////////////////////////////////////////////////////////////////////////////////////
//output crDob stats
///////////////////////////////////////////////////////////////////////////////////////////////////////////
	%dPopulationStats_child_Dob% := table(child_Dob
	                  ,%rPopulationStats_child_Dob%
									  ,child_Dob.type
									  ,few);
	STRATA.createXMLStats(%dPopulationStats_child_Dob%
	                  ,'Accuity'
										,'Dob'
										,pVersion
										,''
										,%zChild_DobStats%
										,'view'
										,'Population');
///////////////////////////////////////////////////////////////////////////////////////////////////////////
//output crIdentifications stats
///////////////////////////////////////////////////////////////////////////////////////////////////////////
	%dPopulationStats_child_Identifications% := table(child_Identifications
	                  ,%rPopulationStats_child_Identifications%
									  ,type
									  ,few);
	STRATA.createXMLStats(%dPopulationStats_child_Identifications%
	                  ,'Accuity'
										,'Identifications'
										,pVersion
										,''
										,%zChild_IdentificationsStats%
										,'view'
										,'Population');
///////////////////////////////////////////////////////////////////////////////////////////////////////////
//output crPhones stats
///////////////////////////////////////////////////////////////////////////////////////////////////////////
	%dPopulationStats_child_Phones% := table(child_Phones
	                  ,%rPopulationStats_child_Phones%
									  ,child_Phones.type
									  ,few);
	STRATA.createXMLStats(%dPopulationStats_child_Phones%
	                  ,'Accuity'
										,'Phones'
										,pVersion
										,''
										,%zChild_PhonesStats%
										,'view'
										,'Population');
///////////////////////////////////////////////////////////////////////////////////////////////////////////
//output crPob stats
///////////////////////////////////////////////////////////////////////////////////////////////////////////
	%dPopulationStats_child_Pob% := table(child_Pob
	                  ,%rPopulationStats_child_Pob%
									  ,child_Pob.type
									  ,few);
	STRATA.createXMLStats(%dPopulationStats_child_Pob%
	                  ,'Accuity'
										,'Pob'
										,pVersion
										,''
										,%zChild_PobStats%
										,'view'
										,'Population');
///////////////////////////////////////////////////////////////////////////////////////////////////////////
//output crAdditional stats
///////////////////////////////////////////////////////////////////////////////////////////////////////////
	%dPopulationStats_child_Additional% := table(child_Additional
	                  ,%rPopulationStats_child_Additional%
									  ,child_Additional.type
									  ,few);
	STRATA.createXMLStats(%dPopulationStats_child_Additional%
	                  ,'Accuity'
										,'Additional_Info'
										,pVersion
										,''
										,%zChild_AdditionalStats%
										,'view'
										,'Population');

zOut := parallel(%zParentStats%,%zChild_AddressStats%,%zChild_AliasStats%,%zChild_DobStats%,%zChild_IdentificationsStats%
								,%zChild_PhonesStats%,%zChild_PobStats%,%zChild_AdditionalStats%);

ENDMACRO;