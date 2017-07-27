import Business_Header, govdata, versioncontrol;

export Out_Population_Stats :=
module

	export Business_Headers :=
	module
		//left pversion in there for when we change to using versions for these files--for flexibility
	
		export CA_Sales_Tax(pversion, pOut) :=
		macro
			
			export pOut := Business_Header.fAsBusinessHeaderStats(
				 fCA_Sales_Tax_As_Business_Header(File_CA_Sales_Tax_BDID)			
				,'ST'
				,(string)versioncontrol.fGetFilenameVersion('~thor_data400::base::CA_Sales_Tax_BDID')
			);

		endmacro;
		
		export FDIC(pversion, pOut) :=
		macro
			
			export pOut := Business_Header.fAsBusinessHeaderStats(
				 fFDIC_As_Business_Header(File_FDIC_BDID)
				,'FD'
				,(string)versioncontrol.fGetFilenameVersion('~thor_Data400::base::govdata_FDIC_BDID')
			);

		endmacro;
		
		export FL_FBN(pversion, pOut) :=
		macro
			
			export pOut := Business_Header.fAsBusinessHeaderStats(
				 fFL_FBN_As_Business_Header(File_FL_FBN_In,File_FL_FBN_Events_In)
				,'FF'
				,versions.fl_fbn
			);

		endmacro;

////// DONE UP TO HERE

		export FL_Non_Profit(pversion, pOut) :=
		macro
			
			export pOut := Business_Header.fAsBusinessHeaderStats(
				 fFL_Non_Profit_As_Business_Header(File_FL_Non_Profit_Corp_In)
				,'FN'
				,versions.FL_Non_Profit
			);

		endmacro;


		export Gov_Phones(pversion, pOut) :=
		macro
			
			export pOut := Business_Header.fAsBusinessHeaderStats(
				 fGov_Phones_As_Business_Header(File_Gov_Phones_Base)
				,'ED'
				,(string)versioncontrol.fGetFilenameVersion('~thor_data400::BASE::gov_phones')
				);

		endmacro;

		export IA_Sales_Tax(pversion, pOut) :=
		macro
			
			export pOut := Business_Header.fAsBusinessHeaderStats(
				 fIA_Sales_Tax_As_Business_Header(File_IA_Sales_Tax_In)
				,'ST'
				,IA_Sales_Tax_File_Date
				);

		endmacro;

		export IRS_Non_Profit(pversion, pOut) :=
		macro
			
			export pOut := Business_Header.fAsBusinessHeaderStats(
				 fIRS_Non_Profit_As_Business_Header(File_IRS_NonProfit_Base)
				,'IN'
				,(string)versioncontrol.fGetFilenameVersion('~thor_Data400::base::IRS_NonProfit')
				);

		endmacro;

		export MS_Workers(pversion, pOut) :=
		macro
			
			export pOut := Business_Header.fAsBusinessHeaderStats(
				 govdata.fMS_Workers_As_Business_Header(File_MS_Workers_Comp_BDID)
				,'WC'
				,(string)versioncontrol.fGetFilenameVersion('~thor_data400::base::MS_Workers_Comp')
				);

		endmacro;

		export OR_Workers(pversion, pOut) :=
		macro
			
			export pOut := Business_Header.fAsBusinessHeaderStats(
				 govdata.fOR_Workers_As_Business_Header(File_OR_Workers_Comp_BDID)
				,'WC'
				,(string)versioncontrol.fGetFilenameVersion('~thor_data400::base::or_workers_comp')
				);

		endmacro;

		export SEC_Broker_Dealer(pversion, pOut) :=
		macro
			
			export pOut := Business_Header.fAsBusinessHeaderStats(
				 govdata.fSEC_Broker_Dealer_As_Business_Header(File_SEC_Broker_Dealer_BDID)
				,'SB'
				,(string)versioncontrol.fGetFilenameVersion('~thor_data400::base::SEC_Broker_Dealer')
				);

		endmacro;

		CA_Sales_Tax(		qa, CA);		
		FDIC(				qa, FD);
		FL_FBN(				qa, FB);	
		FL_Non_Profit(		qa, FN);
		Gov_Phones(			qa, GP);
		IA_Sales_Tax(		qa, IA);
		IRS_Non_Profit(		qa, IR);
		MS_Workers(			qa, MS);
		OR_Workers(			qa, OW);
		SEC_Broker_Dealer(	qa, SE);

		
		export All :=
			parallel(
				 CA
				,FD
				,FB
				,FN
				,GP
				,IA
				,IR
				,MS
				,OW
				,SE
				 
			);

		
	end;
	export Business_Contact :=
	module
		//left pversion in there for when we change to using versions for these files--for flexibility
	
		export CA_Sales_Tax(pversion, pOut) :=
		macro
			
			export pOut := Business_Header.fAsBusinessContactStats(
				 fCA_Sales_Tax_As_Business_Contact(File_CA_Sales_Tax_BDID)			
				,'ST'
				,(string)versioncontrol.fGetFilenameVersion('~thor_data400::base::CA_Sales_Tax_BDID')
			);

		endmacro;
		
	
		export FL_FBN(pversion, pOut) :=
		macro
			
			export pOut := Business_Header.fAsBusinessContactStats(
				 fFL_FBN_As_Business_Contact(File_FL_FBN_In,File_FL_FBN_Events_In)
				,'FF'
				,versions.fl_fbn
			);

		endmacro;

