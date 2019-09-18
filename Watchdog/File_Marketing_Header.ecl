import header,mdr, ut, Watchdog;

hdr_nonglb := Watchdog.Files_ReCleaned.Header_NonGLB(mdr.sourcetools.sourceisonprobation(src)=false);

hdr4mktng0:=hdr_nonglb(~Mdr.sourcetools.SourceIsGLB(src),mdr.Source_is_Marketing_Eligible(src,vendor_id,st,county,dt_nonglb_last_seen,dt_first_seen));
hdr4mktng:=project(hdr4mktng0,transform({hdr4mktng0},self.dob:=if(left.src='TS',0,left.dob),self:=left)) 
           + project(Watchdog.Files_ReCleaned.infutor_,transform(recordof(left),self.ssn := '',self:=LEFT),local)
					 + Watchdog.Files_ReCleaned.infutor_narc;

export File_Marketing_Header := hdr4mktng;