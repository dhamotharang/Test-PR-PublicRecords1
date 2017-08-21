/*2012-10-15T17:38:54Z ()
Sandboxed
*/
import ut,ebr,dnb_dmi,dcav2,edgar,yellowpages,doxie,govdata,busreg,vickers,dnb,LiensV2,InfoUSA,lib_stringlib,corp2,mdr;

export Make_Common_Subfile(

	 dataset(ebr.Layout_5600_Demographic_Data_Base	) pEbrBase 						= EBR.File_5600_Demographic_Data_Base
	,dataset(dcav2.layouts.base.companies						) pDcaBase						= DCAv2.Files().base.companies.qa
	,dataset(Edgar.Layout_Edgar_Company							) pEdgarBase					= Edgar.File_Edgar_Company_Base
	,dataset(BusReg.layouts.Base.full								) pBusregBase					= BusReg.Files().base.full.qa
	,dataset(dnb_dmi.Layouts.Base.CompaniesForBIP2 	) pDNB_Base						= DNB_dmi.Files().base.companies.qa
	,dataset(InfoUSA.Layout_ABIUS_Company_Base			) pInfoUsaBase				= InfoUSA.File_ABIUS_Company_Base
	,dataset(Layouts.Joined_JL											) pJLBase							= Marketing_Best.JoinedJL()
	,dataset(Corp2.Layout_Corporate_Direct_Corp_Base) pCorpFilteredBase		= Marketing_Best.FilteredCorp()
	,string																						pPersistname				= '~thor_data400::persist::Marketing_Best::Make_Common_Subfile'

) := 
function 


ebrBase := pEbrBase(bdid<>0);
dcaBase := pDcaBase(bdid<>0);
edgarCompanyBase := pEdgarBase(bdid<>0);

// Removed YellowPages as a result of Targus replacing Experian. Targus has marketing restrictions. 20090718 
// yellowPagesBase := YellowPages.Files.base.qa(bdid<>0);
busRegBase := pBusregBase(bdid<>0);
dnbBase := pDNB_Base(bdid <> 0);
InfoUSABase := pInfoUsaBase(bdid<>0);
JLBase := pJLBase;
corp2Base := pCorpFilteredBase;


// -----------------------------------------------
// put EBR base file in common layout 
// -----------------------------------------------
Marketing_Best.Layout_Common SlimEBR(ebrBase l) := TRANSFORM
SELF.sourceCode := MDR.sourceTools.src_EBR;

// EBR sales data is sent in thousands. It can also be negative.  Convert to whole 
// dollars & surround negative amounts in parentheses.
SELF.exactSales := if (trim(l.sales_actual,left,right) <> '' and trim(l.sales_actual,left,right)<>'0000000',
						if ((integer)l.sales_actual < 0, 
							'(' + (string)((integer)l.sales_actual * 1000) + ')',
							(string)((integer)l.sales_actual * 1000)),'');
SELF.salesMin := '';
SELF.salesMax := '';
SELF.salesWeight := 2;

SELF.sic := trim(l.sic_1_code,left,right);
SELF.sicWeight := 4;

// EBR employee count data can be either an exact amount or a range.
// If the exact amount is valid, use this vaoue, otherwise check the
// range for validity & use if valid. Ranges are split into minimum &
/// maximum values. Remove leading zeroes from exact employee counts.
SELF.exactEmplCnt := if (trim(l.empl_size_actual,left,right) <> '' and trim(l.empl_size_actual,left,right) <> '0000000',
						 (string)((integer)trim(l.empl_size_actual,left,right)),'');
SELF.emplCntMin := if (trim(l.empl_size_actual,left,right) = '' or trim(l.empl_size_actual,left,right) = '0000000',
						if (trim(l.empl_size_desc,left,right) <> '' and trim(l.empl_size_desc,left,right) <> '0000000',
							if(lib_stringlib.StringLib.StringContains(l.empl_size_desc,'-',true),
								l.empl_size_desc[1..lib_stringlib.StringLib.StringFind(l.empl_size_desc,'-', 1)-1],''),''),'');
						
