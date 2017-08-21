import Address, Data_Services, ut, lib_stringlib,codes, _Control, business_header,_Validate, idl_header;
///////////////////////////////////////////////////////////////////////////////////
//
///////////////////////////////////////////////////////////////////////////////////

export StandardizeInputFile := module
		export	trimUpper(string s) := function
			return trim(stringlib.StringToUppercase(s),left,right);
		end;

 export list2	:=['JAN','FEB','MAR','APR','MAY','JUN','JUL','AUG','SEP','OCT','NOV','DEC'];
 export	list1   :=['01','02','03','04','05','06','07','08','09','10','11','12'];
 export	list3   :=['20','19','18'];
 export Fix_Date1(string d) := function
		dd1:=lib_stringlib.StringLib.StringFind(d,';',1) ;
		dd2:=lib_stringlib.StringLib.StringFind(d,';',2) ;
		dd3:=lib_stringlib.StringLib.StringFind(d,';',3) ;

		dt1:=if(dd1=0 and length(d[1..])=7,0+d[1..],if(dd1=0 and length(d[1..])<>7,d[1..],if(dd1<>0 and length(d[1..dd1-1])=7,0+d[1..dd1-1],d[1..dd1-1])));
		dt2:=if(dd2=0 and d[9..]='','',if(dd2=0 and length(d[dd1+1..])=7,0+d[dd1+1..],if(dd2=0 and length(d[dd1+1..])<>7,d[dd1+1..],if(dd2<>0 and length(d[dd1+1..dd2-1])=7,0+d[dd1+1..dd2-1],d[dd1+1..dd2-1]))));
		dt3:=if(dd3=0 and d[18..]='','',if(dd3=0 and length(d[dd2+1..])=7,0+d[dd2+1..],if(dd3=0 and length(d[dd2+1..])<>7,d[dd2+1..],if(dd3<>0 and length(d[dd2+1..dd2+8])=7,0+d[dd2+1..dd2+8],d[dd2+1..dd2+8]))));

		    concatFields			  := if(_validate.date.fIsValid(dt1[5..8]+dt1[1..4] ),dt1[5..8]+dt1[1..4],'')+ ';'+ 
											 if(_validate.date.fIsValid(dt2[5..8]+dt2[1..4] ),dt2[5..8]+dt2[1..4],'')+ ';' +
											if(_validate.date.fIsValid(dt3[5..8]+dt3[1..4] ),dt3[5..8]+dt3[1..4],'');
				
			tempExp						:= regexreplace('[;]*$',concatFields,'',NOCASE);
			tempExp2					:= regexreplace('^[;]*',tempExp,'',NOCASE);
			
			datefix						:= regexreplace('[;]+',tempExp2,';',NOCASE);
			
	return  if(d[1..2] in list3 ,d,datefix);
   end;
 export Fix_Date2(string d) := function
  date:=StringLib.StringFindReplace(StringLib.StringFindReplace(d,', ',''),' ','');
  d1:=StringLib.StringFindReplace(date,'JAN','01');
  d2:=StringLib.StringFindReplace(d1,'FEB','02');
  d3:=StringLib.StringFindReplace(d2,'MAR','03');
  d4:=StringLib.StringFindReplace(d3,'APR','04');
  d5:=StringLib.StringFindReplace(d4,'MAY','05');
  d6:=StringLib.StringFindReplace(d5,'JUN','06');
  d7:=StringLib.StringFindReplace(d6,'JUL','07');
  d8:=StringLib.StringFindReplace(d7,'AUG','08');
  d9:=StringLib.StringFindReplace(d8,'SEP','09');
  d10:=StringLib.StringFindReplace(d9,'OCT','10');
  d11:=StringLib.StringFindReplace(d10,'NOV','11');
  d12:=StringLib.StringFindReplace(d11,'DEC','12');
	
  fixed_dt:=if (d[1..3]  not in list2 and lib_stringlib.StringLib.StringFind(d,';',1)<>0,Fix_Date1(d),
			    Fix_Date1(d12));
				
	return  fixed_dt;
   end;
   
 //Fix_Date('20020131;20020131;20020131);//Fix_Date function comes back with no change
