﻿IMPORT AutoKeyI;

EXPORT Constants := MODULE

    EXPORT MaxIHperLexId := 10000;  // used to pull data from index

    EXPORT  ESP_Method          := 'FCRAInquiryHistoryDeltabase';
    EXPORT  ResultStructure     := 'FCRAInquiryHistoryDeltabaseResponseEx';

    EXPORT ESP_KeyDecryption_Method := 'KeyDecryption';
    EXPORT KeyDecryption_ResultStructure := 'KeyDecryptionResponseEx';

    EXPORT INTEGER 	SOAPWaitTime 	:= 4;
    EXPORT INTEGER 	SOAPCallRetry := 1;

    EXPORT key_public := '-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxYjK33RDBwdUhvKGRUPK\nvda8ywj9WEqJWBYFJUoIkNFmdzH6yQwPorDffjFkKtyTF9rLYaH61iWWyKfDKRzK\n2YrThAm4cAPnyBExSTIxLz5KZ3OWoo7B8K9uZcSDeGl4ZAnUifNIc6GQTEyHwWW5\nvG3+bEJlGXmTjqKFXiaofbdA0NYRYFAh9Zlpq9bVaFdBXE9injpp29Bg4WEQ185N\nqFW4U+DnNf1s5OBNEzcuYzwk7n4eHqrf1kaJSUOPu5fV/kFdttux/E0SPpP1t4xY\nBcnSRyXi1K9Qhhy96L5WU44v5j+n6tLCkn/hj2e36k3bOpcmMxEfsduZB1Fm8m7A\nyQIDAQAB\n-----END PUBLIC KEY-----';
    EXPORT key_private := '-----BEGIN RSA PRIVATE KEY-----\nMIIEpAIBAAKCAQEAxYjK33RDBwdUhvKGRUPKvda8ywj9WEqJWBYFJUoIkNFmdzH6\nyQwPorDffjFkKtyTF9rLYaH61iWWyKfDKRzK2YrThAm4cAPnyBExSTIxLz5KZ3OW\noo7B8K9uZcSDeGl4ZAnUifNIc6GQTEyHwWW5vG3+bEJlGXmTjqKFXiaofbdA0NYR\nYFAh9Zlpq9bVaFdBXE9injpp29Bg4WEQ185NqFW4U+DnNf1s5OBNEzcuYzwk7n4e\nHqrf1kaJSUOPu5fV/kFdttux/E0SPpP1t4xYBcnSRyXi1K9Qhhy96L5WU44v5j+n\n6tLCkn/hj2e36k3bOpcmMxEfsduZB1Fm8m7AyQIDAQABAoIBADj/FXqQc16t0Mf3\nZqLJwtAwC92RxHgbWbHe+LEfwYT3xtcRxskH/+LzoikpWzu61X6GlTSgpl3wDqfr\nMDbGpglLM2jf3SYFGnXx8ASsxOBa2uEqywYwpukp1XLr1vuBg0lqRLdhSUCEF7zM\nQEefcI5cNpNKPR2ypM79OfpGsUtEeT0no/6tb9KtiRJWJAiewxB3Xy/hB5iNQplC\n63QzZ9+lo6UYZVZ10SMCJGpeBRcrqjULPAOIW3wgz9bjFHzGtS5J9u19qMePSFlY\ned3SM+b9acCiBtEVUHFcAw6ZqwE/3RYqJVGS6MIQnl2rbvRlBQojz9hrQYvseb8l\nce1u/VkCgYEA6rIMvt94k6axc+8imdmfecgEOr0IFQjietNqRSakUbf3oBP9CByn\nR8YS5aZr2GzRnrax0X14N9G8HWuVDafEAmXhxcy2Uom6hVHHGNwYA870W2+gWlyt\nPuyOzk9deneWrCRTxUn0j7FY+qiJKlP6NBhJ5h9JOee/WP4sTNdOua8CgYEA13ct\nKV8BU6kvVarz/aAQBfjRx8xmS+v2cGB4UNW0Vu0ES2KuhtIjmatxYbtxbMxbgXha\nmC/2bSYVWMgd9bgpCLstWgbyTfefCJkSPbrTzSUU3YMTY8QrhycuTJh5nH1oMujJ\nC8KS83t24KS58DndJolCQf8bdBU+sd3jl21XYwcCgYBcQMqzyKHb4B1Gxgwiz6FZ\nPF81O5LOueRUhX/zWKIkoRzMJq9Cngi/NMO+07D2rKelLIkvIJO91UqNgflgGb75\ndlTN7I8KWKshtqh9RB6IeLQisPkmK+HJpzDnNdk3x4RJfCoVleF1DjA8rzzjj4j9\nK0L5GvksssTLVXXSapu+bwKBgQCzbCyRXOnP7vzZy8fuFdICBxc5173/zviiz9Kh\nDbRlBm4jEIPhBTBcEOYTynFDdlFk2QIn5RjB/4qbKdm4+qhA+w1jAJHZ1y/5iu4j\ntWYWWKCtbS9CTuMoYrotUnNCmzOf4TU5s8eHNfLiUon7v1OneXlRV8xWuDJDD1Es\nkgLJFQKBgQCH5M7Nz8z+SCiUu6hGu8z0wR2J84sPpv7GVOkvmxO1NO00IOxk74kl\nKm/q3oXKhnMKGjOzBBSdl17aiLPrtcpOiIhp4Tvc+MelPkasIPPrwd8TvvgvIApd\n7byFh6zjfVL7rHGrY7LJ5RrjEWN7FwxG5/mNQB/HmMSvYdPaIw6XoA==\n-----END RSA PRIVATE KEY-----';


END;    //  Constants MODULE
