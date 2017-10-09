import BIPV2;

export fn_sources(string src) := BIPV2.mod_sources.src2bmap(trim(src[..2],all), trim(src[3..36], all));