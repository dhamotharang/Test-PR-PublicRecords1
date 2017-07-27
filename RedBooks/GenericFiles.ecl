import ut;
export GenericFiles := module

 SHARED _Root := _Dataset.thor_cluster_Files + 'in::Redbooks::using::';

 SHARED AssignDocID(STRING pGenericInFileName,
                    STRING4 pHeaderRecType,
										INTEGER pSrc) := FUNCTION
	 SHARED fdef(STRING pFile) := DATASET(pGenericInFileName,
                                          RedBooks.Layouts.Vendor.Generic_in,
								          THOR);
	  	  
 	 _Generic_In := fdef(pGenericInFileName);
	 _Generic := PROJECT(_Generic_in,TRANSFORM(Layouts.Vendor.Generic, self.DocID := 0; self := LEFT;));
	
	 Layouts.Vendor.Generic DocIDit( Layouts.Vendor.Generic L,
                                    Layouts.Vendor.Generic R,
									STRING4 pRecType
							       ) := TRANSFORM
         SELF.DocId := IF(R.Stuff[2..5] = pRecType,L.DocId + 1,L.DocId );
         SELF := R;
     end;
     
	   _Documented := ITERATE(_Generic,DocIDit(LEFT,RIGHT,pHeaderRecType)); 
		 
	   RETURN DISTRIBUTE(PROJECT(_Documented,TRANSFORM(Layouts.Vendor.Generic,
		                                    SELF.DocId := (INTEGER) ((STRING)pSrc + (STRING)LEFT.DocId);
			   								SELF := LEFT)),HASH(DocID));
	END;

  EXPORT ISDA := module	    
	  shared STRING ISDA_Filename := _Root + 'ISDA';
	  export File := AssignDocID(ISDA_Filename,Input_Record_Types.Class_Description,Source_Codes.ISDA); 
	  //export INT
  end;    
  
  EXPORT ISDAA := module
   shared STRING ISDAA_Filename := _Root + 'ISDAA';
   export File := AssignDocID(ISDAA_Filename,Input_Record_Types.Title,Source_Codes.ISDAA);
  end;
  
  EXPORT IAD := module
   shared STRING IAD_Filename := _Root + 'IAD';
   export File := AssignDocID(IAD_Filename,Input_Record_Types.Class_Description,Source_Codes.IAD);
  end;
  
  EXPORT IAG := module
   shared STRING IAG_Filename := _Root + 'IAG';
   export File := AssignDocID(IAG_Filename,Input_Record_Types.Title,Source_Codes.IAG);
  end;
  
end;