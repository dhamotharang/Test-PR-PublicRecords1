IMPORT ut, Business_Header;

export YellowPages_As_Business_Contact 
 := fYellowPages_As_Business_Contact(Files().Base.BusinessHeader)
 : persist(persistnames().AsBusinessContact)
 ;