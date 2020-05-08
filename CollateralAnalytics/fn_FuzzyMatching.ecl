import CollateralAnalytics, std,java;

export fn_FuzzyMatching:=function

loadfile:=CollateralAnalytics.file_CollaterialAnalytics_Base;

ToUpperFile:=project(loadfile,transform(recordof(loadfile),Self.MLS_AIR_CONDITIONING_TYPE:=STD.Str.ToUpperCase(Left.MLS_AIR_CONDITIONING_TYPE);
                                                           Self.MLS_PARKING_TYPE:=STD.Str.ToUpperCase(Left.MLS_PARKING_TYPE);
                                                           Self.MLS_GARAGE:=STD.Str.ToUpperCase(Left.MLS_GARAGE);
                                                           Self.MLS_ROOF_COVER:=STD.Str.ToUpperCase(Left.MLS_ROOF_COVER);
                                                           Self.MLS_HEATING:=STD.Str.ToUpperCase(Left.MLS_HEATING);
                                                           Self.MLS_FLOOR_TYPE:=STD.Str.ToUpperCase(Left.MLS_FLOOR_TYPE);
                                                           Self.MLS_POOL_TYPE:=STD.Str.ToUpperCase(Left.MLS_POOL_TYPE);
                                                           Self.MLS_PROP_STYLE:=STD.Str.ToUpperCase(Left.MLS_PROP_STYLE);
                                                           Self.MLS_FIREPLACE_TYPE:=STD.Str.ToUpperCase(Left.MLS_FIREPLACE_TYPE);
                                                           Self.MLS_CONSTRUCTION_TYPE:=STD.Str.ToUpperCase(Left.MLS_CONSTRUCTION_TYPE);
                                                           Self.MLS_FOUNDATION:=STD.Str.ToUpperCase(Left.MLS_FOUNDATION);
                                                           Self.MLS_SEWER:=STD.Str.ToUpperCase(Left.MLS_SEWER);
                                                           Self.MLS_PROPERTY_CONDITION:=STD.Str.ToUpperCase(Left.MLS_PROPERTY_CONDITION);
                                                           Self.MLS_PROPERTY_TYPE:=STD.Str.ToUpperCase(Left.MLS_PROPERTY_TYPE);
                                                           Self:=left;));


//remove digit only entries
RemoveDigits:=project(ToUpperFile,transform(recordof(ToUpperFile),Self.MLS_AIR_CONDITIONING_TYPE:=if(STD.STR.FilterOut(Left.MLS_AIR_CONDITIONING_TYPE,'0123456789')='','',Left.MLS_AIR_CONDITIONING_TYPE);
                                                           Self.MLS_PARKING_TYPE:=if(STD.STR.FilterOut(Left.MLS_PARKING_TYPE,'0123456789')='','',Left.MLS_PARKING_TYPE);
                                                           Self.MLS_GARAGE:=if(STD.STR.FilterOut(Left.MLS_GARAGE,'0123456789')='','',Left.MLS_GARAGE);
                                                           Self.MLS_ROOF_COVER:=if(STD.STR.FilterOut(Left.MLS_ROOF_COVER,'0123456789')='','',Left.MLS_ROOF_COVER);
                                                           Self.MLS_HEATING:=if(STD.STR.FilterOut(Left.MLS_HEATING,'0123456789')='','',Left.MLS_HEATING);
                                                           Self.MLS_FLOOR_TYPE:=if(STD.STR.FilterOut(Left.MLS_FLOOR_TYPE,'0123456789')='','',Left.MLS_FLOOR_TYPE);
                                                           Self.MLS_POOL_TYPE:=if(STD.STR.FilterOut(Left.MLS_POOL_TYPE,'0123456789')='','',Left.MLS_POOL_TYPE);
                                                           Self.MLS_PROP_STYLE:=if(STD.STR.FilterOut(Left.MLS_PROP_STYLE,'0123456789')='','',Left.MLS_PROP_STYLE);
                                                           Self.MLS_FIREPLACE_TYPE:=if(STD.STR.FilterOut(Left.MLS_FIREPLACE_TYPE,'0123456789')='','',Left.MLS_FIREPLACE_TYPE);
                                                           Self.MLS_CONSTRUCTION_TYPE:=if(STD.STR.FilterOut(Left.MLS_CONSTRUCTION_TYPE,'0123456789')='','',Left.MLS_CONSTRUCTION_TYPE);
                                                           Self.MLS_FOUNDATION:=if(STD.STR.FilterOut(Left.MLS_FOUNDATION,'0123456789')='','',Left.MLS_FOUNDATION);
                                                           Self.MLS_SEWER:=if(STD.STR.FilterOut(Left.MLS_SEWER,'0123456789')='','',Left.MLS_SEWER);
                                                           Self.MLS_PROPERTY_CONDITION:=if(STD.STR.FilterOut(Left.MLS_PROPERTY_CONDITION,'0123456789')='','',Left.MLS_PROPERTY_CONDITION);
                                                           Self.MLS_PROPERTY_TYPE:=if(STD.STR.FilterOut(Left.MLS_PROPERTY_TYPE,'0123456789')='','',Left.MLS_PROPERTY_TYPE);
                                                           Self:=left;));

//STD.STR.FilterOut(trimmed,'0123456789')=''=>'',
//Check Against Lookup Table

MLS_AC_TYPE_Table               :=table(RemoveDigits,{MLS_AIR_CONDITIONING_TYPE,cnt:=count(group)},MLS_AIR_CONDITIONING_TYPE);
MLS_PARKING_TYPE_Table          :=table(RemoveDigits,{MLS_PARKING_TYPE,cnt:=count(group)},MLS_PARKING_TYPE);
MLS_GARAGE_Table                :=table(RemoveDigits,{MLS_GARAGE,cnt:=count(group)},MLS_GARAGE);
MLS_ROOF_COVER_Table            :=table(RemoveDigits,{MLS_ROOF_COVER,cnt:=count(group)},MLS_ROOF_COVER);
MLS_HEATING_Table               :=table(RemoveDigits,{MLS_HEATING,cnt:=count(group)},MLS_HEATING);
MLS_FLOOR_TYPE_Table            :=table(RemoveDigits,{MLS_FLOOR_TYPE,cnt:=count(group)},MLS_FLOOR_TYPE);
MLS_POOL_TYPE_Table             :=table(RemoveDigits,{MLS_POOL_TYPE,cnt:=count(group)},MLS_POOL_TYPE);
MLS_PROP_STYLE_Table            :=table(RemoveDigits,{MLS_PROP_STYLE,cnt:=count(group)},MLS_PROP_STYLE);
MLS_FIREPLACE_TYPE_Table        :=table(RemoveDigits,{MLS_FIREPLACE_TYPE,cnt:=count(group)},MLS_FIREPLACE_TYPE);
MLS_CONSTRUCTION_TYPE_Table     :=table(RemoveDigits,{MLS_CONSTRUCTION_TYPE,cnt:=count(group)},MLS_CONSTRUCTION_TYPE);
MLS_FOUNDATION_Table            :=table(RemoveDigits,{MLS_FOUNDATION,cnt:=count(group)},MLS_FOUNDATION);
MLS_SEWER_Table                 :=table(RemoveDigits,{MLS_SEWER,cnt:=count(group)},MLS_SEWER);
MLS_PROPERTY_CONDITION_Table    :=table(RemoveDigits,{MLS_PROPERTY_CONDITION,cnt:=count(group)},MLS_PROPERTY_CONDITION);
MLS_PROPERTY_TYPE_Table         :=table(RemoveDigits,{MLS_PROPERTY_TYPE,cnt:=count(group)},MLS_PROPERTY_TYPE);


//prep for fuzzy

PreProcessRec:=RECORD
    String RawData;
    String Processed;
    String ProcessedRound2;
    integer Cnt;
    String split1;
    String split2;
    String split3;
    String split4;
    String split5;
    String split6;
    String split7;
    String split8;
    String split9;
    String split10;
    String split11;
    String split12;
    String split13;
    String split14;
    String split15;
END;

MLS_AC_TYPE_PreSplit              :=project(MLS_AC_TYPE_Table,transform(PreProcessRec,Self.RawData:=left.MLS_AIR_CONDITIONING_TYPE;Self.Cnt:=left.cnt;self:=left;self:=[];));               
MLS_PARKING_TYPE_PreSplit         :=project(MLS_PARKING_TYPE_Table,transform(PreProcessRec,Self.RawData:=left.MLS_PARKING_TYPE;Self.Cnt:=left.cnt;self:=left;self:=[];));          
MLS_GARAGE_PreSplit               :=project(MLS_GARAGE_Table,transform(PreProcessRec,Self.RawData:=left.MLS_GARAGE;Self.Cnt:=left.cnt;self:=left;self:=[];));                
MLS_ROOF_COVER_PreSplit           :=project(MLS_ROOF_COVER_Table,transform(PreProcessRec,Self.RawData:=left.MLS_ROOF_COVER;Self.Cnt:=left.cnt;self:=left;self:=[];));            
MLS_HEATING_PreSplit              :=project(MLS_HEATING_Table,transform(PreProcessRec,Self.RawData:=left.MLS_HEATING;Self.Cnt:=left.cnt;self:=left;self:=[];));               
MLS_FLOOR_TYPE_PreSplit           :=project(MLS_FLOOR_TYPE_Table,transform(PreProcessRec,Self.RawData:=left.MLS_FLOOR_TYPE;Self.Cnt:=left.cnt;self:=left;self:=[];));            
MLS_POOL_TYPE_PreSplit            :=project(MLS_POOL_TYPE_Table,transform(PreProcessRec,Self.RawData:=left.MLS_POOL_TYPE;Self.Cnt:=left.cnt;self:=left;self:=[];));             
MLS_PROP_STYLE_PreSplit           :=project(MLS_PROP_STYLE_Table,transform(PreProcessRec,Self.RawData:=left.MLS_PROP_STYLE;Self.Cnt:=left.cnt;self:=left;self:=[];));            
MLS_FIREPLACE_TYPE_PreSplit       :=project(MLS_FIREPLACE_TYPE_Table,transform(PreProcessRec,Self.RawData:=left.MLS_FIREPLACE_TYPE;Self.Cnt:=left.cnt;self:=left;self:=[];));        
MLS_CONSTRUCTION_TYPE_PreSplit    :=project(MLS_CONSTRUCTION_TYPE_Table,transform(PreProcessRec,Self.RawData:=left.MLS_CONSTRUCTION_TYPE;Self.Cnt:=left.cnt;self:=left;self:=[];));     
MLS_FOUNDATION_PreSplit           :=project(MLS_FOUNDATION_Table,transform(PreProcessRec,Self.RawData:=left.MLS_FOUNDATION;Self.Cnt:=left.cnt;self:=left;self:=[];));            
MLS_SEWER_PreSplit                :=project(MLS_SEWER_Table,transform(PreProcessRec,Self.RawData:=left.MLS_SEWER;Self.Cnt:=left.cnt;self:=left;self:=[];));                 
MLS_PROPERTY_CONDITION_PreSplit   :=project(MLS_PROPERTY_CONDITION_Table,transform(PreProcessRec,Self.RawData:=left.MLS_PROPERTY_CONDITION;Self.Cnt:=left.cnt;self:=left;self:=[];));    
MLS_PROPERTY_TYPE_PreSplit        :=project(MLS_PROPERTY_TYPE_Table,transform(PreProcessRec,Self.RawData:=left.MLS_PROPERTY_TYPE;Self.Cnt:=left.cnt;self:=left;self:=[];));         

