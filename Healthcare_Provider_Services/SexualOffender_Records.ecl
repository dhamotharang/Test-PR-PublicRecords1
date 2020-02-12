import doxie,PersonReports,iesp,Healthcare_Header_Services;

export SexualOffender_Records (Healthcare_Header_Services.IParams.ReportParams inputData,
																doxie.IDataAccess mod_access,
																dataset(doxie.layout_references) dsDids) := module

		// sex-offenses in person reports depend on compliance values only
		emptyMod := project (mod_access, PersonReports.IParam.sexoffenses);

		export sexOffenderOffenses:=PersonReports.sexoffenses_records(dsDids,emptyMod)(inputData.IncludeSexOffenders);
		getID(iesp.sexualoffender.t_SexOffRecordIdNumbers recID) := FUNCTION
				ID := MAP(TRIM(recID.OffenderId)!='' => recID.OffenderId,
									TRIM(recID.DocNumber)!='' => recID.DocNumber,
									TRIM(recID.SORNumber)!='' => recID.SORNumber,
									TRIM(recID.StateIdNumber)!='' => recID.StateIdNumber,
									TRIM(recID.FBINumber)!='' => recID.FBINumber,
									TRIM(recID.NCICNumber)!='' => recID.NCICNumber,
									'');
				RETURN ID;
		end;
		export sexOffenderOffenderIds := if(exists(sexOffenderOffenses),getID(sexOffenderOffenses[1].IdNumbers),'');
END;
