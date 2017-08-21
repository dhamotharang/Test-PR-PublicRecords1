import address, did_add, didville,ut,header_slimsort,UCCV2,business_header,Business_Header_SS;

//NYC Source Data 
dMaster	 			          := File_NYC_Filing_Master_in(~REGEXFIND('LIEN',doc_type));
dUcc3      	 			 	  := File_NYC_Ref_in;
dRemark                       := File_NYC_Remark_in;
dCollateral                   := sort(File_NYC_Lot_in,Unique_Key);
dFile                         := File_NYC_MAin_Base;

Layout_UCC_Common.Layout_UCC_new TFiling(dMaster pLeft, dUcc3 pRight) 
   := 
   TRANSFORM
     string16   tmsid         := if(pLeft.file_nbr!=pRight.ref_file_nbr and pRight.ref_file_nbr>'',
	                                pRight.ref_file_nbr,if(pLeft.file_nbr!=pRight.doc_id_ref and pRight.doc_id_ref>'',
								    pRight.doc_id_ref,if(pLeft.filing_number=pRight.crfn,'',pRight.crfn)));   
//Following changes made on Feb. 16 to fix bug #22890 Jenny
	 string16   filing_number := if(pLeft.unique_key[1..2]='FT' , pLeft.file_nbr,pLeft.filing_number);
	 Boolean    Orig_indc     := REGEXFIND('^F|^I|BOND',pLeft.doc_type );
	 self.rmsid 			  := pLeft.unique_key;
	 self.tmsid               := if(Orig_indc or tmsid='','NYC'+filing_number,'NYC'+tmsid);
	 self.Filing_Jurisdiction := 'NYC';
	 self.orig_filing_number  := if(Orig_indc,filing_number,tmsid);
	 self.orig_filing_type    := if(Orig_indc, pLeft.doc_type,'') ;
	 self.orig_filing_date    := if(Orig_indc, pLeft.filing_date,'') ;
	 self.filing_number		  := filing_number;// #22890  Jenny
	 self.filing_type		  := if(Orig_indc,'', pLeft.doc_type) ;
	 self.filing_date		  := if(Orig_indc,'', pLeft.filing_date) ;
	 self.amount			  := if(stringlib.stringfilterout(pLeft.Document_amt,'0')='.','',pLeft.Document_amt);
	 self.irs_serial_number   := pLeft.Fedtax_serial_nbr;
	 self.effective_date      := pLeft.Fedtax_assess_date;
	 self.collateral_desc     := pLeft.Ucc_collateral;
	 self.date_vendor_changed := pLeft.Modified_date;
	 self			          := pleft;
   END; 

recordof(dRemark) tRollupDuplicates(dRemark pLeft,  dRemark pRight)
  :=
   TRANSFORM
	 self.text 			      := trim(pleft.text)+';'+trim(pRight.text);
	 self        		      := pleft;
	End;
			 
recordof(dUCC3) tRollipDupe(dUCC3 pLeft, dUCC3 pRight) 
   :=
   TRANSFORM
	 self.ref_file_nbr	      := trim(pLeft.ref_file_nbr)+trim(pRight.ref_file_nbr);
	 self.doc_id_ref	      := trim(pLeft.doc_id_ref)+trim(pRight.doc_id_ref);
	 self.crfn      	      := trim(pLeft.crfn)+trim(pRight.crfn);
	 self        		      := pLeft;
	End;			 
Layout_UCC_Common.Layout_UCC_new TDesc(Layout_UCC_Common.Layout_UCC_new pLeft, dRemark pRight) 
   := 
   TRANSFORM
   
     self.description		  := pRight.text;
	 self					  := pLeft;  
   
   END;
   
Layout_UCC_Common.Layout_UCC_new TCollateral(Layout_UCC_Common.Layout_UCC_new pLeft, dCollateral  pRight) 
   := 
   TRANSFORM
			 
	 self.Property_desC  	  := pRight.property_type;
	 self.borough        	  := pRight.borough; 
	 self.block          	  := pRight.Block;
	 self.lot            	  := pRight.Lot; 
	 self.Collateral_address  := trim(pRight.Street_number)+' '+trim(pRight.street_name)+' '+trim(pRight.addr_unit);
	 self.air_rights_indc     := pRight.air_rights;
	 self.subterranean_rights_indc:= pRight.subterranean_rights;
	 self.easment_indc   	  := pRight.easement;
	 self.TMSID               := if(pleft.tmsid='NYC','NYC'+stringlib.StringToUpperCase(pLeft.rmsid),
	                                 stringlib.StringToUpperCase(pLeft.tmsid));//fixed bug #22890
	 self.filing_number       := stringlib.StringToUpperCase(pLeft.filing_number);
	 self.orig_filing_number  := stringlib.StringToUpperCase(pLeft.orig_filing_number);
	 self				      := pLeft;
   
   END;	

 	 
dSortMaster                   := sort(distribute(dedup(dMaster,all),hash(Unique_Key)),Unique_Key,local);
dSortUCC3	   				  := sort(distribute(dedup(dUCC3,all),hash(Unique_Key)),Unique_Key,local);
dsortRemark                   := sort(distribute(dedup(dRemark,all),hash(Unique_Key)),Unique_Key,local);
dsortlot                      := sort(distribute(dedup(dcollateral,all),hash(Unique_Key)),Unique_Key,local);

dJoinF                        := join(dSortMaster,
								  	  rollup(dSortUCC3,tRollipDupe(left,right),Unique_Key,local),
									  left.Unique_Key=right.Unique_Key ,
								      TFiling(left,right),
									  left outer,local);
									
dJoinDesc  				      := join(sort(distribute(dJoinF ,hash(rmsid)),rmsid,local),
								      rollup(dsortRemark ,tRollupDuplicates(left,right),Unique_Key,local),
									  left.rmsid=right.Unique_Key ,
								      TDesc(left,right),
									  left outer);
									  
dAddcollateral                := join(dJoinDesc ,
								      dCollateral,
									  left.rmsid=right.Unique_Key ,
								      TCollateral(left,right),
									  left outer);
									  
Outmain  					  := dedup(dJoinF+dfile,except process_date,all);
AddRecordID := uccv2.fnAddPersistentRecordID_Main(Outmain);

export proc_build_NYC_main_base      := AddRecordID;


