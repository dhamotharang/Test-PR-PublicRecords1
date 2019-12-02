/*--SOAP--
<message name="SNA Business Report">
	<part name="SNABusinessReportRequest" type="tns:XmlDataSet" cols="80" rows="50"/>
 </message>
*/
/*--HELP-- 
<pre>
&lt;SNABusinessReportRequest&gt;
 &lt;Row&gt;
 &lt;User&gt;
  &lt;ReferenceCode&gt;&lt;/ReferenceCode&gt; 
  &lt;BillingCode&gt;&lt;/BillingCode&gt; 
  &lt;QueryId&gt;&lt;/QueryId&gt; 
  &lt;CompanyId&gt;&lt;/CompanyId&gt; 
  &lt;GLBPurpose&gt;&lt;/GLBPurpose&gt; 
  &lt;DLPurpose&gt;&lt;/DLPurpose&gt; 
  &lt;LoginHistoryId&gt;&lt;/LoginHistoryId&gt; 
  &lt;DebitUnits&gt;0&lt;/DebitUnits&gt; 
  &lt;IP&gt;&lt;/IP&gt; 
  &lt;IndustryClass&gt;&lt;/IndustryClass&gt; 
  &lt;ResultFormat&gt;&lt;/ResultFormat&gt; 
  &lt;LogAsFunction&gt;&lt;/LogAsFunction&gt; 
  &lt;SSNMask&gt;&lt;/SSNMask&gt; 
  &lt;DOBMask&gt;&lt;/DOBMask&gt; 
  &lt;DLMask&gt;false&lt;/DLMask&gt; 
  &lt;DataRestrictionMask&gt;&lt;/DataRestrictionMask&gt; 
  &lt;DataPermissionMask&gt;&lt;/DataPermissionMask&gt; 
  &lt;ApplicationType&gt;&lt;/ApplicationType&gt; 
  &lt;SSNMaskingOn&gt;false&lt;/SSNMaskingOn&gt; 
  &lt;DLMaskingOn&gt;false&lt;/DLMaskingOn&gt; 
 &lt;EndUser&gt;
  &lt;CompanyName&gt;&lt;/CompanyName&gt; 
  &lt;StreetAddress1&gt;&lt;/StreetAddress1&gt; 
  &lt;City&gt;&lt;/City&gt; 
  &lt;State&gt;&lt;/State&gt; 
  &lt;Zip5&gt;&lt;/Zip5&gt; 
  &lt;/EndUser&gt;
  &lt;MaxWaitSeconds&gt;0&lt;/MaxWaitSeconds&gt; 
  &lt;RelatedTransactionId&gt;&lt;/RelatedTransactionId&gt; 
  &lt;AccountNumber&gt;&lt;/AccountNumber&gt; 
  &lt;TestDataEnabled&gt;false&lt;/TestDataEnabled&gt; 
  &lt;TestDataTableName&gt;&lt;/TestDataTableName&gt; 
  &lt;/User&gt;
  &lt;RemoteLocations&gt;&lt;/RemoteLocations&gt; 
  &lt;ServiceLocations&gt;&lt;/ServiceLocations&gt; 
 &lt;Options&gt;
  &lt;Blind&gt;false&lt;/Blind&gt; 
  &lt;Encrypt&gt;false&lt;/Encrypt&gt; 
  &lt;ReturnTokens&gt;false&lt;/ReturnTokens&gt; 
  &lt;StartingRecord&gt;0&lt;/StartingRecord&gt; 
  &lt;ReturnCount&gt;10&lt;/ReturnCount&gt; 
  &lt;ContactScoreCutoff&gt;2&lt;/ContactScoreCutoff&gt; 
  &lt;DegreeCutoff&gt;2&lt;/DegreeCutoff&gt; 
  &lt;BusinessFilters&gt;
   &lt;ActiveFilter&gt;all&lt;/ActiveFilter&gt;
   &lt;MedicalFilter&gt;all&lt;/MedicalFilter&gt;
  &lt;/BusinessFilters&gt;
 &lt;/Options&gt;
 &lt;SearchBy&gt;
  &lt;LexID&gt;&lt/LexID&gt;
 &lt;/SearchBy&gt;
 &lt;/Row&gt;
&lt;/SNABusinessReportRequest&gt;
</pre>
*/

