/*--SOAP--
<message name="HeaderSource_Service" wuTimeout="300000">
  <part name="header_src_in" type="tns:XmlDataSet" cols="70" rows="25"/>
  <part name="RecordByDate" type="xsd:string"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/> 
	<part name="ApplicationType" type="xsd:string"/>
  <part name="ProbationOverride" type="xsd:boolean"/>
  <part name="LnBranded" type="xsd:boolean"/>
  <part name="SSNMask" type="xsd:string"/>
  <part name="DLMask" type="xsd:string"/>
	<part name="IndustryClassValue" type="xsd:string"/>
  <part name="KeepOldSsns" type="xsd:boolean"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="UccVersion" type="xsd:byte"/>
	<part name="JudgmentLienVersion" type="xsd:byte"/>
	<part name="BankruptcyVersion" type="xsd:byte"/>
	<part name="VehicleVersion" type="xsd:byte"/>
	<part name="VoterVersion" type="xsd:byte"/>
	<part name="DlVersion" type="xsd:byte"/>
	<part name="DeaVersion" type="xsd:byte"/>
	<part name="PropertyVersion" type="xsd:byte"/>
	<part name="CriminalRecordVersion" type="xsd:byte"/>
  <part name="IncludeOccurrences" type="xsd:boolean"/>
  <part name="ExcludeSources" type="xsd:boolean"/>
	<part name="IncludeBlankDOD"	  type="xsd:boolean"/>
	<part name="IncludeSourceList" type="tns:EspStringArray"/>
	<part name="ExcludeDMVPII" type="xsd:boolean"/>
	<part name="IncludeNonRegulatedVehicleSources" type='xsd:boolean'/>
	<part name="IncludeNonRegulatedWatercraftSources" type="xsd:boolean" />
</message>
*/
/*--INFO-- Search by RID, DID, Location or bdid.*/
import Doxie_Raw, Header, Property, Doxie_LN, doxie_crs, Location_Services,
  iesp, DriversV2_Services, Royalty;

export HeaderSource_Service := macro
#constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
//================ Get input ================================
#constant('IsViewSrc',true); //Used in Doxie.header_records.
#option('optimizeLevel',0);
#CONSTANT('UsingKeepSSNs',true);
#constant('IncludeNonDMVSources', true);

doxie.MAC_Header_Field_Declare();
inputOrig := dataset([], Doxie_Raw.Layout_input) : stored('header_src_in',few);
inputi := project(inputOrig, transform(Doxie_Raw.Layout_input,
    self.idtype := StringLib.StringToUpperCase(left.idtype);
    self.section := StringLib.StringToLowerCase(left.section);
    self := left;
));

mod_access := Doxie.compliance.GetGlobalDataAccessModule();

// inclusion/exclusion
includeOccurrences	:= false : stored('IncludeOccurrences');
excludeSources			:= false : stored('ExcludeSources');
includeSources			:= not excludeSources;


//===========================================================
//For did: do NOT project to Layout_references. Keep the address.
outDid := Doxie_Raw.ViewSourceDid(inputi(idtype in ['DID', 'RID']), mod_access, IsCRS,
		BankruptcyVersion,JudgmentLienVersion,UccVersion,DlVersion,VehicleVersion,VoterVersion,DeaVersion,
    CriminalRecordVersion, doxie_crs.str_typeDebtor);

//=========================================================
//For location
outLoc := Location_Services.location_sources(inputi(idtype='LOCATION'));

outRec := Doxie_Raw.Layout_crs_raw;

// Check if we have any filters to apply at this level.
set of string IncludeSourceList := [] : stored('IncludeSourceList');
sfilter := doxie.SourceDocFilter.GetBitmask(IncludeSourceList);
includeLocator 	:= sfilter & doxie.SourceDocFilter.bLOCATOR  > 0;
includeUtility	:= sfilter & doxie.SourceDocFilter.bUTILITY  > 0;
includeDeceased := sfilter & doxie.SourceDocFilter.bDECEASED > 0;

outSectFiltered := 
	PROJECT(outLoc + outDid, TRANSFORM(outRec,
					// the goal here is to mimic the same filter applied in progressive_phone.ContactPlusSearchService.
					SELF.eq_child 			:= if (includeLocator, LEFT.eq_child);
					SELF.tu_child 			:= if (includeLocator, LEFT.tu_child);		
					SELF.targ_child 		:= if (includeLocator, LEFT.targ_child);
					SELF.en_child				:= if (includeLocator, LEFT.en_child);
					SELF.tn_child  			:= if (includeLocator, LEFT.tn_child);
					SELF.finder_child  	:= if (includeLocator, LEFT.finder_child);
					SELF.util_child 		:= if (includeUtility, LEFT.util_child);
					SELF.death_child		:= if (includeDeceased, LEFT.death_child);
					SELF.did 						:= LEFT.did;
					SELF.rid 						:= LEFT.rid;
					SELF.uid 						:= LEFT.uid;
					SELF 								:= []));

