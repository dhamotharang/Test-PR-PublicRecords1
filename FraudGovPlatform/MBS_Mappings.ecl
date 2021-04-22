import FraudGovPlatform;
MBSMappings         := FraudGovPlatform.Files().CustomerMappings;
MBS                 := FraudGovPlatform.Files().Input.MBS.Sprayed;

J_Mappings          := join (MBS, MBSMappings, left.fdn_file_info_id = right.fdn_file_info_id,
transform({unsigned6 fdn_file_info_id, string20 contribution_source, string contribution_gc_id,integer8 contribution_billing_id, unsigned6 Customer_ID, string2 Customer_State, string Customer_Agency_Vertical_Type, string1 Customer_Program, unsigned3 file_type},
		self.fdn_file_info_id                   := left.fdn_file_info_id;
        self.contribution_source                := right.contribution_source;
        self.contribution_gc_id                 := right.contribution_gc_id;
		self.contribution_billing_id            := right.contribution_billing_id;
        self.Customer_ID            				:= left.gc_id;
        self.Customer_State                     := trim(StringLib.StringToUppercase(left.customer_state),left,right);
        self.Customer_Agency_Vertical_Type      := trim(StringLib.StringToUppercase(left.customer_vertical),left,right);
        self.Customer_Program                   := functions.customer_program_fn(left.ind_type);
        self.file_type                          := left.file_type
));
EXPORT MBS_Mappings := J_Mappings;
