Import ut;

// Export File_AddressFeedback_Base  := dataset('~thor_data400::base::addressfeedback20130617', AddressFeedback.Layouts.Lay_AddressFeedback_base,thor);

Export File_AddressFeedback_Base  := dataset('~thor_data400::base::AddressFeedback', AddressFeedback.Layouts.Lay_AddressFeedback_base,thor);
