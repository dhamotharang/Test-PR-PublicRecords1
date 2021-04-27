Import ut;
EXPORT Update_Base (string version, boolean isFCRA = false, boolean pDaily = true, boolean isDidVille = false) := MODULE

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
		// Appends    :=	dataset('~persist::inql::appends::daily__p1177402905', INQL_v2.Layouts.Common_layout,thor);	
		Appends    := INQL_v2.FN_Append_IDs(Clean) : persist('~persist::inql::appends::daily'); 
		
		//---------append fraudpoint score by hitting batch service---------//
		daily_file_fraud_cnt := INQL_v2.score_constants.daily_file_fraud_count;
		INQL_v2.mac_append_score(Appends, Appends_score, daily_file_fraud_cnt);

		// Appends_Filtered := dataset('~persist::inql::appends_score::daily__p3910105125',INQL_v2.Layouts.Common_layout,thor);
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
               
		dsisFCRA    := INQL_v2.AddPerson_Business_Info(Appends, true, 1) //Accurint
                   +
                 INQL_v2.AddPerson_Business_Info(Appends, true, 2) //Custom
                   +
                 INQL_v2.AddPerson_Business_Info(Appends, true, 3) //Batch
                   +
                 INQL_v2.AddPerson_Business_Info(Appends, true, 4) //BatchR3
                   +
                 INQL_v2.AddPerson_Business_Info(Appends, true, 7); //Riskwise;
		dsisFCRA_remediation_applied := INQL_v2.FN_Apply_FCRA_Remediation_Soft_Inquiry(dsisFCRA).base_remediation;
    
		CurrBase_ := if(isFCRA, dsisFCRA_remediation_applied, dsNONisFCRA);
    shared CurrBase_with_DIDVILLE  := project(CurrBase_, transform({CurrBase_}, 
																						self.version := version; 
																						self := left;));

//  fcra and nonfcra-without-didvile daily base 	
    CurrBase_NO_DidVille    := CurrBase_with_DIDVILLE(search_info.function_description <> 'DIDVILLE.DIDBATCHSERVICERAW');
        Export DeltaBase        		:= if(isFCRA, CurrBase_with_DIDVILLE, CurrBase_NO_DidVille);		
		prevBase        				:= inql_v2.Flush_DeployedData(isFCRA).bld;	
		newBase         				:= Deltabase + prevBase;
		filtered_newBase 				:= distribute(FN_Filter_Base(newBase));
		export INQL_ALL 				:= filtered_newBase;
		

//  nonfcra-didville-only daily base
	EXPORT DeltaBase_DidVille_Only     	:= CurrBase_with_DIDVILLE(search_info.function_description = 'DIDVILLE.DIDBATCHSERVICERAW');
		   prevBaseDidVille 			:= inql_v2.Flush_DeployedData(false,true).bld;
		   newBaseDidVille  			:= DeltaBase_DidVille_Only + prevBaseDidVille;
    export INQL_DidVille 	        	:= newBaseDidVille;
		
//  non-fcra weekly base		
		INQL_v2.File_MBSApp_base(version, isDidville).Append(outMBSBaseAppend);
		baseAppended          := outMBSBaseAppend: persist('~persist::inql::appends::weekly');
		MisScoreMBSBaseAppend:= baseAppended(fraudpoint_score='');
		weekly_file_fraud_count:= INQL_v2.score_constants.weekly_file_fraud_count;
		INQL_v2.mac_append_score(MisScoreMBSBaseAppend, Appends_score_weekly, weekly_file_fraud_count,false);
		nonfcra_full_base_new     := baseAppended(fraudpoint_score<>'') + Appends_score_weekly;

//  fcra weekly base    
		fcra_full_base := INQL_v2.files(true, false).INQL_base.built + INQL_v2.files(true, true).INQL_base.built;
		INQL_v2.File_MBSApp_Base().FCRA_Append(fcra_full_base,fcra_full_base_mbs);
        fcra_full_base_new  := project(fcra_full_base_mbs, transform(INQL_v2.Layouts.Common_ThorAdditions, self := left));
    
		export INQL_HIST     := if(isfcra,distribute(fcra_full_base_new), nonfcra_full_base_new);
    
//  SBA base    		
		SBA_		:= INQL_v2.Clean_and_Translate(isFCRA).fnSBA();
		SBA     := project(SBA_, transform({SBA_}, 
																						self.version := version; 
																						self := left;));
		prevBase := INQL_v2.files(isFCRA, pDaily).SBA_base.built;		
		export SBA_ALL := distribute(SBA + prevBase);

// Batch_PII base
    Batch_PIIs_ := INQL_v2.Clean_and_Translate(isFCRA).fnBatch_PIIs();
		Batch_PIIs  := project(Batch_PIIs_, transform({Batch_PIIs_}, 
																						self.version := version; 
																						self := left;));
		prevBase := INQL_v2.files(isFCRA, pDaily).Batch_PIIs_base.built;		
		export Batch_PIIs_ALL := distribute(Batch_PIIs + prevBase); 

// BillGroups base		
		export BillGroups_DID_All := Inql_v2.File_BillGroups_DID(isFCRA);
	
END;