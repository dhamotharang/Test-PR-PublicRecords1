IMPORT Mortgage_Fraud, didville, Risk_Indicators, VerificationOfOccupancy;


EXPORT revised_layouts := module;

//=============================================
//===  Mortgage Shell is Boca Shell (with IID)
//===   plus the VOO Attributes 
//=============================================

 export Layout_Mortgage_Shell_VOO :=
   RECORD
	   Risk_Indicators.Layout_Boca_Shell - voo_attributes;  // temporarily take these attributes out of the layout until shell 5.3 is released and get_voo_function is plugged into getAllBocashellData
	   VerificationOfOccupancy.Layouts.Layout_VOOAttributes             VOO_attributes; 
   END;

//=============================================
//===  Mortgage Shell is Boca Shell (with IID)
//===   plus the VOO Attributes 
//=============================================

 export Layout_Mortgage_Shell :=
   RECORD
	   Layout_Mortgage_Shell_VOO                   MRR_Borrower1; 
	   Layout_Mortgage_Shell_VOO                   MRR_Borrower2; 
   END;

END; 

 

