import ut, addresscleaner_monthly_testing, address;

  #workunit('protect',true);
  #workunit('name','Yogurt:AddressCleaner Build Data '+ addresscleaner_monthly_testing.version);
	  //#option('AllowedClusters','thor400_30,thor400_20,thor400_60');
	//#option('AllowedClusters','thor400_20,thor400_30,thor400_60');
  #OPTION('multiplePersistInstances',FALSE);
//  #option('AllowAutoQueueSwitch',TRUE);
////# March USDir 20180613, Canada 20180613, Navteq 201305
	
fileservices.RemoveOwnedSubFiles('~thor400_data::addresscleaner::monthly::processed');	
fileservices.clearsuperfile('~thor400_data::addresscleaner::monthly::processed');
	
r:=RECORD
unsigned6 record_id;
string line1;
string line2;
end;



d := dataset('~thor400_data::in::addresscleaner::perm_data',r,flat);

p:=RECORD
r;
string prange;
string ppre;
string pstreet;
string psuffix;
string ppost;
string punit;
string papt;
string pcity;
string pvanity;
string pstate;
string pzip5;
string pzip4;
string pcart;
string psort;
string plot;
string porder;
string pdpbc;
string pchk;
string ptype;
string pcounty;
string pstatus;
string perror;
string plat;
string plong;
string pmsa;
string pblock;
string pmatch;
END;

c:=RECORD
r;
string crange;
string cpre;
string cstreet;
string csuffix;
string cpost;
string cunit;
string capt;
string ccity;
string cvanity;
string cstate;
string czip5;
string czip4;
string ccart;
string csort;
string clot;
string corder;
string cdpbc;
string cchk;
string ctype;
string ccounty;
string cstatus;
string cerror;
string clat;
string clong;
string cmsa;
string cblock;
string cmatch;
END;





//CleanAddress182(const string addrline, const string lastline,string server = '',unsigned2 port = 0)
p TransP (d X) := TRANSFORM
        Clean  		:= address.CleanAddress182(TRIM(X.line1,RIGHT,LEFT),TRIM(X.line2,RIGHT,LEFT));
STRING5   v_zip       		:= Clean[117..121];
STRING4   v_zip4      		:= Clean[122..125];			 
SELF.prange     := Clean[1..10];
SELF.ppre       := Clean[11..12];
SELF.pstreet 		:= Clean[13..40];
SELF.psuffix    := Clean[41..44];
SELF.ppost      := Clean[45..46];
SELF.punit      := Clean[47..56];
SELF.papt       := Clean[57..64];
SELF.pcity      := Clean[65..89];
SELF.pvanity    := Clean[90..114];
SELF.pstate     := Clean[115..116];
SELF.pzip5      := if(v_zip='00000','',v_zip);
SELF.pzip4      := if(v_zip4='0000','',v_zip4);
SELF.pcart      := Clean[126..129];
SELF.psort      := Clean[130..130];
SELF.plot       := Clean[131..134];
SELF.porder     := Clean[135..135];
SELF.pdpbc     	:= Clean[136..137];
SELF.pchk       := Clean[138..138];
SELF.ptype      := Clean[139..140];
SELF.pcounty    := Clean[141..145];
SELF.pstatus    := '';
SELF.perror     := Clean[179..182];
SELF.plat       := Clean[146..155];
SELF.plong      := Clean[156..166];
SELF.pmsa       := Clean[166..169];
SELF.pblock     := Clean[171..177];
SELF.pmatch     := Clean[178..178];
SELF            := X
END;

dProjP			:= PROJECT ( d , TransP ( LEFT ) )	;

//CleanAddress182(const string addrline, const string lastline,string server = '',unsigned2 port = 0)			 
 c TransC (d X) := TRANSFORM
        Clean  		:= address.CleanAddress182(TRIM(X.line1,RIGHT,LEFT),TRIM(X.line2,RIGHT,LEFT),'Bctlppostalclean18.risk.regn.net',21000);
STRING5   v_zip       		:= Clean[117..121];
STRING4   v_zip4      		:= Clean[122..125];			 
SELF.crange     := Clean[1..10];
SELF.cpre       := Clean[11..12];
SELF.cstreet 		:= Clean[13..40];
SELF.csuffix    := Clean[41..44];
SELF.cpost      := Clean[45..46];
SELF.cunit      := Clean[47..56];
SELF.capt       := Clean[57..64];
SELF.ccity      := Clean[65..89];
SELF.cvanity    := Clean[90..114];
SELF.cstate     := Clean[115..116];
SELF.czip5      := if(v_zip='00000','',v_zip);
SELF.czip4      := if(v_zip4='0000','',v_zip4);
SELF.ccart      := Clean[126..129];
SELF.csort      := Clean[130..130];
SELF.clot       := Clean[131..134];
SELF.corder     := Clean[135..135];
SELF.cdpbc     	:= Clean[136..137];
SELF.cchk       := Clean[138..138];
SELF.ctype      := Clean[139..140];
SELF.ccounty    := Clean[141..145];
SELF.cstatus    := '';
SELF.cerror     := Clean[179..182];
SELF.clat       := Clean[146..155];
SELF.clong      := Clean[156..166];
SELF.cmsa       := Clean[166..169];
SELF.cblock     := Clean[171..177];
SELF.cmatch     := Clean[178..178];
SELF            := X
END;

