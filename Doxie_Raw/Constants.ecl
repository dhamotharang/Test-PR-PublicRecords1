IMPORT Header;

EXPORT Constants :=
MODULE

	EXPORT RelativeAssociate_Limit := 2500;
	
	EXPORT strRelative  := 'Relative';
	EXPORT strAssociate := 'Associate';
	
	EXPORT GetSecondDegRelation(UNSIGNED1 pFirstDegTitle,UNSIGNED1 pSecondDegTitle) :=
	FUNCTION
		modRelTitle := Header.relative_titles;
		
		setChild   := [modRelTitle.num_Child,modRelTitle.num_Son,modRelTitle.num_Daughter];
		setSibling := [modRelTitle.num_Brother,modRelTitle.num_Sister,modRelTitle.num_Sibling];
		
		RETURN MAP( pFirstDegTitle IN modRelTitle.set_SpecificParent and pSecondDegTitle = modRelTitle.num_Father => modRelTitle.num_Grandfather,
								pFirstDegTitle IN modRelTitle.set_SpecificParent and pSecondDegTitle = modRelTitle.num_Mother => modRelTitle.num_Grandmother,
								pFirstDegTitle IN modRelTitle.set_SpecificParent and pSecondDegTitle = modRelTitle.num_Parent => modRelTitle.num_Grandparent,
								pFirstDegTitle IN setChild and pSecondDegTitle = modRelTitle.num_Son                          => modRelTitle.num_Grandson,
								pFirstDegTitle IN setChild and pSecondDegTitle = modRelTitle.num_Daughter                     => modRelTitle.num_Granddaughter,
								pFirstDegTitle IN setChild and pSecondDegTitle IN setChild                                    => modRelTitle.num_Gradchild,
								pFirstDegTitle IN modRelTitle.set_Spouse and pSecondDegTitle = modRelTitle.num_Father         => modRelTitle.num_FatherInlaw,
								pFirstDegTitle IN modRelTitle.set_Spouse and pSecondDegTitle = modRelTitle.num_Mother         => modRelTitle.num_MotherInlaw,
								pFirstDegTitle IN modRelTitle.set_Spouse and pSecondDegTitle = modRelTitle.num_Parent         => modRelTitle.num_ParentInlaw,
								pFirstDegTitle IN modRelTitle.set_Spouse and pSecondDegTitle = modRelTitle.num_Brother        => modRelTitle.num_BrotherInlaw,
								pFirstDegTitle IN modRelTitle.set_Spouse and pSecondDegTitle = modRelTitle.num_Sister         => modRelTitle.num_SisterInlaw,
								pFirstDegTitle IN modRelTitle.set_Spouse and pSecondDegTitle IN setSibling                    => modRelTitle.num_SiblingInlaw,
								pFirstDegTitle IN setSibling and pSecondDegTitle = modRelTitle.num_Son                        => modRelTitle.num_nephew,
								pFirstDegTitle IN setSibling and pSecondDegTitle = modRelTitle.num_Daughter                   => modRelTitle.num_niece,
								modRelTitle.num_relative);
	END;
	
	EXPORT Debug := FALSE;

END;