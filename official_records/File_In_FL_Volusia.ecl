rNames
 :=
  record
                        string    Name{xpath('')};
                        string    Ndx{xpath('@index')};
            end
 ;
 rLegals
  := 
   record
                        string    Legal{xpath('')};
                        string    ldx{xpath('@seq')};
            end
 ;
 rMiscs
  := 
   record
                        string    Misc{xpath('')};
                        string    Mdx{xpath('@seq')};
            end
 ;
 rRelateds
  := 
   record
                        string    Rdx{xpath('@id')};
            end
 ;
r
 :=
  record
                        string                Instrument{xpath('@id')};
                        string                Date{xpath('DATE')};
                        string                Book{xpath('BOOK')};
                        string                Page{xpath('PAGE')};
                        string                Pages{xpath('PAGES')};
                        string                Type1{xpath('TYPE')};
                        string                Transfer1{xpath('TRANSFER')};
                        string                Mortgage{xpath('MORTGAGE')};
                        string                Docstamps{xpath('DOCSTAMPS')};
                        string                Intangtax{xpath('INTANGTAX')};
                        string                Recfee{xpath('RECFEE')};
                        dataset(rNames)            Names{xpath('NAMES/NAME')};
                        dataset(rLegals) Legals{xpath('LEGALS/LEGAL')};
                        dataset(rMiscs) Miscs{xpath('MISCS/MISC')};
                        dataset(rRelateds) Relateds{xpath('RELATEDS/RELATED')};



            end
 ;

 File_in_Volusia_xml :=         dataset('~thor_200::in::official_records::fl::volusia',r,xml('/VolusiaClerk/OfficialRecords/Instrument'));

dVolusiaX := distribute(File_in_Volusia_xml,HASH32(Instrument));

rNames1
 :=
  record,MAXLENGTH(99999)
         string    Instrument;
         string    Name;
         string    Ndx;
            end
 ;

rNames1	tNames1(rNames pNames, string pInstrument)
 :=
	transform
		
	    self.Name				:=	if(regexfind(x'0D0A',trim(pNames.Name,left,right)) = true,regexreplace(x'0D0A',pNames.Name,''),pNames.Name);
		self.Ndx				:=	pNames.Ndx;
		self.Instrument	:=	pInstrument;
	end
 ;

dNames1	:=	normalize(File_in_Volusia_xml,left.Names,tNames1(right,left.Instrument));
distdNames1 := distribute(dNames1,HASH32(Instrument));

rLegals1
  := 
   record,maxlength(9999)
            string    Instrument;
						string    Legal;
            string    ldx;
            end
 ;
 
 rLegals1	tLegals1(rLegals pLegals, string pInstrument)
 :=
	transform
		self.Legal				:=	if(regexfind(x'0D0A',trim(pLegals.Legal,left,right)) = true,regexreplace(x'0D0A',pLegals.Legal,''),pLegals.Legal);
		self.ldx				:=	pLegals.ldx;
		self.Instrument	:=	pInstrument;
	end
 ;

dLegals1	:=	normalize(File_in_Volusia_xml,left.Legals,tLegals1(right,left.Instrument));
distdLegals1 := distribute(dLegals1,HASH32(Instrument));

rec2 := record
string Instrument;
string Legal1;
string Legal2;
string Legal3;
string Legal4;
string Legal5;
end;

distdLegals2 := project( distdLegals1,transform(rec2, self := left,self := []));

rec2 tnew(distdLegals1 l) := transform
self.Legal1 := if(l.ldx = '0',l.legal,'');
self.Legal2 := if(l.ldx = '1',l.legal,'');
self.Legal3 := if(l.ldx = '2',l.legal,'');
self.Legal4 := if(l.ldx = '3',l.legal,'');
self.Legal5 := if(l.ldx = '4',l.legal,'');
self := l;
end;

pRec1 := project(distdLegals1,tnew(LEFT),local);