PreProcessRec tSplit(PreProcessRec L):=TRANSFORM
    Set of String SplitString:=STD.STR.SplitWords(L.RawData,',',true);
    Self.split1:=SplitString[1];
    Self.split2:=SplitString[2];
    Self.split3:=SplitString[3];
    Self.split4:=SplitString[4];
    Self.split5:=SplitString[5];
    Self.split6:=SplitString[6];
    Self.split7:=SplitString[7];
    Self.split8:=SplitString[8];
    Self.split9:=SplitString[9];
    Self.split10:=SplitString[10];
    Self.split11:=SplitString[11];
    Self.split12:=SplitString[12];
    Self.split13:=SplitString[13];
    Self.split14:=SplitString[14];
    Self.split15:=SplitString[15];
    self.Processed:='';
    self.ProcessedRound2:='';
    self:=L;
END;

MLS_AC_TYPE_Split              :=project(MLS_AC_TYPE_PreSplit,tSplit(left));              
MLS_PARKING_TYPE_Split         :=project(MLS_PARKING_TYPE_PreSplit,tSplit(left));         
MLS_GARAGE_Split               :=project(MLS_GARAGE_PreSplit,tSplit(left));               
MLS_ROOF_COVER_Split           :=project(MLS_ROOF_COVER_PreSplit,tSplit(left));           
MLS_HEATING_Split              :=project(MLS_HEATING_PreSplit,tSplit(left));              
MLS_FLOOR_TYPE_Split           :=project(MLS_FLOOR_TYPE_PreSplit,tSplit(left));           
MLS_POOL_TYPE_Split            :=project(MLS_POOL_TYPE_PreSplit,tSplit(left));            
MLS_PROP_STYLE_Split           :=project(MLS_PROP_STYLE_PreSplit,tSplit(left));           
MLS_FIREPLACE_TYPE_Split       :=project(MLS_FIREPLACE_TYPE_PreSplit,tSplit(left));       
MLS_CONSTRUCTION_TYPE_Split    :=project(MLS_CONSTRUCTION_TYPE_PreSplit,tSplit(left));    
MLS_FOUNDATION_Split           :=project(MLS_FOUNDATION_PreSplit,tSplit(left));           
MLS_SEWER_Split                :=project(MLS_SEWER_PreSplit,tSplit(left));                
MLS_PROPERTY_CONDITION_Split   :=project(MLS_PROPERTY_CONDITION_PreSplit,tSplit(left));   
MLS_PROPERTY_TYPE_Split        :=project(MLS_PROPERTY_TYPE_PreSplit,tSplit(left));        


MLS_AC_TYPE_Input               :=project(MLS_AC_TYPE_Split,transform(PreProcessRec,Self.split1:=CollateralAnalytics.PreFuzzyFunctions.MLS_AC_TYPE_PREPROCESS(Left.split1);
                                                                                    Self.split2:=CollateralAnalytics.PreFuzzyFunctions.MLS_AC_TYPE_PREPROCESS(Left.split2);
                                                                                    Self.split3:=CollateralAnalytics.PreFuzzyFunctions.MLS_AC_TYPE_PREPROCESS(Left.split3);
                                                                                    Self.split4:=CollateralAnalytics.PreFuzzyFunctions.MLS_AC_TYPE_PREPROCESS(Left.split4);
                                                                                    Self.split5:=CollateralAnalytics.PreFuzzyFunctions.MLS_AC_TYPE_PREPROCESS(Left.split5);
                                                                                    Self.split6:=CollateralAnalytics.PreFuzzyFunctions.MLS_AC_TYPE_PREPROCESS(Left.split6);
                                                                                    Self.split7:=CollateralAnalytics.PreFuzzyFunctions.MLS_AC_TYPE_PREPROCESS(Left.split7);
                                                                                    Self.split8:=CollateralAnalytics.PreFuzzyFunctions.MLS_AC_TYPE_PREPROCESS(Left.split8);
                                                                                    Self.split9:=CollateralAnalytics.PreFuzzyFunctions.MLS_AC_TYPE_PREPROCESS(Left.split9);
                                                                                    Self.split10:=CollateralAnalytics.PreFuzzyFunctions.MLS_AC_TYPE_PREPROCESS(Left.split10);
                                                                                    Self.split11:=CollateralAnalytics.PreFuzzyFunctions.MLS_AC_TYPE_PREPROCESS(Left.split11);
                                                                                    Self.split12:=CollateralAnalytics.PreFuzzyFunctions.MLS_AC_TYPE_PREPROCESS(Left.split12);
                                                                                    Self.split13:=CollateralAnalytics.PreFuzzyFunctions.MLS_AC_TYPE_PREPROCESS(Left.split13);
                                                                                    Self.split14:=CollateralAnalytics.PreFuzzyFunctions.MLS_AC_TYPE_PREPROCESS(Left.split14);
                                                                                    Self.split15:=CollateralAnalytics.PreFuzzyFunctions.MLS_AC_TYPE_PREPROCESS(Left.split15);
                                                                                    self:=left;)
                                                                                    );
MLS_PARKING_TYPE_Input_Round1          :=project(MLS_PARKING_TYPE_Split,transform(PreProcessRec,
                                                                                    Self.split1:=CollateralAnalytics.PreFuzzyFunctions.MLS_PARKING_TYPE_PREPROCESS(Left.split1);
                                                                                    Self.split2:=CollateralAnalytics.PreFuzzyFunctions.MLS_PARKING_TYPE_PREPROCESS(Left.split2);
                                                                                    Self.split3:=CollateralAnalytics.PreFuzzyFunctions.MLS_PARKING_TYPE_PREPROCESS(Left.split3);
                                                                                    Self.split4:=CollateralAnalytics.PreFuzzyFunctions.MLS_PARKING_TYPE_PREPROCESS(Left.split4);
                                                                                    Self.split5:=CollateralAnalytics.PreFuzzyFunctions.MLS_PARKING_TYPE_PREPROCESS(Left.split5);
                                                                                    Self.split6:=CollateralAnalytics.PreFuzzyFunctions.MLS_PARKING_TYPE_PREPROCESS(Left.split6);
                                                                                    Self.split7:=CollateralAnalytics.PreFuzzyFunctions.MLS_PARKING_TYPE_PREPROCESS(Left.split7);
                                                                                    Self.split8:=CollateralAnalytics.PreFuzzyFunctions.MLS_PARKING_TYPE_PREPROCESS(Left.split8);
                                                                                    Self.split9:=CollateralAnalytics.PreFuzzyFunctions.MLS_PARKING_TYPE_PREPROCESS(Left.split9);
                                                                                    Self.split10:=CollateralAnalytics.PreFuzzyFunctions.MLS_PARKING_TYPE_PREPROCESS(Left.split10);
                                                                                    Self.split11:=CollateralAnalytics.PreFuzzyFunctions.MLS_PARKING_TYPE_PREPROCESS(Left.split11);
                                                                                    Self.split12:=CollateralAnalytics.PreFuzzyFunctions.MLS_PARKING_TYPE_PREPROCESS(Left.split12);
                                                                                    Self.split13:=CollateralAnalytics.PreFuzzyFunctions.MLS_PARKING_TYPE_PREPROCESS(Left.split13);
                                                                                    Self.split14:=CollateralAnalytics.PreFuzzyFunctions.MLS_PARKING_TYPE_PREPROCESS(Left.split14);
                                                                                    Self.split15:=CollateralAnalytics.PreFuzzyFunctions.MLS_PARKING_TYPE_PREPROCESS(Left.split15);
                                                                                    self:=left;));
MLS_GARAGE_Input_Round1                :=project(MLS_GARAGE_Split,transform(PreProcessRec,
                                                                                    Self.split1:=CollateralAnalytics.PreFuzzyFunctions.MLS_GARAGE_PREPROCESS(Left.split1);
                                                                                    Self.split2:=CollateralAnalytics.PreFuzzyFunctions.MLS_GARAGE_PREPROCESS(Left.split2);
                                                                                    Self.split3:=CollateralAnalytics.PreFuzzyFunctions.MLS_GARAGE_PREPROCESS(Left.split3);
                                                                                    Self.split4:=CollateralAnalytics.PreFuzzyFunctions.MLS_GARAGE_PREPROCESS(Left.split4);
                                                                                    Self.split5:=CollateralAnalytics.PreFuzzyFunctions.MLS_GARAGE_PREPROCESS(Left.split5);
                                                                                    Self.split6:=CollateralAnalytics.PreFuzzyFunctions.MLS_GARAGE_PREPROCESS(Left.split6);
                                                                                    Self.split7:=CollateralAnalytics.PreFuzzyFunctions.MLS_GARAGE_PREPROCESS(Left.split7);
                                                                                    Self.split8:=CollateralAnalytics.PreFuzzyFunctions.MLS_GARAGE_PREPROCESS(Left.split8);
                                                                                    Self.split9:=CollateralAnalytics.PreFuzzyFunctions.MLS_GARAGE_PREPROCESS(Left.split9);
                                                                                    Self.split10:=CollateralAnalytics.PreFuzzyFunctions.MLS_GARAGE_PREPROCESS(Left.split10);
                                                                                    Self.split11:=CollateralAnalytics.PreFuzzyFunctions.MLS_GARAGE_PREPROCESS(Left.split11);
                                                                                    Self.split12:=CollateralAnalytics.PreFuzzyFunctions.MLS_GARAGE_PREPROCESS(Left.split12);
                                                                                    Self.split13:=CollateralAnalytics.PreFuzzyFunctions.MLS_GARAGE_PREPROCESS(Left.split13);
                                                                                    Self.split14:=CollateralAnalytics.PreFuzzyFunctions.MLS_GARAGE_PREPROCESS(Left.split14);
                                                                                    Self.split15:=CollateralAnalytics.PreFuzzyFunctions.MLS_GARAGE_PREPROCESS(Left.split15);
                                                                                    self:=left;));
