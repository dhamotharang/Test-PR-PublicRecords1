//bug 25396 - nameasis in search would begin w/ a leading ", "

import ln_mortgage;

export fn_patch_deed(dataset(recordof(ln_mortgage.Layout_Deed_Mortgage_Common_Model_BASE)) in_deed) :=
function

recordof(in_deed) t_patch_deed(recordof(in_deed) le) := transform
 self.buyer1           := ln_property.fn_patch_name_field(le.buyer1);
 self.buyer2           := ln_property.fn_patch_name_field(le.buyer2);
 self.borrower1        := ln_property.fn_patch_name_field(le.borrower1);
 self.borrower2        := ln_property.fn_patch_name_field(le.borrower2);
 self.seller1          := ln_property.fn_patch_name_field(le.seller1);
 self.seller2          := ln_property.fn_patch_name_field(le.seller2);
 self.loan_term_months := (string)(integer)le.loan_term_months;
 self.loan_term_years  := (string)(integer)le.loan_term_years;
 self                  := le;
end;

patch_deed := project(in_deed,t_patch_deed(left));

return patch_deed;

end;