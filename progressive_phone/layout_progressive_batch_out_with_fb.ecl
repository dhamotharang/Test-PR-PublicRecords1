EXPORT layout_progressive_batch_out_with_fb := RECORD(layout_progressive_batch_out)
	STRING8		phone_feedback_date_1;
	UNSIGNED1	phone_feedback_result_1;
	STRING20	phone_feedback_first_1;
	STRING20	phone_feedback_middle_1;
	STRING20	phone_feedback_last_1;
	STRING8		phone_feedback_last_rpc_date_1;
END;