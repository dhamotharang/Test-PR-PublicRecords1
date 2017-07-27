import iesp,doxie;
#Stored('DPPAPurpose',1);
#Stored('GLBPurpose',1);
#Stored('DataRestrictionMask','00000000000000000');
#WORKUNIT('name','Healthcare_ABMS.CannedInput_Search Test');    //name it "MyJob"

		rec_in := iesp.abms.t_ABMSSearchRequest;
		rec_in setinput():=transform
			self.SearchBy.AccountNumber:='1';
			// self.SearchBy.UniqueId:='42594788558';
			// self.SearchBy.BusinessId:='26334088';
			self.SearchBy.ABMSBiogID:='10002400';
			// self.SearchBy.Name.Full:='EDWARD STEPHEN AMIS JR';
			self.SearchBy.Name.First:='';
			self.SearchBy.Name.Middle:='';
			self.SearchBy.Name.last:='';
			self.SearchBy.Name.Suffix:='';
			self.SearchBy.Name.Prefix:='';
			self.SearchBy.CompanyName:='';
			self.SearchBy.Address.StreetNumber:='';
			self.SearchBy.Address.StreetPreDirection:='';
			self.SearchBy.Address.StreetName:='';
			self.SearchBy.Address.StreetSuffix:='';
			self.SearchBy.Address.StreetPostDirection:='';
			self.SearchBy.Address.UnitDesignation:='';
			self.SearchBy.Address.UnitNumber:='';
			// self.SearchBy.Address.StreetAddress1:='111 E 210TH ST';
			self.SearchBy.Address.StreetAddress2:='';
			// self.SearchBy.Address.City:='Bronx';
			// self.SearchBy.Address.State:='NY';
			// self.SearchBy.Address.Zip5:='10467';
			self.SearchBy.Address.Zip4:='';
			self.SearchBy.Address.County:='';
			self.SearchBy.Address.PostalCode:='';
			self.SearchBy.Address.StateCityZip:='';
			// self.SearchBy.DOB.Year:=1969;
			// self.SearchBy.DOB.Month:=03;
			// self.SearchBy.DOB.Day:=22;
			// self.SearchBy.NPINumber:='1508959735';
			self.SearchBy.Specialty:='';
			self:=[]
		end;
		ds_in:=dataset([setinput()]);

	first_row := ds_in[1] : INDEPENDENT;	
	iesp.ECL2ESP.Marshall.Mac_Set(first_row.options);
	iesp.ECL2ESP.SetInputUser(first_row.user);	  
	iesp.ECL2ESP.SetInputReportBy (ROW (first_row.searchBy, transform (iesp.bpsreport.t_BpsReportBy, Self := Left, Self := [])), true);
	unsigned2 PenaltThreshold := 10 :stored('PenaltyThreshold');
	#stored ('PenaltThreshold', PenaltThreshold);	
	doxie.MAC_Header_Field_Declare();

	convertedInput := project(first_row.searchBy,Healthcare_ABMS.Transforms.convertIESPtoAKInput(left,false,false,false,GLB_Purpose,DPPA_Purpose));
	recs := Healthcare_ABMS.Raw.getRecords(dataset([convertedInput],Healthcare_ABMS.Layouts.autokeyInput),GLB_Purpose,DPPA_Purpose,PenaltThreshold);	
	// output(convertedInput, named('convertedInput'));
	// output(recs, named('recs'));
	// Format output to iesp
	iesp.abms.t_ABMSSearchResponse format() := transform
				string q_id := '' 	 : stored ('_QueryId');
				string t_id := '' 	 : stored ('_TransactionId');
				self._Header         := ROW ({0, '', q_id, t_id, []}, iesp.share.t_ResponseHeader);
				self.SearchBy				 := first_row.searchBy;
				self.RecordCount 		 := count(recs);
				self.Records := project(Recs,iesp.abms.t_ABMSResults);
	end;

	Results := dataset([format()]);

	output(Results, named('Results'));