IMPORT sna, Business_Header, iesp, Doxie, Suppress, UT, STD;


EXPORT BusinessReport_Service := MACRO

	ds_in    := dataset([], iesp.SNABusinessReport.t_SNABusinessReportRequest)  	: stored('SNABusinessReportRequest', few);

    //CCPA fields
    unsigned1 LexIdSourceOptout := 1 : STORED('LexIdSourceOptout');
    string TransactionID := '' : STORED('_TransactionId');
    string BatchUID := '' : STORED('_BatchUID');
    unsigned6 GlobalCompanyId := 0 : STORED('_GCID');
    
    mod_access := MODULE(Doxie.IDataAccess)
    EXPORT unsigned1 lexid_source_optout := LexIdSourceOptout;
    EXPORT string transaction_id := TransactionID; // esp transaction id or batch uid
    EXPORT unsigned6 global_company_id := GlobalCompanyId; // mbs gcid
    END;

	source_did := [(integer)ds_in[1].SearchBy.LexID];
	contact_score_cutoff := (integer)ds_in[1].Options.ContactScoreCutoff; // defaults to 0
	activeBusinessFilter := STD.Str.ToUpperCase(ds_in[1].Options.BusinessFilters.ActiveFilter);
	medicalBusinessFilter := STD.Str.ToUpperCase(ds_in[1].Options.BusinessFilters.MedicalFilter);
	includeSIC := ds_in[1].Options.IncludeSIC;
	
	degreeCutoff := if(trim(ds_in[1].Options.DegreeCutoff)='', 2.0, (real)ds_in[1].Options.DegreeCutoff);
	
	{SNA.BusinessRecord_Layout, unsigned4 global_sid} prep1_tx(sna.Key_Person_Cluster le, Business_Header.Key_Business_Contacts_DID ri) := TRANSFORM
		self := le;
		self := ri;
		self := [];
	END;
	
	{SNA.BusinessRecord_Layout, unsigned4 global_sid} prep2_tx(SNA.BusinessRecord_Layout le, Business_Header.Key_Business_Contacts_FP ri) := TRANSFORM
        self.global_sid := ri.global_sid;
        self := ri;
		self := le;
		self := [];
	END;
	
	Associates := choosen(sna.Key_Person_Cluster((cluster_id in source_did) and (degree <= degreeCutoff)), 1000);	
	
	BusinessesPrep1_unsuppressed := JOIN(sort(Associates(associated_did > 0), associated_did), 
														Business_Header.Key_Business_Contacts_DID,
		                        keyed(LEFT.associated_did = RIGHT.did),
														prep1_tx(LEFT,RIGHT), 
														LIMIT(iesp.Constants.SNA.MaxBusinessReturn));
    BusinessesPrep1 := Suppress.Suppress_ReturnOldLayout(BusinessesPrep1_unsuppressed, mod_access, SNA.BusinessRecord_Layout);
														
	BusinessesPrep2_unsuppressed := JOIN(BusinessesPrep1, Business_Header.Key_Business_Contacts_FP,
		                        keyed(LEFT.fp = RIGHT.fp) and (contact_score_cutoff <= right.contact_score) and (RIGHT.bdid>0),
														prep2_tx(LEFT,RIGHT), 
														LIMIT(iesp.Constants.SNA.MaxBusinessReturn));
    BusinessesPrep2 := Suppress.Suppress_ReturnOldLayout(BusinessesPrep2_unsuppressed, mod_access, SNA.BusinessRecord_Layout);
				
					
	glb := (INTEGER)ds_in[1].User.GLBPurpose;
  dppa := (INTEGER)ds_in[1].User.DLPurpose;
 
  glb_ok := ut.PermissionTools.glb.ok(glb);		 
  dppa_ok := ut.PermissionTools.dppa.ok(dppa);
 
	doxie.mac_best_records(dedup(sort(BusinessesPrep2,cluster_id),cluster_id),
												 cluster_id,
												 outfile,
												 dppa_ok,
												 glb_ok,
												 ,
												 doxie.DataRestriction.fixed_DRM);										 
	
	SNA.BusinessRecord_Layout prep4_tx(SNA.BusinessRecord_Layout le, outfile ri) := TRANSFORM
		self.cluster_fname := ri.fname;
		self.cluster_mname := ri.mname;
		self.cluster_lname := ri.lname;
		
		self := le;
	END;

	BusinessesPrep4 := JOIN(BusinessesPrep2, outfile, 
				left.cluster_id=right.did, 
				prep4_tx(LEFT, RIGHT), LIMIT(iesp.Constants.SNA.MaxBusinessReturn));
														
	doxie.mac_best_records(dedup(sort(BusinessesPrep4, did),did),
												 did,
												 outfile2,
												 dppa_ok,
												 glb_ok,
												 ,
												 doxie.DataRestriction.fixed_DRM);

	SNA.BusinessRecord_Layout prep5_tx(SNA.BusinessRecord_Layout le, outfile2 ri) := TRANSFORM
		self.fname := ri.fname;
		self.mname := ri.mname;
		self.lname := ri.lname;

		self := le;
	END;
	
	BusinessesPrep5 := JOIN(BusinessesPrep4, outfile2,
													left.did=right.did, 
													prep5_tx(LEFT, RIGHT), LIMIT(iesp.Constants.SNA.MaxBusinessReturn));

