

Party_NameBase:=DATASET( cluster.cluster_out+'base::ucc::party_Name',Layout_UCC_Common.Layout_Party_With_AID , thor)(tmsid not in UCCV2.Suppress_TMSID());
	    	List:=['NA','N/A','NONE','VOID','N./A','(NO DATA)'];
	
	Layout_UCC_Common.Layout_Party_With_AID  trans_clean(Layout_UCC_Common.Layout_Party_With_AID l):=transform 

		self.Orig_name :=if(trim(l.Orig_name,left,right) not in List,l.Orig_name,'') ;
	    self.Orig_lname:=if(trim(l.Orig_lname,left,right) not in List,l.Orig_lname,'') ;
	    self.Orig_fname:=if(trim(l.Orig_lname,left,right) not in List,l.Orig_fname,'') ;
	    self.Orig_mname:=if(trim(l.Orig_lname,left,right) not in List and trim(l.Orig_fname,left,right) not in List,l.Orig_mname,'') ;
	    self.fname:=if(trim(l.fname,left,right) not in List,l.fname,'') ;
	    self.mname:=if(trim(l.lname,left,right) not in List and trim(l.fname,left,right) not in List,l.mname,'') ;
	    self.lname:=if(trim(l.lname,left,right) not in List,l.lname,'') ;
	    self.Orig_suffix:=if(trim(l.Orig_suffix,left,right) not in List,l.Orig_suffix,'') ;
	    self.prim_name:=if(trim(l.prim_name,left,right) not in List,l.prim_name,'') ;
	    self.Orig_address1:=if(trim(l.Orig_address1,left,right) not in List,l.Orig_address1,'') ;
	    self.Orig_address2:=if(trim(l.Orig_address2,left,right) not in List,l.Orig_address2,'') ;
	    self.Orig_city:=if(trim(l.Orig_city,left,right) not in List,l.Orig_city,'') ;
	    self.Orig_state:=if(trim(l.Orig_state,left,right) not in List,l.Orig_state,'') ;
	    self.Orig_zip5:=if(trim(l.Orig_zip5,left,right) not in List and (integer)trim(l.Orig_zip5,left,right)<>0 ,l.Orig_zip5,'') ;
		self.Orig_postal_code:=if(trim(l.Orig_postal_code,left,right) not in List and (integer)trim(l.Orig_postal_code,left,right)<>0 ,l.Orig_postal_code,'') ;
	    self.company_name:=if(trim(l.company_name,left,right) not in ['NA','N/A','N/A N/A N/A','NONE','N./A','VOID'],l.company_name,'') ;
	    self.p_city_name:=if(trim(l.Orig_city,left,right) in List and trim(l.p_city_name,left,right)='NETHERLANDS ANTILLES','',if( trim(l.p_city_name,left,right)  in List or trim(l.Orig_address1,left,right)in ['','NONE','VOID','N./A','(NO DATA)'] ,'',l.p_city_name)) ;
	    self.v_city_name:=if(trim(l.Orig_city,left,right) in List and trim(l.v_city_name,left,right)='NETHERLANDS ANTILLES','',if( trim(l.v_city_name,left,right)  in List or trim(l.Orig_address1,left,right)in ['','NONE','VOID','N./A','(NO DATA)'],'',l.v_city_name)) ;
	    self.st:=if(trim(l.st,left,right) not in List,l.st,'') ;
		self.zip5:=if(trim(l.zip5,left,right) not in List and (integer)trim(l.zip5,left,right)<>0 ,l.zip5,'') ;
		self.orig_country:=if(trim(l.Orig_address1,left,right)  in List and  trim(l.orig_country,left,right)='NETHERLANDS ANTILLES','',if(trim(l.Orig_address1,left,right)in ['','NONE','VOID','N./A','(NO DATA)'],'',l.orig_country));
		self:=l;
		
  end;
 export File_UCC_Party_Name := project(Party_NameBase, trans_clean(left));