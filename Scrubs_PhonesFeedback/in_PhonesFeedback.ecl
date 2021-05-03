import PhonesFeedback;

EXPORT in_PhonesFeedback(String filedate) := dataset(PhonesFeedback.Cluster + 'base::PhonesFeedback_'+filedate,PhonesFeedback.Layouts_PhonesFeedback.Layout_PhonesFeedback_base,thor);
