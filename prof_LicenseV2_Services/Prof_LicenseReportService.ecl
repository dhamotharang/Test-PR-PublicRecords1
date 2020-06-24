/*--SOAP--
<message name="ProfessionalLicenseReportRequest">
  <part name="UniqueId" type="xsd:string"/>
  <part name="LicenseNumber" type="xsd:string"/>
  <part name="SanctionID" type="xsd:string"/>
  <part name="DID" type="xsd:string"/>
  <part name="BDID" type="xsd:string"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte" />
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="ApplicationType"     	type="xsd:string"/>
	<part name="IncludeProfessionalLicenses" type='xsd:boolean' />
	<part name="IncludeSanctions" type='xsd:boolean' />
	<part name="IncludeProviders" type="xsd:boolean"/>
  <part name="MaxResults" type="xsd:unsignedInt"/>
 </message>
*/
/*--INFO-- This service pulls from the Professional License and ingenix files.*/

import prof_licensev2_services, doxie, ingenix_natlprof, Health_Provider_Services, Healthcare_Header_Services, ut;

export Prof_LicenseReportService := MACRO

	input_params := AutoStandardI.GlobalModule();
	tempmod := module(project(input_params,prof_licensev2_services.ProfLicSearch_Ids.params,opt))		                
	
	  
		export unsigned6 bdid_value := (unsigned6) AutoStandardI.InterfaceTranslator.bdid_value.val(project(input_params,
                                    AutoStandardI.InterfaceTranslator.bdid_value.params));                        
    export unsigned6 did_value  := (unsigned6) AutoStandardI.InterfaceTranslator.did_value.val(project(input_params,
                                      AutoStandardI.InterfaceTranslator.did_value.params));                      

	
		shared string20	  L_Number := '' 		 : stored('LicenseNumber');
		export string20   License_Number :=  stringlib.stringtouppercase(l_number);	
		
		export unsigned6 	Sanc_id := 0 						 : stored('SanctionID');
		shared string17 unique_id := '' : stored('Uniqueid');
		shared boolean incl_prof_lic0 := false : stored('IncludeProfessionalLicenses');
		shared boolean incl_sanc0 := false : stored('IncludeSanctions');
		shared boolean incl_prov0 := false : stored('IncludeProviders');
		shared first_two:=unique_id[1..2];
		export unsigned6 unique_id_num :=(unsigned6)  unique_id[3..];
		shared is_sanc := incl_sanc0 and first_two = 'PS';
		shared is_prov := incl_prov0 and (first_two = 'PR' or did_value<> 0 or license_number <> '');
		shared is_prof := incl_prof_lic0 and (first_two = 'PL' or did_value<> 0 or bdid_value <> 0 or license_number <> '');
		export set of unsigned6 	Sanc_id_set := if(is_sanc,[unique_id_num],[]);
		export unsigned6  ProviderId := if(is_sanc and unique_id_num > 100000000,(integer)(((STRING)unique_id_num)[1..(length((string)unique_id_num)-3)]),unique_id_num);
		export unsigned6  prolic_seq_num := if(is_prof,unique_id_num,0);
		export boolean include_prof_lic := is_prof;
		export boolean include_sanc := is_sanc or incl_sanc0;
		export boolean include_prov := is_prov or incl_prov0;
		export boolean is_search := FALSE;
	END;

	ids_prolic := prof_LicenseV2_Services.ProfLicSearch_Ids.val_prolic(tempmod);
  ids_Sanc := prof_LicenseV2_Services.ProfLicSearch_Ids.val_sanc(tempmod);
	ids_prov := prof_LicenseV2_Services.ProfLicSearch_Ids.val_prov(tempmod);
	

	Prolic_r   := prof_LicenseV2_Services.Prof_Lic_raw.source_view.									
										by_ids(ids_prolic);

	Healthcare_Header_Services.Layouts.common_runtime_config buildConfig():=transform
		 self.glb_ok :=  ut.glb_ok (input_params.GLBPurpose);
		 self.dppa_ok := ut.dppa_ok(input_params.DPPAPurpose);
		 self.glb :=  input_params.GLBPurpose;
		 self.dppa := input_params.DPPAPurpose;
		 self.drm := input_params.DataRestrictionMask;	
		 self.includeSanctions:=true;
		// self:=[];Do not uncomment otherwise the default values will not get set.
	end;
	cfg:=dataset([buildConfig()]);
	
	Provider_raw := doxie.ING_provider_report_records(ids_prov,true,,cfg);//Always get this as it is needed for Sanctions.
	//So what if the initial search was a boolean search which is using the backfill keys????  
	//We need to hit the new backfill to vendor id xref key to get the vendor id then hit the HC Individual header vendorid key to get the header lnpid
 
 //At least one name is always expected to be populated if data exists
 provider_data_exists := exists(Provider_raw[1].name);
 
	tmp_rec := record
			Health_Provider_Services.Key_HealthProvider_VEN.InputLayout_Batch;
	end;
	checkBackfill := join(ids_prov,ingenix_natlprof.key_pid_gk,left.ProviderId=right.pid,transform(tmp_rec,
																			self.Reference := 1 ;self.VENDOR_ID := right.group_key;
																			self.SRC := Healthcare_Header_Services.Constants.SRC_SELECTFILE;
																			self.MAINNAME := '';self.FNAME := '';self.MNAME := '';self.LNAME := '';
																			self.SNAME := '';self.GENDER := '';self.DOB := 0;self:=[]),keep(100), limit(0));
	getProviderIDBackfill := dedup(Health_Provider_Services.Key_HealthProvider_VEN.ScoredFetch_Batch(checkBackfill,true),record,all);
	newlayout  := Healthcare_Header_Services.Layouts.autokeyInput;
	searchBy := project(getProviderIDBackfill, transform(newlayout,self.acctno:='1';self.providersrc := Healthcare_Header_Services.Constants.SRC_HEADER;self.ProviderId := left.lnpid;self:=[]));
	rawData := Healthcare_Header_Services.Records.getRecordsRawDoxieIndividual(searchBy,cfg);
	fmtData := Healthcare_Header_Services.Records.fmtRecordsLegacyReport(rawData,cfg);
	Provider_data := if(provider_data_exists,Provider_raw,fmtData);
	Provider_r := Provider_data(tempmod.include_prov);
	
	out_rec := doxie.ingenix_sanctions_module.layout_ingenix_sanctions_report;
  Sanc_raw := project(Provider_data.sanction_data,transform(out_rec,SELF.SANC_ID:=(string)left.SANC_ID;self:=left;self:=[]))(tempmod.include_sanc);
	//What if they get a gap sanction back and come looking for it....
	//Build bogus datasets and pass in the PS value to get the sanction data
	ds1 := project(dataset([{'1'}],{string acctno}),transform(Healthcare_Header_Services.Layouts.autokeyInput,self.providerid:=tempmod.Sanc_id,self.providersrc:=Healthcare_Header_Services.Constants.SRC_SANC;self:=left;self:=[];));
	ds2 := project(dataset([{'1'}],{string acctno}),transform(Healthcare_Header_Services.Layouts.sanc_lookup_rec,self.SANC_ID:=tempmod.Sanc_id;self:=left;self:=[];));
	rslt := Healthcare_Header_Services.Datasource_SelectFile.getSanctionsCommon(ds1,ds2,cfg);
	fmtRslt := Healthcare_Header_Services.Records.fmtRecordsLegacyReport(project(rslt,transform(Healthcare_Header_Services.Layouts.CombinedHeaderResultsDoxieLayout, self :=left;self:=[])),cfg);
	Sanc_gap := project(fmtRslt.sanction_data,transform(out_rec,SELF.SANC_ID:=(string)left.SANC_ID;self:=left;self:=[]))(tempmod.include_sanc);
	Sanc_r := Sanc_raw+Sanc_gap;
	Sanc_Filter := if (tempmod.Sanc_id>0,Sanc_r(sanc_id=(string)tempmod.Sanc_id),Sanc_r);
 	
  //ids_Sanc
	output(Prolic_r,named('Proflic_Results'));
	output(Provider_r,named('Provider_Results'));
	output(Sanc_Filter,named('Sanc_Results'));

ENDMACRO;									
									

									