outSectAll := IF(sfilter > 0, outSectFiltered, outLoc + outDid);									

outRec combineChildResults(outRec L, outRec R) := transform
	self.did := L.did;
	self.atf_child := (L.atf_child + R.atf_child);
	self.bk_child := (L.bk_child + R.bk_child);
	self.bk_v2_child := (L.bk_v2_child + R.bk_v2_child);
	self.lien_child := (L.lien_child + R.lien_child);
	self.lien_v2_child := (L.lien_v2_child + R.lien_v2_child);
	self.dl_child := (L.dl_child + R.dl_child);
	self.dl2_child := choosen((L.dl2_child + R.dl2_child),DriversV2_Services.layouts.max_dl);
	self.emerge_child := (L.emerge_child + R.emerge_child);
	self.voters_v2_child := (L.voters_v2_child + R.voters_v2_child);
	self.death_child := (L.death_child + R.death_child);
	self.state_death_child := (L.state_death_child + R.state_death_child);
	self.proflic_child := (L.proflic_child + R.proflic_child);
	self.veh_child := (L.veh_child + R.veh_child);
	self.veh_v2_child := (L.veh_v2_child + R.veh_v2_child);
	self.dea_child := (L.dea_child + R.dea_child);
	self.dea_v2_child := (L.dea_v2_child + R.dea_v2_child);
	self.airc_child := (L.airc_child + R.airc_child);
	self.pilot_child := (L.pilot_child + R.pilot_child);
	self.pilotCert_child := (L.pilotCert_child + R.pilotCert_child);
	self.watercraft_child := (L.watercraft_child + R.watercraft_child);
	self.ucc_child := (L.ucc_child + R.ucc_child);
	self.ucc_v2_child := (L.ucc_v2_child + R.ucc_v2_child);
	self.corpAffil_child := (L.corpAffil_child + R.corpAffil_child);
	self.whoIs_child := (L.whoIs_child + R.whoIs_child);
	self.deed_child := (L.deed_child + R.deed_child);
	self.assessor_child := (L.assessor_child + R.assessor_child);
	self.deed2_child := (L.deed2_child + R.deed2_child);
	self.assessor2_child := (L.assessor2_child + R.assessor2_child);
	self.ak_child := (L.ak_child + R.ak_child);
	self.mswork_child := (L.mswork_child + R.mswork_child);
	self.util_child := (L.util_child + R.util_child);
	self.eq_child := (L.eq_child + R.eq_child);
	self.en_child := (L.en_child + R.en_child);
	self.nod_child := (L.nod_child + R.nod_child);
	self.for_child := (L.for_child + R.for_child);
	self.boater_child := (L.boater_child + R.boater_child);
	self.tu_child := (L.tu_child + R.tu_child);
	self.tn_child := (L.tn_child + R.tn_child);
	self.finder_child := (L.finder_child + R.finder_child);
	self.phone_child := (L.phone_child + R.phone_child);
	self.busHdr_child := (L.busHdr_child + R.busHdr_child);
	self.targ_child := (L.targ_child + R.targ_child);
	self.phonesPlus_child := (L.phonesPlus_child  + R.phonesPlus_child );
	self.sanc_child := (L.sanc_child + R.sanc_child);
	self.prov_child := (L.prov_child + R.prov_child);
	self.email_child := (L.email_child + R.email_child);
	self.FBNv2_child := (L.FBNv2_child + R.FBNv2_child);
	self.DOC_people_child := L.DOC_people_child + R.DOC_people_child;
	self.DOCv2_child := L.DOCv2_child + R.DOCv2_child;
	self.SexOffender_people_child := L.SexOffender_people_child + R.SexOffender_people_child;
	self.student_child := L.student_child + R.student_child;
	// self.DOC_events_child := [];
	// self.SexOffender_events_child := [];
	// self.QuickHeader_child := [];
	// self.FLCrash_child := [];
	// self.rid := 0;
	// self.uid := 0;
	// self.src := '';
	self := [];
end;

outSectCombined := rollup(outSectAll, true, combineChildResults(LEFT, RIGHT));

