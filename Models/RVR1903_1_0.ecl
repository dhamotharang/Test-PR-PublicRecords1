IMPORT Models, Risk_Indicators, RiskWise, RiskWiseFCRA, RiskView, UT, Std,riskview;

EXPORT RVR1903_1_0 (GROUPED DATASET(riskview.layouts.attributes_internal_layout_noscore) attributes) := FUNCTION

	MODEL_DEBUG        := FALSE;
	// MODEL_DEBUG        := TRUE;

#IF(MODEL_DEBUG)
Layout_Debug := RECORD
			
  UNSIGNED4 seq;
  STRING30 Account;
  STRING1 confirmationsubjectfound;         
	STRING2 subjectdeceased;                  
	STRING2 ssndeceased;                      
	STRING2 inquirynonshortterm12month;       
	STRING2 inquiryshortterm12month;          
	STRING2 inquirytelcom12month;             
	STRING2 inquirycollections12month;        
	STRING2 inquirybanking12month;            
	STRING2 inquiryauto12month;
  STRING3 rvr1903_1_0;

END;

  Layout_Debug doModel(attributes le) := TRANSFORM
#ELSE
  Layout_ModelOut doModel(attributes le) := TRANSFORM
#END


	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */

  confirmationsubjectfound         := le.confirmationsubjectfound;
	subjectdeceased                  := le.SubjectDeceased;
	ssndeceased                      := le.SSNDeceased;
	inquirynonshortterm12month       := le.inquirynonshortterm12month;
	inquiryshortterm12month          := le.inquiryshortterm12month;
	inquirytelcom12month             := le.inquirytelcom12month;
	inquirycollections12month        := le.inquirycollections12month;
	inquirybanking12month            := le.inquirybanking12month;
	inquiryauto12month               := le.inquiryauto12month;

	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */
// sysdate := models.common.sas_date(if(rt.historydate=999999, (STRING8)Std.Date.Today(), (string6)rt.historydate+'01'));

NULL := -999999999;

rvr1903_1_0 := IF((INTEGER)confirmationsubjectfound < 1 or (INTEGER)SubjectDeceased = 1 or (INTEGER)SSNDeceased = 1, -1, MIN(2, IF(MAX((REAL)inquirynonshortterm12month, (INTEGER)(inquiryshortterm12month = '1') +
    (INTEGER)(inquirytelcom12month = '1') +
    (INTEGER)(inquirycollections12month = '1') +
    (INTEGER)(inquirybanking12month = '1') +
    (INTEGER)(inquiryauto12month = '1')) = NULL, -NULL, MAX((REAL)inquirynonshortterm12month, (INTEGER)(inquiryshortterm12month = '1') +
    (INTEGER)(inquirytelcom12month = '1') +
    (INTEGER)(inquirycollections12month = '1') +
    (INTEGER)(inquirybanking12month = '1') +
    (INTEGER)(inquiryauto12month = '1')))));


	//*************************************************************************************//
	//                     RiskView Version 5 - RVT1608_2 Score Overrides TODO: change values
	//*************************************************************************************//
	// Deceased = 200
	// Unscorable = 222
	// Score Range: 501 - 900
	//*************************************************************************************//

#IF(MODEL_DEBUG)
	/* Model Input Variables */	
  SELF.seq                              := le.seq;
  // SELF.Account                          := le.AccountNumber;
  SELF.Account                          := (string30) le.DID;
  SELF.confirmationsubjectfound         := confirmationsubjectfound;
	SELF.subjectdeceased                  := SubjectDeceased;
	SELF.ssndeceased                      := SSNDeceased;
	SELF.inquirynonshortterm12month       := inquirynonshortterm12month;
	SELF.inquiryshortterm12month          := inquiryshortterm12month;
	SELF.inquirytelcom12month             := inquirytelcom12month;
	SELF.inquirycollections12month        := inquirycollections12month;
	SELF.inquirybanking12month            := inquirybanking12month;
	SELF.inquiryauto12month               := inquiryauto12month;
  SELF.rvr1903_1_0                      := (STRING3)rvr1903_1_0;
										
#ELSE
  SELF.ri                               := [];
  SELF.score                            := (STRING3)rvr1903_1_0;
  SELF.seq                              := le.seq;
#END
	END;

	
  // model := PROJECT(attributes, left.seq=right.seq, doModel(LEFT, right));
  model := PROJECT(attributes, doModel(LEFT));
	RETURN(model);
END;