MLS_ROOF_COVER_Input            :=project(MLS_ROOF_COVER_Split,transform(PreProcessRec,
                                                                                    Self.split1:=CollateralAnalytics.PreFuzzyFunctions.MLS_ROOF_COVER_PREPROCESS(Left.split1);
                                                                                    Self.split2:=CollateralAnalytics.PreFuzzyFunctions.MLS_ROOF_COVER_PREPROCESS(Left.split2);
                                                                                    Self.split3:=CollateralAnalytics.PreFuzzyFunctions.MLS_ROOF_COVER_PREPROCESS(Left.split3);
                                                                                    Self.split4:=CollateralAnalytics.PreFuzzyFunctions.MLS_ROOF_COVER_PREPROCESS(Left.split4);
                                                                                    Self.split5:=CollateralAnalytics.PreFuzzyFunctions.MLS_ROOF_COVER_PREPROCESS(Left.split5);
                                                                                    Self.split6:=CollateralAnalytics.PreFuzzyFunctions.MLS_ROOF_COVER_PREPROCESS(Left.split6);
                                                                                    Self.split7:=CollateralAnalytics.PreFuzzyFunctions.MLS_ROOF_COVER_PREPROCESS(Left.split7);
                                                                                    Self.split8:=CollateralAnalytics.PreFuzzyFunctions.MLS_ROOF_COVER_PREPROCESS(Left.split8);
                                                                                    Self.split9:=CollateralAnalytics.PreFuzzyFunctions.MLS_ROOF_COVER_PREPROCESS(Left.split9);
                                                                                    Self.split10:=CollateralAnalytics.PreFuzzyFunctions.MLS_ROOF_COVER_PREPROCESS(Left.split10);
                                                                                    Self.split11:=CollateralAnalytics.PreFuzzyFunctions.MLS_ROOF_COVER_PREPROCESS(Left.split11);
                                                                                    Self.split12:=CollateralAnalytics.PreFuzzyFunctions.MLS_ROOF_COVER_PREPROCESS(Left.split12);
                                                                                    Self.split13:=CollateralAnalytics.PreFuzzyFunctions.MLS_ROOF_COVER_PREPROCESS(Left.split13);
                                                                                    Self.split14:=CollateralAnalytics.PreFuzzyFunctions.MLS_ROOF_COVER_PREPROCESS(Left.split14);
                                                                                    Self.split15:=CollateralAnalytics.PreFuzzyFunctions.MLS_ROOF_COVER_PREPROCESS(Left.split15);
                                                                                    self:=left;));
MLS_HEATING_Input               :=project(MLS_HEATING_Split,transform(PreProcessRec,
                                                                                    Self.split1:=CollateralAnalytics.PreFuzzyFunctions.MLS_HEATING_PREPROCESS(Left.split1);
                                                                                    Self.split2:=CollateralAnalytics.PreFuzzyFunctions.MLS_HEATING_PREPROCESS(Left.split2);
                                                                                    Self.split3:=CollateralAnalytics.PreFuzzyFunctions.MLS_HEATING_PREPROCESS(Left.split3);
                                                                                    Self.split4:=CollateralAnalytics.PreFuzzyFunctions.MLS_HEATING_PREPROCESS(Left.split4);
                                                                                    Self.split5:=CollateralAnalytics.PreFuzzyFunctions.MLS_HEATING_PREPROCESS(Left.split5);
                                                                                    Self.split6:=CollateralAnalytics.PreFuzzyFunctions.MLS_HEATING_PREPROCESS(Left.split6);
                                                                                    Self.split7:=CollateralAnalytics.PreFuzzyFunctions.MLS_HEATING_PREPROCESS(Left.split7);
                                                                                    Self.split8:=CollateralAnalytics.PreFuzzyFunctions.MLS_HEATING_PREPROCESS(Left.split8);
                                                                                    Self.split9:=CollateralAnalytics.PreFuzzyFunctions.MLS_HEATING_PREPROCESS(Left.split9);
                                                                                    Self.split10:=CollateralAnalytics.PreFuzzyFunctions.MLS_HEATING_PREPROCESS(Left.split10);
                                                                                    Self.split11:=CollateralAnalytics.PreFuzzyFunctions.MLS_HEATING_PREPROCESS(Left.split11);
                                                                                    Self.split12:=CollateralAnalytics.PreFuzzyFunctions.MLS_HEATING_PREPROCESS(Left.split12);
                                                                                    Self.split13:=CollateralAnalytics.PreFuzzyFunctions.MLS_HEATING_PREPROCESS(Left.split13);
                                                                                    Self.split14:=CollateralAnalytics.PreFuzzyFunctions.MLS_HEATING_PREPROCESS(Left.split14);
                                                                                    Self.split15:=CollateralAnalytics.PreFuzzyFunctions.MLS_HEATING_PREPROCESS(Left.split15);
                                                                                    self:=left;));
MLS_FLOOR_TYPE_Input            :=project(MLS_FLOOR_TYPE_Split,transform(PreProcessRec,
                                                                                    Self.split1:=CollateralAnalytics.PreFuzzyFunctions.MLS_FLOOR_TYPE_PREPROCESS(Left.split1);
                                                                                    Self.split2:=CollateralAnalytics.PreFuzzyFunctions.MLS_FLOOR_TYPE_PREPROCESS(Left.split2);
                                                                                    Self.split3:=CollateralAnalytics.PreFuzzyFunctions.MLS_FLOOR_TYPE_PREPROCESS(Left.split3);
                                                                                    Self.split4:=CollateralAnalytics.PreFuzzyFunctions.MLS_FLOOR_TYPE_PREPROCESS(Left.split4);
                                                                                    Self.split5:=CollateralAnalytics.PreFuzzyFunctions.MLS_FLOOR_TYPE_PREPROCESS(Left.split5);
                                                                                    Self.split6:=CollateralAnalytics.PreFuzzyFunctions.MLS_FLOOR_TYPE_PREPROCESS(Left.split6);
                                                                                    Self.split7:=CollateralAnalytics.PreFuzzyFunctions.MLS_FLOOR_TYPE_PREPROCESS(Left.split7);
                                                                                    Self.split8:=CollateralAnalytics.PreFuzzyFunctions.MLS_FLOOR_TYPE_PREPROCESS(Left.split8);
                                                                                    Self.split9:=CollateralAnalytics.PreFuzzyFunctions.MLS_FLOOR_TYPE_PREPROCESS(Left.split9);
                                                                                    Self.split10:=CollateralAnalytics.PreFuzzyFunctions.MLS_FLOOR_TYPE_PREPROCESS(Left.split10);
                                                                                    Self.split11:=CollateralAnalytics.PreFuzzyFunctions.MLS_FLOOR_TYPE_PREPROCESS(Left.split11);
                                                                                    Self.split12:=CollateralAnalytics.PreFuzzyFunctions.MLS_FLOOR_TYPE_PREPROCESS(Left.split12);
                                                                                    Self.split13:=CollateralAnalytics.PreFuzzyFunctions.MLS_FLOOR_TYPE_PREPROCESS(Left.split13);
                                                                                    Self.split14:=CollateralAnalytics.PreFuzzyFunctions.MLS_FLOOR_TYPE_PREPROCESS(Left.split14);
                                                                                    Self.split15:=CollateralAnalytics.PreFuzzyFunctions.MLS_FLOOR_TYPE_PREPROCESS(Left.split15);
                                                                                    self:=left;));
MLS_POOL_TYPE_Input             :=project(MLS_POOL_TYPE_Split,transform(PreProcessRec,
                                                                                    Self.split1:=CollateralAnalytics.PreFuzzyFunctions.MLS_POOL_TYPE_PREPROCESS(Left.split1);
                                                                                    Self.split2:=CollateralAnalytics.PreFuzzyFunctions.MLS_POOL_TYPE_PREPROCESS(Left.split2);
                                                                                    Self.split3:=CollateralAnalytics.PreFuzzyFunctions.MLS_POOL_TYPE_PREPROCESS(Left.split3);
                                                                                    Self.split4:=CollateralAnalytics.PreFuzzyFunctions.MLS_POOL_TYPE_PREPROCESS(Left.split4);
                                                                                    Self.split5:=CollateralAnalytics.PreFuzzyFunctions.MLS_POOL_TYPE_PREPROCESS(Left.split5);
                                                                                    Self.split6:=CollateralAnalytics.PreFuzzyFunctions.MLS_POOL_TYPE_PREPROCESS(Left.split6);
                                                                                    Self.split7:=CollateralAnalytics.PreFuzzyFunctions.MLS_POOL_TYPE_PREPROCESS(Left.split7);
                                                                                    Self.split8:=CollateralAnalytics.PreFuzzyFunctions.MLS_POOL_TYPE_PREPROCESS(Left.split8);
                                                                                    Self.split9:=CollateralAnalytics.PreFuzzyFunctions.MLS_POOL_TYPE_PREPROCESS(Left.split9);
                                                                                    Self.split10:=CollateralAnalytics.PreFuzzyFunctions.MLS_POOL_TYPE_PREPROCESS(Left.split10);
                                                                                    Self.split11:=CollateralAnalytics.PreFuzzyFunctions.MLS_POOL_TYPE_PREPROCESS(Left.split11);
                                                                                    Self.split12:=CollateralAnalytics.PreFuzzyFunctions.MLS_POOL_TYPE_PREPROCESS(Left.split12);
                                                                                    Self.split13:=CollateralAnalytics.PreFuzzyFunctions.MLS_POOL_TYPE_PREPROCESS(Left.split13);
                                                                                    Self.split14:=CollateralAnalytics.PreFuzzyFunctions.MLS_POOL_TYPE_PREPROCESS(Left.split14);
                                                                                    Self.split15:=CollateralAnalytics.PreFuzzyFunctions.MLS_POOL_TYPE_PREPROCESS(Left.split15);
                                                                                    self:=left;));
