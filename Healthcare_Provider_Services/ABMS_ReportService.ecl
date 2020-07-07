/*--SOAP--
<message name="ABMS_SearchService">
	<!-- COMPLIANCE SETTINGS -->
	<part name="ABMSReportRequest" type="tns:XmlDataSet" cols="80" rows="30" />

</message>
*/

import iesp, AutoStandardI;

export ABMS_ReportService := MACRO
	ds_in := DATASET ([], iesp.abms.t_ABMSReportRequest) : STORED('ABMSReportRequest', FEW);
	
	first_row := ds_in[1] : INDEPENDENT;	
	iesp.ECL2ESP.Marshall.Mac_Set(first_row.options);
	iesp.ECL2ESP.SetInputUser(first_row.user);	  
	iesp.ECL2ESP.SetInputReportBy (ROW (first_row.reportBy, transform (iesp.bpsreport.t_BpsReportBy, Self := Left, Self := [])));
	unsigned1 PenaltThreshold := 10 :stored('PenaltyThreshold');
	#stored ('PenaltThreshold', PenaltThreshold);	
	doxie.MAC_Header_Field_Declare();
	Healthcare_Header_Services.Layouts.common_runtime_config buildConfig():=transform
		self.MaxResults := first_row.options.MaxResults;
		self.DRM := first_row.user.DataRestrictionMask;
		self.glb_ok := ut.glb_ok ((integer)first_row.user.GLBPurpose);
		self.dppa_ok := ut.dppa_ok((integer)first_row.user.DLPurpose);
		self.glb := (integer)first_row.user.GLBPurpose;
		self.dppa := (integer)first_row.user.DLPurpose;
		self.IncludeAlsoFound := first_row.options.IncludeAlsoFound;
		self.includeCustomerData := true;
		self.hasFullNCPDP:=false;
			end;
	cfgData:=dataset([buildConfig()]);

	convertedInput := project(first_row.reportBy,Healthcare_Provider_Services.ABMS_Transforms.convertIESPtoAKInput(left,first_row.Options.includeCareer,first_row.Options.includeEducation,first_row.Options.includeProfessionalAssociations,GLB_Purpose,DPPA_Purpose));
	recs := Healthcare_Provider_Services.ABMS_Records(GLB_Purpose,DPPA_Purpose,PenaltThreshold).getRecords(dataset([convertedInput],Healthcare_Provider_Services.ABMS_Layouts.autokeyInput),cfgdata);	

	iesp.abms.t_ABMSReportResponse format() := transform
				string q_id := '' 	 : stored ('_QueryId');
				string t_id := '' 	 : stored ('_TransactionId');
				self._Header         := ROW ({0, '', q_id, t_id, [],[]}, iesp.share.t_ResponseHeader);
				self.SearchBy				 := first_row.reportBy;
				self.RecordCount 		 := count(recs);
				self.Records := choosen(project(Recs,iesp.abms.t_ABMSResults),iesp.Constants.HPR.Max_Large_Cnt);
	end;

	Results := dataset([format()]);

	output(Results, named('Results'));
	
ENDMACRO;