rec2 troll(pRec1 l,pRec1 r) := transform
self.Legal1 := if(l.Legal1 <> '',l.legal1,r.Legal1);
self.Legal2 := if(l.Legal2 <> '',l.legal2,r.Legal2);
self.Legal3 := if(l.Legal3 <> '',l.legal3,r.Legal3);
self.Legal4 := if(l.Legal4 <> '',l.legal4,r.Legal4);
self.Legal5 := if(l.Legal5 <> '',l.legal5,r.Legal5);
self := l;
end;

pRec2 := rollup(pRec1,left.Instrument=right.Instrument,troll(LEFT,RIGHT),local);

rMiscs1
  := 
   record,maxlength(9999)
                        string    Instrument;
						string    Miscs;
                        string    Mdx;
            end
 ;
 
 rMiscs1	tMiscs1(rMiscs pMiscs, string pInstrument)
 :=
	transform
		self.Miscs				:=	if(regexfind(x'0D0A',trim(pMiscs.Misc,left,right)) = true,regexreplace(x'0D0A',pMiscs.Misc,''),pMiscs.Misc);;
		self.Mdx				:=	pMiscs.Mdx;
		self.Instrument	:=	pInstrument;
	end
 ;

dMiscs1	:=	normalize(dVolusiaX,left.Miscs,tMiscs1(right,left.Instrument));

distMiscs1 := distribute(dMiscs1(Mdx = '0'),HASH32(Instrument));

rRelateds1
  := 
   record
                        string    Instrument;
						string    Rdx;
            end
 ;

rRelateds1	tRelateds1(rRelateds pRelateds, string pInstrument)
 :=
	transform
		self.Rdx				:=		if(regexfind(x'0D0A',trim(pRelateds.Rdx,left,right)) = true,regexreplace(x'0D0A',pRelateds.Rdx,''),pRelateds.Rdx);;
		self.Instrument	:=	pInstrument;
	end
 ;

dRelateds1	:=	normalize(dVolusiaX,left.Relateds,tRelateds1(right,left.Instrument));

distdRelateds1 := distribute(dRelateds1,HASH32(Instrument));


FinalRec := record

                        string                Instrument;
						            string                Name;
						            string                Name_Index;
                        string                Legal1;
                        string                Legal2;
                        string                Legal3;
                        string                Legal4;
                        string                Legal5;						
			end;
			
	
FinalRec tjoin1(distdNames1 l,pRec2 r) := transform
self.Instrument := l.Instrument;
self.Name := trim(l.Name,left,right);
self.Name_Index := l.Ndx;
self := r;
end;

pJoin := JOIN(distdNames1,pRec2,LEFT.Instrument=RIGHT.Instrument, tjoin1(LEFT,RIGHT),full outer,local);

srt := sort(pJoin,record);
dedp := dedup(srt,all);
distdedp := distribute(dedp,HASH32(Instrument));
JoinRec2 := record
   string   Instrument;     
  string   Date ;     
  string   Book ;     
  string   Page ;     
  string   Pages ;    
  string   Type1 ;    
  string   Transfer1 ;
  string   Mortgage ; 
  string   Docstamps ;
  string   Intangtax ;
  string   Recfee ;   
  string   Name;           
  string   Name_Index;     
  string   Legal1;         
  string   Legal2;         
  string   Legal3;         
  string   Legal4;         
  string   Legal5;		      

end;

JoinRec2 tr_join3(dVolusiaX l ,distdedp r) := transform
self.Instrument           := l.Instrument;
self.Date                 := l.Date;
self.Book                 := l.Book;
self.Page                 := l.Page;
self.Pages                := l.Pages;
self.Type1                := l.Type1;
self.Transfer1            := l.Transfer1;
self.Mortgage             := l.Mortgage;
self.Docstamps            := l.Docstamps;
self.Intangtax            := l.Intangtax;
self.Recfee               := l.Recfee;
self.Name                 := trim(r.Name,left,right);
self.Name_Index           := r.Name_Index;
self.Legal1               := r.Legal1;
self.Legal2               := r.Legal2;
self.Legal3               := r.legal3;
self.Legal4               := r.Legal4;
self.Legal5               := r.Legal5;	
end;

pJoin6 := Join(dVolusiaX,distdedp,LEFT.Instrument=RIGHT.Instrument,tr_join3(LEFT,RIGHT),left outer,local);

