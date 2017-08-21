import EBR,ut;

export mapping_2015_trade_payment_totals(string filedate) := function

File_2015_trade_payment_totals := File_Sprayed_Input(segment_code = '2015');

Layout_2015_trade_payment_tmp := record
	string10	FILE_NUMBER;
	string4		SEGMENT_CODE;
	string5		SEQUENCE_NUMBER;
	string3		TRADE_COUNT1;
	string3		DEBT1;
	string1		HIGH_CREDIT_MASK1;
	string8		RECENT_HIGH_CREDIT1;
	string1		ACCOUNT_BALANCE_MASK1;
	string8		MASKED_ACCOUNT_BALANCE1;
	string3		CURRENT_BALANCE_PERCENT1;
	string3		DEBT_01_30_PERCENT1;
	string3		DEBT_31_60_PERCENT1;
	string3		DEBT_61_90_PERCENT1;
	string3		DEBT_91_PLUS_PERCENT1;
	string3		TRADE_COUNT2;
	string3		DEBT2;
	string1		HIGH_CREDIT_MASK2;
	string8		RECENT_HIGH_CREDIT2;
	string1		ACCOUNT_BALANCE_MASK2;
	string8		MASKED_ACCOUNT_BALANCE2;
	string3		CURRENT_BALANCE_PERCENT2;
	string3		DEBT_01_30_PERCENT2;
	string3		DEBT_31_60_PERCENT2;
	string3		DEBT_61_90_PERCENT2;
	string3		DEBT_91_PLUS_PERCENT2;
	string3		TRADE_COUNT3;
	string3		DEBT3;
	string1		HIGH_CREDIT_MASK3;
	string8		RECENT_HIGH_CREDIT3;
	string1		ACCOUNT_BALANCE_MASK3;
	string8		MASKED_ACCOUNT_BALANCE3;
	string3		CURRENT_BALANCE_PERCENT3;
	string3		DEBT_01_30_PERCENT3;
	string3		DEBT_31_60_PERCENT3;
	string3		DEBT_61_90_PERCENT3;
	string3		DEBT_91_PLUS_PERCENT3;
	string8		HIGHEST_CREDIT_MEDIAN;
	decimal8	ACCOUNT_BALANCE_REGULAR_TRADELINES;
	decimal8	ACCOUNT_BALANCE_NEW;
	decimal8	ACCOUNT_BALANCE_COMBINED;
	string3		AGED_TRADES_COUNT;
end;

rec := record
	string503 allcat;
end;

rec ebr_2015(File_2015_trade_payment_totals le) := transform
	self.allcat :=	le.FILE_NUMBER 					+ le.SEGMENT_CODE			+ le.SEQUENCE_NUMBER	+ le.FILLER1				+ le.EXTRACT_DATE_MDY	+ 
									le.FILE_ESTAB_DATE_MMYY	+ le.FILE_ESTAB_FLAG	+ le.COMPANY_NAME			+ le.STREET_ADDRESS	+ le.CITY 						+
									le.STATE_CODE						+ le.STATE_NAME				+ le.ZIP 							+ le.ZIP_4					+ le.PHONE_NUMBER			+
									le.SIC_CODE							+	le.BUSINESS_DESC		+	le.DISPUTE_IND			+ le.FILLER2				+	le.crlf;
end;

ebr_1000_prj := project(File_2015_trade_payment_totals,ebr_2015(LEFT));

