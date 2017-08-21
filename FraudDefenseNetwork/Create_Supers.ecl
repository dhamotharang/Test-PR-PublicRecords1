import tools,FraudShared;

export Create_Supers :=
	tools.mod_Utilities.createallsupers(
		filenames().Input.dAll_filenames +
		FraudShared.filenames().Input.dAll_filenames,
		filenames().dAll_filenames +
		FraudShared.filenames().dAll_filenames +
		FraudShared.keynames().dAll_filenames);