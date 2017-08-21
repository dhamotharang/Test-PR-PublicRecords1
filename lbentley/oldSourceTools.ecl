export oldSourceTools := MODULE
	export str_DPPA 						:= 'A';
	export str_DPPA_Probation		:= 'B';
	export str_NonDPPA 					:= ' ';
	export str_Utility					:= 'U';
	export str_FCRA 						:= 'D';
	export str_FCRA_Probation 	:= 'E';
	export str_Other_Probation 	:= 'C';

	export set_FCRA   					:= [str_FCRA, str_FCRA_Probation];
	export set_DPPA   					:= [str_DPPA, str_DPPA_Probation];
	export set_Probation   			:= [str_DPPA_Probation, str_FCRA_Probation, str_Other_Probation];
	
	export set_DPPA_sources := 
		 ['MA','RV','ED','WD','ID',//mixed dppa or		
			'MD','ND','FD','OD','TD','VD','CD','RD','AD','PD','SD','JD','YD','KD','DD',//drivers or 
			'AV','EV','IV','XV','FV','TV','MV','WV','OV','SV','NV','PV','LV','YV','QV','KV', //vehs or
			'AE','CE','$E','ME','OE','SE','BE','EE','&E','IE','LE','NE','PE','QE','TE','UE','GE','JE','KE','RE',
			'VE','XE','YE','ZE','HE','?E','@E','!E','.E','WE','#E','+E','=E', // ex veh
			'1X','2X','3X','4X','5X','6X','7X','8X','9X','ZX','XX','BX',  //ex dls
			'LW','RW','CW','EW','FW','(W','PW','KW','$W','XW','2W','BW',')W','3W','5W','6W','YW','8W','9W','!W','WW','#W' ,'ZW',
			'GW','IW','HW','JW','DW','QW','1W','NW','4W','7W','OW','SW','TW','VW','@W','[W','^W']; //watercrafts

	export set_DPPA_Probation_sources := 
		 [/*'MD','YE','SV'*/]; 
		 
	export string2 WH_src := 'WH';
	
	export set_NonDPPA_sources := 
		 ['MI','EQ','QH','WH', 'NC','TC','TU','DE', 'DS', 'TB','GO','FA','FP','FB','AK','FF',
			'FE','EM','PL','AR','AM','EB','FR','CG','DA','LT','LP','LA','PH','WP','PQ','DU','L2','SL','VO','CY','TS','E1','E2','E3','E4','EN','NT'];
	export set_Utility_sources := 
	   ['UT', 'UW', 'MU'];
	export set_FCRA_sources := 
		 ['BA','MW','LI'];
	export set_FCRA_Probation_sources := 
		 ['DC','CC','AL'];//Added Feb build...removed in Oct build
	
	export set_TEMP_Probation_sources := ['TS','EN'/*,'CY'*/];
	
	export SourceGroup(string2 sr) := 
	  MAP( 
	        sr in set_TEMP_Probation_sources => str_Other_Probation,
			sr in set_DPPA_Probation_sources => str_DPPA_Probation,
			sr in set_DPPA_sources 			 => str_DPPA, 			 
			sr in set_NonDPPA_sources 		 => str_NonDPPA, 
			sr in set_Utility_sources		 => str_Utility, 
			sr in set_FCRA_sources			 => str_FCRA, 
			sr in set_FCRA_Probation_sources => str_FCRA_Probation, 
	        str_Other_Probation
		 ); 
	
	export SourceIsDPPA(string2 sr) := 
		SourceGroup(sr) in set_DPPA;
	
	export set_GLB := ['EQ','EN'];
	export SourceIsGLB(string2 sr) := sr in set_GLB;
		
	export SourceIsFCRA(string2 sr) := 
		SourceGroup(sr) in set_FCRA;

	export SourceNot4Despray(string2 sr) := 
		SourceGroup(sr) in ['none'];
		
	export SourceIsUtility(string sr) := 
		SourceGroup(sr) = str_Utility;
	
	export SourceIsOnProbation(string sr) := SourceGroup(sr) in set_Probation;
	
	export set_NoMix  := ['DC','CC','AL'];
	export set_LNOnly := [];
	
	export set_Death := ['DS','DE'];
	export SourceIsDeath(string sr) := 
		sr in set_Death;		

	export set_experian_dl := ['1X','2X','3X','4X','5X','6X','7X','8X','9X','ZX','XX','BX'];
	export set_direct_dl   := ['MD','ND','FD','OD','TD','ED','WD','ID','RD','AD','VD','CD','UD','JD','PD','SD','YD','KD','DD'];
	export set_DL          := set_experian_dl+set_direct_dl;

	export SourceIsExperianDL(string sr) := sr in set_experian_dl;
	export SourceIsDirectDL(string sr)   := sr in set_direct_dl;
	export SourceIsDL(string sr)         := sr in set_dl;
	
	export set_experian_vehicles := ['AE','CE','$E','ME','OE','SE','BE','EE','&E','IE','LE','NE','PE','QE','TE','UE','GE','JE','KE','RE','VE','XE','YE','ZE','HE','?E','@E','!E','.E','WE','#E','+E','=E'];
	export set_direct_vehicles   := ['TV','FV','OV','WV','MV','SV','NV','RV','AV','EV','IV','XV','UV','PV','LV','YV','QV','KV'];
    export set_vehicles          :=	set_experian_vehicles+set_direct_vehicles;
								 
	export SourceIsExperianVehicle(string sr) := sr in set_experian_vehicles;
	export SourceIsDirectVehicle(string sr)   := sr in set_direct_vehicles;	
	export SourceIsVehicle(string sr)         := sr in set_vehicles;
		
	export set_WC := ['9W','4W','@W','6W','HW','!W','5W','CW','#W','7W','DW','3W','EW','LW','VW','QW','IW',
		'CG','GW','KW','JW','TW','2W','RW','SW','PW','OW','WW','ZW','NW','[W','BW','YW','1W','XW','FW','^W'];
	export sourceIsWC(string sr) :=
		sr in set_WC;
		
	export set_lnpropertyV2 :=  ['FA','FP','LA','LP'];
	export SourceIsLnPropertyV2(string sr) :=
		sr in set_lnpropertyV2;

	export set_property :=  ['FB'] + set_lnpropertyV2;
	export SourceIsProperty(string sr) :=
		sr in set_property;

	export set_transunion :=  ['LT','TU'];
	export SourceIsTransUnion(string sr) :=
		sr in set_transunion;

	export set_liens :=  ['LI','LF','LC'	,'LH'	,'LD'	,'LM'	,'LN'	,'LY'	,'LS'	,'LU'	];
	export SourceIsLiens(string sr) :=
		sr in set_liens;
    	
	export set_fbnv2 :=  ['GF','BF','EF','ZF','VF','WF','UF','HF','XF','YF','PF','TF'];
	export SourceIsFBNV2(string sr) :=
		sr in set_fbnv2;

	export set_CorpV2 :=  [
		 'C(','C)','C*','C+','C,','C-','C.' ,'C/','C0','C1','C2','C3','C4','C5','C6','C7','C8','C9','C:','C;'
		,'C<','C=','C>','C?','C@','C[','C\\','C]','C^','C_','C`','C{','C|','C}','C~','CA','CB','CH','CI','CJ'
		,'CK','CM','CN','CP','CQ','CR','CS','CV','CX','CZ'
	];
	export SourceIsCorpV2(string sr) :=
		sr in set_CorpV2;

	export set_bk := ['BA'];
	export SourceIsBankruptcy(string sr) :=
		sr in set_bk;
	
	export set_atf := ['FE','FF'];
	export SourceIsATF(string sr) :=
		sr in set_atf;

	export sourceisWeeklyHeader(string sr) :=
		sr = WH_src;
	
	export set_header := [
		 '!E' ,'!W' ,'#E' ,'#W' ,'$E' ,'&E' ,'+E' ,'.E' ,'1W' ,'1X' ,'2W' ,'2X' 
		,'3W' ,'3X' ,'4W' ,'4X' ,'5W' ,'5X' ,'6W' ,'6X' ,'7W' ,'7X' ,'8X' ,'9W' ,'9X'  
		,'?E' ,'@E' ,'@W' ,'AD' ,'AE' ,'AK' ,'AM' ,'AR' ,'AV' ,'BA' ,'BE' ,'BX' 
		,'CD' ,'CE' ,'CG' ,'CW' ,'CY' ,'DA' ,'DD' ,'DE' ,'DS' ,'DW' ,'EB' ,'ED','E1','E2','E3','E4' 
		,'EE' ,'EM' ,'DU' ,'EQ' ,'EV' ,'EW' ,'FA' ,'FB' ,'FD' ,'FE' ,'FF' ,'FP' ,'FR' 
		,'FV' ,'FW' ,'GE' ,'GW' ,'HE' ,'HW' ,'ID' ,'IE' ,'IV' ,'IW' ,'JE'
		,'JW' ,'KD' ,'KE' ,'KV' ,'KW' ,'L2' ,'LA' ,'LE' ,'LI' ,'LP' ,'LV' ,'LW' 
		,'ME' ,'MV' ,'MW' ,'ND' ,'NE' ,'NV' ,'NW' ,'OD' ,'OE' ,'OV'
		,'OW' ,'PD' ,'PE' ,'PL' ,'PQ' ,'PV' ,'PW' ,'QE' ,'QV' ,'QW'  
		,'RE' ,'RV' ,'RW' ,'SD' ,'SE' ,'SL' ,'SW' ,'TD' ,'TE' ,'TS' ,'TV' 
		,'TW' ,'UE' ,'UT' ,'UW' ,'VD' ,'VE' ,'VO' ,'VW' ,'WD' ,'WE'  
		,'WP' ,'WV' ,'WW' ,'XE' ,'XV' ,'XW' ,'XX' ,'YD' ,'YV' ,'YW' ,'ZE' ,'ZW' ,'ZX' ,'[W' 
		,'^W'
	]
