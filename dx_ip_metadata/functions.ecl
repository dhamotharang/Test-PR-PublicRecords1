import dx_ip_metadata, std;
export functions := module
    export hex4format(string raw_input) := function
        input := TRIM(raw_input, RIGHT);
        zero_string := '0000';
        error_s := 'hex greater than 4 characters '+ raw_input + '=>' + input;
        //if(length(input) > 4, FAIL(error_s));
        s_raw := if(length(input) < 4, zero_string[..4-length(input)]+input, input);
        s := std.str.touppercase(s_raw);
        return s;
    end;
    export hex4char2int(string raw_input) := function
        s := hex4format(raw_input);
        hexval(STRING1 h) := STD.STR.Find('123456789ABCDEF', h, 1);
        hex(STRING1 s, UNSIGNED1 pow) := hexval(s) * POWER(16.0, pow);
        UNSIGNED2 d := hex(s[1],3) + hex(s[2],2) + hex(s[3], 1) + hex(s[4], 0); 
        return d;
    end;
    export int2hex4char(unsigned2 hexdec) := function
        hexchars := '0123456789ABCDEF';
        q1 := hexdec/16;
        q2 := q1/16;
        q3 := q2/16;
        string4 hex :=  hexchars[1+q3%16] + hexchars[1+q2%16] + hexchars[1+q1%16]+ hexchars[1+hexdec%16];
        return hex;
    end;
end;