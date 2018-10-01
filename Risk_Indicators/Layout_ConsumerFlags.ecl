export Layout_ConsumerFlags :=
RECORD
	boolean corrected_flag;
	boolean consumer_statement_flag;
	boolean dispute_flag;
	boolean security_freeze;
	boolean security_alert;
	boolean negative_alert;
	boolean id_theft_flag;
  boolean legal_hold_alert;
END;