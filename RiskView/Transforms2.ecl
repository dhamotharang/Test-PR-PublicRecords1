Import iesp, RiskView, Risk_Indicators;
EXPORT Transforms2(Dataset(RiskView.Layouts.Model_Constants) Model_details) := Module

  //List of models that are using the next gen riskview reason codes, used in Riskview. Transforms
  //these need to be the output model names that the customer sees
  Shared next_gen := Model_details(Next_gen_credit = True);
  Shared next_gen_models := SET(next_gen, Output_Model_Name); 
  
  EXPORT iesp.riskview2.t_RiskView2ModelHRI intoModel(riskview.layouts.layout_riskview5_search_results le, integer c) := TRANSFORM

    Is_next_gen := MAP(
			c=1	 => le.Auto_Score_Name in next_gen_models,
			c=2	 => le.BankCard_Score_Name in next_gen_models,
			c=3	 => le.Short_term_lending_Score_Name in next_gen_models,
			c=4	 => le.Telecommunications_Score_Name in next_gen_models,
			c=5	 => le.Crossindustry_Score_Name in next_gen_models,
			c=6	 => le.Custom_Score_Name in next_gen_models,
			c=7	 => le.Custom2_Score_Name in next_gen_models,
			c=8	 => le.Custom3_Score_Name in next_gen_models,
			c=9	 => le.Custom4_Score_Name in next_gen_models,
			c=10 => le.Custom5_Score_Name in next_gen_models,
			        FALSE
		);
    
		score_name := MAP(
			c=1	=> le.Auto_Score_Name,
			c=2	=> le.BankCard_Score_Name,
			c=3	=> le.Short_term_lending_Score_Name,
			c=4	=> le.Telecommunications_Score_Name,
			c=5	=> le.Crossindustry_Score_Name,
			c=6	=> le.Custom_Score_Name,
			c=7	=> le.Custom2_Score_Name,
			c=8	=> le.Custom3_Score_Name,
			c=9	=> le.Custom4_Score_Name,
			c=10	=> le.Custom5_Score_Name,
			''
		);
		
		score_type := MAP(
			c=1 => le.Auto_Type,
			c=2 => le.BankCard_Type,
			c=3 => le.Short_term_lending_Type,
			c=4 => le.Telecommunications_Type,
			c=5 => le.Crossindustry_Type,
			c=6 => le.Custom_Type,
			c=7 => le.Custom2_Type,
			c=8 => le.Custom3_Type,
			c=9 => le.Custom4_Type,
			c=10 => le.Custom5_Type,			
			''
		);

		score_value := MAP(
			c=1	=> le.auto_score,
			c=2	=> le.Bankcard_score,
			c=3	=> le.Short_term_lending_score,
			c=4	=> le.Telecommunications_score,
			c=5	=> le.Crossindustry_score,
			c=6	=> le.Custom_score,
			c=7 => le.Custom2_score,
			c=8 => le.Custom3_score,
			c=9 => le.Custom4_score,
			c=10 => le.Custom5_score,
			''
		);
		
		reason1 := MAP(
			c=1	=> le.auto_reason1,
			c=2	=> le.Bankcard_reason1,
			c=3	=> le.Short_term_lending_reason1,
			c=4	=> le.Telecommunications_reason1,
			c=5	=> le.Crossindustry_reason1,
			c=6	=> le.Custom_reason1,
			c=7	=> le.Custom2_reason1,
			c=8	=> le.Custom3_reason1,
			c=9	=> le.Custom4_reason1,
			c=10	=> le.Custom5_reason1,
			''
		);
		
		reason2 := MAP(
			c=1	=> le.auto_reason2,
			c=2	=> le.Bankcard_reason2,
			c=3	=> le.Short_term_lending_reason2,
			c=4	=> le.Telecommunications_reason2,
			c=5	=> le.Crossindustry_reason2,
			c=6	=> le.Custom_reason2,
			c=7	=> le.Custom2_reason2,
			c=8	=> le.Custom3_reason2,
			c=9	=> le.Custom4_reason2,
			c=10	=> le.Custom5_reason2,
			''
		);
		
		reason3 := MAP(
			c=1	=> le.auto_reason3,
			c=2	=> le.Bankcard_reason3,
			c=3	=> le.Short_term_lending_reason3,
			c=4	=> le.Telecommunications_reason3,
			c=5	=> le.Crossindustry_reason3,
			c=6	=> le.Custom_reason3,
			c=7	=> le.Custom2_reason3,
			c=8	=> le.Custom3_reason3,
			c=9	=> le.Custom4_reason3,
			c=10	=> le.Custom5_reason3,
			''
		);
		
		reason4 := MAP(
			c=1	=> le.auto_reason4,
			c=2	=> le.Bankcard_reason4,
			c=3	=> le.Short_term_lending_reason4,
			c=4	=> le.Telecommunications_reason4,
			c=5	=> le.Crossindustry_reason4,
			c=6	=> le.Custom_reason4,
			c=7	=> le.Custom2_reason4,
			c=8	=> le.Custom3_reason4,
			c=9	=> le.Custom4_reason4,
			c=10	=> le.Custom5_reason4,
			''
		);
		
		reason5 := MAP(
			c=1	=> le.auto_reason5,
			c=2	=> le.Bankcard_reason5,
			c=3	=> le.Short_term_lending_reason5,
			c=4	=> le.Telecommunications_reason5,
			c=5	=> le.Crossindustry_reason5,
			c=6	=> le.Custom_reason5,
			c=7	=> le.Custom2_reason5,
			c=8	=> le.Custom3_reason5,
			c=9	=> le.Custom4_reason5,
			c=10	=> le.Custom5_reason5,
			''
		);
		
		ds_reasons := DATASET([
			{1, reason1, Risk_Indicators.getHRIDesc(reason1, Is_next_gen)},
			{2, reason2, Risk_Indicators.getHRIDesc(reason2, Is_next_gen)},
			{3, reason3, Risk_Indicators.getHRIDesc(reason3, Is_next_gen)},
			{4, reason4, Risk_Indicators.getHRIDesc(reason4, Is_next_gen)},
			{5, reason5, Risk_Indicators.getHRIDesc(reason5, Is_next_gen)}
			], iesp.riskview2.t_RiskView2RiskIndicator)(ReasonCode NOT IN ['','00']); // Only keep the valid reason codes
		
		self.name := score_name;
    
    //non-standard custom models, scores must be cast as INTEGER vs UNSIGNED
    NonStandardModels := ['ShortTermLendingRVR1903_1'];
		
		SELF.Scores := DATASET([transform(iesp.riskview2.t_RiskView2ScoreHRI,
			// self.value := (unsigned)score_value;
			self.value := if(score_name IN NonStandardModels, (integer)score_value, (unsigned)score_value);
			self._type := score_type;
			self.ScoreReasons := ds_reasons;
			)]);
	END;
  
  
  

END;