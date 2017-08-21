
dInMonroe := Files_raw.Monroe.File_in_raw;


Layouts_Monroe.raw replacenull(dInMonroe l) := transform
 self.iRecordID                := regexreplace( 'NULL',   trim(l.iRecordID      ),'');       
self.sDocumentNO              := regexreplace( 'NULL',   trim(l.sDocumentNO    ),'');       
self.FiledDate                := regexreplace( 'NULL',   trim(l.FiledDate      ),'');       
self.FiledTime                := regexreplace( 'NULL',   trim(l.FiledTime      ),'');       
self.sBookType                := regexreplace( 'NULL',   trim(l.sBookType      ),'');       
self.sBookNo                  := regexreplace( 'NULL',   trim(l.sBookNo        ),'');       
self.sPageNo                  := regexreplace( 'NULL',   trim(l.sPageNo        ),'');       
self.InstrumentDate           := regexreplace( 'NULL',   trim(l.InstrumentDate ),'');       
self.sInstrumentType          := regexreplace( 'NULL',   trim(l.sInstrumentType),'');       
self.mnyConsideration         := regexreplace( 'NULL',   trim(l.mnyConsideration),'');      
self.GenComment               := regexreplace( 'NULL',   trim(l.GenComment     ),'');       
self.sMarketSource            := regexreplace( 'NULL',   trim(l.sMarketSource  ),'');       
self.sCaseNo                  := regexreplace( 'NULL',   trim(l.sCaseNo        ),'');       
self.sUCCNo                   := regexreplace( 'NULL',   trim(l.sUCCNo         ),'');       
self.sFilmNo                  := regexreplace( 'NULL',   trim(l.sFilmNo        ),'');       
self.sLoanNumber              := regexreplace( 'NULL',   trim(l.sLoanNumber    ),'');       
self.iImageID                 := regexreplace( 'NULL',   trim(l.iImageID       ),'');       
self.tiPartyType              := regexreplace( 'NULL',   trim(l.tiPartyType    ),'');       
self.sNameLast                := regexreplace( 'NULL',   trim(l.sNameLast      ),'');       
self.sNameFirst               := regexreplace( 'NULL',   trim(l.sNameFirst     ),'');       
self.sNameMiddle              := regexreplace( 'NULL',   trim(l.sNameMiddle    ),'');       
self.sNameExt                 := regexreplace( 'NULL',   trim(l.sNameExt       ),'');       
self.sAddress1                := regexreplace( 'NULL',   trim(l.sAddress1      ),'');       
self.sAddress2                := regexreplace( 'NULL',   trim(l.sAddress2      ),'');       
self.sAddress3                := regexreplace( 'NULL',   trim(l.sAddress3      ),'');       
self.sCity                    := regexreplace( 'NULL',   trim(l.sCity          ),'');       
self.sState                   := regexreplace( 'NULL',   trim(l.sState         ),'');       
self.sZip                     := regexreplace( 'NULL',   trim(l.sZip           ),'');       
self.tiAddressType            := regexreplace( 'NULL',   trim(l.tiAddressType  ),'');       
self.sLabel                   := regexreplace( 'NULL',   trim(l.sLabel         ),'');       
   
 self.mnyAmount              := regexreplace( 'NULL',trim(l.mnyAmount),'');        
self.sAddition              := regexreplace( 'NULL',trim(l.sAddition),'');        
self.sSubdivision           := regexreplace( 'NULL',trim(l.sSubdivision),'');     
self.PlatBookType           := regexreplace( 'NULL',trim(l.PlatBookType),'');     
self.PlatBookNo             := regexreplace( 'NULL',trim(l.PlatBookNo),'');       
self.PlatPageNo             := regexreplace( 'NULL',trim(l.PlatPageNo),'');       
self.sAbstractNo            := regexreplace( 'NULL',trim(l.sAbstractNo),'');      
self.sAbstractName          := regexreplace( 'NULL',trim(l.sAbstractName),'');    
self.sPID                   := regexreplace( 'NULL',trim(l.sPID),'');             
self.sSection               := regexreplace( 'NULL',trim(l.sSection),'');         
self.LandComment            := regexreplace( 'NULL',trim(l.LandComment),'');      
self.sTownship              := regexreplace( 'NULL',trim(l.sTownship),'');        
self.sRange                 := regexreplace( 'NULL',trim(l.sRange),'');           
self.sPreviousArb           := regexreplace( 'NULL',trim(l.sPreviousArb),'');     
self.sParcel                := regexreplace( 'NULL',trim(l.sParcel),'');          
self.sPreviousParcel        := regexreplace( 'NULL',trim(l.sPreviousParcel),'');  
self.sAcreageAmt            := regexreplace( 'NULL',trim(l.sAcreageAmt),'');      
self.sBlock                 := regexreplace( 'NULL',trim(l.sBlock),'');           
self.sLotList               := regexreplace( 'NULL',trim(l.sLotList),'');         
self.sUnitList              := regexreplace( 'NULL',trim(l.sUnitList),'');        
self.sArbList               := regexreplace( 'NULL',trim(l.sArbList),'');         
self.tiRangeType            := regexreplace( 'NULL',trim(l.tiRangeType),'');      
self.sRangeMin              := regexreplace( 'NULL',trim(l.sRangeMin),'');        
self.sRangeMax              := regexreplace( 'NULL',trim(l.sRangeMax),'');        
self.sRDocumentNo           := regexreplace( 'NULL',trim(l.sRDocumentNo),'');     
self.sRBookType             := regexreplace( 'NULL',trim(l.sRBookType),'');       
self.sRBookNo               := regexreplace( 'NULL',trim(l.sRBookNo),'');         
self.sRPageNo               := regexreplace( 'NULL',trim(l.sRPageNo),'');         
self.sRInstrumentType       := regexreplace( 'NULL',trim(l.sRInstrumentType),''); 
self.sDocumentNoSort        := regexreplace( 'NULL',trim(l.sDocumentNoSort),'');  
self.sBookSortNo            := regexreplace( 'NULL',trim(l.sBookSortNo),'');      
self.sPageSortNo            := regexreplace( 'NULL',trim(l.sPageSortNo),'');      

end;
  
  
export File_In_FL_Monroe := project(dInMonroe,replacenull(LEFT));