outRec ddp_Sections(outRec L) :=
TRANSFORM
		self.did := L.did;
	self.atf_child := dedup(SORT(L.atf_child, -date_last_seen, RECORD), record);
	self.bk_child := dedup(SORT(L.bk_child, -date_filed, RECORD), record);
	self.bk_v2_child := dedup(SORT(L.bk_v2_child, -date_filed, RECORD), record);
	self.lien_child := dedup(SORT(L.lien_child, -filing_date, -release_Date, RECORD), record);
	self.lien_v2_child := dedup(SORT(L.lien_v2_child, -orig_filing_date, -release_Date, RECORD), record);
	self.dl_child := dedup(SORT(L.dl_child , -lic_issue_date, -expiration_date, RECORD), record);
	self.dl2_child := choosen(dedup(SORT(L.dl2_child , -(dl[1].lic_issue_date), -(dl[1].expiration_date), RECORD), record),DriversV2_Services.layouts.max_dl);
	self.emerge_child := dedup(SORT(L.emerge_child, file_id, -date_last_seen, RECORD), record);
  self.voters_v2_child := dedup(SORT(L.voters_v2_child, -LastDateVote, RECORD), record);
	self.death_child := dedup(SORT(L.death_child, -dod8, RECORD), record);
	self.state_death_child := dedup(SORT(L.state_death_child, -dod, RECORD), record);	
	self.proflic_child := dedup(SORT(L.proflic_child, -date_last_seen, RECORD), record);
	self.veh_child := dedup(SORT(L.veh_child, -dt_last_seen, RECORD), record);
	self.veh_v2_child := dedup(SORT(L.veh_v2_child, -(unsigned1) is_current, -iteration_key, RECORD), record);
	self.dea_child := dedup(SORT(L.dea_child, -date_last_reported, RECORD), record);
	self.dea_v2_child := dedup(SORT(L.dea_v2_child, dea_registration_number, RECORD), record);
	self.airc_child := dedup(SORT(L.airc_child, -date_last_seen, RECORD), record);
	self.pilot_child := dedup(SORT(L.pilot_child, -date_last_seen, RECORD), record);
	self.pilotCert_child := dedup(SORT(L.pilotCert_child, -date_last_seen, RECORD), record);
	self.watercraft_child := dedup(SORT(L.watercraft_child, -date_last_seen, RECORD), record);
	self.ucc_child := dedup(SORT(L.ucc_child, -orig_filing_date, RECORD), record);
	self.ucc_v2_child := dedup(SORT(L.ucc_v2_child, -orig_filing_date, RECORD), record);
	self.corpAffil_child := dedup(SORT(L.corpAffil_child, -filing_date, RECORD), record);
	self.whoIs_child := dedup(SORT(L.whoIs_child, -date_last_seen, RECORD), record);
	self.deed_child := dedup(SORT(if(doxie.DataRestriction.Fares,L.deed_child(ln_fares_id[1]<>'R'),L.deed_child), -process_date, RECORD), record);
	self.assessor_child := dedup(SORT(if(doxie.DataRestriction.Fares,L.assessor_child(ln_fares_id[1] <>'R'), L.assessor_child), -process_date, RECORD), record);
	self.deed2_child := dedup(SORT(L.deed2_child, -sortby_date, RECORD), record);
	self.assessor2_child := dedup(SORT(L.assessor2_child, -sortby_date, RECORD), record);
	self.ak_child := dedup(SORT(L.ak_child, -process_date, RECORD), record);
	self.mswork_child := dedup(SORT(L.mswork_child, -date_last_seen, RECORD), record);
	self.util_child := dedup(SORT(L.util_child, -record_date,lname,fname,mname,name_suffix,title,dob,
																							st,county,zip4,zip,p_city_name,prim_name,
																							addr_suffix,predir,prim_range,postdir,unit_desig,sec_range,
																							util_type,date_first_seen,connect_date,
																							date_added_to_exchange
															 ),
																record_date,lname,fname,mname,name_suffix,title,dob,
																st,county,zip4,zip,p_city_name,prim_name,
																addr_suffix,predir,prim_range,postdir,unit_desig,sec_range,
																util_type,date_first_seen,connect_date,
																date_added_to_exchange
												  );
	
		Header.Layout_EQ_src_dates t(Header.Layout_EQ_src_dates a , 
		                             Header.Layout_EQ_src_dates b):= transform
			IsABig := a.date_last_seen > b.date_last_seen ;
			self 	 := if(IsABig ,a ,b);
		 end;
		 
	self.eq_child := rollup(sort(L.eq_child, -current_address_date_reported[3..6],
															 -current_address_date_reported[1..2],RECORD), 
													t(left,right),
							            RECORD,EXCEPT date_last_seen,date_first_seen,cid);	
													
	self.en_child := dedup(SORT(L.en_child,  -date_last_seen, RECORD), record);
	self.nod_child := dedup(SORT(if(doxie.DataRestriction.Fares,dataset([],iesp.foreclosure.t_ForeclosureReportRecord),L.nod_child), -FilingDate, RECORD), record);
	self.for_child := dedup(SORT(if(doxie.DataRestriction.Fares,dataset([],Property.Layout_Fares_Foreclosure),L.for_child), -process_date, RECORD), record);
	self.boater_child := dedup(SORT(L.boater_child, -date_last_seen, RECORD), record);
	self.tu_child := dedup(SORT(L.tu_child, -file_date, RECORD), record);
	self.tn_child := dedup(SORT(L.tn_child, -dt_last_seen, RECORD), record);
	self.finder_child := dedup(SORT(L.finder_child, -dt_last_seen, RECORD), record);
	self.phone_child := dedup(SORT(L.phone_child, -dt_last_seen, RECORD), record);
	self.busHdr_child := dedup(SORT(L.busHdr_child, -dt_last_seen, RECORD), record);
	self.targ_child := dedup(SORT(L.targ_child, -dt_last_seen, RECORD), record); 
	self.phonesPlus_child := dedup(SORT(L.phonesPlus_child, RECORD), record);    // no date field to sort by
	self.sanc_child := dedup(SORT(L.sanc_child, -date_last_seen, RECORD), record);
	self.prov_child := dedup(SORT(L.prov_child, RECORD), record);   // no date field to sort by
	self.email_child := dedup(SORT(L.email_child, -latest_orig_login_date, RECORD),record);
	self.FBNv2_child := dedup(SORT(L.FBNv2_child, -FilingDate, RECORD), record); 
	self.DOC_people_child := dedup(SORT(L.DOC_people_child, -case_date, RECORD), record);
	self.DOCv2_child := dedup(SORT(L.DOCv2_child, -CaseFilingDate, RECORD), record);
	self.SexOffender_people_child := dedup(SORT(L.SexOffender_people_child, RECORD), record);
	self.student_child := dedup(SORT(L.student_child, RECORD), record);
	// self.DOC_events_child := [];
	// self.SexOffender_events_child := [];
	// self.QuickHeader_child := [];
	// self.FLCrash_child := [];
	// self.rid := 0;
	// self.uid := 0;
	// self.src := '';
	self := [];