dProjC			:= PROJECT ( d , TransC ( LEFT ) )	;

inRec :=RECORD
string   line1;    
string   line2;     
string   prange;    
string   ppre;      
string   pstreet;   
string   psuffix;   
string   ppost;   
string   punit;   
string   papt;    
string   pcity;   
string   pvanity; 
string   pstate;  
string   pzip5;   
string   pzip4;   
string   pcart;   
string   psort;     
string   plot;      
string   porder;    
string   pdpbc;     
string   pchk;      
string   ptype;     
string   pcounty;   
string   pstatus;   
string   perror;    
string   plat;      
string   plong;     
string   pmsa;      
string   pblock;    
string   pmatch;    
string   crange;    
string   cpre;      
string   cstreet;   
string   csuffix;   
string   cpost;     
string   cunit;     
string   capt;      
string   ccity;     
string   cvanity ;  
string   cstate;    
string   czip5;     
string   czip4;     
string   ccart;     
string   csort;     
string   clot;      
string   corder;    
string   cdpbc;     
string   cchk;      
string   ctype;     
string   ccounty;   
string   cstatus;   
string   cerror;    
string   clat;      
string   clong;     
string   cmsa;      
string   cblock;    
string   cmatch;    
END;	
inRec processed_key_records_output(dProjP l, dProjC r) := TRANSFORM
  self.line1     := l.line1;
	self.line2     := l.line2;
	self.prange    := l.prange;
	self.ppre      := l.ppre;
	self.pstreet   := l.pstreet;
  self.psuffix   := l.psuffix;
  self.ppost     := l.ppost;
  self.punit     := l.punit;
  self.papt      := l.papt;
  self.pcity     := l.pcity;
  self.pvanity   := l.pvanity;
  self.pstate    := l.pstate;
  self.pzip5     := l.pzip5;
  self.pzip4     := l.pzip4;
  self.pcart     := l.pcart;
	self.psort     := l.psort;
  self.plot      := l.plot;
  self.porder    := l.porder;
  self.pdpbc     := l.pdpbc;
  self.pchk      := l.pchk;
  self.ptype     := l.ptype;
  self.pcounty   := l.pcounty;
  self.pstatus   := l.pstatus;
  self.perror    := l.perror;
  self.plat      := l.plat;
  self.plong     := l.plong;
  self.pmsa      := l.pmsa;
  self.pblock    := l.pblock;
  self.pmatch    := l.pmatch;
  self.crange    := r.crange;
  self.cpre      := r.cpre;
  self.cstreet   := r.cstreet;
  self.csuffix   := r.csuffix;
  self.cpost     := r.cpost;
  self.cunit     := r.cunit;
  self.capt      := r.capt;
  self.ccity     := r.ccity;
  self.cvanity   := r.cvanity;
  self.cstate    := r.cstate;
  self.czip5     := r.czip5;
  self.czip4     := r.czip4;
  self.ccart     := r.ccart;
  self.csort     := r.csort;
  self.clot      := r.clot;
  self.corder    := r.corder;
  self.cdpbc     := r.cdpbc;
  self.cchk      := r.cchk;
  self.ctype     := r.ctype;
  self.ccounty   := r.ccounty;
  self.cstatus   := r.cstatus;
  self.cerror    := r.cerror;
  self.clat      := r.clat;
  self.clong     := r.clong;
  self.cmsa      := r.cmsa;
  self.cblock    := r.cblock;
  self.cmatch    := r.cmatch;
	//self.lf = '';
	END;
	
processed_key_records := join(dProjP,dProjC,LEFT.record_id = RIGHT.record_id, processed_key_records_output(left,right));
output(processed_key_records,,'~thor400_data::addresscleaner_' + addresscleaner_monthly_testing.version + '::processed',compressed,overwrite);	
fileservices.addsuperfile('~thor400_data::addresscleaner::monthly::processed','~thor400_data::addresscleaner_' + addresscleaner_monthly_testing.version + '::processed');						
