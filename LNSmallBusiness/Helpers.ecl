import iesp, LNSmallBusiness;

export Helpers := MODULE
	export unsigned1 DPPA_Purpose := 0;
	export unsigned1 GLB_Purpose  := 8;
	export unsigned  History_Date := 999999;

	export BatchIn2Hierarchical( dataset(LNSmallBusiness.Layouts.Batch_In) indata, string modelname, unsigned1 glb, unsigned1 dppa ) := FUNCTION
		// convert flat batch layout to the hierarchical layout needed by RiskViewSB_Function

		param := dataset( [{'model',modelname}], iesp.share.t_NameValuePair );
		serv  := dataset( [{'','',param}],      iesp.share.t_ServiceLocation );
		
		LNSmallBusiness.Layouts.RequestEx toHier( indata le ) := TRANSFORM
			self.seq             := le.seq;
			self.AcctNo          := le.AcctNo;
			self.user.glbpurpose := (string)glb;
			self.user.dlpurpose  := (string)dppa;

			self.ServiceLocations := serv;
			
			self.searchby.business.name          := le.bus_name;
			self.searchby.business.alternatename := le.bus_altname;
			
			self.SearchBy.Business.Address.streetname            := le.bus_streetname;
			self.SearchBy.Business.Address.streetnumber          := le.bus_streetnumber;
			self.SearchBy.Business.Address.streetpredirection    := le.bus_streetpredirection;
			self.SearchBy.Business.Address.streetpostdirection   := le.bus_streetpostdirection;
			self.SearchBy.Business.Address.streetsuffix          := le.bus_streetsuffix;
			self.SearchBy.Business.Address.unitdesignation       := le.bus_unitdesignation;
			self.SearchBy.Business.Address.unitnumber            := le.bus_unitnumber;
			self.SearchBy.Business.Address.streetaddress1        := le.bus_streetaddress1;
			self.SearchBy.Business.Address.streetaddress2        := le.bus_streetaddress2;
			self.SearchBy.Business.Address.state                 := le.bus_state;
			self.SearchBy.Business.Address.city                  := le.bus_city;
			self.SearchBy.Business.Address.zip5                  := le.bus_zip5;
			self.SearchBy.Business.Address.zip4                  := le.bus_zip4;
			self.SearchBy.Business.Address.county                := le.bus_county;
			self.SearchBy.Business.Address.postalcode            := le.bus_postalcode;
			self.SearchBy.Business.Address.statecityzip          := le.bus_statecityzip;

			self.SearchBy.Business.fein                          := le.bus_fein;
			self.SearchBy.Business.phone10                       := le.bus_phone10;


			self.SearchBy.OwnerAgent.Name.full                   := le.rep_fullname;
			self.SearchBy.OwnerAgent.Name.first                  := le.rep_first;
			self.SearchBy.OwnerAgent.Name.middle                 := le.rep_middle;
			self.SearchBy.OwnerAgent.Name.last                   := le.rep_last;
			self.SearchBy.OwnerAgent.Name.suffix                 := le.rep_suffix;
			self.SearchBy.OwnerAgent.Name.prefix                 := le.rep_prefix;

			self.SearchBy.OwnerAgent.Address.streetname          := le.rep_streetname;
			self.SearchBy.OwnerAgent.Address.streetnumber        := le.rep_streetnumber;
			self.SearchBy.OwnerAgent.Address.streetpredirection  := le.rep_streetpredirection;
			self.SearchBy.OwnerAgent.Address.streetpostdirection := le.rep_streetpostdirection;
			self.SearchBy.OwnerAgent.Address.streetsuffix        := le.rep_streetsuffix;
			self.SearchBy.OwnerAgent.Address.unitdesignation     := le.rep_unitdesignation;
			self.SearchBy.OwnerAgent.Address.unitnumber          := le.rep_unitnumber;
			self.SearchBy.OwnerAgent.Address.streetaddress1      := le.rep_streetaddress1;
			self.SearchBy.OwnerAgent.Address.streetaddress2      := le.rep_streetaddress2;
			self.SearchBy.OwnerAgent.Address.state               := le.rep_state;
			self.SearchBy.OwnerAgent.Address.city                := le.rep_city;
			self.SearchBy.OwnerAgent.Address.zip5                := le.rep_zip5;
			self.SearchBy.OwnerAgent.Address.zip4                := le.rep_zip4;
			self.SearchBy.OwnerAgent.Address.county              := le.rep_county;
			self.SearchBy.OwnerAgent.Address.postalcode          := le.rep_postalcode;
			self.SearchBy.OwnerAgent.Address.statecityzip        := le.rep_statecityzip;

			self.SearchBy.OwnerAgent.SSN                 := le.rep_ssn;
			self.SearchBy.OwnerAgent.DOB.year            := (integer)le.rep_dob_year;
			self.SearchBy.OwnerAgent.DOB.month           := (integer)le.rep_dob_month;
			self.SearchBy.OwnerAgent.DOB.day             := (integer)le.rep_dob_day;
			self.SearchBy.OwnerAgent.phone10             := le.rep_phone10;
			self.SearchBy.OwnerAgent.driverlicensenumber := le.rep_driverlicensenumber;
			self.SearchBy.OwnerAgent.driverlicensestate  := le.rep_driverlicensestate;
			self.HistoryDate := le.HistoryDateYYYYMM;
			self := [];
		END;
		
		hier := project( indata, toHier(LEFT) );
		return hier;
	end;


   	export HierarchicalOut2Testseed( dataset(LNSmallBusiness.Layouts.ResponseEx) hier ) := FUNCTION
   		// convert hierarchical output a flat layout for batch
		LNSmallBusiness.Layouts.Testseeds toBatch( hier le ) := TRANSFORM

			/* INPUT ECHO */
			self.seq                            := le.seq;
			self.AcctNo                         := le._Header.queryid;
			                                    
			/* business info */
			self.bus_name                       := le.Result.InputEcho.Business.Name;
			self.bus_altname                    := le.Result.InputEcho.Business.AlternateName;

			self.bus_streetname                 := le.Result.InputEcho.Business.Address.streetname;
			self.bus_streetnumber               := le.Result.InputEcho.Business.Address.streetnumber;
			self.bus_streetpredirection         := le.Result.InputEcho.Business.Address.streetpredirection;
			self.bus_streetpostdirection        := le.Result.InputEcho.Business.Address.streetpostdirection;
			self.bus_streetsuffix               := le.Result.InputEcho.Business.Address.streetsuffix;
			self.bus_unitdesignation            := le.Result.InputEcho.Business.Address.unitdesignation;
			self.bus_unitnumber                 := le.Result.InputEcho.Business.Address.unitnumber;
			self.bus_streetaddress1             := le.Result.InputEcho.Business.Address.streetaddress1;
			self.bus_streetaddress2             := le.Result.InputEcho.Business.Address.streetaddress2;
			self.bus_state                      := le.Result.InputEcho.Business.Address.state;
			self.bus_city                       := le.Result.InputEcho.Business.Address.city;
			self.bus_zip5                       := le.Result.InputEcho.Business.Address.zip5;
			self.bus_zip4                       := le.Result.InputEcho.Business.Address.zip4;
			self.bus_county                     := le.Result.InputEcho.Business.Address.county;
			self.bus_postalcode                 := le.Result.InputEcho.Business.Address.postalcode;
			self.bus_statecityzip               := le.Result.InputEcho.Business.Address.statecityzip;            

			self.bus_fein                       := le.Result.InputEcho.Business.FEIN;
			self.bus_phone10                    := le.Result.InputEcho.Business.Phone10;

			
			/* rep info */
			self.rep_fullname                   := le.Result.InputEcho.OwnerAgent.Name.full;
			self.rep_first                      := le.Result.InputEcho.OwnerAgent.Name.first;
			self.rep_middle                     := le.Result.InputEcho.OwnerAgent.Name.middle;
			self.rep_last                       := le.Result.InputEcho.OwnerAgent.Name.last;
			self.rep_suffix                     := le.Result.InputEcho.OwnerAgent.Name.suffix;
			self.rep_prefix                     := le.Result.InputEcho.OwnerAgent.Name.prefix;

			self.rep_streetname                 := le.Result.InputEcho.OwnerAgent.Address.streetname;
			self.rep_streetnumber               := le.Result.InputEcho.OwnerAgent.Address.streetnumber;
			self.rep_streetpredirection         := le.Result.InputEcho.OwnerAgent.Address.streetpredirection;
			self.rep_streetpostdirection        := le.Result.InputEcho.OwnerAgent.Address.streetpostdirection;
			self.rep_streetsuffix               := le.Result.InputEcho.OwnerAgent.Address.streetsuffix;
			self.rep_unitdesignation            := le.Result.InputEcho.OwnerAgent.Address.unitdesignation;
			self.rep_unitnumber                 := le.Result.InputEcho.OwnerAgent.Address.unitnumber;
			self.rep_streetaddress1             := le.Result.InputEcho.OwnerAgent.Address.streetaddress1;
			self.rep_streetaddress2             := le.Result.InputEcho.OwnerAgent.Address.streetaddress2;
			self.rep_state                      := le.Result.InputEcho.OwnerAgent.Address.state;
			self.rep_city                       := le.Result.InputEcho.OwnerAgent.Address.city;
			self.rep_zip5                       := le.Result.InputEcho.OwnerAgent.Address.zip5;
			self.rep_zip4                       := le.Result.InputEcho.OwnerAgent.Address.zip4;
			self.rep_county                     := le.Result.InputEcho.OwnerAgent.Address.county;
			self.rep_postalcode                 := le.Result.InputEcho.OwnerAgent.Address.postalcode;
			self.rep_statecityzip               := le.Result.InputEcho.OwnerAgent.Address.statecityzip;

			self.rep_ssn                        := le.Result.InputEcho.OwnerAgent.ssn;
			self.rep_dob_year                   := (string4)le.Result.InputEcho.OwnerAgent.Dob.year;
			self.rep_dob_month                  := intformat(le.Result.InputEcho.OwnerAgent.Dob.month, 2, 1);
			self.rep_dob_day                    := intformat(le.Result.InputEcho.OwnerAgent.Dob.day, 2, 1);
			self.rep_phone10                    := le.Result.InputEcho.OwnerAgent.phone10;
			self.rep_driverlicensenumber        := le.Result.InputEcho.OwnerAgent.driverlicensenumber;
			self.rep_driverlicensestate         := le.Result.InputEcho.OwnerAgent.driverlicensestate;


			/* OUTPUT */
			doModel1 := le.Result.Models[1].Name != '';
			self.name1                          := le.Result.Models[1].Name;
			self.ModelDescription1              := le.Result.Models[1].Description;
			self.type1                          := le.Result.Models[1].Scores[1]._type;
			self.score1                         := if( doModel1, intformat( le.Result.Models[1].Scores[1].Value, 3, 1 ), '' );
			self.index1                         := if( doModel1, (string)le.Result.Models[1].Scores[1].index, '' );
			self.rep_rc11                       := le.Result.Models[1].Scores[1].OwnerAgentHighRiskIndicators[1].RiskCode;
			self.rep_desc11                     := le.Result.Models[1].Scores[1].OwnerAgentHighRiskIndicators[1].Description;
			self.rep_rc21                       := le.Result.Models[1].Scores[1].OwnerAgentHighRiskIndicators[2].RiskCode;
			self.rep_desc21                     := le.Result.Models[1].Scores[1].OwnerAgentHighRiskIndicators[2].Description;
			self.rep_rc31                       := le.Result.Models[1].Scores[1].OwnerAgentHighRiskIndicators[3].RiskCode;
			self.rep_desc31                     := le.Result.Models[1].Scores[1].OwnerAgentHighRiskIndicators[3].Description;
			self.rep_rc41                       := le.Result.Models[1].Scores[1].OwnerAgentHighRiskIndicators[4].RiskCode;
			self.rep_desc41                     := le.Result.Models[1].Scores[1].OwnerAgentHighRiskIndicators[4].Description;
			self.bus_rc11                       := le.Result.Models[1].Scores[1].BusinessHighRiskIndicators[1].RiskCode;
			self.bus_desc11                     := le.Result.Models[1].Scores[1].BusinessHighRiskIndicators[1].Description;
			self.bus_rc21                       := le.Result.Models[1].Scores[1].BusinessHighRiskIndicators[2].RiskCode;
			self.bus_desc21                     := le.Result.Models[1].Scores[1].BusinessHighRiskIndicators[2].Description;
			self.bus_rc31                       := le.Result.Models[1].Scores[1].BusinessHighRiskIndicators[3].RiskCode;
			self.bus_desc31                     := le.Result.Models[1].Scores[1].BusinessHighRiskIndicators[3].Description;
			self.bus_rc41                       := le.Result.Models[1].Scores[1].BusinessHighRiskIndicators[4].RiskCode;
			self.bus_desc41                     := le.Result.Models[1].Scores[1].BusinessHighRiskIndicators[4].Description;

			doModel2 := le.Result.Models[2].Name != '';
			self.name2                          := le.Result.Models[2].Name;
			self.ModelDescription2              := le.Result.Models[2].Description;
			self.type2                          := le.Result.Models[2].Scores[1]._type;
			self.score2                         := if( doModel2, intformat( le.Result.Models[2].Scores[1].Value, 3, 1 ), '' );
			self.index2                         := if( doModel2, (string)le.Result.Models[2].Scores[1].index, '' );
			self.rep_rc12                       := le.Result.Models[2].Scores[1].OwnerAgentHighRiskIndicators[1].RiskCode;
			self.rep_desc12                     := le.Result.Models[2].Scores[1].OwnerAgentHighRiskIndicators[1].Description;
			self.rep_rc22                       := le.Result.Models[2].Scores[1].OwnerAgentHighRiskIndicators[2].RiskCode;
			self.rep_desc22                     := le.Result.Models[2].Scores[1].OwnerAgentHighRiskIndicators[2].Description;
			self.rep_rc32                       := le.Result.Models[2].Scores[1].OwnerAgentHighRiskIndicators[3].RiskCode;
			self.rep_desc32                     := le.Result.Models[2].Scores[1].OwnerAgentHighRiskIndicators[3].Description;
			self.rep_rc42                       := le.Result.Models[2].Scores[1].OwnerAgentHighRiskIndicators[4].RiskCode;
			self.rep_desc42                     := le.Result.Models[2].Scores[1].OwnerAgentHighRiskIndicators[4].Description;
			self.bus_rc12                       := le.Result.Models[2].Scores[1].BusinessHighRiskIndicators[1].RiskCode;
			self.bus_desc12                     := le.Result.Models[2].Scores[1].BusinessHighRiskIndicators[1].Description;
			self.bus_rc22                       := le.Result.Models[2].Scores[1].BusinessHighRiskIndicators[2].RiskCode;
			self.bus_desc22                     := le.Result.Models[2].Scores[1].BusinessHighRiskIndicators[2].Description;
			self.bus_rc32                       := le.Result.Models[2].Scores[1].BusinessHighRiskIndicators[3].RiskCode;
			self.bus_desc32                     := le.Result.Models[2].Scores[1].BusinessHighRiskIndicators[3].Description;
			self.bus_rc42                       := le.Result.Models[2].Scores[1].BusinessHighRiskIndicators[4].RiskCode;
			self.bus_desc42                     := le.Result.Models[2].Scores[1].BusinessHighRiskIndicators[4].Description;

			// don't bother populating the fields from the testseed key
			self.modelname  := '';
			self.table_name := '';

			self := [];
		END;
		
		batch := project( hier, toBatch(LEFT) );
   		return batch;
   	END;

END;