//	+ set_NonDPPA_sources
	;

	export set_business_header := [
		 'AA' ,'AB' ,'FE' ,'FF','AT' ,'BA'  ,'BM' ,'BN' ,'BR' ,'CF' ,'CL' ,'CT' ,'CU' 
		,'D '  ,'DF' ,'DA' ,'DU' ,'E'  ,'ER' ,'EY' ,'AR' ,'FK' ,'FI' ,'FL' ,'FN' ,'GB' ,'GG' 
		,'I '  ,'IA' ,'IC' ,'II' ,'IL' ,'IN' ,'JI' ,'L2' ,'LB' ,'LJ' ,'LL' ,'LP' ,'ML' 
		,'MH' ,'MW' ,'NJ' ,'OL' ,'OS' ,'PI' ,'PL' ,'RB' ,'SA' ,'SB' ,'SG' ,'SK' 
		,'SP' ,'TL' ,'TP' ,'TX' ,'U '  ,'U2' ,'V '  ,'W '  ,'WC' ,'WT' ,'Y '  ,'ZM'
		,'9W','4W','@W','6W','HW','!W','5W','CW','#W','7W','DW','3W','EW','LW','VW','QW','IW',
		'CG','GW','KW','JW','TW','2W','RW','SW','PW','OW','WW','ZW','NW','[W','YW','1W','XW','FW','^W'
		,'TV','FV','OV','WV','MV','NV','RV','AV','EV','IV','XV','UV','PV','LV','YV','QV','KV'
,'AE','CE','$E','ME','OE','SE','BE','EE','&E','IE','LE','NE','PE','QE','TE','UE','GE','JE'
,'KE','RE','VE','XE','ZE','HE','?E','@E','!E','.E','WE','#E','+E','=E','DN','FT','IT'		] 
//	+ set_WC
	+ set_corpv2
	+ set_fbnv2
