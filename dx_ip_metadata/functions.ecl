import dx_ip_metadata, std;
export functions := module
    export hex4char2int(string raw_input) := function
        input := TRIM(raw_input, RIGHT);
        zero_string := '0000';
        if(length(input) > 4, FAIL('hex greater than 4 characters'));
        s_raw := if(length(input) > 0, zero_string[..4-length(input)]+input, input);
        s := std.str.touppercase(s_raw);
        output(s);
        hexval(STRING1 h) := STD.STR.Find('123456789ABCDEF', h, 1);
        hex(STRING1 s, UNSIGNED1 pow) := hexval(s) * POWER(16.0, pow);
        UNSIGNED2 d := hex(s[1],3) + hex(s[2],2) + hex(s[3], 1) + hex(s[4], 0); 
        return d;
    end;
end;