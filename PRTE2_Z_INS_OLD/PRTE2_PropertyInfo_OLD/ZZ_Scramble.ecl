// THIS was Linda's scrambling which is OBSOLETE
//* PRTE2_PropertyInfo.Scramble - scramble the addresses and property data //*
IMPORT PRTE2;
#WORKUNIT ('name', 'Scramble PropertyInfo');

	//* formatted input file for Property Info:  
	export Formatted_Property_Info := record
	  unsigned6  Old_Seq_No;
		unsigned6  New_Seq_no;
		string  fname;
		string  mname;
		string  lname;
		string  SSN;
		string  dob;
		string  i_address;
		string  apt;
		string  p_city_name;
		string  st;
		string  zip;
		string  i_datasource;
		string  prim_range;
		string  predir;
		string  prim_name;
		string  addr_suffix;
		string  postdir;
		string  unit_desig;
		string  sec_range;
		string  i_streetaddr1;
		string  i_streetaddr2;
		string  i_city1;
		string  i_state1;
		unsigned5 zip5;
		unsigned4 zip4;
		string  county;
		string  i_postalcd;
		string  i_stcityzip;	
		string   CensusTract;
		
	  Input_PropertyAttributes;

		string c1;
		string cd1;
		string m1;
		string md1;
		string v1;
		string ev1;
		string c2;
		string cd2;
		string m2;
		string md2;
		string v2;
		string ev2;
		string c3;
		string cd3;
		string m3;
		string md3;
		string v3;
		string ev3;
		string c4;
		string cd4;
		string m4;
		string md4;
		string v4;
		string ev4;
		string c5;
		string cd5;
		string m5;
		string md5;
		string v5;
		string ev5;
		string c6;
		string cd6;
		string m6;
		string md6;
		string v6;
		string ev6;
		string c7;
		string cd7;
		string m7;
		string md7;
		string v7;
		string ev7;
		string c8;
		string cd8;
		string m8;
		string md8;
		string v8;
		string ev8;
		string c9;
		string cd9;
		string m9;
		string md9;
		string v9;
		string ev9;
		string c10;
		string cd10;
		string m10;
		string md10;
		string v10;
		string ev10;
		string c11;
		string cd11;
		string m11;
		string md11;
		string v11;
		string ev11;
		string c12;
		string cd12;
		string m12;
		string md12;
		string v12;
		string ev12;
		string c13;
		string cd13;
		string m13;
		string md13;
		string v13;
		string ev13;
		string c14;
		string cd14;
		string m14;
		string md14;
		string v14;
		string ev14;
		string c15;
		string cd15;
		string m15;
		string md15;
		string v15;
		string ev15;
		string c16;
		string cd16;
		string m16;
		string md16;
		string v16;
		string ev16;
		string c17;
		string cd17;
		string m17;
		string md17;
		string v17;
		string ev17;
		string c18;
		string cd18;
		string m18;
		string md18;
		string v18;
		string ev18;
		string c19;
		string cd19;
		string m19;
		string md19;
		string v19;
		string ev19;
		string c20;
		string cd20;
		string m20;
		string md20;
		string v20;
		string ev20;
		string c21;
		string cd21;
		string m21;
		string md21;
		string v21;
		string ev21;
		string c22;
		string cd22;
		string m22;
		string md22;
		string v22;
		string ev22;
		string c23;
		string cd23;
		string m23;
		string md23;
		string v23;
		string ev23;
		string c24;
		string cd24;
		string m24;
		string md24;
		string v24;
		string ev24;
		string c25;
		string cd25;
		string m25;
		string md25;
		string v25;
		string ev25;
		string c26;
		string cd26;
		string m26;
		string md26;
		string v26;
		string ev26;
		string c27;
		string cd27;
		string m27;
		string md27;
		string v27;
		string ev27;
		string c28;
		string cd28;
		string m28;
		string md28;
		string v28;
		string ev28;
		string c29;
		string cd29;
		string m29;
		string md29;
		string v29;
		string ev29;
		string c30;
		string cd30;
		string m30;
		string md30;
		string v30;
		string ev30;
		string c31;
		string cd31;
		string m31;
		string md31;
		string v31;
		string ev31;
		string c32;
		string cd32;
		string m32;
		string md32;
		string v32;
		string ev32;
		string c33;
		string cd33;
		string m33;
		string md33;
		string v33;
		string ev33;
		string c34;
		string cd34;
		string m34;
		string md34;
		string v34;
		string ev34;
		string c35;
		string cd35;
		string m35;
		string md35;
		string v35;
		string ev35;
		string c36;
		string cd36;
		string m36;
		string md36;
		string v36;
		string ev36;
		string c37;
		string cd37;
		string m37;
		string md37;
		string v37;
		string ev37;
		string c38;
		string cd38;
		string m38;
		string md38;
		string v38;
		string ev38;
		string c39;
		string cd39;
		string m39;
		string md39;
		string v39;
		string ev39;	
		string c40;
		string cd40;
		string m40;
		string md40;
		string v40;
		string ev40;
		string c41;
		string cd41;
		string m41;
		string md41;
		string v41;
		string ev41;
		string c42;
		string cd42;
		string m42;
		string md42;
		string v42;
		string ev42;
		string c43;
		string cd43;
		string m43;
		string md43;
		string v43;
		string ev43;
		string c44;
		string cd44;
		string m44;
		string md44;
		string v44;
		string ev44;
		string c45;
		string cd45;
		string m45;
		string md45;
		string v45;
		string ev45;
		string c46;
		string cd46;
		string m46;
		string md46;
		string v46;
		string ev46;
		string c47;
		string cd47;
		string m47;
		string md47;
		string v47;
		string ev47;
		string c48;
		string cd48;
		string m48;
		string md48;
		string v48;
		string ev48;
		string c49;
		string cd49;
		string m49;
		string md49;
		string v49;
		string ev49;
		string c50;
		string cd50;
		string m50;
		string md50;
		string v50;
		string ev50;
		string c51;
		string cd51;
		string m51;
		string md51;
		string v51;
		string ev51;
		string c52;
		string cd52;
		string m52;
		string md52;
		string v52;
		string ev52;
		string c53;
		string cd53;
		string m53;
		string md53;
		string v53;
		string ev53;
		string c54;
		string cd54;
		string m54;
		string md54;
		string v54;
		string ev54;
		string c55;
		string cd55;
		string m55;
		string md55;
		string v55;
		string ev55;
		string c56;
		string cd56;
		string m56;
		string md56;
		string v56;
		string ev56;
		string c57;
		string cd57;
		string m57;
		string md57;
		string v57;
		string ev57;
		string c58;
		string cd58;
		string m58;
		string md58;
		string v58;
		string ev58;
		string c59;
		string cd59;
		string m59;
		string md59;
		string v59;
		string ev59;
		string c60;
		string cd60;
		string m60;
		string md60;
		string v60;
		string ev60;
		string c61;
		string cd61;
		string m61;
		string md61;
		string v61;
		string ev61;
		string c62;
		string cd62;
		string m62;
		string md62;
		string v62;
		string ev62;
		string c63;
		string cd63;
		string m63;
		string md63;
		string v63;
		string ev63;
		string c64;
		string cd64;
		string m64;
		string md64;
		string v64;
		string ev64;
		string c65;
		string cd65;
		string m65;
		string md65;
		string v65;
		string ev65;
		string c66;
		string cd66;
		string m66;
		string md66;
		string v66;
		string ev66;
		string c67;
		string cd67;
		string m67;
		string md67;
		string v67;
		string ev67;
		string c68;
		string cd68;
		string m68;
		string md68;
		string v68;
		string ev68;
		string c69;
		string cd69;
		string m69;
		string md69;
		string v69;
		string ev69;
		string c70;
		string cd70;
		string m70;
		string md70;
		string v70;
		string ev70;
		string c71;
		string cd71;
		string m71;
		string md71;
		string v71;
		string ev71;
		string c72;
		string cd72;
		string m72;
		string md72;
		string v72;
		string ev72;
		string c73;
		string cd73;
		string m73;
		string md73;
		string v73;
		string ev73;
		string c74;
		string cd74;
		string m74;
		string md74;
		string v74;
		string ev74;
		string c75;
		string cd75;
		string m75;
		string md75;
		string v75;
		string ev75;
		string c76;
		string cd76;
		string m76;
		string md76;
		string v76;
		string ev76;
		string c77;
		string cd77;
		string m77;
		string md77;
		string v77;
		string ev77;
		string c78;
		string cd78;
		string m78;
		string md78;
		string v78;
		string ev78;
		string c79;
		string cd79;
		string m79;
		string md79;
		string v79;
		string ev79;
		string c80;
		string cd80;
		string m80;
		string md80;
		string v80;
		string ev80;
		string c81;
		string cd81;
		string m81;
		string md81;
		string v81;
		string ev81;
		string c82;
		string cd82;
		string m82;
		string md82;
		string v82;
		string ev82;
		string c83;
		string cd83;
		string m83;
		string md83;
		string v83;
		string ev83;
		string c84;
		string cd84;
		string m84;
		string md84;
		string v84;
		string ev84;
		string c85;
		string cd85;
		string m85;
		string md85;
		string v85;
		string ev85;
		string MortgCN1;
		string MortgType1;
		string MortgTDesc1;
		string LoanAmt1;
		string LoanAmtCd1;
		string LoanType1;
		string InterestRate1;
		string InterestRTCD1;
		string InterestRType1;
		string MortgLoanNo1;
		string FsiMLNo1;
		string FsiMCN1;
		string Classification1;
		string MortgCN2;
		string MortgType2;
		string MortgTDesc2;		
		string LoanAmt2;
		string LoanAmtCd2;
		string LoanType2;
		string InterestRate2;
		string InterestRTCD2;
		string InterestRType2;
		string MortgLoanNo2;
		string FsiMLNo2;
		string FsiMCN2;
		string Classification2;
		string MortgCN3;
		string MortgType3;
		string MortgTDesc3;
		string LoanAmt3;
		string LoanAmtCd3;
		string LoanType3;
		string InterestRate3;
		string InterestRTCD3;
		string InterestRType3;
		string MortgLoanNo3;
		string FsiMLNo3;
		string FsiMCN3;
		string Classification3;
		//*	PropertyCharacteristics_Services.Layouts.flat_erc_rec;
		string Classification;
		string DeedRecordingDate;
		string SalesDate;
		string DeedDocumentNumber;
		string SalesAmount;
		string SalesTypeCode;
		string SalesType;
		string SalesFullPart;
		string LegalDesc;
		string ParcelNumber;
		string FipsCode;
		string ApnNumber;
		string BlockNumber;
		string LotNumber;
		string SubdivisionName;
		string TownshipName;
		string MunicipalityName;
		string RangeNo;
		string Section;
		string ZoningDesc;
		string LocationOfInfluenceCode;
		string LocationOfInfluence;
		string LandUseCode;
		string LandUse;
		string PropertyTypeCode;
		string PropertyType;
		string Latitude;
		string Longitude;
		string LotSize;
		string LotFrontFootage;
		string LotDepthFootage;
		string Acres;
		string TotalAssessedValue;
		string TotalCalculatedValue;
		string TotalMarketValue;
		string TotalLandValue;
		string MarketLandValue;
		string AssessedLandValue;
		string ImprovementValue;
		string AssessedYear;
		string TaxCodeArea;
		string TaxBillingYear;
		string HomesteadExemption;
		string TaxAmount;
		string PercentImproved;
		string AssessmentDocumentNumber;
		string AssessmentRecordingDate;
		string Tax_County;
		string CF1_Acres;
		string CF1_AirconditioningTypecode;
		string CF1_ApnNumber;
		string CF1_AssessedLandValue;
		string CF1_AssessedYear;
		string CF1_AssessmentDocumentNumber;
		string CF1_AssessmentRecordingDate;
		string CF1_BasementFinishType;
		string CF1_BasementSquareFootage;
		string CF1_BlockNumber;
		string CF1_BuildingSquareFootage;
		string CF1_CensusTract;
		string CF1_ConstructionType;
		string CF1_County;
		string CF1_EffectiveYearBuilt;
		string CF1_ExteriorWallType;
		string CF1_FipsCode;
		string CF1_FireplaceIndicator;
		string CF1_FireplaceType;
		string CF1_FloodZonePanelNumber;
		string CF1_FloorType;
		string CF1_FoundationType;
		string CF1_FrameType;
		string CF1_FuelType;
		string CF1_GarageCarportType;
		string CF1_GarageSquareFootage;
		string CF1_GroundFloorSquareFootage;
		string CF1_HeatingType;
		string CF1_HomesteadExemptionIndicator;
		string CF1_ImprovementValue;
		string CF1_LandUseCode;
		string CF1_Latitude;
		string CF1_LivingareaSquareFootage;
		string CF1_LocationOfInfluenceCode;
		string CF1_Longitude;
		string CF1_LotDepthFootage;
		string CF1_LotFrontFootage;
		string CF1_LotNumber;
		string CF1_LotSize;
		string CF1_MarketLandValue;
		string CF1_MunicipalityName;
		string CF1_NumberOfBathFixtures;
		string CF1_NumberofBaths;
		string CF1_NumberofBedrooms;
		string CF1_NumberofFireplaces;
		string CF1_NumberofFullBaths;
		string CF1_NumberofHalfBaths;
		string CF1_NumberofRooms;
		string CF1_NumberofStories;
		string CF1_NumberofUnits;
		string CF1_ParkingType;
		string CF1_PercentImproved;
		string CF1_PoolIndicator;
		string CF1_PoolType;
		string CF1_PropertyTypeCode;
		string CF1_QualityofStructureCode;
		string CF1_Range;
		string CF1_RoofCoverType;
		string CF1_SewerType;
		string CF1_StoriesType;
		string CF1_StyleType;
		string CF1_SubdivisionName;
		string CF1_TaxAmount;
		string CF1_TaxBillingYear;
		string CF1_TotalAssessedValue;
		string CF1_TotalCalculatedValue;
		string CF1_TotalLandValue;
		string CF1_TotalMarketValue;
		string CF1_TownshipName;
		string CF1_WaterType;
		string CF1_YearBuilt;
		string CF1_ZoningDescription;
		string CF2_DeedDocumentNumber;
		string CF2_DeedRecordingDate;
		string CF2_InterestRateTypeCode;
		string CF2_LoanAmount;
		string CF2_LoanTypeCode;
		string CF2_MortgageCompanyName;
		string CF2_SaleFullorPart;
		string CF2_SalesAmount;
		string CF2_SalesDate;
		string CF2_SalesTypeCode;
		string CF2_SecondLoanAmount;
		string InsuranceToValue;
		string EstimateReplacementCost;
		string Profit;
		string ArchitectAmount;
		string SalesTaxIncluded;
		string DebrisAmount;
		string ActualCashValue;
		string OverheadAmount;
		string EstReplacementCostScore;
		string ActualCashValueScore;
		boolean is_cleaned := false;
		unsigned general_err;
	 END;