MLS_PROP_STYLE_Input            :=project(MLS_PROP_STYLE_Split,transform(PreProcessRec,
                                                                                    Self.split1:=CollateralAnalytics.PreFuzzyFunctions.MLS_PROP_STYLE_PREPROCESS(Left.split1);
                                                                                    Self.split2:=CollateralAnalytics.PreFuzzyFunctions.MLS_PROP_STYLE_PREPROCESS(Left.split2);
                                                                                    Self.split3:=CollateralAnalytics.PreFuzzyFunctions.MLS_PROP_STYLE_PREPROCESS(Left.split3);
                                                                                    Self.split4:=CollateralAnalytics.PreFuzzyFunctions.MLS_PROP_STYLE_PREPROCESS(Left.split4);
                                                                                    Self.split5:=CollateralAnalytics.PreFuzzyFunctions.MLS_PROP_STYLE_PREPROCESS(Left.split5);
                                                                                    Self.split6:=CollateralAnalytics.PreFuzzyFunctions.MLS_PROP_STYLE_PREPROCESS(Left.split6);
                                                                                    Self.split7:=CollateralAnalytics.PreFuzzyFunctions.MLS_PROP_STYLE_PREPROCESS(Left.split7);
                                                                                    Self.split8:=CollateralAnalytics.PreFuzzyFunctions.MLS_PROP_STYLE_PREPROCESS(Left.split8);
                                                                                    Self.split9:=CollateralAnalytics.PreFuzzyFunctions.MLS_PROP_STYLE_PREPROCESS(Left.split9);
                                                                                    Self.split10:=CollateralAnalytics.PreFuzzyFunctions.MLS_PROP_STYLE_PREPROCESS(Left.split10);
                                                                                    Self.split11:=CollateralAnalytics.PreFuzzyFunctions.MLS_PROP_STYLE_PREPROCESS(Left.split11);
                                                                                    Self.split12:=CollateralAnalytics.PreFuzzyFunctions.MLS_PROP_STYLE_PREPROCESS(Left.split12);
                                                                                    Self.split13:=CollateralAnalytics.PreFuzzyFunctions.MLS_PROP_STYLE_PREPROCESS(Left.split13);
                                                                                    Self.split14:=CollateralAnalytics.PreFuzzyFunctions.MLS_PROP_STYLE_PREPROCESS(Left.split14);
                                                                                    Self.split15:=CollateralAnalytics.PreFuzzyFunctions.MLS_PROP_STYLE_PREPROCESS(Left.split15);
                                                                                    self:=left;));
MLS_FIREPLACE_TYPE_Input        :=project(MLS_FIREPLACE_TYPE_Split,transform(PreProcessRec,
                                                                                    Self.split1:=CollateralAnalytics.PreFuzzyFunctions.MLS_FIREPLACE_TYPE_PREPROCESS(Left.split1);
                                                                                    Self.split2:=CollateralAnalytics.PreFuzzyFunctions.MLS_FIREPLACE_TYPE_PREPROCESS(Left.split2);
                                                                                    Self.split3:=CollateralAnalytics.PreFuzzyFunctions.MLS_FIREPLACE_TYPE_PREPROCESS(Left.split3);
                                                                                    Self.split4:=CollateralAnalytics.PreFuzzyFunctions.MLS_FIREPLACE_TYPE_PREPROCESS(Left.split4);
                                                                                    Self.split5:=CollateralAnalytics.PreFuzzyFunctions.MLS_FIREPLACE_TYPE_PREPROCESS(Left.split5);
                                                                                    Self.split6:=CollateralAnalytics.PreFuzzyFunctions.MLS_FIREPLACE_TYPE_PREPROCESS(Left.split6);
                                                                                    Self.split7:=CollateralAnalytics.PreFuzzyFunctions.MLS_FIREPLACE_TYPE_PREPROCESS(Left.split7);
                                                                                    Self.split8:=CollateralAnalytics.PreFuzzyFunctions.MLS_FIREPLACE_TYPE_PREPROCESS(Left.split8);
                                                                                    Self.split9:=CollateralAnalytics.PreFuzzyFunctions.MLS_FIREPLACE_TYPE_PREPROCESS(Left.split9);
                                                                                    Self.split10:=CollateralAnalytics.PreFuzzyFunctions.MLS_FIREPLACE_TYPE_PREPROCESS(Left.split10);
                                                                                    Self.split11:=CollateralAnalytics.PreFuzzyFunctions.MLS_FIREPLACE_TYPE_PREPROCESS(Left.split11);
                                                                                    Self.split12:=CollateralAnalytics.PreFuzzyFunctions.MLS_FIREPLACE_TYPE_PREPROCESS(Left.split12);
                                                                                    Self.split13:=CollateralAnalytics.PreFuzzyFunctions.MLS_FIREPLACE_TYPE_PREPROCESS(Left.split13);
                                                                                    Self.split14:=CollateralAnalytics.PreFuzzyFunctions.MLS_FIREPLACE_TYPE_PREPROCESS(Left.split14);
                                                                                    Self.split15:=CollateralAnalytics.PreFuzzyFunctions.MLS_FIREPLACE_TYPE_PREPROCESS(Left.split15);
                                                                                    self:=left;));
MLS_CONSTRUCTION_TYPE_Input     :=project(MLS_CONSTRUCTION_TYPE_Split,transform(PreProcessRec,
                                                                                    Self.split1:=CollateralAnalytics.PreFuzzyFunctions.MLS_CONSTRUCTION_TYPE_PREPROCESS(Left.split1);
                                                                                    Self.split2:=CollateralAnalytics.PreFuzzyFunctions.MLS_CONSTRUCTION_TYPE_PREPROCESS(Left.split2);
                                                                                    Self.split3:=CollateralAnalytics.PreFuzzyFunctions.MLS_CONSTRUCTION_TYPE_PREPROCESS(Left.split3);
                                                                                    Self.split4:=CollateralAnalytics.PreFuzzyFunctions.MLS_CONSTRUCTION_TYPE_PREPROCESS(Left.split4);
                                                                                    Self.split5:=CollateralAnalytics.PreFuzzyFunctions.MLS_CONSTRUCTION_TYPE_PREPROCESS(Left.split5);
                                                                                    Self.split6:=CollateralAnalytics.PreFuzzyFunctions.MLS_CONSTRUCTION_TYPE_PREPROCESS(Left.split6);
                                                                                    Self.split7:=CollateralAnalytics.PreFuzzyFunctions.MLS_CONSTRUCTION_TYPE_PREPROCESS(Left.split7);
                                                                                    Self.split8:=CollateralAnalytics.PreFuzzyFunctions.MLS_CONSTRUCTION_TYPE_PREPROCESS(Left.split8);
                                                                                    Self.split9:=CollateralAnalytics.PreFuzzyFunctions.MLS_CONSTRUCTION_TYPE_PREPROCESS(Left.split9);
                                                                                    Self.split10:=CollateralAnalytics.PreFuzzyFunctions.MLS_CONSTRUCTION_TYPE_PREPROCESS(Left.split10);
                                                                                    Self.split11:=CollateralAnalytics.PreFuzzyFunctions.MLS_CONSTRUCTION_TYPE_PREPROCESS(Left.split11);
                                                                                    Self.split12:=CollateralAnalytics.PreFuzzyFunctions.MLS_CONSTRUCTION_TYPE_PREPROCESS(Left.split12);
                                                                                    Self.split13:=CollateralAnalytics.PreFuzzyFunctions.MLS_CONSTRUCTION_TYPE_PREPROCESS(Left.split13);
                                                                                    Self.split14:=CollateralAnalytics.PreFuzzyFunctions.MLS_CONSTRUCTION_TYPE_PREPROCESS(Left.split14);
                                                                                    Self.split15:=CollateralAnalytics.PreFuzzyFunctions.MLS_CONSTRUCTION_TYPE_PREPROCESS(Left.split15);
                                                                                    self:=left;));
MLS_FOUNDATION_Input            :=project(MLS_FOUNDATION_Split,transform(PreProcessRec,
                                                                                    Self.split1:=CollateralAnalytics.PreFuzzyFunctions.MLS_FOUNDATION_PREPROCESS(Left.split1);
                                                                                    Self.split2:=CollateralAnalytics.PreFuzzyFunctions.MLS_FOUNDATION_PREPROCESS(Left.split2);
                                                                                    Self.split3:=CollateralAnalytics.PreFuzzyFunctions.MLS_FOUNDATION_PREPROCESS(Left.split3);
                                                                                    Self.split4:=CollateralAnalytics.PreFuzzyFunctions.MLS_FOUNDATION_PREPROCESS(Left.split4);
                                                                                    Self.split5:=CollateralAnalytics.PreFuzzyFunctions.MLS_FOUNDATION_PREPROCESS(Left.split5);
                                                                                    Self.split6:=CollateralAnalytics.PreFuzzyFunctions.MLS_FOUNDATION_PREPROCESS(Left.split6);
                                                                                    Self.split7:=CollateralAnalytics.PreFuzzyFunctions.MLS_FOUNDATION_PREPROCESS(Left.split7);
                                                                                    Self.split8:=CollateralAnalytics.PreFuzzyFunctions.MLS_FOUNDATION_PREPROCESS(Left.split8);
                                                                                    Self.split9:=CollateralAnalytics.PreFuzzyFunctions.MLS_FOUNDATION_PREPROCESS(Left.split9);
                                                                                    Self.split10:=CollateralAnalytics.PreFuzzyFunctions.MLS_FOUNDATION_PREPROCESS(Left.split10);
                                                                                    Self.split11:=CollateralAnalytics.PreFuzzyFunctions.MLS_FOUNDATION_PREPROCESS(Left.split11);
                                                                                    Self.split12:=CollateralAnalytics.PreFuzzyFunctions.MLS_FOUNDATION_PREPROCESS(Left.split12);
                                                                                    Self.split13:=CollateralAnalytics.PreFuzzyFunctions.MLS_FOUNDATION_PREPROCESS(Left.split13);
                                                                                    Self.split14:=CollateralAnalytics.PreFuzzyFunctions.MLS_FOUNDATION_PREPROCESS(Left.split14);
                                                                                    Self.split15:=CollateralAnalytics.PreFuzzyFunctions.MLS_FOUNDATION_PREPROCESS(Left.split15);
                                                                                    self:=left;));
