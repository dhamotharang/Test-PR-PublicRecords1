/*--SOAP--
<message name="IdentityScreeningRequest">  
	<part name="IdentityScreeningRequest" type="tns:XmlDataSet" cols="80" rows="30" />
 </message>
*/
IMPORT IESP,Healthcare_Shared,Healthcare_Header_Services,Healthcare_Ganga, ut;

EXPORT SearchService := MACRO
	ds_in := DATASET ([], iesp.healthcare_identity.t_HealthCareIdentityScreeningRequest): STORED('HealthCareIdentityScreeningRequest', FEW);
	first_row := ds_in[1] : INDEPENDENT;
	
	SearchCriteria := first_row.SearchBy;
	SearchOptions := first_row.Options;
	

	Healthcare_Ganga.Layouts.IdentityInput getCriteria() := TRANSFORM
		self.acctno := '1';
		self.EntityType := SearchCriteria.EntityType;
		self.RecordIdentifier := SearchCriteria.RecordIdentifier;
		self.FirstName := SearchCriteria.Individual.Name.First;
		self.LastName := SearchCriteria.Individual.Name.Last;
		self.DoB := iesp.ecl2esp.t_DateToString8(SearchCriteria.Individual.DOB);
		self.SSN := SearchCriteria.Individual.SSN;
		self.NPI := SearchCriteria.NPI;
		self.StreetAddress1 := SearchCriteria.Address.StreetAddress1;
		self.StreetAddress2 := SearchCriteria.Address.StreetAddress2;
		self.City := SearchCriteria.Address.City;
		self.State := SearchCriteria.Address.State;
		self.Zip5 := SearchCriteria.Address.Zip5;
		self.Zip4 := SearchCriteria.Address.Zip4;
		self.LegalName := SearchCriteria.Business.LegalName;
		self.BusinessName := SearchCriteria.Business.Name;
		self.TaxID := SearchCriteria.Business.TaxID;
		self.RequestDateTime := SearchCriteria.RequestDateTime;
		self := [];
	END;
	
	dsCriteria := DATASET([getCriteria()]);
	Healthcare_Header_Services.Layouts.common_runtime_config buildConfig():=transform	 
		GLB := (integer)first_row.user.GLBPurpose;
		DL := (integer)first_row.user.DLPurpose;
		self.glb_ok := ut.glb_ok (GLB);
		self.dppa_ok := ut.dppa_ok (DL);
		self.DRM := first_row.user.DataRestrictionMask;		
		self.IncludeSpecialties  := Healthcare_Shared.Constants.CFG_False;
		self.IncludeLicenses  := Healthcare_Shared.Constants.CFG_False;
		self.IncludeResidencies  := Healthcare_Shared.Constants.CFG_False;
		//self:=[];Do not uncomment otherwise the default values will not get set.
	end;
	cfg := dataset([buildConfig()]);

	rawdata := Healthcare_Ganga.Records.getAllRecords(dsCriteria,cfg);
	results := join(dsCriteria, rawdata, left.acctno = right.acctno, Healthcare_Ganga.Transforms.xformWeb(left, right), left outer);

	output(results, named('Results'));

ENDMACRO;