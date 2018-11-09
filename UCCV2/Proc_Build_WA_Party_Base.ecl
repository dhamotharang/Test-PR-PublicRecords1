IMPORT Address, NID, UCCV2, ut;

newInput   			:= 	UCCV2.File_WA_in;	
suppressionFile	:=	if (COUNT(NOTHOR(FileServices.SuperFileContents(uccv2.Cluster.Cluster_In + 'in::uccv2::WA::suppression'))) > 0,
													UCCV2.File_WA_Suppression,
													DATASET([], UCCV2.Layout_File_WA_Suppression)
												);
NeedSuppression	:=	COUNT(NOTHOR(FileServices.SuperFileContents(uccv2.Cluster.Cluster_In + 'in::uccv2::WA::suppression'))) > 0;

trimUpper(string s) := function
			return trim(stringlib.StringToUppercase(s),left,right);
			end;   

name := FileServices.GetSuperFileSubName('~thor_data400::in::uccV2::WA', 1);
process_date := regexfind('[[:digit:]]{8}',name,0) : INDEPENDENT;
if(process_date='',fail('ERROR -- UNABLE TO OBTAIN PROCESS DATE FOR WA UCC DATA'));  
   
UCCV2.Layout_UCC_Common.Layout_Party_with_AID bldParty(newInput  L) := TRANSFORM    	 	 	 
	 clnOriginalFileNumber := trim(StringLib.StringFilterOut(L.originalFileNumber,'-'));
	 clnFileNumber := trim(StringLib.StringFilterOut(L.FileNumber,'-'));
	 clnOrganizationName := trimUpper(StringLib.StringFindReplace(L.organizationName,'&#65533;..',''));
	 
	 self.tmsid 				 := 'WA' + if(clnOriginalFileNumber = '',
										  clnFileNumber,
										  clnOriginalFileNumber) ;
	 self.rmsid 				 := 'WA' + clnFileNumber;
	 self.process_date            := process_date;
	 self.fein							:= L.taxID;
	 tempCorpNumber					    := trimUpper(L.organizationalID);
	 self.corp_number					:= map(tempCorpNumber='NONE' => '',
											   tempCorpNumber='UNKNOWN' => '',
											   tempCorpNumber);
	 tempCorpType						:= trimUpper(L.organizationalType);
	 self.corp_type						:= map(tempCorpType='NOTYPE' => '',
											   tempCorpType='LIMITEDLIABILITYCOMPANY' => 'LIMITED LIABILITY COMPANY',
											   tempCorpType);
	 self.Orig_name 					:= if(trim(clnOrganizationName)<>'',
											  trimUpper(clnOrganizationName),
											  trimUpper(StringLib.StringCleanSpaces(L.fName + ' ' + L.mName + ' ' + L.lName + ' ' + L.Suffix)));
     self.orig_fname					:= trimUpper(L.fName);
	 self.orig_mname					:= trimUpper(L.mName);
	 self.orig_lname					:= trimUpper(L.lName);
	 self.orig_suffix					:= trimUpper(L.suffix);
	 self.Orig_address1				    := trimUpper(L.mailAddress);
	 self.Orig_city						:= trimUpper(L.city);
	 self.Orig_state					:= trimUpper(L.state);
	 self.Orig_zip5						:= if(REGEXFIND('[A-Z]',L.postalCode),'', L.postalCode[1..5]);
	 self.Orig_country					:= trimUpper(L.country);
	 self.Orig_postal_code	            :=if(trimUpper(L.country) not in ['USA','US',''],trimUpper(L.postalcode),'');
	 self.Party_type					:= trimUpper(L.nameType);									
	 self.dt_first_seen					:=   (unsigned6)(process_date[1..6]);
     self.dt_last_seen					:=   (unsigned6)(process_date[1..6]);
     self.dt_vendor_first_reported		:=   (unsigned6)(process_date[1..6]);
     self.dt_vendor_last_reported		:=   (unsigned6)(process_date[1..6]);

	 self								:=	L;
	 self								:= [];  
	 end;
	 
