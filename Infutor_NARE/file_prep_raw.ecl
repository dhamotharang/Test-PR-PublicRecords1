#workunit('name', 'PrepInfutorEmails');
#OPTION('multiplePersistInstances', FALSE);

IMPORT Infutor_NARE, ut, NID, AID, Address, emailservice, lib_stringlib, DID_Add, header_slimsort,email_data, PromoteSupers;

EXPORT file_prep_raw(STRING version) := FUNCTION

in_file			:= Infutor_NARE.file_in_raw;
in_layout		:= Infutor_NARE.layouts.layout_raw_slim;
prep_layout := Infutor_NARE.layouts.prepped;

InfEmdist := distribute(in_file, hash(FirstName,MiddleName[1],LastName,email));
InfEmsort := sort(InfEmdist,FirstName,MiddleName,LastName,email, local);

//prep input file for name and addresscleaning: trim spaces, uppercase, clean, phones, etc.
prep_layout xform_prep(in_layout le):= TRANSFORM
	self.IDNum					:= ut.CleanSpacesAndUpper(le.IDNum);
	self.FirstName			:= ut.CleanSpacesAndUpper(le.FirstName);
	self.MiddleName			:= ut.CleanSpacesAndUpper(le.MiddleName);
	self.LastName				:= ut.CleanSpacesAndUpper(le.LastName);
	self.Suffix					:= ut.CleanSpacesAndUpper(le.Suffix);
	self.RecType				:= ut.CleanSpacesAndUpper(le.RecType);
	self.Gender					:= ut.CleanSpacesAndUpper(le.Gender);
	self.DOB						:= ut.CleanSpacesAndUpper(le.DOB);
	self.AddrLine1			:= ut.CleanSpacesAndUpper(le.AddrLine1);
	self.StreetNum			:= ut.CleanSpacesAndUpper(le.StreetNum);
	self.StreetPreDir		:= ut.CleanSpacesAndUpper(le.StreetPreDir);
	self.StreetName			:= ut.CleanSpacesAndUpper(le.StreetName);
	self.StreetSuffix		:= ut.CleanSpacesAndUpper(le.StreetSuffix);
	self.StreetPostDir	:= ut.CleanSpacesAndUpper(le.StreetPostDir);
	self.AptType				:= ut.CleanSpacesAndUpper(le.AptType);
	self.AptNum					:= ut.CleanSpacesAndUpper(le.AptNum);
	self.City						:= ut.CleanSpacesAndUpper(le.City);
	self.State					:= ut.CleanSpacesAndUpper(le.State);
	self.ZipCode				:= ut.CleanSpacesAndUpper(le.ZipCode);
	self.ZipPlus4				:= ut.CleanSpacesAndUpper(le.ZipPlus4);
	self.DPC						:= ut.CleanSpacesAndUpper(le.DPC);
	self.Z4Type					:= ut.CleanSpacesAndUpper(le.Z4Type);
	self.CRTE						:= ut.CleanSpacesAndUpper(le.CRTE);
	self.FIPSCounty			:= ut.CleanSpacesAndUpper(le.FIPSCounty);
	self.DPV						:= ut.CleanSpacesAndUpper(le.DPV);
	self.VacantFlag			:= ut.CleanSpacesAndUpper(le.VacantFlag);
	self.Phone					:= ut.CleanSpacesAndUpper(le.Phone);
	self.Phone2					:= ut.CleanSpacesAndUpper(le.Phone2);
	self.Email					:= ut.CleanSpacesAndUpper(le.Email);
	self.URL						:= ut.CleanSpacesAndUpper(le.URL);
	self.IPAddr					:= ut.CleanSpacesAndUpper(le.IPAddr);
	self.WesiteType			:= ut.CleanSpacesAndUpper(le.WesiteType);
	self.DateFirstSeen	:= ut.CleanSpacesAndUpper(le.DateFirstSeen);
	self.DateLastSeen		:= ut.CleanSpacesAndUpper(le.DateLastSeen);
	self.FileDate					:= ut.CleanSpacesAndUpper(le.FileDate);
	self.ConfidenceScore	:= ut.CleanSpacesAndUpper(le.ConfidenceScore);
	self.Occurance				:= ut.CleanSpacesAndUpper(le.Occurance);
	self.PersistID					:= ut.CleanSpacesAndUpper(le.PersistID);
	self.EmailSuppressionCd	:= ut.CleanSpacesAndUpper(le.EmailSuppressionCd);
	self.Age								:= ut.CleanSpacesAndUpper(le.Age);
	//new prepped and clean fields
	self.clean_phone1				:= ut.CleanPhone(stringlib.stringcleanspaces(le.Phone));
	self.clean_phone2 			:= ut.CleanPhone(stringlib.stringcleanspaces(le.Phone2));
	self := LE;
end;

prepped_file := PROJECT(InfEmsort, xform_prep(LEFT));

Emdist := distribute(prepped_file, hash(FirstName,MiddleName[1],LastName,Email));
Emsort := sort(Emdist,FirstName,MiddleName,LastName,email,local);

//************Parse source email address and append to prepped file
//apply macro to obtain email domain fields
emailservice.mac_append_domain_flags(Emsort, append_domain, Email);  //infile,outfile,email_field

prep_layout parse_emails(append_domain input) := transform
	self.append_domain 						:= stringlib.stringtouppercase(input.domain);
	self.append_domain_type 			:= stringlib.stringtouppercase(input.domain_type);
	self.append_domain_root 			:= stringlib.stringtouppercase(input.domain_root);
	self.append_domain_ext 				:= stringlib.stringtouppercase(input.domain_ext);
	self.append_email_username 		:= stringlib.stringtouppercase(email_data.Fn_Clean_Email_Username(input.Email));
	self.append_cln_email 				:= if(self.append_email_username = '','', 
																			trim(self.append_email_username, left, right) + '@' + trim(self.append_domain, left, right));
	self := input;
end;

PrepEmail := project(append_domain, parse_emails(left));//: persist('thor_data400::persist::email::infutor_email_clean');
dedup_PrepEmail := dedup(PrepEmail);

PromoteSupers.mac_sf_buildprocess(dedup_PrepEmail,Infutor_NARE.thor_cluster+'in::email::infutor_email_clean',buildinputfile,2,,true);

RETURN buildinputfile;

END;