SELF.emplCntMax := if (trim(l.empl_size_actual,left,right) = '' or trim(l.empl_size_actual,left,right) = '0000000',
						if (trim(l.empl_size_desc,left,right) <> '' and trim(l.empl_size_desc,left,right) <> '0000000',
							if(lib_stringlib.StringLib.StringContains(l.empl_size_desc,'-',true),
								l.empl_size_desc[lib_stringlib.StringLib.StringFind(l.empl_size_desc,'-', 1)+1],''),''),'');
SELF.emplCntType := '';
SELF.emplCntWeight := 3;

SELF.taxLienAmount := '0';
SELF.taxLienTMSID := '';

SELF.orgType := if (trim(l.bus_type_desc,left,right)<>'',
					trim(l.bus_type_desc,left,right),
					'');
SELF.orgTypeweight := 2;

SELF.updateDate := trim(l.date_last_seen,left,right);
SELF := l;
END;

Slim_EBR := PROJECT(ebrBase, SlimEBR(LEFT));

// -----------------------------------------------
// put DCA base file in common layout 
// -----------------------------------------------
Marketing_Best.Layout_Common SlimDCA(dcaBase l) := TRANSFORM
SELF.sourceCode := MDR.sourceTools.src_DCA;

// DCA sales data is either identified as sales or revenues. Accept only 
// those values identified as sales. Check for negative values & 
// surround by parenthses if negative.
SELF.exactSales := if (trim(l.rawfields.sales_desc,left,right)='sales',
						if((integer)trim(l.rawfields.sales,left,right) < 0,
							'(' + trim(l.rawfields.sales,left,right) + ')',
							trim(l.rawfields.sales,left,right)),
						'');
SELF.salesMin := '';
SELF.salesMax := '';
SELF.salesWeight := 1;

SELF.sic := trim(l.rawfields.sic1,left,right);
SELF.sicWeight := 3;

SELF.exactEmplCnt := trim(l.rawfields.emp_num,left,right);
SELF.emplCntMin := '';
SELF.emplCntMax := '';
SELF.emplCntType := '';
SELF.emplCntWeight := 2;

SELF.taxLienAmount := '';
SELF.taxLienTMSID := '';

SELF.orgType := '';
SELF.orgTypeWeight := 0;

SELF.updateDate := trim(l.rawfields.update_date,left,right);
SELF := l;
END;

Slim_DCA := PROJECT(dcaBase, SlimDCA(LEFT));
			

// -----------------------------------------------
// put EDGAR Company base file in common layout 
// -----------------------------------------------
Marketing_Best.Layout_Common SlimEDGARCompany(edgarCompanyBase l) := TRANSFORM
SELF.sourceCode := MDR.sourceTools.src_Edgar;

SELF.exactSales := '';
SELF.salesMin := '';
SELF.salesMax := '';
SELF.salesWeight := 0;

SELF.sic := trim(l.sicCode,left,right);
SELF.sicWeight := 2;

SELF.exactEmplCnt := '';
SELF.emplCntMin := '';
SELF.emplCntMax := '';
SELF.emplCntType := '';
SELF.emplCntWeight := 0;

SELF.taxLienAmount := '';
SELF.taxLienTMSID := '';

SELF.orgType := '';
SELF.orgTypeWeight := 0;

SELF.updateDate := trim(l.fiscalyear,left,right);
SELF := l;
END;

Slim_EDGAR_Company := PROJECT(edgarCompanyBase, SlimEDGARCompany(LEFT));

// -----------------------------------------------
// put BusReg base file in common layout 
// -----------------------------------------------
Marketing_Best.Layout_Common SlimBusReg(busregBase l) := TRANSFORM
SELF.sourceCode := MDR.sourceTools.src_Business_Registration;

SELF.exactSales := '';
SELF.salesMin := '';
SELF.salesMax := '';
SELF.salesWeight := 0;

SELF.sic := trim(l.rawfields.SIC,left,right);
SELF.sicWeight := 5;

SELF.exactEmplCnt := trim(l.rawfields.EMP_SIZE,left,right);
SELF.emplCntMin := '';
SELF.emplCntMax := '';
SELF.emplCntType := '';
SELF.emplCntWeight := 1;