//Fix_Date('JUL 23, 2008;FEB 10, 2003;JUN 26, 1976');//comes back with this '20080723;20030210;19760626"
//Fix_Date('03242010';//comes back with 20100324)
//Fix_Date('Not Historically Underutilized Business');//comes back with blank space
//Fix_Date('20120509');//no change
//Fix_Date('01182001;1182003'); //comes back with 20010118;20030118
//Fix_Date('OCT 3, 2001;SEP 18, 2001;AUG 13, 1997') //comes back with 20010103;20010918;19970813
//Fix_Date('10032001;09182001;08131997') //comes back with 20011003;20010918;19970813
   export Fix_Date(string d) := function
		d1		:= if(d[1..2]  in list1 and length(d)=8 and  lib_stringlib.StringLib.StringFind(d,'-',1)=0,d[5..8]+d[1..4],d);
		date	:= if(d1[1..3]  in list2 or (d1[1..3]  not in list2 and lib_stringlib.StringLib.StringFind(d1,';',1)<>0) ,Fix_Date2(d1),if( _validate.date.fIsValid(d1),d1,''));
	 return date;
   end;
   export fPreProcess(dataset(Diversity_Certification.Layouts.Input) pRawFileInput, string pversion) := function
	
	  Diversity_Certification.Layouts.base	trfDivCertFile(Diversity_Certification.Layouts.Input l)	:=	transform	
	  list:=['NONE','UNKNOWN','NONE GIVEN', 'NOT PROVIDED','N/A'];
			    self.certificateDateTo1							:=  if(l.certificateDateTo1<>'',Fix_Date(l.certificateDateTo1),'');
   				self.certificateDateTo2							:=	if(l.certificateDateTo2<>'',Fix_Date(l.certificateDateTo2),'');
   				self.certificateDateTo3							:=	if(l.certificateDateTo3<>'',Fix_Date(l.certificateDateTo3),'');
   				self.certificateDateTo4							:=	if(l.certificateDateTo4<>'',Fix_Date(l.certificateDateTo4),'');
   				self.certificateDateTo5							:=	if(l.certificateDateTo5<>'',Fix_Date(l.certificateDateTo5),'');
   				self.certificateDateTo6							:=	if(l.certificateDateTo6<>'',Fix_Date(l.certificateDateTo6),'');
   				self.certificatedatefrom1						:=	if(l.certificatedatefrom1<>'',Fix_Date(l.certificatedatefrom1),'');
   				self.certificatedatefrom2						:=	if(l.certificatedatefrom2<>'',Fix_Date(l.certificatedatefrom2),'');
   				self.certificatedatefrom3						:=	if(l.certificatedatefrom3<>'',Fix_Date(l.certificatedatefrom3),'');
   				self.certificatedatefrom4						:=	if(l.certificatedatefrom4<>'',Fix_Date(l.certificatedatefrom4),'');
   				self.certificatedatefrom5						:=	if(l.certificatedatefrom5<>'',Fix_Date(l.certificatedatefrom5),'');
   				self.certificatedatefrom6						:=	if(l.certificatedatefrom6<>'',Fix_Date(l.certificatedatefrom6),'');
   				self.completedate	     						:=  if(l.completedate<>'',Fix_Date(l.completedate),'');
   				self.dateadded 	  	     						:=	if(l.dateadded<>'',	Fix_Date(l.dateadded),'');
   				self.dateupdated	    						:=	if(l.dateupdated<>'',	Fix_Date(l.dateupdated),'');
   				self.profilelastupdated  						:=	if(l.profilelastupdated<>'',	Fix_Date(l.profilelastupdated),'');
   				self.dateestablished 							:=	if(l.dateestablished<>'',	Fix_Date(l.dateestablished),'');
   				self.expirationdate								:=	if(l.expirationdate<>'',	Fix_Date(l.expirationdate),'');
   				self.extendeddate								:=	if(l.extendeddate<>'',	Fix_Date(l.extendeddate),'');
   				self.minorityownershipdate						:=	if(l.minorityownershipdate<>'',	Fix_Date(l.minorityownershipdate),'');
   				self.renewaldate								:=	if(l.renewaldate<>'',	Fix_Date(l.renewaldate),'');
   				self.Website									:=	trimUpper(l.website);
				self.BusinessType1 						        :=	trimUpper(l.BusinessType1);
   				self.Ethnicity									:=	if (trimUpper(l.Ethnicity)in list,	'',	trimUpper(l.Ethnicity));
				self.ServiceArea								:=	trimUpper(l.ServiceArea);	
   				self.Gender										:=	if (trimUpper(l.Gender)in list,	'',trimUpper(l.Gender));
   				self.FirmLocationCounty							:=	if (trimUpper(l.FirmLocationCounty)='OUT OF STATE','',trimUpper(l.FirmLocationCounty));
				self.phone1                   					:=if(lib_stringlib.StringLib.StringFind(l.phone1,'E+',1)=0 ,l.phone1 ,'');
				self.phone2                    					:=if(lib_stringlib.StringLib.StringFind(l.phone2,'E+',1)=0 ,l.phone2 ,'');
				self.phone3                   					:=if(lib_stringlib.StringLib.StringFind(l.phone3,'E+',1)=0 ,l.phone3 ,'');
				self.cell                      					:=if(lib_stringlib.StringLib.StringFind(l.cell,'E+',1)=0 ,l.cell ,'');
				self.fax                       					:=if(lib_stringlib.StringLib.StringFind(l.fax,'E+',1)=0 ,l.fax ,'');
   				self.CertificationType1     					:=trimUpper(l.CertificationType1)	;
   				self.CertificationType2     					:=trimUpper(l.CertificationType2)	;
   				self.CertificationType3     					:=trimUpper(l.CertificationType3)	;
   				self.CertificationType4     					:=trimUpper(l.CertificationType4)	;
   				self.CertificationType5     					:=trimUpper(l.CertificationType5)	;
   				self.CertificationType6     					:=trimUpper(l.CertificationType6)	;
				self.fname										:=trimUpper(l.fname);
				self.mname										:=trimUpper(l.mname);
				self.lname										:=trimUpper(l.lname);
				self.SubClassDescription1						:=trimUpper(l.SubClassDescription1);
				self.SubClassDescription2	   					:=trimUpper(l.SubClassDescription2);
				self.SubClassDescription3	   					:=trimUpper(l.SubClassDescription3);
				self.SubClassDescription4	  					:=trimUpper(l.SubClassDescription4);
				self.SubClassDescription5	   					:=trimUpper(l.SubClassDescription5);
				self.BusinessDescription		 				:=if (trimUpper(l.BusinessDescription)in list,	'',trimUpper(l.BusinessDescription));
				self.contractornongovernment				    :=if (trimUpper(l.contractornongovernment)in list,	'',trimUpper(l.contractornongovernment));
				self.WorkCode1               					:=trimUpper(l.WorkCode1);
				self.WorkCode2               					:=trimUpper(l.WorkCode2);
				self.WorkCode3               					:=trimUpper(l.WorkCode3);
				self.WorkCode4               					:=trimUpper(l.WorkCode4);
				self.WorkCode5               					:=trimUpper(l.WorkCode5);
				self.WorkCode6               					:=trimUpper(l.WorkCode6);
				self.WorkCode7               					:=trimUpper(l.WorkCode7);
				self.WorkCode8               					:=trimUpper(l.WorkCode8);
				self.Reference1                       			:=trimUpper(l.Reference1);
				self.Reference2                       			:=trimUpper(l.Reference2);
				self.Reference3                      			:=trimUpper(l.Reference3);
				self.StarRating				 					:=trimUpper(l.StarRating);
				self.resourcedescription						:=if (trimUpper(l.resourcedescription)in list,	'',trimUpper(l.resourcedescription));
				self.Assets				 	 					:=trimUpper(l.Assets);
				self.BidDescription			 					:=trimUpper(l.BidDescription);
				self.CompetitiveAdvantage	 					:=trimUpper(l.CompetitiveAdvantage);
				self.CageCode				 					:=trimUpper(l.CageCode);
				self.CapabilitiesNarrative	 					:=if (trimUpper(l.CapabilitiesNarrative)in list,	'',trimUpper(l.CapabilitiesNarrative));
				self.classifications	 						:=if (trimUpper(l.classifications)in list,	'',trimUpper(l.classifications));
				self.keywords	 								:=if (trimUpper(l.keywords)in list,	'',trimUpper(l.keywords));
				self.IssuingAuthority	 						:=if (trimUpper(l.IssuingAuthority)in list,	'',trimUpper(l.IssuingAuthority));
				self.Category									:=trimUpper(l.Category);
				self.ChtrClass				 					:=trimUpper(l.ChtrClass);
				self.ProductDescription1	 					:=trimUpper(l.ProductDescription1);
				self.ProductDescription2				 		:=trimUpper(l.ProductDescription2);
				self.ProductDescription3				 		:=trimUpper(l.ProductDescription3);
				self.ProductDescription4				 		:=trimUpper(l.ProductDescription4);
				self.ProductDescription5				 		:=trimUpper(l.ProductDescription5);
				self.ClassDescription1				 			:=trimUpper(l.ClassDescription1);
				self.ProcurementCategory1				 		:=trimUpper(l.ProcurementCategory1);
				self.ProcurementCategory2				 		:=trimUpper(l.ProcurementCategory2);
				self.ProcurementCategory3				 		:=trimUpper(l.ProcurementCategory3);
				self.ProcurementCategory4				 		:=trimUpper(l.ProcurementCategory4);
				self.ProcurementCategory5				 		:=trimUpper(l.ProcurementCategory5);
				self.certificatestatus1				 			:=if(trimUpper(l.certificatestatus1) in list,'',trimUpper(l.certificatestatus1));
				self.certificatestatus2				 			:=if(trimUpper(l.certificatestatus2) in list,'',trimUpper(l.certificatestatus2));
				self.certificatestatus3				 			:=if(trimUpper(l.certificatestatus3) in list,'',trimUpper(l.certificatestatus3));
				self.certificatestatus4				 			:=if(trimUpper(l.certificatestatus4) in list,'',trimUpper(l.certificatestatus4));
				self.certificatestatus5				 			:=if(trimUpper(l.certificatestatus5) in list,'',trimUpper(l.certificatestatus5));
				self.certificatestatus6				 			:=if(trimUpper(l.certificatestatus6) in list,'',trimUpper(l.certificatestatus6));
				self.NAICSCode1                              	:=trimUpper(l.NAICSCode1);//AlphaNumeric
				self.NAICSCode2                              	:=trimUpper(l.NAICSCode2);//AlphaNumeric
				self.NAICSCode3                              	:=trimUpper(l.NAICSCode3);//AlphaNumeric
				self.NAICSCode4                              	:=trimUpper(l.NAICSCode4);//AlphaNumeric
				self.NAICSCode5                              	:=trimUpper(l.NAICSCode5);//AlphaNumeric
				self.NAICSCode6                              	:=trimUpper(l.NAICSCode6);//AlphaNumeric
				self.NAICSCode7                              	:=trimUpper(l.NAICSCode7);//AlphaNumeric
				self.NAICSCode8                             	:=trimUpper(l.NAICSCode8);//AlphaNumeric
 				self.Exporter				 		 			:=trimUpper(l.Exporter);
				self.ExportBusinessActivities		 			:=if(trimUpper(l.ExportBusinessActivities)not in list,trimUpper(l.ExportBusinessActivities),'');
				self.ExportTo						 			:=if(trimUpper(l.ExportTo)not in list,trimUpper(l.ExportTo),'');
				self.ExportBusinessRelationships				:=if(trimUpper(l.ExportBusinessRelationships)not in list,trimUpper(l.ExportBusinessRelationships),'');
				self.ExportObjectives							:=if(trimUpper(l.ExportObjectives)not in list,trimUpper(l.ExportObjectives),'');
				self.Prequalify				 		 			:=trimUpper(l.Prequalify);
				self.SubprocurementCategory1		 			:=trimUpper(l.SubprocurementCategory1);
				self.SubprocurementCategory2		 			:=trimUpper(l.SubprocurementCategory2);
				self.SubprocurementCategory3		 			:=trimUpper(l.SubprocurementCategory3);
				self.SubprocurementCategory4		 			:=trimUpper(l.SubprocurementCategory4);
				self.SubprocurementCategory5 					:=trimUpper(l.SubprocurementCategory5);
				self.Renewal				 					:=trimUpper(l.Renewal);
				self.UnitedCertProgramPartner					:=trimUpper(l.UnitedCertProgramPartner);
				self.VendorKey									:=trimUpper(l.VendorKey);
				self.Vendornumber		 						:=trimUpper(l.Vendornumber);
   				self.dt_vendor_first_reported					:= pVersion[1..8];
   				self.dt_vendor_last_reported					:= pVersion[1..8];
   				self.dt_first_seen								:= pVersion[1..8];
   				self.dt_last_seen								:= pVersion[1..8];
   				self											:=	l;
   				self											:=	[];
   		end;
   
   		dPreProcess		:=	project(pRawFileInput, trfDivCertFile(left));
   			ut.mac_flipnames(dPreProcess,FName,MName,LName,dStandardizedName,_Dataset().max_record_size)
   		return dStandardizedName;
		end;
	 
	export fNormalizephEmail(dataset(Diversity_Certification.Layouts.base) pTempbase) := function   
	
	Diversity_Certification.Layouts.base  pNormalizephEmail(Diversity_Certification.Layouts.base l, unsigned1 cnt)	:=	transform
			
			self.phone	:= 	choose(cnt	,l.phone1,l.phone2,l.phone3);
			self.email	:= 	choose(cnt	,l.email1,l.email2,l.email3);
			self        :=	l;
																					 
	end;
		
	dphEmail			:= 	normalize(pTempbase,if(trim(left.phone3)  <>'' or 
                                         trim(left.email3)   <>'' 
										 ,3,if(trim(left.phone2)  <>'' or 
                                         trim(left.email2)   <>'',2,1)),pNormalizephEmail(left,counter));
										

   		return dphEmail;
