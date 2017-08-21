/*
So there will be a total of 5 files:
	Business Information file
	Business Contacts file
	liens and judgments file	--use liensv2
	criminal file from crim offense/offender file
//	bankruptcy file --no just a flag if they are under bankruptcy proceedings -- use bankrupt.File_BK_Main and bankrupt.File_BK_Search
	
	they will all be linked on bdid to the business information file
	contact file will also have did


Outline of process:
	1. take business contacts file(filtered on the exclude sources), reformat to output layout.
	2. match to filtered bh_bdid_sic(filter on exclude sources) to get the siccodes for that bdid
	3. use ut.TitleRank to find the highest ranking title for this bdid
	4. there are no sales fields from any non-problematic source, so will remain blank
	5. employees -- nothing except maybe in amidir--but this is questionable
	6. bankrupcty indicator -- join to bankrupt.File_BK_Main and bankrupt.File_BK_Search to find out
		if the company is currently operating under chapter 11 proceedings.  if chapter is not 12, and disposed date
		is blank, then it is--confirm with Lisa on this
	7. OB indicator -- can use the above match to flag the businesses that are chapter 12 as 'Y' + can
		join to the deadcompanies file to set the flag, + if date last seen is greater than a year
		(accounting for blank dates of course), 'Y'
	8. business structure -- blank for now--can't think of a way to find this out
	9. fax_number -- not stored in business header -- will be blank for now
	10. url will be blank for now
	11. legal form -- blank for now
	12. year started -- blank for now -- can't find anything for this yet

	//for Business Contacts
	1. reformat business contacts file to output layout, filtering out the exclude sources.
	2. match to watchdog non-glb best file on did to get home address and phone.
	
	// Liens and judgements
	1. match filtered BC file to liensv2 party file on did, grab tmsid, rmsid
	2. match output of above to lienv2 main file on tmsid and rmsid and grab full record minus the child dataset.
	
	// Criminal
	1. match to CrimSrch.File_Moxie_Offender_Dev on did, then to CrimSrch.File_Moxie_Offenses_Dev on offender_key
		and, if they want the punishment, CrimSrch.File_Moxie_Punishment_Dev.
	2. 

Old Sample formats from last time:

layout_company_sample := record
  string12  bdid;
  string120 company_name;
  string120 addr1;
  string30  city;
  string2   state;
  string5   zip;
  string4   zip4;
  string10  phone;
  string9   fein;
end;

 

layout_contact_sample := record
  string12  bdid;
  string12  did;
  string120 company_name;
  string120 addr1;
  string30  city;
  string2   state;
  string5   zip;
  string4   zip4;
  string10  phone;
  string20  fname;
  string20  mname;
  string20  lname;
  string5   name_suffix;
  string30  company_title;
end;

 



*/