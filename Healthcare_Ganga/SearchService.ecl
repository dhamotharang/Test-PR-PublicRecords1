/*--SOAP--
<message name="IdentityScreeningRequest">  
	<part name="IdentityScreeningRequest" type="tns:XmlDataSet" cols="80" rows="30" />
 </message>
*/
IMPORT IESP;

EXPORT SearchService := MACRO
	ds_in := DATASET ([], iesp.healthcare_identity.t_HealthCareIdentityScreeningRequest): STORED('IdentityScreeningRequest', FEW);
	first_row := ds_in[1] : INDEPENDENT;
	
	SearchCriteria := first_row.SearchBy;
	SearchOptions := first_row.Options;
	

	Healthcare_Ganga.Layouts.IdentityInput getCriteria() := TRANSFORM
		self.APSTransactionID := SearchCriteria.APSTransactionID;
		self.EnrollmentId := SearchCriteria.EnrollmentId;
		self.RecordIdentifier := SearchCriteria.RecordIdentifier;
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
	// output(dsCriteria, named('input_criteria'));
	
	// rawdata:=Healthcare_Ganga.Records.getAllRecords(dsCriteria);
	// resultsFinal := PROJECT(rawdata, Healthcare_Ganga.Transforms.xformWeb(left));

	results := PROJECT(dsCriteria, Healthcare_Ganga.Transforms.xform(left));
	
	output(results, named('Results'));

ENDMACRO;