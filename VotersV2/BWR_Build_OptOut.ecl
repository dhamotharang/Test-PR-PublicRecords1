
// This process will Spray and Clean the Voters/Emerges Annual Opt Out file.

// This Opt Out file is used by both the VotersV2 build and the eMerges build
// to remove records for people who choose to opt out of 
// Voters and eMerges Hunt/Fish/CCW Base and Keys files.


pVersion 	:= '20200401'		;		// modify to current tapeload folder date

#workunit('name', 'Voters & Emerges Opt Out' + pversion);
VotersV2.Proc_Build_OptOut(pVersion);