IMPORT Experian_phones, Gong, PhoneMart, PhonesPlus_v2, std;

	//zz_ctio.cron_job.PhoneAnalysis : WHEN(CRON('0 7 1 * *'));
EXPORT PhonesMatrixReport := FUNCTION
  #WORKUNIT('name', 'Phone Matrix Report');
	string pn(unsigned8 stat) := function
				return TRIM(if(stat>999999999999,(string)(stat DIV 1000000000000)+',',																					   ' ') +
										if(stat>999999999,	intformat(((stat%1000000000000) DIV 1000000000),3,if(stat>999999999999,1,0))+',',  '    ') +
										if(stat>999999,			intformat(((stat%1000000000) DIV 1000000),3,if(stat>999999999,1,0))+',',				   '    ') +
										if(stat>999,   			intformat(((stat%1000000) DIV 1000),3,if(stat>999999,1,0))+',',								     '    ') +
										                    intformat(stat%1000,3,if(stat>999,1,0)),right);

  end;

		ppv2 := dedup(sort(distribute(PhonesPlus_v2.key_phonesplus_fdid(cellphone<>''), hash(cellphone)), cellphone, -confidencescore, local), cellphone, local) ;

		gong_key := Gong.Key_History_phone(phone10<>'');
		layout_matrix := record
			string10  phone:='';
			string3   phone_digits:='';
			unsigned6 did:=0;
			string3   src;
			string19  app ;
			string19  bpp ;
			string19  cgo ;
			string19  hgo ;
			string19  eqx ;
			string19  expr ;
		end;

    /*********************************Inputs********************************/
		//1Phones plus records
		PhonesPlusds      := project(ppv2(cellphone<>''),transform({layout_matrix},self.phone:=left.cellphone;
		                                                         self.phone_digits:=left.cellphone[8..10];
																														 self.did:=left.did;
																														 self.src := MAP(left.confidencescore>10 => 'APP','BPP');
																														 self := [])) ;																																									 

		//2Gong Records																																							
    Gongds            :=	project(gong_key(phone10<>''),transform({layout_matrix},self.phone:=left.phone10;
											                                                            self.phone_digits:=left.phone10[8..10];
																															                    self.did:=left.did;
																															                    self.src := MAP(left.current_flag =true =>'LGO','HGO');
																															                    self := []));	
																																		 
		//3Equifax
		Equifaxds		      := project(PhoneMart.key_phonemart_did(phone<>''),transform({layout_matrix},self.phone_digits:=left.phone[8..10];
																                                                                  self.src := 'EQX';     
																                                                                  self :=left;
																													                                        self := []));
		
		//4Experian
		experiands        := project(Experian_phones.Key_Did(fullphone<>''),transform({layout_matrix},self.phone:=left.fullphone;
		                                                                                              self.phone_digits:=left.phone_digits;
														                                                                      self.did:=left.did;
																											                                            self.src := 'EXP';
																											                                            self := []));
				
		Ln_Eqx_Expr       := PhonesPlusds+Gongds+Equifaxds+experiands; 
		
    // tab               := table(Ln_Eqx_Expr,{phone},phone);	
		// count(tab);
		
	  Ln_Eqx_ExprSorted := sort(distribute(Ln_Eqx_Expr(),hash(phone)),phone,src,local):persist('persist::Phones::MatrixReportInput');																	

   // Put the phones and sources in a matrix format for reporting
   layout_matrix createMatrix (Ln_Eqx_ExprSorted L,Ln_Eqx_ExprSorted R) := TRANSFORM
			self.phone       :=IF(L.phone ='', R.phone,L.phone);
			self.did         :=IF(L.did   =0, R.did,L.did);
			self.phone_digits:=IF(L.phone_digits ='', R.phone_digits,L.phone_digits);
			self.app        := Map(R.src = 'APP' => 'X',
			                       L.app = '' and L.src ='APP'=>'X',
			                       L.app);
			self.bpp        := MAP(R.src = 'BPP'=>'X',
			                       L.bpp = '' and L.src ='BPP'=>'X',
														 L.bpp);
			self.cgo        := MAP(R.src = 'LGO'=>'X',
			                       L.cgo = '' and L.src ='LGO'=>'X',
														 L.cgo);
			self.hgo        := MAP(R.src = 'HGO'=>'X',
			                       L.hgo = '' and L.src ='HGO'=>'X',
			                       L.hgo);
			self.eqx        := MAP(R.src = 'EQX'=>'X',
			                       L.eqx = '' and L.src ='EQX'=>'X',
			                       L.eqx);
			self.expr       := MAP(R.src = 'EXP'=>'X',
			                       L.expr = '' and L.src ='EXP'=>'X',
			                       L.expr);
			self             := [];
  end;

	Matrix_result		:= rollup(Ln_Eqx_ExprSorted,
													left.phone=right.phone,
													createMatrix(left,right),local):persist('persist::Phones_Matrix_LN_EQX_EXP');
													
  //Populate the matrix for pass thru records
	Proj_Matrix_res := project(Matrix_result,transform({layout_matrix},self.app  := Map(Left.src = 'APP'=>'X', Left.app);
			                                                               self.bpp  := MAP(Left.src = 'BPP'=>'X', Left.bpp);
			                                                               self.cgo  := MAP(Left.src = 'LGO'=>'X', Left.cgo);
			                                                               self.hgo  := MAP(Left.src = 'HGO'=>'X', Left.hgo);
			                                                               self.eqx  := MAP(Left.src = 'EQX'=>'X', Left.eqx);
			                                                               self.expr := MAP(Left.src = 'EXP'=>'X', Left.expr);
																																		 self := Left;
																											               self := []));
	//Create report skeleton 
	report_rec := record
	
	 String30   Number_Of_Sources := MAP(length(trim(Proj_Matrix_res.app)+trim(Proj_Matrix_res.bpp)+trim(Proj_Matrix_res.cgo)+trim(Proj_Matrix_res.hgo)+trim(Proj_Matrix_res.eqx)+trim(Proj_Matrix_res.expr))=6 => 'In Six Sources',
	                                   length(trim(Proj_Matrix_res.app)+trim(Proj_Matrix_res.bpp)+trim(Proj_Matrix_res.cgo)+trim(Proj_Matrix_res.hgo)+trim(Proj_Matrix_res.eqx)+trim(Proj_Matrix_res.expr))=5 => 'In Five Sources',
						    										 length(trim(Proj_Matrix_res.app)+trim(Proj_Matrix_res.bpp)+trim(Proj_Matrix_res.cgo)+trim(Proj_Matrix_res.hgo)+trim(Proj_Matrix_res.eqx)+trim(Proj_Matrix_res.expr))=4 => 'In Four Sources',
																		 length(trim(Proj_Matrix_res.app)+trim(Proj_Matrix_res.bpp)+trim(Proj_Matrix_res.cgo)+trim(Proj_Matrix_res.hgo)+trim(Proj_Matrix_res.eqx)+trim(Proj_Matrix_res.expr))=3 => 'In Three Sources',
																		 length(trim(Proj_Matrix_res.app)+trim(Proj_Matrix_res.bpp)+trim(Proj_Matrix_res.cgo)+trim(Proj_Matrix_res.hgo)+trim(Proj_Matrix_res.eqx)+trim(Proj_Matrix_res.expr))=2 => 'In Two Sources',
																		 length(trim(Proj_Matrix_res.app)+trim(Proj_Matrix_res.bpp)+trim(Proj_Matrix_res.cgo)+trim(Proj_Matrix_res.hgo)+trim(Proj_Matrix_res.eqx)+trim(Proj_Matrix_res.expr))=1 => 'In One Source',	
																		 '');
   integer   num_srcs					:= length(trim(Proj_Matrix_res.app)+trim(Proj_Matrix_res.bpp)+trim(Proj_Matrix_res.cgo)+trim(Proj_Matrix_res.hgo)+trim(Proj_Matrix_res.eqx)+trim(Proj_Matrix_res.expr));
	                               														 
	 Proj_Matrix_res.app;
   Proj_Matrix_res.bpp;
   Proj_Matrix_res.cgo;
	 Proj_Matrix_res.hgo;
   Proj_Matrix_res.eqx;
   Proj_Matrix_res.expr;
	 Cnt := pn(count(group));
	end;
	MatrixReport_body   := table(Proj_Matrix_res,report_rec,app,bpp,cgo,hgo,eqx,expr,few);
	MatrixReport_bodySrt:= sort(MatrixReport_body,num_srcs,app,bpp,cgo,hgo,eqx,expr);
	
	//Generate footer
	report_rec1 := record
	 String30    Number_Of_Sources := 'Total';
	 integer   num_srcs  := 7;
	 string19  total_app := (string)pn(count(group,Proj_Matrix_res.app  ='X'));
   string19  total_bpp := (string)pn(count(group,Proj_Matrix_res.bpp  ='X'));
   string19  total_cgo := (string)pn(count(group,Proj_Matrix_res.cgo  ='X'));
	 string19  total_hgo := (string)pn(count(group,Proj_Matrix_res.hgo  ='X'));
   string19  total_eqx := (string)pn(count(group,Proj_Matrix_res.eqx  ='X'));
   string19  total_expr:= (string)pn(count(group,Proj_Matrix_res.expr ='X'));
	 string19  total_Cnt := pn(count(group));
	end;
   
	MatrixReport_footer := table(Proj_Matrix_res,report_rec1,few);	
	
	//Create CSV to be emailed
		linestring := RECORD
		  string       code0;
		  integer      num_srcs  ;
		  string30     Number_Of_Sources;
			STRING300000 line; 
		END;

		headerRec := 'Number of Sources, PhonesPlus A, PhonesPlus B, Gong Current, Gong History, Equifax, Experian, Count';
	
		linestring convertbodytocsv (MatrixReport_bodySrt L) := TRANSFORM
		    
				SELF.line  := L.app+ ',' + L.bpp+ ',' + L.cgo+ ',' + L.hgo+ ',' + L.eqx+ ',' + L.expr+','+'"'+L.Cnt+'"';			
				self.code0 := '0';
				self:= L;
		END;		
		singlelineBody := PROJECT (MatrixReport_bodySrt, convertbodytocsv(LEFT));	
		
		linestring convertfootertocsv (MatrixReport_footer L) := TRANSFORM
		    
				SELF.line  :=  '"'+L.total_app+ '","' + L.total_bpp+ '","' + L.total_cgo+ '","' + L.total_hgo+ '","' + L.total_eqx+ '","' + L.total_expr+'","'+L.total_Cnt+'"';		
        self.code0 := '0';				
				self:= L;
		END;		
		singlelinefooter := PROJECT (MatrixReport_footer, convertfootertocsv(LEFT));	
 
    sortedRecords := sort(singlelineBody+singlelinefooter,num_srcs);
		
		linestring DeNormThem(linestring L, linestring R, INTEGER C) := TRANSFORM

	  string templine1  := R.Number_Of_Sources+','+R.line;
		string templine2  := '            ,'+R.line;
			
    SELF.line     := MAP (C=1 => templine1, 
		                      C>1 and L.num_srcs = R.num_srcs =>TRIM(L.line, left, right) + '\n' + TRIM(templine2, LEFT, RIGHT),
											    C>1 and L.num_srcs <>R.num_srcs =>TRIM(L.line, left, right) + '\n' + TRIM(templine1, LEFT, RIGHT),
											    ''); 
    SELF.num_srcs := R.num_srcs;
		self:=    R;
    END;

    csvOut := DENORMALIZE(singlelinefooter,sortedRecords,
                            LEFT.code0 = RIGHT.code0,
                            DeNormThem(LEFT,RIGHT,COUNTER));

	
	  Bodytext := 'Description for columns in the report:'+'\n\n'+
		            'PhonesPlus A - Phones plus records with confidence score >10'+'\n\n'+
		            'PhonesPlus B - Phones plus records with confidence score <=10'+'\n\n'+
								'Gong Current - Current/latest Gong Records'+'\n\n'+
								'Gong History - Historical Gong Records'+'\n\n\n'+
								'Regards,'+'\n\n'+
								'Data Fabrications Team';
		
    sendemail	:= FileServices.SendEmailAttachText( 'vani.chikte@lexisnexis.com'
																						,'Phones Matrix Report - ' + (STRING8)Std.Date.Today() 
																						,'Please find the Analysis attached : WU -'+workunit+'\n\n'+Bodytext
																						, headerRec+'\n'+csvOut[1].line
																						,'text/xml'
																						,'PhonesMatrixReport'+(STRING8)Std.Date.Today()+'.csv'
																						,
																						,
																						,'vani.chikte@lexisnexis.com'	);
																		
    do_all := parallel(output(MatrixReport_bodySrt),output(MatrixReport_footer),                     
                         sendemail
												 );
   return do_all;
   

	END;