END;

Sections_ddpd := PROJECT(outSectCombined, ddp_Sections(LEFT));


// =-=-=-=-=-=-=-=-=-=-=-= RoyaltySet =-=-=-=-=-=-=-=-=-=-=-=
doxie_crs.layout_property_ln asses_child(Doxie_LN.layout_assessor_records l):= transform
self := l;
self :=[];
END;

asses_table := normalize(Sections_ddpd, left.assessor_child,asses_child(right));

doxie_crs.layout_property_ln deeds_child(doxie_ln.layout_deed_records l):= transform
self := l;
self :=[];
END;

deeds_table := normalize(Sections_ddpd, left.deed_child,deeds_child(right));

property_table :=dedup(sort(asses_table + deeds_table,ln_fares_id),ln_fares_id);

doxie_crs.layout_foreclosure_report foreclosure_child(Property.Layout_Fares_Foreclosure l):=transform
self := l;
self :=[];
END;

foreclosure_table :=normalize(Sections_ddpd, left.for_child,foreclosure_child(right));

Royalty.RoyaltyFares.MAC_SetA(property_table, foreclosure_table, royalties);

// =-=-=-=-=-=-=-=-=-=-=-= Occurrences =-=-=-=-=-=-=-=-=-=-=-=
ds_occur := Doxie_Raw.Occurrence.fromHSS(Sections_ddpd);

// =-=-=-=-=-=-=-=-=-=-=-=-= Outputs =-=-=-=-=-=-=-=-=-=-=-=-=
parallel(
	if(includeSources,			output(Sections_ddpd,	named('Sources'))),
	if(includeSources,			output(royalties,			named('RoyaltySet'))),
	if(includeOccurrences,	output(ds_occur,			named('Occurrences')))
);

ENDMACRO;
//HeaderSource_Service()