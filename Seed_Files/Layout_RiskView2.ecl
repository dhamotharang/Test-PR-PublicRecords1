﻿IMPORT riskview;

CountForDatasets := 2;
//Liens for layout - define up to 2
		#DECLARE(Liens);
		#DECLARE(cntLiens);
		
		#SET(Liens,'');
		#SET(cntLiens,1);
		
		#LOOP
			#IF(%cntLiens% > CountForDatasets)
				#BREAK;
			#ELSE
				#APPEND(Liens,
            'string30 Liens' + %'cntLiens'% + '_Seq;' +
            'STRING8 Liens' + %'cntLiens'% + '_DateFiled;' +
            'string2 Liens' + %'cntLiens'% + '_LienTypeID;' +
            'string50 Liens' + %'cntLiens'% + '_LienType;' +
            'string15 Liens' + %'cntLiens'% + '_Amount;'+ 
            'STRING8 Liens' + %'cntLiens'% + '_ReleaseDate;' +
            'STRING8 Liens' + %'cntLiens'% + '_DateLastSeen;' +
            'STRING120 Liens' + %'cntLiens'% + '_Defendant;' +
            'string10 Liens' + %'cntLiens'% + '_StreetNumber;' +
            'string2 Liens' + %'cntLiens'% + '_StreetPreDirection;' +
            'string28 Liens' + %'cntLiens'% + '_StreetName;' +
            'string4 Liens' + %'cntLiens'% + '_StreetSuffix;' +
            'string2 Liens' + %'cntLiens'% + '_StreetPostDirection;' +
            'string10 Liens' + %'cntLiens'% + '_UnitDesignation;' +
            'string8 Liens' + %'cntLiens'% + '_UnitNumber;' +
            'string60 Liens' + %'cntLiens'% + '_StreetAddress1;' +
            'string60 Liens' + %'cntLiens'% + '_StreetAddress2;' +
            'string25 Liens' + %'cntLiens'% + '_City;' +
            'string2 Liens' + %'cntLiens'% + '_State;' +
            'string5 Liens' + %'cntLiens'% + '_Zip5;' +
            'string4 Liens' + %'cntLiens'% + '_Zip4;' +
            'string18 Liens' + %'cntLiens'% + '_County;' +
            'string9 Liens' + %'cntLiens'% + '_PostalCode;' +
            'string50 Liens' + %'cntLiens'% + '_StateCityZip;' +
            'string20 Liens' + %'cntLiens'% + '_FilingNumber;'+ 
            'string10 Liens' + %'cntLiens'% + '_FilingBook;'+ 
            'STRING10 Liens' + %'cntLiens'% + '_FilingPage;' +
            'STRING7 Liens' + %'cntLiens'% + '_AgencyID;' +
            'STRING60 Liens' + %'cntLiens'% + '_Agency;' +
            'string35 Liens' + %'cntLiens'% + '_AgencyCounty;' +
            'string2 Liens' + %'cntLiens'% + '_AgencyState;' +
            'unsigned Liens' + %'cntLiens'% + '_ConsumerStatementId;');
								
				#SET(cntLiens,%cntLiens% + 1)
			#END
		#END		