SELF.taxLienAmount := '';
SELF.taxLienTMSID := '';

SELF.orgType := case(trim(l.rawfields.SOS_CODE,left,right),
						'AN' 	=> 'ASSUMED NAME',
						'CP' 	=> 'CORPORATION',
						'DB' 	=> 'DBA NAME',
						'FN' 	=> 'FICTIOUS NAME',
						'FP' 	=> 'FOR PROFIT',
						'LLC' 	=> 'LIMITED LIABILITY COMPANY',
						'LLP' 	=> 'LIMITED LIABILITY PARTNERSHIP',
						'LP' 	=> 'LIMITED PARTNER',
						'NP' 	=> 'NON PROFIT',
						'PCP'	=> 'PROFESSIONAL CORPORATION',
						'PLLC'  => 'PROFESSIONAL LLC',
						'PLLP'  => 'PROFESSIONAL LLP',
						'RCP'  	=> 'RESERVED CORPORATION',
						'RNP'  	=> 'RESERVED NON PROFIT',
						'RLLC'  => 'RESERVED LLC',
						'RLLP'  => 'RESERVED LLP',
						'RLP'  	=> 'RESERVED LP',
						'SP'	=> 'SOLE PRIOPRIOTOR',
						'');
SELF.orgTypeWeight := 1;

SELF.updateDate := trim((string)l.record_date,left,right);
SELF := l;
END;

Slim_BusReg := PROJECT(busregBase, SlimBusReg(LEFT));

//-----------------------------------------------
//put D&B base file in common layout 
//-----------------------------------------------
Marketing_Best.Layout_Common SlimDNB(dnbBase l) := TRANSFORM
SELF.sourceCode := MDR.sourceTools.src_Dunn_Bradstreet;

// D&B sales data has a sign field associated with it. Check for this sign to be negative.
// If this sign is negative or the sales volume is negative, surround the data in parentheses.
SELF.exactSales := if (trim(l.rawfields.annual_sales_volume,left,right)<>'',
						if ((integer)trim(l.rawfields.annual_sales_volume,left,right)<0 or trim(l.rawfields.annual_sales_volume_sign,left,right) = '-',
							'(' + trim(l.rawfields.annual_sales_volume,left,right) + '0',
							trim(l.rawfields.annual_sales_volume,left,right)),
						'');
SELF.salesMin := '';
SELF.salesMax := '';
SELF.salesWeight := 4;

SELF.sic := trim(l.rawfields.sic1,left,right);
SELF.sicWeight := 1;

SELF.exactEmplCnt := trim(l.rawfields.employees_here,left,right);
SELF.emplCntMin := '';
SELF.emplCntMax := '';
SELF.emplCntType := 'LOCATION';
SELF.emplCntWeight := 6;

SELF.taxLienAmount := '';
SELF.taxLienTMSID := '';

SELF.orgType := '';
SELF.orgTypeWeight := 0;

SELF.updateDate := trim(l.rawfields.report_date,left,right);
SELF := l;
END;

Slim_DNB := PROJECT(dnbBase, SlimDNB(LEFT));


// -----------------------------------------------
// put J&L Joined file in common layout 
// -----------------------------------------------
Marketing_Best.Layout_Common SlimJL(JLBase l) := TRANSFORM
SELF.sourceCode := MDR.sourceTools.src_Liens_and_Judgments;

SELF.exactSales := '';
SELF.salesMin := '';
SELF.salesMax := '';
SELF.salesWeight := 0;

SELF.sic := '';
SELF.sicWeight := 0;

SELF.exactEmplCnt := '';
SELF.emplCntMin := '';
SELF.emplCntMax := '';
SELF.emplCntType := '';
SELF.emplCntWeight := 0;

SELF.taxLienAmount := l.amount;
SELF.taxLienTMSID := l.tmsid;

SELF.orgType := '';
SELF.orgTypeweight := 0;

SELF.updateDate := trim(l.filing_date,left,right);
SELF.bdid := (integer)l.bdid;
END;

Slim_JL := PROJECT(JLBase, SlimJL(LEFT));

