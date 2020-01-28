IMPORT std;

EXPORT fn_valid_SSN(string ssn) := function

    string sn := trim(ssn,left,right);
    string s := std.str.findreplace(sn,'-','');
    boolean validssn := length(s)=9 and std.str.filterout(s[..9],'0123456789xX') = '';

    return if(s = '' or validssn,1,0);

end;