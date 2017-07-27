EXPORT TaxRefundISv3_BatchService_transforms := MODULE
	//TRANSFORM USING 2 MACROS to fill 30 sets of 14 liens and judgement output fields
 		
  EXPORT mac_fieldname(fname, inCnt) := macro
    #uniquename(fieldsymbol);
    #uniquename(fieldsymbolLEFT);
    #uniquename(fieldsymbolRIGHT);
    #set(fieldsymbol,'self.'+fname+'_'+inCnt);
    #set(fieldsymbolLEFT,'l.'+fname+'_'+inCnt);
    #set(fieldsymbolRIGHT,'r.'+fname);
	  %fieldsymbol% := if ((integer)inCnt = c, %fieldsymbolRIGHT%, %fieldsymbolLEFT%);
  ENDMACRO;				 
  
	EXPORT mac_fields(cnt) := macro
		mac_fieldname('filing_jurisdiction',cnt);
		mac_fieldname('filing_jurisdiction_name',cnt);
		mac_fieldname('orig_filing_number',cnt);
		mac_fieldname('orig_filing_type',cnt);
		mac_fieldname('orig_filing_date',cnt);
		mac_fieldname('tax_code',cnt);
		mac_fieldname('irs_serial_number',cnt);
		mac_fieldname('release_date',cnt);
		mac_fieldname('amount',cnt);
		mac_fieldname('eviction',cnt);
		mac_fieldname('judg_satisfied_date',cnt);
		mac_fieldname('judg_vacated_date',cnt);
		mac_fieldname('judge',cnt);
		mac_fieldname('filing_status',cnt);
	ENDMACRO;	

  EXPORT BatchServices.TaxRefundISv3_BatchService_Layouts.rec_batch_out xfm_30_lien(BatchServices.TaxRefundISv3_BatchService_Layouts.rec_batch_out l, 
	                                                                                  BatchServices.TaxRefundISv3_BatchService_Layouts.rec_lien r, 
																																									   INTEGER C) := TRANSFORM
   self.acctno := l.acctno;
   mac_fields('01')   
   mac_fields('02')
   mac_fields('03')
   mac_fields('04')
   mac_fields('05')
   mac_fields('06')
   mac_fields('07')
   mac_fields('08')
   mac_fields('09')
   mac_fields('10')
   mac_fields('11')   
   mac_fields('12')
   mac_fields('13')
   mac_fields('14')
   mac_fields('15')
   mac_fields('16')
   mac_fields('17')
   mac_fields('18')
   mac_fields('19')
   mac_fields('20')
   mac_fields('21')   
   mac_fields('22')
   mac_fields('23')
   mac_fields('24')
   mac_fields('25')
   mac_fields('26')
   mac_fields('27')
   mac_fields('28')
   mac_fields('29')
   mac_fields('30')
   self := l;	
	END;
	
END;	