distppJoin6 := distribute(pJoin6,HASH32(Instrument));


FinalRec2 := record
	string Instrument;
	string Miscs;
	string Mdx;
	string Rdx;
end;

FinalRec2 tjoin4(distMiscs1 l,distdRelateds1 r) := transform
	self.Miscs := l.Miscs;
	self.Mdx := l.Mdx;
	self.Rdx  := r.Rdx;
	self.Instrument := l.Instrument;
end;

prj4 := Join(distMiscs1,distdRelateds1,LEFT.Instrument=RIGHT.Instrument,tjoin4(LEFT,RIGHT),left outer,local);

distJoin1 := distribute(dedup(sort(prj4,Instrument,Miscs,Mdx,-rdx),record, except rdx),HASH32(Instrument));

JoinRec1 := record
 string   Instrument;      
string   Date     ; 
string   Book ;
string   Page ;
string   Pages ;
string   Type1 ;
string   Transfer1; 
string   Mortgage ;
string   Docstamps ; 
string   Intangtax ; 
string   Recfee ;    
string   Miscs;           
string   RelatedS;        
end;

JoinRec1 tr_join2(dVolusiaX l ,distJoin1 r) := transform
self.Instrument            := l.Instrument;
self.Date                  := l.Date;
self.Book                  := l.Book;
self.Page                  := l.Page;
self.Pages                 := l.Pages;
self.Type1                 := l.Type1;
self.Transfer1             := l.Transfer1;
self.Mortgage              := l.Mortgage;
self.Docstamps             := l.Docstamps;
self.Intangtax             := l.Intangtax;
self.Recfee                := l.Recfee;
self.Miscs                 := r.Miscs;
self.RelatedS              := r.Rdx;
end;

pJoin5 := Join(dVolusiaX,distJoin1,LEFT.Instrument=RIGHT.Instrument,tr_join2(LEFT,RIGHT),left outer,local);

distppJoin5 := distribute(pJoin5,HASH32(Instrument));

JoinFinalRec := 
record
  string Instrument;
  string BOOK ;
  string DATE ;
  string DOCSTAMPS ;
  string INTANGTAX ;
  string MORTGAGE ;
  string PAGE ;
  string PAGES ;
  string RECFEE ;
  string RELATEDS ;
  string TRANSFER1 ;
  string TYPE1 ;
  string LEGAL1 ;
  string LEGAL2 ;
  string LEGAL3 ;
  string LEGAL4 ;
  string LEGAL5 ;
  string MISC ;
  string NAME_index;
  string NAME;
end;

JoinFinalRec tjoinfinal(distppJoin6 l,distppJoin5 r) := transform
self.Instrument         := l.Instrument;
self.BOOK               := trim(l.BOOK);            
self.DATE               := trim(l.DATE);            
self.DOCSTAMPS          := trim(l.DOCSTAMPS);  
self.INTANGTAX          := trim(l.INTANGTAX);  
self.MORTGAGE           := trim(l.MORTGAGE);    
self.PAGE               := trim(l.PAGE);            
self.PAGES              := trim(l.PAGES);          
self.RECFEE             := trim(l.RECFEE);        
self.RELATEDS           := trim(r.RELATEDS);    
self.TRANSFER1          := trim(l.TRANSFER1);  
self.TYPE1              := trim(l.TYPE1);          
self.LEGAL1             := trim(l.LEGAL1);        
self.LEGAL2             := trim(l.LEGAL2);        
self.LEGAL3             := trim(l.LEGAL3);        
self.LEGAL4             := trim(l.LEGAL4);        
self.LEGAL5             := trim(l.LEGAL5);        
self.MISC               := trim(r.miscs);            
self.NAME_index         := trim(l.NAME_index);
self.NAME               := trim(l.NAME,left,right);            

end;

PJoinFinal := Join(distppJoin6,distppJoin5,LEFT.Instrument=RIGHT.Instrument,tjoinfinal(LEFT,RIGHT),left outer,local);

srtfinal := sort(PJoinFinal,record);
export File_In_FL_Volusia := dedup(srtfinal,all);


