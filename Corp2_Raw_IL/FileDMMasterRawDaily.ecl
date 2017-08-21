import corp2;

//****************************************************************************
//FileDMMasterRawDaily:
//							
//							Transforms the daily Master file that comes in as a variable set 
//						  of physical records that represents one logical record into 
//							one physical record that is in a fixed string format.
//
//							NOTE: The raw data consists of the following types of records:
//										1) A header record that is a "DATE" record
//											 e.g.DATE =   CCYYMMDD
//										2) One to many variable formatted data records that is
//											 separated logically by 80 '$' characters.  
//										3) A footer record that is a "COUNT" record that contains
//											 the total number of records in the file.
//											 e.g.COUNT =   NNNNNN                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
//
//							NOTE: The record following the "separater" record contains the
//										record type.  The record type is found in the first position  
//										and can be one of the following values:
//										1 - Master Record
//										2 - Master Record
//										3 - Master Record
//										4 - Stock Record
//										5 - Assumed Name Record
//****************************************************************************

export FileDMMasterRawDaily(dataset(Corp2_Raw_IL.Layouts.StringLayoutIn) pInMaster) := function

		Corp2_Raw_IL.Layouts.TempMasterRawLayout addSequenceTransform(Corp2_Raw_IL.Layouts.StringLayoutIn l, integer c) := transform
			self.seqno   					:= c;
			self.groupno 					:= 0;
			self.recno 						:= 0;
			self.ctr							:= 0;
			self 									:= l;
			self									:= [];
		end;

		MasterExtended		:= project(pInMaster, addSequenceTransform(left, counter));

		//This logic attaches the same groupno for each logical record set
		Corp2_Raw_IL.Layouts.TempMasterRawLayout addGroupNo(Corp2_Raw_IL.Layouts.TempMasterRawLayout l, Corp2_Raw_IL.Layouts.TempMasterRawLayout r) := transform
			IsNewLine    	 				:= trim(r.payload)[1..6] = 'DATE =' or trim(r.payload)[1..10] = '$$$$$$$$$$';
			self.groupno 					:= if(IsNewLine, r.seqno, l.groupno);
			self 									:= r;
		end;
			
		GroupedRecords					:= iterate(MasterExtended,addGroupNo(left,right));

		Corp2_Raw_IL.Layouts.TempMasterRawLayout denormTransform(Corp2_Raw_IL.Layouts.TempMasterRawLayout l, Corp2_Raw_IL.Layouts.TempMasterRawLayout r, integer c) := transform
			self.seqno 						:= l.seqno;
			self.groupno 					:= l.groupno;
			self.recno 						:= l.seqno - l.groupno + 1;
			self.ctr							:= c;
			self.payload					:= l.payload;
			self.payload1					:= if(l.recno = 1, l.payload,'');
			self.payload2					:= if(l.recno = 2, l.payload,'');
			self.payload3					:= if(l.recno = 3, l.payload,'');
			self.payload4					:= if(l.recno = 4, l.payload,'');
			self.payload5					:= if(l.recno = 5, l.payload,'');
			self.payload6					:= if(l.recno = 6, l.payload,'');
			self.payload7					:= if(l.recno = 7, l.payload,'');
			self.payload8					:= if(l.recno = 8, l.payload,'');
			self.payload9					:= if(l.recno = 9, l.payload,'');
			self.payload10				:= if(l.recno = 10,l.payload,'');
			self.payload11				:= if(l.recno = 11,l.payload,'');		
			self 									:= l;
		end;

		MasterDenorm 						:= denormalize(GroupedRecords,GroupedRecords,
																					 left.groupno = right.groupno,
																					 denormTransform(left,right,counter)
																					);
																					
		MasterSorted						:= sort(distribute(MasterDenorm,groupno),groupno,recno,local);
		
		Corp2_Raw_IL.Layouts.TempMasterRawLayout rollupTransform(Corp2_Raw_IL.Layouts.TempMasterRawLayout L, Corp2_Raw_IL.Layouts.TempMasterRawLayout R) := transform
			self.seqno 						:= l.seqno;
			self.groupno 					:= l.groupno;
			self.recno 						:= l.recno;
			self.payload1					:= if(corp2.t2u(l.payload1)  = '',r.payload1, l.payload1);
			self.payload2					:= if(corp2.t2u(l.payload2)  = '',r.payload2, l.payload2);
			self.payload3					:= if(corp2.t2u(l.payload3)  = '',r.payload3, l.payload3);
			self.payload4					:= if(corp2.t2u(l.payload4)  = '',r.payload4, l.payload4);
			self.payload5					:= if(corp2.t2u(l.payload5)  = '',r.payload5, l.payload5);
			self.payload6					:= if(corp2.t2u(l.payload6)  = '',r.payload6, l.payload6);
			self.payload7					:= if(corp2.t2u(l.payload7)  = '',r.payload7, l.payload7);
			self.payload8					:= if(corp2.t2u(l.payload8)  = '',r.payload8, l.payload8);
			self.payload9					:= if(corp2.t2u(l.payload9)  = '',r.payload9, l.payload9);
			self.payload10				:= if(corp2.t2u(l.payload10) = '',r.payload10,l.payload10);
			self.payload11				:= if(corp2.t2u(l.payload11) = '',r.payload11,l.payload11);
			self.payload12				:= self.payload1 + self.payload2  +  
															 self.payload3 + self.payload4  + 
															 self.payload5 + self.payload6  + 
															 self.payload7 + self.payload8  +
															 self.payload9 + self.payload10 +
															 self.payload11;	
			self 									:= l;
		end;

		MasterRollUp						:= rollup(MasterSorted,rollupTransform(left,right),groupno,local);

		return project(MasterRollUp,transform(Corp2_Raw_IL.Layouts.MasterFixedStringLayoutIn,
																					self.masterheader := left.payload1;
																					self.recordtype	 	:= left.payload2[1];
																					self.payload 		 	:= left.payload12[82..];
																				 )
									);

end;