// Healthcare 
// ------------------------------------------------------------
	TOKEN pWspace := PATTERN('[^a-zA-Z0-9.]');
	TOKEN pWord := PATTERN('[a-zA-Z0-9.]+');
	PATTERN pMedPrefix:=  [
											 'MEDIC', 'AMBUL', 'BIO',
											 'REHAB', 'PHARM', 'RX', 'DRUG', 'PEDIATRIC','HEALTH',
											 'SURGEON', 'PSYCHIA', 'PSYCHOLOG', 'CHIRO', 'ONCOLO', 'OBGYN','GYN', 'ORTHO', 'OPTHAL','NEURO', 'HEMAT',
											 'HOSPITAL','PHYSICIAN', 'CARDIO', 'URO'
											 ];											
	PATTERN pMedWords :=  [
											 'DRS', 'D.O.', 'MD', 'M.D.', 'MD.', 'MDS',
											 'CARE',
											 'MEDICAL', 'EMS', 
											 'RESCUE', 'MEMORIAL', 'EMERGENCY',
											 'WHEELCHAIR', 'EMERGENCY', 'FIRST AID', 'THERAPY', 'RX',
											 'SURGICAL', 'SURGERY', 'WELLNESS', 'DETOX', 'CHRONIC', 'DENTAL', 'CANCER', 'RADIATION', 'PAIN','CARDIAC',
											 'HOMECARE','CLINIC'
												];
	PATTERN pExclude := ['NAIL','VET','AUTO', 'TREE', 'LAWN', 'GARDEN', 'CARPET','VETERINARY', 'ANIMAL', 'HOSPITALITY', 'PROPERTY', 'LOCKSMITH', 'SECURITY', 'FOOD', 'LOCKSMITH', 'PAINT', 'VENDING', 'CAREER'];


	RULE rNotSkip := pWord not in pExclude pWspace*;
	RULE rSpecials := (['DR'] pWspace+ pword pWspace*) | (['FIRST'] pWspace* ['AID']); // words with unusual 
	RULE rMedword := (pMedPrefix pword?) | (pWord in pMedWords) | rSpecials;
	RULE rKeepWord:= rMedWord pWspace*;

	RULE rHit := rNotSkip* rKeepWord rNotSkip*;
	RULE rSentence := rHit;
	RULE rMatch := FIRST rHit LAST;

	company_name_rec := record
	 bdid := BusinessesPrep5.bdid;
	 company_name := BusinessesPrep5.company_name;
	end;
  // use rules above to find all company names that look medical...
	medical_companies := parse( dedup(sort(BusinessesPrep5, bdid), bdid), company_name, rMatch, TRANSFORM( company_name_rec, self := left), BEST, NOSCAN);


  SNA.BusinessRecord_Layout checkIsMedical(SNA.BusinessRecord_Layout le, medical_companies ri) := TRANSFORM
		self.isMedical := ri.bdid > 0;
		self 					 := le;
	end;

	BusFinal := join(
													BusinessesPrep5, 
													medical_companies, 
													left.bdid=right.bdid, 
													checkIsMedical(LEFT,RIGHT),
													left outer);	
	// filter for medical / non-medical...
	BusFinalFiltered := case(medicalBusinessFilter,
													'MEDICAL' => BusFinal(isMedical=true),
													'NONMEDICAL' => BusFinal(isMedical=false),
													BusFinal);
	ds_ordered := dedup(BusFinalFiltered, except company_phone, fp, ALL);

	standing := SNA.BusinessStanding_Function(ds_ordered);	
	// filter for business standing...
	busFiltered := case(activeBusinessFilter,
											'ACTIVE' => standing(Standing='A'),
											'INACTIVE' => standing(Standing!='A'),
											standing);
	// final sort for output order...
	finalResultOrder := sort(busFiltered, Degree, Standing, bdid);
	
	// add link count...
	withCounters := project( finalResultOrder, TRANSFORM(SNA.BusinessRecord_Layout, self.link_count := counter, self := left));
	// page output.
	ReturnCount := if(ds_in[1].Options.ReturnCount=0, choosen:all, ds_in[1].Options.ReturnCount);
	StartingRecord := if(ds_in[1].Options.StartingRecord=0, 1, ds_in[1].Options.StartingRecord);	
	paged := choosen(withCounters, ReturnCount, StartingRecord);
	
	SNA.BusinessRecord_Layout addSicCodes(SNA.BusinessRecord_Layout L) := TRANSFORM
		self.sic_codes := JOIN(DATASET(l),Business_header.key_sic_code, KEYED(left.bdid = right.bdid),
												TRANSFORM(iesp.share.t_StringArrayItem, self.value := right.sic_code), atmost(50), keep(iesp.Constants.SNA.MaxSIC_CODES));
		self := L;
	END;
	// only add sic codes to the final paged request...and if it is needed...	
	pagedWithSic := if( includeSIC=true, project(paged, addSicCodes(left)), paged); 
	
	iesp.SNABusinessReport.t_SNABusiness companies(SNA.BusinessRecord_Layout le) := TRANSFORM
	
		self.LinkCount := (string)le.link_count;
		
		self.Cluster.ID := (string)le.cluster_id;
		self.Cluster.Degree := (string)(decimal5_2)le.degree;
		self.Cluster.Name.First := le.cluster_fname;
		self.Cluster.Name.Middle := le.cluster_mname;
		self.Cluster.Name.Last := le.cluster_lname;
		
		self.Associate.LexID := (string)le.did;
		self.Associate.Name.First := le.fname;
		self.Associate.Name.Middle := le.mname;
		self.Associate.Name.Last := le.lname;

		self.Company.Name := le.company_name;
		self.Company.bdid := (string)le.bdid;
		self.Company.ContactScore := (string)le.contact_score;
		self.Company.Address.StreetNumber := le.company_prim_range;
		self.Company.Address.StreetPreDirection := le.company_predir;
		self.Company.Address.StreetName := le.company_prim_name;
		self.Company.Address.StreetSuffix := le.company_addr_suffix;
		self.Company.Address.StreetPostDirection := le.company_postdir;
		self.Company.Address.UnitDesignation := le.company_unit_desig;
		self.Company.Address.UnitNumber := le.company_sec_range;
		self.Company.Address.City := le.company_city;
		self.Company.Address.State := le.company_state;
		self.Company.Address.Zip5 := (string)le.company_zip;
		self.Company.Address.Zip4 := (string)le.company_zip4;
		self.Company.Phone := (string)le.company_phone;
		self.Company.FEIN := (string)le.company_fein;
		self.Company.Standing := le.Standing;
		self.Company.IsMedical := le.ismedical;
		self.Company.SICCodes := le.sic_codes;
		self := [];
	END;
	final_form := PROJECT(pagedWithSic, companies(LEFT));
		
	iesp.SNABusinessReport.t_SNABusinessReportResponse build_esdl_result(DATASET(iesp.SNABusinessReport.t_SNABusiness) le, integer total) := TRANSFORM
		self._Header := [];
		self.Result.InputEcho := ds_in[1].SearchBy;
		self.SubjectTotalCount := total;
		self.Result.Companies := le;
		self.Result := [];
	END;
	res := ROW(build_esdl_result(final_form, count(withCounters)));
	
	output( res, named( 'Results' ) );

ENDMACRO;