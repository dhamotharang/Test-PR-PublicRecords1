import iesp;
/*--SOAP--
<message name="CriminalRecords::CrimImageSeachService">
	<!-- Keyed Fields -->
  <part name="DID" 							 type="xsd:string" />
  <part name="SexualOffenderOnly type="xsd:boolean" />
	<!-- XML Input -->
	<part name="CriminalImageReportRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/
import iesp,doxie;

EXPORT ReportService := MACRO
 #CONSTANT ('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
	#onwarning(4207, ignore);
	
	rec_in		:= iesp.criminalimagereport.t_CriminalImageReportRequest;
	ds_in			:= dataset([], rec_in) : STORED('CriminalImageReportRequest', few);
	first_row	:= ds_in[1] : INDEPENDENT;
	iesp.ECL2ESP.SetInputBaseRequest(first_row);

	//set main search criteria:
	Report_By := global(first_row.ReportBy);
	iesp.ECL2ESP.SetInputName (Report_By.Name);
	iesp.ECL2ESP.SetInputReportBy(row(first_row.ReportBy,transform(iesp.bpsreport.t_BpsReportBy,self:=left,self:=[])));
			
	//set options:
	report_opt := GLOBAL(first_row.Options);
	#stored('SexualOffenderOnly', first_row.options.SexualOffenderOnly);

  boolean sexualOffenderOnly := false : stored('SexualOffenderOnly'); 	

	#CONSTANT('useOnlyBestDID',true);
	
	dids := doxie.Get_Dids();
	
	report_recs := CriminalImage_Services.ReportRecords(dids, sexualOffenderOnly); 
	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(report_recs, results, iesp.criminalimagereport.t_CriminalImageReportResponse, Records, false);
	OUTPUT(results,NAMED('Results'));	
ENDMACRO;