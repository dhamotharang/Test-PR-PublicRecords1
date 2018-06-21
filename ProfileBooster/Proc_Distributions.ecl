EXPORT Proc_Distributions (string Version, string PBWU) := function

iMPORT ProfileBooster;

Myda_MM   := DATASET('~in::marketmagnifier::profileboosterin::' + Version + '::profile_booster_attributes_thor_' + PBWU,ProfileBooster.Layouts.Layout_PB_BatchOutFlat,CSV(HEADING(1),SEPARATOR(','),quote('"'),MAXLENGTH(4655)));

DS_Populated   := TABLE(Myda_MM,{Myda_MM,
	STRING1	Populated_v1_crtrecbkrptcnt				   				:= if((integer)v1_crtrecbkrptcnt	      	    	> 0,'Y','N'),
	STRING1	Populated_v1_crtrecbkrptcnt12mo				   		:= if((integer)v1_crtrecbkrptcnt12mo	      	  > 0,'Y','N'),
	STRING1	Populated_v1_crtrecbkrpttimenewest			   	:= if((integer)v1_crtrecbkrpttimenewest    	    > 0,'Y','N'),
	STRING1	Populated_v1_crtreccnt					  	 				:= if((integer)v1_crtreccnt		      	    			> 0,'Y','N'),
	STRING1	Populated_v1_crtreccnt12mo				   				:= if((integer)v1_crtreccnt12mo	      	    		> 0,'Y','N'),
	STRING1	Populated_v1_crtrecevictioncnt				   		:= if((integer)v1_crtrecevictioncnt	      	    > 0,'Y','N'),
	STRING1	Populated_v1_crtrecevictioncnt12mo			   	:= if((integer)v1_crtrecevictioncnt12mo	    		> 0,'Y','N'),
	STRING1	Populated_v1_crtrecevictiontimenewest			  := if((integer)v1_crtrecevictiontimenewest	    > 0,'Y','N'),
	STRING1	Populated_v1_crtrecfelonycnt				   			:= if((integer)v1_crtrecfelonycnt		    				> 0,'Y','N'),
	STRING1	Populated_v1_crtrecfelonycnt12mo			   		:= if((integer)v1_crtrecfelonycnt12mo	   	 			> 0,'Y','N'),
	STRING1	Populated_v1_crtrecfelonytimenewest			   	:= if((integer)v1_crtrecfelonytimenewest	    	> 0,'Y','N'),
	STRING1	Populated_v1_crtreclienjudgcnt				   		:= if((integer)v1_crtreclienjudgcnt		    			> 0,'Y','N'),
	STRING1	Populated_v1_crtreclienjudgcnt12mo			   	:= if((integer)v1_crtreclienjudgcnt12mo	    		> 0,'Y','N'),
	STRING1	Populated_v1_crtrecmsdmeancnt				   			:= if((integer)v1_crtrecmsdmeancnt		    			> 0,'Y','N'),
	STRING1	Populated_v1_crtrecmsdmeancnt12mo			   		:= if((integer)v1_crtrecmsdmeancnt12mo	    		> 0,'Y','N'),
	STRING1	Populated_v1_crtrecmsdmeantimenewest			  := if((integer)v1_crtrecmsdmeantimenewest	    	> 0,'Y','N'),
	STRING1	Populated_v1_crtrectimenewest				   			:= if((integer)v1_crtrectimenewest		    			> 0,'Y','N'),
	STRING1	Populated_v1_hhcnt					   							:= if((integer)v1_hhcnt			    								> 0,'Y','N'),
	STRING1	Populated_v1_hhcollege2yrattendedmmbrcnt		:= if((integer)v1_hhcollege2yrattendedmmbrcnt   > 0,'Y','N'),
	STRING1	Populated_v1_hhcollege4yrattendedmmbrcnt		:= if((integer)v1_hhcollege4yrattendedmmbrcnt   > 0,'Y','N'),
	STRING1	Populated_v1_hhcollegeattendedmmbrcnt			  := if((integer)v1_hhcollegeattendedmmbrcnt	    > 0,'Y','N'),
	STRING1	Populated_v1_hhcollegegradattendedmmbrcnt		:= if((integer)v1_hhcollegegradattendedmmbrcnt  > 0,'Y','N'),
	STRING1	Populated_v1_hhcollegeprivatemmbrcnt			  := if((integer)v1_hhcollegeprivatemmbrcnt	    	> 0,'Y','N'),
	STRING1	Populated_v1_hhcollegetiermmbrhighest			  := if((integer)v1_hhcollegetiermmbrhighest	    > 0,'Y','N'),
	STRING1	Populated_v1_hhcrtrecbkrptmmbrcnt			   		:= if((integer)v1_hhcrtrecbkrptmmbrcnt	    		> 0,'Y','N'),
	STRING1	Populated_v1_hhcrtrecbkrptmmbrcnt12mo			  := if((integer)v1_hhcrtrecbkrptmmbrcnt12mo	    > 0,'Y','N'),
	STRING1	Populated_v1_hhcrtrecbkrptmmbrcnt24mo			  := if((integer)v1_hhcrtrecbkrptmmbrcnt24mo	    > 0,'Y','N'),
	STRING1	Populated_v1_hhcrtrecevictionmmbrcnt			  := if((integer)v1_hhcrtrecevictionmmbrcnt	    	> 0,'Y','N'),
	STRING1	Populated_v1_hhcrtrecevictionmmbrcnt12mo		:= if((integer)v1_hhcrtrecevictionmmbrcnt12mo   > 0,'Y','N'),
	STRING1	Populated_v1_hhcrtrecfelonymmbrcnt			   	:= if((integer)v1_hhcrtrecfelonymmbrcnt	    		> 0,'Y','N'),
	STRING1	Populated_v1_hhcrtrecfelonymmbrcnt12mo			:= if((integer)v1_hhcrtrecfelonymmbrcnt12mo	    > 0,'Y','N'),
	STRING1	Populated_v1_hhcrtreclienjudgmmbrcnt			  := if((integer)v1_hhcrtreclienjudgmmbrcnt	    	> 0,'Y','N'),
	STRING1	Populated_v1_hhcrtreclienjudgmmbrcnt12mo		:= if((integer)v1_hhcrtreclienjudgmmbrcnt12mo   > 0,'Y','N'),
	STRING1	Populated_v1_hhcrtrecmmbrcnt				   			:= if((integer)v1_hhcrtrecmmbrcnt		    				> 0,'Y','N'),
	STRING1	Populated_v1_hhcrtrecmmbrcnt12mo			   		:= if((integer)v1_hhcrtrecmmbrcnt12mo	    			> 0,'Y','N'),
	STRING1	Populated_v1_hhcrtrecmsdmeanmmbrcnt			   	:= if((integer)v1_hhcrtrecmsdmeanmmbrcnt	    	> 0,'Y','N'),
	STRING1	Populated_v1_hhcrtrecmsdmeanmmbrcnt12mo			:= if((integer)v1_hhcrtrecmsdmeanmmbrcnt12mo	  > 0,'Y','N'),
	STRING1	Populated_v1_hhelderlymmbrcnt				   			:= if((integer)v1_hhelderlymmbrcnt		    			> 0,'Y','N'),
	STRING1	Populated_v1_hhinterestsportpersonmmbrcnt		:= if((integer)v1_hhinterestsportpersonmmbrcnt  > 0,'Y','N'),
	STRING1	Populated_v1_hhmiddleagemmbrcnt				   		:= if((integer)v1_hhmiddleagemmbrcnt		   			> 0,'Y','N'),
	STRING1	Populated_v1_hhoccbusinessassocmmbrcnt			:= if((integer)v1_hhoccbusinessassocmmbrcnt	    > 0,'Y','N'),
	STRING1	Populated_v1_hhoccproflicmmbrcnt			   		:= if((integer)v1_hhoccproflicmmbrcnt	    			> 0,'Y','N'),
	STRING1	Populated_v1_hhppcurrownedaircrftcnt			  := if((integer)v1_hhppcurrownedaircrftcnt	  	  > 0,'Y','N'),
	STRING1	Populated_v1_hhppcurrownedautocnt			   		:= if((integer)v1_hhppcurrownedautocnt	    		> 0,'Y','N'),
	STRING1	Populated_v1_hhppcurrownedcnt				   			:= if((integer)v1_hhppcurrownedcnt		    			> 0,'Y','N'),
	STRING1	Populated_v1_hhppcurrownedmtrcyclecnt			  := if((integer)v1_hhppcurrownedmtrcyclecnt	    > 0,'Y','N'),
	STRING1	Populated_v1_hhppcurrownedwtrcrftcnt			  := if((integer)v1_hhppcurrownedwtrcrftcnt	    	> 0,'Y','N'),
	STRING1	Populated_v1_hhpropcurrownedcnt				   		:= if((integer)v1_hhpropcurrownedcnt		    		> 0,'Y','N'),
	STRING1	Populated_v1_hhpropcurrownermmbrcnt			   	:= if((integer)v1_hhpropcurrownermmbrcnt	    	> 0,'Y','N'),
	STRING1	Populated_v1_hhseniormmbrcnt				   			:= if((integer)v1_hhseniormmbrcnt		    				> 0,'Y','N'),
	STRING1	Populated_v1_hhyoungadultmmbrcnt			   		:= if((integer)v1_hhyoungadultmmbrcnt	    			> 0,'Y','N'),
	STRING1	Populated_v1_lifeevecontrajectory			   		:= if((integer)v1_lifeevecontrajectory	    		> 0,'Y','N'),
	STRING1	Populated_v1_lifeevecontrajectoryindex			:= if((integer)v1_lifeevecontrajectoryindex	    > 0,'Y','N'),
	STRING1	Populated_v1_lifeeveverresidedcnt			   		:= if((integer)v1_lifeeveverresidedcnt	    		> 0,'Y','N'),
	STRING1	Populated_v1_lifeevtimefirstassetpurchase		:= if((integer)v1_lifeevtimefirstassetpurchase  > 0,'Y','N'),
	STRING1	Populated_v1_lifeevtimelastassetpurchase		:= if((integer)v1_lifeevtimelastassetpurchase   > 0,'Y','N'),
	STRING1	Populated_v1_lifeevtimelastmove				   		:= if((integer)v1_lifeevtimelastmove		    		> 0,'Y','N'),
	STRING1	Populated_v1_occbusinessassociationtime			:= if((integer)v1_occbusinessassociationtime	  > 0,'Y','N'),
	STRING1	Populated_v1_ppcurrownedaircrftcnt			   	:= if((integer)v1_ppcurrownedaircrftcnt	    		> 0,'Y','N'),
	STRING1	Populated_v1_ppcurrownedautocnt				   		:= if((integer)v1_ppcurrownedautocnt		    		> 0,'Y','N'),
	STRING1	Populated_v1_ppcurrownedcnt				   				:= if((integer)v1_ppcurrownedcnt		    				> 0,'Y','N'),
	STRING1	Populated_v1_ppcurrownedmtrcyclecnt			   	:= if((integer)v1_ppcurrownedmtrcyclecnt	    	> 0,'Y','N'),
	STRING1	Populated_v1_ppcurrownedwtrcrftcnt			   	:= if((integer)v1_ppcurrownedwtrcrftcnt	    		> 0,'Y','N'),
	STRING1	Populated_v1_propcurrownedcnt				   			:= if((integer)v1_propcurrownedcnt		    			> 0,'Y','N'),
	STRING1	Populated_v1_propeverownedcnt				   			:= if((integer)v1_propeverownedcnt		    			> 0,'Y','N'),
	STRING1	Populated_v1_propeversoldcnt				   			:= if((integer)v1_propeversoldcnt		    				> 0,'Y','N'),
	STRING1	Populated_v1_proppurchasecnt12mo			   		:= if((integer)v1_proppurchasecnt12mo           > 0,'Y','N'),
	STRING1	Populated_v1_propsoldcnt12mo				   			:= if((integer)v1_propsoldcnt12mo	            	> 0,'Y','N'),
	STRING1	Populated_v1_proptimelastsale				   			:= if((integer)v1_proptimelastsale	            > 0,'Y','N'),
	STRING1	Populated_v1_prospectage				   					:= if((integer)v1_prospectage	            			> 0,'Y','N'),
	STRING1	Populated_v1_prospecttimelastupdate			   	:= if((integer)v1_prospecttimelastupdate        > 0,'Y','N'),
	STRING1	Populated_v1_prospecttimeonrecord			   		:= if((integer)v1_prospecttimeonrecord          > 0,'Y','N'),
	STRING1	Populated_v1_raacollege2yrattendedmmbrcnt		:= if((integer)v1_raacollege2yrattendedmmbrcnt  > 0,'Y','N'),
	STRING1	Populated_v1_raacollege4yrattendedmmbrcnt		:= if((integer)v1_raacollege4yrattendedmmbrcnt  > 0,'Y','N'),
	STRING1	Populated_v1_raacollegeattendedmmbrcnt			:= if((integer)v1_raacollegeattendedmmbrcnt	    > 0,'Y','N'),
	STRING1	Populated_v1_raacollegegradattendedmmbrcnt	:= if((integer)v1_raacollegegradattendedmmbrcnt > 0,'Y','N'),
	STRING1	Populated_v1_raacollegelowtiermmbrcnt			  := if((integer)v1_raacollegelowtiermmbrcnt	    > 0,'Y','N'),
	STRING1	Populated_v1_raacollegemidtiermmbrcnt			  := if((integer)v1_raacollegemidtiermmbrcnt	    > 0,'Y','N'),
	STRING1	Populated_v1_raacollegeprivatemmbrcnt			  := if((integer)v1_raacollegeprivatemmbrcnt	    > 0,'Y','N'),
	STRING1	Populated_v1_raacollegetoptiermmbrcnt			  := if((integer)v1_raacollegetoptiermmbrcnt	    > 0,'Y','N'),
	STRING1	Populated_v1_raacrtrecbkrptmmbrcnt36mo			:= if((integer)v1_raacrtrecbkrptmmbrcnt36mo	    > 0,'Y','N'),
	STRING1	Populated_v1_raacrtrecevictionmmbrcnt			  := if((integer)v1_raacrtrecevictionmmbrcnt	    > 0,'Y','N'),
	STRING1	Populated_v1_raacrtrecevictionmmbrcnt12mo		:= if((integer)v1_raacrtrecevictionmmbrcnt12mo  > 0,'Y','N'),
	
	STRING1	Populated_V1_RAACRTRECFELONYMMBRCNT									:= if((integer)V1_RAACRTRECFELONYMMBRCNT  > 0,'Y','N'),
	STRING1	Populated_V1_RAACRTRECFELONYMMBRCNT12MO					:= if((integer)V1_RAACRTRECFELONYMMBRCNT12MO  > 0,'Y','N'),
	STRING1	Populated_V1_RAACRTRECLIENJUDGMMBRCNT							:= if((integer)V1_RAACRTRECLIENJUDGMMBRCNT  > 0,'Y','N'),
	STRING1	Populated_V1_RAACRTRECLIENJUDGMMBRCNT12MO			:= if((integer)V1_RAACRTRECLIENJUDGMMBRCNT12MO  > 0,'Y','N'),

	STRING1	Populated_v1_raacrtrecmmbrcnt				   			:= if((integer)v1_raacrtrecmmbrcnt		    			> 0,'Y','N'),
	STRING1	Populated_v1_raacrtrecmmbrcnt12mo			   		:= if((integer)v1_raacrtrecmmbrcnt12mo	    		> 0,'Y','N'),
	STRING1	Populated_v1_raacrtrecmsdmeanmmbrcnt			  := if((integer)v1_raacrtrecmsdmeanmmbrcnt	    	> 0,'Y','N'),
	STRING1	Populated_v1_raacrtrecmsdmeanmmbrcnt12mo		:= if((integer)v1_raacrtrecmsdmeanmmbrcnt12mo   > 0,'Y','N'),
	STRING1	Populated_v1_raaelderlymmbrcnt				   		:= if((integer)v1_raaelderlymmbrcnt		    			> 0,'Y','N'),
	STRING1	Populated_v1_raahhcnt					   						:= if((integer)v1_raahhcnt			    						> 0,'Y','N'),
	STRING1	Populated_v1_raainterestsportpersonmmbrcnt	:= if((integer)v1_raainterestsportpersonmmbrcnt > 0,'Y','N'),
	STRING1	Populated_v1_raamiddleagemmbrcnt			   		:= if((integer)v1_raamiddleagemmbrcnt	    			> 0,'Y','N'),
	STRING1	Populated_v1_raammbrcnt					   					:= if((integer)v1_raammbrcnt			    					> 0,'Y','N'),
	STRING1	Populated_v1_raaoccbusinessassocmmbrcnt			:= if((integer)v1_raaoccbusinessassocmmbrcnt	  > 0,'Y','N'),
	STRING1	Populated_v1_raaoccproflicmmbrcnt			   		:= if((integer)v1_raaoccproflicmmbrcnt	    		> 0,'Y','N'),
	STRING1	Populated_v1_raappcurrowneraircrftmmbrcnt		:= if((integer)v1_raappcurrowneraircrftmmbrcnt  > 0,'Y','N'),
	STRING1	Populated_v1_raappcurrownerautommbrcnt			:= if((integer)v1_raappcurrownerautommbrcnt	    > 0,'Y','N'),
	STRING1	Populated_v1_raappcurrownermmbrcnt			   	:= if((integer)v1_raappcurrownermmbrcnt	    		> 0,'Y','N'),
	STRING1	Populated_v1_raappcurrownermtrcyclemmbrcnt	:= if((integer)v1_raappcurrownermtrcyclemmbrcnt > 0,'Y','N'),
	STRING1	Populated_v1_raappcurrownerwtrcrftmmbrcnt		:= if((integer)v1_raappcurrownerwtrcrftmmbrcnt  > 0,'Y','N'),
	STRING1	Populated_v1_raapropcurrownermmbrcnt			  := if((integer)v1_raapropcurrownermmbrcnt	    	> 0,'Y','N'),
	STRING1	Populated_v1_raaseniormmbrcnt				   			:= if((integer)v1_raaseniormmbrcnt		    			> 0,'Y','N'),
	STRING1	Populated_v1_raayoungadultmmbrcnt			   		:= if((integer)v1_raayoungadultmmbrcnt	    		> 0,'Y','N'),
	STRING1	Populated_v1_rescurravmblockratio			   		:= if((integer)v1_rescurravmblockratio	    		> 0,'Y','N'),
	STRING1	Populated_v1_rescurravmcntyratio			   		:= if((integer)v1_rescurravmcntyratio	    			> 0,'Y','N'),
	STRING1	Populated_v1_rescurravmratiodiff12mo			  := if((integer)v1_rescurravmratiodiff12mo	    	> 0,'Y','N'),
	STRING1	Populated_v1_rescurravmratiodiff60mo			  := if((integer)v1_rescurravmratiodiff60mo	    	> 0,'Y','N'),
	STRING1	Populated_v1_rescurravmtractratio			   		:= if((integer)v1_rescurravmtractratio	    		> 0,'Y','N'),
	STRING1	Populated_v1_rescurrbusinesscnt				   		:= if((integer)v1_rescurrbusinesscnt		    		> 0,'Y','N'),
	STRING1	Populated_v1_resinputavmblockratio			   	:= if((integer)v1_resinputavmblockratio	    		> 0,'Y','N'),
	STRING1	Populated_v1_resinputavmratiodiff12mo			  := if((integer)v1_resinputavmratiodiff12mo	    > 0,'Y','N'),
	STRING1	Populated_v1_resinputavmratiodiff60mo			  := if((integer)v1_resinputavmratiodiff60mo	    > 0,'Y','N'),
	STRING1	Populated_v1_resinputavmtractratio			   	:= if((integer)v1_resinputavmtractratio	    		> 0,'Y','N'),
	STRING1	Populated_v1_resinputbusinesscnt			   		:= if((integer)v1_resinputbusinesscnt	    			> 0,'Y','N'),
	STRING1	Populated_V1_PropCurrOwnedAssessedTtl			  := if((integer)V1_PropCurrOwnedAssessedTtl 	    > 0,'Y','N'),	
	STRING1	Populated_V1_PropCurrOwnedAVMTtl 			   		:= if((integer)V1_PropCurrOwnedAVMTtl 	    		> 0,'Y','N'),	
	STRING1	Populated_V1_ResCurrAVMValue 				   			:= if((integer)V1_ResCurrAVMValue 		    			> 0,'Y','N'),	
	STRING1	Populated_V1_ResCurrAVMValue12Mo 			   		:= if((integer)V1_ResCurrAVMValue12Mo 	    		> 0,'Y','N'),	
	STRING1	Populated_V1_ResCurrMortgageAmount 			   	:= if((integer)V1_ResCurrMortgageAmount 	    	> 0,'Y','N'),	
	STRING1	Populated_V1_ResInputAVMValue 				   		:= if((integer)V1_ResInputAVMValue 		    			> 0,'Y','N'),	
	STRING1	Populated_V1_ResInputAVMValue12Mo 			   	:= if((integer)V1_ResInputAVMValue12Mo 	    		> 0,'Y','N'),	
	STRING1	Populated_V1_ResInputAVMValue60Mo 			   	:= if((integer)V1_ResInputAVMValue60Mo 	    		> 0,'Y','N'),	
	STRING1	Populated_V1_ResInputMortgageAmount 			  := if((integer)V1_ResInputMortgageAmount  			> 0,'Y','N'),	
	STRING1	Populated_V1_CrtRecLienJudgAmtTtl 			   	:= if((integer)V1_CrtRecLienJudgAmtTtl 	    		> 0,'Y','N'),	
	STRING1	Populated_V1_HHPropCurrAVMHighest 			   	:= if((integer)V1_HHPropCurrAVMHighest 	    		> 0,'Y','N'),	
	STRING1	Populated_V1_HHCrtRecLienJudgAmtTtl 			  := if((integer)V1_HHCrtRecLienJudgAmtTtl        > 0,'Y','N'),	
	STRING1	Populated_V1_RaAPropOwnerAVMHighest 			  := if((integer)V1_RaAPropOwnerAVMHighest        > 0,'Y','N'),	
	STRING1	Populated_V1_RaAPropOwnerAVMMed 			   		:= if((integer)V1_RaAPropOwnerAVMMed 	    			> 0,'Y','N'),		
	STRING1	Populated_V1_RaACrtRecLienJudgAmtMax 			  := if((integer)V1_RaACrtRecLienJudgAmtMax       > 0,'Y','N'),	
	string1 Populated_V1_LIFEEVLASTMOVETAXRATIODIFF     := if((integer)V1_LIFEEVLASTMOVETAXRATIODIFF    > 0,'Y','N'),	
	string1 Populated_V1_CRTRECLIENJUDGTIMENEWEST       := if((integer)V1_CRTRECLIENJUDGTIMENEWEST      > 0,'Y','N'),	
	string1 Populated_V1_PROPSOLDRATIO                  := if((integer)V1_PROPSOLDRATIO                 > 0,'Y','N')
		 });
		 
		 DISTRIBUTION(DS_Populated 
,v1_assetcurrowner
,v1_crtrecseverityindex
,v1_donotmail
,v1_hhestimatedincomerange
,v1_interestsportperson
,v1_lifeevnamechange
,v1_lifeevnamechangecnt12mo
,v1_occbusinessassociation
,v1_occbusinesstitleleadership
,v1_occproflicense
,v1_occproflicensecategory
,v1_ppcurrowner
,v1_propcurrowner
,v1_prospectbankingexperience
,v1_prospectcollegeattended
,v1_prospectcollegeattending
,v1_prospectcollegeprivate
,v1_prospectcollegeprogramtype
,v1_prospectcollegetier
,v1_prospectdeceased
,v1_prospectestimatedincomerange
,v1_prospectgender
,v1_prospectlastupdate12mo
,v1_prospectmaritalstatus
,v1_raamedincomerange
,v1_raateenagemmbrcnt
,v1_rescurrdwelltype
,v1_rescurrdwelltypeindex
,v1_rescurrmortgagetype
,v1_rescurrownershipindex
,v1_resinputdwelltype
,v1_resinputdwelltypeindex
,v1_resinputmortgagetype
,v1_resinputownershipindex
,v1_verifiedcurrresmatchindex
,v1_verifiedname
,v1_verifiedphone
,v1_verifiedprospectfound
,v1_verifiedssn

,Populated_v1_crtrecbkrptcnt			
,Populated_v1_crtrecbkrptcnt12mo			
,Populated_v1_crtrecbkrpttimenewest		
,Populated_v1_crtreccnt				
,Populated_v1_crtreccnt12mo			
,Populated_v1_crtrecevictioncnt			
,Populated_v1_crtrecevictioncnt12mo		
,Populated_v1_crtrecevictiontimenewest		
,Populated_v1_crtrecfelonycnt			
,Populated_v1_crtrecfelonycnt12mo		
,Populated_v1_crtrecfelonytimenewest		
,Populated_v1_crtreclienjudgcnt			
,Populated_v1_crtreclienjudgcnt12mo		
,Populated_v1_crtrecmsdmeancnt			
,Populated_v1_crtrecmsdmeancnt12mo		
,Populated_v1_crtrecmsdmeantimenewest		
,Populated_v1_crtrectimenewest			
,Populated_v1_hhcnt				
,Populated_v1_hhcollege2yrattendedmmbrcnt	
,Populated_v1_hhcollege4yrattendedmmbrcnt	
,Populated_v1_hhcollegeattendedmmbrcnt		
,Populated_v1_hhcollegegradattendedmmbrcnt	
,Populated_v1_hhcollegeprivatemmbrcnt		
,Populated_v1_hhcollegetiermmbrhighest		
,Populated_v1_hhcrtrecbkrptmmbrcnt		
,Populated_v1_hhcrtrecbkrptmmbrcnt12mo		
,Populated_v1_hhcrtrecbkrptmmbrcnt24mo		
,Populated_v1_hhcrtrecevictionmmbrcnt		
,Populated_v1_hhcrtrecevictionmmbrcnt12mo	
,Populated_v1_hhcrtrecfelonymmbrcnt		
,Populated_v1_hhcrtrecfelonymmbrcnt12mo		
,Populated_v1_hhcrtreclienjudgmmbrcnt		
,Populated_v1_hhcrtreclienjudgmmbrcnt12mo	
,Populated_v1_hhcrtrecmmbrcnt			
,Populated_v1_hhcrtrecmmbrcnt12mo		
,Populated_v1_hhcrtrecmsdmeanmmbrcnt		
,Populated_v1_hhcrtrecmsdmeanmmbrcnt12mo		
,Populated_v1_hhelderlymmbrcnt			
,Populated_v1_hhinterestsportpersonmmbrcnt	
,Populated_v1_hhmiddleagemmbrcnt			
,Populated_v1_hhoccbusinessassocmmbrcnt		
,Populated_v1_hhoccproflicmmbrcnt		
,Populated_v1_hhppcurrownedaircrftcnt		
,Populated_v1_hhppcurrownedautocnt		
,Populated_v1_hhppcurrownedcnt			
,Populated_v1_hhppcurrownedmtrcyclecnt		
,Populated_v1_hhppcurrownedwtrcrftcnt		
,Populated_v1_hhpropcurrownedcnt			
,Populated_v1_hhpropcurrownermmbrcnt		
,Populated_v1_hhseniormmbrcnt			
,Populated_v1_hhyoungadultmmbrcnt		
,Populated_v1_lifeevecontrajectory		
,Populated_v1_lifeevecontrajectoryindex		
,Populated_v1_lifeeveverresidedcnt		
,Populated_v1_lifeevtimefirstassetpurchase	
,Populated_v1_lifeevtimelastassetpurchase	
,Populated_v1_lifeevtimelastmove			
,Populated_v1_occbusinessassociationtime		
,Populated_v1_ppcurrownedaircrftcnt		
,Populated_v1_ppcurrownedautocnt			
,Populated_v1_ppcurrownedcnt			
,Populated_v1_ppcurrownedmtrcyclecnt		
,Populated_v1_ppcurrownedwtrcrftcnt		
,Populated_v1_propcurrownedcnt			
,Populated_v1_propeverownedcnt			
,Populated_v1_propeversoldcnt			
,Populated_v1_proppurchasecnt12mo		
,Populated_v1_propsoldcnt12mo			
,Populated_v1_proptimelastsale			
,Populated_v1_prospectage			
,Populated_v1_prospecttimelastupdate		
,Populated_v1_prospecttimeonrecord		
,Populated_v1_raacollege2yrattendedmmbrcnt	
,Populated_v1_raacollege4yrattendedmmbrcnt	
,Populated_v1_raacollegeattendedmmbrcnt		
,Populated_v1_raacollegegradattendedmmbrcnt	
,Populated_v1_raacollegelowtiermmbrcnt		
,Populated_v1_raacollegemidtiermmbrcnt		
,Populated_v1_raacollegeprivatemmbrcnt		
,Populated_v1_raacollegetoptiermmbrcnt		
,Populated_v1_raacrtrecbkrptmmbrcnt36mo		
,Populated_v1_raacrtrecevictionmmbrcnt		
,Populated_v1_raacrtrecevictionmmbrcnt12mo	
,Populated_v1_raacrtrecmmbrcnt			
,Populated_v1_raacrtrecmmbrcnt12mo		
,Populated_v1_raacrtrecmsdmeanmmbrcnt		
,Populated_v1_raacrtrecmsdmeanmmbrcnt12mo	
,Populated_v1_raaelderlymmbrcnt			
,Populated_v1_raahhcnt				
,Populated_v1_raainterestsportpersonmmbrcnt	
,Populated_v1_raamiddleagemmbrcnt		
,Populated_v1_raammbrcnt				
,Populated_v1_raaoccbusinessassocmmbrcnt		
,Populated_v1_raaoccproflicmmbrcnt		
,Populated_v1_raappcurrowneraircrftmmbrcnt	
,Populated_v1_raappcurrownerautommbrcnt		
,Populated_v1_raappcurrownermmbrcnt		
,Populated_v1_raappcurrownermtrcyclemmbrcnt	
,Populated_v1_raappcurrownerwtrcrftmmbrcnt	
,Populated_v1_raapropcurrownermmbrcnt		
,Populated_v1_raaseniormmbrcnt			
,Populated_v1_raayoungadultmmbrcnt		
,Populated_v1_rescurravmblockratio		
,Populated_v1_rescurravmcntyratio		
,Populated_v1_rescurravmratiodiff12mo		
,Populated_v1_rescurravmratiodiff60mo		
,Populated_v1_rescurravmtractratio		
,Populated_v1_rescurrbusinesscnt			
,Populated_v1_resinputavmblockratio		
,Populated_v1_resinputavmratiodiff12mo		
,Populated_v1_resinputavmratiodiff60mo		
,Populated_v1_resinputavmtractratio		
,Populated_v1_resinputbusinesscnt		
,Populated_V1_PropCurrOwnedAssessedTtl		
,Populated_V1_PropCurrOwnedAVMTtl 		
,Populated_V1_ResCurrAVMValue 			
,Populated_V1_ResCurrAVMValue12Mo 		
,Populated_V1_ResCurrMortgageAmount 		
,Populated_V1_ResInputAVMValue 			
,Populated_V1_ResInputAVMValue12Mo 		
,Populated_V1_ResInputAVMValue60Mo 		
,Populated_V1_ResInputMortgageAmount 		
,Populated_V1_CrtRecLienJudgAmtTtl 		
,Populated_V1_HHPropCurrAVMHighest 		
,Populated_V1_HHCrtRecLienJudgAmtTtl 		
,Populated_V1_RaAPropOwnerAVMHighest 		
,Populated_V1_RaAPropOwnerAVMMed 		
,Populated_V1_RaACrtRecLienJudgAmtMax 		
,Populated_V1_LIFEEVLASTMOVETAXRATIODIFF     	
,Populated_V1_CRTRECLIENJUDGTIMENEWEST       	
,Populated_V1_PROPSOLDRATIO     
,Populated_V1_RAACRTRECFELONYMMBRCNT						
,Populated_V1_RAACRTRECFELONYMMBRCNT12MO		
,Populated_V1_RAACRTRECLIENJUDGMMBRCNT				
,Populated_V1_RAACRTRECLIENJUDGMMBRCNT12MO             	
,NAMED('MMPart2_Profilebooster'));	

RETURN 0;

END;