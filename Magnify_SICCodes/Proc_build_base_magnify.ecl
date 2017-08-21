import doxie,Advo,Address,ut,Business_Header,versioncontrol, _control;
 
 export Proc_build_base_magnify(
						string	Filedate
						,boolean				pOverwrite      = false
) :=function 
	
	BH_BDID_SIC_ds 	:= 	dedup(sort(distribute(Business_Header.BH_BDID_SIC(),hash(bdid)),bdid,local),bdid,local);
    BH_ds			:=	dedup(sort(distribute(Business_Header.File_Business_Header,hash(bdid)),bdid,-dt_last_seen,local),bdid,local);
    siccodes_ds 	:= Magnify_SICCodes.File_raw_in;
	
    layout_sic_Addr := record
     string8    	sic_code;
     unsigned6  	bdid;
     string2 	 	source;
     qstring120 	company_name;
     qstring10  	prim_range;
     string2    	predir;
     qstring28  	prim_name;
     qstring4   	suffix;
     string2    	postdir;
     qstring5   	unit_desig;
     qstring8   	sec_range;
     qstring25  	city;
     string2   	 	state;
     unsigned3  	zip;
     unsigned2  	zip4;
     unsigned6  	phone;
     
   end;
   
   layout_sic_Addr JoinedToGetBHaddr(BH_BDID_SIC_ds lInput, BH_ds rInput)	:=	transform
   	self.sic_code		:=	lInput.sic_code;
   	self.bdid			:=	lInput.bdid;
   	self.source			:=	lInput.source;
   	self.company_name	:=	rInput.company_name;
   	self.prim_range		:=	rInput.prim_range;
   	self.predir	    	:=	rInput.predir;
   	self.prim_name  	:=	rInput.prim_name;
   	self.suffix			:=	rInput.addr_suffix;
   	self.postdir	    :=	rInput.postdir;
   	self.unit_desig		:=	rInput.unit_desig;
   	self.sec_range		:=	rInput.sec_range;
   	self.city			:=	rInput.city;
   	self.state	    	:=	rInput.state;
   	self.zip	    	:=	rInput.zip;
   	self.zip4			:=	rInput.zip4;
   	self.phone			:=	rInput.phone;
   end;
   
   //Join the BH_BDID_SIC file to the business header file to get associated sic_code business entity information 
   JoinToGetBHaddr	:=	join(BH_BDID_SIC_ds,BH_ds,
   							left.bdid = right.bdid,
   							JoinedToGetBHaddr(left,right),
   							left outer,
   							local
   						 );
    //Magnify process only gets 4 character lengths sic codes form vendor.
	//sic codes in Business_Header file are zero padded out to 8 characters.							 
    Sic_businessH_ds := dedup(JoinToGetBHaddr, all)((integer)sic_code[5..8]=0);
    
    

	 
	 layout_sic_Addr_CDS := record
				   layout_sic_Addr;
		string1    CDS_code;
		string     CDS_desc;
     
	end;
   

	advo_ds                := Advo.Files().File_Cleaned_Base;
      	 
         //Join the YellowPages-sic_code business entity information with Advo file to get associated CDS_code and CDS_description info
      	 Layouts.SIC_Code_Out_layout JoinedToGetCDS(Sic_businessH_ds lInput, advo_ds rInput)	:=	transform
         
      	  self.CDS_code	 		            :=	trim(rInput.Residential_or_Business_Ind,left,right);
      	  self.CDS_Description	            :=	Advo.Lookup_Descriptions.Delivery_Type_Description_lookup(trim(rInput.Residential_or_Business_Ind,left,right));   	
		  self.sic                    		:=	trim(lInput.Sic_code[1..4],left,right);
   		  self.Business_Name                :=	trim(lInput.company_name,left,right);
   		  self.Address					    :=	trim(Address.Addr1FromComponents(
   																 lInput.prim_range
   																,lInput.predir
   																,lInput.prim_name
   																,lInput.suffix
   																,lInput.postdir
   																,lInput.unit_desig,lInput.sec_range
   															),left,right);
   		  self.City                    		:=	trim(lInput.city,left,right);
   		  self.State                    	:=	trim(lInput.state,left,right);
   		  self.Zip                    		:=if(lInput.zip<>0,(string)INTFORMAT(lInput.zip,5,1),'') + if(lInput.zip4<>0,(string)INTFORMAT(lInput.zip4,4,1),'');
		  self.Phone                    	:=(string)lInput.phone;
		  self                              := 	lInput;
		  self                              := 	[];
		  
         end;
         
      
         JoinToGetCDS	:=	join(Sic_businessH_ds,advo_ds,
   							(string)(integer)left.zip = (string)(integer)right.zip and 
							left.prim_range           = right.prim_range and 
							left.prim_name            = right.prim_name and 
							left.suffix         	  = right.addr_suffix and 
							left.predir               = right.predir and 
							left.postdir              = right.postdir and 
							left.sec_range            = right.sec_range,
   							JoinedToGetCDS(left,right),
   							left outer
   						 );
								 
		YsicCDS               := dedup(sort(JoinToGetCDS,record),record);

    Layouts.SIC_Code_Out_layout tranExtract(YsicCDS  l ,siccodes_ds	 r):=transform 
   
          self.UniqueID						:=	trim(r.UniqueID,left,right);
   		  self.Sic_code						:=	trim(r.Sic_code,left,right);
   		  self.Organization					:=	REGEXREPLACE('[\\r|\\n]',stringlib.StringToUppercase(trim(r.Organization,left,right)), '');
		  self.lf                           :='\r\n';
		  self                              :=  l;
   end;
   		
   		SicExtract		:= join(YsicCDS,siccodes_ds,
   								trim(left.sic,left,right)=trim(right.sic_code,left,right),
   								tranExtract(left,right),right outer );
								
		SIC_Code_Lookup_TBL :=record
      		string sic_code;
      		string desc;
      	end;
      	
       SIC_Code_Lookup_ds    := dataset(ut.foreign_prod+'~thor_data50::lookup::sic_code_table',SIC_Code_Lookup_TBL,
      																			 csv(heading(0),separator('|'),quote('"')));
       
      	
      	//Join to SIC_Code_Lookup table to get sic_business description
      Layouts.SIC_Code_Out_layout Sic_Description(Layouts.SIC_Code_Out_layout l, SIC_Code_Lookup_TBL r ) := transform
      			self.Sic_Description    	:= stringlib.StringToUppercase(trim(r.desc)); 
      			self         			    := l;
      end; 
      		
      		
       SicDesExtract := join(SicExtract,SIC_Code_Lookup_ds,
      									trim(left.sic, left,right) = trim(right.sic_code,left,right),
      									Sic_Description(left,right),
      									lookup,left outer
      								);
									
        
    
								 
		response        := sort(SicDesExtract,sic_code,zip);
		
		VersionControl.macBuildNewLogicalFile('~thor_data400::out::'+filedate+'::magnify_Extract',response,BuildExtractFile,,,pOverwrite,);
		e_mail_success  := fileservices.sendemail(_control.MyInfo.EmailAddressNotify+' datareceiving@lexisnexis.com;kirtan.dave@lexisnexis.com;chet.price@lexisnexis.com;saritha.myana@lexisnexis.com',
										 'Magnify',
   										 'The SIC Code scheduled batch is complete. -------\n' +
   										 'You may pick up the output files from FTP site at any time-------\n'
   										 );
   		super_main := sequential(FileServices.StartSuperFileTransaction()
		        ,FileServices.clearsuperfile('~thor_data400::base::magnify_Extract',true)
				,FileServices.AddSuperFile('~thor_data400::base::magnify_Extract', 
				                          '~thor_data400::out::'+filedate+'::magnify_Extract'), 
				FileServices.FinishSuperFileTransaction());

Add_super := if(FileServices.FindSuperFileSubName('~thor_data400::base::magnify_Extract', '~thor_data400::out::'+filedate+'::magnify_Extract') = 0,super_main); 							  
									  
		results			  :=sequential(
								output('Sic_code BusinessInfo Results Follow'	,named('_' ))
								,BuildExtractFile
								,Add_super
								,output(choosen(File_magnifySICCodes_base,1000),named ('MagnifySicCode_SampleRecords'))
								): success(e_mail_success);
		
		return results;
		
end;