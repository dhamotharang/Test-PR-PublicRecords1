import iesp,doxie;
#Stored('DPPAPurpose',1);
#Stored('GLBPurpose',1);
#Stored('DataRestrictionMask','00000000000000000');
#WORKUNIT('name','Healthcare_ABMS.CannedInput_Batch Test');    //name it "MyJob"

		rec_in := iesp.abms.t_ABMSReportRequest;
		rec_in setinput():=transform
			self.Options.includeCareer:=true;
			self.Options.includeEducation:=true;
			self.Options.includeProfessionalAssociations:=true;
			self.ReportBy.AccountNumber:='1';
			// self.ReportBy.UniqueId:='42594788558';
			// self.ReportBy.BusinessId:='26334088';
			self.ReportBy.ABMSBiogID:='10002400';
			// self.ReportBy.Name.Full:='EDWARD STEPHEN AMIS JR';
			self.ReportBy.Name.First:='';
			self.ReportBy.Name.Middle:='';
			self.ReportBy.Name.last:='';
			self.ReportBy.Name.Suffix:='';
			self.ReportBy.Name.Prefix:='';
			self.ReportBy.CompanyName:='';
			self.ReportBy.Address.StreetNumber:='';
			self.ReportBy.Address.StreetPreDirection:='';
			self.ReportBy.Address.StreetName:='';
			self.ReportBy.Address.StreetSuffix:='';
			self.ReportBy.Address.StreetPostDirection:='';
			self.ReportBy.Address.UnitDesignation:='';
			self.ReportBy.Address.UnitNumber:='';
			// self.ReportBy.Address.StreetAddress1:='111 E 210TH ST';
			self.ReportBy.Address.StreetAddress2:='';
			// self.ReportBy.Address.City:='Bronx';
			// self.ReportBy.Address.State:='NY';
			// self.ReportBy.Address.Zip5:='10467';
			self.ReportBy.Address.Zip4:='';
			self.ReportBy.Address.County:='';
			self.ReportBy.Address.PostalCode:='';
			self.ReportBy.Address.StateCityZip:='';
			// self.ReportBy.DOB.Year:=1969;
			// self.ReportBy.DOB.Month:=03;
			// self.ReportBy.DOB.Day:=22;
			// self.ReportBy.NPINumber:='1508959735';
			self.ReportBy.Specialty:='';
			self:=[]
		end;
		ds_in:=dataset([setinput()]);

	first_row := ds_in[1] : INDEPENDENT;	
	iesp.ECL2ESP.Marshall.Mac_Set(first_row.options);
	iesp.ECL2ESP.SetInputUser(first_row.user);	  
	iesp.ECL2ESP.SetInputReportBy (ROW (first_row.ReportBy, transform (iesp.bpsreport.t_BpsReportBy, Self := Left, Self := [])), true);
	unsigned2 PenaltThreshold := 10 :stored('PenaltyThreshold');
	#stored ('PenaltThreshold', PenaltThreshold);	
	doxie.MAC_Header_Field_Declare();

	convertedInput := project(first_row.reportBy,Healthcare_ABMS.Transforms.convertIESPtoAKInput(left,first_row.Options.includeCareer,first_row.Options.includeEducation,first_row.Options.includeProfessionalAssociations,GLB_Purpose,DPPA_Purpose));
	BatchRecs := Healthcare_ABMS.Raw.getRecordsBatch(dataset([convertedInput],Healthcare_ABMS.Layouts.autokeyInput),GLB_Purpose,DPPA_Purpose,PenaltThreshold);	
	output(BatchRecs, named('BatchResults'));