MLS_SEWER_Input                 :=project(MLS_SEWER_Split,transform(PreProcessRec,
                                                                                    Self.split1:=CollateralAnalytics.PreFuzzyFunctions.MLS_SEWER_PREPROCESS(Left.split1);
                                                                                    Self.split2:=CollateralAnalytics.PreFuzzyFunctions.MLS_SEWER_PREPROCESS(Left.split2);
                                                                                    Self.split3:=CollateralAnalytics.PreFuzzyFunctions.MLS_SEWER_PREPROCESS(Left.split3);
                                                                                    Self.split4:=CollateralAnalytics.PreFuzzyFunctions.MLS_SEWER_PREPROCESS(Left.split4);
                                                                                    Self.split5:=CollateralAnalytics.PreFuzzyFunctions.MLS_SEWER_PREPROCESS(Left.split5);
                                                                                    Self.split6:=CollateralAnalytics.PreFuzzyFunctions.MLS_SEWER_PREPROCESS(Left.split6);
                                                                                    Self.split7:=CollateralAnalytics.PreFuzzyFunctions.MLS_SEWER_PREPROCESS(Left.split7);
                                                                                    Self.split8:=CollateralAnalytics.PreFuzzyFunctions.MLS_SEWER_PREPROCESS(Left.split8);
                                                                                    Self.split9:=CollateralAnalytics.PreFuzzyFunctions.MLS_SEWER_PREPROCESS(Left.split9);
                                                                                    Self.split10:=CollateralAnalytics.PreFuzzyFunctions.MLS_SEWER_PREPROCESS(Left.split10);
                                                                                    Self.split11:=CollateralAnalytics.PreFuzzyFunctions.MLS_SEWER_PREPROCESS(Left.split11);
                                                                                    Self.split12:=CollateralAnalytics.PreFuzzyFunctions.MLS_SEWER_PREPROCESS(Left.split12);
                                                                                    Self.split13:=CollateralAnalytics.PreFuzzyFunctions.MLS_SEWER_PREPROCESS(Left.split13);
                                                                                    Self.split14:=CollateralAnalytics.PreFuzzyFunctions.MLS_SEWER_PREPROCESS(Left.split14);
                                                                                    Self.split15:=CollateralAnalytics.PreFuzzyFunctions.MLS_SEWER_PREPROCESS(Left.split15);
                                                                                    self:=left;));
MLS_PROPERTY_CONDITION_Input    :=project(MLS_PROPERTY_CONDITION_Split,transform(PreProcessRec,
                                                                                    Self.split1:=CollateralAnalytics.PreFuzzyFunctions.MLS_PROPERTY_CONDITION_PREPROCESS(Left.split1);
                                                                                    Self.split2:=CollateralAnalytics.PreFuzzyFunctions.MLS_PROPERTY_CONDITION_PREPROCESS(Left.split2);
                                                                                    Self.split3:=CollateralAnalytics.PreFuzzyFunctions.MLS_PROPERTY_CONDITION_PREPROCESS(Left.split3);
                                                                                    Self.split4:=CollateralAnalytics.PreFuzzyFunctions.MLS_PROPERTY_CONDITION_PREPROCESS(Left.split4);
                                                                                    Self.split5:=CollateralAnalytics.PreFuzzyFunctions.MLS_PROPERTY_CONDITION_PREPROCESS(Left.split5);
                                                                                    Self.split6:=CollateralAnalytics.PreFuzzyFunctions.MLS_PROPERTY_CONDITION_PREPROCESS(Left.split6);
                                                                                    Self.split7:=CollateralAnalytics.PreFuzzyFunctions.MLS_PROPERTY_CONDITION_PREPROCESS(Left.split7);
                                                                                    Self.split8:=CollateralAnalytics.PreFuzzyFunctions.MLS_PROPERTY_CONDITION_PREPROCESS(Left.split8);
                                                                                    Self.split9:=CollateralAnalytics.PreFuzzyFunctions.MLS_PROPERTY_CONDITION_PREPROCESS(Left.split9);
                                                                                    Self.split10:=CollateralAnalytics.PreFuzzyFunctions.MLS_PROPERTY_CONDITION_PREPROCESS(Left.split10);
                                                                                    Self.split11:=CollateralAnalytics.PreFuzzyFunctions.MLS_PROPERTY_CONDITION_PREPROCESS(Left.split11);
                                                                                    Self.split12:=CollateralAnalytics.PreFuzzyFunctions.MLS_PROPERTY_CONDITION_PREPROCESS(Left.split12);
                                                                                    Self.split13:=CollateralAnalytics.PreFuzzyFunctions.MLS_PROPERTY_CONDITION_PREPROCESS(Left.split13);
                                                                                    Self.split14:=CollateralAnalytics.PreFuzzyFunctions.MLS_PROPERTY_CONDITION_PREPROCESS(Left.split14);
                                                                                    Self.split15:=CollateralAnalytics.PreFuzzyFunctions.MLS_PROPERTY_CONDITION_PREPROCESS(Left.split15);
                                                                                    self:=left;));
MLS_PROPERTY_TYPE_Input         :=project(MLS_PROPERTY_TYPE_Split,transform(PreProcessRec,
                                                                                    Self.split1:=CollateralAnalytics.PreFuzzyFunctions.MLS_PROPERTY_TYPE_PREPROCESS(Left.split1);
                                                                                    Self.split2:=CollateralAnalytics.PreFuzzyFunctions.MLS_PROPERTY_TYPE_PREPROCESS(Left.split2);
                                                                                    Self.split3:=CollateralAnalytics.PreFuzzyFunctions.MLS_PROPERTY_TYPE_PREPROCESS(Left.split3);
                                                                                    Self.split4:=CollateralAnalytics.PreFuzzyFunctions.MLS_PROPERTY_TYPE_PREPROCESS(Left.split4);
                                                                                    Self.split5:=CollateralAnalytics.PreFuzzyFunctions.MLS_PROPERTY_TYPE_PREPROCESS(Left.split5);
                                                                                    Self.split6:=CollateralAnalytics.PreFuzzyFunctions.MLS_PROPERTY_TYPE_PREPROCESS(Left.split6);
                                                                                    Self.split7:=CollateralAnalytics.PreFuzzyFunctions.MLS_PROPERTY_TYPE_PREPROCESS(Left.split7);
                                                                                    Self.split8:=CollateralAnalytics.PreFuzzyFunctions.MLS_PROPERTY_TYPE_PREPROCESS(Left.split8);
                                                                                    Self.split9:=CollateralAnalytics.PreFuzzyFunctions.MLS_PROPERTY_TYPE_PREPROCESS(Left.split9);
                                                                                    Self.split10:=CollateralAnalytics.PreFuzzyFunctions.MLS_PROPERTY_TYPE_PREPROCESS(Left.split10);
                                                                                    Self.split11:=CollateralAnalytics.PreFuzzyFunctions.MLS_PROPERTY_TYPE_PREPROCESS(Left.split11);
                                                                                    Self.split12:=CollateralAnalytics.PreFuzzyFunctions.MLS_PROPERTY_TYPE_PREPROCESS(Left.split12);
                                                                                    Self.split13:=CollateralAnalytics.PreFuzzyFunctions.MLS_PROPERTY_TYPE_PREPROCESS(Left.split13);
                                                                                    Self.split14:=CollateralAnalytics.PreFuzzyFunctions.MLS_PROPERTY_TYPE_PREPROCESS(Left.split14);
                                                                                    Self.split15:=CollateralAnalytics.PreFuzzyFunctions.MLS_PROPERTY_TYPE_PREPROCESS(Left.split15);
                                                                                    self:=left;));
//second preprocess step for parking and garage

PreProcessRec tCombineRound1(PreProcessRec L):=TRANSFORM
    Self.Processed:=STD.STR.ToUpperCase(L.split1
                    +if(L.split2='','',if(L.split1='',L.split2,','+L.split2))
                    +if(L.split3='','',','+L.split3)
                    +if(L.split4='','',','+L.split4)
                    +if(L.split5='','',','+L.split5)
                    +if(L.split6='','',','+L.split6)
                    +if(L.split7='','',','+L.split7)
                    +if(L.split8='','',','+L.split8)
                    +if(L.split9='','',','+L.split9)
                    +if(L.split10='','',','+L.split10)
                    +if(L.split11='','',','+L.split11)
                    +if(L.split12='','',','+L.split12)
                    +if(L.split13='','',','+L.split13)
                    +if(L.split14='','',','+L.split14)
                    +if(L.split15='','',','+L.split15));
    self:=L;
END;

MLS_AC_TYPE_Combined_Input_Round1               :=project(MLS_AC_TYPE_Input,tCombineRound1(left));
MLS_PARKING_TYPE_Combined_Input_Round1          :=project(MLS_PARKING_TYPE_Input_Round1,tCombineRound1(left));
MLS_GARAGE_Combined_Input_Round1                :=project(MLS_GARAGE_Input_Round1,tCombineRound1(left));
MLS_ROOF_COVER_Combined_Input_Round1            :=project(MLS_ROOF_COVER_Input,tCombineRound1(left));
MLS_HEATING_Combined_Input_Round1               :=project(MLS_HEATING_Input,tCombineRound1(left));
MLS_FLOOR_TYPE_Combined_Input_Round1            :=project(MLS_FLOOR_TYPE_Input,tCombineRound1(left));
MLS_POOL_TYPE_Combined_Input_Round1             :=project(MLS_POOL_TYPE_Input,tCombineRound1(left));
MLS_PROP_STYLE_Combined_Input_Round1            :=project(MLS_PROP_STYLE_Input,tCombineRound1(left));
MLS_FIREPLACE_TYPE_Combined_Input_Round1        :=project(MLS_FIREPLACE_TYPE_Input,tCombineRound1(left));
MLS_CONSTRUCTION_TYPE_Combined_Input_Round1     :=project(MLS_CONSTRUCTION_TYPE_Input,tCombineRound1(left));
MLS_FOUNDATION_Combined_Input_Round1            :=project(MLS_FOUNDATION_Input,tCombineRound1(left));
MLS_SEWER_Combined_Input_Round1                 :=project(MLS_SEWER_Input,tCombineRound1(left));
MLS_PROPERTY_CONDITION_Combined_Input_Round1    :=project(MLS_PROPERTY_CONDITION_Input,tCombineRound1(left));
MLS_PROPERTY_TYPE_Combined_Input_Round1         :=project(MLS_PROPERTY_TYPE_Input,tCombineRound1(left));

