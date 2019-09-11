IMPORT BatchShare, FCRA;

EXPORT IParam := MODULE

	EXPORT batch_params := interface (BatchShare.IParam.BatchParams, FCRA.iRules)
		// PII Preferential matching:
		EXPORT BOOLEAN MatchName     			:= FALSE;
		EXPORT BOOLEAN MatchStrAddr  			:= FALSE;     
		EXPORT BOOLEAN MatchCity     			:= FALSE;
		EXPORT BOOLEAN MatchState    			:= FALSE;       
		EXPORT BOOLEAN MatchZip      			:= FALSE;         
		EXPORT BOOLEAN MatchSSN      			:= FALSE;  
		EXPORT BOOLEAN MatchDOB						:= FALSE;
    // v---- 06/13/2017, offense categories filtering enhancement ----v
	  // 45 booleans total;
		//      1 for each of the 44 LN standard offense categories in hygenics_crim._functions.ctg_***,
		// plus 1 extra to indicate if any 1 of the 44 were set on.
    EXPORT BOOLEAN IncludeArson           := FALSE;
	  EXPORT BOOLEAN IncludeAssaultAgg      := FALSE;
    EXPORT BOOLEAN IncludeAssaultOther	  := FALSE;
    EXPORT BOOLEAN IncludeBadChecks       := FALSE;
    EXPORT BOOLEAN IncludeBribery         := FALSE;
    EXPORT BOOLEAN IncludeBurglaryComm    := FALSE;   
    EXPORT BOOLEAN IncludeBurglaryRes     := FALSE;
    EXPORT BOOLEAN IncludeBurglaryVeh     := FALSE; 
    EXPORT BOOLEAN IncludeComputer        := FALSE;
    EXPORT BOOLEAN IncludeCounterfeit     := FALSE;
    EXPORT BOOLEAN IncludeCurLoiVag       := FALSE;
    EXPORT BOOLEAN IncludeVandalism       := FALSE;
    EXPORT BOOLEAN IncludeDisorderly      := FALSE;
    EXPORT BOOLEAN IncludeDUI             := FALSE;
    EXPORT BOOLEAN IncludeDrug            := FALSE;
    EXPORT BOOLEAN IncludeDrunk           := FALSE;
    EXPORT BOOLEAN IncludeFamilyOff       := FALSE;
    EXPORT BOOLEAN IncludeFraud           := FALSE;
    EXPORT BOOLEAN IncludeGambling        := FALSE;
    EXPORT BOOLEAN IncludeHomicide        := FALSE;
    EXPORT BOOLEAN IncludeHumanTraff      := FALSE;
    EXPORT BOOLEAN IncludeIdTheft         := FALSE;
    EXPORT BOOLEAN IncludeKidnapping      := FALSE;
    EXPORT BOOLEAN IncludeLiquorLaw       := FALSE;
    EXPORT BOOLEAN IncludeMVTheft         := FALSE;
    EXPORT BOOLEAN IncludePeepingTom      := FALSE;
    EXPORT BOOLEAN IncludePornography     := FALSE;
    EXPORT BOOLEAN IncludeProstitution    := FALSE;
    EXPORT BOOLEAN IncludeRestraining     := FALSE;
    EXPORT BOOLEAN IncludeRobberyComm     := FALSE;
    EXPORT BOOLEAN IncludeRobberyRes      := FALSE;
    EXPORT BOOLEAN IncludeSOForce         := FALSE;
    EXPORT BOOLEAN IncludeSONonForce      := FALSE;
    EXPORT BOOLEAN IncludeShoplift        := FALSE;
    EXPORT BOOLEAN IncludeStolenProp      := FALSE;
    EXPORT BOOLEAN IncludeTerrorist       := FALSE;
    EXPORT BOOLEAN IncludeTheft           := FALSE;
    EXPORT BOOLEAN IncludeTraffic         := FALSE;
    EXPORT BOOLEAN IncludeTrespass        := FALSE;
    EXPORT BOOLEAN IncludeWeaponLaw       := FALSE;
    EXPORT BOOLEAN IncludeOther           := FALSE;
	  EXPORT BOOLEAN IncludeCannotClassify  := FALSE;
    EXPORT BOOLEAN IncludeWarrantFugitive := FALSE;
    EXPORT BOOLEAN IncludeObstructResist  := FALSE;
		EXPORT BOOLEAN IncludeAtLeast1Offense := FALSE;
	END;

  // Function to initalize the batch params
	EXPORT getBatchParams() :=	FUNCTION
	
	  BatchShareParams := BatchShare.IParam.getBatchParams();
			
		param_mod := MODULE(PROJECT(BatchShareParams,batch_params,OPT))
      EXPORT UNSIGNED2 MaxResults_val       := 50    : STORED('MaxResults');
			
		  EXPORT BOOLEAN IncludeArson           := FALSE : STORED('Includearson');        // #1
	    EXPORT BOOLEAN IncludeAssaultAgg      := FALSE : STORED('Includeassaultagg');   // #2
      EXPORT BOOLEAN IncludeAssaultOther	  := FALSE : STORED('Includeassaultother'); // ...
      EXPORT BOOLEAN IncludeBadChecks       := FALSE : STORED('Includebadchecks');
      EXPORT BOOLEAN IncludeBribery         := FALSE : STORED('Includebribery');
      EXPORT BOOLEAN IncludeBurglaryComm    := FALSE : STORED('Includeburglarycomm');   
      EXPORT BOOLEAN IncludeBurglaryRes     := FALSE : STORED('Includeburglaryres');
      EXPORT BOOLEAN IncludeBurglaryVeh     := FALSE : STORED('Includeburglaryveh'); 
      EXPORT BOOLEAN IncludeComputer        := FALSE : STORED('Includecomputer');
      EXPORT BOOLEAN IncludeCounterfeit     := FALSE : STORED('Includecounterfeit');
      EXPORT BOOLEAN IncludeCurLoiVag       := FALSE : STORED('Includecurloivag');
      EXPORT BOOLEAN IncludeVandalism       := FALSE : STORED('Includevandalism');
      EXPORT BOOLEAN IncludeDisorderly      := FALSE : STORED('Includedisorderly');
      EXPORT BOOLEAN IncludeDUI             := FALSE : STORED('Includedui');
      EXPORT BOOLEAN IncludeDrug            := FALSE : STORED('Includedrug');
      EXPORT BOOLEAN IncludeDrunk           := FALSE : STORED('Includedrunk');
      EXPORT BOOLEAN IncludeFamilyOff       := FALSE : STORED('Includefamilyoff');
      EXPORT BOOLEAN IncludeFraud           := FALSE : STORED('Includefraud');
      EXPORT BOOLEAN IncludeGambling        := FALSE : STORED('Includegambling');
      EXPORT BOOLEAN IncludeHomicide        := FALSE : STORED('Includehomicide');
      EXPORT BOOLEAN IncludeHumanTraff      := FALSE : STORED('Includehumantraff');
      EXPORT BOOLEAN IncludeIdTheft         := FALSE : STORED('Includeidtheft');
      EXPORT BOOLEAN IncludeKidnapping      := FALSE : STORED('Includekidnapping');
      EXPORT BOOLEAN IncludeLiquorLaw       := FALSE : STORED('Includeliquorlaw');
      EXPORT BOOLEAN IncludeMVTheft         := FALSE : STORED('Includemvtheft');
      EXPORT BOOLEAN IncludePeepingTom      := FALSE : STORED('Includepeepingtom');
      EXPORT BOOLEAN IncludePornography     := FALSE : STORED('Includepornography');
      EXPORT BOOLEAN IncludeProstitution    := FALSE : STORED('Includeprostitution');
      EXPORT BOOLEAN IncludeRestraining     := FALSE : STORED('Includerestraining');
      EXPORT BOOLEAN IncludeRobberyComm     := FALSE : STORED('Includerobberycomm');
      EXPORT BOOLEAN IncludeRobberyRes      := FALSE : STORED('Includerobberyres');
      EXPORT BOOLEAN IncludeSOForce         := FALSE : STORED('Includesoforce');
      EXPORT BOOLEAN IncludeSONonForce      := FALSE : STORED('Includesononforce');
      EXPORT BOOLEAN IncludeShoplift        := FALSE : STORED('Includeshoplift');
      EXPORT BOOLEAN IncludeStolenProp      := FALSE : STORED('Includestolenprop');
      EXPORT BOOLEAN IncludeTerrorist       := FALSE : STORED('Includeterrorist');
      EXPORT BOOLEAN IncludeTheft           := FALSE : STORED('Includetheft');
      EXPORT BOOLEAN IncludeTraffic         := FALSE : STORED('Includetraffic');
      EXPORT BOOLEAN IncludeTrespass        := FALSE : STORED('Includetrespass');
      EXPORT BOOLEAN IncludeWeaponLaw       := FALSE : STORED('Includeweaponlaw');
      EXPORT BOOLEAN IncludeOther           := FALSE : STORED('Includeother');
      EXPORT BOOLEAN IncludeCannotClassify  := FALSE : STORED('Includecannotclassify');
      EXPORT BOOLEAN IncludeWarrantFugitive := FALSE : STORED('Includewarrantfugitive');
      EXPORT BOOLEAN IncludeObstructResist  := FALSE : STORED('Includeobstructresist');

      // Check if any of the 44 individual Include*** input switches were set on/requested
      EXPORT BOOLEAN IncludeAtLeast1Offense := IncludeArson          or 
	                                             IncludeAssaultAgg     or 
                                               IncludeAssaultOther   or 
                                               IncludeBadChecks      or
                                               IncludeBribery        or
                                               IncludeBurglaryComm   or    
                                               IncludeBurglaryRes    or
                                               IncludeBurglaryVeh    or     
                                               IncludeComputer       or             
                                               IncludeCounterfeit    or      
                                               IncludeCurLoiVag      or 
                                               IncludeVandalism      or 
                                               IncludeDisorderly     or          
                                               IncludeDUI            or   
																		           IncludeDrug           or 
                                               IncludeDrunk          or                
                                               IncludeFamilyOff      or   
                                               IncludeFraud          or                      
                                               IncludeGambling       or                   
																		           IncludeHomicide       or 
                                               IncludeHumanTraff     or           
                                               IncludeIdTheft        or              
                                               IncludeKidnapping     or        
                                               IncludeLiquorLaw      or        
                                               IncludeMVTheft        or          
                                               IncludePeepingTom     or                 
                                               IncludePornography    or 
                                               IncludeProstitution   or               
                                               IncludeRestraining    or 
                                               IncludeRobberyComm    or          
                                               IncludeRobberyRes     or         
                                               IncludeSOForce        or        
                                               IncludeSONonForce     or     
                                               IncludeShoplift       or                
                                               IncludeStolenProp     or 
                                               IncludeTerrorist      or           
                                               IncludeTheft          or                      
																		           IncludeTraffic        or 
                                               IncludeTrespass       or     
                                               IncludeWeaponLaw      or        
                                               IncludeOther          or                      
                                               IncludeCannotClassify or
                                               IncludeWarrantFugitive or
                                               IncludeObstructResist;
	  END;
			
		RETURN param_mod;
	END;

END;