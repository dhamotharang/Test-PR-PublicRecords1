/*--SOAP--
<message name="Discpl_Batch_Service">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/> 
	<part name="DataRestrictionMask"   type="xsd:string"/>
	<part name="DataPermissionMask"    type="xsd:string"/>
	<part name="ApplicationType"     	type="xsd:string"/>
	<part name="MaxResults" type="xsd:unsignedInt"/> 
	<part name="PenaltThreshold" type="xsd:unsignedInt"/>
</message>
*/

//uses licnum,upin,taxid
import Autokey_batch,BatchServices,doxie,doxie_files,codes,AutoStandardI,Healthcare_Header_Services,ut;
export Discpl_Batch_Service := MACRO

  ipl := TRUE :STORED('IncludeSanctions');
	unsigned2 inputPT := 10 : STORED('PenaltThreshold');
	pt := if(inputPT>0,inputPT,10);
	maxResultsPerRow := 100 : STORED('MaxResults');
	gm := AutoStandardI.GlobalModule();
  	
	batch_view := prof_LicenseV2_Services.Prof_Lic_Raw.Batch_View;
	pl_rec := Batch_View.pl_rec;
	id_rec := Batch_View.id_rec;
		
  //**** INPUT TRANSFORM
	ds_batch_in_1 := DATASET([],pl_rec) : STORED('batch_in');
	ds_batch_in   := Batch_View.format_input(ds_batch_in_1);
	
	//Payload
	batchRows := project(ds_batch_in,transform(Healthcare_Header_Services.Layouts.autokeyInput,self:=left;self:=[]));
	Healthcare_Header_Services.Layouts.common_runtime_config buildConfig():=transform
		 self.penalty_threshold := pt;
		 self.glb_ok :=  ut.glb_ok (gm.GLBPurpose);
		 self.dppa_ok := ut.dppa_ok(gm.DPPAPurpose);
		 self.glb := gm.GLBPurpose;
		 self.dppa := gm.DPPAPurpose;
		 self.drm := gm.DataRestrictionMask;	
		 self.includeSanctions:=true;
		// self:=[];Do not uncomment otherwise the default values will not get set.
	end;
	cfg:=dataset([buildConfig()]);
	//Handle taxid's
	rawdata := Healthcare_Header_Services.Records.getRecordsRawDoxie(batchRows(comp_name<>'' or name_last<>''),cfg);
	// filterData := rawdata(record_penalty<=pt);//Lose records that are over the penalty
	filterResponse := rawdata(exists(legacysanctions));

	layout_w_penalt := record
	  Doxie.layout_inBatchMaster.acctno;
		unsigned1 penalt := 0;
		doxie.ingenix_sanctions_module.layout_ingenix_sanctions_report;
	END;
	layout_NPI := record
	  Doxie.layout_inBatchMaster.acctno;
		unsigned1 penalt := 0;
		Ingenix_NatlProf.key_NPI_providerid.npi;
	END;

	layout_w_penalt fmtOutput(Healthcare_Header_Services.Layouts.autokeyInput l, Healthcare_Header_Services.Layouts.layout_LegacySanctions r) := TRANSFORM
		self.acctno := r.acctno;
		self.SANC_ID := (string)r.SANC_ID;
		self.DID := r.DID;
		self.Prov_Clean_fname := r.Prov_Clean_fname;
		self.Prov_Clean_mname := r.Prov_Clean_mname;
		self.Prov_Clean_lname := r.Prov_Clean_lname;
		self.Prov_Clean_name_suffix := r.Prov_Clean_name_suffix;
		self.ProvCo_Address_Clean_prim_range := r.ProvCo_Address_Clean_prim_range;
		self.ProvCo_Address_Clean_predir := r.ProvCo_Address_Clean_predir;
		self.ProvCo_Address_Clean_prim_name := r.ProvCo_Address_Clean_prim_name;
		self.ProvCo_Address_Clean_addr_suffix := r.ProvCo_Address_Clean_addr_suffix;
		self.ProvCo_Address_Clean_postdir := r.ProvCo_Address_Clean_postdir;
		self.ProvCo_Address_Clean_unit_desig := r.ProvCo_Address_Clean_unit_desig;
		self.ProvCo_Address_Clean_sec_range := r.ProvCo_Address_Clean_sec_range;
		self.ProvCo_Address_Clean_p_city_name := r.ProvCo_Address_Clean_p_city_name;
		self.ProvCo_Address_Clean_v_city_name := r.ProvCo_Address_Clean_p_city_name;
		self.ProvCo_Address_Clean_st := r.ProvCo_Address_Clean_st;
		self.ProvCo_Address_Clean_zip := r.ProvCo_Address_Clean_zip;
		self.ProvCo_Address_Clean_zip4 := '';
		self.ProvCo_Address_Clean_geo_lat := r.ProvCo_Address_Clean_geo_lat;
		self.ProvCo_Address_Clean_geo_long := r.ProvCo_Address_Clean_geo_long;
		self.bdid := r.bdid;
		self.SANC_BUSNME := r.SANC_BUSNME;
		self.SANC_DOB := r.SANC_DOB;
		self.SANC_TIN := r.SANC_TIN;
		self.SANC_UPIN := r.SANC_UPIN;
		self.npi := '';
		self.NPPESVerified := r.NPPESVerified;
		self.SANC_PROVTYPE := r.SANC_PROVTYPE;
		self.SANC_SANCDTE_form := r.SANC_SANCDTE_form;
		self.SANC_SANCDTE := r.SANC_SANCDTE;
		self.SANC_LICNBR := r.SANC_LICNBR;
		self.SANC_SANCST := r.SANC_SANCST;
	  self.SANC_BRDTYPE := r.SANC_BRDTYPE;	
		self.SANC_SRC_DESC := r.SANC_SRC_DESC;
		self.SANC_TYPE := r.SANC_TYPE;
		self.SANC_TERMS := r.SANC_TERMS;
		self.SANC_REAS := r.SANC_REAS;
		self.SANC_COND := r.SANC_COND;
		self.SANC_FINES := r.SANC_FINES;		
		self.SANC_UPDTE_form := r.SANC_UPDTE_form;
		self.SANC_UPDTE := r.SANC_UPDTE;
		self.date_first_reported := r.date_first_reported;
		self.date_last_reported := r.date_last_reported;
		self.SANC_REINDTE_form := r.SANC_REINDTE_form;
		self.SANC_REINDTE := r.SANC_REINDTE;
		self.SANC_FAB := if(r.SANC_FAB='TRUE','Y','N');
		self.SANC_UNAMB_IND := if(r.SANC_UNAMB_IND='TRUE','Y','N');
		self.process_date := r.process_date;
		self.date_first_seen := r.date_first_seen;
		self.date_last_seen := r.date_last_seen;
		self.sanc_grouptype := r.sanc_grouptype;
		self.sanc_subgrouptype := r.sanc_subgrouptype;
		self.sanc_priority := r.sanc_priority;
		self := [];
	end;

	formatResponse := join(batchRows,filterResponse.LegacySanctions,(integer)left.acctno=(integer)right.acctno,fmtOutput(left,right),keep(maxResultsPerRow));
	getNpi := dedup(sort(project(filterResponse,transform(layout_NPI,self.acctno:=left.acctno;self.penalt:=left.record_penalty;self.npi:=left.NPIRaw[1].NPIInformation.NPINumber))(npi<>''),acctno,penalt,NPI),acctno);
	addNPI := sort(join(formatResponse,getNpi,left.acctno=right.acctno,transform(layout_w_penalt,self.penalt:=right.penalt;self.npi:=right.npi;self:=left),left outer),acctno,penalt);
	final := sort(dedup(sort(addNPI,acctno,record),record),acctno,penalt,sanc_id);
	// DEBUGS...:
	// OUTPUT(pt, NAMED('pt'));
	// OUTPUT(batchRows, NAMED('batchRows'));
	// OUTPUT(rawdata,  NAMED('rawdata'));
	// OUTPUT(filterData, NAMED('filterData'));
	// OUTPUT(filterResponse, NAMED('filterResponse'));
	// OUTPUT(formatResponse,  NAMED('formatResponse'));
	// OUTPUT(final,  NAMED('final'));
	
  pre_result := SORT(final,acctno,penalt,-sanc_sancdte_form,-sanc_updte_form,record);		
	ut.mac_TrimFields(pre_result, 'pre_result', result);
		
	OUTPUT(result, NAMED('RESULTS'));	
		
ENDMACRO;		
// Discpl_Batch_Service();