// -----------------------------------------------
// put InfoUSA base file in common layout 
// -----------------------------------------------
Marketing_Best.Layout_Common SlimInfoUSA(InfoUSABase l) := TRANSFORM
SELF.sourceCode := MDR.sourceTools.src_Infousa_abius_usabiz;

// InfoUSA sales data is a coded value. These codes explode to minimum & maximum 
// range values. 
SELF.exactSales := '';
SELF.salesMin := case(trim(l.SALES_VOLUME_CD,left,right),
						'A' => '1',
						'B' => '500',
						'C' => '1,000',
						'D' => '2,500',
						'E' => '5,000',
						'F' => '10,000',
						'G' => '20,000',
						'H' => '50,000',
						'I' => '100,000',
						'J' => '500,000',
						'K' => '1,000,000',
						'');
					 
SELF.salesMax := case(trim(l.SALES_VOLUME_CD,left,right),
						'A' => '499',
						'B' => '999',
						'C' => '2,499',
						'D' => '4,999',
						'E' => '9,999',
						'F' => '19,999',
						'G' => '49,999',
						'H' => '99,999',
						'I' => '499,999',
						'J' => '999,999',
						'K' => '+',
						'');
SELF.salesWeight := 3;

SELF.sic := trim(l.sic_cd,left,right)[1..4];
SELF.sicWeight := 7;

// InfoUSA employee count data is a coded value. These codes explode to minimum 
// & maximum range values.
SELF.exactEmplCnt := '';
SELF.emplCntMin := case(trim(l.EMPLOYEE_SIZE_CD,left,right),
						'A' => '1',
						'B' => '5',
						'C' => '10',
						'D' => '20',
						'E' => '50',
						'F' => '100',
						'G' => '250',
						'H' => '500',
						'I' => '1,000',
						'J' => '5,000',
						'K' => '10,000',
						'');
SELF.emplCntMax := case(trim(l.EMPLOYEE_SIZE_CD,left,right),
						'A' => '4',
					    'B' => '9',
						'C' => '19',
						'D' => '49',
					   	'E' => '99',
						'F' => '249',
						'G' => '499',
						'H' => '999',
						'I' => '4,999',
					   	'J' => '9,999',
					   	'K' => '+',
						'');
SELF.emplCntType := 'LOCATION';
SELF.emplCntWeight := 5;

SELF.taxLienAmount := '0';
SELF.taxLienTMSID := '';


SELF.orgType := '';
SELF.orgTypeweight := 0;

SELF.updateDate := trim(l.DATE_ADDED,left,right) + '01';
SELF := l;
END;

Slim_InfoUSA := PROJECT(InfoUSABase, SlimInfoUSA(LEFT));

// -----------------------------------------------
// put Corp2 base file in common layout 
// -----------------------------------------------
Marketing_Best.Layout_Common SlimCorp2(corp2Base l) := TRANSFORM
SELF.sourceCode := MDR.sourceTools.fCorpV2(l.corp_key, l.corp_state_origin);

SELF.exactSales := '';
SELF.salesMin := '';
SELF.salesMax := '';
SELF.salesWeight := 0;

SELF.sic := '';
SELF.sicWeight := 0;

SELF.exactEmplCnt := '';
SELF.emplCntMin := '';
SELF.emplCntMax := '';
SELF.emplCntType := '';
SELF.emplCntWeight := 0;

SELF.taxLienAmount := '';
SELF.taxLienTMSID := '';

SELF.orgType := trim(l.corp_orig_org_structure_desc,left,right);
SELF.orgTypeWeight := 3;

SELF.updateDate := trim(l.corp_process_date,left,right);
SELF := l;
END;

Slim_Corp2 := PROJECT(corp2Base, SlimCorp2(LEFT));

file_All_common := 	slim_EBR +
					slim_DCA +
					slim_EDGAR_Company +
					// Removed YellowPages as a result of Targus replacing Experian. Targus has marketing restrictions. 20090718 
					// slim_YellowPages +
					slim_BusReg +
					slim_DNB +
					Slim_InfoUSA +
					slim_JL +
					slim_Corp2
					;
				   
sorted_common := dedup(SORT(file_All_common, bdid, -updateDate),RECORD,ALL) : persist(pPersistname);

return sorted_common;

end;