import doxie, Relocations;

con := contactcard.constants;

export storeds :=
MODULE

shared numAddressesPerPerson_chosen := con.default_AddrsPerPerson : stored('AddressesPerPerson');
export AddressesPerPerson := if(numAddressesPerPerson_chosen > 0 and numAddressesPerPerson_chosen < con.max_AddrsPerPerson, numAddressesPerPerson_chosen, con.max_AddrsPerPerson);

shared numPhonesPerPerson_chosen := con.default_PhonesPerPerson : stored('PhonesPerPerson');
export PhonesPerPerson := if(numPhonesPerPerson_chosen > 0 and numPhonesPerPerson_chosen < con.max_PhonesPerPerson, numPhonesPerPerson_chosen, con.max_PhonesPerPerson);

//this not affected by SelectIndividually
export IncludeNonSubjectPhonelessAddresses := false : stored('IncludeNonSubjectPhonelessAddresses');

//these for relocations
export unsigned2	maxDaysBefore 	:= Relocations.wdtg.default_daysBefore	: stored('MaxDaysBefore');
export unsigned2	maxDaysAfter		:= Relocations.wdtg.default_daysAfter		: stored('MaxDaysAfter');
export unsigned2  targetRadius		:= Relocations.wdtg.default_radius			: stored('TargetRadius');

// PhonesPlus data for relatives/associates/neighbors is taken separately from subject:
export IncludePhonesPlus_for_RNA := false : stored('IncludePhonesPlusForRNA');

export boolean Include_Email_Addresses := false : stored('IncludeEmailAddresses');

END;