MLS_PARKING_TYPE_Second_Step:=project(MLS_PARKING_TYPE_Combined_Input_Round1,transform(PreProcessRec,
                        Self.ProcessedRound2:=CollateralAnalytics.PreFuzzyFunctions.MLS_PARKING_TYPE_PREPROCESS_Round2(STD.STR.touppercase(Left.processed));
                        self:=left;));

MLS_GARAGE_Second_Step:=project(MLS_GARAGE_Combined_Input_Round1,transform(PreProcessRec,
                        Self.ProcessedRound2:=CollateralAnalytics.PreFuzzyFunctions.MLS_GARAGE_PREPROCESS_Round2(STD.STR.touppercase(Left.processed));
                        self:=left;));

PreProcessRec tCombineRound2(PreProcessRec L):=TRANSFORM
    Self.ProcessedRound2:=if(L.ProcessedRound2='',L.processed,L.ProcessedRound2);
    self:=L;
END;

MLS_AC_TYPE_Combined_Input_Round2               :=project(MLS_AC_TYPE_combined_input_Round1,tCombineRound2(left));
MLS_PARKING_TYPE_Combined_Input_Round2          :=project(MLS_PARKING_TYPE_Second_Step,tCombineRound2(left));
MLS_GARAGE_Combined_Input_Round2                :=project(MLS_GARAGE_Second_Step,tCombineRound2(left));
MLS_ROOF_COVER_Combined_Input_Round2            :=project(MLS_ROOF_COVER_combined_input_Round1,tCombineRound2(left));
MLS_HEATING_Combined_Input_Round2               :=project(MLS_HEATING_combined_input_Round1,tCombineRound2(left));
MLS_FLOOR_TYPE_Combined_Input_Round2            :=project(MLS_FLOOR_TYPE_combined_input_Round1,tCombineRound2(left));
MLS_POOL_TYPE_Combined_Input_Round2             :=project(MLS_POOL_TYPE_combined_input_Round1,tCombineRound2(left));
MLS_PROP_STYLE_Combined_Input_Round2            :=project(MLS_PROP_STYLE_combined_input_Round1,tCombineRound2(left));
MLS_FIREPLACE_TYPE_Combined_Input_Round2        :=project(MLS_FIREPLACE_TYPE_combined_input_Round1,tCombineRound2(left));
MLS_CONSTRUCTION_TYPE_Combined_Input_Round2     :=project(MLS_CONSTRUCTION_TYPE_combined_input_Round1,tCombineRound2(left));
MLS_FOUNDATION_Combined_Input_Round2            :=project(MLS_FOUNDATION_combined_input_Round1,tCombineRound2(left));
MLS_SEWER_Combined_Input_Round2                 :=project(MLS_SEWER_combined_input_Round1,tCombineRound2(left));
MLS_PROPERTY_CONDITION_Combined_Input_Round2    :=project(MLS_PROPERTY_CONDITION_combined_input_Round1,tCombineRound2(left));
MLS_PROPERTY_TYPE_Combined_Input_Round2         :=project(MLS_PROPERTY_TYPE_combined_input_Round1,tCombineRound2(left));

java_out := RECORD
  String mls_prepared_field;
  String mls_fuzzy_match;
  real8 mls_ratio;
  String mls_match_source;
	 
	END;
//Fuzzy Calls
java_in := RECORD
	String mls_prepared_field;
	END;
MLS_AC_TYPE_Java_Input               :=project(MLS_AC_TYPE_combined_input_Round2,transform(java_in,Self.mls_prepared_field:=Left.ProcessedRound2;));
MLS_PARKING_TYPE_Java_Input          :=project(MLS_PARKING_TYPE_combined_input_Round2,transform(java_in,Self.mls_prepared_field:=Left.ProcessedRound2;));
MLS_GARAGE_Java_Input                :=project(MLS_GARAGE_combined_input_Round2,transform(java_in,Self.mls_prepared_field:=Left.ProcessedRound2;));
MLS_ROOF_COVER_Java_Input            :=project(MLS_ROOF_COVER_combined_input_Round2,transform(java_in,Self.mls_prepared_field:=Left.ProcessedRound2;));
MLS_HEATING_Java_Input               :=project(MLS_HEATING_combined_input_Round2,transform(java_in,Self.mls_prepared_field:=Left.ProcessedRound2;));
MLS_FLOOR_TYPE_Java_Input            :=project(MLS_FLOOR_TYPE_combined_input_Round2,transform(java_in,Self.mls_prepared_field:=Left.ProcessedRound2;));
MLS_POOL_TYPE_Java_Input             :=project(MLS_POOL_TYPE_combined_input_Round2,transform(java_in,Self.mls_prepared_field:=Left.ProcessedRound2;));
MLS_PROP_STYLE_Java_Input            :=project(MLS_PROP_STYLE_combined_input_Round2,transform(java_in,Self.mls_prepared_field:=Left.ProcessedRound2;));
MLS_FIREPLACE_TYPE_Java_Input        :=project(MLS_FIREPLACE_TYPE_combined_input_Round2,transform(java_in,Self.mls_prepared_field:=Left.ProcessedRound2;));
MLS_CONSTRUCTION_TYPE_Java_Input     :=project(MLS_CONSTRUCTION_TYPE_combined_input_Round2,transform(java_in,Self.mls_prepared_field:=Left.ProcessedRound2;));
MLS_FOUNDATION_Java_Input            :=project(MLS_FOUNDATION_combined_input_Round2,transform(java_in,Self.mls_prepared_field:=Left.ProcessedRound2;));
MLS_SEWER_Java_Input                 :=project(MLS_SEWER_combined_input_Round2,transform(java_in,Self.mls_prepared_field:=Left.ProcessedRound2;));
MLS_PROPERTY_CONDITION_Java_Input    :=project(MLS_PROPERTY_CONDITION_combined_input_Round2,transform(java_in,Self.mls_prepared_field:=Left.ProcessedRound2;));
MLS_PROPERTY_TYPE_Java_Input         :=project(MLS_PROPERTY_TYPE_combined_input_Round2,transform(java_in,Self.mls_prepared_field:=Left.ProcessedRound2;));


transform(java_out) getFuzzyMatch2(java_in in, String FieldName, integer lim) := IMPORT(java, 'com.relx.mls.fuzzy.Result.FuzzyMatch:(Lcom/relx/mls/fuzzy/Result;Ljava/lang/String;I)Lcom/relx/mls/fuzzy/Result;');

MLS_AC_TYPE_Fuzzy               := project(MLS_AC_TYPE_Java_Input, getFuzzyMatch2(LEFT, 'AC_TYPE', COUNTER));
MLS_PARKING_TYPE_Fuzzy          := project(MLS_PARKING_TYPE_Java_Input, getFuzzyMatch2(LEFT, 'PARKING_TYPE', COUNTER));
MLS_GARAGE_Fuzzy                := project(MLS_GARAGE_Java_Input, getFuzzyMatch2(LEFT, 'GARAGE', COUNTER));
MLS_ROOF_COVER_Fuzzy            := project(MLS_ROOF_COVER_Java_Input, getFuzzyMatch2(LEFT, 'ROOF_COVER', COUNTER));
MLS_ROOF_TYPE_Fuzzy             := project(MLS_ROOF_COVER_Java_Input, getFuzzyMatch2(LEFT, 'ROOF_TYPE', COUNTER));
MLS_HEATING_Fuzzy               := project(MLS_HEATING_Java_Input, getFuzzyMatch2(LEFT, 'HEATING', COUNTER));
MLS_FLOOR_TYPE_Fuzzy            := project(MLS_FLOOR_TYPE_Java_Input, getFuzzyMatch2(LEFT, 'FLOOR_TYPE', COUNTER));
MLS_POOL_TYPE_Fuzzy             := project(MLS_POOL_TYPE_Java_Input, getFuzzyMatch2(LEFT, 'POOL_TYPE', COUNTER));
MLS_PROP_STYLE_Fuzzy            := project(MLS_PROP_STYLE_Java_Input, getFuzzyMatch2(LEFT, 'PROP_STYLE', COUNTER));
MLS_FIREPLACE_TYPE_Fuzzy        := project(MLS_FIREPLACE_TYPE_Java_Input, getFuzzyMatch2(LEFT, 'FIREPLACE_TYPE', COUNTER));
MLS_CONSTRUCTION_TYPE_Fuzzy     := project(MLS_CONSTRUCTION_TYPE_Java_Input, getFuzzyMatch2(LEFT, 'CONSTRUCTION_TYPE', COUNTER));
MLS_FOUNDATION_Fuzzy            := project(MLS_FOUNDATION_Java_Input, getFuzzyMatch2(LEFT, 'FOUNDATION', COUNTER));
MLS_SEWER_Fuzzy                 := project(MLS_SEWER_Java_Input, getFuzzyMatch2(LEFT, 'SEWER', COUNTER));
MLS_PROPERTY_CONDITION_Fuzzy    := project(MLS_PROPERTY_CONDITION_Java_Input, getFuzzyMatch2(LEFT, 'PROPERTY_CONDITION', COUNTER));
MLS_PROPERTY_TYPE_Fuzzy         := project(MLS_PROPERTY_TYPE_Java_Input, getFuzzyMatch2(LEFT, 'PROPERTY_TYPE', COUNTER));

//Join Everything Back Together
 ExceptionReportLayoutWithSource:=RECORD
	String 	FieldName;
	String 	Raw_Value;
	String 	Processed_Raw_Round1;
	String 	FuzzyInput;
	String 	mls_fuzzy_match;
  	real8  	mls_ratio;
  	String 	PC_MappedCode;
	String 	FinalMatchedValue;
	integer frequency;
    string 	NewFlag;
    String  mls_match_source;
END;
ExceptionReportLayoutWithSource tReJoin(PreProcessRec L, java_out R, String Field):=TRANSFORM
    SELF.FieldName:=Field;
    SELF.Raw_Value:=L.RawData;
    SELF.Processed_Raw_Round1:=L.Processed;
    SELF.FuzzyInput:=L.ProcessedRound2;
    SELF.Frequency:=L.cnt;
    SELF.MLS_Fuzzy_Match:= R.mls_fuzzy_match;
    Self.mls_ratio:=R.mls_ratio;
    self.NewFlag:='Y';
    self.mls_match_source:=std.str.ToUpperCase(R.mls_match_source);
    Self:=[];
