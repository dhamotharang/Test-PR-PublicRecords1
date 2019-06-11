import address, did_add, didville, ut, header_slimsort, business_header, Business_Header_SS, lib_stringlib, _validate;

dFinancingComment   	:= File_DnB_FinancingComment_in;
dSigner             	:= File_DnB_Signer_in;
dFinancingStatement		:= distribute(File_DnB_FinancingStatement_in,hash(FILG_OFC_DUNS_NBR));
dCollateral	 			    := File_DnB_Collateral_in;
dCollateralItem       := File_DnB_CollateralItem_in;	
dJurisidiction        := distribute(File_DNB_Jurisdiction_Lookup_in,hash(FILG_OFC_DUNS_NBR));
dfile								  := File_Dnb_Main_Base;

fn_past_date(STRING sDate) :=	function
	date     := stringlib.stringfilter(trim(sdate, all),'0123456789');
	validdate:= if(_validate.date.fisvalid(date) and 
								 _validate.date.fisvalid(date,_validate.date.rules.dateinpast),
								 date,'');
	return validdate;		
end;

fn_general_date(STRING sDate) :=	function
	date     := stringlib.stringfilter(trim(sdate, all),'0123456789');
	validdate:= if( _validate.date.fisvalid(date),date,'');
	return validdate;		
end;

fCorrectFilingNum(string FilingNumber, string jurisdiction)	:=	function
	string25	NewFiling	:=if(jurisdiction = 'NY' and length(trim(FilingNumber,left,right))=13,
													 stringlib.StringToUpperCase('20' + trim(FilingNumber,left,right)),
													 stringlib.StringToUpperCase(trim(FilingNumber,left,right))
												   );
	return NewFiling;
end;

recordof(dFinancingStatement)  Trans_add_Jurisdiction(dFinancingStatement pLeft, dJurisidiction  pRight):=TRANSFORM
	self.Filing_Jurisdiction  := pRight.Jurisdiction;
	self                      := pLeft;
END;

layout_collateral :=record
	string17 	rmsid;	
	Layout_UCC_Common.collateral ;
end;

Layout_UCC_Common.layout_ucc_new Trans_Rmsid(Layout_UCC_Common.layout_ucc_new pLeft,string2 c ) :=TRANSFORM
	self.Rmsid               := if(trim(C,left,right)='1',pLeft.rmsid,trim(C,left,right)+'D'+pLeft.rmsid);
	self                     := pLeft;
end;
Layout_UCC_Common.layout_ucc_new Trans_rollback_Rmsid(Layout_UCC_Common.layout_ucc_new pInput) :=TRANSFORM
	unsigned2 position       := stringlib.stringfind(pInput.rmsid,'D',1)+1;
	self.Rmsid               := pInput.rmsid[position..23-position+1];
	self                     := pInput;
end;	

