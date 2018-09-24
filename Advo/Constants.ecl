EXPORT Constants := MODULE

// DF-21511 specify fields to be deprecated in thor_data400::key::advo::fcra::qa::addr_search1 and thor_data400::key::advo::fcra::qa::addr_search1_history
EXPORT fields_to_clear := 'college_end_suppression_date,college_start_suppression_date,seasonal_end_suppression_date,seasonal_start_suppression_date';

END;
