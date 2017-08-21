import _validate;
	Filing_In   :=distribute(FBN_CP_HIST_Validations,hash(CPS_SIG_FLNG_FL)) ;
	Name_In		:=distribute(FBNV2.File_CP_Hist_Name_raw_in,hash(CPS_SIG_FLNG));
   
		//joining Filing file and Name file
	Layout_FBN_CP_HIST.Layout_FNSlim transFN( Layout_FBN_CP_HIST.Layout_In_Filing l,Layout_FBN_CP_HIST.Layout_In_Name r):=transform 
         self:=l;
   	     self:=r;

    end;
         
     Filing_name:=join(Filing_In,Name_In,
					trim(left.CPS_SIG_FLNG_FL,left,right) = trim(right.CPS_SIG_FLNG,left,right),
                         transFN(left,right),
         				 left outer,local );		
	/*We have like 213,453 blank name CP records and we are excluding blank name records as per requirement */
	valid_fbn_cp_hist_raw:=Filing_name(name<>''):persist(cluster.cluster_out+'persist::FBNV2::CP_HIST_ValidFilingName');

	reformatDate(string rDate) := function
   			string8 newDate := rDate[5..]+rDate[1..2]+rDate[3..4];	
   			return  newDate	;	
   	end;
	
    NewLayout	:=	record,maxlength(10000000)
      	fbnv2.Layout_FBN_CP_HIST.Layout_FNSlim ;
      	STRING38 	Tmsid					:='';
		STRING35 	Rmsid					:='';
		string 		filing_st;
		string 		bus_name;
		string 		IN_DATE;
		string 		fil_DATE;
		string      cnty_nm;
		string      fil_no;
    end;
      
    newlayout	trfNewLayout(valid_fbn_cp_hist_raw l)	:=	transform
      	self	:=	l;
      	self	:=	[];
    end;
      
    fbn_cp_hist_raw	:=	sort(project(valid_fbn_cp_hist_raw, trfNewLayout(left)),FILING_NUM1,CPS_REC_TYPE);
	
	  /* Raw field "Name" of a Name file can hold either business name or contact name. 
	  We can identify between contact and business by raw field “CPS_REC_TYPE” type, when CPS_REC_TYPE='O' 
	  its contact name and when CPS_REC_TYPE='F' its Business name. With iterate function, creating a unique id for the same group of records, 
	  which can tie together a business name record with its corresponding contact name records.
	  */
	 trimUpper(string s) := function
		  return trim(stringlib.StringToUppercase(s),left,right);
		  end; 
	newLayout trfMerge(newLayout l,newLayout r)	:=	transform
      	samegroup := if(trimUpper(l.FILING_NUM1)=trimUpper(r.FILING_NUM1),true,false);
      	self.bus_name := if(samegroup and trimUpper(l.CPS_REC_TYPE) <> trimUpper(r.CPS_REC_TYPE),
      						stringlib.StringToUppercase(l.name),
      						if(samegroup and trimUpper(l.CPS_REC_TYPE )= 'O' and trimUpper(r.CPS_REC_TYPE) ='O',l.bus_name,stringlib.StringToUppercase(r.name))
      					   );
      	self.filing_st :=if(samegroup and trimUpper(l.CPS_REC_TYPE) <> trimUpper(r.CPS_REC_TYPE),
      						stringlib.StringToUppercase(l.CPS_FILE_ST1),
      						 if(samegroup and trimUpper(l.CPS_REC_TYPE )= 'O' and trimUpper(r.CPS_REC_TYPE) ='O',l.filing_st,stringlib.StringToUppercase(r.CPS_FILE_ST1))
      					   );
		self.IN_DATE := if(samegroup and trimUpper(l.CPS_REC_TYPE) <> trimUpper(r.CPS_REC_TYPE),
      						 l.INSERT_DTE,
      						 if(samegroup and trimUpper(l.CPS_REC_TYPE )= 'O' and trimUpper(r.CPS_REC_TYPE) ='O',l.IN_DATE,r.INSERT_DTE)
      					   );
		self.fil_DATE := if(samegroup and trimUpper(l.CPS_REC_TYPE) <> trimUpper(r.CPS_REC_TYPE),
      						 l.FILING_DTE,
      						 if(samegroup and trimUpper(l.CPS_REC_TYPE )= 'O' and trimUpper(r.CPS_REC_TYPE) ='O',l.fil_DATE,r.FILING_DTE)
      					   );
		self.fil_no := if(samegroup and trimUpper(l.CPS_REC_TYPE) <> trimUpper(r.CPS_REC_TYPE),
      						 stringlib.StringToUppercase(l.FILING_NUM1),
      						 if(samegroup and trimUpper(l.CPS_REC_TYPE )= 'O' and trimUpper(r.CPS_REC_TYPE) ='O',l.fil_no,stringlib.StringToUppercase(r.FILING_NUM1))
      					   );
		self.cnty_nm := if(samegroup and trimUpper(l.CPS_REC_TYPE) <> trimUpper(r.CPS_REC_TYPE),
      						 stringlib.StringToUppercase(l.cps_cnty_nm),
      						 if(samegroup and trimUpper(l.CPS_REC_TYPE )= 'O' and trimUpper(r.CPS_REC_TYPE) ='O',l.cnty_nm,stringlib.StringToUppercase(r.cps_cnty_nm))
      					   );						   
   					   
      	self		  := r;
   end;
   
   
   New_fbn_cp_hist_raw	:=	iterate(fbn_cp_hist_raw	, trfMerge(left,right));
      
      
   NewLayout	trftmsid( NewLayout	l)	:=	transform
      	self.tmsid	:=	'CP' + hash64(trim(l.bus_name,left,right)+ trim(l.filing_st,left,right)+trim(l.fil_no,left,right)+ trim(l.cnty_nm,left,right));
      	self.rmsid  :=	if( _validate.date.fIsValid(trim(reformatDate(l.fil_DATE),left,right)) and 
   															 ((integer)trim(reformatDate(l.fil_DATE),left,right)) <> 0,trim(reformatDate(l.fil_DATE),left,right),
   																if( _validate.date.fIsValid(trim(reformatDate(l.IN_DATE),left,right)) and 
   																	((integer)trim(reformatDate(l.IN_DATE),left,right)) <> 0,
   																	trim(reformatDate(l.IN_DATE),left,right),''));	
      	self		:=	l;
   
   end;
      
      ds_fbn_cp_hist_raw	:=	project(New_fbn_cp_hist_raw,trftmsid(left));


   export File_FBN_CP_HIST_In :=ds_fbn_cp_hist_raw:persist(cluster.cluster_out+'persist::FBNV2::CP_HIST_FilingName');