end;

	export fStandardizeAddresses(dataset(Diversity_Certification.Layouts.base) pStandardizeNameInput) := function
	
		Diversity_Certification.Layouts.base tProjectAddress(Diversity_Certification.Layouts.base l) := transform
			self.Append_Prep_MailAddress1		:= 	StringLib.StringCleanSpaces(trim(l.Address1) + ' ' + trim(l.Address2));
			self.Append_Prep_MailAddressLast	:= 	if (l.AddressCity!='',
																									StringLib.StringCleanSpaces(trim(l.AddressCity) + ', ' + trim(l.AddressState) + ' ' + trim(l.AddressZipcode)),
																									StringLib.StringCleanSpaces(trim(l.AddressState) + ' ' + trim(l.AddressZipcode))
																								); 
			self.Append_MailRawAID				:=	0;
			self.Append_Prep_PhyAddress1		:= 	StringLib.StringCleanSpaces(trim(l.FirmLocationAddress));
			self.Append_Prep_PhyAddressLast		:= 	if (l.FirmLocationAddressCity!='',
																									StringLib.StringCleanSpaces(trim(l.FirmLocationAddressCity) + ', ' + trim(l.FirmLocationState) + ' ' + trim(l.FirmLocationAddressZipCode)),
																									StringLib.StringCleanSpaces(trim(l.FirmLocationState) + ' ' + trim(l.FirmLocationAddressZipCode))
																								); 
			self.Append_PhyRawAID				:=	0;	
			
			self								:= 	l;
		end;
      
		dAddressPrep   := project(pStandardizeNameInput, tProjectAddress(left));
      
		return dAddressPrep;
      
	end;

	export fWithTable_SIC_NAISCdesc(dataset(Diversity_Certification.Layouts.base) pStandardizeNameInput ):=function
	SIC_Lookup_TBL :=record,maxlength(500)
      		string SIC_code;
      		string desc;
      	end;
      	
       SIC_Lookup_ds    := dataset(Data_Services.foreign_prod+'thor_data50::lookup::sic_code_table',SIC_Lookup_TBL,
      																			 csv(heading(0),separator('|'),quote('"')));
     
      	
      	//Join to SIC_Lookup table to get sic_Code business description
      Diversity_Certification.Layouts.base Sic_Description1(Diversity_Certification.Layouts.base l, SIC_Lookup_TBL r ) := transform
      			self.SICCode1_desc    	:= trimUpper(r.desc); 
      			self         			:= l;
      end; 
      		
      		
       SicDesExtract1 := join(pStandardizeNameInput,SIC_Lookup_ds,
      									trim(left.SICCode1, left,right) = trim(right.SIC_code,left,right),
      									Sic_Description1(left,right),
      									lookup,left outer
      								);
									
									
		      Diversity_Certification.Layouts.base Sic_Description2(Diversity_Certification.Layouts.base l, SIC_Lookup_TBL r ) := transform
      			self.SICCode2_desc    	:= trimUpper(r.desc); 
      			self         			:= l;
      end; 
      		
      		
       SicDesExtract2 := join(SicDesExtract1,SIC_Lookup_ds,
      									trim(left.SICCode2, left,right) = trim(right.SIC_code,left,right),
      									Sic_Description2(left,right),
      									lookup,left outer
      								);	
									
 Diversity_Certification.Layouts.base Sic_Description3(Diversity_Certification.Layouts.base l, SIC_Lookup_TBL r ) := transform
      			self.SICCode3_desc    		:= trimUpper(r.desc); 
      			self         			    := l;
      end; 
      		
      		
       SicDesExtract3 := join(SicDesExtract2,SIC_Lookup_ds,
      									trim(left.SICCode3, left,right) = trim(right.SIC_code,left,right),
      									Sic_Description3(left,right),
      									lookup,left outer
      								);
	 Diversity_Certification.Layouts.base Sic_Description4(Diversity_Certification.Layouts.base l, SIC_Lookup_TBL r ) := transform
      			self.SICCode4_desc    	:= trimUpper(r.desc); 
      			self         			:= l;
      end; 
      		
      		
       SicDesExtract4 := join(SicDesExtract3,SIC_Lookup_ds,
      									trim(left.SICCode4, left,right) = trim(right.SIC_code,left,right),
      									Sic_Description4(left,right),
      									lookup,left outer
      								);
			 Diversity_Certification.Layouts.base Sic_Description5(Diversity_Certification.Layouts.base l, SIC_Lookup_TBL r ) := transform
      			self.SICCode5_desc    	:= trimUpper(r.desc); 
      			self         			:= l;
      end; 
      		
      		
       SicDesExtract5 := join(SicDesExtract4,SIC_Lookup_ds,
      									trim(left.SICCode5, left,right) = trim(right.SIC_code,left,right),
      									Sic_Description5(left,right),
      									lookup,left outer
      								);
	 Diversity_Certification.Layouts.base Sic_Description6(Diversity_Certification.Layouts.base l, SIC_Lookup_TBL r ) := transform
      			self.SICCode6_desc    	:= trimUpper(r.desc); 
      			self         			:= l;
      end; 
      		
      		
       SicDesExtract6 := join(SicDesExtract5,SIC_Lookup_ds,
      									trim(left.SICCode6, left,right) = trim(right.SIC_code,left,right),
      									Sic_Description6(left,right),
      									lookup,left outer
      								);	
		 Diversity_Certification.Layouts.base Sic_Description7(Diversity_Certification.Layouts.base l, SIC_Lookup_TBL r ) := transform
      			self.SICCode7_desc    	:= trimUpper(r.desc); 
      			self         			:= l;
      end; 
      		
      		
       SicDesExtract7 := join(SicDesExtract6,SIC_Lookup_ds,
      									trim(left.SICCode7, left,right) = trim(right.SIC_code,left,right),
      									Sic_Description7(left,right),
      									lookup,left outer
      								);
									
									
	 Diversity_Certification.Layouts.base Sic_Description8(Diversity_Certification.Layouts.base l, SIC_Lookup_TBL r ) := transform
      			self.SICCode8_desc    	:=trimUpper(r.desc); 
      			self         			:= l;
      end; 
      		
      		
       SicDesExtract8 := join(SicDesExtract7,SIC_Lookup_ds,
      									trim(left.SICCode8, left,right) = trim(right.SIC_code,left,right),
      									Sic_Description8(left,right),
      									lookup,left outer
      								);
									
	
		Diversity_Certification.Layouts.base NAICS_Description1(Diversity_Certification.Layouts.base l, Codes.File_NAICS_Codes r ) := transform
      			self.NAICSCode1_desc    	:= trimUpper(r.NAICS_Description); 
      			self         			    := l;
		end; 
      		
      		
       NAICSDesExtract1 := join(SicDesExtract8,Codes.File_NAICS_Codes,
      									trim(left.NAICSCode1[1..6], left,right) = trim(right.NAICS_Code,left,right),
      									NAICS_Description1(left,right),
      									lookup,left outer
      								);
 Diversity_Certification.Layouts.base NAICS_Description2(Diversity_Certification.Layouts.base l, Codes.File_NAICS_Codes r ) := transform
      			self.NAICSCode2_desc    	:= trimUpper(r.NAICS_Description); 
      			self         			    := l;
      end; 
      		
      		
       NAICSDesExtract2 := join(NAICSDesExtract1,Codes.File_NAICS_Codes,
      									trim(left.NAICSCode2[1..6], left,right) = trim(right.NAICS_Code,left,right),
      									NAICS_Description2(left,right),
      									lookup,left outer
      								);																	
 Diversity_Certification.Layouts.base NAICS_Description3(Diversity_Certification.Layouts.base l, Codes.File_NAICS_Codes r ) := transform
      			self.NAICSCode3_desc    	:= trimUpper(r.NAICS_Description); 
      			self         			    := l;
      end; 
      		
      		
       NAICSDesExtract3 := join(NAICSDesExtract2,Codes.File_NAICS_Codes,
      									trim(left.NAICSCode3[1..6], left,right) = trim(right.NAICS_Code,left,right),
      									NAICS_Description3(left,right),
      									lookup,left outer
      								);
 Diversity_Certification.Layouts.base NAICS_Description4(Diversity_Certification.Layouts.base l, Codes.File_NAICS_Codes r ) := transform
      			self.NAICSCode4_desc    	:= trimUpper(r.NAICS_Description); 
      			self         			    := l;
      end; 
      		
      		
       NAICSDesExtract4 := join(NAICSDesExtract3,Codes.File_NAICS_Codes,
      									trim(left.NAICSCode4[1..6], left,right) = trim(right.NAICS_Code,left,right),
      									NAICS_Description4(left,right),
      									lookup,left outer
      								);