//	+ set_liens
	+ set_lnpropertyV2
//	+ set_direct_vehicles
//	+ set_experian_vehicles
//	- [')W','BW','MD','SV','YE']	//MO sources that were filtered out
	;
	
	export set_paw := [
		 'AA' ,'AB' ,'FE' ,'FF' ,'AT' ,'BA' ,'BR' ,'CF' ,'CL' ,'CT' ,'CU' ,'D '  ,'DF' ,'DA' ,'DU' 
		,'E '  ,'EY' ,'AR' ,'FK' ,'FL' ,'FN' ,'GB' ,'GG' ,'I '  ,'IA' ,'IC' ,'II' // EBR is filtered out of paw for permissioning reasons
		,'IL' ,'IN' ,'JI' ,'LB' ,'LL' ,'LP' ,'ML' ,'MH' ,'MW' ,'NJ' ,'OL' ,'PI' ,'PL' ,'PP' 
		,'QQ' ,'RB' ,'SA' ,'SB' ,'SG' ,'SK' ,'SP' ,'TL' ,'TP' ,'TX' ,'V '  ,'W '  ,'WC' 
		,'WT' ,'Y ' ,'ZM'
		,'C(','C)','C*','C+','C,','C-','C.' ,'C0','C1','C2','C3','C4','C5','C6','C7','C8','C9','C:','C;'
		,'C<','C=','C>','C?','C[','C\\','C]','C^','C`','C{','C|','C}','C~','CA','CB','CH','CI'
		,'CK','CN','CP','CQ','CR','CS','CV','CX','CZ','DN','FT','IT'
	]
	+ set_fbnv2
//	+ set_liens
	+ set_header
	+ set_property
//	- [')W','BW','MD','SV','YE']	//MO sources that were filtered out
	;

	export set_business_contacts := ['ER'] 
	+ set_paw;

//////////////////////	
	export set_dea							:= ['DA'] ;
	export set_BBB							:= ['BM','BN'] ;
	export set_Liquor_Licenses	:= ['CL','CT','IL','LL','OL','PI','TL'] ;
	export set_Emerges					:= ['EB','EM','E1','E2','E3','E4'] ;
	export set_Criminal_History := ['FC','GC','PC','UC'] ;
	export set_Sex_Offender			:= ['FS','GS','MS','PS','US','AS'] ;
	export set_FAA							:= ['AM','AR'] ;
	export set_Infousa					:= ['IA','IC','II'] ;
	export set_Gong							:= ['GB','GG','GO'] ;
	export set_UCCS							:= ['U ','U2'] ;
	export set_Workmans_Comp		:= ['MW','WC'] ;
	export set_Equifax					:= ['QH','QQ','WH','EQ'] ;
	export set_Sales_Tax				:= ['FT','IT'] ;
	export set_TCOA							:= ['TB','TC'] ;
