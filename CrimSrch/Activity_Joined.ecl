import CrimSrch, Crim_Common;

Layout_Moxie_Activity tDOCtoCrimSrchActivity(Crim_Common.Layout_In_Court_Activity pInput)
 :=
  transform
	self.date_first_reported	:= pInput.process_date; 
	self.date_last_reported		:= pInput.process_date; 
	self.conviction_override_date		:= if((integer4)pInput.event_date=0,
													 pInput.process_date,
												 	 pInput.event_date);
	
	self.conviction_override_date_type	:= if(self.conviction_override_date = '','','E');
										
	self := pInput;
  end
 ;

lActivityProcessed := project(Crim_Common.File_In_Court_Activity,tDOCtoCrimSrchActivity(left));

#if(CrimSrch.Switch_ShouldUsePersists = CrimSrch.Switch_YesValue)
export Activity_Joined
 :=	lActivityProcessed
 :	persist('persist::CrimSrch_Activity_Joined')
 ;
#else
export Activity_Joined 
 :=	lActivityProcessed
 ;
#end