//* Customer Test Property Info input file

Property_Info_Test := DATASET('~prct_pii::in::custtest::propertyinfo10',
									PRTE2.layouts.batch_in,CSV(HEADING(1),QUOTE('"'),MAXLENGTH(32768)));
sorted_pi_test := SORT(property_info_test,i_address,p_city_name,st,zip);

Max_Orig := COUNT(sorted_pi_test);
								
PI_Test_Deduped := DEDUP(sorted_pi_test,i_address,p_city_name,st,zip);

Max_seq     := COUNT(PI_Test_Deduped);

	Formatted_Property_Info  AddSeqNo  (PI_Test_Deduped L, integer C) := TRANSFORM
			self.Old_Seq_No := (unsigned) C;
			new_seq         := (unsigned) C + 1;
			self.New_Seq_no := IF (new_seq > Max_Seq,  1, new_seq);
			SELF := L;
			SELF := [];
  END;  	 	  	
	
Sequenced_DS := PROJECT(PI_Test_Deduped, AddSeqNo (Left, Counter));


//* Join the sorted input property info to the file of addresses with seq nos,
//* appending the seq nos to the Property Info file.
Property_Info_w_Seq  := JOIN(sorted_pi_test,Sequenced_DS,
					left.prim_range = right.prim_range and
					left.predir = right.predir and
					left.prim_name = right.prim_name and
					left.addr_suffix = right.addr_suffix and
					left.postdir = right.postdir and
					left.unit_desig = right.unit_desig and
					left.sec_range = right.sec_range and
					left.p_city_name = right.p_city_name and
					left.st   = right.st and
					left.zip = right.zip and
					left.zip4 = right.zip4,
					
					transform(Formatted_Property_Info,
							self.old_seq_no := right.old_seq_no,
							self.new_seq_no := right.new_seq_no,
							self := left),
					left outer
					);
					

