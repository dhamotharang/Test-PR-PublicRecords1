/*--SOAP--
<message name="IdentityScreeningRequest">  
	<part name="IdentityScreeningRequest" type="tns:XmlDataSet" cols="80" rows="30" />
 </message>
*/
IMPORT IESP,AutoStandardI,Healthcare_Shared,Healthcare_Header_Services,Healthcare_Ganga, ut;

EXPORT SearchService := MACRO
	ds_in := DATASET ([], iesp.healthcare_identity.t_HealthCareIdentityScreeningRequest): STORED('IdentityScreeningRequest', FEW);
	first_row := ds_in[1] : INDEPENDENT;
	
	SearchCriteria := first_row.SearchBy;
	SearchOptions := first_row.Options;
	

	Healthcare_Ganga.Layouts.IdentityInput getCriteria() := TRANSFORM
		self.acctno := '1';
		self.APSTransactionID := SearchCriteria.APSTransactionID;
		self.EnrollmentId := SearchCriteria.EnrollmentId;
		self.FirstName := SearchCriteria.Individual.Name.First;
		self.LastName := SearchCriteria.Individual.Name.Last;
		self.DoB := iesp.ecl2esp.t_DateToString8(SearchCriteria.Individual.DOB);
		self.SSN := SearchCriteria.Individual.SSN;
		self.NPI := SearchCriteria.NPI;
		self.StreetAddress1 := SearchCriteria.CorrespondenceAddress.StreetAddress1;
		self.StreetAddress2 := SearchCriteria.CorrespondenceAddress.StreetAddress2;
		self.City := SearchCriteria.CorrespondenceAddress.City;
		self.State := SearchCriteria.CorrespondenceAddress.State;
		self.Zip5 := SearchCriteria.CorrespondenceAddress.Zip5;
		self.Zip4 := SearchCriteria.CorrespondenceAddress.Zip4;
		self.LegalName := SearchCriteria.Business.LegalName;
		self.BusinessName := SearchCriteria.Business.Name;
		self.TaxID := SearchCriteria.Business.TaxID;
		self := [];
	END;
	
	dsCriteria := DATASET([getCriteria()]);
	gm := AutoStandardI.GlobalModule();
	Healthcare_Header_Services.Layouts.common_runtime_config buildConfig():=transform
	 self.glb_ok := ut.glb_ok (gm.GLBPurpose);
	 self.dppa_ok := ut.dppa_ok(gm.DPPAPurpose);
	 self.DRM := gm.DataRestrictionMask;
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