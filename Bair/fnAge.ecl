// expected DOB format CCYYMMDD
import std;
EXPORT fnAge(unsigned4 dob) := function

	integer YYYYMMDDToDays(string pInput) :=
	 (((integer)(pInput[1..4])*365) + ((integer)(pInput[5..6])*30)+ ((integer)(pInput[7..8])));

	today := YYYYMMDDToDays((string8)std.date.today());
	IsInvalid(integer pDOB) := pDOB < 19000101 or pDOB > (unsigned)(string8)std.date.today();

	return if(IsInvalid(dob),-999,(integer)((today - YYYYMMDDToDays((string)dob)) / 365));
end;