//* Now Join and Scramble Addresses:
Property_Info_PreScrambled  := JOIN(Property_Info_w_Seq,Property_Info_w_Seq,
         left.new_seq_no = right.old_seq_no
				 and left.i_datasource = right.i_datasource, 
						transform(Formatted_Property_Info,
						  self.old_seq_no := left.old_seq_no,
							self.new_seq_no := left.new_seq_no,
							self.i_address    := right.i_address,
							self.i_streetaddr1 := right.i_streetaddr1,
							self.i_streetaddr2 := right.i_streetaddr2,
							self.i_city1      := right.i_city1,
							self.i_state1     := right.i_state1,
							self.zip5         := right.zip5,
							self.zip4         := right.zip4,
							self.county       := right.county,
							self.i_postalcd   := right.i_postalcd,
							self.i_stcityzip  := right.i_stcityzip,
							self.censustract  := right.censustract,
							self.prim_range 	:= right.prim_range,
							self.predir 			:= right.predir,
							self.prim_name 		:= right.prim_name,
							self.addr_suffix 	:= right.addr_suffix,
							self.postdir 			:= right.postdir,
							self.unit_desig 	:= right.unit_desig,
							self.sec_range 		:= right.sec_range,
							self.p_city_name 	:= right.p_city_name,
							self.st   				:= right.st,
							self.zip  				:= right.zip,
						self := left),
				left outer
					);

 Deduped_Property_Info_preScrambled :=    DEDUP(Property_Info_preScrambled,RECORD);
 
 
