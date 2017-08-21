import _Validate;
EXPORT IsValidDate(string date) := _Validate.Date_New(1991,2100).fIsValid(date);