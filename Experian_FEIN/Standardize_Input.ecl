import Address, Ut, lib_stringlib, _Control, _Validate, MDR;

export Standardize_Input := module

  EXPORT fAssignSeq(DATASET(Experian_FEIN.layouts.Input.sprayed) pRawFileInput, string pversion) := FUNCTION
	
    // Add a unique_id to the input records to use for normalizing FEIN fields	
		Experian_FEIN.layouts.TempRec tAssignSeq(Experian_FEIN.layouts.Input.Sprayed l, unsigned8 cnt) := TRANSFORM
			SELF.unique_id	:= cnt;
			SELF						:= L;
		END;
				 		
		dAssignSeq := PROJECT(pRawFileInput, tAssignSeq(left,counter));

		// Normalize the raw input records
		Experian_FEIN.layouts.NormRec	tNormalizeRec(Experian_FEIN.layouts.TempRec l, unsigned8 cnt) := TRANSFORM
			SELF.unique_id	       					:= l.unique_id;
			SELF.Norm_Type         					:= choose(cnt ,'1'	 /*FEIN 1*/       	       
																										,'2'	 /*FEIN 2*/             
																										,'3'	 /*FEIN 3*/        
																										,'4'	 /*FEIN 4*/
																										,'5'); /*FEIN 5*/                      
			SELF.Norm_Tax_ID 					 			:= choose(cnt ,l.Tax_ID_1
																										,l.Tax_ID_2
																										,l.Tax_ID_3
																										,l.Tax_ID_4
																										,l.Tax_ID_5);
			SELF.Norm_Confidence_Level 			:= choose(cnt ,l.Confidence_Level_1
																										,l.Confidence_Level_2
																										,l.Confidence_Level_3
																										,l.Confidence_Level_4
																										,l.Confidence_Level_5);																					 															
			SELF.Norm_Display_Configuration := choose(cnt ,l.Display_Configuration_1
																										,l.Display_Configuration_2
																										,l.Display_Configuration_3
																										,l.Display_Configuration_4
																										,l.Display_Configuration_5);
			SELF						  := L;																		
		END;

		dNormalize	:=	normalize(dAssignSeq,	5,	tNormalizeRec(left, counter));
		
		RETURN dNormalize;
	END;	


	export fPreprocess(dataset(Layouts.NormRec) dNormalize, string pversion) := function
		Layouts.base tPreProcessRecs(Layouts.NormRec l) := transform
    
			// Prepare Addresses for Cleaning using macro
			addr1 :=	ut.CleanSpacesAndUpper(l.Business_Address);        
			addr2 :=	stringlib.stringcleanspaces(ut.CleanSpacesAndUpper(l.Business_City)
				      	+ if (trim(l.Business_City) <> '',', ','')	+ ut.CleanSpacesAndUpper(l.Business_State)
				      	+ ' '		+ ut.CleanSpacesAndUpper(l.Business_Zip) );                
			                                
			// Map Fields
			self.prep_addr_line1										:= addr1;
			self.prep_addr_line_last								:= addr2;
   		self.dt_vendor_first_reported						:= (unsigned4)pversion;
			self.dt_vendor_last_reported						:= (unsigned4)pversion;
		  self.Business_Identification_Number			:= trim(l.Business_Identification_Number,left,right);
			self.Business_Name											:= ut.CleanSpacesAndUpper(l.Business_Name);
			self.Business_Address										:= ut.CleanSpacesAndUpper(l.Business_Address);
			self.Business_City											:= ut.CleanSpacesAndUpper(l.Business_City);
			self.Business_State											:= ut.CleanSpacesAndUpper(l.Business_State);
			self.Business_Zip												:= trim(l.Business_Zip,left,right);
			self.Norm_Tax_ID												:= trim(l.Norm_Tax_ID,left,right);
			self.Norm_Confidence_Level							:= trim(l.Norm_Confidence_Level,left,right);
			self.Norm_Display_Configuration					:= ut.CleanSpacesAndUpper(l.Norm_Display_Configuration);
			self.Long_Name													:= ut.CleanSpacesAndUpper(l.Long_Name);
			self.source	:= if(l.Norm_Confidence_Level = '1' and l.Norm_Display_Configuration = 'Y'
												,MDR.sourceTools.src_Experian_FEIN_Unrest /* unrestricted 'E6' */
												,MDR.sourceTools.src_Experian_FEIN_Rest); /* restricted   'E5' */
			self 																		:= l;
			self 																		:= [];

		end;
		
		dPreProcess := project(dNormalize, tPreProcessRecs(left));

		return dPreProcess;

	end;
	
	//-----------------------------------------------------
	// function: fAll
	//-----------------------------------------------------
	export fAll( dataset(Layouts.Input.sprayed	)	pRawFileInput
							,string	pversion
							,string	pPersistname = persistnames().StandardizeInput
	) := function
	
	  dNormalize  := fAssignseq (pRawFileInput,pversion);
		
		dPreprocess	:= fPreProcess(dNormalize,pversion);// : persist(pPersistname);
		
		dGoodRecs := dPreprocess(Norm_Tax_ID <> '');
		
		return dGoodRecs;
	end;




end;