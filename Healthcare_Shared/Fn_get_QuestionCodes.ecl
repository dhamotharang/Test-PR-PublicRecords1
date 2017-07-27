IMPORT ut, std;
EXPORT Fn_get_QuestionCodes := Module

	// Hbp flag is hospital based physician flag.
	export get_hbp_flag(string50 taxonomy) := function
		return taxonomy in ['2085B0100X','2085D0003X','2085H0002X','2085N0700X','2085N0904X','2085P0229X','2085R0001X','2085R0202X','2085R0203X','2085R0204X','2085R0205X','2085U0001X','207ZB0001X','207ZC0006X','207ZC0500X','207ZD0900X','207ZF0201X','207ZH0000X','207ZI0100X','207ZM0300X','207ZN0500X','207ZP0007X','207ZP0101X','207ZP0102X','207ZP0104X','207ZP0105X','207ZP0213X','207L00000X','207LA0401X','207LC0200X','207LH0002X','207LP2900X','207LP3000X'];		
	end;

	export getCode(boolean srcIndividualHeader, boolean srcBusinessHeader, integer npi_ustat, integer taxonomy_ustat, integer license_ustat,integer sanction_ustat,integer addr_ustat,integer phone_ustat,
									integer provider_ustat,integer dos_ustat,integer name_ustat,integer	oig_sanction_ustat,integer	opm_sanction_ustat,string8 servicefromdate,
									string stateorfederal,string8	sanc1_date,string10 sanc1_code,string2	sanc1_state,string2 prac1_state,string8 load_date,
									string2 aug_lic1_state,string2 lic_state_in,string provider_status,string npi_deact_date,string8 prac_corr_last_update_date,string50 taxonomy,
									boolean state_restrict_flag,string aug_npi_num,	string npi_num,	string aug_npi_deact_date,string npi_verif_st) := Function
				// Provider 		
				p1 := provider_ustat & Healthcare_Shared.Constants.ustat_Provider_NotFound > 0;	// 1
				p2 := provider_ustat & Healthcare_Shared.Constants.ustat_Provider_Retired_R4 > 0; // 2
				p3 := provider_ustat & Healthcare_Shared.Constants.ustat_Provider_Rpt_Deceased_U1 > 0;	// 4
				p4 := provider_ustat & Healthcare_Shared.Constants.ustat_Provider_Confirm_Deceased > 0;	// 8
				p5 := provider_ustat & Healthcare_Shared.Constants.ustat_Provider_InactLicPracState	 > 0; //    16
				p6 := provider_ustat & Healthcare_Shared.Constants.ustat_Provider_ExpLicPracState	 > 0; 	// 	32
				p7 := provider_ustat & Healthcare_Shared.Constants.ustat_Provider_DEARetired	 > 0; 	// 	64
				p8 := provider_ustat & Healthcare_Shared.Constants.ustat_Provider_NoActLicPracState	 > 0; 	// 	128
				p9 := provider_ustat & Healthcare_Shared.Constants.ustat_Provider_RestrictLicPracState	 > 0; 	// 	256
				p10 := provider_ustat & Healthcare_Shared.Constants.ustat_Provider_SuspendLicPracState	 > 0; 	// 	512
				// Dos
				d1 := dos_ustat & Healthcare_Shared.Constants.ustat_Dos_Missing	> 0;  // 1
				d2 := dos_ustat & Healthcare_Shared.Constants.ustat_Dos_DeaRetiredPrior	> 0;  // 4	
				d3 := dos_ustat & Healthcare_Shared.Constants.ustat_Dos_DeaExpiredPrior	> 0;  // 8
				d4 := dos_ustat & Healthcare_Shared.Constants.ustat_Dos_NpiDeactivatedPrior	> 0;  // 16
				d5 := dos_ustat & Healthcare_Shared.Constants.ustat_Dos_PracAddrInactivePrior	> 0;  // 32
				d6 := dos_ustat & Healthcare_Shared.Constants.ustat_Dos_LicenseExpiredPrior	> 0; // 128
				d7 := dos_ustat & Healthcare_Shared.Constants.ustat_Dos_ReportedDeceasedWithin	> 0;  // 2048 
				d8 := dos_ustat & Healthcare_Shared.Constants.ustat_Dos_ProviderDeceasedPrior	> 0;  // 4096
				// Current OIG/OPM providerInfo
				os1 := oig_sanction_ustat & Healthcare_Shared.Constants.ustat_OIG_Current_FAB > 0; // 1
				os2 := oig_sanction_ustat & Healthcare_Shared.Constants.ustat_OIG_Current_License > 0; // 2
				os3 := oig_sanction_ustat & Healthcare_Shared.Constants.ustat_OIG_Current_Program > 0; // 4
				os4 := oig_sanction_ustat & Healthcare_Shared.Constants.ustat_OIG_Current_Quality > 0; // 8
				os5 := oig_sanction_ustat & Healthcare_Shared.Constants.ustat_OIG_Current_RX > 0; // 16
				os6 := oig_sanction_ustat & Healthcare_Shared.Constants.ustat_OIG_Current_Other > 0; // 32											
				os7 := oig_sanction_ustat & Healthcare_Shared.Constants.ustat_OIG_History_FAB > 0; // 64
				os8 := oig_sanction_ustat & Healthcare_Shared.Constants.ustat_OIG_History_License > 0; // 128
				os9 := oig_sanction_ustat & Healthcare_Shared.Constants.ustat_OIG_History_Program > 0; // 256
				os10 := oig_sanction_ustat & Healthcare_Shared.Constants.ustat_OIG_History_Quality > 0; // 512
				os11 := oig_sanction_ustat & Healthcare_Shared.Constants.ustat_OIG_History_RX > 0; // 1024				
				op1 := opm_sanction_ustat & Healthcare_Shared.Constants.ustat_OPM_Current_Program > 0; //  4
				// State Sanction
				s1 := sanction_ustat & Healthcare_Shared.Constants.ustat_StRestrict_Current_FAB > 0; // 1
				s2 := sanction_ustat & Healthcare_Shared.Constants.ustat_StRestrict_Current_License > 0; // 2
				s3 := sanction_ustat & Healthcare_Shared.Constants.ustat_StRestrict_Current_Program > 0; // 4
				s4 := sanction_ustat & Healthcare_Shared.Constants.ustat_StRestrict_Current_Quality > 0; // 8
				s5 := sanction_ustat & Healthcare_Shared.Constants.ustat_StRestrict_Current_RX > 0; // 16
				s6 := sanction_ustat & Healthcare_Shared.Constants.ustat_StRestrict_Current_Other > 0; // 32											
				s7 := sanction_ustat & Healthcare_Shared.Constants.ustat_StRestrict_History_FAB > 0; // 64
				s8 := sanction_ustat & Healthcare_Shared.Constants.ustat_StRestrict_History_RX > 0; // 1024  
				s9 := sanction_ustat & Healthcare_Shared.Constants.ustat_StRestrict_NonPracSt_Current_FAB > 0; // 8192 
				s10 := sanction_ustat & Healthcare_Shared.Constants.ustat_StRestrict_NonPracSt_Current_RX > 0; // 131072
				s11 := sanction_ustat & Healthcare_Shared.Constants.ustat_StRestrict_NonPracSt_History_FAB > 0; // 524288
				s12 := sanction_ustat & Healthcare_Shared.Constants.ustat_StRestrict_NonPracSt_History_RX > 0; // 8388608
				s13 := sanction_ustat & Healthcare_Shared.Constants.ustat_StRestrict_History_Program > 0; //  256 
				s14 := sanction_ustat & Healthcare_Shared.Constants.ustat_Sanc_OIG_OPM_future > 0; // 16 
				s15 := sanction_ustat & Healthcare_Shared.Constants.ustat_Sanc_prac_StateRestrict_future > 0; // 32 
				// Name
				nm1 := 	name_ustat & Healthcare_Shared.Constants.ustat_Name_Match_NPI_FKA > 0 ; // 32768
				nm2 := 	name_ustat & Healthcare_Shared.Constants.ustat_Name_Match_Last_DEA_Former > 0; // 65536    
				nm3 := 	name_ustat & Healthcare_Shared.Constants.ustat_Name_Match_Last_NPI_Former > 0; // 131072
				// processed_as
				processed_as := MAP(srcIndividualHeader = true => 'I', srcBusinessHeader = true => 'F','');				
				// dos date 
				dos1 := ut.date_math(servicefromdate, -30);
				dos2 := ut.date_math(servicefromdate, -60);
				dos3 := ut.date_math(servicefromdate, -90);
				dt1 := (load_date >= dos1) and (load_date <= servicefromdate);
				dt2 := (load_date >= dos2) and (load_date < dos1);
				dt3 := (load_date >= dos3) and (load_date < dos2);
				// getPracticeStateLicense
				licPracStateFlag := aug_lic1_state <> '' and lic_state_in <> '' and aug_lic1_state =  lic_state_in;
				// Provider QC
				pqc1 := if(p1, 'PJ', ''); //   Provider not found on Enclarity Master Referential Database
				pqc2 := if(p1, '', if(d8, 'PZ', '')); // Confirmed deceased prior to the date of service
				pqc3 := if(p1, '', if(p4, 'PD', '')); // Confirmed Deceased
				pqc4 := if(p1, '', if(d6, 'PO', '')); // License inactive prior to date of service				
				// Provider License suspended in practice state
				pqc5Flag := processed_as = 'I' and p10; 				
				pqc6 := if(p1, '', if(pqc5Flag and licPracStateFlag and dt1, 'PId', '')); // dos > load_date > dos-30
				pqc7 := if(p1, '', if(pqc5Flag and licPracStateFlag and dt2, 'PIe', '')); // dos-30 > load_date > dos-60
				pqc8 := if(p1, '', if(pqc5Flag and licPracStateFlag and dt3, 'PIf', '')); // dos-60 > load_date > dos-90 
				pqc5 := if(p1, '', if(pqc5Flag and pqc6 = '' and pqc7 = '' and pqc8 = '', 'PI1', ''));				
				// Inactive/Retired/Suspended License
				pqc9Flag := processed_as = 'I' and p5; 
				pqc10 := if(p1, '', if(pqc9Flag and licPracStateFlag and dt1, 'PIa', '')); // dos > load_date > dos-30
				pqc11 := if(p1, '', if(pqc9Flag and licPracStateFlag and dt2, 'PIb', '')); // dos-30 > load_date > dos-60
				pqc12 := if(p1, '', if(pqc9Flag and licPracStateFlag and dt3, 'PIc', '')); // dos-60 > load_date > dos-90		
				pqc9   := if(p1, '', if(pqc9Flag and pqc10 = '' and pqc11 = '' and pqc12 = '', 'PI', ''));
				// Restrictive License (idv only)
				pqc13Flag := processed_as = 'I' and p9; 
				pqc14 := if(p1, '', if(pqc13Flag and licPracStateFlag and dt1, 'PBa', '')); // dos > load_date > dos-30
				pqc15 := if(p1, '', if(pqc13Flag and licPracStateFlag and dt2, 'PBb', '')); // dos-30 > load_date > dos-60
				pqc16 := if(p1, '', if(pqc13Flag and licPracStateFlag and dt3, 'PBc', '')); // dos-60 > load_date > dos-90
				pqc13 := if(p1, '', if(pqc13Flag and pqc14 = '' and pqc15 = '' and pqc16 = '', 'PB', '')); //Restrictive License - Individual only  			
				pqc17 := if(p1, '', if(d7, 'PP', '')); // Reported Deceased prior to Date of Service																						
				pqc18 := if(p1, '', if(p3 and provider_status = 'U', 'PU', ''));  		// Unconfirmed Deceased - Strong 99% accurate // 
				pqc19 := if(p1, '', if(p3 and provider_status = 'U1', 'PU1', ''));  // Unconfirmed Deceased // 			
				// Expired license for the practice state (including grace period)
				pqc20Flag :=  processed_as = 'I' and p6; 	 // 
				pqc21 := if(p1, '', if(pqc20Flag and licPracStateFlag and dt1, 'PEa', ''));  // dos > load_date > dos-30
				pqc22 := if(p1, '', if(pqc20Flag and licPracStateFlag and dt2, 'PEb', '')); // dos-30 > load_date > dos-60
				pqc23 := if(p1, '', if(pqc20Flag and licPracStateFlag and dt3, 'PEc', '')); // dos-60 > load_date > dos-90
				pqc20 := if(p1, '', if(pqc20Flag and pqc21 = '' and pqc22 = '' and pqc23 = '', 'PE', ''));				
				pqc24 := if(p1, '', if(processed_as = 'I' and p8, 'PL', '')); // No Active License in the Practice State (idv only)  	
				// Current OIG/OPM providerInfo
				oig_or_opm_sanction_ustat := (os1 and os2 and os3 and os4 and os5 and os6) or op1; 
				pqc25 := if(p1, '', if(oig_or_opm_sanction_ustat and processed_as = 'I', 'PS', '')); 
				pqc26 := if(p1, '', if(oig_or_opm_sanction_ustat and processed_as = 'F', 'PSx', '')); 				
				// Current state sanctions
				pqc27Flag := processed_as = 'I' and p5 and (s1 and s2 and s3 and s4 and s5 and s6);	 	
				pqc28 := if(p1, '', if(pqc27Flag and licPracStateFlag and dt1, 'PSa', '')); // dos > load_date > dos-30  
				pqc29 := if(p1, '', if(pqc27Flag and licPracStateFlag and dt2, 'PSb', '')); // dos-30 > load_date > dos-60 
				pqc30 := if(p1, '', if(pqc27Flag and licPracStateFlag and dt3, 'PSc', '')); // dos-30 > load_date > dos-60 
				pqc27 := if(p1, '', if(pqc27Flag and pqc28 = '' and pqc29 = '' and pqc30 = '', 'PS1', '')); 								
				pqc31Flag :=  processed_as = 'I' and p9 and (s1 and s2 and s3 and s4 and s5 and s6);		
				pqc32 := if(p1, '', if(pqc31Flag and licPracStateFlag and dt1, 'PSd', '')); // dos > load_date > dos-30 // pqc31='PS2' and 'load_date1'
				pqc33 := if(p1, '', if(pqc31Flag and licPracStateFlag and dt2, 'PSe', '')); // dos-30 > load_date > dos-60 // pqc31='PS2' and 'load_date2'
				pqc34 := if(p1, '', if(pqc31Flag and licPracStateFlag and dt3, 'PSf', '')); // dos-30 > load_date > dos-60 // pqc31='PS2' and 'load_date3'
				pqc31 := if(p1, '', if(pqc31Flag and pqc32 = '' and pqc33 = '' and pqc34 = '', 'PS2', '')); 				
				pqc35 := if(p1, '', if(d4, 'PN', '')); // NPI deactivated prior to the date of service
				pqc36 := if(p1, '', if(d3, 'PT', '')); // DEA expired prior to the date of service and no active DEA found
				pqc37 := if(p1, '', if(d2, 'PQ', '')); // DEA number retired prior to the date of service and no active DEA number found				
				pqc38 := if(p1, '', if(p7, 'PX', '')); // Retired DEA number with no active DEAs				
				pqc39 := if(p1, '', if(provider_status = 'R1', 'PR1', '')); // 'deceased_flag==R1' // Retired with 98% accuracy - Retired flag and either there is no active license in the practice state or there is a deactivated NPI with no active NPIs
				pqc40 := if(p1, '', if(provider_status = 'R2', 'PR2', '')); // 'deceased_flag==R2' // Retired with 95% accuracy - Retired flag and unconfirmed retired and DEA retired with no other active DEA
				pqc41 := if(p1, '', if(provider_status = 'R4', 'PR4', '')); // 'deceased_flag==R4' // Retired with 85% accuracy - Retired flag											
				pqc42 := if(p1, '', if(nm1 or nm2 or nm3 and trim(npi_verif_st,left) <> '4096', 'PF', '')); // Input name is FKA 
				// append all provider qc 
				pqc := if(p1, 'PJ', if(pqc1<>'', pqc1+',', '')+if(pqc2<>'', pqc2+',', '')+if(pqc3<>'', pqc3+',', '')+if(pqc4<>'', pqc4+',', '')+if(pqc5<>'', pqc5+',', '')+if(pqc6<>'', pqc6+',', '')
						+if(pqc7<>'', pqc7+',', '')+if(pqc8<>'', pqc8+',', '')+if(pqc9<>'', pqc9+',', '')+if(pqc10<>'', pqc10+',', '')+if(pqc11<>'', pqc11+',', '')+if(pqc12<>'', pqc12+',', '')
						+if(pqc13<>'', pqc13+',', '')+if(pqc14<>'', pqc14+',', '')+if(pqc15<>'', pqc15+',', '')+if(pqc16<>'', pqc16+',', '')+if(pqc17<>'', pqc17+',', '')+if(pqc18<>'', pqc18+',', '')
						+if(pqc19<>'', pqc19+',', '')+if(pqc20<>'', pqc20+',', '')+if(pqc21<>'', pqc21+',', '')+if(pqc22<>'', pqc22+',', '')+if(pqc23<>'', pqc23+',', '')+if(pqc24<>'', pqc24+',', '')
						+if(pqc25<>'', pqc25+',', '')+if(pqc26<>'', pqc26+',', '')+if(pqc27<>'', pqc27+',', '')+if(pqc28<>'', pqc28+',', '')+if(pqc29<>'', pqc29+',', '')+if(pqc30<>'', pqc30+',', '')
						+if(pqc31<>'', pqc31+',', '')+if(pqc32<>'', pqc32+',', '')+if(pqc33<>'', pqc33+',', '')+if(pqc34<>'', pqc34+',', '')+if(pqc35<>'', pqc35+',', '')+if(pqc36<>'', pqc36+',', '')
						+if(pqc37<>'', pqc37+',', '')+if(pqc38<>'', pqc38+',', '')+if(pqc39<>'', pqc39+',', '')+if(pqc40<>'', pqc40+',', '')+if(pqc41<>'', pqc41+',', '')+if(pqc42<>'', pqc42+',', ''));															
				// Taxonomy QC
				t1 :=taxonomy_ustat & Healthcare_Shared.Constants.ustat_Taxonomy_BadFormat > 0; 		// 131072
				t2 :=taxonomy_ustat & Healthcare_Shared.Constants.ustat_Taxonomy_Invalid > 0;						// 262144	
				t3 :=taxonomy_ustat & Healthcare_Shared.Constants.ustat_Taxonomy_NotVerified >	0;// 255
				t4 :=taxonomy_ustat & Healthcare_Shared.Constants.ustat_Taxonomy_NoAugmentation > 0;	// 4278190080
				t5 :=taxonomy_ustat & Healthcare_Shared.Constants.ustat_Taxonomy_Missing > 0;	// 4096
				t6 :=taxonomy_ustat & Healthcare_Shared.Constants.ustat_Taxonomy_NoFixCorrectionApplied > 0;	//  3840
				tqc1 := if(p1, '', if((t1 and t2) and ~t4 and ~t6, 'TB', '')); // Taxonomy bad/invalid and no correction 
				tqc2 := if(p1, '', if(~(t1 and t2) and ~t3 and ~t4 and ~t5 and ~t6, 'TI', '')); // Taxonomy verified and correction and correctly formated 
				tqc := if(tqc1<>'', tqc1+',', '')+if(tqc2<>'', tqc2+',', ''); 											
				// License QC
				l1 := license_ustat & Healthcare_Shared.Constants.ustat_License_Suspended > 0; 			// 16384
				l2 := license_ustat & Healthcare_Shared.Constants.ustat_License_SomeoneElse > 0; 	// 8192
				l3 := license_ustat & Healthcare_Shared.Constants.ustat_License_NoAugmentation > 0; //4278190080 
				lqc1 := if(p1, '', if(l1, 'L8', ''));	// Suspended license found for the provider in some state (may not be practice state)
				lqc2 := if(p1, '', if(l2 and ~l3, 'LT', '')); 		// License belongs to someone else with no augmentation
				lqc := if(lqc1<>'', lqc1+',', '')+if(lqc2<>'', lqc2+',', ''); 											
				// NPI	
				n1 := npi_ustat & Healthcare_Shared.Constants.ustat_NPI_SomeoneElse > 0;   // 8192
				n2 := npi_ustat & Healthcare_Shared.Constants.ustat_NPI_AugAuthSource > 0; // 268435456								
				n3 := npi_ustat & Healthcare_Shared.Constants.ustat_NPI_Missing > 0;   // 4096
				n4 := npi_ustat & Healthcare_Shared.Constants.ustat_NPI_BadFormat > 0; // 131072
				n5 := npi_ustat & Healthcare_Shared.Constants.ustat_NPI_Verified > 0; // 8 
				n6 := npi_ustat & Healthcare_Shared.Constants.ustat_NPI_Invalid > 0 ; //262144
				n7 := npi_ustat & Healthcare_Shared.Constants.ustat_NPI_Type1 > 0; // 2
				n8 := npi_ustat & Healthcare_Shared.Constants.ustat_NPI_Type2 > 0; // 4
				n9 := npi_ustat & Healthcare_Shared.Constants.ustat_NPI_DeActivated > 0; // 65536
				n10 := npi_deact_date = '' or npi_deact_date = '00000000'; // (py) npi_aug_act_flag 
				n11 := aug_npi_num; // (py) aug_npi_num					
				n12 := npi_num; // (py) npi_num					
				n13 := aug_npi_deact_date; // (py) aug_npi_deact_date
				// NPI qc 
				nqc1 := if(p1, '', if(n1 and ~n2 or n10, 'NT', '')); 	// ** Belongs to a different provider with no augmentation
				nqc2 := if(p1, '', if(~n2 and n9 or  n11 <> '' and n11 <> n12 and ~(n13 = '' or n13 = '00000000'), 'ND2', ''));					//  Deactivated with no augmentation  
				nqc3 := if(p1, '', if((n3 and n4) or n3 or ~n5 and n2 and n10, 'NP', ''));	// ** Input blank, bad or unverifed and only NPI found is deactivated
				nqc4 := if(p1, '', if(n6 and ~n2, 'NI', '')); // 	Passes LUHN with no augmentation ?
				nqc5 := if(p1, '', if(processed_as = 'I' and n8 and ~n5, 'N2', '')); 	// Type mismatch with no augmentation // 
				nqc6 := if(p1, '', if(processed_as = 'F' and n7 and ~n5, 'N2', '')); 	// Type mismatch with no augmentation // 
				nqc7 := if(p1, '', if(n4 and ~n2, 'NB', '')); 	// Bad format and no augmentation										
				nqc8 := if(p1, '', if(n3 and ~n2, 'NM', '')); 	// Missing with no augmentation 
				nqc := if(nqc1<>'',nqc1+',', '')+if(nqc2<>'',nqc2+',', '')+if(nqc3<>'',nqc3+',', '')+if(nqc4<>'',nqc4+',', '') 
									+if(nqc5<>'',nqc5+',', '')+if(nqc6<>'',nqc6+',', '')+if(nqc7<>'',nqc7+',', '')+if(nqc8<>'',nqc8+',', ''); 
				// Address
				a1 := addr_ustat & Healthcare_Shared.Constants.ustat_Addr_PV_Practice > 0; // 16 
				a2 := addr_ustat & Healthcare_Shared.Constants.ustat_Addr_PV_Billing > 0		; // 32 
				a3 := addr_ustat & Healthcare_Shared.Constants.ustat_Addr_PV_Inactive > 0; // 8192
				a4 := addr_ustat & Healthcare_Shared.Constants.ustat_Addr_HCInactive > 0; // 16384
				a5 := addr_ustat & Healthcare_Shared.Constants.ustat_Addr_POBox > 0; // 65536
				a6 := addr_ustat & Healthcare_Shared.Constants.ustat_Addr_Undeliverable > 0; // 131072
				a7 := addr_ustat & Healthcare_Shared.Constants.ustat_Addr_Aug_HV_Value > 0; // 536870912
				a8 := addr_ustat & Healthcare_Shared.Constants.ustat_Addr_Aug_PV_Value > 0; // 1073741824
				a9 := addr_ustat & Healthcare_Shared.Constants.ustat_Addr_Aug_HCVerified	> 0; // 67108864
				a10 := addr_ustat & Healthcare_Shared.Constants.ustat_Addr_Aug_PV_Verified > 0; //134217728
				a11 := addr_ustat & Healthcare_Shared.Constants.ustat_Addr_Typo_Correction > 0; //256
				a12 := addr_ustat & Healthcare_Shared.Constants.ustat_Addr_Missing > 0; //4096
				a13 := addr_ustat & Healthcare_Shared.Constants.ustat_Addr_CallBased_Update > 0; //1024
				ph1 := phone_ustat & Healthcare_Shared.Constants.ustat_Phone_Aug_HCVerified > 0; // 67108864
				ph2 := phone_ustat & Healthcare_Shared.Constants.ustat_Phone_Aug_PV_Verified > 0; // 134217728
				ph3 := phone_ustat & Healthcare_Shared.Constants.ustat_Phone_PV_Inactive	> 0; // 8192 															
				// Address QC
				hbp_flag := get_hbp_flag(taxonomy);
				aqc1 := if(p1, '', if(processed_as = 'I' and ~a1 and (a3 and a4) and (p5 and p6) and ~(a7 and a8) , 'AZ', '')); // Inactive License and Inactive Address in Practice State and no other active address in practice state 
				aqc2 := if(p1, '', if(d5, 'AR', '')); // Inactive Address prior to the Date of Service
				aqc3 := if(p1, '', if((a3 or a4) and ~a1 and ph3 and prac_corr_last_update_date <> '', 'AF', '')); //Inactive Address and no other active address in the client file  
				aqc4 := if(p1, '', if(a6 and ~(a11 and a13), 'AX', '')); // Undeliverable and no correction 
				aqc5 := if(p1, '', if(a5 and ~hbp_flag , 'AP', '')); // PO Box and non hospital doctor
				aqc6 := if(p1, '', if(a4, 'AH', '')); // High Risk 
				aqc7 := if(p1, '', if(~hbp_flag and a12, 'AN', '')); // High Risk 
				aqc8 := if(p1, '', if(d5 and ~a7 and ~a8, 'AR1', '')); // Inactive address prior to the date of service and no HV or PV address augs in the practice state
				aqc9 := if(p1, '', if(d5 and ~a9 and ~a10 , 'AR2', '')); // Inactive address prior to the date of service and no high confidence augmented addresses found in any state
				aqc := if(aqc1<>'',aqc1+',', '')+if(aqc2<>'',aqc2+',', '')+if(aqc3<>'',aqc3+',', '')+if(aqc4<>'',aqc4+',', '') 
								+ if(aqc5<>'',aqc5+',', '')+if(aqc6<>'',aqc6+',', '')+if(aqc7<>'',aqc7+',', '')+if(aqc8<>'',aqc8+',', '')+if(aqc9<>'',aqc9+',', '');
				// State Sanction QC
				stateBoardSanction := Std.Str.ToUpperCase(stateorfederal) = 'STATE' and  sanc1_state = prac1_state and sanc1_code in ['112eS','111L','SME','112ds','CandD'];
				sanc1_date_flag := sanc1_date <> '' and sanc1_date <= servicefromdate;
				sqc1 := if(s1 and s2 and s3 and s4 and s5 and s6, 'S1', ''); // Any current state sanctions		// 63 = 32, 16, 8, 4, 2, 1
				sqc3 := if(p1, '', if(state_restrict_flag and stateBoardSanction and sanc1_date_flag, 'S3a', '')); //Flipped the order so SQC3 comes first, guarentees that SQC3 does not get overwritten if it is true
				sqc2 := if(p1, '', if(state_restrict_flag and sqc3 = '', 'S3', ''));  // ** Practice State Restrictive sanction for the provider
				 // ** Practice State Restrictive sanction for the provider 
				sqc4 := if(p1, '', if((os1 and os2 and os3 and os4 and os5 and os6 ) and processed_as = 'I', 'S4', ''));		// State sanction (current) and License is inactive for input practice state
				sqc5 := if(p1, '', if((os1 and os2 and os3 and os4 and os5 and os6 ) and processed_as = 'F', 'S4x', ''));	// State sanction (current) and License is inactive for input practice state
				sqc6 := if(p1, '', if(os9 and processed_as = 'I', 'S5', ''));		// State sanction (current) and License is restricted for input practice state
				sqc7 := if(p1, '', if(os9 and processed_as = 'F', 'S5x', ''));	// State sanction (current) and License is restricted for input practice state										
				sqc8 := if(p1, '', if(s5, 'SR', '')); // State sanction for RX (current)
				sqc9 := if(p1, '', if(s1, 'SF', '')); // State sanction for Fraud (current)
				sqc10 := if(p1, '', if(s3, 'SP', '')); // State sanction for Program  (current)
				sqc11 := if(p1, '', if(s2, 'SL', '')); // State sanction for License  (current)
				sqc12 := if(p1, '', if(s6, 'SO', '')); // State sanction for Other (current)
				sqc13 := if(p1, '', if(s4, 'SQ', '')); // State sanction for Quality of Care  (current)
				sqc14 := if(p1, '', if(os1 or os7 or s1 or s7 or s9 or s11, 'SHF', '')); // Past/present Fraud Sanctions
				sqc15 := if(p1, '', if(os5 or os11 or s5 or s8 or s10 or s12, 'SHR', '')); // Past/present RX Sanctions
				sqc16 := if(p1, '', if(s14, 'S6', '')); // Future OIG/OPM Sanction
				sqc17 := if(p1, '', if(s15, 'S7', '')); // Future sanction in practice state
				sqc :=  if(sqc1<>'',sqc1+',', '')+if(sqc2<>'',sqc2+',', '')+if(sqc3<>'',sqc3+',', '')+if(sqc4<>'',sqc4+',', '')+if(sqc5<>'',sqc5+',', '') 
									+if(sqc6<>'',sqc6+',', '')+if(sqc7<>'',sqc7+',', '')+ if(sqc8<>'',sqc8+',', '') +  if(sqc9<>'',sqc9+',', '') +  if(sqc10<>'',sqc10+',', '') +  if(sqc11<>'',sqc11+',', '') 
									+if(sqc12<>'',sqc12+',', '')+if(sqc13<>'',sqc13+',', '')+if(sqc14<>'',sqc14+',', '')+if(sqc15<>'',sqc15+',', '')+if(sqc16<>'',sqc16+',', '')+if(sqc17<>'',sqc17+',', '');				
		// concatenate qc codes
		c := pqc+tqc+lqc+nqc+aqc+sqc+',';	
		qc := stringlib.StringFindReplace(c, ',,', '');
	return qc;
	end;
End;