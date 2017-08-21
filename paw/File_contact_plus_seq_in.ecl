import business_header;

business_header.Layout_Business_Contact_Sequenced 	AddSequenceNbr(business_header.Layout_Business_Contact_Plus l, unsigned c)	:=	transform
				self.seqNum    		:= c;
				self.ssn					:= if(business_header.IsValidSsn(l.ssn)	,l.ssn	,0							);
				self 							:= l;
			end;

export File_contact_plus_seq_in := project(sort(File_contact_plus_in,RECORD), AddSequenceNbr(left,counter));