//* Now Join without the data source for the non-matches:
Property_Info_Scrambled  := JOIN(Deduped_Property_Info_preScrambled,Property_Info_w_Seq,
         left.new_seq_no = right.old_seq_no,
			
						transform(Formatted_Property_Info,
						  self.old_seq_no := left.old_seq_no,
							self.new_seq_no := left.new_seq_no,
							self.i_datasource := left.i_datasource,
							
							self.i_address     := IF(left.i_address > '', left.i_address, right.i_address),
							self.i_streetaddr1 := IF(left.i_streetaddr1 > '', left.i_streetaddr1, right.i_streetaddr1),
							self.i_streetaddr2 := IF(left.i_streetaddr2 > '', left.i_streetaddr1, right.i_streetaddr2),
							self.i_city1       := IF(left.i_city1 > '', left.i_city1, right.i_city1),
							self.i_state1      := IF(left.i_state1 > '', left.i_state1, right.i_state1),
							self.zip5          := IF(left.zip5 > 0, left.zip5, right.zip5),
							self.zip4          := IF(left.zip4 > 0, left.zip4, right.zip4),
							self.county        := IF(left.county > '', left.county, right.county),
							self.i_postalcd    := IF(left.i_postalcd > '', left.i_postalcd, right.i_postalcd),
							self.i_stcityzip   := IF(left.i_stcityzip > '', left.i_stcityzip, right.i_stcityzip),
							self.censustract   := IF(left.i_address > '', left.censustract, right.censustract),
							self.prim_range 	 := IF(left.prim_range > '', left.prim_range, right.prim_range),
							self.predir 			 := IF(left.predir > '', left. predir, right.predir),
							self.prim_name 		 := IF(left. prim_name > '', left.prim_name, right.prim_name),
							self.addr_suffix 	 := IF(left.addr_suffix > '', left. addr_suffix, right.addr_suffix),
							self.postdir 			 := IF(left.postdir > '', left.postdir, right.postdir),
							self.unit_desig 	 := IF(left.unit_desig > '', left.unit_desig, right.unit_desig),
							self.sec_range 		 := IF(left.sec_range > '', left.sec_range, right.sec_range),
							self.p_city_name 	 := IF(left.p_city_name > '', left.p_city_name, right.p_city_name),
							self.st   			   := IF(left.st > '', left.st, right.st),
							self.zip  				 := IF(left.zip > '', left.zip, right.zip),
											
						self := left),
				left outer
					);
					

 Sorted_Pi_Scrambled             := SORT(Property_Info_Scrambled,new_seq_no, fname, mname, lname, i_address,apt, p_city_name,st,zip, i_datasource); 
 Deduped_Property_Info_Scrambled := DEDUP(Sorted_PI_Scrambled,RECORD);
 OUTPUT (Deduped_Property_Info_Scrambled,,'~prte::ct::propertybluebook::scrambled::propinfo9',OVERWRITE);
 
PII_Scrambled    := '~prte::in::custtest::csv::scrambled::propertyinfo9b';
                      prte::in::custtest::csv::scrambled::propertyinfo9b
PII_Scrambled_DS := DATASET(PII_Scrambled,
									PRTE2.layouts.batch_in,CSV(HEADING(1),QUOTE('"'),MAXLENGTH(32768)));
							
//*  remove the sequence numbers:
	PRTE2.Layouts.batch_in  WOSeqNo  (Deduped_Property_Info_Scrambled L) := TRANSFORM
			self.fname := l.fname,
			self.lname := l.lname,
			self.mname := l.mname,
			SELF := L,
			SELF := [],
	 END;  	 	  	
	
	UnSequenced_DS := PROJECT(Deduped_Property_Info_Scrambled, WOSeqNo (Left));
//* write out the final descrambled file
	OUTPUT(UnSequenced_DS,, PII_Scrambled,
								CSV(HEADING(SINGLE), QUOTE('"'), SEPARATOR(','), NOTRIM),OVERWRITE);
	OUTPUT(choosen(Unsequenced_DS,100), NAMED('finalds'));
//* end of Scramble