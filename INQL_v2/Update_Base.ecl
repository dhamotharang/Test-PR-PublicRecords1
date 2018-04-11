EXPORT Update_Base (string version, boolean isFCRA = false, boolean pDaily = true) := MODULE

		Accurint := INQL_v2.Clean_and_Translate(isFCRA).fnAccurint();		
		Custom   := INQL_v2.Clean_and_Translate(isFCRA).fnCustom();			
		Banko    := INQL_v2.Clean_and_Translate(isFCRA).fnBanko();	
		Batch    := INQL_v2.Clean_and_Translate(isFCRA).fnBatch();		
		BatchR3  := INQL_v2.Clean_and_Translate(isFCRA).fnBatchR3();		
		Bridger	 := INQL_v2.Clean_and_Translate(isFCRA).fnBridger();		
		Riskwise := INQL_v2.Clean_and_Translate(isFCRA).fnRiskwise();		
		IDM      := INQL_v2.Clean_and_Translate(isFCRA).fnIDM();		
				
		nonisFCRA_files := Accurint + Custom + Banko + Batch + BatchR3 + Bridger + Riskwise + IDM;
		isFCRA_files    := Accurint + Banko + Batch + BatchR3 + Riskwise;
    
		comb := if(isFCRA, isFCRA_files, nonisFCRA_files);
    
    //--------Clean up special char---------------//
    spec_filter := '[^[:print:]]';
    comb_clean := project(comb, transform(INQL_v2.Layouts.Common_layout,
					self.transaction_id       := StringLib.StringCleanSpaces(regexreplace(spec_filter, left.transaction_id, '', nocase)),
					self.datetime             := if(regexfind(spec_filter,left.datetime),self.transaction_id, left.datetime),
					self.Function_Description := StringLib.StringCleanSpaces(regexreplace(spec_filter, left.Function_Description, '', nocase)),
          self := left
          ));    
    
		Clean      := INQL_v2.fn_clean_and_parse(comb_clean);// : persist('~persist::inql::cleaned::daily');
		Appends    := INQL_v2.FN_Append_IDs(Clean) : persist('~persist::inql::appends::daily'); 
		
		//---------append fraudpoint score by hitting batch service---------//
		daily_file_fraud_cnt := INQL_v2.score_constants.daily_file_fraud_count;
		INQL_v2.mac_append_score(Appends, Appends_score, daily_file_fraud_cnt);
		Appends_Filtered := Appends_score : persist('~persist::inql::appends_score::daily');
    
    //---------Add Persons and Business Address, etc---------//
    dsNONisFCRA := INQL_v2.AddPerson_Business_Info(Appends_Filtered, false, 1) //Accurint
                   +
                 INQL_v2.AddPerson_Business_Info(Appends_Filtered, false, 2) //Custom
                   +
                 INQL_v2.AddPerson_Business_Info(Appends_Filtered, false, 3) //Batch
                   +
                 INQL_v2.AddPerson_Business_Info(Appends_Filtered, false, 4) //BatchR3
                   +
                 INQL_v2.AddPerson_Business_Info(Appends_Filtered, false, 5) //Banko
                   +
                 INQL_v2.AddPerson_Business_Info(Appends_Filtered, false, 6) //Bridger
                   +
                 INQL_v2.AddPerson_Business_Info(Appends_Filtered, false, 7) //Riskwise
                   +
                 INQL_v2.AddPerson_Business_Info(Appends_Filtered, false, 8); //IDM
               
		dsisFCRA    := INQL_v2.AddPerson_Business_Info(Appends_Filtered, true, 1) //Accurint
                   +
                 INQL_v2.AddPerson_Business_Info(Appends_Filtered, true, 2) //Custom
                   +
                 INQL_v2.AddPerson_Business_Info(Appends_Filtered, true, 3) //Batch
                   +
                 INQL_v2.AddPerson_Business_Info(Appends_Filtered, true, 4) //BatchR3
                   +
                 INQL_v2.AddPerson_Business_Info(Appends_Filtered, true, 7); //Riskwise;
		
    CurrBase_ := if(isFCRA, dsisFCRA, dsNONisFCRA);
    CurrBase  := project(CurrBase_, transform({CurrBase_}, 
																						self.version := version; 
																						self := left;));
        
		prevBase := INQL_v2.files(isFCRA, pDaily).INQL_base.built;		
		export INQL_ALL := CurrBase; //prevBase + CurrBase;
		
		SBA		:= INQL_v2.Clean_and_Translate(isFCRA).fnSBA();
		prevBase := INQL_v2.files(isFCRA, pDaily).SBA_base.built;		
		export SBA_ALL := SBA;// prevBase + SBA;

    Batch_PIIs := INQL_v2.Clean_and_Translate(isFCRA).fnBatch_PIIs();
		prevBase := INQL_v2.files(isFCRA, pDaily).Batch_PIIs_base.built;		
		export Batch_PIIs_ALL := Batch_PIIs; //prevBase + Batch_PIIs;
	
END;