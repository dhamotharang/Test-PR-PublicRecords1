export File_Joined := function


   //Input files have been joined based on primary-foreign key columns 
ECRulings.Layouts.competition_DecisionPublication trans_comp_DeciPub(ECRulings.Layouts.competition l,ECRulings.Layouts.DecisionPublication r):=transform 
   self:=l;
   self:=r;
   end;
   
joinCompetition_DecisionPublication:=join(sort(distribute(ECRulings.Files().RawIN_Competition ,(integer)trim(euid,left,right)),euid,local),
										  sort(distribute(ECRulings.Files().RawIN_DecisionPublication,(integer)trim(euid,left,right)),euid,local),
                                          trim(left.euid,left,right)=trim(right.euid,left,right),
										  trans_comp_DeciPub(left,right),
   										  left outer,local );

   
 ECRulings.Layouts.comp_DeciPub_EconomicAct trans_comp_DeciPub_EconomicAct(ECRulings.Layouts.competition_DecisionPublication l,ECRulings.Layouts.EconomicActivity r):=transform 
   self:=l;
   self:=r;
   end;
   
   joinComp_DeciPub_EconomicAct:=join(sort(distribute(joinCompetition_DecisionPublication,(integer)trim(euid,left,right)),euid,local),
									  sort(distribute(ECRulings.Files().RawIN_EconomicActivity,(integer)trim(euid,left,right)),euid,local),
                                      trim(left.euid,left,right)=trim(right.euid,left,right),
									  trans_comp_DeciPub_EconomicAct(left,right),
   									  left outer,local );

   
ECRulings.Layouts.comp_DeciPub_EconomicAct_Eventdoc trans_comp_DeciPub_EconomicAct_Eventdoc(ECRulings.Layouts.comp_DeciPub_EconomicAct l,ECRulings.Layouts.Eventdocument r):=transform 
   self:=l;
   self:=r;
   self:=[];
   end;	
   
 joinComp_DeciPub_EconomicAct_Eventdoc:=join(sort(distribute(joinComp_DeciPub_EconomicAct,(integer)trim(euid,left,right)),euid,local),
                                             sort(distribute(ECRulings.Files().RawIN_EventDocument,(integer)trim(euid,left,right)),euid,local),
                                             trim(left.euid,left,right)=trim(right.euid,left,right),
											 trans_comp_DeciPub_EconomicAct_Eventdoc(left,right),
   										     left outer,local ):persist('~thor_data400::ECRulings::raw_Joined_file');
return 	joinComp_DeciPub_EconomicAct_Eventdoc;

end;									  