//////////////////////	
	export set_NonUpdatingSrc := [
		 'AT'
		,'CU'
		,'E'
		,'EY'
		,'FN'
		,'IA'
		,'IC'
		,'II'
		,'LB'
		,'LJ'
		,'ML'
		,'QQ'
		,'TP'
		,'U'
		,'W'
		,'WT'
	]
	+ set_experian_vehicles;


	export SourceIsHeader					(string sr) :=	sr in set_header					;
	export SourceIsBusinessHeader	(string sr) :=	sr in set_business_header	;
	export SourceIsPaw						(string sr) :=	sr in set_paw							;
	export SourceIsNonUpdatingSrc	(string sr) :=	sr in set_NonUpdatingSrc	;

	export layout_description :=
	RECORD
		STRING2		code												        ;
		STRING100	description									        ;
		boolean		IsBusinessHeaderSource		:= false	;
		boolean		IsPeopleHeaderSource			:= false	;
		boolean		IsBusinessContactsSource	:= false	;
		boolean		IsPawSource								:= false	;
		boolean		IsFCRA										:= false	;
		boolean		IsDPPA										:= false	;
		boolean		IsUtility									:= false	;
		boolean		IsOnProbation							:= false	;
		boolean		IsDeath 									:= false	;
		boolean		IsDL 											:= false	;
		boolean		IsWC											:= false	;
		boolean		IsProperty								:= false	;
		boolean		IsTransUnion							:= false	;
		boolean		isWeeklyHeader						:= false	;
		boolean		isVehicle									:= false	;
		boolean		isLiens										:= false	;
		boolean		isBankruptcy							:= false	;
		boolean		isCorpV2									:= false	;
		boolean		isUpdating								:= true		;
	END;																			

	// -- Convert big map statement to dataset for flexibility
	// -- translatesource works the same way as before
	// -- We are consolidating business and people header sources here. 
	// -- Sometimes the source codes step on each other, so that is why there are 
	// -- two source codes in the dataset.  Eventually there will be only one, once 
	// -- all of the inconsistencies between the two headers are fixed.
	// -- So, that means when u add a source, put the source code in both code fields
	export dSource_Codes := DATASET([
		//****** For DPPA, char2 st abbrev. must be first two chars of description
		//		 see mdr.get_DPPA_st
		
		// -- DLs
		// -- if additional DL sources, please add to set_DL above
		 {'AD'  	,'ME DL'}
		,{'CD'  	,'MI DL'}
		,{'DD'  	,'CT DL'}
		,{'ED'  	,'NM DL'}
		,{'FD'  	,'FL DL'}
		,{'ID'  	,'ID DL'}
		,{'JD'  	,'IA DL'}
		,{'KD'  	,'KY DL'}
		,{'ND'  	,'MN DL'}
		,{'OD'  	,'OH DL'}
		,{'MD'  	,'MO DL'}
		,{'PD'  	,'MA DL'}
		,{'UD'  	,'UT DL'}
		,{'RD'  	,'OR DL'}
		,{'SD'  	,'TN DL'}
		,{'TD'  	,'TX DL'}
		,{'VD'  	,'WV DL'}
		,{'WD'  	,'WI DL'}
		,{'YD'  	,'WY DL'}
           
		// -- Experian DLs
		// -- if additional Experian DL sources, please add to set_DL above
		,{'1X' 	,'CO Experian DL' }
		,{'2X' 	,'DE Experian DL' }
		,{'3X' 	,'ID Experian DL' }
		,{'4X' 	,'IL Experian DL' }
		,{'5X' 	,'KY Experian DL' }
		,{'6X' 	,'LA Experian DL' }
		,{'7X' 	,'MD Experian DL' }
		,{'8X' 	,'MS Experian DL' }
		,{'9X' 	,'ND Experian DL' }
		,{'BX' 	,'WV Experian DL' }
		,{'XX' 	,'SC Experian DL' }
		,{'ZX' 	,'NH Experian DL' }
            
		// -- Vehicles
		// -- if additional Vehicle sources, please add to set_direct_vehicles above
		,{'AV' 	,'ME Veh'}
		,{'EV' 	,'NE Veh'}
		,{'FV' 	,'FL Veh'}
		,{'IV' 	,'ID Veh'}
		,{'KV' 	,'KY Veh'}
		,{'LV' 	,'MT Veh'}
		,{'MV' 	,'MS Veh'}
		,{'NV' 	,'MN Veh'}
		,{'OV' 	,'OH Veh'}
		,{'PV' 	,'ND Veh'}
		,{'RV' 	,'NC Veh'}
		,{'QV' 	,'NV Veh'}
		,{'SV' 	,'MO Veh'}
		,{'TV' 	,'TX Veh'}
		,{'UV' 	,'UT Veh'}
		,{'WV' 	,'WI Veh'}
		,{'XV' 	,'NM Veh'}
		,{'YV' 	,'WY Veh'}
            
		// -- Experian Vehicles
		// -- if additional Experian Vehicle sources, please add to set_experian_vehicles above
		,{'!E' 	,'OH Experian Veh'}
		,{'#E' 	,'WY Experian Veh'}
		,{'$E' 	,'DE Experian Veh'}
		,{'&E' 	,'DC Experian Veh'}
		,{'+E' 	,'NM Experian Veh'}
		,{'.E' 	,'TX Experian Veh'}
		,{'=E' 	,'OR Experian Veh'}
		,{'?E' 	,'NV Experian Veh'}
		,{'@E' 	,'ND Experian Veh'}
		,{'AE' 	,'AK Experian Veh'}
		,{'BE' 	,'AL Experian Veh'}
		,{'CE' 	,'CT Experian Veh'}
		,{'EE' 	,'CO Experian Veh'}
		,{'GE' 	,'FL Experian Veh'}
		,{'HE' 	,'NE Experian Veh'}
		,{'IE' 	,'IL Experian Veh'}
		,{'JE' 	,'ID Experian Veh'}
		,{'KE' 	,'KY Experian Veh'}
		,{'LE' 	,'LA Experian Veh'}
		,{'NE' 	,'MA Experian Veh'}
		,{'OE' 	,'OK Experian Veh'}
		,{'ME' 	,'MD Experian Veh'}
		,{'PE' 	,'MI Experian Veh'}
		,{'QE' 	,'NY Experian Veh'}
		,{'UE' 	,'UT Experian Veh'}
		,{'RE' 	,'ME Experian Veh'}
		,{'SE' 	,'SC Experian Veh'}
		,{'TE' 	,'TN Experian Veh'}
		,{'VE' 	,'MN Experian Veh'}
		,{'WE' 	,'WI Experian Veh'}
		,{'XE' 	,'MS Experian Veh'}
		,{'ZE' 	,'MT Experian Veh'}
		,{'YE' 	,'MO Experian Veh'}
                                                                                                     
		// -- Watercraft
		// -- if additional Watercraft sources, please add to set_WC above
		,{'!W' 	,'WV Watercraft'      /*DPPA*/}
		,{'#W' 	,'AK Watercraft'      /*DPPA*/}
		,{'$W' 	,'KY Watercraft (LN)'         }
		,{'(W' 	,'FL Watercraft (LN)' /*DPPA*/}
		,{')W' 	,'MO Watercraft (LN)'         }
		,{'1W' 	,'MN Watercraft'              }
		,{'2W' 	,'MS Watercraft'      /*DPPA*/}
		,{'3W' 	,'MT Watercraft'      /*DPPA*/}
		,{'4W' 	,'ND Watercraft'              }
		,{'5W' 	,'NE Watercraft'      /*DPPA*/}
		,{'6W' 	,'NH Watercraft'      /*DPPA*/}
		,{'7W' 	,'NV Watercraft'              }
		,{'8W' 	,'OR Watercraft'      /*DPPA*/}
		,{'9W' 	,'UT Watercraft'      /*DPPA*/}
		,{'@W' 	,'WY Watercraft'              }
		,{'[W' 	,'TX Watercraft'              }
		,{'BW' 	,'MO Watercraft'      /*DPPA*/}
		,{'CW' 	,'CO Watercraft'      /*DPPA*/}
		,{'DW' 	,'MD Watercraft'              }
		,{'EW' 	,'CT Watercraft'      /*DPPA*/}
		,{'FW' 	,'FL Watercraft'              }
		,{'GW' 	,'GA Watercraft'              }
		,{'HW' 	,'KS Watercraft'              }
		,{'IW' 	,'IA Watercraft'              }
		,{'JW' 	,'MA Watercraft'              }
		,{'KW' 	,'KY Watercraft'      /*DPPA*/}
		,{'LW' 	,'AL Watercraft'      /*DPPA*/}
		,{'NW' 	,'NC Watercraft'              }
		,{'OW' 	,'OH Watercraft'              }
		,{'PW' 	,'IL Watercraft'      /*DPPA*/}
		,{'RW' 	,'AR Watercraft'              }
		,{'QW' 	,'ME Watercraft'              }
		,{'SW' 	,'SC Watercraft'              }
		,{'TW' 	,'TN Watercraft'              }
		,{'VW' 	,'VA Watercraft'              }
		,{'WW' 	,'WI Watercraft'      /*DPPA*/}
		,{'XW' 	,'MI Watercraft'      /*DPPA*/}
		,{'YW' 	,'NY Watercraft'      /*DPPA*/}
		,{'ZW' 	,'AZ Watercraft'              }
            
		// -- Criminal History and Sex Offender files for Matrix
		,{'FC' 	,'FL CH'                }
		,{'FS' 	,'FL SO'                }
		,{'GC' 	,'GA CH'                }
		,{'GS' 	,'GA SO'                }
		,{'MS' 	,'MI SO'                }
		,{'PC' 	,'PA CH'                }
		,{'PS' 	,'PA SO'                }
		,{'UC' 	,'UT CH'                }
		,{'US' 	,'UT SO'                }
		,{'AS' 	,'Accurint Sex offender'}
            
		// -- Other Crim
		,{'CC' 	,'Accurint Crim Court'  }
		,{'DC' 	,'Accurint DOC'         }
		,{'AL' 	,'Accurint Arrest Log'  }
            
		// -- Emerges
		,{'EB' 	,'EMerge Boat'          }
		,{'EM' 	,'EMerge Master'        }
		,{'E1' 	,'EMerge Hunt'          }
		,{'E2' 	,'EMerge Fish'          }
		,{'E3' 	,'EMerge CCW'           }
		,{'E4' 	,'EMerge Cens'          }
            
		// -- Federal Firearms & Explosives
		,{'FE' 	,'Federal Explosives'   }
		,{'FF' 	,'Federal Firearms'     }
            
		// -- Utilities
		// -- if additional Utility sources, please add to set_Utility_sources above
		,{'UT' 	,'Utilities'            }
		,{'UW' 	,'Util Work Phone'      }
		,{'MU' 	,'Mixed Utilities'      }
            
		// -- Alaska Permanent Fund
		,{'AK' 	,'AK Perm Fund'         }

		// -- Bankruptcy
		// -- if additional Bankruptcy sources, please add to set_bk above
		,{'BA' 	,'Bankruptcy'           }
           
		// -- BBB
		,{'BM' 	,'Better Business Bureau Member'     }
		,{'BN' 	,'Better Business Bureau Non-Member' }
		        
		// -- Liquor & Gaming Licenses
		,{'CL' 	,'California Liquor Licenses'        }
		,{'CT' 	,'Conneticut Liquor Licenses'        }
		,{'IL' 	,'Indiana Liquor Licenses'           }
		,{'LL' 	,'Louisana Liquor Licenses'          }
		,{'NJ' 	,'New Jersey Gaming Licenses'        }
		,{'OL' 	,'Ohio Liquor Licenses'              }
		,{'PI' 	,'Pennsylvania Liquor Licenses'      }
		,{'TL' 	,'Texas Liquor Licenses'             }
            
		// -- DEA
		,{'DA' 	,'DEA'                               }
		        
		// -- Death
		// -- if additional death sources, please add to set_Death above
		,{'DE' 	,'Death Master'                      }
		,{'DS' 	,'Death State'                       }
		        
		// -- FAA Aircraft and Airmen
		,{'AM' 	,'Airmen'                            }
		,{'AR' 	,'Aircrafts'                         }
           
		// -- Property
		// -- if additional property sources, please add to set_property above
		,{'FB' 	,'Fares Deeds from Assessors'              }
		,{'FA' 	,'LN_Propertyv2 Fares Assessors'           }
		,{'FP' 	,'LN_Propertyv2 Fares Deeds'               }
		,{'LA' 	,'LN_Propertyv2 Lexis Assessors'           }
		,{'LP' 	,'LN_Propertyv2 Lexis Deeds and Mortgages' }
            
		// -- Miscellaneous
		,{'MA' 	,'Mixed DPPA'         }
		,{'MC' 	,'Mixed Probation'    }
		,{'MI' 	,'Mixed Non-DPPA'     }
		,{'PQ' 	,'Miscellaneous'      }		//got this from MDR.source_is_marketing_eligible
            
		// -- Equifax
		,{'QH' 	,'Equifax Quick'          }
		,{'QQ' 	,'Eq Employer'            }
		,{'WH' 	,'Equifax Weekly'         }
		,{'EQ' 	,'Equifax'         }
		,{'EN' 	,'Experian Credit Header' }
            
		// -- Liens
		// -- if additional Liens sources, please add to set_liens above
		,{'L2' 	,'Liens v2'                      }
		,{'LI' 	,'Liens'                         }
		,{'LJ' 	,'Liens and Judgments'           }
		// these new codes not used yet
		,{'LF' 	,'CA Liens v2 CA Federal'        }
		,{'LC' 	,'CL,CJ Liens v2 Chicago Law'    }
		,{'LH' 	,'HG Liens v2 Hogan'             }
		,{'LD' 	,'IL Liens v2 ILFDLN'            }
		,{'LM' 	,'MA Liens v2 MA'                }
		,{'LN' 	,'NYC Liens v2 NYC'              }
		,{'LY' 	,'NY Liens v2 NYFDLN'            }
		,{'LS' 	,'SA Liens v2 Service Abstract'  }
		,{'LU' 	,'SU Liens v2 Superior Party'    }
		        
		// -- TransUnion
		// -- if additional Transunion sources, please add to set_transunion above
		,{'LT' 	,'Lexis Trans Union'             }
		,{'TS' 	,'TUCS_Ptrack'                   }
		,{'TU' 	,'TransUnion'                    }
		        
		// -- Workman's Comp
		,{'MW' ,'MS Worker Comp'	}
		,{'WC' ,'OR Worker Comp' }
           
		// -- Gong
		,{'GB' 	,'Gong Business'    }
		,{'GG' 	,'Gong Government'  }
		,{'GO' 	,'Gong History'     }
           
		// -- Infousa
		,{'IA' 	,'INFOUSA ABIUS(USABIZ)'   }
		,{'IC' 	,'INFOUSA DEAD COMPANIES'  }
		,{'II' 	,'INFOUSA IDEXEC'          }
           
		// -- Redbooks
		,{'SA' 	,'SDA - Standard Directory of Advertisers'  }
		,{'AA' 	,'SDAA - Standard Directory of Ad Agencies' }
		,{'RB' 	,'Redbooks International Advertisers'       }
           
		// -- Medical 
		,{'ML' 	,'Medical Information Directory'    }
		,{'SK' 	,'SK&A Medical Professionals'       }
           
		// -- Tax
		,{'FT' 	,'California Sales Tax'                       }
		,{'IT' 	,'Iowa Sales Tax'                       }
		,{'TX' 	,'Texas Sales Tax Registrations(TXBUS)'  }
		,{'TP' 	,'Tax practitioner'                      }
           
		// -- TCOA
		,{'TB' 	,'TCOA Before Address'    }
		,{'TC' 	,'TCOA After Address'     }
		        
		// -- UCCs
		,{'U ' 	,'UCC'    }
		,{'U2' 	,'UCCV2'  }
           
		// -- Boats other than watercraft
		,{'CG' 	,'US Coastguard'                                                                }
		,{'^W' 	,'AK Commercial Fishing Vessels'   /*Assume same DPPA as regular AK Watercraft*/}

		// -- FBNs 
		// -- For any new FBNV2 sources, please add to set_fbnv2 above
		,{'FL' 	,'Florida FBN'                          }
		,{'BR' 	,'Business Registration'                }
		,{'GF' 	,'CAO FBNV2 California Orange county'		}
		,{'BF' 	,'CAB FBNV2 California San Bernadino'		}
		,{'EF' 	,'CAS FBNV2 California San Diego'				}
		,{'ZF' 	,'CSC FBNV2 California Santa Clara'			}
		,{'VF' 	,'CAV FBNV2 California Ventura'				  }
		,{'WF' 	,'FL  FBNV2 Florida'				            }
		,{'UF' 	,'INF FBNV2 Infousa'				            }
		,{'HF' 	,'TXH FBNV2 Texas Harris'				        }
		,{'XF' 	,'TXD FBNV2 Texas Dallas'				        }
		,{'YF' 	,'NBX,NYN,NKI,NQU,NRI FBNV2 New York'		}
		,{'PF' 	,'CP  FBNV2 Historical Choicepoint'			}
		,{'TF' 	,'EXP FBNV2 Experian Direct'						}

		// -- CorporationsV2
		,{'C('  	,'AL Corporations'   }
		,{'C)'  	,'AK Corporations'   }
		,{'C*'  	,'AZ Corporations'   }
		,{'C+'  	,'AR Corporations'   }
		,{'C,'  	,'CA Corporations'   }
		,{'C-'  	,'CO Corporations'   }
		,{'C.'  	,'CT Corporations'   }
		,{'C/'  	,'DC Corporations'   }
		,{'C0'  	,'FL Corporations'   }
		,{'C1'  	,'GA Corporations'   }
		,{'C2'  	,'HI Corporations'   }
		,{'C3'  	,'ID Corporations'   }
		,{'C4'  	,'IL Corporations'   }
		,{'C5'  	,'IN Corporations'   }
		,{'C6'  	,'IA Corporations'   }
		,{'C7'  	,'KS Corporations'   }
		,{'C8'  	,'KY Corporations'   }
		,{'C9'  	,'LA Corporations'   }
		,{'C:'  	,'ME Corporations'   }
		,{'C;'  	,'MD Corporations'   }
		,{'C<'  	,'MA Corporations'   }
		,{'C='  	,'MI Corporations'   }
		,{'C>'  	,'MN Corporations'   }
		,{'C?'  	,'MS Corporations'   }
		,{'C@'  	,'MO Corporations'   }
		,{'C['  	,'MT Corporations'   }
		,{'C\\' 	,'NE Corporations'   }
		,{'C]'  	,'NV Corporations'   }
		,{'C^'  	,'NH Corporations'   }
		,{'C_'  	,'NJ Corporations'   }
		,{'C`'  	,'NM Corporations'   }
		,{'C{'  	,'NY Corporations'   }
		,{'C|'  	,'NC Corporations'   }
		,{'C}'  	,'ND Corporations'   }
		,{'C~'  	,'OH Corporations'   }
		,{'CA'  	,'OK Corporations'   }
		,{'CB'  	,'OR Corporations'   }
		,{'CH'  	,'PA Corporations'   }
		,{'CI'  	,'RI Corporations'   }
		,{'CJ'  	,'SC Corporations'   }
		,{'CK'  	,'SD Corporations'   }
		,{'CM'  	,'TN Corporations'   }
		,{'CN'  	,'TX Corporations'   }
		,{'CP'  	,'UT Corporations'   }
		,{'CQ'  	,'VT Corporations'   }
		,{'CR'  	,'VA Corporations'   }
		,{'CS'  	,'WA Corporations'   }
		,{'CV'  	,'WV Corporations'   }
		,{'CX'  	,'WI Corporations'   }
		,{'CZ'  	,'WY Corporations'   }
                     

		,{'AT' 	,'Accurint Trade Show'                                    }
		,{'CU' 	,'Credit Unions'                                          }
		,{'AB' 	,'Alaska Business Registrations'                          }
		,{'CF' 	,'ACF - America\'s Corporate Financial Directory'         }
		,{'CO' 	,'A corrections/override (used in FCRA products) record'  }
		,{'CY' 	,'Certegy'                                                }
		,{'D '  ,'Dunn & Bradstreet'                                      }
		,{'DN'  ,'Dunn & Bradstreet Fein'                                 }
		,{'DF' 	,'DCA'                                                    }
		,{'DU' 	,'Dummy Records'                                          }
		,{'E '  ,'Edgar'                                                  }
		,{'ER' 	,'Experian Business Reports'                              }
		,{'EY' 	,'Employee Directories'                                   }
		,{'FK' 	,'FCC Radio Licenses'                                     }
		,{'FI' 	,'FDIC'                                                   }
		,{'FN' 	,'Florida Non-Profit'                                     }
		,{'NT' 	,'Foreclosures - Notice of Delinquency'                   }
		,{'FR' 	,'Foreclosures'                                           }
		,{'I '  ,'IRS 5500'                                               }
		,{'IN' 	,'IRS Non-Profit'                                         }
		,{'IP' 	,'Ingenix National Provider Sanctions'                    }
		,{'JI'  ,'Jigsaw' 		                                          	}
		,{'LB' 	,'Lobbyists'                                              }
		,{'MH' 	,'MartinDale Hubbell'                                     }
		,{'NC' 	,'NCOA'                                                   }
		,{'OS' 	,'OSHAIR'                                                 }
		,{'PH' 	,'Appended phone from gong file'                          }
		,{'PL' 	,'Professional License'                                   }
		,{'PP' 	,'Phones Plus'                                            }
		,{'SB' 	,'SEC Broker/Dealer'                                      }
		,{'SG' 	,'Sheila Greco'                                           }
		,{'SL' 	,'American Students List'                                 }
		,{'SP' 	,'Spoke'                                                  }
		,{'V '  ,'Vickers'                                                }
		,{'VO' 	,'Voters v2'                                              }
		,{'W '  ,'Domain Registrations (WHOIS)'                           }
		,{'WP' 	,'Targus White pages'                                     }
		,{'WT' 	,'Wither and Die'                                         }
		,{'Y ' 	,'Yellow Pages'                                           }
		,{'ZM' 	,'ZOOM'                                                   }
		,{'AC' 	,'American Correctional Association'                      }
                                                                                                        
	], layout_description);

	layout_description tSetSources(layout_description l) :=
	transform
