/*--SOAP--
<message name="SourceService">

	<!-- COMPLIANCE/USER SETTINGS -->
	<part name="GLBPurpose" type="xsd:byte"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="ApplicationType" type="xsd:string"/>
	<part name="SSNMask" type="xsd:string"/>

	<!-- Testing SEARCH FIELDS -->
	<part name="UltID" type="xsd:string"/>
	<part name="OrgID" type="xsd:string"/>
  <part name="SeleID" type="xsd:string"/>
	<part name="ProxID" type="xsd:string"/>
	<part name="PowID" type="xsd:string"/>
	<part name="EmpID" type="xsd:string"/>
	<part name="DotID" type="xsd:string"/>
	<part name="Source" type="xsd:string"/>
	<part name="Section" type="xsd:string"/>
	<part name="IDvalue" type="xsd:string"/>
	<part name="IDtype" type="xsd:string"/>

	<part name="SourceDocFetchLevel" type="xsd:string"/>  //values['S','D','C','W','P','O','U',''

	<!-- ADDITIONAL OPTIONS -->

	<!-- XML REQUEST -->
	<part name="TopBusinessSourceDocRequest" type="tns:XmlDataSet" cols="80" rows="30"/>

</message>
*/

/*--INFO-- This service produces a set of source documents for a report.*/
import iesp, TopBusiness_Services, doxie, AutoStandardI;
export SourceService() := macro
#constant('NoDeepDive', true);
#constant ('CaseNumber', '');

// Get XML input

	rec_in := iesp.TopBusinessSourceDoc.t_TopBusinessSourceDocRequest;
	ds_in := dataset([],rec_in) : stored('TopBusinessSourceDocRequest',few);
	first_row := ds_in[1] : independent;

	// Set some base options, including DPPA, GLBA, DRM, etc.
	iesp.ECL2ESP.SetInputBaseRequest(first_row);
	iesp.ECL2ESP.SetInputUser (first_row.User);
	#stored('LnBranded',first_row.User.LnBranded);

	// Test Soap Params
	string s_DotID  := '' 	: stored('DotID');
	string s_EmpID  := '' 	: stored('EmpID');
	string s_PowID  := '' 	: stored('PowID');
	string s_ProxID := '' 	: stored('ProxID');
	string s_SeleID := '' 	: stored('SeleID');
	string s_OrgID  := '' 	: stored('OrgID');
	string s_UltID  := '' 	: stored('UltID');
	string2 s_Source 	:= '' 	: stored('Source');
	string25 s_Section := ''	: stored('Section');
	string100 s_IDvalue := '' : stored('IDvalue');
	string20 s_IDtype := '' 	: stored('IDtype');


	// Create Test dataset
	iesp.TopBusinessSourceDoc.t_TopBusinessSourceDocBy initialize_Soap() := transform
		 self.BusinessIds.DotID  := (unsigned6) s_dotid;
	   self.BusinessIds.EmpID  := (unsigned6) s_empid;
		 self.BusinessIds.PowID  := (unsigned6) s_powid;
		 self.BusinessIds.ProxID := (unsigned6) s_proxid;
		 self.BusinessIds.SeleID := (unsigned6) s_seleid;
		 self.BusinessIds.OrgID  := (unsigned6) s_orgid;
		 self.BusinessIds.UltID  := (unsigned6) s_ultid;
		 self.Source := s_Source;
		 self.Section := s_Section;
		 self.IdValue := s_IDvalue;
     self.IdType := s_IDtype;
		 self := [];
	end;

	soap_in_ds := dataset([initialize_Soap()]);

	// Store search options
	options_by := global(first_row.Options);

	// Get main search criteria
	dataset(iesp.TopBusinessSourceDoc.t_TopBusinessSourceDocRequest) stored_searchby_docs :=
		dataset([],iesp.TopBusinessSourceDoc.t_TopBusinessSourceDocRequest) : stored('TopBusinessSourceDocRequest',few);

	searchby_docs_dset := NORMALIZE(ds_in,LEFT.SearchBy,TRANSFORM(iesp.TopBusinessSourceDoc.t_TopBusinessSourceDocBy,
																																									SELF := RIGHT,
																																									SELF := []));
	// Get back the search options
	TopBusiness_Services.SourceService_Layouts.InputLayout initialize(iesp.TopBusinessSourceDoc.t_TopBusinessSourceDocBy l) := transform
		self.acctno := 'SINGLE';
		self := l;
	end;

	inputs := project(searchby_docs_dset+soap_in_ds,initialize(left));

	TopBusiness_Services.SourceService_Layouts.OptionsLayout search_options() := TRANSFORM
		self.app_type  		:= AutoStandardI.GlobalModule().ApplicationType;
		self.ssn_mask  		:= AutoStandardI.GlobalModule().ssnmask;
		self.fetch_level 	:= topbusiness_services.functions.fn_fetchLevel(options_by.SourceDocFetchLevel);
    self.IncludeVendorSourceB := false;
    self.IncludeAssignmentsAndReleases := false;
    
    
	end;

	options := row(search_options());

	mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());
	initial_results := TopBusiness_Services.SourceService_Records(inputs,mod_access,options);

	// Project to remove the acctno from the SourceService_Records output
	projected_results := project(initial_results,
                               transform(iesp.topbusinesssourcedoc.t_TopBusinessSourceDocRecord,
                                           self := left,
                                           self := []));

	iesp.topbusinesssourcedoc.t_TopBusinessSourceDocResponse format() := transform
	  proj_cnt := count(projected_results);
		self._Header     := iesp.ECL2ESP.GetHeaderRow(),
		self.RecordCount := proj_cnt;
	  self.Records     := if (proj_cnt > 0, projected_results[1])
  end;

	results := dataset([format()]);

	output(results,named('Results'));

endmacro;