END;

MLS_AC_TYPE_Joined               := join(distribute(MLS_AC_TYPE_Combined_Input_Round2,hash(ProcessedRound2)),
                                         distribute(MLS_AC_TYPE_Fuzzy,hash(mls_prepared_field)),                                         
                                        trim(Left.ProcessedRound2,left,right)=trim(right.mls_prepared_field,left,right),tRejoin(left,right,'MLS_AIR_CONDITIONING_TYPE'),left outer,keep(1),local);

MLS_PARKING_TYPE_Joined          := join(distribute(MLS_Parking_TYPE_Combined_Input_Round2,hash(ProcessedRound2)),
                                         distribute(MLS_Parking_TYPE_Fuzzy,hash(mls_prepared_field)),                                         
                                         trim(Left.ProcessedRound2,left,right)=trim(right.mls_prepared_field,left,right),tRejoin(left,right,'MLS_PARKING_TYPE'),left outer,keep(1),local);
MLS_GARAGE_Joined                := join(distribute(MLS_GARAGE_Combined_Input_Round2,hash(ProcessedRound2)),
                                         distribute(MLS_GARAGE_Fuzzy,hash(mls_prepared_field)),
                                         trim(Left.ProcessedRound2,left,right)=trim(right.mls_prepared_field,left,right),tRejoin(left,right,'MLS_GARAGE'),left outer,keep(1),local);
MLS_ROOF_COVER_Joined            := join(distribute(MLS_ROOF_COVER_Combined_Input_Round2,hash(ProcessedRound2)),
                                         distribute(MLS_ROOF_COVER_Fuzzy,hash(mls_prepared_field)),
                                         trim(Left.ProcessedRound2,left,right)=trim(right.mls_prepared_field,left,right),tRejoin(left,right,'MLS_ROOF_COVER'),left outer,keep(1),local);
MLS_ROOF_TYPE_Joined             := join(distribute(MLS_ROOF_COVER_Combined_Input_Round2,hash(ProcessedRound2)),
                                         distribute(MLS_ROOF_TYPE_Fuzzy,hash(mls_prepared_field)),
                                         trim(Left.ProcessedRound2,left,right)=trim(right.mls_prepared_field,left,right),tRejoin(left,right,'MLS_ROOF_TYPE'),left outer,keep(1),local);
MLS_HEATING_Joined               := join(distribute(MLS_HEATING_Combined_Input_Round2,hash(ProcessedRound2)),
                                         distribute(MLS_HEATING_Fuzzy,hash(mls_prepared_field)),
                                         trim(Left.ProcessedRound2,left,right)=trim(right.mls_prepared_field,left,right),tRejoin(left,right,'MLS_HEATING'),left outer,keep(1),local);
MLS_FLOOR_TYPE_Joined            := join(distribute(MLS_FLOOR_TYPE_Combined_Input_Round2,hash(ProcessedRound2)),
                                         distribute(MLS_FLOOR_TYPE_Fuzzy,hash(mls_prepared_field)),
                                         trim(Left.ProcessedRound2,left,right)=trim(right.mls_prepared_field,left,right),tRejoin(left,right,'MLS_FLOOR_TYPE'),left outer,keep(1),local);
MLS_POOL_TYPE_Joined             := join(distribute(MLS_POOL_TYPE_Combined_Input_Round2,hash(ProcessedRound2)),
                                         distribute(MLS_POOL_TYPE_Fuzzy,hash(mls_prepared_field)),
                                         trim(Left.ProcessedRound2,left,right)=trim(right.mls_prepared_field,left,right),tRejoin(left,right,'MLS_POOL_TYPE'),left outer,keep(1),local);
MLS_PROP_STYLE_Joined            := join(distribute(MLS_PROP_STYLE_Combined_Input_Round2,hash(ProcessedRound2)),
                                         distribute(MLS_PROP_STYLE_Fuzzy,hash(mls_prepared_field)),
                                         trim(Left.ProcessedRound2,left,right)=trim(right.mls_prepared_field,left,right),tRejoin(left,right,'MLS_PROP_STYLE'),left outer,keep(1),local);
MLS_FIREPLACE_TYPE_Joined        := join(distribute(MLS_FIREPLACE_TYPE_Combined_Input_Round2,hash(ProcessedRound2)),
                                         distribute(MLS_FIREPLACE_TYPE_Fuzzy,hash(mls_prepared_field)),
                                         
                                         trim(Left.ProcessedRound2,left,right)=trim(right.mls_prepared_field,left,right),tRejoin(left,right,'MLS_FIREPLACE_TYPE'),left outer,keep(1),local);
MLS_CONSTRUCTION_TYPE_Joined     := join(distribute(MLS_CONSTRUCTION_TYPE_Combined_Input_Round2,hash(ProcessedRound2)),
                                         distribute(MLS_CONSTRUCTION_TYPE_Fuzzy,hash(mls_prepared_field)),
                                         trim(Left.ProcessedRound2,left,right)=trim(right.mls_prepared_field,left,right),tRejoin(left,right,'MLS_CONSTRUCTION_TYPE'),left outer,keep(1),local);
MLS_FOUNDATION_Joined            := join(distribute(MLS_FOUNDATION_Combined_Input_Round2,hash(ProcessedRound2)),
                                         distribute(MLS_FOUNDATION_Fuzzy,hash(mls_prepared_field)),
                                         trim(Left.ProcessedRound2,left,right)=trim(right.mls_prepared_field,left,right),tRejoin(left,right,'MLS_FOUNDATION'),left outer,keep(1),local);
MLS_SEWER_Joined                 := join(distribute(MLS_SEWER_Combined_Input_Round2,hash(ProcessedRound2)),
                                         distribute(MLS_SEWER_Fuzzy,hash(mls_prepared_field)),
                                         trim(Left.ProcessedRound2,left,right)=trim(right.mls_prepared_field,left,right),tRejoin(left,right,'MLS_SEWER'),left outer,keep(1),local);
MLS_PROPERTY_CONDITION_Joined    := join(distribute(MLS_PROPERTY_CONDITION_Combined_Input_Round2,hash(ProcessedRound2)),
                                         distribute(MLS_PROPERTY_CONDITION_Fuzzy,hash(mls_prepared_field)),
                                         trim(Left.ProcessedRound2,left,right)=trim(right.mls_prepared_field,left,right),tRejoin(left,right,'MLS_PROPERTY_CONDITION'),left outer,keep(1),local);
MLS_PROPERTY_TYPE_Joined         := join(distribute(MLS_PROPERTY_TYPE_Combined_Input_Round2,hash(ProcessedRound2)),
                                         distribute(MLS_PROPERTY_TYPE_Fuzzy,hash(mls_prepared_field)),
                                         trim(Left.ProcessedRound2,left,right)=trim(right.mls_prepared_field,left,right),tRejoin(left,right,'MLS_PROPERTY_TYPE'),left outer,keep(1),local);

//Mapping

CollateralAnalytics.layouts.ExceptionReportLayout tMapping(ExceptionReportLayoutWithSource L,CollateralAnalytics.layouts.dictionaryRec R):= TRANSFORM
    Self.PC_MappedCode:=R.CODE;
    Self:=L;
END;

MLS_AC_TYPE_Mapped               := join(distribute(MLS_AC_TYPE_Joined,hash(mls_match_source,mls_fuzzy_match)),
                                        CollateralAnalytics.PCDictionaries.AC_Type,
                                         left.mls_match_source=right.match_source and left.mls_fuzzy_match=right.Desc,tMapping(left,right),left outer,lookup);
MLS_PARKING_TYPE_Mapped          := join(distribute(MLS_Parking_TYPE_Joined,hash(mls_match_source,mls_fuzzy_match)),
                                         CollateralAnalytics.PCDictionaries.Parking_Type,
                                         left.mls_match_source=right.match_source and left.mls_fuzzy_match=right.Desc,tMapping(left,right),left outer,lookup);
MLS_GARAGE_Mapped                := join(distribute(MLS_GARAGE_Joined,hash(mls_match_source,mls_fuzzy_match)),
                                         CollateralAnalytics.PCDictionaries.Garage_Type,
                                         left.mls_match_source=right.match_source and left.mls_fuzzy_match=right.Desc,tMapping(left,right),left outer,lookup);
MLS_ROOF_COVER_Mapped            := join(distribute(MLS_ROOF_COVER_Joined,hash(mls_match_source,mls_fuzzy_match)),
                                         CollateralAnalytics.PCDictionaries.Roof_Cover,
                                         left.mls_match_source=right.match_source and left.mls_fuzzy_match=right.Desc,tMapping(left,right),left outer,lookup);
MLS_ROOF_TYPE_Mapped             := join(distribute(MLS_ROOF_TYPE_Joined,hash(mls_match_source,mls_fuzzy_match)),
                                         CollateralAnalytics.PCDictionaries.Roof_Type,
                                         left.mls_match_source=right.match_source and left.mls_fuzzy_match=right.Desc,tMapping(left,right),left outer,lookup);
MLS_HEATING_Mapped               := join(distribute(MLS_HEATING_Joined,hash(mls_match_source,mls_fuzzy_match)),
                                         CollateralAnalytics.PCDictionaries.Heating_Type,
                                         left.mls_match_source=right.match_source and left.mls_fuzzy_match=right.Desc,tMapping(left,right),left outer,lookup);
MLS_FLOOR_TYPE_Mapped            := join(distribute(MLS_FLOOR_TYPE_Joined,hash(mls_match_source,mls_fuzzy_match)),
                                         CollateralAnalytics.PCDictionaries.Floor_Type,
                                         left.mls_match_source=right.match_source and left.mls_fuzzy_match=right.Desc,tMapping(left,right),left outer,lookup);
MLS_POOL_TYPE_Mapped             := join(distribute(MLS_POOL_TYPE_Joined,hash(mls_match_source,mls_fuzzy_match)),
                                         CollateralAnalytics.PCDictionaries.Pool_Type,
                                         left.mls_match_source=right.match_source and left.mls_fuzzy_match=right.Desc,tMapping(left,right),left outer,lookup);
