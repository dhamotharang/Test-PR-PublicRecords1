EXPORT IID_trans_function  (DATASET(scoring_project_Macros.Global_Output_Layouts.NONFCRA_InstantId_Global_Layout) ds_base, 
																											DATASET(scoring_project_Macros.Global_Output_Layouts.NONFCRA_InstantId_Global_Layout) ds_test, string date1 , string date2) := function


				import risk_indicators, ut, ashirey, scoring_project_Macros, scoring_project_pip, scoring_qa, RiskProcessing;
				eyeball := 30;

				import models, riskwise, iesp;

				// basefilename := '~scoringqa::out::nonfcra::instantid_xml_generic_20180415_1';        //XML or Batch
				// testfilename := '~scoringqa::out::nonfcra::instantid_xml_generic_20180419_1';        //XML or Batch



					clean_ds_baseline := ds_base(errorcode='');
					clean_ds_testline := ds_test(errorcode='');
					
				flattenlay := scoring_project_Macros.Global_Output_Layouts.trans_IID_Layout;
					 
				flattenlay trans(recordof(clean_ds_baseline) le ) := transform
						self.models__accountnumber := '';
						self.models__description:= '';
						self.models__scores__i := '';
						self.models__scores__description := '';
						self.models__scores__index := '';
						self.models__scores__reason_codes__seq :=0;
						self.models__scores__reason_codes__reason_code := '';
						self.models__scores__reason_codes__reason_description := '';
						self.models__scores__name:= '';
						self.models__scores__value:= '';
						self.cvicustomscore_ri__seq:= 0;
						self.cvicustomscore_ri__hri := '';
						self.cvicustomscore_ri__desc := '';
						self.cvicustomscore_fua__hri := '';
						self.cvicustomscore_fua__desc := '';		 
						self := le;
						self := [];
				end;

				ds_flat_base := project(clean_ds_baseline, trans(left));
				ds_flat_test := project(clean_ds_testline, trans(left));

				
			// (string)	base_date := ds_base[49..56]
			// (string) test_date := ds_test[49..56]
				
				dates := 'IID Generic '+ date1 +' vs '+ date2;
				output(dates);
				results_daily := Scoring_Project_PIP.Compare_dsets_macro_email(ds_flat_base, ds_flat_test, ['acctno'], 0.05);

				
				return results_daily;

end;