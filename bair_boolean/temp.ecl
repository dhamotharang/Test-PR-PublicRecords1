export temp := TABLE(pull(bair_boolean.key_exkeyi), {ExternalKey, collision_count:=doc>>40}) (collision_count>250);
