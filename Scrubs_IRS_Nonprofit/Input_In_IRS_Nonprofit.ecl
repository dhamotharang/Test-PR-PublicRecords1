IMPORT Data_Services;
EXPORT Input_In_IRS_Nonprofit := dataset(Data_Services.foreign_prod + 'thor_data400::in::irs::20200428::non_profit_in',Input_Layout_IRS_Nonprofit,CSV(HEADING(1),SEPARATOR(',')));