MLS_PROP_STYLE_Mapped            := join(distribute(MLS_PROP_STYLE_Joined,hash(mls_match_source,mls_fuzzy_match)),
                                         CollateralAnalytics.PCDictionaries.Prop_Style,
                                         left.mls_match_source=right.match_source and left.mls_fuzzy_match=right.Desc,tMapping(left,right),left outer,lookup);
MLS_FIREPLACE_TYPE_Mapped        := join(distribute(MLS_FIREPLACE_TYPE_Joined,hash(mls_match_source,mls_fuzzy_match)),
                                         CollateralAnalytics.PCDictionaries.Fireplace_Type,
                                         left.mls_match_source=right.match_source and left.mls_fuzzy_match=right.Desc,tMapping(left,right),left outer,lookup);
MLS_CONSTRUCTION_TYPE_Mapped     := join(distribute(MLS_CONSTRUCTION_TYPE_Joined,hash(mls_match_source,mls_fuzzy_match)),
                                         CollateralAnalytics.PCDictionaries.Construction_Type,
                                         left.mls_match_source=right.match_source and left.mls_fuzzy_match=right.Desc,tMapping(left,right),left outer,lookup);
MLS_FOUNDATION_Mapped            := join(distribute(MLS_FOUNDATION_Joined,hash(mls_match_source,mls_fuzzy_match)),
                                         CollateralAnalytics.PCDictionaries.Foundation_Type,
                                         left.mls_match_source=right.match_source and left.mls_fuzzy_match=right.Desc,tMapping(left,right),left outer,lookup);
MLS_SEWER_Mapped                 := join(distribute(MLS_SEWER_Joined,hash(mls_match_source,mls_fuzzy_match)),
                                         CollateralAnalytics.PCDictionaries.Sewer_Type,
                                         left.mls_match_source=right.match_source and left.mls_fuzzy_match=right.Desc,tMapping(left,right),left outer,lookup);
MLS_PROPERTY_CONDITION_Mapped    := join(distribute(MLS_PROPERTY_CONDITION_Joined,hash(mls_match_source,mls_fuzzy_match)),
                                         CollateralAnalytics.PCDictionaries.Property_Condition,
                                         left.mls_match_source=right.match_source and left.mls_fuzzy_match=right.Desc,tMapping(left,right),left outer,lookup);
MLS_PROPERTY_TYPE_Mapped         := join(distribute(MLS_PROPERTY_TYPE_Joined,hash(mls_match_source,mls_fuzzy_match)),
                                         CollateralAnalytics.PCDictionaries.Property_Type,
                                         left.mls_match_source=right.match_source and left.mls_fuzzy_match=right.Desc,tMapping(left,right),left outer,lookup);

//PostFuzzyProcessing
MLS_AC_TYPE_PostProcessing               := project(MLS_AC_TYPE_Mapped,transform(CollateralAnalytics.layouts.ExceptionReportLayout,Self.FinalMatchedValue:=CollateralAnalytics.PostFuzzyFunctions.MLS_AC_TYPE_PostFuzzy(Left.PC_MappedCode,Left.mls_fuzzy_match);Self:=Left;));
MLS_PARKING_TYPE_PostProcessing          := project(MLS_PARKING_TYPE_Mapped,transform(CollateralAnalytics.layouts.ExceptionReportLayout,Self.FinalMatchedValue:=CollateralAnalytics.PostFuzzyFunctions.MLS_Parking_TYPE_PostFuzzy(Left.PC_MappedCode,Left.mls_fuzzy_match,Left.FuzzyInput,'DESC');
                                                                                                                                   Self.PC_MappedCode:=CollateralAnalytics.PostFuzzyFunctions.MLS_Parking_TYPE_PostFuzzy(Left.PC_MappedCode,Left.mls_fuzzy_match,Left.FuzzyInput,'CODE');Self:=Left;));
MLS_GARAGE_PostProcessing                := project(MLS_GARAGE_Mapped,transform(CollateralAnalytics.layouts.ExceptionReportLayout,Self.FinalMatchedValue:=CollateralAnalytics.PostFuzzyFunctions.MLS_Garage_PostFuzzy(Left.PC_MappedCode,Left.mls_fuzzy_match,Left.FuzzyInput,'DESC');
                                                                                                                                   Self.PC_MappedCode:=CollateralAnalytics.PostFuzzyFunctions.MLS_Garage_PostFuzzy(Left.PC_MappedCode,Left.mls_fuzzy_match,Left.FuzzyInput,'CODE');Self:=Left;));
MLS_ROOF_COVER_PostProcessing            := project(MLS_ROOF_COVER_Mapped,transform(CollateralAnalytics.layouts.ExceptionReportLayout,Self.FinalMatchedValue:=CollateralAnalytics.PostFuzzyFunctions.MLS_Roof_Cover_PostFuzzy(Left.PC_MappedCode,Left.mls_fuzzy_match);Self:=Left;));
MLS_ROOF_TYPE_PostProcessing             := project(MLS_ROOF_TYPE_Mapped,transform(CollateralAnalytics.layouts.ExceptionReportLayout,Self.FinalMatchedValue:=left.mls_fuzzy_match;self:=left;));
MLS_HEATING_PostProcessing               := project(MLS_HEATING_Mapped,transform(CollateralAnalytics.layouts.ExceptionReportLayout,Self.FinalMatchedValue:=left.mls_fuzzy_match;self:=left;));
MLS_FLOOR_TYPE_PostProcessing            := project(MLS_FLOOR_TYPE_Mapped,transform(CollateralAnalytics.layouts.ExceptionReportLayout,Self.FinalMatchedValue:=left.mls_fuzzy_match;self:=left;));
MLS_POOL_TYPE_PostProcessing             := project(MLS_POOL_TYPE_MAPPED,transform(CollateralAnalytics.layouts.ExceptionReportLayout,Self.FinalMatchedValue:=CollateralAnalytics.PostFuzzyFunctions.MLS_Pool_Type_PostFuzzy(Left.PC_MappedCode,Left.mls_fuzzy_match);Self:=Left;));
MLS_PROP_STYLE_PostProcessing            := project(MLS_PROP_STYLE_MAPPED,transform(CollateralAnalytics.layouts.ExceptionReportLayout,Self.FinalMatchedValue:=CollateralAnalytics.PostFuzzyFunctions.MLS_Prop_Style_PostFuzzy(Left.PC_MappedCode,Left.mls_fuzzy_match);Self:=Left;));
MLS_FIREPLACE_TYPE_PostProcessing        := project(MLS_FIREPLACE_TYPE_MAPPED,transform(CollateralAnalytics.layouts.ExceptionReportLayout,Self.FinalMatchedValue:=CollateralAnalytics.PostFuzzyFunctions.MLS_Fireplace_PostFuzzy(Left.PC_MappedCode,Left.mls_fuzzy_match);Self:=Left;));
MLS_CONSTRUCTION_TYPE_PostProcessing     := project(MLS_CONSTRUCTION_TYPE_MAPPED,transform(CollateralAnalytics.layouts.ExceptionReportLayout,Self.FinalMatchedValue:=CollateralAnalytics.PostFuzzyFunctions.MLS_Construction_PostFuzzy(Left.PC_MappedCode,Left.mls_fuzzy_match);Self:=Left;));
MLS_FOUNDATION_PostProcessing            := project(MLS_FOUNDATION_MAPPED,transform(CollateralAnalytics.layouts.ExceptionReportLayout,Self.FinalMatchedValue:=CollateralAnalytics.PostFuzzyFunctions.MLS_Foundation_PostFuzzy(Left.PC_MappedCode,Left.mls_fuzzy_match);Self:=Left;));
MLS_SEWER_PostProcessing                 := project(MLS_SEWER_MAPPED,transform(CollateralAnalytics.layouts.ExceptionReportLayout,Self.FinalMatchedValue:=CollateralAnalytics.PostFuzzyFunctions.MLS_Sewer_PostFuzzy(Left.PC_MappedCode,Left.mls_fuzzy_match);Self:=Left;));
MLS_PROPERTY_CONDITION_PostProcessing    := project(MLS_PROPERTY_CONDITION_MAPPED,transform(CollateralAnalytics.layouts.ExceptionReportLayout,Self.FinalMatchedValue:=CollateralAnalytics.PostFuzzyFunctions.MLS_Property_Condition_PostFuzzy(Left.PC_MappedCode,Left.mls_fuzzy_match);Self:=Left;));
MLS_PROPERTY_TYPE_PostProcessing         := project(MLS_PROPERTY_TYPE_MAPPED,transform(CollateralAnalytics.layouts.ExceptionReportLayout,Self.FinalMatchedValue:=CollateralAnalytics.PostFuzzyFunctions.MLS_Property_Type_PostFuzzy(Left.PC_MappedCode,Left.mls_fuzzy_match);Self:=Left;));
//Send Report

CombinedReport:=
MLS_AC_TYPE_PostProcessing               +
MLS_PARKING_TYPE_PostProcessing          +                                         
MLS_GARAGE_PostProcessing                +                                           
MLS_ROOF_COVER_PostProcessing            +
MLS_ROOF_TYPE_PostProcessing             +
MLS_HEATING_PostProcessing               +
MLS_FLOOR_TYPE_PostProcessing            +
MLS_POOL_TYPE_PostProcessing             +
MLS_PROP_STYLE_PostProcessing            +
MLS_FIREPLACE_TYPE_PostProcessing        +
MLS_CONSTRUCTION_TYPE_PostProcessing     +
MLS_FOUNDATION_PostProcessing            +
MLS_SEWER_PostProcessing                 +
MLS_PROPERTY_CONDITION_PostProcessing    +
MLS_PROPERTY_TYPE_PostProcessing         ;
//remove exception list and mark old
RemoveExceptions:=join(CombinedReport,CollateralAnalytics.file_ExceptionList,
                       left.FieldName=right.FieldName and
                       left.Raw_Value=right.Raw_Value,
                       transform(left),left only, lookup);
CollateralAnalytics.layouts.ExceptionReportLayout tMarkOld(CollateralAnalytics.layouts.ExceptionReportLayout L,CollateralAnalytics.layouts.ExceptionReportLayout R):= TRANSFORM
    Self.NewFlag:='N';
    Self:=L;
END;
MarkOld:=join(RemoveExceptions,CollateralAnalytics.file_FuzzyMatch,
                       left.FieldName=right.FieldName and
                       left.Raw_Value=right.Raw_Value,
                       tMarkOld(left,right),left outer);

return MarkOld;

end;