UCCV2.Layout_UCC_Common.Layout_Party_with_AID RollupUpdate(UCCV2.Layout_UCC_Common.Layout_Party_with_AID L, 
												  UCCV2.Layout_UCC_Common.Layout_Party_with_AID R) := TRANSFORM
		self.dt_first_seen 						:= ut.EarliestDate(ut.EarliestDate(L.dt_first_seen,R.dt_first_seen),
																				ut.EarliestDate(L.dt_last_seen,R.dt_last_seen));
	  self.dt_last_seen 						:= max(L.dt_last_seen,R.dt_last_seen);
	  self.dt_vendor_last_reported	:= max(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
	  self.dt_vendor_first_reported	:= ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
	  self.process_date							:= if(L.process_date > R.process_date, L.process_date, R.process_date);
		self													:= L;
	  end;

dParties := distribute(PROJECT(newInput, bldParty(LEFT)),hash(tmsid));

UCCV2.Layout_File_WA_Suppression	GetTMISID(UCCV2.Layout_File_WA_Suppression l) := transform
	self.filing := 	'WA' + StringLib.StringFilterOut(l.filing,'-');
	self				:=	l;
end;
	 
GetTMSIDSuppression	:=	distribute(project(suppressionFile, GetTMISID(left)),hash(filing));

UCCV2.Layout_UCC_Common.Layout_Party_with_AID JoinForKeeps(UCCV2.Layout_UCC_Common.Layout_Party_with_AID l, UCCV2.Layout_File_WA_Suppression r)	:=	transform
	self	:=	l;
end;
										
Keepers		:=	join(	dParties,
										GetTMSIDSuppression,
										left.tmsid=right.filing,
										JoinForKeeps(left, right),
										Left only,
										local);	
										
TempParties	:=	if (NeedSuppression,
											Keepers,
											dParties
										);								

// Since the layout contains nametype, need to declare the NID attriubte to be something else.
NID.Mac_CleanFullNames(TempParties, VerifyPersons, Orig_name, , nid_nametype);

person_flags := ['P', 'D'];
// An executive decision was made to consider Unclassifed and Invalid names as company names for UCC.
business_flags := ['B', 'U', 'I'];

// Because the vendor will sometimes send a company name as a person's last name only, we need to make
// sure what they sent is a person.
UCCV2.Layout_UCC_Common.Layout_Party_with_AID add_clean_name_person(VerifyPersons L) := TRANSFORM
	SELF.title        := IF(L.nid_nametype IN person_flags, L.cln_title, '');
	SELF.fname        := IF(L.nid_nametype IN person_flags, L.cln_fname, '');
	SELF.mname        := IF(L.nid_nametype IN person_flags, L.cln_mname, '');
	SELF.lname        := IF(L.nid_nametype IN person_flags, L.cln_lname, '');
	SELF.name_suffix  := IF(L.nid_nametype IN person_flags, L.cln_suffix, '');
	SELF.company_name := IF(L.nid_nametype IN business_flags, L.Orig_name, '');

	SELF := L;
END;

dCleanParties := PROJECT(VerifyPersons, add_clean_name_person(LEFT));

newParties   := sort(distribute(dCleanParties,hash(tmsid)),record,local);
partiesDedup := rollup(newParties, RollupUpdate(left, right), except bdid, dt_first_seen, dt_last_seen,
                       dt_vendor_first_reported, dt_vendor_last_reported, process_date,  local);
									   									 
OutParty         :=  output(partiesDedup,,UCCV2.cluster.cluster_out+'base::UCC::Party::wa',overwrite,__compressed__);
AddSuperfile     :=  FileServices.AddSuperFile(UCCV2.cluster.cluster_out+'base::UCC::Party_Name',UCCV2.cluster.cluster_out+'base::UCC::Party::wa');

export proc_build_wa_party_base    :=sequential(OutParty,AddSuperfile);  