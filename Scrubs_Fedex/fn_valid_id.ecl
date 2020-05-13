IMPORT std;


EXPORT fn_valid_id(string st) := FUNCTION 

    RETURN If 
    (
        (st[..3] = 'FDX'
        AND std.str.FilterOut(st[4..], '0123456789') = '')
        OR st = '',
        1,
        0
    );
END;