Diversity_Certification.Layouts.base NAICS_Description5(Diversity_Certification.Layouts.base l, Codes.File_NAICS_Codes r ) := transform
      			self.NAICSCode5_desc    	:= trimUpper(r.NAICS_Description); 
      			self         			    := l;
      end; 
      		
      		
       NAICSDesExtract5 := join(NAICSDesExtract4,Codes.File_NAICS_Codes,
      									trim(left.NAICSCode5[1..6], left,right) = trim(right.NAICS_Code,left,right),
      									NAICS_Description5(left,right),
      									lookup,left outer
      								);
 Diversity_Certification.Layouts.base NAICS_Description6(Diversity_Certification.Layouts.base l, Codes.File_NAICS_Codes r ) := transform
      			self.NAICSCode6_desc    	:= trimUpper(r.NAICS_Description); 
      			self         			    := l;
      end; 
      		
      		
       NAICSDesExtract6 := join(NAICSDesExtract5,Codes.File_NAICS_Codes,
      									trim(left.NAICSCode6[1..6], left,right) = trim(right.NAICS_Code,left,right),
      									NAICS_Description6(left,right),
      									lookup,left outer
      								);
	 Diversity_Certification.Layouts.base NAICS_Description7(Diversity_Certification.Layouts.base l, Codes.File_NAICS_Codes r ) := transform
      			self.NAICSCode7_desc    	:= trimUpper(r.NAICS_Description); 
      			self         			    := l;
      end; 
      		
      		
       NAICSDesExtract7 := join(NAICSDesExtract6,Codes.File_NAICS_Codes,
      									trim(left.NAICSCode7[1..6], left,right) = trim(right.NAICS_Code,left,right),
      									NAICS_Description7(left,right),
      									lookup,left outer
      								);
 Diversity_Certification.Layouts.base NAICS_Description8(Diversity_Certification.Layouts.base l, Codes.File_NAICS_Codes r ) := transform
      			self.NAICSCode8_desc    	:= trimUpper(r.NAICS_Description); 
      			self         			    := l;
      end; 
      		
      		
       NAICSDesExtract8 := join(NAICSDesExtract7,Codes.File_NAICS_Codes,
      									trim(left.NAICSCode8[1..6], left,right) = trim(right.NAICS_Code,left,right),
      									NAICS_Description8(left,right),
      									lookup,left outer
      								);
return NAICSDesExtract8;

end;	

	

	export fAll( dataset(Diversity_Certification.Layouts.Input)  pRawFileInput, string pversion) := function
   
		dPreprocess				 := fPreProcess             (pRawFileInput,pversion);
		dStandPhEmail            := fNormalizephEmail    	(dPreprocess);
		dWithTable_SIC_NAISCdesc := fWithTable_SIC_NAISCdesc(dStandPhEmail);
		#if(_flags.UseStandardizePersists)
			dAppendBusinessInfo  := fStandardizeAddresses	(dWithTable_SIC_NAISCdesc) : persist(Persistnames.standardizeInput);
		#else
			dAppendBusinessInfo  := fStandardizeAddresses	(dWithTable_SIC_NAISCdesc);
		#end
      
		return dAppendBusinessInfo;
	
	end;
end;