////// DONE UP TO HERE

		export FL_Non_Profit(pversion, pOut) :=
		macro
			
			export pOut := Business_Header.fAsBusinessContactStats(
				 fFL_Non_Profit_As_Business_Contact(File_FL_Non_Profit_Corp_In)
				,'FN'
				,versions.FL_Non_Profit
			);

		endmacro;


		export Gov_Phones(pversion, pOut) :=
		macro
			
			export pOut := Business_Header.fAsBusinessContactStats(
				 fGov_Phones_As_Business_Contact(File_Gov_Phones_Base)
				,'ED'
				,(string)versioncontrol.fGetFilenameVersion('~thor_data400::BASE::gov_phones')
				);

		endmacro;

		export IA_Sales_Tax(pversion, pOut) :=
		macro
			
			export pOut := Business_Header.fAsBusinessContactStats(
				 fIA_Sales_Tax_As_Business_Contact(File_IA_Sales_Tax_In)
				,'ST'
				,IA_Sales_Tax_File_Date
				);

		endmacro;

		export IRS_Non_Profit(pversion, pOut) :=
		macro
			
			export pOut := Business_Header.fAsBusinessContactStats(
				 fIRS_Non_Profit_As_Business_Contact(File_IRS_NonProfit_Base)
				,'IN'
				,(string)versioncontrol.fGetFilenameVersion('~thor_Data400::base::IRS_NonProfit')
				);

		endmacro;

		export MS_Workers(pversion, pOut) :=
		macro
			
			export pOut := Business_Header.fAsBusinessContactStats(
				 govdata.fMS_Workers_As_Business_Contact(File_MS_Workers_Comp_BDID)
				,'WC'
				,(string)versioncontrol.fGetFilenameVersion('~thor_data400::base::MS_Workers_Comp')
				);

		endmacro;

		export SEC_Broker_Dealer(pversion, pOut) :=
		macro
			
			export pOut := Business_Header.fAsBusinessContactStats(
				 govdata.fSEC_Broker_Dealer_As_Business_Contact(File_SEC_Broker_Dealer_In)
				,'SB'
				,(string)versioncontrol.fGetFilenameVersion('~thor_data400::base::SEC_Broker_Dealer')
				);

		endmacro;

		CA_Sales_Tax(		qa, CA);		
		FL_FBN(				qa, FB);	
		FL_Non_Profit(		qa, FN);
		Gov_Phones(			qa, GP);
		IA_Sales_Tax(		qa, IA);
		IRS_Non_Profit(		qa, IR);
		MS_Workers(			qa, MS);
		SEC_Broker_Dealer(	qa, SE);

		
		export All :=
			parallel(
				 CA
				,FB
				,FN
				,GP
				,IA
				,IR
				,MS
				,SE
				 
			);

		
	end;

	export All :=
		parallel(
			 Business_Headers.all
			,Business_Contact.all
		);



end;