Layout_UCC_Common.Filing Trans_add_signer(dFinancingStatement pLeft, dSigner pRight) :=TRANSFORM
	string60 title 			     := if(pRight.FING_SGNR_TTL>'',trim(pRight.FING_SGNR_TTL)+';','')  +
														  if(pRight.FING_SGNR_TTL2>'',trim(pRight.FING_SGNR_TTL2)+';','')+
															if(pRight.FING_SGNR_TTL3>'',trim(pRight.FING_SGNR_TTL3)+';','')+ 
															if(pRight.FING_SGNR_TTL_DESC>'',trim(pRight.FING_SGNR_TTL_DESC)+';','');
	string25 orig_filing     := if(pLeft.FILG_STMT_TYPE_DEC='INITIAL FILING' Or pLeft.FILG_STMT_TYPE_DEC='ORIGINAL' 
															   ,fCorrectFilingNum(pLeft.FILG_NBR_FULL,pLeft.Filing_Jurisdiction)
															   ,fCorrectFilingNum(pLeft.XREF_NBR,pLeft.Filing_Jurisdiction)
																 );
	self.rmsid 				       := pLeft.F_FING_ENTY_ID;
	self.tmsid				       := if(lib_stringlib.stringlib.stringfindreplace(orig_filing,'0','')='','',orig_filing);
	self.orig_filing_number  := if(lib_stringlib.stringlib.stringfindreplace(orig_filing,'0','')='','',orig_filing);
	self.orig_filing_date 	 := if(pLeft.FILG_STMT_TYPE_DEC='INITIAL FILING' Or pLeft.FILG_STMT_TYPE_DEC='ORIGINAL', fn_past_date(pLeft.FILG_DT), fn_past_date(pLeft.XREF_DT));
	self.filing_date 		     := fn_past_date(pLeft.FILG_DT);
	self.page 				       := pLeft.FILG_NBR_PG;
	self.vendor_entry_date 	 := fn_past_date(pLeft.DT_ENTD);
	self.vendor_upd_date 		 := fn_past_date(pLeft.DT_LAST_UPD);
	self.filing_number 		 	 := if(pLeft.FILG_NBR_FULL='',orig_filing,fCorrectFilingNum(pLeft.FILG_NBR_FULL,pLeft.Filing_Jurisdiction));
	self.filing_type 		     := if(pLeft.FILG_STMT_TYPE_DEC='ORIGINAL','INITIAL FILING',pLeft.FILG_STMT_TYPE_DEC);
	self.contract_type 		   := pLeft.CONT_desc;
	self.filing_time 		     := pLeft.FILG_TIME;
	self.expiration_date 		 := fn_general_date(pLeft.FILG_EXPN_DT) ;
	self.Signer_Name 		     := pRight.INDV_NME;
	self.Title 				       := if(trim(title,left,right) =';', '',title);
	self.Filing_agency 		   := pLeft.FILG_OFC_NME;
	self.address			       := pLeft.FILG_OFC_STR_ADR;
	self.city 				       := pLeft.FILG_OFC_CITY_NME;
	self.county 				     := pLeft.FILG_OFC_CNTY_NME;
	self.state 				       := pLeft.FILG_OFC_ST_NME;
	self.zip 					       := pLeft.FILG_OFC_POST_CD;
	self.duns_number 			   := pLeft.FILG_OFC_DUNS_NBR;
	self						         :=	pLeft;

END;

Layout_UCC_Common.Filing Trans_cmn_signer(Layout_UCC_Common.Filing pLeft, dFinancingComment  pRight) :=TRANSFORM
	string60 title 			 			:= if(pRight.SRC_INDV_TTL>'0',trim(pRight.SRC_INDV_TTL)+';','')+
															 if(pRight.SRC_INDV_TTL2>'0',trim(pRight.SRC_INDV_TTL2)+';','')+
															 if(pRight.SRC_INDV_TTL3>'0',trim(pRight.SRC_INDV_TTL3)+';','')+ 
															 if(pRight.SRC_INDV_TTL_DESC>'0',trim(pRight.SRC_INDV_TTL_DESC)+';','');
	self.cmnt_effective_date  := fn_past_date(pRight.CMNT_DT);
	self.description 		      := if(pRight.SRC_INDV_NME>'',trim(pRight.SRC_INDV_NME,right)+';','')+
															 if(title>'0',trim(title),'')+
															 if(pRight.SRC_BUS_NME>'',trim(pRight.SRC_BUS_NME)+';','')+
															 if(pRight.CMNT_DESC>'',trim(pRight.CMNT_DESC)+';','')    + pRight.TXT ;
	self					            := pLeft;

END;

layout_collateral tproject(dCollateral	 pLeft) :=TRANSFORM
	self.collateral_desc		 := if(pLeft.COLL>'',trim(pLeft.COLL)+' ',StringLib.StringToLowerCase(pLeft.COLL_DESC))+
															if(pLeft.COLL_PRQUAL>'',trim(pLeft.COLL_PRQUAL)+' ','')+
															if(pLeft.COLL_POQUAL>'',trim(pLeft.COLL_POQUAL)+' ','')+
															if(pLeft.COLL>'',StringLib.StringToLowerCase(pLeft.COLL_DESC),'');
	self.rmsid               := pLeft.F_FING_ENTY_ID;
	self        		         := pleft;
End;

layout_collateral tRollupDuplicates(layout_collateral pLeft,  layout_collateral pRight) :=TRANSFORM
	self.collateral_desc  := trim(pleft.collateral_desc)+';'+trim(pRight.collateral_desc);
	self        		      := pleft;
End;