//		self.IsBusinessSource		:= SourceIsBusinessHeader	(l.code);
//		self.IsHeaderSource			:= SourceIsHeader					(l.code);
		self.IsPawSource				:= SourceIsPaw						(l.code);
		self.IsFCRA						 	:= SourceIsFCRA						(l.code);
		self.IsDPPA						 	:= SourceIsDPPA						(l.code);
		self.IsUtility				 	:= SourceIsUtility				(l.code);
		self.IsOnProbation			:= SourceIsOnProbation		(l.code);
		self.IsDeath 						:= SourceIsDeath 					(l.code);
		self.IsDL 							:= SourceIsDL 						(l.code);
		self.IsWC								:= sourceIsWC							(l.code);
		self.IsProperty					:= SourceIsProperty				(l.code);
		self.IsTransUnion				:= SourceIsTransUnion			(l.code);
		self.isWeeklyHeader			:= sourceisWeeklyHeader		(l.code);
		self.isVehicle					:= sourceisVehicle				(l.code);
		self.isLiens						:= sourceisLiens					(l.code);
		self.isBankruptcy				:= sourceisBankruptcy			(l.code);
		self.isCorpV2						:= sourceisCorpV2					(l.code);
		self.isUpdating					:= SourceIsNonUpdatingSrc	(l.code);
		self										:= l;                                                     

	end;

	export dSource_Codes_proj := project(dSource_Codes, tSetSources(left));

	export fTranslateSource(string pSource) :=
	function
		
		lcode := dSource_Codes_proj.code;
		source_filter 		:= 	(		trim(pSource,left,right) = trim(lcode,left,right)
																);
		dsource 					:= dSource_Codes_proj(source_filter		)[1].description;
		returnDescription := dsource;
		return if(returnDescription != '', returnDescription, '?' + pSource);
	end;

	export TranslateSource(string2 pSource) := fTranslateSource(pSource);		
