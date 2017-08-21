import corp2;

//*************************FileComfichexRaw:************************************
							
//	Transforms the Comfichex raw file that comes in as a variable set 
//	of physical records that represents one logical record into 
//	one physical record that is in a fixed string format.
//
//	Data comes in 3 pages !each page contains 1-53 lines,
//	among  53 lines[ 1-5 lines ]contain bad data & 53rd has blank
//	record.  We need to process data content from 6th to 52 lines
//	from each page 
//
//	NOTE: The raw data consists of the following types of records:
//	1) A header record that is a "DATE" record
//	e.g.DATE XX/XX/XX
//	2) One to many variable formatted data records that is
//	separated logically by 133 'blank' characters.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      

//****************************************************************************
export FileComfichexRaw(dataset(Corp2_Raw_WI.Layouts.ReportLineLayoutIn) pInComfichex) := function

		Corp2_Raw_WI.Layouts.TempComfichexRawLayout AddSequenceTransform(Corp2_Raw_WI.Layouts.reportLineLayoutIn l, integer c) := transform
		
			self.seqno   					:= c;
			self.groupno 					:= 0;
			self.recno 						:= 0;
			self.ctr							:= 0;
			self 									:= l;
			self									:= [];
			
		end;

		ComfichexExtended				:= project(pInComfichex, AddSequenceTransform(left, counter));			 

		//This logic attaches the same groupno for each logical record set
		Corp2_Raw_WI.Layouts.TempComfichexRawLayout AddGroupNo(Corp2_Raw_WI.Layouts.TempComfichexRawLayout l, Corp2_Raw_WI.Layouts.TempComfichexRawLayout r) := transform,
		skip(corp2.t2u(stringlib.stringfilter(corp2.t2u(r.linevary),'ABCDEFGHIJKLMNOPQRSTUVWXYZ')) = 'CORPORATIONNAMECORPNOCORPTYPEPAIDDATEINCORPCURRENTSTATUS' or //if header, skip
				 corp2.t2u(stringlib.stringfilter(corp2.t2u(r.linevary),'ABCDEFGHIJKLMNOPQRSTUVWXYZ')) = 'REGISTEREDAGENTADDRESSCITYCAPSTATEZIPANDDATE'		or					//if header, skip
				 stringLib.stringFind(corp2.t2u(r.linevary),'RECORDS ON REPORT',1)<> 0 or   //last record ,Total No of records info,skip 		                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
				 stringLib.stringFind(corp2.t2u(r.linevary),'THIS RECORD IS USED BY',1)<> 0
				 )
				 
			IsNewLine    	 				:= REGEXFIND('^DATE (.*)/(.*)/(.*)', r.lineVary[1..15]) or REGEXFIND('^DATE (.*)/(.*)/(.*)', r.lineVary[2..16]) or  corp2.t2u(r.linevary)='';
			self.groupno 					:= if(IsNewLine, r.seqno, l.groupno);
			self 									:= r;
			
		end;
			
		GroupedRecords					:= iterate(ComfichexExtended,AddGroupNo(left,right));

		Corp2_Raw_WI.Layouts.TempComfichexRawLayout DenormTransform(Corp2_Raw_WI.Layouts.TempComfichexRawLayout l, Corp2_Raw_WI.Layouts.TempComfichexRawLayout r, integer c) := transform
			
			self.seqno 						:= l.seqno;
			self.groupno 					:= l.groupno;
			self.recno 						:= l.seqno - l.groupno + 1;
			self.ctr							:= c;
			self.linevary					:= l.linevary;
			self.linevary1				:= if(l.recno = 1, l.linevary,'');
			self.linevary2				:= if(l.recno = 2, l.linevary,'');
			self.linevary3				:= if(l.recno = 3, l.linevary,'');
			self.linevary4				:= if(l.recno = 4, l.linevary,'');
			self.linevary5				:= if(l.recno = 5, l.linevary,'');	
			self 									:= l;
			
		end;

		ComfichexDenorm 						:= denormalize(GroupedRecords,GroupedRecords,
																							 left.groupno = right.groupno,
																							 DenormTransform(left,right,counter)
																							);

		Corp2_Raw_WI.Layouts.TempComfichexRawLayout RollupTransform(Corp2_Raw_WI.Layouts.TempComfichexRawLayout L, Corp2_Raw_WI.Layouts.TempComfichexRawLayout R) := transform
			
			self.seqno 							:= l.seqno;
			self.groupno 						:= l.groupno;
			self.recno 							:= l.recno;
			self.linevary1					:= if(corp2.t2u(l.linevary1)  = '',r.linevary1, l.linevary1);
			self.linevary2					:= if(corp2.t2u(l.linevary2)  = '',r.linevary2, l.linevary2);
			self.linevary3					:= if(corp2.t2u(l.linevary3)  = '',r.linevary3, l.linevary3);
			self.linevary4					:= if(corp2.t2u(l.linevary4)  = '',r.linevary4, l.linevary4);
			self.linevary5					:= if(corp2.t2u(l.linevary5)  = '',r.linevary5, l.linevary5);
			self.linevary6					:= self.linevary1 + self.linevary2 + self.linevary3 + self.linevary4 + self.linevary5;
			self 										:= l;
			
		end;

		ComfichexRollUp						:= rollup(ComfichexDenorm,RollupTransform(left,right),groupno);

		return project(ComfichexRollUp,transform(Corp2_Raw_WI.Layouts.TempComfichexFixedLayoutIn,
																						 self.keyvalue				:= left.groupno;
																						 self.linevary 		 		:= left.linevary6[134..];
																					  )
									);


end;