layout_collateral  TCollateral(layout_collateral pLeft,dCollateralItem pRight) :=TRANSFORM
	self.prim_machine	 	   := pRight.MACH_PRIM;
	self.sec_machine       := pRight.MACH_SECDY;
	self.manufacturer_code := pRight.MFR_CD;
	self.manufacturer_name := pRight.MFR_NAME;
	self.model			     	 := pRight.MODEL;
	self.model_year			   := pRight.MODEL_YR;
	self.model_desc			   := pRight.MODEL_DESC;
	self.collateral_count	 := pRight.COLL_ITEM_QTY;
	self.manufactured_year := pRight.YR_MFD;
	self.new_used		       := pRight.NEW_USED_INDC;
	self.serial_number		 := pRight.SER_NBR;
	self			         		 := pleft;
END; 

dAddJurisdiction  := join(dFinancingStatement,dJurisidiction ,
												  if(left.FILG_OFC_DUNS_NBR[1]='0',left.FILG_OFC_DUNS_NBR[2..9],left.FILG_OFC_DUNS_NBR)=right.FILG_OFC_DUNS_NBR,
												  Trans_add_Jurisdiction(left,right),
												  lookup,left outer,local);	
												 
dsortSigner			  := distribute(dedup(dSigner,except process_date, ALL),
															  hash(F_FING_ENTY_ID)
															 );

dsortStatement	  := distribute(dedup(dAddJurisdiction(~REGEXFIND('CA|MA|IL|TX',Filing_Jurisdiction)),except process_date,ALL),
															  hash(F_FING_ENTY_ID)
															 );
																			
dsortComment      := distribute(dedup(dFinancingComment,except process_date, ALL),
											          hash(F_FING_ENTY_ID)
															 );

dSortCollateral   := sort(distribute(dedup(dCollateral,except process_date, def_data_length,fing_coll_seq_nbr,ALL),
																		 hash(F_FING_ENTY_ID)
																		),
													F_FING_ENTY_ID,local
												 );
																		 
dSortCItem	   		:= distribute(dedup(dCollateralItem,except process_date, ALL),
														    hash(F_FING_ENTY_ID)
															 );

dJoinCollateral   := join(rollup(project(dSortCollateral,tproject(left)),tRollupDuplicates(left,right),rmsid), dSortCItem,
													left.rmsid=right.F_FING_ENTY_ID,
													Tcollateral(left,right),
													left outer,local);
				
daddsigner   		  := Join(dsortStatement, dsortSigner	,
													left.F_FING_ENTY_ID = Right.F_FING_ENTY_ID, 
													Trans_add_signer(left, right),
													Left outer,local);
				 
dFiling           := distribute(dedup(Join(daddsigner , dsortComment,
																					 left.Rmsid = Right.F_FING_ENTY_ID, 
																					 Trans_cmn_signer(left, right),
																					 Left outer,local
																					 ),
																      except process_date,all),
																hash(rmsid)
															 );

Layout_UCC_Common.layout_ucc_new Trans_add_collateral(dFiling pLeft, layout_collateral pRight) :=TRANSFORM
	string  filing  := IF(pLeft.orig_filing_number<>'' and pLeft.orig_filing_date<>'',pLeft.orig_filing_number+pLeft.orig_filing_date,
											  IF(pLeft.orig_filing_number<>'' ,pLeft.Filing_jurisdiction+pLeft.orig_filing_number,
													 pLeft.filing_number+pLeft.filing_date)
											  );	
	self.tmsid      := if(pLeft.duns_number='361960479', //WA state duns ?
												'CP','DNB') + TRIM(filing,all);
	self            := pLeft;
	self					  := pRight; 

END;

dAddCollateral    := Join(dFiling , distribute(dJoinCollateral,hash(rmsid)),
													left.Rmsid = Right.Rmsid, 
													Trans_add_collateral(left, right),
													Left outer,local
												 );
													 
dDedup            := dedup(distribute(dAddCollateral + Project(dFile,Trans_rollback_Rmsid(left)),hash(rmsid)),
													 except process_date,vendor_entry_date,vendor_upd_date, all, local
													);	
														
dGroup            := group(sort(distribute(ddedup,hash(tmsid,rmsid)),tmsid,rmsid,local),
													 tmsid,rmsid,local
													);
														
dMainBase         := ungroup(Project(dGroup ,Trans_Rmsid(left,(string2) counter),local));

AddRecordID       := uccv2.fnAddPersistentRecordID_Main(dMainBase);

export Proc_Build_DnB_Main_Base := AddRecordID;