/*
	//in a normalized record 1, 3, 4, and 7 should never be valid
	export TranslateWeeklyInd(string1 pIn) := 
	case(pIn
		,'W' => 'New'
		,'1' => 'Name Chg,Addr Chg,SSN Chg,Former Name Chg'
		,'2' => 'Name Chg,Addr Chg,SSN Chg'
		,'3' => 'Name Chg,SSN Chg,Former Name Chg'
		,'4' => 'Name Chg,Addr Chg,Former Name Chg'
		,'5' => 'Name Chg,Addr Chg'
		,'6' => 'Name Chg,SSN Chg'
		,'7' => 'Name Chg,Former Name Chg'
		,'N' => 'Name Chg'
		,'8' => 'Addr Chg,SSN Chg,Former Name Chg'
		,'9' => 'Addr Chg,SSN Chg'
		,'Y' => 'Addr Chg,Former Name Chg'
		,'A' => 'Addr Chg'
		,'Z' => 'SSN Chg,Former Name Chg'
		,'S' => 'SSN Chg'				 
		,'F' => 'Former Name Chg'
		,'-' => 'No Relevant Information'											
		,pIn
	);
*/
	export layout_Weekly_Indicators :=
	RECORD
		STRING2		code												        ;
		STRING100	description									        ;
	END;																			

	export dWeekly_Indicators := DATASET([
		 {'W' 	,'New'           																}
		,{'1' 	,'Name Chg,Addr Chg,SSN Chg,Former Name Chg'    }
		,{'2' 	,'Name Chg,Addr Chg,SSN Chg'           					}
		,{'3' 	,'Name Chg,SSN Chg,Former Name Chg'           	}
		,{'4' 	,'Name Chg,Addr Chg,Former Name Chg'           	}
		,{'5' 	,'Name Chg,Addr Chg'           									}
		,{'6' 	,'Name Chg,SSN Chg'           									}
		,{'7' 	,'Name Chg,Former Name Chg'           					}
		,{'N' 	,'Name Chg'           													}
		,{'8' 	,'Addr Chg,SSN Chg,Former Name Chg'           	}
		,{'9' 	,'Addr Chg,SSN Chg'           									}
		,{'Y' 	,'Addr Chg,Former Name Chg'           					}
		,{'A' 	,'Addr Chg'          	 													}
		,{'Z' 	,'SSN Chg,Former Name Chg'           						}
		,{'S' 	,'SSN Chg'				            									}
		,{'F' 	,'Former Name Chg'           										}
		,{'-' 	,'No Relevant Information'										  }
	], layout_Weekly_Indicators);
	           
	export fTranslateWeeklyInd(string pIndicator) :=
	function
		
		lcode := dWeekly_Indicators.code;
		source_filter 		:= 	(		trim(pIndicator,left,right) = trim(lcode,left,right)
																);
		dsource 					:= dWeekly_Indicators(source_filter		)[1].description;
		returnDescription := dsource;
		return if(returnDescription != '', returnDescription, pIndicator);
	end;

	export TranslateWeeklyInd(string2 pIndicator) := fTranslateWeeklyInd(pIndicator);		

	//convert multiple sources for source match usage
	export str_convert_property := 'PP';
	export str_convert_utility  := 'UU';
	export str_convert_ATF      := 'AF';
	export str_convert_DL       := 'DR';
	export str_convert_vehicle  := 'VV';
	export str_convert_WC       := 'WC';
	export filter_from_moxie    := ['TS','CY','EN'] ; 
		 
END;