//Judgments for layout - define up to 2
		#DECLARE(Jgmts);
		#DECLARE(cntJgmts);
		
		#SET(Jgmts,'');
		#SET(cntJgmts,1);
		
		#LOOP
			#IF(%cntJgmts% > CountForDatasets)
				#BREAK;
			#ELSE
				#APPEND(Jgmts,
            'string30 Jgmts' + %'cntJgmts'% + '_Seq;' +
            'STRING8 Jgmts' + %'cntJgmts'% + '_DateFiled;' +
            'string2 Jgmts' + %'cntJgmts'% + '_JudgmentTypeID;' +
            'string50 Jgmts' + %'cntJgmts'% + '_JudgmentType;' +
            'string15 Jgmts' + %'cntJgmts'% + '_Amount;'+ 
            'STRING8 Jgmts' + %'cntJgmts'% + '_ReleaseDate;' +
            'string16 Jgmts' + %'cntJgmts'% + '_FilingDescription;' +
            'STRING8 Jgmts' + %'cntJgmts'% + '_DateLastSeen;' +
            'string120 Jgmts' + %'cntJgmts'% + '_Defendant;' +
            'string10 Jgmts' + %'cntJgmts'% + '_StreetNumber;' +
            'string2 Jgmts' + %'cntJgmts'% + '_StreetPreDirection;' +
            'string28 Jgmts' + %'cntJgmts'% + '_StreetName;' +
            'string4 Jgmts' + %'cntJgmts'% + '_StreetSuffix;' +
            'string2 Jgmts' + %'cntJgmts'% + '_StreetPostDirection;' +
            'string10 Jgmts' + %'cntJgmts'% + '_UnitDesignation;' +
            'string8 Jgmts' + %'cntJgmts'% + '_UnitNumber;' +
            'string60 Jgmts' + %'cntJgmts'% + '_StreetAddress1;' +
            'string60 Jgmts' + %'cntJgmts'% + '_StreetAddress2;' +
            'string25 Jgmts' + %'cntJgmts'% + '_City;' +
            'string2 Jgmts' + %'cntJgmts'% + '_State;' +
            'string5 Jgmts' + %'cntJgmts'% + '_Zip5;' +
            'string4 Jgmts' + %'cntJgmts'% + '_Zip4;' +
            'string18 Jgmts' + %'cntJgmts'% + '_County;' +
            'string9 Jgmts' + %'cntJgmts'% + '_PostalCode;' +
            'string50 Jgmts' + %'cntJgmts'% + '_StateCityZip;' +
            'string120 Jgmts' + %'cntJgmts'% + '_Plaintiff;' +
            'string20 Jgmts' + %'cntJgmts'% + '_FilingNumber;'+ 
            'string10 Jgmts' + %'cntJgmts'% + '_FilingBook;'+ 
            'STRING10 Jgmts' + %'cntJgmts'% + '_FilingPage;' +
            'STRING1 Jgmts' + %'cntJgmts'% + '_Eviction;' +
            'STRING7 Jgmts' + %'cntJgmts'% + '_AgencyID;' +
            'STRING60 Jgmts' + %'cntJgmts'% + '_Agency;' +
            'string35 Jgmts' + %'cntJgmts'% + '_AgencyCounty;' +
            'string2 Jgmts' + %'cntJgmts'% + '_AgencyState;' +	
            'unsigned Jgmts' + %'cntJgmts'% + '_ConsumerStatementId;');
      
				#SET(cntJgmts,%cntJgmts% + 1)
			#END
		#END

layout_riskview_lnj_batch := record
	%Liens%
	%Jgmts%
end;

layout_riskview5_batch_response_slimmed := record
	string30 acctno;
	RiskView.Layouts.layout_riskview5;
  string5  Exception_code := '';
	string3	 Billing_Index2 := '';
end;

Layout_ConsumerStatement := RECORD	
	string16 CS_UniqueId := '';
	integer2 CS_Year := 0 ;
	integer2 CS_Month := 0 ;
	integer2 CS_Day := 0 ;
	integer2 CS_Hour24  := 0 ;
	integer2 CS_Minute := 0;
	integer2 CS_Second  := 0;
	unsigned CS_StatementId := '';
	string5 CS_StatementType := '';
	string50 CS_DataGroup := '';
	string3000 CS_Content := '';
	
	string16 CS2_UniqueId := '';
	integer2 CS2_Year := 0 ;
	integer2 CS2_Month := 0 ;
	integer2 CS2_Day := 0 ;
	integer2 CS2_Hour24  := 0 ;
	integer2 CS2_Minute := 0;
	integer2 CS2_Second  := 0;
	unsigned CS2_StatementId := '';
	string5 CS2_StatementType := '';
	string50 CS2_DataGroup := '';
	string3000 CS2_Content := '';
end;



export Layout_RiskView2 := RECORD
	STRING32 TestDataTableName := '';
	STRING30 AccountNumber := '';
	STRING30 Name_First := '';
	STRING30 Name_Last := '';
	STRING65 Address := '';
	STRING25 City := '';
	STRING2 State := '';
	STRING5 Zip5 := '';
	STRING9 SSN := '';
	STRING10 Home_Phone := '';
	STRING30 TransactionID := '';


// Model Testseed Fields
	// riskview.layouts.layout_riskview5_batch_response; has 99 and we only need 2
	layout_riskview5_batch_response_slimmed -consumerstatementtext;
	layout_riskview_lnj_batch;
	Layout_ConsumerStatement;
	
	END;