Layout_2015_trade_payment_tmp ebr_2015_trans(ebr_1000_prj le) := transform
	self.FILE_NUMBER												:=	le.allcat[1..10];           
	self.SEGMENT_CODE												:=	le.allcat[11..14];          
	self.SEQUENCE_NUMBER										:=	le.allcat[15..19];
	self.TRADE_COUNT1												:=	le.allcat[26..28];          
	self.DEBT1															:=	le.allcat[29..31];          
	self.HIGH_CREDIT_MASK1									:=	le.allcat[32];              
	self.RECENT_HIGH_CREDIT1								:=	le.allcat[33..40];          
	self.ACCOUNT_BALANCE_MASK1							:=	le.allcat[41];              
	self.MASKED_ACCOUNT_BALANCE1						:=	le.allcat[42..49];          
	self.CURRENT_BALANCE_PERCENT1						:=	le.allcat[50..52];          
	self.DEBT_01_30_PERCENT1								:=	le.allcat[53..55];          
	self.DEBT_31_60_PERCENT1								:=	le.allcat[56..58];          
	self.DEBT_61_90_PERCENT1								:=	le.allcat[59..61];          
	self.DEBT_91_PLUS_PERCENT1							:=	le.allcat[62..64];          
	self.TRADE_COUNT2												:=	le.allcat[65..67];          
	self.DEBT2															:=	le.allcat[68..70];          
	self.HIGH_CREDIT_MASK2									:=	le.allcat[71];              
	self.RECENT_HIGH_CREDIT2								:=	le.allcat[72..79];          
	self.ACCOUNT_BALANCE_MASK2							:=	le.allcat[80];              
	self.MASKED_ACCOUNT_BALANCE2						:=	le.allcat[81..88];          
	self.CURRENT_BALANCE_PERCENT2						:=	le.allcat[89..91];          
	self.DEBT_01_30_PERCENT2								:=	le.allcat[92..94];          
	self.DEBT_31_60_PERCENT2								:=	le.allcat[95..97];          
	self.DEBT_61_90_PERCENT2								:=	le.allcat[98..100];         
	self.DEBT_91_PLUS_PERCENT2							:=	le.allcat[101..103];        
	self.TRADE_COUNT3												:=	le.allcat[104..106];        
	self.DEBT3															:=	le.allcat[107..109];        
	self.HIGH_CREDIT_MASK3									:=	le.allcat[110];             
	self.RECENT_HIGH_CREDIT3								:=	le.allcat[111..118];        
	self.ACCOUNT_BALANCE_MASK3							:=	le.allcat[119];        
	self.MASKED_ACCOUNT_BALANCE3						:=	le.allcat[120..127];      
	self.CURRENT_BALANCE_PERCENT3						:=	le.allcat[128..130];      
	self.DEBT_01_30_PERCENT3								:=	le.allcat[131..133];        
	self.DEBT_31_60_PERCENT3								:=	le.allcat[134..136];        
	self.DEBT_61_90_PERCENT3								:=	le.allcat[137..139];        
	self.DEBT_91_PLUS_PERCENT3							:=	le.allcat[140..142];        
	self.HIGHEST_CREDIT_MEDIAN							:=	le.allcat[143..150];        
	self.ACCOUNT_BALANCE_REGULAR_TRADELINES	:=	(decimal8)(le.allcat[151..158]);        
	self.ACCOUNT_BALANCE_NEW								:=	(decimal8)(le.allcat[159..166]);        
	self.ACCOUNT_BALANCE_COMBINED						:=	(decimal8)(le.allcat[167..174]);        
	self.AGED_TRADES_COUNT									:=	le.allcat[175..177];        
end;

File_2015_layout := project(ebr_1000_prj,ebr_2015_trans(LEFT));

EBR.Layout_2015_Trade_Payment_Totals_In ebr_2015_trade_payment_tr(File_2015_layout l) := transform
	self.orig_ACCOUNT_BALANCE_REGULAR_TRADELINES	:=	(string8)l.ACCOUNT_BALANCE_REGULAR_TRADELINES;
	self.orig_ACCOUNT_BALANCE_NEW									:=	(string8)l.ACCOUNT_BALANCE_NEW;
	self.orig_ACCOUNT_BALANCE_COMBINED						:=	(string8)l.ACCOUNT_BALANCE_COMBINED;
	self.account_balance_regular_tradelines				:=	((string)l.ACCOUNT_BALANCE_REGULAR_TRADELINES)[1..7];
	self.account_balance_new											:=	((string)l.ACCOUNT_BALANCE_NEW)[1..7];
	self.account_balance_combined									:=	((string)l.ACCOUNT_BALANCE_COMBINED)[1..7];
	self.process_date															:=	filedate;
	self 																					:= 	l;
	self																					:=	[];
end;

Filenm_2015_trade_payment_totals := project(File_2015_layout,ebr_2015_trade_payment_tr(LEFT));

FileName_2015_tr := '~thor_data400::in::ebr_2015_trade_payment_totals_'+filedate;

Out_File := sequential(
												FileServices.ClearSuperFile('~thor_data400::in::EBR_2015_' + trim(decode_segments('2015'))),
												output(Filenm_2015_trade_payment_totals,,FileName_2015_tr,overwrite,__compressed__)
											 );

add_file := FileServices.AddSuperFile('~thor_data400::in::EBR_2015_' + trim(decode_segments('2015')),FileName_2015_tr);

return sequential(Out_File,add_file);
end;